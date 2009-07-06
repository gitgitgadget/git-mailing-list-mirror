From: Eric Raible <raible@gmail.com>
Subject: Re: Does CVS has a easy way to compare file with its previous 
	version?
Date: Mon, 6 Jul 2009 16:39:43 -0700
Message-ID: <279b37b20907061639o6d6c72e7qf7bbc2459c7fc77e@mail.gmail.com>
References: <1e56aa11-735a-47f7-a273-5b6bf611f528@n11g2000yqb.googlegroups.com>
	 <m3hbxxx5jk.fsf@localhost.localdomain> <4A4A9FA5.7000009@gnu.org>
	 <alpine.LFD.2.01.0906301813480.3605@localhost.localdomain>
	 <loom.20090702T174843-784@post.gmane.org> <4A4DA7A5.7020303@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jul 07 01:39:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNxmr-0005X0-Rb
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 01:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbZGFXjm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jul 2009 19:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752781AbZGFXjl
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 19:39:41 -0400
Received: from mail-vw0-f202.google.com ([209.85.212.202]:53589 "EHLO
	mail-vw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbZGFXjk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jul 2009 19:39:40 -0400
Received: by vwj40 with SMTP id 40so3411051vwj.33
        for <git@vger.kernel.org>; Mon, 06 Jul 2009 16:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ENLDcOqqc40qaj0JUs33LIYHbGVZbxXZNksp0XCFEgY=;
        b=QmFRUL18GSvVUW/1cDogHkN+JhYgznUY81IXkAn140aUiO3WomJD532rBKMjfb40dE
         IYuaLQuH1o8NDWANWIzwe0k4WANK5t0suP3JtVSTh8xxWkml69l25WBM1c8/zEsE+QLk
         IfgaStrQvCvehiLBYfDh4zSr9bFW3Vr1yNt4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ljq1D0f66Dljl3UMjt51XSj344msskEBEwmZOA+3+RRctjJbSyo3qjrFlsCa9HJfTL
         76e4BrUKBu4PultzZwyYQQKF9W9iS9GR8YBl1Ly1n9gGT0Gf1aA7Ry7JKP+8vuU/nrkr
         0JCwXuP60GDIRPKhzEPflvPn+qG9s+8Myl0Yc=
Received: by 10.220.72.194 with SMTP id n2mr10755377vcj.36.1246923583830; Mon, 
	06 Jul 2009 16:39:43 -0700 (PDT)
In-Reply-To: <4A4DA7A5.7020303@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122809>

On Thu, Jul 2, 2009 at 11:39 PM, Paolo Bonzini<bonzini@gnu.org> wrote:
> On 07/02/2009 08:04 PM, Eric Raible wrote:
>>
>> Isn't the first one incorrect because<file> =A0needs to be inside th=
e
>> backticks?
>> git diff `git log -2 --pretty=3Dformat:%h<file>` --<file>
>>
>> And isn't the replacement incorrect also (the diffs are backwards)?
>> git log --no-merges -p -R -1<file>
>
> Yes and no.
>
> Paolo
>

Are you sure that you didn't mean yes and yes?

As the transcript shows the git-diff form produces a
backwards diff.  Thus to get the same output git-log
needs the -R:

$ git init
$ perl -e 'for (0..10) { print "$_\n" }' > file
$ git add file
$ git commit -minitial
[master (root-commit) 2d451ec] initial
 1 files changed, 11 insertions(+), 0 deletions(-)
 create mode 100644 file
$ sed -e 's/4/four/' < file > file1
$ mv file1 file
$ git commit -a -m'updated'
[master d49613a] updated
 1 files changed, 1 insertions(+), 1 deletions(-)
$ git diff `git log -2 --pretty=3Dformat:%h file` -- file
diff --git a/file b/file
index b29b605..b033488 100644
--- a/file
+++ b/file
@@ -2,7 +2,7 @@
 1
 2
 3
-four
+4
 5
 6
 7

$ git log --no-merges -p -1 file
commit d49613a1d16c9ece551f9a52f56f16a3dae8bebc
Author: Eric Raible <raible@nextest.com>
Date:   Mon Jul 6 16:25:29 2009 -0700

    updated

diff --git a/file b/file
index b033488..b29b605 100644
--- a/file
+++ b/file
@@ -2,7 +2,7 @@
 1
 2
 3
-4
+four
 5
 6
 7

$ git log --no-merges -p -R -1 file
commit d49613a1d16c9ece551f9a52f56f16a3dae8bebc
Author: Eric Raible <raible@nextest.com>
Date:   Mon Jul 6 16:25:29 2009 -0700

    updated

diff --git b/file a/file
index b29b605..b033488 100644
--- b/file
+++ a/file
@@ -2,7 +2,7 @@
 1
 2
 3
-four
+4
 5
 6
 7
