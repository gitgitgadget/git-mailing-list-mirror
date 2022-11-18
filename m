Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF03C4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 12:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbiKRMYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 07:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKRMYc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 07:24:32 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CC1970A2
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 04:24:31 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id f18so12657176ejz.5
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 04:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VEMWFXqounCDxt9SB0qTRpG7en7JapqnVTCDgf74Ikk=;
        b=CgyyrkGUbjSgaOs50sWQnhQo9mm4YCVWqq09VV4XY8fXIVOJUERj/dv6tICQQ7+3cE
         cdzsmCFyaG0G1fTywKPMHQZwZZsgEs2xADpPua/tF+MnXORR/237OUfo6/5++efALGLZ
         VQy2srsaZBDRnizXuRzaKIxJfXKPi4/4Y9FOerlF9d2Xd87TeSl5L87OZUC9QVsG+05z
         J9IAK6NnbT5We429gzecCwHTH+RByViSaTDaSTJt87hD53LoLgk7M31MUtFlQWocJnLx
         N6yhdSD5kfD7GMVyvhiZPZAxb7P8dsO2aSfj9fXBXtHcSTJE/Q6CMp04b2TIJbjhjxZM
         4UEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VEMWFXqounCDxt9SB0qTRpG7en7JapqnVTCDgf74Ikk=;
        b=VbS4bd/mjV/ufC6kqwLjHizROmPRVWhFXvU1vMKPWHACyY+gayynbtsTXdO6+TDNU9
         gX4Ve+PQdJ7VfYTBT2JQCQhAZNRN2rvleuPo4OD40nsfdLBN6uR7p7VYvrAOKePqkJpN
         1NIYeyu9GZyYjQQPWVE/rvILjou59af88/0PfgMArTdjWlyxf/TnURqQEOAn+TDiPYjy
         83tYuaj5i/Mn9QW4dXYyfq4VMucpSuh7gUULBlYfDMdJtHICD2Wim9sACpdm6Jn0iBeM
         FImawC4NZpgcuNwC0rF/Qj8bXzkz6JLROhj0oXlqxJ0rxV7iTz6qPvJ1ifjrIOftZ1Gh
         Rk1Q==
X-Gm-Message-State: ANoB5pnrBbiy1/DEjAZ4hKMFEvaV+uaDK2+05cqHTlLmtiXMLIRVs/cB
        BGIvU5pbB9nE8t0PWW+oqANmuys5ja3Ceg==
X-Google-Smtp-Source: AA0mqf76OPsmeNLErmjynwuUVXHa2FPMTchk0laLrIpeU/XoJzpYcTNIwV7ET0GlwOAc59c6ML127A==
X-Received: by 2002:a17:906:19d6:b0:7ac:9917:c9c6 with SMTP id h22-20020a17090619d600b007ac9917c9c6mr5836671ejd.325.1668774269769;
        Fri, 18 Nov 2022 04:24:29 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id eq12-20020a056402298c00b00461c1804cdasm1756093edb.3.2022.11.18.04.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 04:24:29 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ow0Q0-005San-2W;
        Fri, 18 Nov 2022 13:24:28 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/12] tree-wide: chip away at
 USE_THE_INDEX_COMPATIBILITY_MACROS
Date:   Fri, 18 Nov 2022 13:21:27 +0100
References: <cover-00.12-00000000000-20221118T112205Z-avarab@gmail.com>
 <51e91e8f-f11c-be8c-a23d-566eb3fbb387@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <51e91e8f-f11c-be8c-a23d-566eb3fbb387@dunelm.org.uk>
Message-ID: <221118.86v8ncfo1v.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 18 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 18/11/2022 11:30, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> As 3/12 here notes we've been undergoing a sloooow migration away from
>> functions that provide "the_index" for you since 2007, with the last
>> major move away from some of them being in 2019.
>
> The commit cited in 3/12 actually introduced most of these
> macros. What it did was remove the dependency on `the_index` from
> cache.c. Maybe I'm missing some context but I struggling to see the
> benefit in removing the macros with out removing the dependency on
> `the_index`. Doing that would require much more manual work as it
> cannot be automated with coccinelle but it would provide a tangible
> benefit which I don't see here.

I didn't cover this myself as I figured the linked-to commits & context
covered it: But no, there is no great benefit to doing this, it's just
janitorial work.

My proximate motivation for this is having written this to libify some
code in a parallel series: [1].

Does that in itself justify this? No, far from it. But we've had this
supposed online migration for years, I tihnk we shouldn't rush to do
those sorts of things needlessly (e.g. let's avoid conflicts with other
in-flight stuff, if it can be helped), but leaving it for another 4-10
years would also suck.

1. https://lore.kernel.org/git/patch-v9-09.12-f29343197eb-20221118T110058Z-=
avarab@gmail.com/

