Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3C601F453
	for <e@80x24.org>; Wed, 30 Jan 2019 18:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733309AbfA3Sux (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 13:50:53 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36471 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfA3Suw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 13:50:52 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so1034212itj.1
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 10:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=09V3tLMG9Olj7nWgZ+0MTwr7du8NqZ85xDRnODkRDww=;
        b=fkIydU0WG6kbA+2gUMaTuUeIVcJmuHmkU8pvWhxcmiGlHqH797ET0G/eEWyuMMK3D8
         CvbrQwu8tYg4FRRYjE2LZjJOBVDJHfFczH+vp4epz33kdCfu9DAavaS/fPM7u9/fL9Y7
         5MY3udmwldEx5K+RScOsB0dZFNf9nhucrq47O0naYPh1Dyd/7K3xpNhn8Ik0aszt5P7W
         9UczJBk0O/d1iRCFPu0feRnu+1MUSDXnLMVrRLJb7BO0aJx4d+aNyXpvXrxFx4SS1cOd
         EpIEUwvtIp65SdlwQitQffVXqXyI7I+rkvusX9/PWEgGQ7KcfVb83WrSAayOv8OcobiZ
         h9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=09V3tLMG9Olj7nWgZ+0MTwr7du8NqZ85xDRnODkRDww=;
        b=noHdGArAyeaFzOCrPQtP4p8q0GXzrThxC4LSS3psDgOkfTLVCmY9BJlYNvgUGk2tZn
         JcxJkpsuC/INiRq4MnDvWwMVczv9PlZm5VDX/4sSgd0VXn5lZVsrjx2ufn6M/k4/tGnY
         k5bNJl593xzqs7J166N6bWVlE6v1xBeCy5HBJnzs8hqP9HH3gDRO2rOAeOWjkzdRfCx/
         5WmZ1hmb0haSJNpnGYq6dzkZKInM4EVKZFI/cVr1vGmNbnqKSOQmKGigCxgGLXt25Hu7
         wcV3HQ06ukym7o/Ww0Coae0MVfS8sxlLRxx2JtvozoashQ7p02ZoX6KCV0Lcq7iuPlSJ
         gU0Q==
X-Gm-Message-State: AJcUukeVsX6NocnCB/ja9TWxv312/CI5AIStWNH02EdziVjvHEEJMWE5
        qXbIn0ByeinlDNfL5XVrrWg0vre9Vcw=
X-Google-Smtp-Source: AHgI3IZwzww8CbsLN9z+CKiAujwb6/Bs9F0pXdsTRleS+0sH/Nc6oyKlLVctE4YJKfslTIPjiHTkcg==
X-Received: by 2002:a05:660c:88b:: with SMTP id o11mr15550253itk.9.1548874251195;
        Wed, 30 Jan 2019 10:50:51 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
        by smtp.gmail.com with ESMTPSA id u25sm980060iob.23.2019.01.30.10.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 10:50:50 -0800 (PST)
From:   Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To:     git@vger.kernel.org
Cc:     Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH] subtree: Teach push the --force option
Date:   Wed, 30 Jan 2019 12:50:47 -0600
Message-Id: <20190130185047.15401-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Force pushing to subtree remotes can occasionally be a useful workflow,
particularly when the remote uses a workflow like GitHub pull requests.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 contrib/subtree/git-subtree.sh  | 14 +++++++++++++-
 contrib/subtree/git-subtree.txt |  9 +++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 147201dc6c..39792198b4 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -29,6 +29,8 @@ onto=         try connecting new tree to an existing one
 rejoin        merge the new branch back into HEAD
  options for 'add', 'merge', and 'pull'
 squash        merge subtree changes as a single commit
+ options for 'push'
+f,force       force push
 "
 eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"
 
@@ -48,6 +50,7 @@ annotate=
 squash=
 message=
 prefix=
+force=
 
 debug () {
 	if test -n "$debug"
@@ -137,6 +140,9 @@ do
 	--no-squash)
 		squash=
 		;;
+	-f)
+		force=1
+		;;
 	--)
 		break
 		;;
@@ -892,7 +898,13 @@ cmd_push () {
 		refspec=$2
 		echo "git push using: " "$repository" "$refspec"
 		localrev=$(git subtree split --prefix="$prefix") || die
-		git push "$repository" "$localrev":"refs/heads/$refspec"
+		if test -n "$force"
+		then
+			fopt="--force"
+		else
+			fopt=""
+		fi
+		git push $fopt "$repository" "$localrev":"refs/heads/$refspec"
 	else
 		die "'$dir' must already exist. Try 'git subtree add'."
 	fi
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 352deda69d..e956e6ab7d 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -175,6 +175,15 @@ remain intact and can be later split and send upstream to the
 subproject.
 
 
+OPTIONS FOR push
+----------------
+-f::
+--force::
+	This option is only valid for the push command
++
+Force push to the remote branch, just like gitlink:git-push[1]
+
+
 OPTIONS FOR split
 -----------------
 --annotate=<annotation>::
-- 
2.20.1

