Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D76C433DB
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 15:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD5BE221E5
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 15:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbhADPSA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 10:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbhADPR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 10:17:59 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3502EC061574
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 07:17:19 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id g20so37292492ejb.1
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 07:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=w5g4oZDQ6GForwu/7aSmjKGMfT2RLzJZuQ/ataAco1Q=;
        b=skNEbLPu/hsGtyrt1i6Xo6KGfApw5NeCzHT0s5ef9D8CE8hCqVUL6JOmZ+ORw2MTTE
         pUym/a/Igd9Q+om+tSeVA2JKCJGJF1MBUSm65BgeYWBJcd9vCYCX6Uuc60MzAMhCFRKq
         Jvm/UMjhaNepr2q9hGuQ5lpcB1bRiYHxBp/WBASt+aKPLAHydcmDjp2PxhlF97WhTGAK
         qW9hK9edLh4ISxDRBRc2CYGcUXevtgOpgkgg/YIC5rEgvViSwRvYGh9WpwGWtjUkdwpu
         0K4X2VbGTISG0XXmitT4Eq8wi0sFnbhnKidixgpFtKzH3/7QHuXgmCuD2scyKXoznu4M
         Ttcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=w5g4oZDQ6GForwu/7aSmjKGMfT2RLzJZuQ/ataAco1Q=;
        b=I3veyJm7GQ5vzBg4SfLOGBp7/WOzS/XCWbttCxevK0kdojIS6y6G8Zz65lXzNOud0e
         Fkry/6s9tk+uWmNtGJSG6X5AwaUjxVMjbFIo5IcN10Gxl2BvFWmY1oTQ4WCHqYNSxtSB
         8ov4FbXtkY4CIjXCg4GoueXcgTZcc3+y62ryIek2yTWkyi2hOlIIfcjhMkN/4twe5pxn
         SwwS8EMvFz6A4Oa8q4F2/k9cGTZEvvd0roydBlMD1z359+rFsKXCNDLTHEYq6nhqZJxE
         yfE2ND/CnVMUS1ktJVWlnbaGbvOeeLrVZMGFoBQUxwmaImCd1mzCcXRxpCpP+zZuGVxo
         SGcw==
X-Gm-Message-State: AOAM531wV4KbqsYxgq15pYA7smuHYt7c0CojhDTUgvsrcG7o94CtNQv6
        FgC6pVEnSfkNfNdeBccIDYm0LPDs028=
X-Google-Smtp-Source: ABdhPJx8P11XHSP6HuSxMb1U3CdKJPojGDqRkji2ErQg969sA+5QnsBtrWss7XmP2qu+bqvgIoU6zQ==
X-Received: by 2002:a17:906:b04f:: with SMTP id bj15mr64903941ejb.383.1609773437919;
        Mon, 04 Jan 2021 07:17:17 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id a2sm16565475ejt.46.2021.01.04.07.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 07:17:17 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/5] mailmap: switch to opaque struct
References: <20210103211849.2691287-1-sandals@crustytoothpaste.net>
 <20210103211849.2691287-3-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <20210103211849.2691287-3-sandals@crustytoothpaste.net>
Date:   Mon, 04 Jan 2021 16:17:16 +0100
Message-ID: <87ft3gviir.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 03 2021, brian m. carlson wrote:

> -void clear_mailmap(struct string_list *map)
> +void clear_mailmap(struct mailmap *mailmap)
>  {
> +	struct string_list *map = mailmap->mailmap;
>  	debug_mm("mailmap: clearing %d entries...\n", map->nr);

Re my comment on 1/5 wouldn't it make more sense to use the new API
here:

    -       debug_mm("mailmap: clearing %d entries...\n", map->nr);
    +       debug_mm("mailmap: clearing %u entries...\n", mailmap_entries(mailmap));

I changed %d to %u here, maybe we'd also want to do that earlier while
we're at it (not code you're changing):

    -       debug_mm("mailmap: removing entries for <%s>, with %d sub-entries\n",
    +       debug_mm("mailmap: removing entries for <%s>, with %u sub-entries\n",
