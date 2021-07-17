Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63517C636CA
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 18:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4801D6109E
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 18:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbhGQSH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 14:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbhGQSHx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 14:07:53 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8A1C061765
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 11:04:56 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id t4-20020a05683014c4b02904cd671b911bso5357747otq.1
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 11:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=XnMaA1mMI105jHfH7EHvXmUunWFVY8TSDb38LnQT/lA=;
        b=nhKR2dz5HKQBIoK46xqCtgsuW+2tBWTQ+T8hbaozjw/f4k5+vkrNPFZ1WnuRNGot8O
         j4exMOU4d3RYTnsbhveCIsAwNq8hsvuKHYbIQql+tU8opJ8F37izc1Kjq7/NIQ7VAtgB
         cmahHYJ3VXXqOLzDJmEoaBUkv4QiyIC8JLMnMJR+YUOui91OteSsaN4BPLE8I4nWHQsQ
         kVunkxaJ7ARxpEdFuoh9ab0w61tyW1D/2kiuZYxSu8ifBpDpfORe/HiicWEeX896WNBj
         Yyo6I3DyeIslgmrlGp76zNpEr3rUAJyGpyW+5+/aArr7G5AMg96tmQNxCJMW4I/w5WG/
         BKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=XnMaA1mMI105jHfH7EHvXmUunWFVY8TSDb38LnQT/lA=;
        b=UIObvmrhP7Fqk1/iGgxT7Bl2VToBkqPl6IzsWoNOCkji/zF5gAOdA1w7KPlrvaJusc
         7W5U5pqvEvYaGRE2XX5i0VObgDbXO1x/pAUp2v/wi4jb4C7xEEMY0FnYb3SITB7V6rh4
         Z0USpy09Xw8Js7w6aoPC1ljvSt3Bi+PdJLui6ofblPDaAvbXSPYyxFR+MJkhKvzeED/L
         LBJI11l7CoQdLDmlH9bTJvYecPCo+WggXeVsbGxOX1XoxcKRaLBJLFDqTTvcoUuP5+yb
         KZtb2PYyefdDpqMEtLQgpnLvB83Qv37Ytaq+VWgQe5LMNpnP7/ELRofagGqUYRxrgvot
         WcOw==
X-Gm-Message-State: AOAM533UVYCy34gSDxSeGsg5Fu0uIybbrG/GtKgCNunFPyIq9um7Hfg0
        JqUCCiB8l/A6gErAfJ+KgyE=
X-Google-Smtp-Source: ABdhPJzpvTOhcwcxv8yeSntM4Hp3gFr6BZCGBsClmy3Sfca1QPbc6OKtVUvd86vjjaXSzihAqPSmGA==
X-Received: by 2002:a9d:6a0c:: with SMTP id g12mr13224013otn.220.1626545096365;
        Sat, 17 Jul 2021 11:04:56 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id h96sm2742327oth.25.2021.07.17.11.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 11:04:55 -0700 (PDT)
Date:   Sat, 17 Jul 2021 13:04:54 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Message-ID: <60f31bc6a42f8_25f2208b4@natae.notmuch>
In-Reply-To: <329802382bfa24241c2333bd38284aa77e3eb9f0.1626536508.git.gitgitgadget@gmail.com>
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
 <329802382bfa24241c2333bd38284aa77e3eb9f0.1626536508.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH 2/9] t7601: add tests of interactions with multiple merge
 heads and config
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> There were already code checking that --rebase was incompatible with
> a merge of multiple heads.  However, we were sometimes throwing warnings
> about lack of specification of rebase vs. merge when given multiple
> heads.  Since rebasing is disallowed with multiple merge heads, that
> seems like a poor warning to print; we should instead just assume
> merging is wanted.

Where is that explained in the documentation?

-- 
Felipe Contreras
