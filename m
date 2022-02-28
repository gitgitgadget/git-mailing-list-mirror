Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E62FC433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 22:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiB1WfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 17:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiB1WfL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 17:35:11 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC00611C7CB
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 14:34:31 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id bg10so27801269ejb.4
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 14:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=1y2zFCvXFgpCjzitZokicqq+DUE7gqbPuqlA6gTNVkc=;
        b=gO9A17Kg3/0VlGfPVPYpaLbMaECOVu37n9KuMsbjoxpFBiYBAfwQ/Rfuor6uEj/kju
         zHa0vgclevn+eyUUlm2AFb5OfaNidxV7KMI0FTQ0B5k+qG0dMbzh9M2iRWr/OEsw9rhF
         x0APQnER4ZN318o6UDMbVD5z6MN3+286QFy3HKEnjypxGdZoI+yf7em0qhONvCrJoLU9
         4BQeY4UeBQkNFMEAvke+y8CSk3ZUUZFActoJN9aV8/TX3tXA8RyXbfF1RKOO2c6jnFTW
         0jUJlaAP8j1eA1gTX7ITbRKxe8SIetWSoDjgIDaEf5jAyOuKRKFpFTtIwLNfnPJMnZg4
         qzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=1y2zFCvXFgpCjzitZokicqq+DUE7gqbPuqlA6gTNVkc=;
        b=2jAK2FLrvfq0NyIoI1YD7CJxvA4MnPuOMrxHoc5PoqEjIqHvpZ39A890ANH+VJWYsW
         u8/ZhR9ffp6RN+cR8ipRQ37eMQQzZ6F/sA9oPzvFrVCNain6SGzFl58olkP5RMHnPD5F
         fkZuza2n6XXhvES96YGJxXRCv/KyO0CsTy176Lcudb/0xNgTJJxrQXtMKNA6nd3zzvLL
         pXmjSIbS4awDXMvYo7OuZT9X7ZBC9D5DIq808iRY/NLH0DJ74efiqfNYyaAhdzk58M2D
         4Da4Ll8xh20CQGT9gg7mfaInkFAw9cCZlzppU3JH7gKb7nq5gPSegusTkYcR61To1t1/
         9dVw==
X-Gm-Message-State: AOAM533BH2rssipbilWzFqyrdrRUPFNT+4P1Nr89OkQ2Iax7aqszxlrk
        hm9KAtgi95GvUCKxBneJBjwCjcp/1tU=
X-Google-Smtp-Source: ABdhPJwyCcau0L4syU+sqa1wyZA4AhuNxPxdaLj0GVGJ/xuwZ514MHnXhFba4DI9Oo8MKxGJ9+BwHg==
X-Received: by 2002:a17:906:506:b0:6d6:e3c7:4c43 with SMTP id j6-20020a170906050600b006d6e3c74c43mr800440eja.456.1646087669981;
        Mon, 28 Feb 2022 14:34:29 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r22-20020a17090638d600b006d584aaa9c9sm4730515ejd.133.2022.02.28.14.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 14:34:29 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nOob6-001cjE-PS;
        Mon, 28 Feb 2022 23:34:28 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Robert Coup <robert@coup.net.nz>
Cc:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/8] fetch: add repair: full refetch without
 negotiation (was: "refiltering")
Date:   Mon, 28 Feb 2022 23:20:59 +0100
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
 <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
 <220228.86r17n2aqd.gmgdl@evledraar.gmail.com>
 <CACf-nVcy8xsf+STJoE5vwcsUauHRcR5wmwmCfnUnSW=4jDcgYQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CACf-nVcy8xsf+STJoE5vwcsUauHRcR5wmwmCfnUnSW=4jDcgYQ@mail.gmail.com>
Message-ID: <220228.86ee3m39jf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 28 2022, Robert Coup wrote:

> Hi =C3=86var,
>
> Thanks for taking the time to look into this,
>
> On Mon, 28 Feb 2022 at 16:54, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <ava=
rab@gmail.com> wrote:
>> I realize this was probably based on feedback on v1 (I didn't go back
>> and re-read it, sorry).
>
> Yes, `fetch --repair` was from Jonathan Tan's v1 feedback[1], where he
> pointed out it could fill in lost objects from any remote in a more
> generally useful fashion.
>
> My goal here is to refetch with a different filter so that I get the
> outcome of a `clone --filter=3D` without having to chuck my object
> directory. But the actual implementation doesn't need to know anything
> specific about filters, so the original "refilter" name I had isn't
> really right.

*nod*

>> But I feel strongly that we really should name this something other than
>> --repair. I don't care much if it isn't that :) But maybe
>> --expand-filters, --fleshen-partial or something like that?
>
> fleshen-partial sounds like a horror movie scene to me.
>
> 1. `--refetch`
> 2. `--as-clone`
> 3. `--expand-filter` (though TBC you don't necessarily need a filter)
> 4. `--refilter`
> 5. something else

*nod*

>> So first (and partially as an aside): Is a "noop" negotiatior really
>> want we want at all? Don't we instead want to be discovering those parts
>> of our history that are closed under reachability (if any) and say we
>> HAVE those things during negotiation?
>
> At an object level we don't have any means of knowing what has or
> hasn't been obtained via fetch to a partial clone with different
> `--filter` args (via config or cli), dynamic fault-ins, or sourced
> from a different remote. Fetch negotiation only occurs for refs and
> their associated commits/histories, but filtering occurs at the blob
> or tree level =E2=80=94 so we often HAVE a commit but not all of its
> trees/blobs, whereupon negotiation skips that commit and all it's
> associated objects.

Yes, I'm basically asking if the negotiation part wouldn't *ideally* be
doing basically the same "everything is connected" check
receive-pack/fsck do.

I.e. you've got partial data with promisors locally, but if you walk
your branch histor(y|ies) you'll discover that N commits down we have
all the prerequisite objects locally.

As an aside there's a 1=3D1 mapping between that and what "git bundle
create" will do/verify to create a bundle without listed
prerequisites.

I.e. I think you'll find what it does with revision.c and PREREQ_* and
other flags INTERESTING (a lame pun on its use of UNINTERESTING :).

Presumably the code needed to drive such a negotiation would be useful
for other neat stuff, e.g. having a some-partial repo locally, wanting
to fetch the PACK to complete it from the server, and knowing you have
that data to create a fully connected (or incremental) bundle for that
repository, but I digress.

>> But secondly, on the "--repair" name: The reason I mentioned that is
>> that I'd really like us to actually have a "my repo is screwed, please
>> repair it".
>
> Feels like people would look at `fsck` for that over `fetch`? Maybe
> not. Anyway, I get the point about the naming still not being right
> :-)

I think that definitely would be fetch/gc over "fsck". I.e. if you've
got corruption fsck can only tell you that it's screwed.

It's fetch/gc (or "git bundle unbundle") that stand any chance of
actually doing the repair, since we'd need to stitch together the
(partially) corrupted local/remote content with a hopefully good
compliment to it.

FWIW I had an ad-hoc implementation of this basically working by
disabling the negotiation + not doing any object existence/collision
checks before writing content to the repository.

That and teaching "repack" to not die and instead to carry on in the
face of object decoding failure (and hopefully discover a "duplicate"
but good copy later) + "gc" is enough to repair most corruption,
e.g. truncated loose object etc.

>> But (and I haven't tested, but I'm pretty sure), this patch series isn't
>> going to give you that. The reasons are elaborated on in [1], basically
>> we try really hard to re-use local data, and due to that & the collision
>> detection will often just hard die early in object walking.
>>
>> But maybe I'm wrong, have you actually tested this with *broken* objects
>> as opposed to just missing ones with repo filters + promisors in play?
>> Our t/*fsck* and t/*corrupt*/ etc. tests have some of those.
>
> Correct: I haven't tested with such objects/broken ODBs. Ideally
> repack/gc/etc would prefer a new-fixed pack over the old-broken
> pack/object but that's not really what I'm aiming to achieve here or
> am interested in.

I think I've only tested loose (bad) + pack (good), I think pack (bad) +
pack (good) probably has some bigger caveats (like the first error
aborting the whole pack read, due to deltas etc.).

But yeah, I'm not saying this should be on your radar at all, other than
the bikeshedding comment of having a --repair that doesn't really do
"repair" would be unfortunate naming, especially if we're locked into
behavior orthagonal to that needed for an "actual" repair.

> 1. https://lore.kernel.org/git/20220202185957.1928631-1-jonathantanmy@goo=
gle.com/

