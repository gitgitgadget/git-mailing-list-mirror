Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD9BC77B73
	for <git@archiver.kernel.org>; Mon, 22 May 2023 19:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbjEVT3U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 May 2023 15:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbjEVT3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2023 15:29:16 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16559118
        for <git@vger.kernel.org>; Mon, 22 May 2023 12:29:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-307d20548adso4155207f8f.0
        for <git@vger.kernel.org>; Mon, 22 May 2023 12:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684783746; x=1687375746;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXZgtomDUzZgqaysrY3KHewgOZIRwk9evIrjx/Ge6ec=;
        b=RgrWfsd+tE5HHGkuQ8Dx8tAD0l8lyFnM0Bro02qsEOGPFwh0CJplfCjvNyrtw3/88b
         Ye5uXxeezvBcOF1AsNGCFhwY8ezxE9DDH4AUrWyUpCn11Vw4dzHq387b0XhYwE9Zkef1
         HSV2rYmiwsSn2l3Uote+HfNKLMTSLmbr6m0n+58mj7UIoRITIbIDbHFJC0XW7jBZ0vQV
         LMK3o6GbxXi5ez5bMEEpnCofbMir5fXuy0Zr6Qr+ShhhPFF7p7OnRAh+Q/1GQva1w2aC
         43RgDNoBp7vFGlaYLsgkm6vTychCkFi7GyuqfK1UEDgzAECXXhUbYLhrcwTgeUcl+bnI
         bJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684783746; x=1687375746;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXZgtomDUzZgqaysrY3KHewgOZIRwk9evIrjx/Ge6ec=;
        b=BIzHnEiO/lmU6VpY/Zml9TdBYEIpi7JihmaabkBdSCyK3jVIUp6OcBGbB8rR5goUbP
         IJd9vJDSPgYMsyvA7VXQRq6717do54X6aEZJeqhzngXBB6brSm1qhYJgHHKJyNY2ruXP
         6tIBd+gYaV1mf+cHHXutjHqqIYxWGBcEn5zsU1kxqklYyoguXZY+C1JRHRDuSw2K/l6f
         ToOW3dWU8NM/GoHZwidNp+kfqyNeiOWdMbs0Rr/Ch7xtVvjGsidj8Nrue+9Wou3OlWur
         0VrjxGspS27fTOms7WcjFSHi4XGAzoWNFiUXat5GuI8S2vfyPHHwBN0/WW6x3LUe7+8Q
         MmrQ==
X-Gm-Message-State: AC+VfDztHuGVNncvFyiOB0z/b8geCl1WJLWnpIp6eDncr6JrkYMaP/4u
        1AhqwzELbdgAk5c45eM9SmZ+fXSTKIE=
X-Google-Smtp-Source: ACHHUZ5bPo0v1vr92gG31K2wqNxCWfwLBa3PsiEVPfxsVB4LVa+Pd0R+pu75amitwPp9Rees8tQVKg==
X-Received: by 2002:adf:fa09:0:b0:309:4e64:7a28 with SMTP id m9-20020adffa09000000b003094e647a28mr7747351wrr.49.1684783745563;
        Mon, 22 May 2023 12:29:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10-20020a5d414a000000b00304ae802f02sm8633605wrq.66.2023.05.22.12.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:29:05 -0700 (PDT)
Message-Id: <70487d664591f1a201ce5711b16521873f80dbee.1684783741.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1515.v2.git.1684783741.gitgitgadget@gmail.com>
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
        <pull.1515.v2.git.1684783741.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 May 2023 19:28:58 +0000
Subject: [PATCH v2 3/6] completion: complete REVERT_HEAD and BISECT_HEAD
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The pseudorefs REVERT_HEAD and BISECT_HEAD are not suggested
by the __git_refs function. Add them there.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index dc95c34cc85..bcda376735c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -767,7 +767,7 @@ __git_refs ()
 			track=""
 			;;
 		*)
-			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD REBASE_HEAD CHERRY_PICK_HEAD; do
+			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD REBASE_HEAD CHERRY_PICK_HEAD REVERT_HEAD BISECT_HEAD; do
 				case "$i" in
 				$match*|$umatch*)
 					if [ -e "$dir/$i" ]; then
-- 
gitgitgadget

