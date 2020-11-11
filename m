Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8B0C55ABD
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 15:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E36F620679
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 15:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMogs27f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgKKPST (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 10:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgKKPSR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 10:18:17 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A548C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 07:18:17 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d12so2839315wrr.13
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 07:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c0pnHV5ecCBsM8gl8aL9wVKSRAEBKNojSJz6OuHJJhY=;
        b=fMogs27fiC82mqjDwXirxSIRKM4dZV1xsilagrTd0LSZxNeXhPgj31nu88XaAHClXS
         Ptjqb3XqlRgHsbmaunT1rPhMwMpyzavoJrQcyytSmtR+vJNJpHY9xhJURYJWLYDSPmf5
         WT18zl3IMPOywpD21gniea1DIS6PoXCm9RiNHX0tZ9mPiSfAdID3jV+A73Dcz/wJWsvK
         k+/WQf1ParQimOOTdmgqZwiGKZE6yYymnzld4S84GvuY4dORMK44ahVj9Kw/74zOxAyF
         5Lgm6ysPF72ccJ1HBt6RVcUy1PCpU7MfjsCBwNFQ9l1fHyXEU2e46ezTctPcj4vlZ725
         uOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c0pnHV5ecCBsM8gl8aL9wVKSRAEBKNojSJz6OuHJJhY=;
        b=aabiScvfXXIazPt2vF8vZZtzOi9pVik+Cprj5pf/32BqlQxl+GEyAJhN9Lo1kJut7e
         Fkv/5dqZ7oqBK1OrjAG/r6a7fAJL4c4dD/Le+gdOkxB34aGdmhXl4G10drq5T255cCny
         2Hl/MGtWSAlaIMe7xbRhFckkS+UglcSVtdB/4Tw/ObeDkLCEG724P5/fPeV7BDg65FBC
         Y0bYFrJcB4Q4FmaWACFazSwBGU8SN1Gge5bW3Z2At5RTBYJNkPgg1otDg7vlJ41p37GA
         1SvlS4Hzq39RjYYVmqqxRP6eL9zvumwD55ZtdalJkzBcD7/0mYngKdE3UIL0ua+Zze/m
         k3fQ==
X-Gm-Message-State: AOAM533HxhjBFOlqhkFCHUNecgDXRTlfvF4XnmLHhoYAI2IQZFtVaVGU
        shiYgSoJWafKH+YT0tB2EDjZkPYbs7uDWA==
X-Google-Smtp-Source: ABdhPJwSPNiIodBXTnEA4h5cQIjXMCqdWMAzG4RHtG8JlafPHW4F/Z8p56XB26m6UVod3+AIrqJ9VQ==
X-Received: by 2002:adf:f3d2:: with SMTP id g18mr22322822wrp.77.1605107895516;
        Wed, 11 Nov 2020 07:18:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q2sm2940010wru.76.2020.11.11.07.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 07:18:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] parse-remote: remove long-dead git-pull.sh code
Date:   Wed, 11 Nov 2020 16:17:52 +0100
Message-Id: <20201111151754.31527-4-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com>
References: <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove long-dead code that used to be used by git-pull.sh before
49eb8d39c7 ("Remove contrib/examples/*", 2018-03-25).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-parse-remote.sh | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index e3f6195281..864519eecf 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -8,43 +8,3 @@ get_default_remote () {
 	origin=$(git config --get "branch.$curr_branch.remote")
 	echo ${origin:-origin}
 }
-
-get_remote_merge_branch () {
-	case "$#" in
-	0|1)
-	    origin="$1"
-	    default=$(get_default_remote)
-	    test -z "$origin" && origin=$default
-	    curr_branch=$(git symbolic-ref -q HEAD) &&
-	    [ "$origin" = "$default" ] &&
-	    echo $(git for-each-ref --format='%(upstream)' $curr_branch)
-	    ;;
-	*)
-	    repo=$1
-	    shift
-	    ref=$1
-	    # FIXME: It should return the tracking branch
-	    #        Currently only works with the default mapping
-	    case "$ref" in
-	    +*)
-		ref=$(expr "z$ref" : 'z+\(.*\)')
-		;;
-	    esac
-	    expr "z$ref" : 'z.*:' >/dev/null || ref="${ref}:"
-	    remote=$(expr "z$ref" : 'z\([^:]*\):')
-	    case "$remote" in
-	    '' | HEAD ) remote=HEAD ;;
-	    heads/*) remote=${remote#heads/} ;;
-	    refs/heads/*) remote=${remote#refs/heads/} ;;
-	    refs/* | tags/* | remotes/* ) remote=
-	    esac
-	    [ -n "$remote" ] && case "$repo" in
-		.)
-		    echo "refs/heads/$remote"
-		    ;;
-		*)
-		    echo "refs/remotes/$repo/$remote"
-		    ;;
-	    esac
-	esac
-}
-- 
2.29.2.222.g5d2a92d10f8

