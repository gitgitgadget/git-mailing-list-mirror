Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8F9C433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 07:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B1B613D1
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 07:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhDNHjM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 03:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbhDNHjL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 03:39:11 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F997C061574
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 00:38:50 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r9so29903702ejj.3
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 00:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=VZweW2jAwbMFf9qPE9bJuLeOC+y0zwy+eLOoGu1ynnk=;
        b=Y8zR4BL8+gK/+V8T4RtXPpFGWbFcuylFAQuGu4GoMFwPrwgkMnUNfh8K6V+rFI5+Tb
         qrZNGpg98H9wtbuXnbwnizceLR2S6PZHyTwe0XfUupabsbjkfjXfEMSmXxSj7BDo+q6K
         Ew7IhOiYkJpr9Trp2ctca4ge8gLYNEa636pL+eX8Z/ot/kezmqUIr74aIRZ+CZuwX3ac
         stXMjRRG1njnrGLKcKfwX0Npu667yoya2zTy0oVYWrUkQsrl/r/z8D5LGvWC3LpfTiJU
         UymRpXns58KqGCbLLu2wyoqRhSNHEMARAYPOaN086S3tFczZE/jorHz8GncYdsFNSkVa
         MkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=VZweW2jAwbMFf9qPE9bJuLeOC+y0zwy+eLOoGu1ynnk=;
        b=MW5rgWB8alVOBC7wstgCwQN52QwGKOdOL4QIavxzAU/F50uVLGrl/ZUtGlxEOhI/cy
         nAcvZGPbinumgGTAa/TNrqaA9lesxlgnAe5r31SQITXLl3zY5cAKiiC1fHUu3pSOKCbo
         Cn1hukEybv3gdisR2CxF3tOklODzlfV2MtSzdSQJ0GZp5HEdQZoUw3bp18cPnvSG6niR
         dtf35SMUm86JkXEzYfla4YZjI6pMtd39wSY2QpEYCl6JhioNvMapjZgfnIk/RTTikNEZ
         eV+GueA8eb0BJdCh1PdI+wc34YaV2s4moLFVz4ScVfEJBq1yIDLdof9R9xurlaUXNYGb
         ELgA==
X-Gm-Message-State: AOAM531aE+0EXH5v+r9YBFquLEPxRb5ZsZPmwK3IojrzwIcoBJ8GgH/8
        hCx70tTR0jr9WnYJ/LzqhCk=
X-Google-Smtp-Source: ABdhPJzoNFRDmzF2Kw5uLdUsKGNyl1CVAogqBA1U73dBZxgJ5T/jUtQMsK3ix79FYlzupJtRNsvqYw==
X-Received: by 2002:a17:906:4a90:: with SMTP id x16mr15785950eju.44.1618385928969;
        Wed, 14 Apr 2021 00:38:48 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ju23sm9357469ejc.17.2021.04.14.00.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 00:38:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] diff tests: rewrite flakyness-causing test "aid"
References: <patch-1.1-f0542cd902c-20210413T121930Z-avarab@gmail.com>
 <cover-0.2-00000000000-20210413T122645Z-avarab@gmail.com>
 <patch-2.2-c2cb52b6605-20210413T122645Z-avarab@gmail.com>
 <CAHd-oW4G+7z3UM3qjhPp=2oqOPE4a49fweew0n+gheGtQEy5VA@mail.gmail.com>
 <87fszu2elw.fsf@evledraar.gmail.com>
 <CAHd-oW6D7Tmp2TmrmGvXDt-NnT_wxhfr_bn_P_7=ot=m_2eyyA@mail.gmail.com>
 <874kg92xn0.fsf@evledraar.gmail.com> <xmqqim4pz83e.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqim4pz83e.fsf@gitster.g>
Date:   Wed, 14 Apr 2021 09:38:48 +0200
Message-ID: <871rbd2u47.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 14 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Tue, Apr 13 2021, Matheus Tavares Bernardino wrote:
>> ...
>>>> >>         actual=3D"$pfx-diff.$test"
>>>> >>
>>>> >>         test_expect_$status "git $cmd # magic is ${magic:-(not used=
)}" '
>>>> >> +               test_when_finished "rm $actual" &&
>>>> >
>>>> > Nit: before these two patches, "$actual" was only removed when the
>>>> > test succeeded. So, in case of failure, the failed output files would
>>>> > still be there for debugging. It might be interesting to keep this
>>>> > behavior and only remove "$actual" at the end of the test.
>> ...
>> Ah, yes that's a problem we should solve, but I think we should not put
>> off migration to test_when_finished because of that.
>>
>> The whole reason we use it is to clean up the work area for the next
>> test.
>>
>> Thus if we do:
>>
>>     git something >expected &&
>>     test_cmp expected actual &&
>>     rm expected actual
>
> Isn't it a poor example to use to argue for your particular change,
> where $actual in the original is designed to be unique among tests,
> in order to ensure that $actual files left after test pieces fail
> would not interfere with the tests that come later?  IOW, there is
> not a reason to remove $actual until the end of the test sequence,
> is there?

Not really, because you needed to read the rest of the test file to come
to that conclusion.

The point of using a helper that guarantees cleanup such as
test_when_finished or test_config over manual "git config" or "git rm"
isn't that we can prove that we need it because a later test needs the
cleanup, but that anyone can add new tests or functionality without
having to worry about cleaning up the existing trash directory.

So yes, it's not needed here, but that's only because we know the rest
of the tests don't have e.g. a test that does a:

    for file in t4013/*

Anyway, that's only half of the example I cited for why we should use
test_when_finished in general, the other half was noting that because
we've semantically annotated cleanup tasks we can smartly handle those
for debugging, e.g. stash the "removed" files away, and if the test
fails present them to the user.

