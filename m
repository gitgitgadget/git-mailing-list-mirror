From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Document "commit --only".
Date: Mon, 07 May 2007 12:37:50 +0200
Message-ID: <vpqirb4q5q9.fsf@bauges.imag.fr>
References: <11784859173386-git-send-email-Matthieu.Moy@imag.fr>
	<11784859173725-git-send-email-Matthieu.Moy@imag.fr>
	<11784859182473-git-send-email-Matthieu.Moy@imag.fr>
	<11784859184184-git-send-email-Matthieu.Moy@imag.fr>
	<alpine.LFD.0.99.0705061908430.24220@xanadu.home>
	<vpq8xc1ujzq.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 12:38:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl0cF-0000q8-Mg
	for gcvg-git@gmane.org; Mon, 07 May 2007 12:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbXEGKiG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 06:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbXEGKiG
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 06:38:06 -0400
Received: from imag.imag.fr ([129.88.30.1]:51493 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932192AbXEGKiF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 06:38:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l47Aboat005829
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 7 May 2007 12:37:50 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Hl0bG-00081A-A7; Mon, 07 May 2007 12:37:50 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Hl0bG-0004bT-7O; Mon, 07 May 2007 12:37:50 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <vpq8xc1ujzq.fsf@bauges.imag.fr> (Matthieu Moy's message of "Mon\, 07 May 2007 10\:16\:09 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 07 May 2007 12:37:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46440>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Nicolas Pitre <nico@cam.org> writes:
>
>> This looks really confusing.  This is the default _only_ if files are 
>> specified on the command line.
>>
>> IMHO I'd rather remove the option from the synopsis and flag it as 
>> scheduled for removal in the source instead.
>
> I'm fine with this proposal. Next email will be a patch to do that
> (I'm not sure about the standard way to deprecate things in git, so I
> just added a warning when -o is used, feel free to improve it).

I messed up threading, sorry. Here's the patch again, but it's already
in a separate thead.



[PATCH] Remove mention of -o|--only in SYNOPSYS of git-commit.

This flag is actually useless since it is the default behavior, and
was mentionned in the SYNOPSYS, but not actually documented. Better
just deprecate it.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-commit.txt |    4 ++--
 git-commit.sh                |    4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 53a7bb0..4324ca0 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git-commit' [-a | --interactive] [-s] [-v]
 	   [(-c | -C) <commit> | -F <file> | -m <msg> | --amend]
 	   [--no-verify] [-e] [--author <author>]
-	   [--] [[-i | -o ]<file>...]
+	   [--] [[-i] <files>...]
 
 DESCRIPTION
 -----------
@@ -91,7 +91,7 @@ OPTIONS
 
 	Used to amend the tip of the current branch. Prepare the tree
 	object you would want to replace the latest commit as usual
-	(this includes the usual -i/-o and explicit paths), and the
+	(this includes the usual -i and explicit paths), and the
 	commit log editor is seeded with the commit message from the
 	tip of the current branch. The commit you create replaces the
 	current tip -- if it was a merge, it will have the parents of
diff --git a/git-commit.sh b/git-commit.sh
index f28fc24..3913097 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Linus Torvalds
 # Copyright (c) 2006 Junio C Hamano
 
-USAGE='[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>] [[-i | -o] <path>...]'
+USAGE='[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>] [[-i] <path>...]'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 require_work_tree
@@ -138,6 +138,8 @@ do
 		shift
 		;;
 	-o|--o|--on|--onl|--only)
+                echo >&2 "Warning: --only option is now the default."
+                echo >&2 "It will be removed in a future version of git."
 		only=t
 		shift
 		;;
-- 
1.5.1.1
