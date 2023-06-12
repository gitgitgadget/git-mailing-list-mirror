Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D805C7EE2E
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbjFLMyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235997AbjFLMxV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:21 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE761984
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:15 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f6da07feb2so43205615e9.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574393; x=1689166393;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5BkXreb400WVeOfBVlIPrRt2tE9+3uwExECt0YY96k=;
        b=bE7BTFbcgiG4HidyhaDYYrecfY8aLrZnWFxWsHeWhibpX/ZVSGCp9lQ51iKl8IM+i1
         J8ktWNRif7Nz5PVG/WfOHxvWcU05dTcURd1752LcPFl2LOIZ0YZX1PFiebNlg4i8BUnH
         pReQSXfkKD0AYqJYggusaEJJDDM/KS/hAVE24J/oEHZ20yXQElghhStfe2gbP2wMDDUU
         igEB1OD1vJBJrosnNTcj+NGzAL5JUqgq8vkscUBfuI3shhNcwkTvDj3jRG6yI8P+1C3O
         0uQ6+aJ9GZOPubnh3IpIEqpzELc5dTR0Y0QXNm9csK92I5ZraX6xXGv0AV9MTWTGHlxM
         cYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574393; x=1689166393;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5BkXreb400WVeOfBVlIPrRt2tE9+3uwExECt0YY96k=;
        b=drfI1thEd5g6HjPu83Eve/0pYKcj+/tmyJpCUDmSWIYeyCOrI8568Ewh6NIAZnfz2U
         UldVvctCQvMSvgVA7lafQuVtGjeIckRtwdeTMKqI1/XCB2O1hEmwIRJt96vvESttF0Aq
         mzX1KX8shFVI2gOClsO19sjobH8nyjnJV1pjunZWvtfiQeUOQw3ZhMyfcIW4N4PZZH5L
         Hm+0bZayasYHIqeXWKogTRziT/GT/3+feN6usezC+NTgavTEc636cNECPRJyN5FKmiG8
         H3t+uYPn+W1uH1sILvrv57lh03Rq/GWGHj+UPqMcU2osDva4eHVq1US3JUqHClIVwJ7Q
         L/WQ==
X-Gm-Message-State: AC+VfDyBphCpDGeBPi9OLcBePw7ZYSrFgo7vXrPPiKyWRy34AV4DvYCx
        mS7RFH673Ev6wdZLVTMKBH/wL1hyM3A=
X-Google-Smtp-Source: ACHHUZ7KeGIzPYE93JiQEUae0T/dKK4f/8hKgHLxBHxTZmTiMZwuSwiAsav4CblSNnJZIDAzQwi8pQ==
X-Received: by 2002:a7b:ca55:0:b0:3f8:1b4b:bd13 with SMTP id m21-20020a7bca55000000b003f81b4bbd13mr1972745wml.20.1686574393336;
        Mon, 12 Jun 2023 05:53:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t12-20020adfe10c000000b00307acec258esm12365221wrz.3.2023.06.12.05.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:53:12 -0700 (PDT)
Message-Id: <040248a386899a611f7c10243a808624b53f290f.1686574374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 12:52:50 +0000
Subject: [PATCH v2 22/25] completion: move --pickaxe-{all,regex} to
 __git_diff_common_options
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

