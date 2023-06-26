Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBC4EB64DD
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjFZQZ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjFZQZH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:07 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA08173E
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:02 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fa94ea1caaso11748535e9.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687796701; x=1690388701;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l05uboNt/LUqosn2wfX53a4vdlSfAxNCZIFmlfGziwE=;
        b=sM/Z7jN6wkznc+YHF0F9A/A4JGdclC8xaWVIGTqlNRqaiTS+oAyEplwAmfHYD9zz3j
         tVdVc+9Qtx7tEu20UmPBTd0bq+X26N7fN7jmW35wDU2Qom6nYFu9eSbBdJigOExRNy/g
         VzaK4tg4FBiQZIaY8k534Tg3aFr5S2qdbzSyHQTpDjTbycmXEyaKB4VaEo6xGTRqhSWI
         2+ooUdTAZNkgAryHxddoaWKAgDdQfILIxcioR/825UfDaFfmu3v1uu6zcA8LHGuxA6y2
         gMNKTJ9Mk1guUMKs0up6xJYBNvhwKaUQmzbrZHNRpfyuCt+ZzftU60Bj8OaMTqCLtJ31
         8l7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796701; x=1690388701;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l05uboNt/LUqosn2wfX53a4vdlSfAxNCZIFmlfGziwE=;
        b=Cv5hUobTbkXK47c08PRN8cf0EeT7Xe+i53NAsCFy/aAr3kc72qKamkaBdyGy+7QIMQ
         kgsFHsJGOhXQD/H3ly0h0EYGOXfDz3ngRl4YLlEXwlUCtCDvoICm0J+K1nl/O6cm2p/c
         a6K1UU1chu8t6i3wQyqo/le9PcqyeVbCTtUtfxcQo5RLZ7q7I8Afel723qhPUbEH2qFL
         6i3ZdlIku4EU7CaCx6O3U8uGtQZlbjlE4Ghpi4BmSJNQyrB0gBz72JNYV5JZqa/jmKZd
         xQmJ1xjVCpjdyV0UjHBTCjZ5F6O5QukVYYAXU7k0912WFPNJg0aDPOj/DvKCx54YDEaF
         O+NA==
X-Gm-Message-State: AC+VfDyD6UUOA/iAO4zL72qal/d22EL0C7NwNRpeHnIBJdc5UP1RCHx7
        UdOIA3KcN8gWpXheko4U+fDl/t/w7K0=
X-Google-Smtp-Source: ACHHUZ6KPqaYJT9HLtunl2ua97mSRuYoYn+Y2kJS6RGmOWCi3orzmDVjzJdvTWTrkQTbt+rqV97SVQ==
X-Received: by 2002:a05:600c:4309:b0:3fa:8522:283 with SMTP id p9-20020a05600c430900b003fa85220283mr6359552wme.13.1687796700751;
        Mon, 26 Jun 2023 09:25:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b3-20020adfe303000000b0030fd03e3d25sm7854611wrj.75.2023.06.26.09.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:25:00 -0700 (PDT)
Message-Id: <fd94e9ae7830e98397c0f79cd3e0a519dc1fcd5f.1687796689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
References: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
        <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 16:24:37 +0000
Subject: [PATCH v3 13/24] completion: complete --ita-invisible-in-index and
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

