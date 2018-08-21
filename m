Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82C8B1F954
	for <e@80x24.org>; Tue, 21 Aug 2018 12:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeHUPa1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 11:30:27 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:39218 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbeHUPa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 11:30:27 -0400
Received: by mail-wm0-f51.google.com with SMTP id q8-v6so2637555wmq.4
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 05:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FV81sjoNLJdlmBd69mGnNahwmeUz0A07kw5jiQm9+4A=;
        b=iZPyaJCFvbkfcV4jjZfODgVqUNHvluSCfJyyxQoJ+qHaVyf+ABe7U+3T2gzD03x+3g
         4ER2X044iVYs64Q8qd56wNMNpzTEJ2/4PM1xkt3V+L1jyAeuSKwdffQhsHLTp6M03hQ7
         SnfNHH0pZzl+lxfOrhlc6hJeT9ymFzePCeFCUbNOiIoqqy8PewZ8JMaIht+dkSEUNd6+
         xNdnqz69QDxh2IJRv+0Es4/rqyBpGrW+2kbk8OuGIm3su2tUzmnutFn46gDK1MceZXVN
         15k32tLVEyeYzIxBqeV7t6MXJMsLfmJAt3qETXf89PKG/CIOCF88V6b6VvICYxxqtY8f
         HU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FV81sjoNLJdlmBd69mGnNahwmeUz0A07kw5jiQm9+4A=;
        b=Ciky4NqEwoCbzYu6cL1sPFfSdBKJJKmArhmsOFILEQHyAAV0GNZuRq+FwY6YaFCcbO
         n3yETI2lslJ+Hx2aJehtWkbYyW9cvZMr0/tSX/szJ8VbMffchJTjLPkDMcYX00/4vUP1
         wA9Ri63+1iYIlcA1U9TGiId8TADUDDzVidTSg6yucpkybtsULE0MDZ0XKsk8P4+68FEr
         zmwI0BgMIrB3y4xde018L2kXzRVhlu1GlMk/QcLvBc1jT+WCHE8CbHmY/hx9OVfInHtW
         /y99kH5sWmt1aULoEAxOw3i2WMsrwdPkTEb7g4IOGdPyCJJc8TTrArUyY41J/0IIwdN7
         eaNQ==
X-Gm-Message-State: AOUpUlEVZuguLttyZPNCjgXNKnlucpMZ+xjwWXVa006JtN5dOdle/JzG
        8XdYKkq3EJViDQHPFiN8pF85MWe5
X-Google-Smtp-Source: AA+uWPzb40HjE72LTXvVem239HFH1ULqMpPLfuqmVEcOsvnzvAv4bI5Uw0GwfA90jRZpJPmcCHsosg==
X-Received: by 2002:a1c:3314:: with SMTP id z20-v6mr27007075wmz.95.1534853430623;
        Tue, 21 Aug 2018 05:10:30 -0700 (PDT)
Received: from [192.168.1.5] (93-87-220-187.dynamic.isp.telekom.rs. [93.87.220.187])
        by smtp.gmail.com with ESMTPSA id 60-v6sm6192279wre.82.2018.08.21.05.10.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 05:10:29 -0700 (PDT)
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Subject: Re: Do not raise conflict when a code in a patch was already added
To:     Konstantin Kharlamov <hi-angel@yandex.ru>,
        Johannes Sixt <j6t@kdbg.org>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org
References: <fae8346d-398f-e984-5aa5-e3dc3ee71d70@yandex.ru>
 <ab5021a9-6980-b96c-9d51-cc301844f2af@talktalk.net>
 <0d36d185-23d5-a656-67dd-5df86abed3e9@kdbg.org>
 <e5f65c19-0f49-d48e-c600-7dfcd95f3218@yandex.ru>
X-Mozilla-News-Host: news://news.public-inbox.org
Message-ID: <32354ab0-1d17-0be3-679a-75f6287a6bab@gmail.com>
Date:   Tue, 21 Aug 2018 14:10:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e5f65c19-0f49-d48e-c600-7dfcd95f3218@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Konstantin,

On 21/08/2018 11:37, Konstantin Kharlamov wrote:
> 
> > There's another possibility (and I think it is what happens 
> > actually in Konstantin's case): When one side added lines 1 2 and the 
> > other side added 1 2 3, then the actual conflict is 
> > << 1 2 == 1 2 3 >>, but our merge code is able to move the identical 
> > part out of the conflicted section: 1 2 << == 3 >>. But this is just 
> > a courtesy for the user; the real conflict is the original one. 
> > Without this optimization, the work to resolve the conflict would be 
> > slightly more arduous.
> 
> Yeah, thanks, that's what happens. And I'm wondering, is it really 
> needed to raise a conflict there? Would it be worth to just apply the 
> line "3", possibly with a warning or an interactive question to user 
> (apply/raise) that identical parts were ignored?

I see how this might make sense in the given example of "A added 1 
and 2, B added 1 and 2 and 3", but I'm afraid that might be a too 
narrow view.

What we actually don't know is if A deliberately chose not to include 
3, or even worse, if A started from having "1 and 2 and 3" in there, 
and then decided to remove 3.

In both these situation just applying 3 would be wrong, and raising a 
conflict seems as the most (and only?) sensible solution.

Applying _and_ asking for confirmation might be interesting, but I'm 
afraid it would favor specific use case only, being an annoyance in 
all the others (where it should really be a conflict, and you now 
have additional prompt to deal with).

That said, it would indeed be nice to have a way to communicate to 
`git rebase` that we are just splitting later commit into smaller 
parts preceding it, so situations like this could be resolved 
automatically and without conflicts, as you'd expected - but only 
within that narrow, user-provided/communicated context, not in 
general case.

Regards, Buga
