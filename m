Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81345C433EF
	for <git@archiver.kernel.org>; Mon,  4 Jul 2022 12:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiGDM4c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 08:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiGDM4b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 08:56:31 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E713B4
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 05:56:30 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id l24so8532736ion.13
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 05:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mfMhjKINi4xCZt/RB5tZXhuFUmMYKXELUobJsrn6/Bo=;
        b=RtgMkVz1V+//UZ4oi9uuUrOAlVxXI2bY5/3o4z1/N8NMBeIb2x7CZzWd9nYPJ/cglh
         6lpGqYAF7N+voqvFDfaZnIlEI5AagwCX8Mi3tie+wrZZkFOrwLXEtAFPDvd/p4lUg4XH
         3sIxR6XTXVIM6Zn8q/Vwh7f/oz3BffyYmSef87uj7nwNoLTuP8DZrh5TvbT+twrzi3Y7
         LWyR3HmgBk5PVB2Q6+/u5YI1LwzE+9sPwMsNoGjAmre25jX6h3bq/T23mRVO9TUKAizW
         XOVYQ/+mOGPXVCw/HLErRLFdhBASOmtizl6gkk/n1XQGT4TttPDZdvk0unrg4PvhQ+vP
         9f+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mfMhjKINi4xCZt/RB5tZXhuFUmMYKXELUobJsrn6/Bo=;
        b=HH68eKBV3LTDIezGPEassbNgPuiYalY0oFB7n4i+G39h/Ekb1IcMZZbHszhfhX60Lm
         192sfyiNUesEVvxj/5+nbrBB7FxdsP2v9deywlAmv3OFR4nsuL7XzNzqCWW1gzjur3Db
         zKUMnj4zJ4yiUeiuFdlp9kOuHF53nPweaYFRtd1rU0TFbC1v5hZPUhVzBQCXOjodfHwf
         S6FOhEEgkJ69UgxcgQ43Iz1egxBqAouZVZRsqegINJNAw7LfaYfZRLKFNHq9x8UMDWkj
         JgBMXn3HMV7iFzbEdb7EgSzBbELEVm/25J2YVp90qygA5jF/puuQHWRQTL9hgycAdlUC
         rxlg==
X-Gm-Message-State: AJIora9VA7NITE9VKaYctb56CzPb4M1vnkywhYvS1dvkLMi2/dG7AtTm
        IR18/2eDCU00ipd9emzrAKIj
X-Google-Smtp-Source: AGRyM1v5it/WBt75J5gBXc4BnSs+eBas/ZR8G0ORJj4yxMsL2OtnonemaY/9SMnYQ69CAx/jS2OLQA==
X-Received: by 2002:a02:9f17:0:b0:339:ed5d:c3e1 with SMTP id z23-20020a029f17000000b00339ed5dc3e1mr18656608jal.270.1656939389950;
        Mon, 04 Jul 2022 05:56:29 -0700 (PDT)
Received: from [192.168.103.184] ([4.1.157.141])
        by smtp.gmail.com with ESMTPSA id q12-20020a92d40c000000b002db01356d36sm3701395ilm.12.2022.07.04.05.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 05:56:29 -0700 (PDT)
Message-ID: <7dd69bb1-8bc7-3ae9-6265-bdba660b4c4a@github.com>
Date:   Mon, 4 Jul 2022 06:56:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v3 6/8] rebase: add --update-refs option
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <918b398d6a2264a99acadd319f780c796bbafc18.1656422759.git.gitgitgadget@gmail.com>
 <CABPp-BFqLP51q9RkJr=16+Aqq7R=tYqL5mZGUq-dvfn8LL2AMQ@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BFqLP51q9RkJr=16+Aqq7R=tYqL5mZGUq-dvfn8LL2AMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/1/22 3:20 PM, Elijah Newren wrote:
>> +/*
>> + * For each 'pick' command, find out if the commit has a decoration in
> Is this really limited to picks?  If someone uses --autosquash and has
> a fixup or squash in the list, wouldn't this apply as well, or does
> all of this apply before the transformations to fixup/squash?  Also,
> what if the user is doing --rebase-merges and there's a merge commit
> with a branch pointing at the merge.   Would that be included?
> 
>> + * refs/heads/. If so, then add a 'label for-update-refs/' command.
>> + */

This is limited to picks (for now) mostly for the reason that the
fixup! and squash! commits are probably getting reordered, even if
they exist at the tip of some refs.

The workflow I am optimizing for is to create fixup! and squash!
commits at the tip of a long multi-topic series, and then those
get reordered into the list. In that case, the only ref that is
pointing at one of those commits is also the HEAD branch, so that
is not updated using this mechanism.

This is a case where I'm very interested in alternatives here, and
maybe I should clearly mark this option as experimental so we can
work out cases like this based on use.

Thanks,
-Stolee
