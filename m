Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168F0C2B9F7
	for <git@archiver.kernel.org>; Wed, 26 May 2021 10:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E995B6124C
	for <git@archiver.kernel.org>; Wed, 26 May 2021 10:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhEZKJA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 06:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbhEZKI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 06:08:59 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCB3C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 03:07:26 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g7so685800edm.4
        for <git@vger.kernel.org>; Wed, 26 May 2021 03:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=6BcB2I+w3sAaNnUI8OTycGGZ+V/5j4wozBnZNkGA0iA=;
        b=tnNG+uWVQ3tAclqCI3lZ5Tc27xbeO7JD+PTz1KFodQZLoecm4Edpqzg4BRPEdggkuX
         ycXTRPx0QkNWKFmwQYppIccVP+wfCEz2bRPwwlqWQ3znpJeWPvaPekRqdLblplTEhaGN
         w/oFkG7U0ZBD6O0WMhtiiirdIWmT7o4VI9ruDp9Qs8iqNaTFl+ncTNlPMR5bgoTiW3Zl
         h58Bfbfjei7Nq2jgWIBdmQxcmhNKKyhAKDV34Wj5fmP5EuratGIt/ij0XwaAIHchr+W7
         nnvJ3bWfBnuH9lCgHP28tHj483c2T0WGE4f4TJCgqw5UcT+XbURjtL+hauDlYfORQ/vo
         9eCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=6BcB2I+w3sAaNnUI8OTycGGZ+V/5j4wozBnZNkGA0iA=;
        b=J/fEFgpqxjfN/4Jay4NM25AOkop6kqfsPe4EF/gY+yO6Ph2q6UNUEW6TTw2nnbnaoy
         xjE9NPloBAQLz+9lxKg4tcSnwQ6Aatx9DumUVyvNerphKa+w/HPIQ7fXCN5MfltKAPwy
         fD9HahtMTEsmQsRXDwB4GD7k61+qW8WykIJ+uq4jfI1TUDuwHFxW707PKIJfdPxcbppx
         Kpo1O3jTTf6WG/Hv58BDAW5j1E4PeB/aiVedAorBo0JleH7zB4jsApCBFkROcO0gVGxb
         kf9LUFx5K9MGnEDgq3mPEnOXwWKuQ8VYVSJ6PKCAr4aoH/Bjh+KSTaUOsG1l78K01VT7
         1AOA==
X-Gm-Message-State: AOAM5337qZONmQj1gCrr9+3GIwoUMywDkFe7R2nM+fjDPu7iLPl5uUsA
        WpS7Pl3+s0/90AqXUsRAkcw=
X-Google-Smtp-Source: ABdhPJzH92a5YKIOPQi/YP+XZOMAF4gmXay3Z7JpVKgqQENsjAV+dOXdCRf76Ch6cA/KJ6oXn17KZA==
X-Received: by 2002:aa7:c507:: with SMTP id o7mr24869929edq.57.1622023645213;
        Wed, 26 May 2021 03:07:25 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id m19sm12667360edd.12.2021.05.26.03.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 03:07:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 00/21] Prepare tests for reftable backend
Date:   Wed, 26 May 2021 11:52:41 +0200
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
 <878s49pdmd.fsf@evledraar.gmail.com>
 <CAFQ2z_NDKn4vTM_WBrDMumrcTkzS2nOT-cd-TQ=LpTHG+m8Fug@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <CAFQ2z_NDKn4vTM_WBrDMumrcTkzS2nOT-cd-TQ=LpTHG+m8Fug@mail.gmail.com>
Message-ID: <87pmxdn6zo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 26 2021, Han-Wen Nienhuys wrote:

> On Thu, May 20, 2021 at 6:35 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>
>>
>> I looked this all over and left some nits, suspect/probably/definite bug
>> comments on specific patches, the ones with no comments from me LGTM.
>
> Awesome. Thanks for reviewing. I'll try to go over your comments this wee=
k.
>
>> I intentionally didn't review my own earlier feedback on v1 to look at
>> this with fresh eyes, I'd forgetten what points I raised, aside from the
>> general "let's not skip tests but test the new behavior" mantra I think
>> I either mentioned there or in related discussions.
>
>
> "test new behavior" is troublesome, because it requires merging the
> reftable support first, which in itself is a tough job, and predicated
> on getting reviews for that code. This is why I split this series off,
> because it can be merged early without impacting coverage of the
> existing loose/packed backend.
>
> How about I document more clearly, for each test marked REFFILES, what
> is going on, and what should be done for coverage with reftable? We
> can go over it as part of the reftable series. "REFFILES" will be an
> easy term to grep for.

Indeed, as I pointed out in some (particularly later patches) v2
commentary there's that chicken & egg problem.

Having re-skimmed my v2 reviews I think these would help:

 A. Just leaning on the side of splitting up tests, e.g in my comment on
    20/21[1], there's a test with file backend specific logic there, but
    also a general assertion. Should just be two tests.

 B. My suggestion in 15/21[2] to split up maybe make these two
    prerequisites, i.e. REFFILES and REFTABLE.

    One one hand it's a bit silly to have two prerequisites required for
    the one reftable mode we don't have yet, and as long as we just have
    two backends it'll be an informed guess at best.

    But I'm leaning on the side of it being a good idea, to clearly
    document those cases that are really files-backend.c specific, such
    as low-level test to check that a .git/HEAD exists along with a "git
    rev-parse HEAD" for that backend.

    And then REFTABLE (and !REFTABLE) to test/skip things that are
    specific to the behavior of reftable, but not in a way that has to
    do with the "ref files" v.s. "a ref database" distinction. E.g. a
    maintenance command calling pack-refs is skipped under REFTABLE, but
    one could imagine us e.g. having a PostgreSQL backend where that
    would be mapped to "VACUUM refs" or whatever. I.e. it's
    testing/skipping based on reftable-specific features.

    Even if strictly speaking we'd make no use of the distinction now in
    that you could losslessly map REFFILES =3D !REFTABLE and REFTABLE =3D
    !REFFILES.

    Or maybe it's useless and we'd want to eventually do a second pass
    over both REFFILES and REFTABLE to see if we need to change them to
    positively assert the behavior of the "other" backend in both
    cases. Just a thought...

1. https://lore.kernel.org/git/87eee1pfzk.fsf@evledraar.gmail.com/
2. http://lore.kernel.org/git/87pmxlpgb1.fsf@evledraar.gmail.com
