From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: clone: I'm only doing a max of 256 requests
Date: Thu, 6 Oct 2005 15:41:29 +0200
Message-ID: <81b0412b0510060641g3a3c6e02m6827370dd61b5ea6@mail.gmail.com>
References: <20051005191300.GC17475@hexapodia.org>
	 <Pine.LNX.4.64.0510051541300.31407@g5.osdl.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_20415_29338163.1128606089102"
Cc: Andy Isaacson <adi@hexapodia.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Oct 06 15:45:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENW08-00089O-5T
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 15:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbVJFNlc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 09:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbVJFNlc
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 09:41:32 -0400
Received: from nproxy.gmail.com ([64.233.182.204]:46617 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750915AbVJFNlb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2005 09:41:31 -0400
Received: by nproxy.gmail.com with SMTP id n15so171515nfc
        for <git@vger.kernel.org>; Thu, 06 Oct 2005 06:41:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=JrsVfGbQ3D5g65y8c1BtwNhPg9tTcnGLpWMxCubAKMABlMQpIGm2u4CCoPR4gRPwNeSOuB44oygkkBXdJEtToRBlvjlKYsJCeHL++cj+FSibwecm/N9kUSzV173fCmkXqb/1v/4GzKmUvTykGXbeBHNn6r9eHNz/0u1p0sV/bhA=
Received: by 10.48.142.15 with SMTP id p15mr114296nfd;
        Thu, 06 Oct 2005 06:41:29 -0700 (PDT)
Received: by 10.48.247.10 with HTTP; Thu, 6 Oct 2005 06:41:29 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0510051541300.31407@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9769>

------=_Part_20415_29338163.1128606089102
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 10/6/05, Linus Torvalds <torvalds@osdl.org> wrote:
>
>         git ls-remote http://www.linux-mips.org/pub/scm/linux.git | wc -l
>

Which, btw, failed for me, when I tried to run it home (which has no
.git in it yet).
Do the scripts git-ls-remote.sh and git-parse-remote.sh really need .git/..=
.?

Just in case they don't, the attached patch removes the die("Not a git arch=
ive")

------=_Part_20415_29338163.1128606089102
Content-Type: application/xxxxx; name=git-ls-remote.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="git-ls-remote.patch"

The scripts work perfectly without a repository.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

diff --git a/git-ls-remote.sh b/git-ls-remote.sh
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 #
-. git-sh-setup || die "Not a git archive"
+. git-sh-setup
 
 usage () {
     echo >&2 "usage: $0 [--heads] [--tags] <repository> <refs>..."
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-. git-sh-setup || die "Not a git archive"
+. git-sh-setup
 
 get_data_source () {
 	case "$1" in

------=_Part_20415_29338163.1128606089102--
