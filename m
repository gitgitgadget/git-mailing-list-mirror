Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82516C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ADA66190A
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhEKSrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 14:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbhEKSrS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 14:47:18 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0011DC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 11:46:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id r5so12905173lfr.5
        for <git@vger.kernel.org>; Tue, 11 May 2021 11:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MLDZa7nGfG6r06TGCcB2TQ90C/MwPgL7QcJCvhM1L2A=;
        b=uBq9UK80J9quVYGbKUiXeSMZEZ/At0G9Rhlxo9kvEp/TzAjr3UjzCnFMm6tV80iU4r
         S7uOYBp+rEIW4usuXSKimw+wICy5Po43urR266GslOeAue4Y5DiJMcJKNX+5RILtomGR
         voPssma3fGRgs77ux9iGRCtC/3UkW19AwtSShUB4Tlk2Y1kJOSqEFefFUz/qDmB6BkkC
         SDUMHY3W81GRiXb3X4EZJk4ZC4pB7kENdkBU+c6yJgIE0XapclMCH0UCg3hRaO+XBQLi
         wTtAzfCrnL9TN9AB7EDWWU4RKzeNIWKRXtHv3v9SdQDt6YHn/HPRJIPtWa4XAz3YmgGN
         3D6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=MLDZa7nGfG6r06TGCcB2TQ90C/MwPgL7QcJCvhM1L2A=;
        b=Jt9YUwov/0ay2avYW1hGOPSIDeexpLmKMg/n+goPeKwV+hcv24Yo8RiWH2zPUJJKt5
         Q3pKVXRLk+3lyFaRGbKnIonZVgizzIV+VjITo7JL64h3rOAWQ+hUmUQA8Opmo4qELmql
         MTsNohO9zF9Mubzgp924+kBnAV0sk9X/1dvAdC1swBSgvMOD83BFN79g+aW4v1dZpjMn
         pSshNyj76Hgb+HgV8JaDVCC/0/9QdeUSBPJBkPPiy4a3d1M7/3YozjqfvxC94Tht8LW+
         jK28mq9MtjAp8hjpT3hndR4Z8xBx7Nl1vKM5cE9DAQXFaIomADrfUlXLLII1UPevtYqN
         zBsQ==
X-Gm-Message-State: AOAM531oh8X5apPr4nmjnqBEDLdrZv+SbopDLGN7vlJgUD1dLTEwor1a
        jtRhiEEmp+uUNVBUUxwYnCCTh4fdiNU=
X-Google-Smtp-Source: ABdhPJwaL70i+oi1fXo2ftBaOvnlkB5UFJjtlcXuznobEsegRnNhmaglHrmkYxMvfWyqiCnuI2/Crw==
X-Received: by 2002:ac2:42d5:: with SMTP id n21mr21108078lfl.164.1620758768957;
        Tue, 11 May 2021 11:46:08 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u23sm3827356lji.39.2021.05.11.11.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:46:08 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210510153451.15090-1-sorganov@gmail.com>
        <20210510153451.15090-7-sorganov@gmail.com>
        <xmqqsg2toqik.fsf@gitster.g> <xmqqo8dhool7.fsf@gitster.g>
        <87v97pv04p.fsf@osv.gnss.ru>
        <CAMMLpeTL9ZOuHLhqonFOwMu8yC9bETMVzkCZ__F2JsR=0umL3A@mail.gmail.com>
Date:   Tue, 11 May 2021 21:46:07 +0300
In-Reply-To: <CAMMLpeTL9ZOuHLhqonFOwMu8yC9bETMVzkCZ__F2JsR=0umL3A@mail.gmail.com>
        (Alex Henrie's message of "Tue, 11 May 2021 11:13:19 -0600")
Message-ID: <878s4lqfbk.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> On Tue, May 11, 2021 at 8:03 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> > Junio C Hamano <gitster@pobox.com> writes:
>>
>> [...]
>>
>> > If we enable "some kind of diff" for "-m", I actually think that by
>> > default "git log -m" should be turned into "log --cc".  As you told
>> > Alex in your response, "log -m -p" is a quite unpleasant format to
>> > read---it is there only because it was the only thing we had before
>> > we invented "-c/--cc".
>>
>> Please, no! --cc has unfortunate feature of outputting exactly nothing
>> for a lot of merge commits, causing even more confusion than historical
>> "-m -p" format.
>>
>> The best default for -m output is --diff-merges=first-parent. Everybody
>> is familiar with it, and it's useful.
>>
>> > But that might be outside the scope of this series.  I dunno, but if
>> > there is no other constraints (like backward compatibility issues),
>> > I have a moderately strong preference to use "--cc" over "-m -p"
>> > from the get go for unconfigured people, rather than forcing
>> > everybody to configure
>>
>> I rather have strong preference for --diff-merges=first-parent. --cc is
>> only suitable for Git experts, and they know how to get what they want
>> anyway. Yep, by using --cc. Why spare yet another short option for that?
>>
>> Overall, let's rather make -m give diff to the first parent by default.
>> Simple. Useful. Not confusing.
>
> Honestly --diff-merges=separate is fine. Two weeks ago, when I started
> this discussion, I was trying to use `git log -m` and `git show -m` to
> find which merge commit introduced a particular change. Extremely
> verbose diff output would have been great for that, the confusing part
> was just that `git show -m` produced diff output and `git log -m` did
> not.

This is not a case in favor of "separate" over "first-parent" as the
default for "-m", right?

"Which merge commit introduced particular change" is exactly what
--diff-merges=1 achieves, so "--diff-merges=separate" was not in fact
needed, as I see it. Moreover, it could have produced wrong positives.
Looks like --diff-merges=1 is a better fit.

> Maybe what we really want is a new short option like `git log -m1`
> which would both enable diff output and set --diff-merges=1.

Hopefully this will be simply "-m" soon. "-m1" is no-go as optional
arguments to short options is a bad idea. It could have been "--m1", but
I believe that's not needed.

>
> But again, I don't have a strong opinion on which particular diff
> output is "the best", so I'm happy to leave that decision to the
> experts.

There is no "the best", and at least "first-parent" and "dense-combined"
are to survive, and "dense-combined" already has its "--cc" rather short
variant, so it's logical to give -m the other one, especially as it
already has this meaning when --first-parent is provided as well.

Also, I'm not sure if -c is being in use, and if it isn't, then it could
be changed to produce dense-combined format, especially as one still
have --diff-merges=condensed nowadays anyway, so that -m and -c will
finally give 2 most useful formats.

Overall, I still find a lot of sense in giving "-m" exactly first-parent
default meaning.

Thanks,
-- Sergey Organov

P.S. If generic options machinery were in use, it could have been
possible to say:

  git log -pm

reducing the issue to consistency only. I wonder if anybody have plans
to convert setup_revisions() to parse_options() utility?

