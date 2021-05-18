Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F09BC433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 15:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CA11610A8
	for <git@archiver.kernel.org>; Tue, 18 May 2021 15:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244559AbhERPBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 11:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbhERPBV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 11:01:21 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA36C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 08:00:02 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id z1so5068457qvo.4
        for <git@vger.kernel.org>; Tue, 18 May 2021 08:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GcWRaQtcEtJMJQ4WOMKNrVUKvG6Dnly+CJ+UFIa5Qv4=;
        b=WuGIqKWohJJwUzA9d/m1gUsGNhIWmF62RrNZ6Bfcj+Hx1dJCgbZzSOyO7DnPz0lZ+l
         sVo3V2JqLQ6pEAmQrOMCGD3b3M7dFILnr5DhFevNqauqYrNF/pJisfNZdYHBUtpuSHNm
         5WBkszCM63JQwFaOxvQQ5pCb1RnCOaeGQdHNYq+6lJwovNOcX6zPbDXhfDLgN4MNRleM
         Mp7lVmH69dPheBPQsLD2LrOxu2x8a20e12OEmBA42m5Ry5g8Iyjj8BLGZFz6Czq+u053
         VDA2tfRdckBFtFpEs69qtxXQGuk2nHZLrsieuzChzW9o0pql8cw0EqgjEXNg9Fq4aM6+
         byPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GcWRaQtcEtJMJQ4WOMKNrVUKvG6Dnly+CJ+UFIa5Qv4=;
        b=lmVNSPlU+NokLuadLuK0SeNK2dz9anGwBy2NTLf0Q5yo1M9k8RSpreeVJD6ZP1O0BA
         jr6nvSjP2LcPHEm5iu7OX1kYWL/ANxT0iYSInWv72Vu09L1rn+H/HTnp/76Opl5jSOw7
         iWie5CoOtuTLeXw7NMJ+ew9WgaNyKW98tR8bLKdNGjZyz2F5B0gDdQF/mz5YEZ9u2DDv
         WBYcN4SJESGcVvcUMXSOhEyHT/sT2ecYzgKIJz8dR5EiUY9z0HML8VFfIZYNV8hTtZlb
         24AmbJHLI3ArpkGrCrpkQWZERHoxOQtIeS/dEjht1ob/3vDPi3laLoHECrkJ7sDa3D7n
         coeg==
X-Gm-Message-State: AOAM530oPM94pqFWhQb2PxWqZBsF5IS1HZwdNJa90PxChW1RTOyS5LzV
        oOti5yxvY84OZPclkJ/IXlw=
X-Google-Smtp-Source: ABdhPJzfZ8K0kFu2p4DKjUgzcvD6h8cOR4buMBs/67Tp1QoD+nb14OAwvXwOiSzqiz6Hr/NtNWeHIw==
X-Received: by 2002:ad4:4184:: with SMTP id e4mr6044669qvp.13.1621350001310;
        Tue, 18 May 2021 08:00:01 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:bcf4:c194:74a1:9906? ([2600:1700:e72:80a0:bcf4:c194:74a1:9906])
        by smtp.gmail.com with ESMTPSA id t17sm3978965qto.92.2021.05.18.08.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 08:00:00 -0700 (PDT)
Subject: Re: [PATCH v3 03/12] t1092: expand repository data shape
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
 <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
 <70971b1f9261f2623ad6d6393be1a8e191003eb4.1621017072.git.gitgitgadget@gmail.com>
 <CABPp-BG=5huMt2FOrzscNrg9rCpo40we7ms8K=508+Kur0yGnQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <48a361fd-33d5-29ba-556f-10075139de33@gmail.com>
Date:   Tue, 18 May 2021 10:59:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CABPp-BG=5huMt2FOrzscNrg9rCpo40we7ms8K=508+Kur0yGnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/17/2021 9:49 PM, Elijah Newren wrote:
> On Fri, May 14, 2021 at 11:31 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> Later tests will take advantage of these shapes, but they also deepen
>> the tests that already exist.
> 
> Makes sense.  Do we also want to add ones of the form
> 
>    foo/bar
>    foo.txt
> 
> ?
> 
> Here we'd be particularly looking that if foo is a sparse directory,
> we want to avoid messing up its order.  ('foo' sorts before 'foo.txt',
> but 'foo/' sorts after, and thus 'foo' the directory should be after
> 'foo.txt')

Good idea!

Thanks,
-Stolee
