From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git status and empty directories
Date: Thu, 18 May 2006 11:12:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605181112040.10823@g5.osdl.org>
References: <E1Fgmkh-0000ur-Hn@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 18 20:13:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fgmzc-0005o3-6h
	for gcvg-git@gmane.org; Thu, 18 May 2006 20:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWERSM5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 14:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWERSM5
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 14:12:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35776 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932117AbWERSM4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 14:12:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4IICjtH023893
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 18 May 2006 11:12:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4IICh9H028589;
	Thu, 18 May 2006 11:12:44 -0700
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1Fgmkh-0000ur-Hn@moooo.ath.cx>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20295>



On Thu, 18 May 2006, Matthias Lederhofer wrote:
>
> - hide empty directories if the user does not ask explicitly for them
>   with a command line option

Like this?

Makes sense to me, although I didn't add the option to disable it.

		Linus

---
diff --git a/git-commit.sh b/git-commit.sh
index 6ef1a9d..ed00b5c 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -136,11 +136,11 @@ #'
 
 	if test -f "$GIT_DIR/info/exclude"
 	then
-	    git-ls-files -z --others --directory \
+	    git-ls-files -z --others --directory --no-empty-directory \
 		--exclude-from="$GIT_DIR/info/exclude" \
 		--exclude-per-directory=.gitignore
 	else
-	    git-ls-files -z --others --directory \
+	    git-ls-files -z --others --directory --no-empty-directory \
 		--exclude-per-directory=.gitignore
 	fi |
 	perl -e '$/ = "\0";
