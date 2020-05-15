Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D80C433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 15:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6662220671
	for <git@archiver.kernel.org>; Fri, 15 May 2020 15:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpP6dff1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgEOPd0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 11:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726183AbgEOPd0 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 15 May 2020 11:33:26 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF76CC061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 08:33:25 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l11so4106647wru.0
        for <git@vger.kernel.org>; Fri, 15 May 2020 08:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7nNnUcBZdZoao/5Ck9FWE8QwHuz7pQm6Q4/QpkyBxOs=;
        b=WpP6dff1HsfSdFDJJmta+QxO4FX3nLZBrXHwsYrd4DgfrlbWEJ4+C1IizxoJdL7UBY
         kvjjPfceMa6/gZn7Re9VcVNLZvJegbUKt0Uhm9w8T4ZQDtLkZ77tq+7W/+WkuvAdTFG+
         TieUsfaMxiixMru6vmU+if2w+0hU9R0VgNhwKGhDrDtREpWVkxY7mLYMEFeBci1i7Z4+
         7XdeMSbxwxAwjLHyiFyLKVjOhxWsNR1+YGHucoFFnPVeIekB07iwSLLog+PPIaubvg5Q
         Vgbh5UaMb1oL7CZmLgK5WvwnZ7znx4cUjxRAd+WYIip/++hjhOwVSZl/AwH4XNsNdvlj
         +umg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7nNnUcBZdZoao/5Ck9FWE8QwHuz7pQm6Q4/QpkyBxOs=;
        b=AbTTPbyfuQGak8W+ww6b6/yWJwwVVB+bvFlsOZ5W/d2/UmOgKNhN1GIqBhaUV/PzF8
         hpxsghyyuZJJmhlDnAd+4Jwni6M4vCW4mt9ZB99PGJ3KZJTygd6RH+gbuR5Ah2qeMYvx
         JatPGMyrQZ3aebBPw1ImxghLtk3g86YvtfXl+vZy7sKnoeGlIQoaTB7If+YJy+nvtlxF
         hN0bFT5ivI9MiqLMaIan/8BMi/AJufXO4NUUf5pwTzG8+jtHXhM29DQmFm4XuasiftUH
         xvhWKNiF3nNf5w95CQCdBiEzsz+80xf785g0EswRhWly+Z6jO9c9hQP2SilkIE0GmVZU
         qrBw==
X-Gm-Message-State: AOAM5323/4w07zDGVX9hpg8ByIaezgzt7FH3J+/1a6ocM3yal01IMRIM
        pSF1FEWotTLeE0kuESo4ncM=
X-Google-Smtp-Source: ABdhPJxwcd+csMnehAQc23ha/HLyVlLWRy+ZWHqWmVXsMkPx2BgbOT2gA3zHNC7wdJFwAYh/vYQumw==
X-Received: by 2002:adf:ecc3:: with SMTP id s3mr5182923wro.301.1589556804659;
        Fri, 15 May 2020 08:33:24 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-654-1-314-129.w86-199.abo.wanadoo.fr. [86.199.201.129])
        by smtp.gmail.com with ESMTPSA id n13sm4124994wrs.2.2020.05.15.08.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 08:33:24 -0700 (PDT)
Subject: Re: [PATCH v5 10/12] tests: when run in Bash, annotate test failures
 with file name/line number
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
Cc:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
 <cover.1586538752.git.congdanhqx@gmail.com>
 <ce0038598704e03becc65731a71abf596bdfbe98.1586538752.git.congdanhqx@gmail.com>
 <5b373748-d986-1aec-670f-7ac1502e7052@gmail.com>
 <20200515152823.GA61200@Carlos-MBP>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <65ce572d-5afe-694d-1371-ac781bd2ab1f@gmail.com>
Date:   Fri, 15 May 2020 17:33:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20200515152823.GA61200@Carlos-MBP>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo,

Le 15/05/2020 à 17:28, Carlo Marcelo Arenas Belón a écrit :
> On Fri, May 15, 2020 at 03:16:38PM +0200, Alban Gruin wrote:
>>
>> This happens on my machine, as well as on github.
> 
> could you point me to a failed github report?, 
> 

Here you go:
https://github.com/agrn/git/runs/678028019?check_suite_focus=true

I hope you can read it you're logged in.

> also would the patch I posted
> earlier (better with the following on top) help?

Yes, it does, thank you!  I have a few comments about it, I'll send them
in a minute.

Cheers,
Alban

