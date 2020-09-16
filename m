Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22BAC433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 09:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EDE5206B7
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 09:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4f/JXCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgIPJpx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 05:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgIPJpv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 05:45:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F35EC06174A
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 02:45:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w5so6175148wrp.8
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 02:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RFchD6QKBqbGg2/qYPl+T26JXrwroKmro5xPJNt+RKM=;
        b=U4f/JXCRxQ7g4InV0rvMa54HxhNR5AvdePvZR48+ER7403I/Gist45Mq15V3XFhk6x
         iyUcybNmSkFxXnch137mKCxH8d7BDSOR2YoPmkzkIojFlQCh4EjXtOn2duNnXbzO+Les
         xvB7FUs87DbbqA0C7EGHU3GuUCWlvw0Y5G/wWOYBMoX7fRN88edQGU6/uRpRHHw8a6g+
         1nvJ+2xI52VVJfUba3vSE2gaIRSRyQHu44GvQ19kodjKGEyoTLBBgMf+8xohYisSRfOB
         I9BoWqbka92h6kI2mkRtsQ4s6tKqeYyGTrSq5MVaQtLZIkQRLiJSj9W6re53eCAWvbUA
         rF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RFchD6QKBqbGg2/qYPl+T26JXrwroKmro5xPJNt+RKM=;
        b=JcTc90ayRdqey+/xMy8c8Xeq+wcfnicAG2JjeqIERrisv645e8yxb7rQJRxmcyclej
         O5TUzCCLMvEtYzyZKFtJT6LUfpdDkFMjne/w7RD37QG5HqtBfdsVb4xNwEKEWFU2TMtC
         Y8EmF9J6hQjDm77hApEom2HtJZnoVnVR0tSuM3pYfgjS2p5gka5TDMbP/6L2s8EwwbH7
         +oUZ/RGWq9D+5A6ZbLxYkEVGOMFzEyzLAbzRKI4bDprvkOcyrHvwUYClh3IsruuwclOZ
         EqCNAkMqlWugmg6jSptZt+sTPANiODASDBjiyDvB71iUdZ8ZgZR/B5qkxaY+ZEqFiY5P
         yjeA==
X-Gm-Message-State: AOAM532PjcRBA2qqIZpqdlsE8JczNJnNOEGbbI9syDHKr/40yqPLsANG
        EwOE1Uf+l97k+fgY1TUN41DGN22QZ9Y=
X-Google-Smtp-Source: ABdhPJyjDyFyQ6+fpu4ZKOalTI5gmlN9DDg0spxDh6cQB6XfZKZD1HYpKvI0EfP8Xiobpx37/rJ7Gw==
X-Received: by 2002:adf:dd88:: with SMTP id x8mr16582261wrl.54.1600249548863;
        Wed, 16 Sep 2020 02:45:48 -0700 (PDT)
Received: from [192.168.1.240] (79.35.7.51.dyn.plus.net. [51.7.35.79])
        by smtp.gmail.com with ESMTPSA id m185sm4524187wmf.5.2020.09.16.02.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 02:45:47 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Git in Outreachy?
To:     Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2009020558550.56@tvgsbejvaqbjf.bet>
 <CAP8UFD31B9YgninC2Fyb=0+OVY7E4SW7LGBbx9E7CrgSn+95BA@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0244caba-8075-e742-9c05-55c320aef64e@gmail.com>
Date:   Wed, 16 Sep 2020 10:45:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD31B9YgninC2Fyb=0+OVY7E4SW7LGBbx9E7CrgSn+95BA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/09/2020 10:01, Christian Couder wrote:
> Hi Dscho,
> 
> On Wed, Sep 2, 2020 at 10:50 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> 
>> As to projects, I would like to believe that
>> https://github.com/gitgitgadget/git/issues has grown into a useful
>> resource.
> 
> Thanks for the useful resource!
> 
> I would be interested in mentoring, or better co-mentoring, the
> following projects:
> 
> - Accelerate rename detection and range-diff
> (https://github.com/gitgitgadget/git/issues/519): ideally I would
> co-mentor with someone a bit familiar with the suggested algorithms.
> - Add support for drop!/reword! commits to `git rebase -i`
> (https://github.com/gitgitgadget/git/issues/259,
> https://public-inbox.org/git/alpine.DEB.2.21.1.1710151754070.40514@virtualbox/)

I've got some patches that implement the reword! part (or something very 
similar) at [1]. I've never ended up using them that much so haven't 
pushed them forward.

Best Wishes

Phillip

[1] https://github.com/phillipwood/git/commits/wip/rebase-amend

> - Invent a way to retain reflogs for a while after the ref was deleted
> (https://github.com/gitgitgadget/git/issues/236): I guess this might
> be implemented as part of the new `git maintenance` builtin.
> 
> Best,
> Christian.
> 
