Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F9BC43381
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 18:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 505EA224DE
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 18:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbhAWSsn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 13:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbhAWSsh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 13:48:37 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22812C061786
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 10:47:57 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id r199so2275834oor.2
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 10:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=InvK8UiTr2Epak4oAetN8zVO6JUC1R4rcoXlL5HlVNY=;
        b=dG0GmQcvwRFpT+vD6VfLa/s1OyOKnlKKbqVs+YBsPxxigySvELC8uEdDqO0jNM8Gxr
         LKqzODTvdgkVaXDilRLohkXNOtCX+J3YmunWJlFsT6DDsGHCBY4eN230Y2KuRvn/maym
         2JeDKZLux2snQ2yjsXpwiR9yxCF/JgpsMZFz5FPU73ZY6c9lvoUMpOCbrAjcl7+XuAmY
         Ej9nVbnF6s3cGDdGAbRS0T7M+3w8KFx4LtH4LAYroY19wFagMBSJRBMBP6tu8762H7O2
         hoc/yjcQOAFZIrw6wABJyr8yeQu8TG/JQSgTxL0NaxoaAGA3BoC1iPEgQpJWyfr6s4GD
         XXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=InvK8UiTr2Epak4oAetN8zVO6JUC1R4rcoXlL5HlVNY=;
        b=VKiUGDf8V4v4IeBClNiQVBhkwVTMujPx4Ii2lMEsiOKu4cZuqodPuT9MLLclKQG/Qr
         wM981o/gZyNR/JnnurQfa2RAAzMmVnHSI+yZH23a6uO0AaRMrS92K66NgTm1KGSqI5wA
         Gg3ZYnTcoOCfVqn/d6kjuqI3aeux7lpWdxSr82PwNFeYYo3895jkW+U7zUVrp2gnkmH2
         MtmR08d48wWrGqmys7zI9gOVmX4fpQk3Dtn3890ooHIVeL5C4ApOIpIQ0kAkfsYbOC4Q
         yF8U4X7USAZcHeoIrh9ivc6NW8MC8AmFVXAyTP5rzqmUf42T4g/QQayjeuqa+YreqOSA
         3+ig==
X-Gm-Message-State: AOAM532xAu2ggxxCzYVBtQ0xmd9H6hC6GhG5bw1PFUiDnF+7/4Ybq30e
        De77hv96rSGZMJ5eb/qOaj4=
X-Google-Smtp-Source: ABdhPJznMgXmxy4Y0pNyG4Gm/eU/QvLW8B30/UYzL+mrBxPDQXqhxTBKd3jmG0LnU2bNvMbxKBEzQw==
X-Received: by 2002:a4a:e963:: with SMTP id i3mr7666183ooe.37.1611427676504;
        Sat, 23 Jan 2021 10:47:56 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:98e8:103:e6ee:9536? ([2600:1700:e72:80a0:98e8:103:e6ee:9536])
        by smtp.gmail.com with UTF8SMTPSA id d11sm2187813oon.21.2021.01.23.10.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jan 2021 10:47:56 -0800 (PST)
Subject: Re: [PATCH v2 0/8] More index cleanups
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
 <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
 <CABPp-BHfVs3Yb-QqeTPcdaa_hSVbqyds6ZQ2kX_wMQmWwAEdvQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a6762eae-6c63-0e15-f5b9-14f69e1f2593@gmail.com>
Date:   Sat, 23 Jan 2021 13:47:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHfVs3Yb-QqeTPcdaa_hSVbqyds6ZQ2kX_wMQmWwAEdvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/22/2021 2:49 PM, Elijah Newren wrote:
> 
> You've addressed all my feedback from v1, but it looks like you missed
> the pos + 1 changes highlighted by Chris in his review of patch 3.
> Oversight?
 
Yes, oversight. Thank you for the reminder.

-Stolee
