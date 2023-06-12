Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEAEC7EE23
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbjFLMxw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235767AbjFLMxR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:17 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A3E10D3
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:08 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so4097844f8f.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574386; x=1689166386;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l05uboNt/LUqosn2wfX53a4vdlSfAxNCZIFmlfGziwE=;
        b=UcFE2ENlY+wfND0h4eRMWWCNZxcWX6V0OEOTv0ogDrTUjCcpcqDIE4KDG2wLrkZryg
         uhpRbJNIwt43MwE3miY3OqRmPnqW703+cTlnqTtpeRnqqVcQhQO8GD1nvUR+k0Yp/iXJ
         dtKQOeH7dwhQjqC9gNftgL9/K7IxiV6iMLuOMrwk6inp7qE3ifGHR/BZC8z6ktO7tRop
         sj37e662uExwzhWRlfCjfvrl1DT8WMLxexL2IgmiE9GQQ7I0FCiWgMsEEWmnfVgs1eL0
         9iYTxNDXjbif6SyNn7BLQhnsQ2NOm7moOTrrtQkkR3zPXpq7VhJX7nFOocWTCySsqvBz
         E4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574386; x=1689166386;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l05uboNt/LUqosn2wfX53a4vdlSfAxNCZIFmlfGziwE=;
        b=RSWAgiNaDYKxfz++y/qEDREBND6U1hyNBwv2JxmPeULHzbxxUm7ldEeijprbQkLJwy
         SV24cOVR3rKsrmmh4oVfQrBzuYYybo17dy1Ldlzy0EkWFkJqR+UDaU4//xWjH9HNNMzL
         KNn6/MW/NnX4mXYocAVxVylgT/VRd5VyDgoRD7cMIsGfWiekFjk7WYKyy6ovYqKYJNRA
         +qAZVFKJkhxGVMkjQeD0wKoYNpEpd7KnrztNUj/58Mh5OuYFrq7t1P2g18DT3j9ePlBZ
         wbJZGrTyiuLORZYY88FoKqDr0Is6it7bkOy4jCEQz09zu3rdVEjlbWKH8MpszmVANjw+
         S4/w==
X-Gm-Message-State: AC+VfDwdTnqLbi8/Ne3vy08oKz9nsDV1vg0CLXYr2sq5Nh1LYj8Nnv2S
        GUZHDsa6wk5qKK+7Ev4m1yfD74HzBJg=
X-Google-Smtp-Source: ACHHUZ4MHblWZaZblEOmAlj4WuBzXnzdx6a5KIjcbSPTH5PsRGQRJ8pFF0MgCOUXFcY9XD7iFDOCAA==
X-Received: by 2002:a5d:68c4:0:b0:30f:c601:63d9 with SMTP id p4-20020a5d68c4000000b0030fc60163d9mr1143312wrw.65.1686574386491;
        Mon, 12 Jun 2023 05:53:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17-20020adfda51000000b00307c8d6b4a0sm12464312wrl.26.2023.06.12.05.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:53:06 -0700 (PDT)
Message-Id: <fd94e9ae7830e98397c0f79cd3e0a519dc1fcd5f.1686574374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 12:52:41 +0000
Subject: [PATCH v2 13/25] completion: complete --ita-invisible-in-index and
 --ita-visible-in-index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The options --ita-invisible-in-index and --ita-visible-in-index are
listed in diff-options.txt and so are included in the documentation of
commands which include this file (diff, diff-*, log, show, format-patch)
but they only make sense for diffs relating to the index. As such, add
them to '__git_diff_difftool_options' instead of
'__git_diff_common_options' since it makes more sense to add them there.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e74636ebe86..7246ced14ad 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1763,6 +1763,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 # Options for diff/difftool
 __git_diff_difftool_options="--cached --staged --pickaxe-all --pickaxe-regex
 			--base --ours --theirs --no-index --relative --merge-base
+			--ita-invisible-in-index --ita-visible-in-index
 			$__git_diff_common_options"
 
 _git_diff ()
-- 
gitgitgadget

