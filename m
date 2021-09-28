Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BD7C433FE
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 19:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA1F461350
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 19:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242567AbhI1TxV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 15:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242390AbhI1TxV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 15:53:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EA3C061745
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 12:51:41 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x7so72766128edd.6
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 12:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=phTbnp9386DrBgvQ/CAmCu4hAMqudlppcFOFH/TmaxE=;
        b=SzEukaPtX/igsFbz7X7nEtjPOlIdPQkAOlH8msZC/rfI6edsDr0OxM0zPzw8AnIG08
         GyraKxc7vc/FsjgJjCtYby4ekS59mSeU2BP2h2KnCglamBlWiyPazKz8fuKjKdQMVNMV
         6niu4uWSBanl+eVpWOnC5IZ5lJFXkbhowcrp9LJ4JY3AN7cSLgoY3M/HYFZV+uDgLgap
         65YzvU3LFsLvHbNW5LIzh8WJD7EZNUKiA2tbRYj0rPLLPScq+DOPz/ZSf8DUHUhHb0RX
         7ZpxVWYxAzBpDEFThLvt/qznn50m7sM7Jb51g8s08kdjuHHteELmAE9Akbasq4Sel83N
         +NIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=phTbnp9386DrBgvQ/CAmCu4hAMqudlppcFOFH/TmaxE=;
        b=VYEZlcZ5huUWJ+xbQFWPrL3ApW6BBmP1MZUFZd1kdhsqyJ3GLJO7oGwB0ItZo1J8jS
         EW1bMrqIBYto+v7c5x5E9Kmm4zSclmLyRCLybp4LdMcx6vPi+BkFmCQepJODYEqWh9j8
         4q1RvAlThiXrvdj6qZqvG5ej+7iDNrrwoCDMDAag0PcmX2I/uvspwoLaPWlxsCnj8Pjp
         y+iN1skR28rixOGmHbe2ZDGP/S7HBY0/ejnV9rjsmOLPRSoJsdqm0IzgAmwLXQyFGffq
         OBqEovjEeephTWGvbe/Lli0UlB8VXrtfPiUeVZyNLQgjUHnNPK5Jay0D+idQ34KlGTDD
         doBg==
X-Gm-Message-State: AOAM532MFMMxLn1xRTOMQeL6pv3qFz7QQUkdYH6OpozQBuRnTTVPqhbi
        Kj50NcUN4No+zAZvPaNlgNdi/p0ck3/2yw==
X-Google-Smtp-Source: ABdhPJw38psO3P1vPL/S4g531Se+Yek9UMy9ELSPWP3N/zvEVgTrI15/u2aMHzCUbLjV2y/vPVfILw==
X-Received: by 2002:a17:906:f0cc:: with SMTP id dk12mr8638742ejb.36.1632858699846;
        Tue, 28 Sep 2021 12:51:39 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c11sm38611edw.5.2021.09.28.12.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 12:51:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Makefile: add a non-.PHONY "sparse-incr" target
Date:   Tue, 28 Sep 2021 21:45:19 +0200
References: <patch-v3-1.1-b6ba99ca4cc-20210928T011319Z-avarab@gmail.com>
 <patch-v4-1.1-f31fa3e8282-20210928T014023Z-avarab@gmail.com>
 <xmqqy27gk321.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqy27gk321.fsf@gitster.g>
Message-ID: <8735powkad.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 28 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> I.e. per [2] want "make <file>.sp" to *always* run "sparse", even
>> though a corresponding "make <file>.o" would only re-run the "real"
>> compilation if needed.
>
> It is different from my reading.  If <file>.c and what it includes
> haven't changed, it would be fine not to run "sparse".

I was attempting to summarize this part of Ramsay Jones's comments in=20

    [...] Prior to this patch series, 'make <file>.sp' would _always_
    run sparse over the file - it would not depend on the 'mtime' or
    existence of any other file, or run the compiler (and wouldn't leave
    any 'droppings' either). I liked that! :D

> The point of
> running "make <file>.sp" is to see it fail if there is something
> problematic.  If there is any room for the word "*always*" to come
> into the observation, it would be more like "if we cannot make it
> follow the usual dependency rules like the real compilation, we can
> live with it always running, as it is fast enough".  If we can make
> it honor the dependencies, that would give the best of both worlds,
> and we do not have to add an extra target.

...which I think describe something different than what you're
describing here.

I.e. I was under the impression that you didn't mind the incremental
part of it (but Ramsey did), but just didn't want the initial "make
sparse" to take much longer due to the *.o file compilation.

In any case, we can always tweak the "make <file>.sp" later. I don't
mind it working the way it did before, I think the only time I ever make
individual files is when generating the assembly output for them. So as
long as I've got a "make sparse-incr" target I can use.

Do you think that approach in this v4 is OK to move forward?
