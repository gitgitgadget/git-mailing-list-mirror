Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8007FC433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 13:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB13206B2
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 13:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Atciv9CG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgHLN7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgHLN7v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 09:59:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30707C061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 06:59:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l2so2132091wrc.7
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 06:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jsHU0mJ0dEC5S++ePbFOfCNTCh4M0U3BULOQdP3XdrA=;
        b=Atciv9CGFffSp1taT46txkGcbUUfQMd5goe0kQ7qU83l1yAnf3avOGt5xWViTHZrpG
         s5jcVRrGxN5tO1JB58LlxaAiZ4nJSTN50nFWtl6Dt0HHciG2n0ZVgVSa+oyOOexV6YZl
         YjuVYSfsvdfOrIeqSQEmzGXmRRVMzqDf3hg0n67FLUFU+60jB+8CqPUK2PgRNtbn3Q8s
         f9sdP+tatP1eodQ5y22/Q+jvinOb5UX7cn9cns9VVaocnNUCTFqPQRKcjum+W9VYrpvK
         LfywGfvzBOU9vVRgFfnoB/JpANNtc9SNRbAgOhUDObsaWItQ5Ehk6dWT1htzbFiOSIKW
         9dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jsHU0mJ0dEC5S++ePbFOfCNTCh4M0U3BULOQdP3XdrA=;
        b=K0szUUCbNv+H7CWDB6WzZ7fSNkZsd/sYA/XiVZyC23ynjFh0C6+VYnVJQX8MWKwkIS
         l6dbIV3WmMw3U2A6JYxUhR6rXHTHl0b3LJV6A2glwLSeBl9n5ZkFfHQCiLsMnoqIKnFH
         U+EiONmtKZPvLmufFcY53TKNwsYRYzVjQA4X39tiU2rvVoT07oQglcLxpIKkeyv9L12F
         p03X06BH1Xwa7V24+vmhEu/RSjcwB6Hs1nSp31gKFCjmzhkFIDSPLiipqUFeNQlnO9YZ
         4uB6g+cCAQt0n/eHJbsUU7r2ynhHRnE4RrrD1FW3ox7drhaHftoFtwW79OxmiAyX48zJ
         6TGQ==
X-Gm-Message-State: AOAM533FRPlnAPDEvD1DQFruMG4hiwwWQ1BVFCZSQuE8OLkoDm1fWWYQ
        f2Um0MYw9X4O1x3v5srgpYM=
X-Google-Smtp-Source: ABdhPJyrVJXWjGjjecixBnBKK9c7ElMUp8NkD/HjKavSPMZyeSOEeeXQhwlTL+cKshxE94HsCKFsNA==
X-Received: by 2002:a5d:540c:: with SMTP id g12mr33115567wrv.120.1597240789909;
        Wed, 12 Aug 2020 06:59:49 -0700 (PDT)
Received: from [192.168.1.240] (192.252.189.80.dyn.plus.net. [80.189.252.192])
        by smtp.gmail.com with ESMTPSA id b2sm3655711wmj.47.2020.08.12.06.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 06:59:49 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: Fix possibly wrong onto hash in todo
To:     =?UTF-8?Q?Antti_Ker=c3=a4nen?= <antti@keraset.fi>,
        Taylor Blau <me@ttaylorr.com>
Cc:     phillip.wood@dunelm.org.uk,
        =?UTF-8?Q?Antti_Ker=c3=a4nen?= <detegr@rbx.email>,
        git@vger.kernel.org,
        =?UTF-8?Q?Jussi_Ker=c3=a4nen?= <jussike@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20200811131313.3349582-1-detegr@rbx.email>
 <ebdc0bc7-f48e-9f38-328d-b1181ac974d7@gmail.com>
 <20200811153621.GD19871@syl.lan>
 <20200811181537.qt7jkoxy7qn3k7mo@haukka.localdomain>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <eb3ecbc0-84aa-70fa-1893-3b16b21989a8@gmail.com>
Date:   Wed, 12 Aug 2020 14:59:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200811181537.qt7jkoxy7qn3k7mo@haukka.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Antti

On 11/08/2020 19:15, Antti Keränen wrote:
> Hi Phillip and Taylor.
> 
> On Tue, Aug 11, 2020 at 04:32:37PM +0100, Phillip Wood wrote:
>>> I'm not sure it's worth rearranging these lines. It probably does not matter
>>> but we could do
>>>
>>> +	char shortonto[GIT_MAX_HEXSZ + 1];
>>>
>>> and then later call find_unique_abbrev_r() instead so we don't have to worry
>>> about freeing shortonto.
> 
> I like this. I'll change the code, if the rest of the patch is okay.

Thanks great

Thanks

Phillip

> 
>>> Thanks for taking the trouble to add a test, I think all the lines above
>>> could be simplified to
>>>
>>> 	GIT_SEQUENCE_EDITOR=cat git rebase -i HEAD~5 branch1 >actual
> 
> Nice! :) There was a test called 'todo count' which I mimicked. This
> obviously is much cleaner solution, thanks.
> 
>>> we could lose the final .*
> 
> Ack.
> 
> On Tue, Aug 11, 2020 at 11:36:21AM -0400, Taylor Blau wrote:
>> Ack, I noticed this too during my review, but apparently forgot to
>> comment on it. I'm puzzled by the first '..*'. If you're searching for
>> any non-empty string, how about '.+' instead?
> 
> That's true. Good point. I pretty much copy&pasted the 'todo count' test
> so I didn't give this much thought. I'll fix this.
> 
