From: Alecs King <alecsk@gmail.com>
Subject: [PATCH] #!/bin/sh --> #!/usr/bin/env bash
Date: Fri, 22 Apr 2005 03:42:55 +0800
Message-ID: <20050421194255.GA8479@alc.bsd.st>
References: <426734DE.3040606@timesys.com> <426736AF.7000900@timesys.com> <4267387A.6040602@timesys.com> <20050421102326.GA22541@xdt04.mpe-garching.mpg.de> <20050421143102.GA830@alc.bsd.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Apr 21 21:32:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOhPD-0008Nm-Ce
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 21:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVDUTgY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 15:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVDUTgY
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 15:36:24 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:60354 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261808AbVDUTfx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 15:35:53 -0400
Received: by rproxy.gmail.com with SMTP id a41so380037rng
        for <git@vger.kernel.org>; Thu, 21 Apr 2005 12:35:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=JN2I3klbB+L0z8n+w0FeVZq1msgjD9hiqL76yR8SypyigMzovhKxHYlHKvOWnlBrmC9mROpV+bRBy3y5McLAyT7byVi8cs3XO4BjiN+rrx5x5YoWXptDD7U/wdRTs98LCzkedDZiVvJwFrorTDHxsw93ymw37qqQaC+V3/nPepg=
Received: by 10.38.67.8 with SMTP id p8mr2700563rna;
        Thu, 21 Apr 2005 12:35:52 -0700 (PDT)
Received: from localhost ([210.77.3.122])
        by mx.gmail.com with ESMTP id 79sm173772rna.2005.04.21.12.35.50;
        Thu, 21 Apr 2005 12:35:52 -0700 (PDT)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050421143102.GA830@alc.bsd.st>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 21, 2005 at 10:31:02PM +0800, Alecs King wrote:
> On Thu, Apr 21, 2005 at 12:23:26PM +0200, Klaus Robert Suetterlin wrote:
> > Hi,
> > 
> > I supply a patch that dehardcodes the path to bash (which is not /bin
> > on all computers) and adds sys/limits.h to provide ULONG_MAX.
> 
> Hi, i did a similar patch a while back ago. As for ULONG_MAX, not every
> sytem has <sys/limits.h>, i think <limits.h> is the rite place to go.
> 
> The patch below tested on both debian and fbsd.
>  
> [snip]

And as for bash, only gitdiff-do and gitlog.sh 'explicitly' use bash
instead of /bin/sh.  On most Linux distros, /bin/sh is just a symbolic
link to bash.  But not on some others.  I found gitlsobj.sh could not
work using a plain /bin/sh on fbsd.  To make life easier, i think it
might be better if we all explicitly use bash for all shell scripts.

patch below assumes the patch above has been applied.


commit 341cd1241815178d567ce612c97c2bb5a663021a
tree abb16c39fe8354383b632f7fa9dd4611ff66e1d1
parent 2deea74db72fb57a8b80e7945f23814112b22723
author Alecs King <alecsk ! gmail d@t com> 1114107613 +0800
committer Alecs King <alecsk ! gmail d@t com> 1114107613 +0800

Explicitly use bash
#!/bin/sh ==> #!/usr/bin/env bash

Index: gitXlntree.sh
===================================================================
--- 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/gitXlntree.sh  (mode:100755 sha1:c474913d09906739d8175f1b430720a3ac67e798)
+++ abb16c39fe8354383b632f7fa9dd4611ff66e1d1/gitXlntree.sh  (mode:100755 sha1:adc01eeb56f394a6168ae1f6f1fe4c40e1c2aecc)
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # Provide an independent view to the objects database.
 # Copyright (c) Petr Baudis, 2005
Index: gitXnormid.sh
===================================================================
--- 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/gitXnormid.sh  (mode:100755 sha1:c0d53afabe8662ebfc3c697faf08b0a2b43c93f7)
+++ abb16c39fe8354383b632f7fa9dd4611ff66e1d1/gitXnormid.sh  (mode:100755 sha1:9b311aca57bd8b7012f45d730c6fd26d5fb5d2b2)
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # Internal: Normalize the given ID to a tree ID.
 # Copyright (c) Petr Baudis, 2005
Index: gitadd.sh
===================================================================
--- 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/gitadd.sh  (mode:100755 sha1:3f5e9a2d6b452d596cd853f1585113bdb356a2e3)
+++ abb16c39fe8354383b632f7fa9dd4611ff66e1d1/gitadd.sh  (mode:100755 sha1:6feb7372e95be4546af17e0c6b55d10c9a1c441d)
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # Add new file to a GIT repository.
 # Copyright (c) Petr Baudis, 2005
Index: gitaddremote.sh
===================================================================
--- 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/gitaddremote.sh  (mode:100755 sha1:a117b9e8d14b977143caa48c26fc51794e8b7135)
+++ abb16c39fe8354383b632f7fa9dd4611ff66e1d1/gitaddremote.sh  (mode:100755 sha1:bccaa9068063b07d13012477861c6706b7cd40a6)
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # Add new "remote" to the GIT repository.
 # Copyright (c) Petr Baudis, 2005
Index: gitapply.sh
===================================================================
--- 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/gitapply.sh  (mode:100755 sha1:7703809dc0743c6e4c1fa5b7d922a4efc16b4276)
+++ abb16c39fe8354383b632f7fa9dd4611ff66e1d1/gitapply.sh  (mode:100755 sha1:794ea5ed6acdd34e34742a17cbd784dcbf738289)
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # Apply a diff generated by git diff.
 # Copyright (c) Petr Baudis, 2005
Index: gitcancel.sh
===================================================================
--- 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/gitcancel.sh  (mode:100755 sha1:74b4083d67eda87d88a6f92c6c66877bba8bda8a)
+++ abb16c39fe8354383b632f7fa9dd4611ff66e1d1/gitcancel.sh  (mode:100755 sha1:c320ee98e2ed0b13a68de3b2ec4e4a8451b5189a)
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # Cancels current edits in the working tree.
 # Copyright (c) Petr Baudis, 2005
Index: gitcommit.sh
===================================================================
--- 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/gitcommit.sh  (mode:100755 sha1:a13bef2c84492ed75679d7d52bb710df35544f8a)
+++ abb16c39fe8354383b632f7fa9dd4611ff66e1d1/gitcommit.sh  (mode:100755 sha1:0207f402cc5107de2a4685f6fcade081c41d91e9)
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # Commit into a GIT repository.
 # Copyright (c) Petr Baudis, 2005
Index: gitdiff.sh
===================================================================
--- 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/gitdiff.sh  (mode:100755 sha1:8e14a868f513f4ec524a2c8974c8d202c6824038)
+++ abb16c39fe8354383b632f7fa9dd4611ff66e1d1/gitdiff.sh  (mode:100755 sha1:e27915d4172717ddd4d01269877312b08ed2acc4)
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # Make a diff between two GIT trees.
 # Copyright (c) Petr Baudis, 2005
Index: gitexport.sh
===================================================================
--- 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/gitexport.sh  (mode:100755 sha1:5b94424beca55ffe6b5535e4975e6e63c1bae672)
+++ abb16c39fe8354383b632f7fa9dd4611ff66e1d1/gitexport.sh  (mode:100755 sha1:428cd9d845598e320556729b6098505132a4e7c4)
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # Exports a particular revision from a GIT repository.
 # Copyright (c) Johannes E. Schindelin, 2005
Index: gitfork.sh
===================================================================
--- 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/gitfork.sh  (mode:100755 sha1:b827c3037ac4f3cdfb6708bf8edb60944f59318a)
+++ abb16c39fe8354383b632f7fa9dd4611ff66e1d1/gitfork.sh  (mode:100755 sha1:ce26f985ebb48b6a3127ac8afd427ba30ba5668a)
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # Create a branch sharing the objects database.
 # Copyright (c) Petr Baudis, 2005
Index: gitinit.sh
===================================================================
--- 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/gitinit.sh  (mode:100755 sha1:9905166859827893e326b01bdc3970ff6d51064d)
+++ abb16c39fe8354383b632f7fa9dd4611ff66e1d1/gitinit.sh  (mode:100755 sha1:bc00e9ee709aabeb4764b77ac4e5a19212fa5857)
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # Initialize a GIT repository.
 # Copyright (c) Petr Baudis, 2005
Index: gitls.sh
===================================================================
--- 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/gitls.sh  (mode:100755 sha1:c8d2220eae66addd49493cdb32af21b6c0217b23)
+++ abb16c39fe8354383b632f7fa9dd4611ff66e1d1/gitls.sh  (mode:100755 sha1:a05883b09512bd1d1fe31e1c6d43f01a395c58a1)
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # List contents of a particular tree in a GIT repository.
 # Copyright (c) Petr Baudis, 2005
Index: gitlsobj.sh
===================================================================
--- 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/gitlsobj.sh  (mode:100755 sha1:423a1bc7476bad7bf40f1b3ddb03d83fdcf1f9cd)
+++ abb16c39fe8354383b632f7fa9dd4611ff66e1d1/gitlsobj.sh  (mode:100755 sha1:3f4426eeac7cc5ad51a46632319814fbf62b2cc3)
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # List objects of the GIT repository.
 # Copyright (c) Randy Dunlap, 2005
Index: gitlsremote.sh
===================================================================
--- 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/gitlsremote.sh  (mode:100755 sha1:2212be93aaa8a371e83cafb69fa21a7a1b24ed13)
+++ abb16c39fe8354383b632f7fa9dd4611ff66e1d1/gitlsremote.sh  (mode:100755 sha1:29657d7a899ffb425a36ec04bf1c62aa1ecc14d7)
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # Lists remote GIT repositories
 # Copyright (c) Steven Cole 2005
Index: gitmerge-file.sh
===================================================================
--- 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/gitmerge-file.sh  (mode:100755 sha1:820de487babb76ce419b6823c8fe4c58608d0c8c)
+++ abb16c39fe8354383b632f7fa9dd4611ff66e1d1/gitmerge-file.sh  (mode:100755 sha1:237186eaefc4a503c386e4a0e7c28818e6704db7)
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # Copyright (c) Linus Torvalds, 2005
 #
Index: gitmerge.sh
===================================================================
--- 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/gitmerge.sh  (mode:100755 sha1:bc68f6cda84cbf1165d71b17d6207b3c46a8cad4)
+++ abb16c39fe8354383b632f7fa9dd4611ff66e1d1/gitmerge.sh  (mode:100755 sha1:92e552700a40c5e1f7339c9b1f261cb39206a3c3)
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # Merge a branch to the current tree.
 # Copyright (c) Petr Baudis, 2005
Index: gitpatch.sh
===================================================================
--- 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/gitpatch.sh  (mode:100755 sha1:580e3e6b0c23625abd2288be35ee33a787a1ba3c)
+++ abb16c39fe8354383b632f7fa9dd4611ff66e1d1/gitpatch.sh  (mode:100755 sha1:fd00c88133c874ac71a90a045a313363f9f22350)
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # Make a patch from a given commit.
 # Copyright (c) Petr Baudis, 2005
Index: gitpull.sh
===================================================================
--- 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/gitpull.sh  (mode:100755 sha1:0cafc0270ea91aaf099f398b7e5cd360be9ea086)
+++ abb16c39fe8354383b632f7fa9dd4611ff66e1d1/gitpull.sh  (mode:100755 sha1:7f847f39e0b2aa150fe195d8d4f6f0d62487ae72)
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # Pulls changes from "remote" to the local GIT repository.
 # Copyright (c) Petr Baudis, 2005
Index: gitrm.sh
===================================================================
--- 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/gitrm.sh  (mode:100755 sha1:3fa31f9a1ae843dcb184b8371ff60f626e8820b3)
+++ abb16c39fe8354383b632f7fa9dd4611ff66e1d1/gitrm.sh  (mode:100755 sha1:e014b979ea7b8f7ae69eabc7dd146c8a7f286d19)
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # Remove a file from a GIT repository.
 # Copyright (c) Petr Baudis, 2005
Index: gitseek.sh
===================================================================
--- 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/gitseek.sh  (mode:100755 sha1:b80969a4ba040202827ea7532235abab15ca9392)
+++ abb16c39fe8354383b632f7fa9dd4611ff66e1d1/gitseek.sh  (mode:100755 sha1:035b78a93307da8f67f7447ed3a182a6d17d2c50)
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # Seek the working tree to a given commit.
 # Copyright (c) Petr Baudis, 2005
Index: gitstatus.sh
===================================================================
--- 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/gitstatus.sh  (mode:100755 sha1:7d5209ea838106eb2ab5bde2704997508a22a4e8)
+++ abb16c39fe8354383b632f7fa9dd4611ff66e1d1/gitstatus.sh  (mode:100755 sha1:9cfb2ce947082002cff3e5497ca2a994c4bbb101)
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # Show status of entries in your working tree.
 # Copyright (c) Petr Baudis, 2005
Index: gittag.sh
===================================================================
--- 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/gittag.sh  (mode:100755 sha1:9e1e200deda54b2401d6d685f0d5305cfbfa38ca)
+++ abb16c39fe8354383b632f7fa9dd4611ff66e1d1/gittag.sh  (mode:100755 sha1:19c7f3ecffa55f117c27c9a1d8de67f65805f1c7)
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # Mark certain commit by a tag.
 # Copyright (c) Petr Baudis, 2005
Index: gittrack.sh
===================================================================
--- 0c92ac3af53457b6b9651cf82d98ce3a7b166dcd/gittrack.sh  (mode:100755 sha1:7509d4adb2b2c50cd2acdf9126fc57cff79e6009)
+++ abb16c39fe8354383b632f7fa9dd4611ff66e1d1/gittrack.sh  (mode:100755 sha1:bdf33313f4ad0c4f7b6b235fbc68fc85f226a33a)
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # Makes your working tree track the given branch.
 # Copyright (c) Petr Baudis, 2005

-- 
Alecs King
