Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E8DC433E9
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 14:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18F3564F65
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 14:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhCSOpC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 10:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhCSOof (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 10:44:35 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9ADC06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 07:44:34 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id u190so3072712qkd.6
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 07:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:from:subject:organization:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=UnYLYHMlRknGXZtTdRxA7AGPYoC8RCNF8dVA7Vmnef0=;
        b=hl3xSyjylvHY7tiWq0Fd7cjWYH8/a4SZ5jUkbmpjGA3SiBcPqvr48IiAVL3GoXeJax
         8grptasRjjEk4EJrBFLP+SkehRB39tiTzt/nHjqtEhinnO0VykU6RSPz6S1rjR3d6ZdC
         738feQw9LxvL80y+EkRMDzi0CDB07BmCcyJafmZxlR3w5OXKOwEXMjd2ptBARTN8uoKZ
         rqELceNqaIscm68XmaTBb5uUE2NWwjirxBEpezgHMvoipKDMkmarwMkvuMdZakuIQzL9
         YmZMn3XF8Ij0qA6/E0yvTxkPrSvoiTsbeekYtNUKIoGCdA8BzPGpMAfMMsZoR8do+fDH
         BMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:from:subject:organization:message-id
         :date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=UnYLYHMlRknGXZtTdRxA7AGPYoC8RCNF8dVA7Vmnef0=;
        b=oWM1Qk2fBqn26I8j6UCb1grmlYfo9okcJD1RhzwlITgzdvMKNiJJZ2BO/CsD5v30qb
         oq2ulf3kUzPFJTxQos0ee6NcE+SKM2trWgwSqcRWPPS7FZAh40Lkfy75D+7FR5rSb6QT
         nCC0nAf7cRZlG89ycQBUiuhnKjX6MdF4wM6tfmjYM/fDfMt1xQVRS4uBstENxmz59v1K
         CFlDG84u9UaRW2FEn/dP2aeSadYUV9/L1FQt+Qh/yvHLrdKId8qT5v6LkzpqZuAIQ2Vd
         7/SoTU8seKqFdCqlDDYjWCaDT+dbifMeW8qB8H2b52e3ocNrTiiBhx2ZvbkCzM/kRj0r
         rT2A==
X-Gm-Message-State: AOAM531ZTvHlGVhkmE/dvCr173SqiqCpHPCNHuixJBrrfr9ESc/FvjOT
        Tyns3LIX/2v19TQ41YUtRUZRv5nIXAU=
X-Google-Smtp-Source: ABdhPJyH+k39Yry64biDlrHt7uDHbiBkvEGy2GcoQaT2+JWErpcABzmqyixemGesw08qHqk5O6tIyg==
X-Received: by 2002:a05:620a:120d:: with SMTP id u13mr9546364qkj.248.1616165073399;
        Fri, 19 Mar 2021 07:44:33 -0700 (PDT)
Received: from mbp.home (dynamic-177-53-82-16.telecominternet.net.br. [177.53.82.16])
        by smtp.gmail.com with ESMTPSA id p66sm4659309qka.108.2021.03.19.07.44.31
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 07:44:32 -0700 (PDT)
Sender: Renato Botelho <garga.bsd@gmail.com>
To:     git@vger.kernel.org
From:   Renato Botelho <garga@FreeBSD.org>
Subject: --no-edit not respected after conflict
Organization: FreeBSD
Message-ID: <4442fd0a-3306-a22b-3614-e3272f8f0be5@FreeBSD.org>
Date:   Fri, 19 Mar 2021 11:44:30 -0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was reverting multiple commits using --no-edit parameter and after one 
of those commits conflicted and I resolved using mergetool, no-edit 
option was not respected anymore and next commits opened editor for me 
to review commit message.
-- 
Renato Botelho
