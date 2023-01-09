Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A01C54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 18:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjAIS5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 13:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237305AbjAIS5E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 13:57:04 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321671C92A
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 10:57:03 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id g19-20020a05600c4ed300b003d9eb1dbc0aso4810512wmq.3
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 10:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1g4sJ4hwIGwx2bckHl4k2QPwGMn4s+C3A+566tGye0o=;
        b=m9ervHkyUafCWxSEqO/roQoNb3IBgFDVs63plVbq5H/cdsjbOndBQRKoaGYwAHuXRN
         pw2m66eC22lVIRymz+uAaP/YbfxCWEOjiTGxBUxPwFutz+jpct7VQwcBNuP57qTV3OD2
         jOyvuXkxAvss8BmY/A0LIyOTif+voqVk+dm6iTkEpTINQJUO4zndo/SB19YGpZeR3VHp
         Xo85wp5Dz/MfGPmQ/DmSiSVCp2m5idOtDiFnaMTisZtvt6Cw1d+nrHyMCWWdzkjDocKn
         O+ce6XAwbh40NMjrGjePJSny450VRsTfcAPW9TPWDukbCSHQ12fVVa5qKPaGX6Iic/fU
         InlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1g4sJ4hwIGwx2bckHl4k2QPwGMn4s+C3A+566tGye0o=;
        b=UqpB3ooe2Xb3HXgHhCd6dk6r6VXBAiOHYhv3aEf4POc3VlkbBevCLsxnzXlC+1LnDJ
         xD3vumtdeVO+ziD73kPeoKuDWCKzuTI6mK3vDB1WLTMNnsNDITL86sSkTITo6Hrdcofj
         jyGM8z7At6lo9emz8KGqqhQ2nh43moEvzfhp6IuBLGRJCaXMxEp+ynEGPX4rjrrljpbL
         4d8bwhX2Lqk6GF08WbIijIms/C8RhnxMc1Cs/Xv8Ll/GtpwzhQUecU12XOvKiVMHZQE4
         V4gSF5noz+rmMcdLC2Dr4R3leAT+8O29KCyWSAYZ6nHwTrEfvN2GJha3txgYKx+EMcMW
         BWag==
X-Gm-Message-State: AFqh2krbtzeajhBlFHaSmEN9AWjCU6y5drOSuveiu5c9Ix+g02jKyhnM
        GNXsw6OgT/0GVK65rkUMUajmio9iyjE=
X-Google-Smtp-Source: AMrXdXsecVpsjUOhGjX/MSYhBoW9MA6u9LLVdHxMC+8+Wo4sbePyVSITMfNQpjGTdtLc88mD3Wf7mw==
X-Received: by 2002:a05:600c:22d4:b0:3cf:82b9:2fe6 with SMTP id 20-20020a05600c22d400b003cf82b92fe6mr56589785wmg.8.1673290621512;
        Mon, 09 Jan 2023 10:57:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c444a00b003d998412db6sm18119844wmn.28.2023.01.09.10.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 10:57:00 -0800 (PST)
Message-Id: <pull.1432.git.git.1673290620410.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Jan 2023 18:57:00 +0000
Subject: [PATCH] git: replace two checks with one not equal check
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

(version < 2 || version > 2) looks silly
considering this is an integer.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    git: replace two checks with one not equal check
    
    (version < 2 || version > 2) looks silly considering this is an integer.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1432%2FAtariDreams%2Fversion-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1432/AtariDreams/version-v1
Pull-Request: https://github.com/git/git/pull/1432

 builtin/show-index.c | 2 +-
 packfile.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/show-index.c b/builtin/show-index.c
index 0e0b9fb95bc..ae5cbfdc407 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -38,7 +38,7 @@ int cmd_show_index(int argc, const char **argv, const char *prefix)
 		die("unable to read header");
 	if (top_index[0] == htonl(PACK_IDX_SIGNATURE)) {
 		version = ntohl(top_index[1]);
-		if (version < 2 || version > 2)
+		if (version != 2)
 			die("unknown index version");
 		if (fread(top_index, 256 * 4, 1, stdin) != 1)
 			die("unable to read index");
diff --git a/packfile.c b/packfile.c
index c0d7dd93f46..428f572a263 100644
--- a/packfile.c
+++ b/packfile.c
@@ -121,7 +121,7 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 
 	if (hdr->idx_signature == htonl(PACK_IDX_SIGNATURE)) {
 		version = ntohl(hdr->idx_version);
-		if (version < 2 || version > 2)
+		if (version != 2)
 			return error("index file %s is version %"PRIu32
 				     " and is not supported by this binary"
 				     " (try upgrading GIT to a newer version)",

base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
-- 
gitgitgadget
