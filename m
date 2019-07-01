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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A9801F461
	for <e@80x24.org>; Mon,  1 Jul 2019 12:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfGAM02 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 08:26:28 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39579 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGAM02 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 08:26:28 -0400
Received: by mail-qt1-f195.google.com with SMTP id i34so14357215qta.6
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 05:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JJO886U89jMlTbAFhvCp1PxByfF7iMUJ/OrsbSaYMfc=;
        b=PMq1kfgHwZGcsqRTvHf7HjCyHKQkFvY9f1MikxkViPsLyV2a93YCKnKtU7EFWiMQrz
         y79d9m6QicPUxjoZ2rc1TWtg2M6ZKq91vyM984GMvjLqUGA1Y62SjS74yDDR0twD6lS8
         7RHMcNq5BlTT6H8huZFqNctLB18uegSyfGmH1+VM+WXyRg2I2quVa6OpF/QvytkWKaho
         D66bceABiAVTg8NEOGykWFdRSbgdlsKj/9B9Mb4k/9m4igUyn4UsKJJwLyt5iFnMbnXo
         US3soMThQ+XENqH3mXHXALLZToGRHSjxtBH5C8fNrBXfdUVu83rPyOJ+LT1aZP5h7ixo
         YRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JJO886U89jMlTbAFhvCp1PxByfF7iMUJ/OrsbSaYMfc=;
        b=RuMOv2VtUMB2+n9eujoWZGPDdEbJP7yeqmt6mb6JLSqGlN0LkIjMxAnLG3jcrCkdp6
         SalketW4JL69Vq20hoMA5g4fL25DJJ8aP0ovZhF762bEpm8qRLFSHkS1XVPx3Ecgi9sC
         tOBVJtQo/GB5h3CzJLF0fOwdOjzUpG0To8g+ytmVDBA6VoeqHe5xCdQohnEt5lHEKM6d
         d0dxmTVCUu5Lf45Ba5g64jY+gXO5QpWR1GyZYtLoNgRwTvHlh+LlJ9tFmfuXULiV1S7v
         9zr5VRUVjKbuedwYViZ6jV01lM+hV0SwBb4mnXZJfan/pH23zssJFzoDoArgBMHrddEs
         Y3uQ==
X-Gm-Message-State: APjAAAVlLwFGFX6/lVoRnm6Y50a9W6KqmbxJXxYw62JxmY/QsulWsKnC
        IGgp4PrpFOwA5OHgQcPskMs=
X-Google-Smtp-Source: APXvYqwtWO/evbipRnxQ8nZfbkkl7cOL1Lgbaq9pbymGMrsUHU0u08Aw1wBGnCRKV7Q07Zup45wlXQ==
X-Received: by 2002:ac8:3f81:: with SMTP id d1mr20441425qtk.5.1561983987657;
        Mon, 01 Jul 2019 05:26:27 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:8d39:716e:a6fa:35c4? ([2001:4898:a800:1012:3e6d:716e:a6fa:35c4])
        by smtp.gmail.com with ESMTPSA id h40sm5499433qth.4.2019.07.01.05.26.26
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 05:26:27 -0700 (PDT)
Subject: Re: [PATCH] check_everything_connected: assume alternate ref tips are
 valid
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
References: <20190628101131.GA22862@sigill.intra.peff.net>
 <xmqqpnmx8ysf.fsf@gitster-ct.c.googlers.com>
 <20190629075536.GB5080@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5c38cb79-bc04-db10-12b9-7e4f83f836c4@gmail.com>
Date:   Mon, 1 Jul 2019 08:26:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190629075536.GB5080@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/29/2019 3:55 AM, Jeff King wrote:
> On Fri, Jun 28, 2019 at 09:22:56AM -0700, Junio C Hamano wrote:
> 
>>>  	argv_array_push(&rev_list.args, "--quiet");
>>> +	argv_array_push(&rev_list.args, "--alternate-refs");
>>>  	if (opt->progress)
>>>  		argv_array_pushf(&rev_list.args, "--progress=%s",
>>>  				 _("Checking connectivity"));
>>
>> Quite honestly, I am very surprised that we did not do this.  The
>> idea of alternate object store, as well as reducing transfer cost by
>> advertising their tips as '.have' phony refs, is almost as old as
>> the pack protocol itself.
> 
> Yeah, as you note we are already telling the other side of the push
> "hey, we already have these objects". So we are almost always just
> walking over our own local objects in the connectivity check, which is
> silly.
> 
> I only did "clone --reference" in the perf test because it was the
> simplest, but a push to a server with alternates should be similarly
> improved. E.g., doing this in a clone of linux.git:
> 
>   git init --bare dst.git
>   echo '../../.git/objects' >dst.git/objects/info/alternates
>   time git push dst.git HEAD
> 
> goes from 40+ seconds to 100ms or so. Again, obviously that's the best
> case, but it should also improve the normal case of somebody pulling
> down "torvalds/linux.git" and pushing it back up to their own
> "peff/linux.git", too.
> 
> I don't have real-world numbers yet from GitHub, because we're not
> actually advertising .haves on push right now. All of the Git pieces are
> now in places to do so, but we still have to make some tweaks at our
> replication layer. But soon. :)

Exciting! Should improve the user's experience keeping their forks
updated!

-Stolee
