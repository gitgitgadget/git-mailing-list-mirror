Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86AEC433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 08:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADD006115A
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 08:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbhJFI5T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 04:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237593AbhJFI5P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 04:57:15 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D17C061749
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 01:55:23 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id p11so6986806edy.10
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 01:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=/SieCaDYmcFP9/vn6d+T8oeVUfzyQklpE4BYTpGv+zs=;
        b=qdNXaxsTfgicliU1R2K56hzVoRemFT03WY/eCN90D8vq5giW+2w3txNhk0+KVZZsjB
         3LrepxNbtBelKt4Z1cV6sa9FqItWHblQTjyViu6q7SWR1tMwQ1AAvd2PwktNzyW08nYb
         OmiLCr+BLLwfSV9IiNY0mkMkbwCNaCK1jMEBPbgDt0gQszN71fhXI7p59QP5BzkREf0m
         5ujTqNyGgiD7IPE/NtkNfGWYgxDWttRT/WhT+tfyUeW4sU+zPrCjH/JYfVLKXrKFNy46
         +5SjWCHxOmLcgn9SJRE6T6PX+RjMmYLnxVyr1DJOiaPO/gGPdchiDxioLDGHRjLM8FwK
         4xsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=/SieCaDYmcFP9/vn6d+T8oeVUfzyQklpE4BYTpGv+zs=;
        b=0xWPdR7BVVkySPKHGZlFUCOZMK8PEClVPxxJTnmnV9jlYJR3h6iL/4apDGHHXip43i
         ZS56SH4z+PAoQ64N3rqkYY0ZWJ5gcToa9IHv/NnXprN36XeYVJ+fcTjN4fKMLmn0A+W7
         oXzX5O6OgXS5Wx1sbcfz5plvpOwTnJs5I5HX9jP2G4War1ePl1lBU5WuP7YPCq0okc+z
         BRQASdDzRopsiCl2Ol8ZUCeVXuiFYEZfYJUrG4sJB1lBWjuzbEoU1pmefRUyeeY9s5UM
         XttznwkT3K9qKb8kMEdx+2AO7T66Nz+cB1J/oswmTpkY5X/uA/sGxv0amoNfOovbCnd6
         GIqg==
X-Gm-Message-State: AOAM531/KL/VGGMpnJyQgswQbW3/pLaM3KP4Tk1vQstvXDFACkmISeUf
        UN91swMMehuWd5SMDHv/x2E=
X-Google-Smtp-Source: ABdhPJzTSR0tExEDkKuRybaGxevSgPJc68XQYsmVpHwI0LCrRdn4h/YYq8xlB5lt9I2hIiqrl5AzAw==
X-Received: by 2002:a05:6402:1250:: with SMTP id l16mr18067268edw.323.1633510522278;
        Wed, 06 Oct 2021 01:55:22 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id dx2sm1226962ejb.125.2021.10.06.01.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 01:55:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: ab/fsck-unexpected-type (and "cat-file replace handling and
 optimization")
Date:   Wed, 06 Oct 2021 10:54:43 +0200
References: <xmqqo884tkxd.fsf@gitster.g>
 <87bl43jit5.fsf@evledraar.gmail.com>
 <YVzLRSa9/vUWJPL0@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YVzLRSa9/vUWJPL0@coredump.intra.peff.net>
Message-ID: <87y276ilc8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 05 2021, Jeff King wrote:

> On Tue, Oct 05, 2021 at 10:47:26PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > * ab/fsck-unexpected-type (2021-10-01) 17 commits
>> [...]
>> Note that Jeff's just-submitted cat-file series[3] will conflict with
>> this, as they both adjust the same "garbage" object tests. The semantic
>> conflict is minimal/none, but the textual one is probably annoying
>> (e.g. his 1/5 uses a variable I split/renamed).
>>=20
>> Jeff: Depending on what Junio thinks of queuing ab/fsck-unexpected-type
>> for next what do you think about rebasing your series on top, or perhaps
>> take a look at the v10[4] of it/ack it in case that helps with that (sin=
ce
>> you've been looking at some related code just now...).
>
> The conflict is pretty easy to resolve: just keep my new cleanup tests,
> but swap out the variable name. The combined diff is below for
> reference (this is more readable than a remerge diff, but I guess a
> remerge diff could actually be applied).
>
> I don't mind rebasing on top if that's easier for Junio, but in that
> case it may make sense to float the test cleanup to the front of the
> series.
>
> I can also just change mine to do the --batch-all-objects tests in a
> separate repository (which is what the existing ones do). That has the
> minor advantage that we know all objects in the repository, so rather
> than picking out the interesting object with perl, we could generate the
> full expected output.

Thanks, your plan sounds better. I hadn't tried the merge when I sent
that E-Mail, just saw your series & that it would conflict, wanted to
give you/Junio a headsup.
