Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986FAC433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238222AbiDMTQr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238291AbiDMTPs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:15:48 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEB375636
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:12:10 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id c64so3577350edf.11
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=IYOSjtw/Ve+oauvg5Hf+t0oSag4YwdLj4lsr4oUEiEI=;
        b=LNW4EqTakBGWmWDFZumZYZCtcu/QS27g99kF8J2UC3PazfjZGV9IGKayIg6WKwo8Tz
         fKvDglF7zViQPwjcLQCO60j8nJozPaNPcH2SCi6W8I/uOAvWbHssfFBB/UG0HS0ncmhM
         PqzPak4F1a8ss8Xy+XEGo2skuUJbh7WTbE2VcSRexYI0zg9+bScnx3sBgB61NrTGTxzf
         WLe0K2Xwo4W6BJjU8dbL1ZqcyQ5e6SRczc5e5FLcjistACsYo4jAvsrPZUo59NpruCAY
         avE6ytVFD70LpcMCyEo2DFYk/ytN8gGX8oUwz7lDAumPad1A5ZnE4hoGhVBmiLxHot+o
         rNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=IYOSjtw/Ve+oauvg5Hf+t0oSag4YwdLj4lsr4oUEiEI=;
        b=Z3NO0Cl0iDUBnO30w8aC8CHZBcBdQiN7LOtKE12nZKTI73UR8WFvsCPXSDHBvOCEyV
         0PRauk3ml6usNZuAltbLMQoSUpgXPHXEW5ms37gDgPCstr4cMxqkXCTbbRIprrloo3oK
         No8ofV+LNJznlFlXQRZuCBj4xqFGiX0kewiFbuiAgUcYac+Y2ckbdhNdbGnZkGIZtcaO
         A3yGkjNuAFVg9mDaMcZhOIEL6LD7Fy5nUQFueIEu8fVbfnc5CfoC5Hs+/s2ArgqTjyJE
         d4kr9MioqqRGREr0b7kdZBeFBhlzby6DZ6RkNBOvOEBVorSUifkSwjuYQ4WIoj43xaRI
         3+Zg==
X-Gm-Message-State: AOAM533TzzP7DbOjEVXkojJrBjYhjHJWdQhT2fney/nnYVYj9o9xEt6A
        IvlNMFyIQLkDAVJNXGhHOArbcPwg3lo=
X-Google-Smtp-Source: ABdhPJyr2MmkLACfQU6AN09eHNeDzR1wbfHiAXAdOpOd/teK9Vjdb4xdxJqOqxeVz0fTfxx4YgevwA==
X-Received: by 2002:a05:6402:50d3:b0:41d:86f4:afbf with SMTP id h19-20020a05640250d300b0041d86f4afbfmr13404754edb.146.1649877128646;
        Wed, 13 Apr 2022 12:12:08 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r3-20020aa7d583000000b00420a8b66566sm6909edq.97.2022.04.13.12.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:12:07 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1neiPP-005A6H-DQ;
        Wed, 13 Apr 2022 21:12:07 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Phillip Susi <phill@thesusis.net>, Git List <git@vger.kernel.org>
Subject: Re: [RFC] introducing git replay
Date:   Wed, 13 Apr 2022 21:07:25 +0200
References: <20220413164336.101390-1-eantoranz@gmail.com>
 <8735iglvxq.fsf@vps.thesusis.net>
 <CAOc6etbheKZ9CYJ+6Chz9gDj1WGK_5hQeHYTmhOKiUtDd0RKtQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAOc6etbheKZ9CYJ+6Chz9gDj1WGK_5hQeHYTmhOKiUtDd0RKtQ@mail.gmail.com>
Message-ID: <220413.86o814er20.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 13 2022, Edmundo Carmona Antoranz wrote:

> On Wed, Apr 13, 2022 at 7:45 PM Phillip Susi <phill@thesusis.net> wrote:
>>
>>
>> Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:
>>
>> > If HEAD and v2.35.0 share the same tree, it _should_ be possible
>> > to recreate the commits that make up the range v2.35.0..v2.36.0-rc1
>> > on top of HEAD without requiring any real "rebasing". Just creating
>>
>> Isn't that literally the definition of rebase?
>>
>
> Well, yeah. :-) What I mean is to skip the rebase _engine_. No
> merging/cherry-picking/conflicts along the way of recreating the
> new revisions. Say, clone the exact same revisions that we want to
> _rebase_ and adjust their parents, nothing else (or little else, like adjusting
> the committer).

Yeah I think this is fundimentally a good idea to pursue, and it's been
discussed at various times in the past, and indeed, it seems best to
pursue it as a rebase optimization.

I.e. given a history that has say files A.txt and B.txt, and a fork from
A adding X.txt and Y.txt (and nothing else) we should be able to do a
"light rebase" in moving that X & Y forward to it has B as the parent.

Right now we do a rebase in all its glory to do that, with index
updating along the way (I forget how much that's been optimized, if at
all) etc.

But if we can detect that we say only have additions of new files we
could just munge the headers as we go along, and the rest should all be
happening essentially as fast as we can SHA-1 the commit objects, which
is basically what this built-in does, right?

