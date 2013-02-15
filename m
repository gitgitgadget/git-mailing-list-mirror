From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 3/3] contrib/subtree: update documentation
Date: Fri, 15 Feb 2013 22:54:04 +0000
Message-ID: <CALeLG_nsiAoPbwTU537CcWkBEfbb3A+wsb-yTSA-4kbNkjfWFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Adam Tkac <atkac@redhat.com>,
	"David A. Greene" <greened@obbligato.org>,
	"Jesper L. Nielsen" <lyager@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Techlive Zheng <techlivezheng@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 15 23:54:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6UAq-0004TF-KK
	for gcvg-git-2@plane.gmane.org; Fri, 15 Feb 2013 23:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595Ab3BOWyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2013 17:54:07 -0500
Received: from mail-ob0-f182.google.com ([209.85.214.182]:54645 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab3BOWyG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2013 17:54:06 -0500
Received: by mail-ob0-f182.google.com with SMTP id va7so4137273obc.13
        for <git@vger.kernel.org>; Fri, 15 Feb 2013 14:54:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=JAAspxW1wwuPieRsOAtzXop42fCE9miMFrvtyKK3RU8=;
        b=nhM4/AlISPLlQfNmNCDYnDNW5fsqJ1/2MXwQEkXTbzN9XteK/GsxDPr+x3RGSzHlyw
         j4kRGCZ9DZr6BJNqtyTWwKL5z2EEBSNiacA/e9iaPTJ5btK7tkFr33HpZiTVU4wt3Tj1
         VN+E3R73QVFor87Hq64/R6yA72+evofk88uAu77k+2wpwP82IoRWzNk3jaW7sgrkggLv
         T+DVpKMlbH2YWkcPrl9cgCSHYqPU0OGamH68DMy2cJeBPCVw2asL56zPeTPX3tN3qY71
         xvCL6HCf5TkIHUggPHc6mfjmIX03vyBXoyw35oAxklrG3Ueg6Wra7Wt1wNANX64R8EWS
         uUQw==
X-Received: by 10.182.74.5 with SMTP id p5mr2898943obv.74.1360968845140; Fri,
 15 Feb 2013 14:54:05 -0800 (PST)
Received: by 10.76.143.67 with HTTP; Fri, 15 Feb 2013 14:54:04 -0800 (PST)
X-Originating-IP: [2.102.85.14]
X-Gm-Message-State: ALoCoQmkG+9cNfLmSSkNCnH+hrJNcInnR62kwSbj5fPN1cpOXV0nw1LoRfb0kINsnsHDkU0NvPVp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216361>

Indicate that repository and refspec are now optional on push and pull.

Add notes to add, push and pull about storing values in .gitsubtree
and their use as default values.

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.txt | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 7ba853e..2ad9278 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -11,8 +11,8 @@ SYNOPSIS
 [verse]
 'git subtree' add   -P <prefix> <refspec>
 'git subtree' add   -P <prefix> <repository> <refspec>
-'git subtree' pull  -P <prefix> <repository> <refspec...>
-'git subtree' push  -P <prefix> <repository> <refspec...>
+'git subtree' pull  -P [<prefix> <repository> <refspec...>]
+'git subtree' push  -P [<prefix> <repository> <refspec...>]
 'git subtree' merge -P <prefix> <commit>
 'git subtree' split -P <prefix> [OPTIONS] [<commit>]

@@ -72,7 +72,9 @@ add::
 	A new commit is created	automatically, joining the imported
 	project's history with your own.  With '--squash', imports
 	only a single commit from the subproject, rather than its
-	entire history.
+	entire history. Details of the <prefix> are added to the
+	.gitsubtree file, where they will be used as defaults for
+	'push' and 'pull'.

 merge::
 	Merge recent changes up to <commit> into the <prefix>
@@ -91,13 +93,16 @@ merge::
 pull::
 	Exactly like 'merge', but parallels 'git pull' in that
 	it fetches the given commit from the specified remote
-	repository.
+	repository. Default values for <repository> and <refspec>
+	are taken from the .gitsubtree file.
 	
 push::
 	Does a 'split' (see below) using the <prefix> supplied
 	and then does a 'git push' to push the result to the
 	repository and refspec. This can be used to push your
 	subtree to different branches of the remote repository.
+	Default values for <repository> and <refspec> are taken
+	from the .gitsubtree file.

 split::
 	Extract a new, synthetic project history from the
-- 
1.8.1.3.605.g02339dd
