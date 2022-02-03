Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B8AC433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 17:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352910AbiBCRfa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 12:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbiBCRf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 12:35:28 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFD7C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 09:35:28 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id i16-20020aa78d90000000b004be3e88d746so1546179pfr.13
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 09:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=g3T1LGuuXnKvF7GNfpQ8UPeTOOAjn4Qh8jtZkgWTSqA=;
        b=AF+rg/FT8SeCEulssnHAunlY29jhzou7LakB5OmuqgeuQhmyFhTvButE265h4deatF
         QwrvzwQ4ET+vXERWnXxFrB8jqZenaUXDNrizA8uR5Axs3CtC+XmDXT2Mo3fzsw55jY67
         xZxu1cdUgCaVLcPFoQTFJ0N6nXutZf6IOt/BV9kaMClYkOhropYsPa0862etLf2HJulg
         aj7TFPKOzBwhK7iBohket3NRY/qrvh3OZiSZIQvYwt/zJ5VnE7WgtgIlhBrGdnF0kGcJ
         F6tlT0x6ArH+iAB+QANNthL0bWON+UIrwdbXsH2sPG8r8cNb6QdF7mShgXDJVWROkRkx
         srCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=g3T1LGuuXnKvF7GNfpQ8UPeTOOAjn4Qh8jtZkgWTSqA=;
        b=pRNsFDOelH8VJP0MiTXvY0KO28U3cJ6UKbOrLJly68cfuqw/I/amaOXUSrgDjDBn3b
         ik3aqUMWsFR/pLn3Vgc/Xj1O9ZDoFELBbczhx0uJHvBW962oTCud7PM7iFaRxrUPrHev
         cWZT+hfmLYueO2dvhalv82QnvEBu19FDi3fHFLoz8VXR2qJ+wqTGEYHStpadu2KpZHoR
         7ECFEJRAMsKtrmuL7CCbT8Wns4ujNwrfAhlpj5c5rr+GUjGHy0B/mtaol4BPfplU1kHP
         R3+ap1NSnlpuWDuUxFOxEkJipihSjaMQATF4Eu2sm7Cqjh2B2qDtPAIU6NOUghm/2DUF
         VOhw==
X-Gm-Message-State: AOAM532BZncllF7UQ1B21esDK/1ZNsAcWiN6Z1UE8+CzTm2fxzAvIgtL
        wUPtCzwe6ZPJs1K4Kf57+9aIHEhR8ErpWQ==
X-Google-Smtp-Source: ABdhPJx96ZLcRVtIJEsT5GVsbBUqHaWklm5CZ3jo7hfpoILFc9j3vsBm4IDlV66g7lm4Zjdk1AhbqytCYQLD9Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:e7c6:: with SMTP id
 kb6mr15126909pjb.139.1643909727540; Thu, 03 Feb 2022 09:35:27 -0800 (PST)
Date:   Thu, 03 Feb 2022 09:35:25 -0800
In-Reply-To: <220203.861r0k74bz.gmgdl@evledraar.gmail.com>
Message-Id: <kl6l1r0j26qq.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com>
 <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com>
 <patch-v5-9.9-e8e57606ee9-20220128T125206Z-avarab@gmail.com>
 <kl6l4k5g246p.fsf@chooglen-macbookpro.roam.corp.google.com>
 <220203.865ypw7jw6.gmgdl@evledraar.gmail.com> <220203.861r0k74bz.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH v5 9/9] submodule: move core cmd_update() logic to C
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Feb 03 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Wed, Feb 02 2022, Glen Choo wrote:
>>
>>> - Junio pointed out that this conflicts with
>>>   es/superproject-aware-submodules [2]. I'm not sure which should be
>>>   based on which. If this does end up being based on
>>>   es/superproject-aware-submodules, it would probably be easier to
>>>   rebase as a series of smaller patches. Atharva noted that the
>>>   conflicts are mild though, so maybe it's not so bad.
>>
>> I think it makes sense to get this series through first, i.e. the
>> (supposedly) no-behavior-changing one, and then one that introduces new
>> submodule behavior.
>>
>> Particularly because for es/superproject-aware-submodules the main
>> selling point is a performance improvement, which as I noted in the
>> review for it I've been unable to observe once the C<->sh layer goes
>> away.
>>
>> I'm not saying it's not there, just that I don't think it's been shown
>> so far, IIRC there was some reference to some Google-internal network FS
>> that might or might not be helped by it...

I'll let the experts chime in, I don't think I can add anything useful
to the discussion.

>>> My ideal patch organization would be something like:
>>>
>>> - wrap some existing command in "git submodule--helper update" (probabl=
y
>>>   run-update-procedure)
>>> - absorb the surrounding sh code into "git submodule--helper
>>>   update" one command at-a-time i.e. deprecating and removing the
>>>   commands one at a time - instead of deprecating and removing them all
>>>   at once (like this patch), or deprecating all at once and removing
>>>   them one at a time (like v1).
>>
>> I do think atomic changes that don't leave dead code for removal later
>> are easier to read & reason about, whatever else is reorganized.
>>
>> I.e. not to have something where we replace all the running code, and
>> then remove already-unused code later.

I agree - otherwise patches aren't self-contianed and harder to merge.

>>> - If you think this alternative organization would be helpful for you
>>>   too, I will attempt it. This will take a while, but by the end you an=
d
>>>   I will have effectively reviewed all of the code, so it should be eas=
y
>>>   to finish up the review.
>>
>> I think it might, but I really don't know. We'll just have to see, so if
>> you want to take a stab at it that would be great.
>>
>> Maybe it's a good way forward. E.g. as af first small step we could turn=
:
>>
>>     while read -r quickabort sha1 just_cloned sm_path
>>     [...]
>>     die_if_unmatched "$quickabort" "$sha1"
>>
>> into version where we fold that die_if_unmatched() logic into the C
>> code, and then ensure-core-worktree etc.
>
> Sorry, that one makes no sense since it's an artifact of the shellscript
> implementation.

Whether or not it makes sense, I think it gets the point across i.e.
that we think folding into C can be done incrementally.

>>> - Otherwise e.g. maybe this is a huge waste of time, or you're already
>>>   really confident in the correctness of the sh -> c when you reviewed
>>>   the original patch, etc, I'll just review this patch as-is. I'd
>>>   appreciate any tips and tricks that might help :)
>>
>> I'm not really confident in it.
>>
>> I've read it, tested it as well as I could manage etc. but it's still a
>> very large change.
[...]
> But I tested the below on top of master, and it passes all tests, which
> isn't very promising...

A good enough (i.e. extremely comprehensive) test suite will all but
guarantee that no behavior has changed. Our test suite is nowhere near
that level and probably never will be, so we can't trust that things are
correct even if it passes tests.

So, for the sake of reviewability, I'll take a stab at reorganizing.
I'll be taking a long flight anyway, so I'll have big chunk of
non-company time to spend on this ;)
