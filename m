Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3810EC433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 21:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbiKKVYY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 16:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbiKKVYR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 16:24:17 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69BB627C1
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 13:23:44 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id bj12so15252606ejb.13
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 13:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DCHyM51ya6SqM3sK4MBWFlorVbDy9rod0nfBQXShjj0=;
        b=I4eIsCsBqpgh7zVxQro8xV68Thuove5fpLQT6WPMOMM/nAPsDKpT6gnrTtfxFjrCT0
         kgjLpC2+kAhsvKSkUmbTRbSfAt7eIiornCNxnV7BtJTH6LIvCCbcNHHtVdor+NIqO8xp
         RckeaVOkDcQTELFMWBq0knvM88x3MCT8BJI7Yy5fsNwh07FNp6K67QH+o03pV7nacF1c
         svZJfHxrvAfH/RXQmvdCZGMqzyhtvZqEQutSowZZugADxUeXsxP0XiwiMhos3KGBgmvu
         S1jBEW6sNsT2Ja0p9qMKRa9kYbdTYs4zy/nXPwlbkZstD8kmy/ulhSwIYBZHhwE0ffdd
         axuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCHyM51ya6SqM3sK4MBWFlorVbDy9rod0nfBQXShjj0=;
        b=3cjkmU9of1M55XoSRtpJrcizS1AikMCKcBVbnbSRegBkzXU0uVczF46Z+kz5ReEa7C
         LlLFWli9iZP7dKVzxW1FSoN/0rcZ+EPoKc/7cP+tRkni0eTewaKYGGFSUGgY8vG/0iIa
         yP0WxjogWBwgJa0JsvuOqQX61P6js7/BDRz8tgJHSpI3fKPS2VMN0JjKLSMba2jQlObe
         W9D2Ya3qDUuU8Dm9g1p14rtkoOTMM7xQ9j4w8LsPaCJ2x+yPRRNQXM+ZY+WllGLXEoFg
         H1qZka1tSsVVgSkx88UCQ/uwznPw23GcTW8I9OulFi4H1qCavGBzdKznwzfj8erglkHf
         VFSA==
X-Gm-Message-State: ANoB5pnvyOo5G+MNnodObGEJKl7qUSBJopPkQhW8vaISa1KE/+XqXOU2
        kIzDVdhbl/nvzdMuMUv/g23YWbAC0Hk=
X-Google-Smtp-Source: AA0mqf7t/oLH9EFH+3y/QTS6J1bp7oRW1mrDYOPoe2Tm3gMQMYNnsG3F49vMUAfYJfMK1FESJ1keYw==
X-Received: by 2002:a17:906:b10d:b0:7a3:fbfa:32e5 with SMTP id u13-20020a170906b10d00b007a3fbfa32e5mr3486699ejy.7.1668201822920;
        Fri, 11 Nov 2022 13:23:42 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id r18-20020a17090609d200b0077f324979absm1291508eje.67.2022.11.11.13.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 13:23:42 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1otbUz-0027Y5-2k;
        Fri, 11 Nov 2022 22:23:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] Get rid of "git --super-prefix"
Date:   Fri, 11 Nov 2022 22:17:44 +0100
References: <20221109004708.97668-1-chooglen@google.com>
 <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <kl6ltu373ae5.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221110.86zgcznjah.gmgdl@evledraar.gmail.com>
 <kl6l5yfm2taf.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lv8nl1h19.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <kl6lv8nl1h19.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <221111.86fsepmbhe.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 11 2022, Glen Choo wrote:

> Glen Choo <chooglen@google.com> writes:
>
>> Rereading this series and thinking about this some more, let's go with
>> your approach, primarily because it avoids global state.
>>
>> From this series, it seems that it's not that hard to make this change
>> and support whatever use cases we currently have.
>>
>> This does make it more tedious to add more "--super-prefix" in the
>> future, but that's a good push for us to do more things in-process
>> and/or be more principled about passing context objects through the call
>> stack instead of relying on globals.
>>
>> Let me know what I can add to this effort besides reviewing :)
>
> Specifically, if you have other things on your plate, I'd be happy to
> pick up where where this RFC has left off.

I was going to get around to re-rolling this in the next few days, but
I'd also be happy to have you beat me to it.

My plan was basically:

 * Steal the test from your series, put them at the beginning, and for
   those that fail make them "test_expect_failure", then
   "test_expect_success" later when they pass.

 * Pretty much my RFC as-is. If you're re-rolling it I'll leave to you
   whether it makes sense to do it with the "read-tree" included (I
   think probably yes, but "just the submodule--helper" is smaller).

   Rewording the commit message referring to "the other approach"
   (i.e. your series) probably makes sense in light of later discussion
   (probably just dropping it).

 * Right now I can't remember if that one test failed until the
   "read-tree" patch, or if the "submodule--helper" was sufficient, so
   maybe we need the "read-tree" one to flip the
   "test_expect_failure"...

 * The 8/8 has a wart where I just removed "SUPPORT_SUPER_PREFIX" from
   git.c, but didn't adjust the rest of the bitfields, i.e. it should be
   1<<0..6, not 1<<0..3,5..9 at the end (having removed "1<<4". You got
   that right in your version...

If you can do that and address any other nits/issues you find that would
be great. I don't think I'd get to it before next week otherwise, but
it's earlier in the -0800 TZ :)
