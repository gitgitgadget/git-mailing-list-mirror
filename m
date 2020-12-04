Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F141CC4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99922229C4
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgLDT66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 14:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgLDT66 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 14:58:58 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E11CC0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 11:58:18 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id u9so3767601lfm.1
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 11:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vQ8MwFG3ETaPMYKcyNNyuXE2gDQW6IjWUB2TgaXTcok=;
        b=XFaksWYy+0onY/PByRv0p78N/mF0XGI3M+ZteuHKmGFi8CBwI/sAxxyygoPGMAS4Mc
         TEsDouA7Cttx4Nm+2mc9uKNNj4cb/75HByecmi8lVL0AclH5GsWPRjRpQXew42fZkOq0
         23Che1+lX9M9y02FM+sGDscPuBTWkXbpgPnVoI2ICJ5Thu45eod9eQ5fNe+0ZB2MjXkj
         rm1z50FVSZrpPINBRaebwkBFfRrcnj8flVRq5RPvma4zr6r0HA0yFRyPjBrqvL869mxH
         7fpYgl5OaPSuZoSqz5X4FmwVIK8AJvqsoklE2jfo3wr0WxRNb4MPib1R5VatJLbklzq/
         aCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=vQ8MwFG3ETaPMYKcyNNyuXE2gDQW6IjWUB2TgaXTcok=;
        b=OSHSv8422+NFNJyQenuv0WMtZjVrxOHcal9vYS5IhBbc6ACFLlS2UvodDKUlE2w0JJ
         tkyCA+M/EwHjndSs2LFD3kiCoOR4cZAgAnn4aknhW9QC5J3cmSeBIuwmCGcxYx8r5Zu9
         QcFGy3O9fR6t+kmnTMPkJ6QOpBiuqJv3wLYqNvvglR5qbtdEzciBHYcjodMC0ce6pYSQ
         3WHVOj4Zei02NlJFxApVJjvui9XPaNT05K1bvdd+d+6ZMrTlK0aAfWr9Al3LAIz8Sncw
         +WFpSxfc9J9lVusGr+Aha/SXY2TnDYZ/1Wb7ej+AyoGglAzlqiuem3TeNeQmOacx048l
         Gtww==
X-Gm-Message-State: AOAM531wyjJx16Z5Z/7k6GTkjTig8ZzW0pRBBKpBEyAeav8GUnigaDF5
        /RKreAn2SeNXozyNrjnvUDoKftF2V1M=
X-Google-Smtp-Source: ABdhPJy+bkrf9Ugr4gKJ/tv7KKX5bL2ovHd9rOaCLEONNtXNMpBOGFAlfv0+iZg0ELbkMFRdbDyqzg==
X-Received: by 2002:a05:6512:20c9:: with SMTP id u9mr4026398lfr.280.1607111895960;
        Fri, 04 Dec 2020 11:58:15 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b20sm1983888lfb.18.2020.12.04.11.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 11:58:14 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1 24/27] doc/git-log: describe new --diff-merges options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201108213838.4880-1-sorganov@gmail.com>
        <20201108213838.4880-25-sorganov@gmail.com>
        <CABPp-BGZO+7bRdCAGFdetOkmwyFnHxDPQ=SD4f6TSa9ZYGFn=A@mail.gmail.com>
        <877dpyhefj.fsf@osv.gnss.ru>
        <CABPp-BEyiLDZ5Ums1D5gL679EMmKXpqxWDF_xGT4scXLMkwseg@mail.gmail.com>
        <877dpxpjae.fsf@osv.gnss.ru>
        <CABPp-BH1ORV8XYzM1ESH8NibAb2B-OszqZ6r2xnU2pxvR5AZwQ@mail.gmail.com>
Date:   Fri, 04 Dec 2020 22:58:13 +0300
In-Reply-To: <CABPp-BH1ORV8XYzM1ESH8NibAb2B-OszqZ6r2xnU2pxvR5AZwQ@mail.gmail.com>
        (Elijah Newren's message of "Fri, 4 Dec 2020 10:33:57 -0800")
Message-ID: <87o8j9ny22.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Dec 4, 2020 at 9:34 AM Sergey Organov <sorganov@gmail.com> wrote:

[...]

>> >> To my excuse, I took this from git:5fbb4bc191 that has:
>> >>
>> >> +Note that unless one of `-c`, `--cc`, or `-m` is given, merge commits
>> >> +will never show a diff, even if a diff format like `--patch` is
>> >> +selected, nor will they match search options like `-S`. The exception is
>> >> +when `--first-parent` is in use, in which merges are treated like normal
>> >> +single-parent commits (this can be overridden by providing a
>> >> +combined-diff option or with `--no-diff-merges`).
>> >
>> > Yeah, I can see where you're coming from, though the context change
>> > feels like just enough different that the four words you added bother
>> > me a bit more.  However, this existing wording does bother me now that
>> > you highlight it.  Even though it's not something introduced by your
>> > patch, I'd really like to drop "normal" here; I think it is prone to
>> > cause confusion to users and as far as I can tell provides no useful
>> > meaning for the sentence.  (There are multiple types of single-parent
>> > commits?  What is an "unnormal" one?  How do I tell which kind I want?
>> >  etc...).
>>
>> I see your point, but I won't change it in these series. I think that
>> it'd be better if you change this yourself, independently.
>
> Sounds good; I'll submit it after your series merges to avoid any conflicts.

Ooops! I actually did change this in the series, and now it reads:

       Note that unless one of --diff-merges variants (including short
       -m, -c, and --cc options) is explicitly given, merge commits will
       not show a diff, even if a diff format like --patch is selected,
       nor will they match search options like -S. The exception is when
       --first-parent is in use, in which case
       --diff-merges=first-parent is implied.

that hopefully is OK with you.

-- Sergey Organov
