Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE6D11F463
	for <e@80x24.org>; Thu, 26 Sep 2019 13:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfIZNgt (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 09:36:49 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41206 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfIZNgt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 09:36:49 -0400
Received: by mail-qk1-f194.google.com with SMTP id p10so1752905qkg.8
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 06:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PQc1EkREy542qBGfuQ9Y4sJJPjkPkeizV4nRCHzyk7U=;
        b=Qy4UxkszZoP7fnItxQLwXP9aubddvpZtyyjdL3dShXKoAgclGJ7k14yYnf6OOR57mc
         9QE0QPR7+a1wxqex0XGn6+gT/bs7KJmIA3OEBb4aXc+jIa4zlSpGGct3cLdsDKOuLS4V
         0293hav0RZZ7/7okt9y9D3ee7qKYtqfuvKKLUDKCvsFfsXxBQMXvS5mSj/jSPpz/1Dwc
         Nt3ZQhvrm93tUJl2z3PerVC5GDU+uf7DXq8uwH1aysANlFYK+q+lPKedrcruFrv0yIwU
         ZZnF8jkxLZrJTN4V/4tCD8SlrlrJ8JGnVjSYZeu72fKL2SzAVAKTBGOoO+Aa1KkQ9+0U
         UdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PQc1EkREy542qBGfuQ9Y4sJJPjkPkeizV4nRCHzyk7U=;
        b=MKAnEmkWK3Ot6353AfE9AxYrNVlPwc9rqUk3a/Rm3AWWYBJ+daoydfmSDmLwIjx1KE
         HdRpL4qXEXn1wRpxEtmTIFwQ+MN2n/Na5+fzePlgVw6V2J5aEV1OzDTlA598XUnkS1qi
         hSrmXWzTN7qt/zGUyyFsaGg6p5eigM/PZqglH/tbWzN4dZU8IEF5AasOLtAirEpMx5Ud
         z95pNsB3tL5x/KdFVb0AjPbShaRkOJcKCdLRimR1hV+TotlElayMgNNQEE3uTAM7Gn7N
         D4Qv1f+eBVi/dwVD7enbPltl2oheDQam7Zz+xNjzrELrRNMU+KOg7pyeHRy2TQQiQDPx
         1QBQ==
X-Gm-Message-State: APjAAAV1RKjzQq7xAF6RdLTFbFWozVPbZ2wOYdWPCYbrjVt4OkK0EZsE
        nbVVoOiYeT0o19BJLQT/Or1UjucPi7w=
X-Google-Smtp-Source: APXvYqwqgyHI7JHzgyQRLr3GFK29Mhf8tCa5WcM/yC7G1Vtwa6X5NLKDk/1YpjLbvCSHp89O9jY0ig==
X-Received: by 2002:a37:6291:: with SMTP id w139mr3340294qkb.268.1569505008610;
        Thu, 26 Sep 2019 06:36:48 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:b594:20f6:c10f:d45d? ([2001:4898:a800:1012:66c8:20f6:c10f:d45d])
        by smtp.gmail.com with ESMTPSA id x19sm993981qkf.26.2019.09.26.06.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 06:36:47 -0700 (PDT)
Subject: Re: sizeof(var) vs sizeof(type), was Re: [PATCH] git: use COPY_ARRAY
 and MOVE_ARRAY in handle_alias()
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <d5eef24a-faa8-d6f3-c9e5-f13dc40219d4@web.de>
 <20190923222659.GA22645@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1909261521380.15067@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b79f52f7-4a7e-f7cd-ed8a-cb6cfbadd7b2@gmail.com>
Date:   Thu, 26 Sep 2019 09:36:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1909261521380.15067@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/26/2019 9:22 AM, Johannes Schindelin wrote:
> Hi Peff,
> 
> On Mon, 23 Sep 2019, Jeff King wrote:
> 
>> On Thu, Sep 19, 2019 at 10:48:30PM +0200, René Scharfe wrote:
>>
>>> Use the macro COPY_ARRAY to copy array elements and MOVE_ARRAY to do the
>>> same for moving them backwards in an array with potential overlap.  The
>>> result is shorter and safer, as it infers the element type automatically
>>> and does a (very) basic type compatibility check for its first two
>>> arguments.
>>>
>>> These cases were missed by Coccinelle and contrib/coccinelle/array.cocci
>>> because the type of the elements is "const char *", not "char *", and
>>> the rules in the semantic patch cautiously insist on the sizeof operator
>>> being used on exactly the same type to avoid generating transformations
>>> that introduce subtle bugs into tricky code.
>>
>> Another good reason to use "sizeof(var)" instead of sizeof(type)". :)
> 
> That is indeed a very good reason, in addition to getting the type right
> automatically (by virtue of letting the compiler pick it).
> 
> Should we make this an explicit guideline in our documentation?

Better yet: can we create a Coccinelle script to fix it automatically?

-Stolee

