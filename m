Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B28C7EE2E
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 20:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjFJUWX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 16:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFJUVv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 16:21:51 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1D63AAC
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:43 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30ad8f33f1aso1900860f8f.0
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686428501; x=1689020501;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5BkXreb400WVeOfBVlIPrRt2tE9+3uwExECt0YY96k=;
        b=puxbgW25RgRJ/8gZgpW5kLfhqzvjzhHOFXpgB4iXVXFRhHUvDJWmgpvxQ+w8tfEaoW
         V6rHXImX/z/KMFf94hCFG6Hmv1x9BxAc3KqbxtU/MjNLrzUBE2aIRJpc/afKvKgE3pii
         DIzwJ2dUG1HmTOYjMhG0u6dPqSXhFud7CFyWwa03izH7DgDC+MnMvz9tNYrdU802Kjdl
         bBERAmRvhcOcYbzr8DnGc9RABqJuWiMxYfW2YMwVJUezaDKKL2fSZYIvl20V3cLdxx3j
         piLZRLu+JR7BMrFhB79h/L1GmdVoh+0UAdkRqyIM+kFPg1NDOpo1ciqu5Rx/ouniOhoP
         Wl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686428501; x=1689020501;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5BkXreb400WVeOfBVlIPrRt2tE9+3uwExECt0YY96k=;
        b=NT7FLywPKJ9lgCqwSKNlb0ARAUWxrtarGZwgQam9I/+uSk1RKOUNviOJ+CRjFWgyqQ
         6sJiKq1Ij9uK7Ye4kptPqAgQAVbKoiDPGJPSfy4/Q8xCIuww/NKSwX0wNkZhZHlrvnBW
         iOs6dcPlQ14Qx4zCYmbHmJzTCW8P/e5b+sS9tJqfV/V+VnIoG22xa0aPXAJRIYm15S0e
         QpGGYopl1efLeHVy7R9S49bM04rPDVRXuLpv+fybpswQ5UOU5sI0/1PS9n2NSYhq78Uz
         4Eb+v5MgbEl2cM8AqbAAd7qOiA4GX4Eg8Uj5f9tSw3rAvfegkoyAboj6pl0KMu+e+wrA
         C4xQ==
X-Gm-Message-State: AC+VfDzbdWXkbEKGiyT5/LHiZflEudfheuKv1SajfxbK/eS61StDL1is
        tvF+pWyiljFVFNapWED7Z504dZFZr9E=
X-Google-Smtp-Source: ACHHUZ6wfLdbyG+wZb8O66BdnIeRMOpuKNmoV2oYLsz7ODIvfy8e0u7YvznCbcete9O+1GAz6n6WqQ==
X-Received: by 2002:adf:ea05:0:b0:306:2a42:d23b with SMTP id q5-20020adfea05000000b003062a42d23bmr1176817wrm.6.1686428501432;
        Sat, 10 Jun 2023 13:21:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600000cc00b002ff2c39d072sm7857838wrx.104.2023.06.10.13.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:21:41 -0700 (PDT)
Message-Id: <cbe0c1b3e5fc0de8dd30253e8967360d2fb1f095.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jun 2023 20:21:21 +0000
Subject: [PATCH 22/25] completion: move --pickaxe-{all,regex} to
 __git_diff_common_options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The options --pickaxe-all and --pickaxe-regex are listed in
__git_diff_difftool_options and repeated in _git_log. Move them to
__git_diff_common_options instead, which makes them available
automatically in the completion of other commands referencing this
variable.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 93522558a98..8dd54fd3ae0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1763,10 +1763,12 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--irreversible-delete --line-prefix --no-stat
 			--output= --output-indicator-context=
 			--output-indicator-new= --output-indicator-old=
+			--ws-error-highlight=
+			--pickaxe-all --pickaxe-regex
 "
 
 # Options for diff/difftool
-__git_diff_difftool_options="--cached --staged --pickaxe-all --pickaxe-regex
+__git_diff_difftool_options="--cached --staged
 			--base --ours --theirs --no-index --merge-base
 			--ita-invisible-in-index --ita-visible-in-index
 			$__git_diff_common_options"
@@ -2115,7 +2117,6 @@ _git_log ()
 			--expand-tabs --expand-tabs= --no-expand-tabs
 			$merge
 			$__git_diff_common_options
-			--pickaxe-all --pickaxe-regex
 			"
 		return
 		;;
-- 
gitgitgadget

