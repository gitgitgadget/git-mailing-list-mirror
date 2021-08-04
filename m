Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEBFC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 11:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C315C6104F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 11:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbhHDLCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 07:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbhHDLCR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 07:02:17 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9744C0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 04:02:03 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id hs10so3191761ejc.0
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 04:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=0QeuJOv9TzuAXW0V1Jc6t3lKPykN8iyGFo7GhuWCHT4=;
        b=Q4PyNDhZs+gfHuDpM2p0GLMuh9mXXP/WDucqcV8zzL1+iSkJ8Hn2JxLp26XdBYtjKP
         C51kC8b4Ei15Hc1k5siEam91bgw0KPsux2spi7jRY3qEZmagsCZeSzIZR/IEBarprPYB
         gf4hNSLCA8tEqhZm/jeCP5OQNfvH+QIZ2VbxbMXOOtHSsNBl9ms8f49rj6OVuRYrKdSJ
         A+uSmAhpLY/ozt6lkBLm5KLerEeX65wuXyVeKsT5sH9+2Dy1AT5YscwfimxmRNyzxOrY
         U24PQn7NT5BGZRAhb64oZInMxxjnYrq8VeO4dT3y+7u8fNVWfegxxW8WrOSAB5rdD3iW
         AMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=0QeuJOv9TzuAXW0V1Jc6t3lKPykN8iyGFo7GhuWCHT4=;
        b=szKsT4rm5E+KkqzzPHRmHsDuD4iPCzXYNJuqzjs6DwD+3UlJl3XeNxbtld325v2NhV
         GVTSEbWlxHplCpk9vaULzxIkHW6d6iseFEbr0kEfev886YB6VF/hYpPdQQOAePGV+4ht
         /z6OiDrBIsLJWequZE25LHiwNxEblVbl//6PCLqBJHAEl/NMorHz7qIZ3WDCDXec3vDH
         IdZfHcIHhzjdD9upCyq2dWpHWlVNQ9bWu4Fe4NbEu80e22DtkgbokMgzPccwxi+tKo3z
         +ftcJW9usDYOv5eejoydFyzHuPhondLfoGF3NuTjmvxbv1w8RsaL0MfPYPRwka4UvA7u
         d7Og==
X-Gm-Message-State: AOAM530xx1idc6xef43CXXofvZHZTpLzwXs5cbXR+/MHR18J6TKso2wJ
        czxtOrO6gpKdAlPI7mgeaKI=
X-Google-Smtp-Source: ABdhPJwIkPTAj73nkN/cGwuhCHA0CT7ph+OGt7R0V6WYKKumWkIVrHRLvL+OjaHzGH9/N2oPIgy/7Q==
X-Received: by 2002:a17:907:766c:: with SMTP id kk12mr24520823ejc.525.1628074922099;
        Wed, 04 Aug 2021 04:02:02 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u2sm797875edd.82.2021.08.04.04.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 04:02:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 1/4] connected: do not sort input revisions
Date:   Wed, 04 Aug 2021 13:01:19 +0200
References: <cover.1624858240.git.ps@pks.im>
 <cover.1627896460.git.ps@pks.im>
 <1fd83f726a04dfb5be27c74cb116618cb76be923.1627896460.git.ps@pks.im>
 <871r7covsa.fsf@evledraar.gmail.com> <YQkDQY9Qyqi7FCg6@ncase>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YQkDQY9Qyqi7FCg6@ncase>
Message-ID: <87r1f9mq1j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 03 2021, Patrick Steinhardt wrote:

> [[PGP Signed Part:Undecided]]
> On Mon, Aug 02, 2021 at 02:49:29PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> On Mon, Aug 02 2021, Patrick Steinhardt wrote:
> [snip]
>> > Introduce a new "--unsorted-input" flag to git-rev-list(1) which will
>> > cause it to not sort the commits and adjust the connectivity check to
>> > always pass the flag. This results in the following speedups, executed
>> > in a clone of gitlab-org/gitlab [1]:
>> >
>> >     Benchmark #1: git rev-list  --objects --quiet --not --all --not $(=
cat newrev)
>> >       Time (mean =C2=B1 =CF=83):      7.639 s =C2=B1  0.065 s    [User=
: 7.304 s, System: 0.335 s]
>> >       Range (min =E2=80=A6 max):    7.543 s =E2=80=A6  7.742 s    10 r=
uns
>> >
>> >     Benchmark #2: git rev-list --unsorted-input --objects --quiet --no=
t --all --not $newrev
>> >       Time (mean =C2=B1 =CF=83):      4.995 s =C2=B1  0.044 s    [User=
: 4.657 s, System: 0.337 s]
>> >       Range (min =E2=80=A6 max):    4.909 s =E2=80=A6  5.048 s    10 r=
uns
>> >
>> >     Summary
>> >       'git rev-list --unsorted-input --objects --quiet --not --all --n=
ot $(cat newrev)' ran
>> >         1.53 =C2=B1 0.02 times faster than 'git rev-list  --objects --=
quiet --not --all --not $newrev'
>>=20
>> Just bikeshedding for a potential re-roll, perhaps --unordered-input, so
>> that it matches/rhymes with the existing "git cat-file --unordered",
>> which serves the same conceptual purpose (except this one's input, that
>> one's output).
>
> Yeah, I wasn't quite sure how to name it myself either. Internally, we
> typically use "unsorted" instead of "unordered", and there's also the
> preexisting "--no-walk=3D(sorted|unsorted)" flag for git-rev-list(1). With
> the latter in mind, I think that "unsorted" fits a bit better given that
> we already use it in the same command, but I don't particularly mind.
>
> For now, I'll keep "--unsorted-input", but please feel free to give me
> another shout if you disagree with my reasoning.

Sounds good. I didn't mean it as a strong suggestion, unsorted does
indeed sounds better in this context, just a gentle poke to check if you
knew about that similar option...

Thanks.
