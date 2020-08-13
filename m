Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3FFC433E0
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 01:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF2F720756
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 01:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uklVgUe3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgHMBpg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 21:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgHMBpg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 21:45:36 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDA9C061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 18:45:36 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id p1so1927385pls.4
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 18:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b+Gz74ib0lkjbEacP99rP9QailG4g+tUGbX/nbXyyfo=;
        b=uklVgUe3DhtH0tzBAkqee4HEorqADY45SabXzlAcSppoPyNBwTGMcH3717OH1PSna9
         f6l7zqMelFcBHBiaDDuxAGzydmHWNEoaeeShPfJfOKYRdIPEJwIQt6c0oXzl6NAj65Eq
         fBmtoXSlLVUpwGqJFsc3cCaNd8RtMzQhqnTMAK1OLtaeIRKtoKpvqP2UREiP/sJ1x9JP
         dfA60+0GL+Z6gPEf8Dra15gmjOaVNiE5q4szvw5FI953N5QKWG2a38W5jAinSGfGHiVm
         lIRYc5hTT7nkp1BmrHoeCIR8Pl/Zi28ACR7xi1nmSs4RaznqNv/DCeazFX/wx8yJ95qx
         zI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b+Gz74ib0lkjbEacP99rP9QailG4g+tUGbX/nbXyyfo=;
        b=AL59OLVDwJUKiG0tZ1//UPDbU/hDDcBM+Lexdu5qoL6O6oxUSPQQ1zjJ4B9yn8FeES
         f2eEyN5mLDkNg1DW2Gm6I9QKvxV+mOeuseY66BP3oTUMbHw3XXBGCfbCw8idoawhXrpD
         xoxGUaiH2Q1rlIBAPa9LJi41nLG6aOiq/bvmh6K4NHvdZLHyRW+tNWTMDxC9tzPx6IR1
         Z1SD7E1FLjBmE0o7Azl/qozBRgSNzlqeBdEBXy9SBvq4DA7HaItkkZhxG2kBNqU9AmwO
         5I6gyDqIHWDRRg35JEaBJ6fb2kql2WVpvgHNrZMPU3inrsmUt5Z7+iMFXb/XGBqE+nep
         IDcg==
X-Gm-Message-State: AOAM5306jDRfbxgBLnzpUOPpxsKfVKfWzDW2pFKvnBYZeqkII0x6VaWV
        UVbMThFoTJb/Jf2BEoEWvPM=
X-Google-Smtp-Source: ABdhPJxEX5SBQXRlDAMLN+ty8bQfeeHfASfNbFnIi1bmi5aRpyUeLP7OWIZEadJuMLQCSEI2X3VGcw==
X-Received: by 2002:a17:90a:eb98:: with SMTP id o24mr2507704pjy.150.1597283135398;
        Wed, 12 Aug 2020 18:45:35 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id y29sm3747929pfr.11.2020.08.12.18.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 18:45:34 -0700 (PDT)
Date:   Wed, 12 Aug 2020 18:45:32 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, sluongng@gmail.com,
        jonathantanmy@google.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/9] fetch: optionally allow disabling FETCH_HEAD update
Message-ID: <20200813014532.GC104953@google.com>
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
 <83401c52002716084b9c53a77c9d57b6009f84e2.1596731424.git.gitgitgadget@gmail.com>
 <20200812231021.GG2965447@google.com>
 <xmqqo8nf4dkb.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo8nf4dkb.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> As the feature itself is primarily designed for scripts that want to
> always disable writing of FETCH_HEAD, I can certainly understand a
> short-term/sighted view of not wanting to add configuration, though.

Yes, I think that since this feature is primarily designed for
scripts, an option is more likely to be useful for them than a config
setting.  An option kicks in when the calling script requests it; a
config setting can kick in even when they didn't intend to request it.

My opinion would change if we think that we're going to flip the
default to --no-write-fetch-head some day, in which case a config
setting would be a good way to request a preview of the future.  But I
don't believe anyone's brought that up as a direction we want to
pursue.

[...]
>>            If someone specifies both, then they probably want to say
>> "show me what I would write to FETCH_HEAD but don't actually do that" -
>> which isn't info that we print anyways, right now.
>
> Do you mean "don't actually write but show it to standard output
> instead" or something?

My take is that the behavior that the patch implements for --dry-run
--write-fetch-head is correct and what a user would want: it acts *as
though* you passed --write-fetch-head (including producing the same
console output), without producing mutations that the user might
regret (such as updating FETCH_HEAD).

Thanks and hope that helps,
Jonathan
