Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13ACC47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 09:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B414613EE
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 09:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhFCJvk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 05:51:40 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:47098 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCJvk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 05:51:40 -0400
Received: by mail-lf1-f44.google.com with SMTP id i9so7846519lfe.13
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 02:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ScusXkG45QK3ZIuRvCf/J67NM2Dk/4XDXKzfgo2k6fY=;
        b=QPD1+9tj7E8Y2hFPmBR1ZyNSbxdG3hNB1F6bDMMBIuGs3gG6dwtUh6VjzdiG2YNBNt
         S9WV78K084Y2ZPfzf6jBXud5+0pbPrJs16x1hyNucyEJyY16vyUQ5nRm1GhOSfQBHsqo
         MiGjEw6pcfqgqezuaguB2lyHQUzdaieKcTpVkgc/UBy6M/725QeyPdtXERKFLkIzF8sn
         3GA8Ok+psRRiCtyT34f5+tzP0ntcG1UbGiI/6Mwo9Dlxqi9jiTbIAEpEgXKsHo2+Q2pI
         mMaa0willXigkBTjtpdbaTS+XtyF1r9h7uoLGDfr8ZZj2w+A5QIh1mvFMcOwMTgM0SZO
         ZVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=ScusXkG45QK3ZIuRvCf/J67NM2Dk/4XDXKzfgo2k6fY=;
        b=kwcvls9bNzbgKkX38MzDdeA0e2AuPjhpVQmxn+vd5Uc45q++2af4OvZnL5L25c07xO
         RgrexSQemkFwPXGh1dy3yRVKqH8kW2j3HgvAwrbqSPxt8AVqguU4VVDdft5hhE4beqJE
         OLMR2Du5XX4dbVtZDHNcPfnCigYBMmCyNhlwK7LAAMFm8Tt9kNuaSD8H6/kEPL/LclN3
         zJVikLxiU+fRfMPB2u4ErWmpTuBOGCxYgVhBhTETMyt+z8l3oMNLBaDg8DGhvbhkyV2s
         7ZeAHlAiaV3qXqMFZM10INxtNhfhM2jhYjhbY5zPR2IeHPw6zoeG0fFJW2rnMwbpVo8b
         U8jA==
X-Gm-Message-State: AOAM533MEnVVOaE2/shw4JxPYH7gjR9VLxtB3CE0HlQy9w5BzcLTynEN
        QKRAxYgytjDsuDcLzqFDYKKt6gIjd8E=
X-Google-Smtp-Source: ABdhPJyeb+Ge+vuXhZpZ6Zb0t9asLZ78n6Ek1lEX7U4jiWVK5Ogl5ITAEVQikvbpR+xUPrdR2ftpkw==
X-Received: by 2002:a05:6512:1304:: with SMTP id x4mr25299475lfu.571.1622713722768;
        Thu, 03 Jun 2021 02:48:42 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p20sm303704ljn.86.2021.06.03.02.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 02:48:41 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: The git spring cleanup challenge
References: <60b5d281552d6_e359f20828@natae.notmuch>
        <87wnrd6wqj.fsf@osv.gnss.ru>
        <CABPp-BH7f+sM_POEsSSvmz_p=oEzHQcvTk_cEhTGeb-yq9fq_A@mail.gmail.com>
Date:   Thu, 03 Jun 2021 12:48:40 +0300
In-Reply-To: <CABPp-BH7f+sM_POEsSSvmz_p=oEzHQcvTk_cEhTGeb-yq9fq_A@mail.gmail.com>
        (Elijah Newren's message of "Wed, 2 Jun 2021 17:26:37 -0700")
Message-ID: <87pmx32s93.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Jun 1, 2021 at 3:39 PM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>> > Hello,
>> >
>>
>> [...]
>>
>> > These are the configurations I've chosen:
>> >
>> >   [merge]
>> >     conflictstyle = diff3
>> >   [sendemail]
>> >     smtpserver = /usr/bin/msmtp
>> >
>>
>> [pull]
>>         rebase = merges
>> [push]
>>         default = simple
>> [rerere]
>>         enabled = true
>>         autoupdate = true
>> [diff]
>>         algorithm = patience
>
> Any reason for patience vs. histogram?

No, I only tried the 'patience', didn't try 'histogram'.

-- Sergey Organov
