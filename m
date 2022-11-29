Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8972FC4708B
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 18:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiK2SBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 13:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiK2SBq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 13:01:46 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EE76B39B
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 10:01:45 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id fy37so35677717ejc.11
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 10:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wz4SDGoracWe+FgZspc3AMfi8/G1QL7DCk0DY/lgosM=;
        b=NNu1vIAhUs90Qx+HmUv2w+i53/YHDYhm1BDB+jW/fPvuMBteUWmZ3RihA0gboNpdw3
         NZCF0sCHOg80C42fNbgc/dB5Bus1C05/5rOHNo50NqJqu2GLMv46xQxK5BtU4R3s/hnv
         BUxoLm9G0SM37aLQJVPVreRcDueAyT71WvXqcCl3MnorfIboPfYxnE1ms/2HptJJRRp4
         v685m4Y7410t2C7fl59uIVnPrnCjo5pkn642kdezu4cQtnHWhGQGIQQf26jDqLVGtWk7
         MmSUwh+WgiAgn5szZR+CEeAamaWYSI2wF0BEfIU0ND/kT3oWG2t9HYdFvwSh9C/DnyCp
         2WqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wz4SDGoracWe+FgZspc3AMfi8/G1QL7DCk0DY/lgosM=;
        b=msyzpM2P6jEV7OK/ULRjVe9nWIpe3mKPSqiTvKDDH2/F4uhflCR/ciQh+gZFGQ20zX
         msZ+H3ABdbvYLze2Q3OaOIPMWt5zxc0r69TM6ArhmkCTLJGeHdV/NlDYi05C4gARQNi9
         ITYyWLq1CHGrE2z8B9z3NEHYckMIm3FLx7xzTUKtLkp/NkjQGI9Zwo1pmdOi8PCuitHw
         SAYULwKPl35whn3nM+KyRZqhZXjpQ/uAmuU5CKC0wotX197XCHWaA7Z3Cb0TjcTMf45Y
         07e2IrYHo9ed3ZTZG1yJRCAqIc9i3TF1aJ0akE8NI1Lg6sFmkPICRphTEEakbB4Bd1hh
         c4mg==
X-Gm-Message-State: ANoB5pn9YJVbwZYVKltUIg/vp4PSiivQSu/qBVyT8NeWUG/sxnLIgkfW
        Mw5gDUyRc3aoa243p2y2kdNd+hxuG3YRnQ==
X-Google-Smtp-Source: AA0mqf7XGX95WVibT2fZVJ7u0wS3704RbFknDlsc7CGseOd5sMPJQzu7TJG9ZOWjIWMTXRAOTyO/gA==
X-Received: by 2002:a17:906:1546:b0:741:5c0e:1058 with SMTP id c6-20020a170906154600b007415c0e1058mr48212760ejd.472.1669744903538;
        Tue, 29 Nov 2022 10:01:43 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id r18-20020a1709061bb200b007b2a58e31dasm6524651ejg.145.2022.11.29.10.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 10:01:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p04vN-001VtJ-2b;
        Tue, 29 Nov 2022 19:01:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sergey Organov <sorganov@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/5] diff-merges: implement log.diffMergesForce config
Date:   Tue, 29 Nov 2022 18:59:37 +0100
References: <20221127093721.31012-1-sorganov@gmail.com>
 <20221127093721.31012-4-sorganov@gmail.com> <xmqqedtn957j.fsf@gitster.g>
 <8735a3gmuq.fsf@osv.gnss.ru> <xmqqbkop3hjb.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqbkop3hjb.fsf@gitster.g>
Message-ID: <221129.86tu2hiqre.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 30 2022, Junio C Hamano wrote:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Sergey Organov <sorganov@gmail.com> writes:
>>>
>>>> +	if (set_func != NULL) {
>>>
>>> Please write it like so:
>>>
>>> 	if (set_func) {
>>
>> OK, will do.
>>
>>>
>>> I am not reviewing any new feature topic during -rc period (yet),
>>> but this triggered CI failure at the tip of 'seen', so.
>>
>> Thanks! Do we now have tool for auto-check for these issues? I still use
>> one from Linux kernel, and it didn't object to this form.
>
> I noticed it when I pushed to GitHub, which ran the CI ;-)
>
> If you have your own fork at GitHub of https://github.com/git/git/, I
> think preparing a pull request against it triggers the CI.

...in this case though there's no reason to wait for the glacially slow
GitHub CI. You just need spatch installed and:

	make coccicheck

Sergey: If you've hacked on the (I'm assuming linux) kernel you likely
have that installed already, they use it too (being the canonical and I
believe original use-case for it).
