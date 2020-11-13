Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6758CC55ABD
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 16:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06BBA208D5
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 16:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8E6pzY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgKMQGh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 11:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgKMQGf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 11:06:35 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF85C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 08:06:35 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p22so8554504wmg.3
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 08:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XK/HO55hIZKj2h0/yeZz2mLQvQ7JeX7cef/OoSw7d7Y=;
        b=g8E6pzY11obSEQVrCt+P3E/Z2GSwioT9nU8MfFrBBaOYdD3QiMUrZtLIuXPqXjWPLL
         HkFZyiU7qhqO39JVjGph+MMQrtCj4PpmqADIGKB1Ge0GTTeBFLgLD4j3CuVI8P7lALYq
         z82++RiLGA/c7V+R457EblgZ9ZBuJbMzLpTjZV1hXsvthaPaNRwj0kLdWzniN9gVrkDI
         aQxj9IZ9xoLBk6RFCbLbuWRWzOw30u2IptlqfbRzTk7FHybVcsMQRbYyebYbd5mP5BQn
         lSUZU/QACWf0f+1BJ8GmzQjoUCuXQD+Z5X7qLLtyTDrZLq/pa+3HJc4Mt/KlM+JZoolu
         hs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XK/HO55hIZKj2h0/yeZz2mLQvQ7JeX7cef/OoSw7d7Y=;
        b=huHgZkAmLPfI1xo3T8nhd1bdpm1vh3i4g88xyajQr7GVzVOOz4zRvuBhS5wZ2uNpw9
         PFu0+Ntx2yr1XGrqHX4t/YBrZclGj4nJT+fHE+78+kuFABkRIJkRsXqafmkwrQxVMZvk
         /hlHinDf7vriOuyHxUmt78R8X3bIkO3UiMLhqaH2f4osYk3/N8JFk8wI8j511QHKmufw
         ZowHg5Jnk+4Kwz6jRwqbmR8rO4YD/UKv3IOlvKu7v9JcHTXG1fmjPuJuicZHwKmM5muN
         IqGv58oL+XRUuxrnPMQvHL5WHBbE90eV7ZePWvimS8Q0D3Yd5PS+h4Q+94hcEsqzgBIF
         GqFA==
X-Gm-Message-State: AOAM5314HfrFL+bpkoZuy1THm/WNafTFdJ+PDAk63/ENOQ1zvN8+dJP7
        F6wFsyLvrpAUGmfcxHCyATk=
X-Google-Smtp-Source: ABdhPJwsEdOSt2xR0EnXENV4qdZBU+8ivSaGcwiF1Oe1bMlj1GsJBUQ+QMs/hsvIx4K2sU4yNVcWpw==
X-Received: by 2002:a7b:c845:: with SMTP id c5mr3180376wml.135.1605283589338;
        Fri, 13 Nov 2020 08:06:29 -0800 (PST)
Received: from [192.168.1.240] (194.55.7.51.dyn.plus.net. [51.7.55.194])
        by smtp.gmail.com with ESMTPSA id 6sm3858885wrn.72.2020.11.13.08.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 08:06:28 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 07/11] add -p (built-in): do not color the progress
 indicator separately
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
 <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
 <73b6d60a801766605cde9403d7a9e8451ef99e11.1605097704.git.gitgitgadget@gmail.com>
 <918a0a1d-6384-5615-c343-1f03046770f7@gmail.com>
 <nycvar.QRO.7.76.6.2011131455460.18437@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <d0603db3-a6d8-d71b-1ee0-4c5c51b00da2@gmail.com>
Date:   Fri, 13 Nov 2020 16:06:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2011131455460.18437@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 13/11/2020 13:57, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Fri, 13 Nov 2020, Phillip Wood wrote:
> 
>> On 11/11/2020 12:28, Johannes Schindelin via GitGitGadget wrote:
>>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>>
>>> The Perl version of this command colors the progress indicator and the
>>> prompt message in one go, let's do the same in the built-in version.
>>
>> Why? the C version has access to an api that means we don't have to remember
>> to print the reset string each time so why move away from that? I don't think
>> it matters to the user that there are some extra escape codes in the prompt of
>> the C version. The answer is probably "so we can use the same test as the perl
>> version" which might be a good reason - if it is I think it would be helpful
>> to say so in the commit message.
> 
> Honestly, the number one reason is so that the _same_ test passes using
> the Perl version as well as with the built-in version, something that is
> required by the `linux-clang` job in our CI build.

That's what I assumed - it would be good to document that in the commit 
message.

> I am not really willing to change this, unless I hear a goooood reason to
> complicate the test.

I guess we could change the perl version to match the C version as it is 
the perl version that will be retired but I'm not that fussed

Best Wishes

Phillip


> Ciao,
> Dscho
> 
