From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: Re: Git Gui does not want to work on chunk level
Date: Mon, 15 Sep 2008 18:21:17 +0400
Message-ID: <c6c947f60809150721m1ec11f10xc68ce39559398659@mail.gmail.com>
References: <c6c947f60808270216k2feb8f9ar765cdee1fc3910ee@mail.gmail.com>
	 <c6c947f60809031223i575ca3fdya357588610bb72e8@mail.gmail.com>
	 <20080903230814.GJ28315@spearce.org>
	 <c6c947f60809040220t589e65bfkbd693fd335792069@mail.gmail.com>
	 <20080904143723.GB23708@spearce.org>
	 <c6c947f60809040754g34e60633lcd5f872ac5e80158@mail.gmail.com>
	 <20080905045327.GA31166@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git-users@googlegroups.com, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 15 16:24:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfEyB-0002Kr-Is
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 16:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbYIOOVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 10:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753392AbYIOOVS
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 10:21:18 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:36929 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960AbYIOOVS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 10:21:18 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2065085wfd.4
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 07:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4SKS0Qo3FBwbZiht523szDiYkZtjeWCytmUFRfkL3tM=;
        b=pkhE4hLzVNPd2UBMjtPIgqqj5P/M9opGcknqU2vuDE7GDSxeUhOZ8Qzb0hTrV0oZOb
         uUTSza0etKOrakjsdaWCFkptjzbhWBPVKv7cdh0hx8nd0I3do2Y7Eog7ElcU/TEsRw/b
         65bwE+wfgy3lWEuy0cK9H58H3ogH7LokGCuys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=iaOa0d2Nr5u5Uha6pM/yyaVKhTOwIMFG19bpn/tAHjHNStqFUpdEPG0FuUkjZC0+r9
         6fnzFBvr3mHEPuMyQFOEkiMD6HN0KLwdT/xmWknDl4zCkn21zdWahvz/MFTL+th6s079
         B+Eag0Cze8vPParxkxiasK2JrTnTyM1aGTeW0=
Received: by 10.141.106.14 with SMTP id i14mr4809095rvm.178.1221488477392;
        Mon, 15 Sep 2008 07:21:17 -0700 (PDT)
Received: by 10.141.48.15 with HTTP; Mon, 15 Sep 2008 07:21:17 -0700 (PDT)
In-Reply-To: <20080905045327.GA31166@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95911>

Hi, list!

On Fri, Sep 5, 2008 at 8:53 AM, Shawn O. Pearce <spearce@spearce.org> wrote:

> git-gui: Fix diff parsing for lines starting with "--" or "++"

Somewhat related bug, but reproduceable event without "--". If I set
diff context to none in git gui (by repeatedly clicking "show less
context") I'm sometimes not able to stage hunk or line.

git version 1.6.0.GIT
git-gui version 0.11.GITGUI

Steps to reproduce:

agladysh@agladysh-desktop:~$ mkdir test
agladysh@agladysh-desktop:~$ cd test
agladysh@agladysh-desktop:~/test$ git init
Initialized empty Git repository in /home/agladysh/test/.git/
agladysh@agladysh-desktop:~/test$ cat >file.ext
-- 1
-- 2
-- 3
-- 4
-- 5
agladysh@agladysh-desktop:~/test$ git add file.ext
agladysh@agladysh-desktop:~/test$ git commit -m "one"
Created initial commit aa4da16: one
 1 files changed, 5 insertions(+), 0 deletions(-)
 create mode 100644 file.ext
agladysh@agladysh-desktop:~/test$ cat >file.ext
-- 1
-- 2
-- 33
-- 4
-- 5
agladysh@agladysh-desktop:~/test$ git gui

Reduce context to none, then do stage hunk. It fails with message:

error: patch failed: file.ext:3
error: file.ext: patch does not apply
OK

Dump (by your debuging dumper patch from the same tread):

diff --git a/file.ext b/file.ext
--- a/file.ext
+++ b/file.ext
@@ -1,5 +1,5 @@
 -- 1
 -- 2
--- 3
+-- 33
 -- 4
 -- 5

Do stage line. It fails with message:

fatal: corrupt patch at line 5

Dump:

diff --git a/file.ext b/file.ext
--- a/file.ext
+++ b/file.ext
@@ -3 +3 @@
--- 3
+-- 33

HTH,
Alexander.
