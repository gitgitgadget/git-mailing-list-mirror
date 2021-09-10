Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842ABC433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 17:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B7CE611BD
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 17:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhIJRnd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 13:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhIJRnd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 13:43:33 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E33C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 10:42:21 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id me10so5755504ejb.11
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 10:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=U/8PnlHWGGI8FpHH3t6qNHso47qXyE93iifb+ySWBZY=;
        b=BMvxrcoUrUHQcPwxhgkVJCAvQ3cbv2otDbrRGLyfosU6UzhAgq7vMVO2tnr50AY54v
         PKcg4zYSldn6tcpoKJGbDQHb6MfUWQCaGp8goYnU8aCI8oYPMp/ekE7HOloc0Psk0lOT
         eBY+MWeqjQK/XANuwAKUuCVNMDohky08EC0dNLz9soW5kbWW62T67KYiVAyoaTf2TSAw
         5ToOO1/hUIVwMCwvJmIslzNvpiKZ8TaYAz7xIZYwoaRmVWzQKat2S2w6ke7O4A22k+PE
         KS9FD4xsHBTDocCN0q9Cv6QusbeBK00bjbKLTkKOriHuCDkZJmyvvEbyD2XHYpj4VEnl
         0vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=U/8PnlHWGGI8FpHH3t6qNHso47qXyE93iifb+ySWBZY=;
        b=q8vyvoulkSM7RuoKv8d9qDcKwDFTbjWUhAL0UgyfVDXL2lyuBtMB/YAo/mvPsGi88g
         rE5228CHUsCWSrEmJ/2CzoDoXPgWNPe28V3wdUzje/xpvmqDXX1H2xQamFKOolbbzFUO
         wTW351ySzSy6a9MhieXxJN54hKtq4/XeIe9SYR4xxgFdPz1rnJyWDpEW2o/YmK705iDV
         WG0OR02cYxItEdYnAzWZa1RlwfiB8jbctvpNtDlhqMpInKYbUgi8D9CFMVnaNVxTxlSr
         DGTHJ0SPmurT2EEYxsI1hdvuJeJIa8757jOesEuHXgr5GxYB4dl5jV/vS/Gjcc3mWpXV
         VFhw==
X-Gm-Message-State: AOAM532GsixEGbvr4Bhg6K3hBsp3N7uBA6F5BVMtKQk5hdgi2DJmxtp8
        NbPMfh6mllObpfTX8TkpP9E=
X-Google-Smtp-Source: ABdhPJxqdvDS0VUqHRtThbEskXj+7vKRLjRHEQ67ua+Jype43VMn0ROrn0JjJ73Hs+MUSqgcclF/Ww==
X-Received: by 2002:a17:906:144b:: with SMTP id q11mr10736182ejc.78.1631295740331;
        Fri, 10 Sep 2021 10:42:20 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w25sm3256381edi.22.2021.09.10.10.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 10:42:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Daniel Stenberg <daniel@haxx.se>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 5/8] http: correct version check for CURL_HTTP_VERSION_2
Date:   Fri, 10 Sep 2021 19:19:29 +0200
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
 <patch-v2-5.8-2567b888c3d-20210910T105523Z-avarab@gmail.com>
 <YTt1RLty0KDEAio1@coredump.intra.peff.net>
 <nycvar.QRO.7.76.2109101713110.2614@fvyyl>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <nycvar.QRO.7.76.2109101713110.2614@fvyyl>
Message-ID: <8735qccop0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 10 2021, Daniel Stenberg wrote:

> On Fri, 10 Sep 2021, Jeff King wrote:
>
>>> The newest symbol we depend on is CURL_HTTP_VERSION_2. It was added
>>> in 7.33.0, but the CURL_HTTP_VERSION_2 alias we used was added in
>>> 7.47.0. So we could support an even older version here, but let's
>>> just correct the checked version.
>>
>> Thanks for expanding on the history here. I agree it probably
>> doesn't matter much between the two versions, as they're both 6+
>> years old (and only about 6 months apart). If somebody has a case
>> where it really matters, they can submit a patch.
>
> Forgive me for digressing a bit here but wow, I *so* appreciate your
> digging into the details of the curl history and the symbols that were
> introduced when etc. I know of no other libcurl-using project with
> this eye and sense for historic details and as the lead maintainer of
> libcurl I learn a lot here. It also keeps me motivated to provide this
> documentation and work on keeping in accurate.
>
> Keep it up! <3

Thanks! And thanks for curl.

For what it's worth I found myself looking for some bidirectional API
mapping between these option IDs and their names, we tend to prefer that
sort of pattern in git.git to macros, since we can test that something
compiles everywhere, run tests without the feature without recompiling
etc.

I found that curl didn't have anything like that & started writing up a
feature request for it, only to find that my curl.git checkout had been
on an older commit, and that you'd added that API last year in curl.git
6ebe63fac (options: API for meta-data about easy options, 2020-08-26):

    https://curl.se/libcurl/c/curl_easy_option_by_name.html

It's probably not something we can use in the next 10 years, but if
whatever the most ancient OS we support upgrades past it it should make
dealing with the version-specific code in http.c even easier.
