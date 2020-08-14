Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DCEC433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D92B720B1F
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rTYTzmM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgHNMVm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgHNMVl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 08:21:41 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4DAC061384
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:21:40 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id e5so6717177qth.5
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jHfkt2nJzIcLnn6pjxLD3Tf7SMh+fxl+xNfs5ksevBc=;
        b=rTYTzmM49Rng6KFVybRu19M6B4nh+gg5cXgKDz7iL/S0rR9qQkHnzEMEAZps1/CdNe
         QTa8ciWY3weWCKjRRxemOQMCYFfjcEpmyutep4BLbPRnhwyzheTpMX1ZrEtFxf9Qy1bH
         pW+OFSHJHuPr2sZXg5aOqJoMjsZ24OA/cN+uI7cAozwrSsaf355LczJaBpZTpjiM0nzC
         xxuNFoyXnaz5E4IBacaLmqb/bRAlJvQ24jVZ6iHq34jvhDKLxX7xEkCA3mbdsBXzy0YC
         43KXUY2B4MuB7DFR4MSuXCPRywBWA6ofULE/mZHhuYqal4MeDpSin2Q9/b23THtpR0bf
         x+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jHfkt2nJzIcLnn6pjxLD3Tf7SMh+fxl+xNfs5ksevBc=;
        b=Mpi9avi7koVxrR7Z7Zhd6Gak+3vlBBwLlsL5+0iPAwZZSHOyLPgwyZHVbwuUHc54qn
         6zlXAssxwXZPPM+cd9G4EvW3rTBODQq82GeK5O+iNN8cU2eYMo/jbnSWtoWbhG3nwnDQ
         oBas1AgBXNcPJYeS4+3WMpMrZLsYzFFfLtZf4wdNxHWSrmeXFe1EnAmOw/RC0e2Ca8Ok
         G0mlDN4o9WHuDTe+JlvCrY382Sfzxg9oIWa2+SM/XD4f4HpUJZWruEZiLWMZVgIo6L2b
         WL+2MJpzVW+VTlOJD1c2ySr8TE5YbOt1p06UYALKjKH68xo2lh3W0QjcQ8vePDFA2VVg
         XmxQ==
X-Gm-Message-State: AOAM5311OoH2tMgx4Ahn9YaeAmLofbANQ1j3PwYLLaVs4AFJE7TRvis/
        /yLDPp1HYqtw4DmZKv/T8R4nSoVyjPzZYQ==
X-Google-Smtp-Source: ABdhPJwKe8rmavJq7syVoKfw20sXC2dk3c7Cur/QaPTH2Yj3kIOuOwzsMXBYe4EjQpT8Yy+Wt6bgOQ==
X-Received: by 2002:ac8:6d0e:: with SMTP id o14mr1664662qtt.93.1597407699628;
        Fri, 14 Aug 2020 05:21:39 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:4116:add4:1500:aeb7? ([2600:1700:e72:80a0:4116:add4:1500:aeb7])
        by smtp.gmail.com with ESMTPSA id b187sm7930506qkd.107.2020.08.14.05.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 05:21:39 -0700 (PDT)
Subject: Re: [PATCH] messages: avoid SHA-1 in end-user facing messages
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <xmqqy2miyr0f.fsf@gitster.c.googlers.com>
 <ee61b773-91c0-4b30-1d5b-e941bba03867@gmail.com>
 <xmqqlfihzvhu.fsf@gitster.c.googlers.com>
 <CAPig+cTTr8VdzeaPewktdncvnTWHjieEnEPV+vbD=GVbK7zQNQ@mail.gmail.com>
 <xmqqd03tzley.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5e9805f4-81c0-39bc-463a-8c47872f6456@gmail.com>
Date:   Fri, 14 Aug 2020 08:21:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <xmqqd03tzley.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/14/2020 4:22 AM, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>> On Fri, Aug 14, 2020 at 12:45 AM Junio C Hamano <gitster@pobox.com> wrote:
>>>>> N_("Show blank SHA-1 for boundary commits (Default: off)")),
>>>>> N_("Blank object names of boundary commits (Default: off)")),
>>>
>>> You guessed my intention correctly.  By using the word "blank" as a
>>> verb (i.e. to fill the space, which should ordinarily contain
>>> something meaningful, with whitespace instead), I can shorten "Show
>>> blank" to compensate the lengthening of the message caused by
>>> replacing "SHA-1" with "object name".

Ah, the "whitespace, not all-zeroes" is something that I misunderstood.
That makes a verb change valuable in this instance.

>>> A better phrasing to replace it is of course welcome.
>>
>> Perhaps?
>>
>>     "suppress object names of boundary commits (default: off)"
> 
> I think we want a verb that not just means to "remove" but also to
> "replace with the same amount of whitespace so that the overall
> alignment is kept".  To "blank out" would mean exactly that; I do
> not know about "to suppress", though.

What about something as simple as:

	"Do not show object names of boundary commits (Default: off)"

While this doesn't imply that the object name positions are filled with
whitespace, that is just a formatting concern.

Thanks,
-Stolee
