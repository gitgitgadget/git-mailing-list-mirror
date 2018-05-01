Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08FB421841
	for <e@80x24.org>; Tue,  1 May 2018 11:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754742AbeEAL1V (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 07:27:21 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33294 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753993AbeEAL1U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 07:27:20 -0400
Received: by mail-wm0-f42.google.com with SMTP id x12so14597431wmc.0
        for <git@vger.kernel.org>; Tue, 01 May 2018 04:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ALfoEMErNzM8tdlGN9ra245RWO07CPEczomBId0hPgs=;
        b=KekeZYtn4R/Lgei2gG9u6l5L9JKmoztgT531l/rVK9efG6wg7X4EN/n8ob7uG61dDV
         3ogbak2DEbbgaojHzyIStW9tSqHnGMgprKn3CJLArFiM+IfZ0Bqe7AkWbI0dEas37HQ4
         mWN/BeMgsS4FAW5qceeVWvaanmTCJMC35v8Q+XC4IINeBzg0DugomqCEeHZTzdF+Papl
         YW8dr+QlxQ1vXRYmxHx40V0D7PXRqWFN5npClMeemlQoLvl/bwNVC0bW9EeJhpXxhyql
         R8V2K3IeTLdXlGyRxmbQAjJfuJaBSUsR/GSjb3Pe4D1kf2dz+E4PEWhxrJA8gp5VKd3U
         up6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ALfoEMErNzM8tdlGN9ra245RWO07CPEczomBId0hPgs=;
        b=uJLu2L6X8quBGNDmeuaj0sKsjvWvlkLYPsNgS83mDYBJcHFM2AVBLJkrlmanspvYk5
         xEsyZ3WcfGfeJZ4+NlJmtNwGRR3Lh9HtD17MlgaOoPCfb6MLBm8KBrtO3g7dT7poOIC8
         RKM1yCnPaOYet0yjK44XkPziy/2e5nMBsovykZUdVCJ1Ms6ecaIeDRZ23vkrgs7XZQC/
         ACA4Dhijyl1cNH/WF0qo1kPfhaZto0eG49el1wr/ul/AbVfpHybWqmHrphwva6QBktOr
         w7cYZnBcimaj0vaggl74w/1/iEz/8cN1i6QG7z6IdbacYzei7yqugCgnQ682ADP6r744
         RYKw==
X-Gm-Message-State: ALQs6tDdt+S7KaXj/OugBsN9e5wkjX5+wDj/5baLyWKdtbexr2e9oQ3z
        3m+KQI8YjAw+wXa3v1xS65Y=
X-Google-Smtp-Source: AB8JxZrTMV4Izwx4lk6CQVDXSmn1J7eC7PVzx6ALrFdkEqkbnw7Q0UErvZfE7UE9j3tVypW2SDhlog==
X-Received: by 2002:a50:eb94:: with SMTP id y20-v6mr20246955edr.185.1525174038924;
        Tue, 01 May 2018 04:27:18 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id f5-v6sm5644808edb.86.2018.05.01.04.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 04:27:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 4/9] get_short_oid: sort ambiguous objects by type, then SHA-1
References: <20180430220734.30133-1-avarab@gmail.com> <20180430220734.30133-5-avarab@gmail.com> <5f8b1ec1-258d-1acc-133e-a7c248b4083e@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <5f8b1ec1-258d-1acc-133e-a7c248b4083e@gmail.com>
Date:   Tue, 01 May 2018 13:27:17 +0200
Message-ID: <87a7tjzkdm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 01 2018, Derrick Stolee wrote:

> On 4/30/2018 6:07 PM, Ævar Arnfjörð Bjarmason wrote:
>> Since we show the commit data in the output that's nicely aligned once
>> we sort by object type. The decision to show tags before commits is
>> pretty arbitrary, but it's much less likely that we'll display a tag,
>> so if there is one it makes sense to show it first.
>
> Here's a non-arbitrary reason: the object types are ordered
> topologically (ignoring self-references):
>
> tag -> commit, tree, blob
> commit -> tree
> tree -> blob

Thanks. I'll add a patch with that comment to v2.

>> @@ -421,7 +451,12 @@ static int get_short_oid(const char *name, int len, struct object_id *oid,
>>   			ds.fn = NULL;
>>     		advise(_("The candidates are:"));
>> -		for_each_abbrev(ds.hex_pfx, show_ambiguous_object, &ds);
>> +		for_each_abbrev(ds.hex_pfx, collect_ambiguous, &collect);
>> +		QSORT(collect.oid, collect.nr, sort_ambiguous);
>
> I was wondering how the old code sorted by SHA even when the ambiguous
> objects were loaded from different sources (multiple pack-files, loose
> objects). Turns out that for_each_abbrev() does its own sort after
> collecting the SHAs and then calls the given function pointer only
> once per distinct object. This avoids multiple instances of the same
> object, which may appear multiple times across pack-files.
>
> I only ask because now we are doing two sorts. I wonder if it would be
> more elegant to provide your sorting algorithm to for_each_abbrev()
> and let it call show_ambiguous_object as before.
>
> Another question is if we should use this sort generally for all calls
> to for_each_abbrev(). The only other case I see is in
> builtin/revparse.c.

When preparing v2 I realized how confusing this was, so I'd added this
to the commit message of my WIP re-roll which should explain this:

    A note on the implementation: I started out with something much
    simpler which just replaced oid_array_sort() in sha1-array.c with a
    custom sort function before calling oid_array_for_each_unique(). But
    then dumbly noticed that it doesn't work because the output function
    was tangled up with the code added in fad6b9e590 ("for_each_abbrev:
    drop duplicate objects", 2016-09-26) to ensure we don't display
    duplicate objects.
    
    That's why we're doing two passes here, first we need to sort the list
    and de-duplicate the objects, then sort them in our custom order, and
    finally output them without re-sorting them. I suppose we could also
    make oid_array_for_each_unique() maintain a hashmap of emitted
    objects, but that would increase its memory profile and wouldn't be
    worth the complexity for this one-off use-case,
    oid_array_for_each_unique() is used in many other places.
