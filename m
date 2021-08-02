Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2578C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 12:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D770D60E09
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 12:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhHBMyx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 08:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbhHBMyv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 08:54:51 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EA4C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 05:54:41 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id cf5so12788677edb.2
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 05:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=1kivBecigd3M/QTWUbM2num/wy2WkjkmpmxSDCw+l20=;
        b=phqBD+okZrE8QMtjXFR0bl5d1wizrWHD4SJqlWFLrtCi3YAGSHkNmbx1N1vr10a1K5
         6AtXzBqztyehUckhWiOpSG+aYWJzcknUkrWt6mGzkS+N8NZl02KNpmKsTT77SlMVqAqy
         8DfzYSGaSFPQ7rh4n6etMwovk189ctGKvlreCLvOeBcU+jvnFrlYcykDgse5QWABv6ui
         eveP48sMzHohDOaipkjbCJDwOQNfBzut3obpQlaDjNlqTNhBu4JjcJ0rU1cp9y64qDzO
         EtFDY6UxyTxpJR+nYY3Sdjmu224dDEe0qa1CbVK6k/a0diyERPBI/VH61n9l4ws7dCTu
         YFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=1kivBecigd3M/QTWUbM2num/wy2WkjkmpmxSDCw+l20=;
        b=cskAuP8XEmsOha+WBXO/85bqY7Je5QEYuvs3Wq4l3gXVvkU28BOKZzJZ1mxCcMqO95
         omVhjbdWettpP1tGPh6j4MXO13DIejvfll7HbHpd8HsMwB3T8CXn4fb8esIz9Duoh5EM
         2ibshB957ISf0QRfkhfb78kcfVwyQJMiUmkuYrk1hE4RP0/RJI/lp2w8kk80kJ3baa9F
         AFWIQQ9BQLeaC+isu1WBqlzY+TMcdWEPY84dYRxIZaezJqwZP3mZ0f1PFzZlaM0BrIez
         7xvQwzuc8UyOx1oc+3FY6Lb3FM9J4gKhwN0qquH8qiddv/2EW3TCt28gKU5qa0+ipTA/
         ksVw==
X-Gm-Message-State: AOAM530cgBsuUKQgKKIYNRw6ulnv346ABEJ6v4goeuQhK55E9PbbdDfx
        g5KNtZg7kJ3OLW9OkiHolxo=
X-Google-Smtp-Source: ABdhPJwsWK/E+p4n5+VS1QI+arWpkDD3UWeNAbouA7zd6HWcyKbXWZa9Y8C7t0UFTQ5gbgwf2IH+zw==
X-Received: by 2002:a50:8fe1:: with SMTP id y88mr18921902edy.101.1627908879533;
        Mon, 02 Aug 2021 05:54:39 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id e27sm4568493ejc.41.2021.08.02.05.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 05:54:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/4] revision: stop retrieving reference twice
Date:   Mon, 02 Aug 2021 14:53:30 +0200
References: <cover.1624858240.git.ps@pks.im>
 <cover.1627896460.git.ps@pks.im>
 <db854806498b316b4f59c33d70a1ea9c1401fdb7.1627896460.git.ps@pks.im>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <db854806498b316b4f59c33d70a1ea9c1401fdb7.1627896460.git.ps@pks.im>
Message-ID: <87y29knh0x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 02 2021, Patrick Steinhardt wrote:

> [[PGP Signed Part:Undecided]]
> When queueing up references for the revision walk, `handle_one_ref()`
> will resolve the reference's object ID and then queue the ID as pending
> object via `add_pending_oid()`. But `add_pending_oid()` will again try
> to resolve the object ID to an object, effectively duplicating the work
> its caller already did before.
>
> Fix the issue by instead calling `add_pending_object()`, which takes the
> already-resolved object as input. In a repository with lots of refs,
> this translates in a nearly 10% speedup:
>
>     Benchmark #1: HEAD~: rev-list --unsorted-input --objects --quiet --no=
t --all --not $newrev
>       Time (mean =C2=B1 =CF=83):      5.015 s =C2=B1  0.038 s    [User: 4=
.698 s, System: 0.316 s]
>       Range (min =E2=80=A6 max):    4.970 s =E2=80=A6  5.089 s    10 runs
>
>     Benchmark #2: HEAD: rev-list --unsorted-input --objects --quiet --not=
 --all --not $newrev
>       Time (mean =C2=B1 =CF=83):      4.606 s =C2=B1  0.029 s    [User: 4=
.260 s, System: 0.345 s]
>       Range (min =E2=80=A6 max):    4.565 s =E2=80=A6  4.657 s    10 runs
>
>     Summary
>       'HEAD: rev-list --unsorted-input --objects --quiet --not --all --no=
t $newrev' ran
>         1.09 =C2=B1 0.01 times faster than 'HEAD~: rev-list --unsorted-in=
put --objects --quiet --not --all --not $newrev'

It might be worth calling out explicitly that it's not just
"effectively", but that add_pending_oid() is just a thin wrapper for
get_reference() followed by add_pending_object(), so we're guaranteed to
get the exact same result here as before, just without the duplicate
work.

I.e. we're not going down some other lookup path that uses object
lookups with different flags or whatever as a result of this change.
