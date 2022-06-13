Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963E6C433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 22:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245179AbiFMWjy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 18:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241622AbiFMWjf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 18:39:35 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6CC1BE9A
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:19 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c21so8857423wrb.1
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ToooNOTgavex5x2MG3PNLcEHtMzKdYQZwy6Pk5Zu00M=;
        b=eWlvMibYPzIWSF6MQWO6902/qNoPsNJpXuzZLZgGqWu/pjeV10OKw9biEJBlh18KUc
         s3ke8vVzBAAU5b2GnPCCEidK5m6Vdyxa9AA+7dvcfxE5Vb8DtwiKEcg8s0m7Pu4G54+b
         D92WNVFTwSaz04FnmYLLyKo4xcwEStMp9tjyZbHvWYBav6egVFOsPMYUaU+cPaNb5mwp
         3JdrUthhat9XhgMRWWUjQOlULFzrh+FHBBHiL0wdjBoeKce0j0SOS+y72sI+8/p/KL8L
         ZkVo9k7TpGONTmooEqi3O7AynjiOPZobyKUMRGfUZcBpcbYDSvZSkNGJeqWH/ey0loup
         DHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ToooNOTgavex5x2MG3PNLcEHtMzKdYQZwy6Pk5Zu00M=;
        b=1O2q1kDz41Xux9M05ckowwu369gZQ+LpZG0cYLLiHgAvmmDEzrHpy5sQssTxMRspgJ
         h/mJkIv+9XugfFRpYtCF8DpFkx4M96iWAQVulrQhp1GT1nrBNLwhPaOxRquZseqA1X2p
         yq9dbXfPRKuckJP6ALrN3JzGhFXQViawAIeaC+uwYCT26/imXh3YUw/WFxqeh/cKWt+0
         jk1KuexdRUsoYDwrlXuvMZn6FFsJlufohLTfizuWTABmubEmdzqsrsCFO7bSfyQbp3Nk
         ogmrdkRwas50y63cmL+gDFyWHeLUy9noLEZF+79RgO2NVZpihi2Mfru5MyrflbSZy+0P
         P2gw==
X-Gm-Message-State: AJIora/yHVkKHaSMkEsU4UkdB3f5NCrL1zFtJ4IxcrOoUnBlapfRFtWs
        9qDHWIGhHl7d3A7ucO1/e7WSatyIldjjSA==
X-Google-Smtp-Source: AGRyM1t6K4LuF50XgK6EhKr8/VAr+6Q3x+5z5FnxRuTez4QwimHE+IW/dHsT0LaSA3Daym+4YwG9uw==
X-Received: by 2002:adf:eac4:0:b0:217:737b:e77a with SMTP id o4-20020adfeac4000000b00217737be77amr1751124wrn.121.1655159958447;
        Mon, 13 Jun 2022 15:39:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y3-20020adfd083000000b002103cfd2fbasm9670303wrh.65.2022.06.13.15.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 15:39:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/12] git-submodule.sh: use "$quiet", not "$GIT_QUIET"
Date:   Tue, 14 Jun 2022 00:39:02 +0200
Message-Id: <patch-v2-11.12-875acae8550-20220613T220150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
References: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com> <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the use of the "$GIT_QUIET" variable in favor of our own
"$quiet", ever since b3c5f5cb048 (submodule: move core cmd_update()
logic to C, 2022-03-15) we have not used the "say" function in
git-sh-setup.sh, which is the only thing that's affected by using
"GIT_QUIET".

We still want to support --quiet for our own use though, but let's use
our own variable for that, but now it's obvious that we only care
about passing "--quiet" to "git submodule--helper", and not to change
the output of any "say" invocation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-submodule.sh | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 7fc7119fb21..5e5d21c010f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -30,6 +30,7 @@ GIT_PROTOCOL_FROM_USER=0
 export GIT_PROTOCOL_FROM_USER
 
 command=
+quiet=
 branch=
 force=
 reference=
@@ -80,7 +81,7 @@ cmd_add()
 			force=$1
 			;;
 		-q|--quiet)
-			GIT_QUIET=1
+			quiet=1
 			;;
 		--progress)
 			progress=1
@@ -128,7 +129,7 @@ cmd_add()
 		usage
 	fi
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper add ${GIT_QUIET:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper add ${quiet:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
 }
 
 #
@@ -144,7 +145,7 @@ cmd_foreach()
 	do
 		case "$1" in
 		-q|--quiet)
-			GIT_QUIET=1
+			quiet=1
 			;;
 		--recursive)
 			recursive=1
@@ -159,7 +160,7 @@ cmd_foreach()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper foreach ${GIT_QUIET:+--quiet} ${recursive:+--recursive} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper foreach ${quiet:+--quiet} ${recursive:+--recursive} -- "$@"
 }
 
 #
@@ -174,7 +175,7 @@ cmd_init()
 	do
 		case "$1" in
 		-q|--quiet)
-			GIT_QUIET=1
+			quiet=1
 			;;
 		--)
 			shift
@@ -190,7 +191,7 @@ cmd_init()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper init ${GIT_QUIET:+--quiet} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper init ${quiet:+--quiet} -- "$@"
 }
 
 #
@@ -207,7 +208,7 @@ cmd_deinit()
 			force=$1
 			;;
 		-q|--quiet)
-			GIT_QUIET=1
+			quiet=1
 			;;
 		--all)
 			deinit_all=t
@@ -226,7 +227,7 @@ cmd_deinit()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${GIT_QUIET:+--quiet} ${force:+--force} ${deinit_all:+--all} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${quiet:+--quiet} ${force:+--force} ${deinit_all:+--all} -- "$@"
 }
 
 #
@@ -241,7 +242,7 @@ cmd_update()
 	do
 		case "$1" in
 		-q|--quiet)
-			GIT_QUIET=1
+			quiet=1
 			;;
 		--progress)
 			progress=1
@@ -335,7 +336,7 @@ cmd_update()
 	done
 
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update \
-		${GIT_QUIET:+--quiet} \
+		${quiet:+--quiet} \
 		${force:+--force} \
 		${progress:+"--progress"} \
 		${remote:+--remote} \
@@ -396,7 +397,7 @@ cmd_set_branch() {
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-branch ${GIT_QUIET:+--quiet} ${branch:+--branch "$branch"} ${default:+--default} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-branch ${quiet:+--quiet} ${branch:+--branch "$branch"} ${default:+--default} -- "$@"
 }
 
 #
@@ -409,7 +410,7 @@ cmd_set_url() {
 	do
 		case "$1" in
 		-q|--quiet)
-			GIT_QUIET=1
+			quiet=1
 			;;
 		--)
 			shift
@@ -425,7 +426,7 @@ cmd_set_url() {
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-url ${GIT_QUIET:+--quiet} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper set-url ${quiet:+--quiet} -- "$@"
 }
 
 #
@@ -496,7 +497,7 @@ cmd_status()
 	do
 		case "$1" in
 		-q|--quiet)
-			GIT_QUIET=1
+			quiet=1
 			;;
 		--cached)
 			cached=1
@@ -518,7 +519,7 @@ cmd_status()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper status ${GIT_QUIET:+--quiet} ${cached:+--cached} ${recursive:+--recursive} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper status ${quiet:+--quiet} ${cached:+--cached} ${recursive:+--recursive} -- "$@"
 }
 #
 # Sync remote urls for submodules
@@ -531,7 +532,7 @@ cmd_sync()
 	do
 		case "$1" in
 		-q|--quiet)
-			GIT_QUIET=1
+			quiet=1
 			shift
 			;;
 		--recursive)
@@ -551,7 +552,7 @@ cmd_sync()
 		esac
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper sync ${GIT_QUIET:+--quiet} ${recursive:+--recursive} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper sync ${quiet:+--quiet} ${recursive:+--recursive} -- "$@"
 }
 
 cmd_absorbgitdirs()
@@ -572,7 +573,7 @@ do
 		command=$1
 		;;
 	-q|--quiet)
-		GIT_QUIET=1
+		quiet=1
 		;;
 	--cached)
 		cached=1
-- 
2.36.1.1239.gfba91521d90

