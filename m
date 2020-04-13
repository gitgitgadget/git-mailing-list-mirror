Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4875C2BB86
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 10:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7930A2073E
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 10:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVFAfBuT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgDMKGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 06:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728236AbgDMKEp (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Apr 2020 06:04:45 -0400
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 06:04:45 EDT
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ACAC00861A
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 02:58:37 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i10so9540559wrv.10
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 02:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rPW7oYoMXt5gMGDg6mkoyvlPPGACBN547sT5N+PqIII=;
        b=PVFAfBuTeu7dxoPLBfDiO096oMlPp/s7I+CzCFKfnREzQTf3qy8P+ey7oDFp9HMw01
         kJ9B0qrW5XqTozbxAHHxUVsiWduAi1F+didRhLeMm9H1/WNgT/3svvSEvIJ1ka9PMtVZ
         Hy7w2RI9prF4XMNOxNQxodQPPM9mWuazWUjHRyDlW5CTZEBcb6TEmNC6EPoJZ7J3hiYY
         fWH5MaQnD06EFzkaFfGcBAd72pwhT5ZAYtMOdXZQH1l4ADq6Mk1dmBx3ffkujSejymZ5
         uNVqtrm3ZLpKn8GAxtCpqZ5QmRInzuFDOaKhs7AYoKkj6dAgxD8FYP/0ytqvkTlnG/ci
         /eTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rPW7oYoMXt5gMGDg6mkoyvlPPGACBN547sT5N+PqIII=;
        b=P1h58WVEFzyiH66JbuX1M5cLkQW/9Ho3eYPxwQjL3LkXGYjURQfyhnI66trU12bPAS
         pDaJqsmkJWUN52MUJ77U3DPQIbFdSmtgl/nPVF1F04R7aNjadAq0hWMhEy762tHwtcJ4
         DBp51VK8qCIjKoqo9JKHzhbRwQnMBzkx4oYdUX82bgdwnazjEBUOyvAGyHcQftmQMeZ3
         Y6epbMb40B/kvwpehgHzzzt/yl3GLZSx8QMe9eQjLubDWEE5myGMSU+8+72mlOUImBTo
         OzINnO1h1D7JrEXlimca8EXQ1ygmsbMa4qNP3k2RPMUhBwoETRKtRPMTgtkAQTQlsbos
         za8w==
X-Gm-Message-State: AGi0PuZnidGgGtvHiUAItbi+APTGzVl0lRUoVupFVF0MuxefFIFibnhJ
        LWA51qTsve/NQfvSj97Oicw=
X-Google-Smtp-Source: APiQypKP2CkoZVBxOeUtiXz9N9+HZoFs5KgR1bswAoouFzWSd2cde1rbny0Os9IOaIKT2JoqrWCW4g==
X-Received: by 2002:adf:ea82:: with SMTP id s2mr17713601wrm.407.1586771916340;
        Mon, 13 Apr 2020 02:58:36 -0700 (PDT)
Received: from [192.168.1.201] (155.20.198.146.dyn.plus.net. [146.198.20.155])
        by smtp.googlemail.com with ESMTPSA id s14sm14427397wme.33.2020.04.13.02.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 02:58:35 -0700 (PDT)
Subject: Re: [PATCH 1/6] Revert "Revert "Merge branch
 'ra/rebase-i-more-options'""
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200407141125.30872-2-phillip.wood123@gmail.com>
 <CABPp-BEnmpET=6rEdDXJWnPjzV33a2x6rKB6FQ-o8y+8ssK4jw@mail.gmail.com>
 <xmqqv9mbroqw.fsf@gitster.c.googlers.com>
 <xmqqlfn7rnj2.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2004121944590.46@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <43d06bc0-b2ee-0ae6-f22c-9850e4033d45@gmail.com>
Date:   Mon, 13 Apr 2020 10:58:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2004121944590.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All

On 12/04/2020 18:47, Johannes Schindelin wrote:
> Hi Phillip, Elijah & Junio,
> 
> On Tue, 7 Apr 2020, Junio C Hamano wrote:
> 
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Elijah Newren <newren@gmail.com> writes:
>>>
>>>> On Tue, Apr 7, 2020 at 7:11 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>>>
>>>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>>>
>>>>> This reverts commit 4d924528d8bfe947abfc54ee9bd3892ab509c8cd.
>>>>>
>>>>> This is being reverted to enable some fixups for
>>>>> ra/rebase-i-more-options to be built on this commit.
>>>>
>>>> This makes sense to me, but it will be only the second 'Revert
>>>> "Revert..."' commit in all of git.git and I'm curious if Junio will be
>>>> unhappy with it.
>>>
>>> Nah, there isn't much to become unhappy about.
>>>
>>> I however suspect that the alternative would certainly be much nicer
>>> and easier to understand, which is to rebuild the 7-patch series
>>> c58ae96fc4..d82dfa7f5b but bugs already fixed, instead of doing this
>>> patch to take us back to a known buggy state and then fix the result
>>> with 5 more patches.  Is that what you meant?
>>
>> After looking at the conflict resolution while merging the result of
>> applying these patches on top of the older codebase, I would have to
>> say that the approach """I've opted to add some cleanup commits on
>> top of Rohit's work rather than reworking his patches.""" may not
>> have been particularly a brilliant idea, not because the conflicts
>> arising from an older codebase are unpleasant to resolve (they seem
>> to be reasonably contained), but because it resurrects other
>> unwanted cruft we have cleaned up since then, and worse yet, it does
>> so without triggering conflicts.  For example, we'll end up seeing
>> mentions of "'am' backend", which have all been updated to "'apply'
>> backend", in the documentation, and patches [2-6/6] do not fix them.
>>
>> [5/6] is an example of one more "unwanted" thing the reversion
>> resurrects that needed to be fixed, I guess?
>>
>> The result of applying all these patches and merging it to 'master'
>> and/or 'pu' may be more or less right, as far as the new features
>> added to the "rebase -i" by the series are concerned but there may
>> be many small "unwanted cruft" we may be resurrecting with [1/6],
>> so...
> 
> I agree that it would make for a much nicer read if the entire patch
> series was simply rebased on top of v2.26.0, with drops instead of
> reverts. I suspect that 4/6 will not even become a fixup, but that the
> resulting patch is really more of an `Initial-patch-by: Rohit` material
> with Phillip as the author on record.
> 
> As to the changes, I had a brief look over them, and I have nothing to add
> to Elijah's review except to stress how excited I am about the increased
> test coverage. From my perspective, this makes the patch series 10x
> better.

Thanks for all your feedback, I'll reroll as a new patch series based on
master

Best Wishes

Phillip

> Thanks,
> Dscho
> 

