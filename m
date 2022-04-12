Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CECC433FE
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 10:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351658AbiDLKBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382343AbiDLIY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 04:24:59 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71045A175
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 00:58:52 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bh17so35628017ejb.8
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 00:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=rDYV9KMVE1SSpuCpcJSE8wMl/kMOS37l3JnXS6teZZQ=;
        b=QHnhl5itD4kqtQ42759f+jego8Pnf501huLZbqMCWWQ9tslaSAQQQZ1lbPAMJ6M2wT
         ksHqTyFIQZ/Z73LDYusymHQLIxtcSK5Z1qKUqLFDIirb3XHo3dN0E5x1lMdH2TR1B/i6
         hV0WrxY7OE3XMhl8mpi48KzHlthNs4v6a79uyeQyZRwkxku0gYABY8eKcQqJp65EoZgR
         bfdJjvWhangKC6vOxMxfGoKRlW3kO4a3V+NpKnvFg4SbHuUDd4vBClmz+tRm5lPtTI6p
         1yMLMrbVrNRnx/hpZUBgtdGqgAuNKMTZn8oyZMrZXGJv4I3c18zBmjr+RFThLXgWWsT5
         ztDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=rDYV9KMVE1SSpuCpcJSE8wMl/kMOS37l3JnXS6teZZQ=;
        b=SQV6LkancflhWPV9iHFFn6A3x9ZxvZw/7SfcJAk4pWsP6mrqZtLnhJvEsMvGXKmrzN
         b8UZr8R8NOtbXI+rtSe8MrKdbf3FozgRBDJwC6lRimFPZA80qNEiAUIb5dPGDBlJN4mv
         GecPFU7S1LqWlC64TNab6ISX/ILQ4o9UMvGwHvHblSD+/labtiiOphaPY8UZqqfxjSxg
         cWZJd+uxy9t09kCii6PJuppHJH0xTivfU7lvYcnaGUjn2VdBvm4KgQPLuMbeu8DN9GxM
         nlt2Ist0AtvbGsajumwqykL87+VE9evq/c4ggeqKDh9liAwGpv9JVGighYRn0JDUI/SH
         bPUA==
X-Gm-Message-State: AOAM530u6G89nNHDJUemCPFPlGWD6WumKEvqAaj7GlHxJIVxyw+Nd+ic
        kR+oaM8ESbnEKpvJ86xhXmU=
X-Google-Smtp-Source: ABdhPJxy5r0+epxwwxKiJixr8Tlb3aXlS3KLP460LcyBfSBmoVzB5NKDLLmO88n3BjZZN5AAlMM6kw==
X-Received: by 2002:a17:907:3f82:b0:6df:919c:97a with SMTP id hr2-20020a1709073f8200b006df919c097amr33523635ejc.19.1649750331046;
        Tue, 12 Apr 2022 00:58:51 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w14-20020a170906d20e00b006cee22553f7sm12868867ejz.213.2022.04.12.00.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 00:58:50 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1neBQH-004VTW-Ca;
        Tue, 12 Apr 2022 09:58:49 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Makefile: add a prerequisite to the
 coverage-report target
Date:   Tue, 12 Apr 2022 09:51:35 +0200
References: <20220409043033.1288946-1-gitter.spiros@gmail.com>
 <xmqqv8vfiidm.fsf@gitster.g> <220411.86fsmji970.gmgdl@evledraar.gmail.com>
 <xmqqpmlnfcq1.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqpmlnfcq1.fsf@gitster.g>
Message-ID: <220412.8635iiivgm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 11 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I haven't come up with a patch for these coverage targets, but I think
>> it would be much more useful to:
>>
>>  * Not have the target itself compile git, i.e. work like SANITIZE=3Dlea=
k,
>>    there's no reason you shouldn't be able to e.g. combine the two
>>    easily, it's just a complimentary set of flags.
>>
>>  * We should be able to run this in parallel, see
>>    e.g. https://stackoverflow.com/questions/14643589/code-coverage-using=
-gcov-on-parallel-run
>>    for a trick for how to do that on gcc 9+, on older gcc GCOV_PREFIX*
>>    can be used.
>>
>>    I.e. we'd save these in t/test-results/t0001.coverage or whatever,
>>    and then "join" them at the end.
>
> I can see how this might lead to "Ah, *.coverage file exists so we
> run report to show that existing result", but it is not reasonable
> to say "we didn't touch t0001 so we do not have to rerun the script
> under coverage-test" because whatever git subcommand we use may have
> be updated (we _could_ describe the dependency fully so we only
> re-run t0001 if any of t0001-init.sh, "git init", "git config", and
> "git" is newer than the existing t0001.coverage; I do not know if
> that is sensible, though).  And ...

I've done some experimenting with having "make -C t t0001-init.sh" only
run if the underlying code changed, which we can do by scraping the
trace2 output, generated*.d files, and e.g. making t0001-init.sh depend
on whatever builtin/init-db.c and the rest depend on.

But that's not what I'm talking about here, I'm just saying that we'd do
a normal "make test" where we write the gcov tests per-test into
t/test-results/t0001 and join them at the end of the run.

So the equivalent of a FORCE run, just like now.

>> I wonder if the issue this patch is trying to address would then just go
>> away, i.e. isn't it OK that we'd re-run the tests to get the report
>> then? gcov doesn't add that much runtime overhead.
>
> ... I don't think overhead of gcov matters all that much.  Overhead
> of "Having to" rerun tests primarily comes from running the tests,
> with or without gcov enabled, so...

No, on a multi-core machine the inability to run with -jN is the main
factor in making this run slow. E.g. on my 8 core box the tests run in
2-3 minutes with -j8, with -j1 it's 20-25 minutes.

(-j1 numbers from wetware memory, I didn't want to wait for that slower
run while writing this, which is pretty much the point...).

So I'm wondering if the desire to keep the old coverage report around is
synonymous with the current implementation running so slowly.

We could also make that work, e.g. with order-only dependencies, but if
this doesn't run in ~30m but instead in ~3m with -jN v.s. -j1 perhaps we
could just treat it like we do "make test" itself.

> Or are you suggesting that we'd enable gcov in all our test runs by
> default?

No, just that when you do want to generate this report that we can make
it happen much faster than we currently do.

The GCC manual discusses all the ways to easily make gcov work with
parallelism, these rules just didn't use those methods.
