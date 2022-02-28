Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF2EC433FE
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 17:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbiB1R3J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 12:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbiB1R2z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 12:28:55 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFA254FBF
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 09:27:56 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id t14so9216893pgr.3
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 09:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coup.net.nz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eAbaN7SSjvYgWmshBNWajLGKh4EJUjr/aMAw5aToTvM=;
        b=H4HBDjSCxLokUObr5s/nvCCXzg48wUmXBg8Ze59rAujs9E18cayvKy3cTdgvMQ6Wpd
         ErQ7TWeqC4KtOwIX5vfb4+9PILJYIPPB18VlHX22RdOsyCgkJrpO/iKgCuuVYKfjTupV
         pGKZZ0c63I4aRKxiFae3l0Wb35weAc0y9FmCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eAbaN7SSjvYgWmshBNWajLGKh4EJUjr/aMAw5aToTvM=;
        b=3/QOdsARGAQ2rxp7L+AxtdHqj7NdtTkqiSxGappd4Oz64IOoGzbd4qSuvxFHP8XZHs
         /YF+8CBMnFPq59YSMof45iQH3YR+FbfT5jkOoXbWJPJXdybmzgS7rOBVqm3OxTk78IEP
         AnjHj5gCGM8Udvt/33nJsmZbYGzpBslwITveLqDtjztzDmnzlTZxSiqRGQprD/Pw+42w
         h4PLs5Kp6uhcAq9eE8kHBKfUrNZtEbDeYlFPW4kri/7MuOCeDEqmfTPivDKIb8RDGklJ
         q1n9TC63of1R8F8o94gAp2cEBsEuiVyMJqMgUWcDZPUcHSiFFyVlYGErw3OzCCTcdn0L
         TlcQ==
X-Gm-Message-State: AOAM5321rhInVzcccFuNkDEgGWDRYtvM018WTs7Do1fvuxnPf0NCRjGq
        JqGioinw9THR5jcs+x4EpXrel67bqlWKqI9jrHG/YHT6H+WBqwR0nq9+Uw==
X-Google-Smtp-Source: ABdhPJzKF/RYUlLoFYNicAO2/z3o1SRn2/krf1Szy7Pt4IMw3eD0TQMqu98gvttILlv4UzJXCfaE4xoqbtwlbLKnQCE=
X-Received: by 2002:a05:6a00:1c4c:b0:4f4:236b:4382 with SMTP id
 s12-20020a056a001c4c00b004f4236b4382mr1234532pfw.29.1646069276053; Mon, 28
 Feb 2022 09:27:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
 <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com> <220228.86r17n2aqd.gmgdl@evledraar.gmail.com>
In-Reply-To: <220228.86r17n2aqd.gmgdl@evledraar.gmail.com>
From:   Robert Coup <robert@coup.net.nz>
Date:   Mon, 28 Feb 2022 17:27:45 +0000
Message-ID: <CACf-nVcy8xsf+STJoE5vwcsUauHRcR5wmwmCfnUnSW=4jDcgYQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] fetch: add repair: full refetch without
 negotiation (was: "refiltering")
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

Thanks for taking the time to look into this,

On Mon, 28 Feb 2022 at 16:54, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avara=
b@gmail.com> wrote:
> I realize this was probably based on feedback on v1 (I didn't go back
> and re-read it, sorry).

Yes, `fetch --repair` was from Jonathan Tan's v1 feedback[1], where he
pointed out it could fill in lost objects from any remote in a more
generally useful fashion.

My goal here is to refetch with a different filter so that I get the
outcome of a `clone --filter=3D` without having to chuck my object
directory. But the actual implementation doesn't need to know anything
specific about filters, so the original "refilter" name I had isn't
really right.

> But I feel strongly that we really should name this something other than
> --repair. I don't care much if it isn't that :) But maybe
> --expand-filters, --fleshen-partial or something like that?

fleshen-partial sounds like a horror movie scene to me.

1. `--refetch`
2. `--as-clone`
3. `--expand-filter` (though TBC you don't necessarily need a filter)
4. `--refilter`
5. something else

> So first (and partially as an aside): Is a "noop" negotiatior really
> want we want at all? Don't we instead want to be discovering those parts
> of our history that are closed under reachability (if any) and say we
> HAVE those things during negotiation?

At an object level we don't have any means of knowing what has or
hasn't been obtained via fetch to a partial clone with different
`--filter` args (via config or cli), dynamic fault-ins, or sourced
from a different remote. Fetch negotiation only occurs for refs and
their associated commits/histories, but filtering occurs at the blob
or tree level =E2=80=94 so we often HAVE a commit but not all of its
trees/blobs, whereupon negotiation skips that commit and all it's
associated objects.

> But secondly, on the "--repair" name: The reason I mentioned that is
> that I'd really like us to actually have a "my repo is screwed, please
> repair it".

Feels like people would look at `fsck` for that over `fetch`? Maybe
not. Anyway, I get the point about the naming still not being right
:-)

> But (and I haven't tested, but I'm pretty sure), this patch series isn't
> going to give you that. The reasons are elaborated on in [1], basically
> we try really hard to re-use local data, and due to that & the collision
> detection will often just hard die early in object walking.
>
> But maybe I'm wrong, have you actually tested this with *broken* objects
> as opposed to just missing ones with repo filters + promisors in play?
> Our t/*fsck* and t/*corrupt*/ etc. tests have some of those.

Correct: I haven't tested with such objects/broken ODBs. Ideally
repack/gc/etc would prefer a new-fixed pack over the old-broken
pack/object but that's not really what I'm aiming to achieve here or
am interested in.

1. https://lore.kernel.org/git/20220202185957.1928631-1-jonathantanmy@googl=
e.com/

Thanks,

Rob :)
