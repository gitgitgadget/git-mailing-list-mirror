Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FDA31F51C
	for <e@80x24.org>; Thu, 31 May 2018 07:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753908AbeEaHIE (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 03:08:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37172 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753846AbeEaHID (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 03:08:03 -0400
Received: by mail-wm0-f66.google.com with SMTP id l1-v6so52117001wmb.2
        for <git@vger.kernel.org>; Thu, 31 May 2018 00:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=AC1AJ+MPzJZKUIAiRIkoHV0a5E0/dh4PKnLy331Gyj4=;
        b=D5SYQXQeG5SGW96MMqHj2d5GR45WYEC/mNN58FGmzCKw1RPVxMsAT2igNqZr+meDAj
         8zE8xEGpLU/56blBwDgem30Ted/6ZkQzxBCUw8jmSTTf9TElFmOUfHB4WAYXHzgFReRK
         gGFwr2NucDQG9o/dEWba6hfmZCCJo7axdDlU2wcspma5N9zp+GSATWKTlvbL27xlvoxX
         CD3yoHInAUCrg0KuQeUuf4O23i46y2cxM7rSq6+zS4++RfqZwL5Zh0cZ93ikrIwhLWak
         ukJCPmEv8cjB+Nymn3FVo3eG+oOVHDcTMAKY8TebRnxSCw7c4Vd9oYU2GKjxmQp/EbuY
         9kQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=AC1AJ+MPzJZKUIAiRIkoHV0a5E0/dh4PKnLy331Gyj4=;
        b=E48cPZQICgzD/yYTrIKD56cnkBhI37HN+1P/Bv7Iyre3m9hlyLp2sgzoAdC+o4YqMA
         2rD6E5eGURe75gM9Ss7j78KwoP4UD6upt08v6NwtuCdNalTyJT3rdc7Eq4GOMk2KADsy
         bwepNAXU636lvgmo2GxxUV1evFViQtfUp05euFyL6hdVsxySeCxZxbJNXG7OwEqt6dKU
         bh4gOVk3oAGLwOjyAceAVrF0iMcBJ38OJHwuo2Yz4YIeQJDILGiwevzkdbVlHPguQZp+
         hVye7r6+kfnCofFEL+UOarI1eQTqHiHAONfG+Q/WEheLeNcrLLPUkbMqe9b/Wxl+JKgj
         toxQ==
X-Gm-Message-State: ALKqPwflZyvS2jNeH/9EVs5dkTUD0AsvMeZonjV86OokKt8OyZJdrRqW
        dtn5ZMu5JThFRqAeR7Ii7rA=
X-Google-Smtp-Source: ADUXVKLsT5EkGuFI73babNRdRNLQylvRca4KLsLDBOj0fcHrctR5awsg9/aLITU0geHEFqAVrHlXaw==
X-Received: by 2002:a50:b7ed:: with SMTP id i42-v6mr6635469ede.284.1527750482202;
        Thu, 31 May 2018 00:08:02 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id w9-v6sm22882500edb.38.2018.05.31.00.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 00:08:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 4/4] color.ui config: add "isatty" setting
References: <20180530210641.19771-1-avarab@gmail.com> <20180530210641.19771-5-avarab@gmail.com> <xmqqmuwgda5k.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqmuwgda5k.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 31 May 2018 09:07:23 +0200
Message-ID: <87k1rk9uc4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 30 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> A co-worker of mine who was using UNIX systems when dinosaurs roamed
>> the earth was lamenting that kids these days were using tools like
>> "git" that thought they knew better than isatty(3) when deciding
>> whether or not something was a terminal, and the state of the
>> documentation fixed earlier in this series certainly didn't help.
>>
>> So this setting is a small gift to all the UNIX graybeards out
>> there. Now they can set color.ui=isatty and only emit fancy colors in
>> situations when the gods of old intended, not whatever heuristic we've
>> decided to set "auto" to.
>
> Re-read the above again, and notice that you are *only* hinting that
> you consider difference between "auto" and "isatty" is important,
> and that your "isatty" is better, without telling what the
> difference is, let alone why you think "isatty" is better.
>
>>
>> As noted here this is *currently* the same as setting color.ui=auto &
>> color.pager=false, but I think it's good to explicitly have this
>> setting for any future changes. The reason, as now noted in the
>> documentation is that the "auto" setting may become even smarter in
>> the future and learn even deeper heuristics for when to turn itself on
>> even if isatty(3) were returning true.
>
> Do you mean s/true/false/ in the last part?

No "true" as noted in
https://public-inbox.org/git/874liofgv6.fsf@evledraar.gmail.com/

>> At that point the fans of plain isatty(3) will become even more upset
>> at what we're doing, so let's give them a simple future-proof opt-out.
>
> You still haven't explained why "auto" that does more than "isatty"
> is and will be irritating.
>
> That's not a good way to sell a patch.

I'm not really trying to sell this thing, as noted in the CL. This is
more of a "I wrote this, does anyone find this useful?".

> Also even "isatty" still needs to do more than isatty(1) call.  The
> process that is trying to do color.ui=isatty may be talking to an
> outgoing pipe due to the use of "git -p cmd", by that time, it is
> too late to call isatty(1) and obtain the info the caller wishes to.
