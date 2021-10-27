Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC27C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 20:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E46A3610A3
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 20:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238821AbhJ0U6s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 16:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbhJ0U6s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 16:58:48 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B08C061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 13:56:22 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r12so15788809edt.6
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 13:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=znKShaa49SrtIxSRPjbjxik5OWVf2nk9CozmSe2c1uM=;
        b=LAbw7qp29TAL6qBB+w/AkIVbluqHFYXym9ulD4ohzNOywIj3KPAfn8SgnoVxMxPlZW
         Opv1cXWe9Mwh7pHc/i+bpjYBgZGvq/rE/5Z5VhGVBo9Sok/xVdJpZf57CySzrM/sSZaK
         2KLG97TQ1IK/p2M/ood/mw9WoSg6gK8qKHpJEQE+qB5fV8fDUnohItevP/G23PtD8uTy
         8O4HOTf5ER8iCmncLBK9mfUDrGHpe+KOJOa/BSd194ZoXhyvw1+9cRlXrsizbso+w7Pg
         X5I6xOgzoerNE0W7mmQROuUcg8WGUhCAYC+lY/nhYF0K+ihWa0xgLskZ/xrLUQ+uzmJV
         SzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=znKShaa49SrtIxSRPjbjxik5OWVf2nk9CozmSe2c1uM=;
        b=DlYdTcj6Eo5PQRJpr0UqADKQOA9b7l97ZJzWRMdy3Q+VmuYX0IL2DxTATWBkcUFEM9
         qTF2KRQGDVNdFcxtTK3/nezgUyEEj6vE4RuY4uaucw3ii8f6agz1rZkXbzbGdyVA7+Pl
         YznIHHL80myqasSmCkt7F5qGCFYeyOOhMcDN6Ociqi5G75whZKvRZiAgPaI9Kwpj2k/1
         9o0hKmBfe/v/JrZq5kN5xlGJzlew/jSUhQDko+Zjk/VyQSr09klEaTte42dp+adxGgIH
         QIuhP4roNBkXK28ND4IaJhXbdsI78VQIxVXziRzLI0FqPXj9D7faJNiZzzebZDWI/Yl6
         P1eg==
X-Gm-Message-State: AOAM531BYwtfDz4eM+s9tr2eHDc92Reuyt31ANkBbM7kPxBJ+QO2vC/z
        B094WvY1j+w9ol36Aznc0Ae3ZYArTSQ=
X-Google-Smtp-Source: ABdhPJyC+0aClAGF8VEHrqlLiTyYjQ+AykXe6uytw0Z3Bh9Kk6nicPi3G/iA+Ul4CFDIeZARoV3DuA==
X-Received: by 2002:a17:907:3cb:: with SMTP id su11mr11972423ejb.252.1635368180074;
        Wed, 27 Oct 2021 13:56:20 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r26sm466098ejd.85.2021.10.27.13.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 13:56:19 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mfpy6-0021kl-HC;
        Wed, 27 Oct 2021 22:56:18 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        "Robin H . Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH 2/3] protocol v2: specify static seeding of clone/fetch
 via "bundle-uri"
Date:   Wed, 27 Oct 2021 22:22:28 +0200
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com>
 <patch-2.3-3ac0539c053-20211025T211159Z-avarab@gmail.com>
 <7fab28bf-54e7-d0e9-110a-53fad6244cc9@gmail.com>
 <211027.86r1c6yh52.gmgdl@evledraar.gmail.com>
 <756524c1-a3b9-29b5-bb72-f75a0c76ea1f@gmail.com>
 <211027.86ilxixoxz.gmgdl@evledraar.gmail.com>
 <e3c923b4-cce0-372c-31f4-9f091239ad8b@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <e3c923b4-cce0-372c-31f4-9f091239ad8b@gmail.com>
Message-ID: <211027.86a6iuxk3x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 27 2021, Derrick Stolee wrote:

> On 10/27/2021 2:01 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Wed, Oct 27 2021, Derrick Stolee wrote:
>>=20
>>> On 10/27/2021 4:29 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>>
>>>> On Tue, Oct 26 2021, Derrick Stolee wrote:
>>>>
>>>>> On 10/25/2021 5:25 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>>>> Add a server-side implementation of a new "bundle-uri" command to
>>>>>> protocol v2. As discussed in the updated "protocol-v2.txt" this will
>>>>>> allow conforming clients to optionally seed their initial clones or
>>>>>> incremental fetches from URLs containing "*.bundle" files created wi=
th
>>>>>> "git bundle create".
>>>>>
>>>>> ...
>>>>>
>>>>>> +DISCUSSION of bundle-uri
>>>>>> +^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>> +
>>>>>> +The intent of the feature is optimize for server resource consumpti=
on
>>>>>> +in the common case by changing the common case of fetching a very
>>>>>> +large PACK during linkgit:git-clone[1] into a smaller incremental
>>>>>> +fetch.
>>>>>> +
>>>>>> +It also allows servers to achieve better caching in combination with
>>>>>> +an `uploadpack.packObjectsHook` (see linkgit:git-config[1]).
>>>>>> +
>>>>>> +By having new clones or fetches be a more predictable and common
>>>>>> +negotiation against the tips of recently produces *.bundle file(s).
>>>>>> +Servers might even pre-generate the results of such negotiations for
>>>>>> +the `uploadpack.packObjectsHook` as new pushes come in.
>>>>>> +
>>>>>> +I.e. the server would anticipate that fresh clones will download a
>>>>>> +known bundle, followed by catching up to the current state of the
>>>>>> +repository using ref tips found in that bundle (or bundles).
>>>>>> +
>>>>>> +PROTOCOL for bundle-uri
>>>>>> +^^^^^^^^^^^^^^^^^^^^^^^
>>>>>> +
>>>>>> +A `bundle-uri` request takes no arguments, and as noted above does =
not
>>>>>> +currently advertise a capability value. Both may be added in the
>>>>>> +future.
>>>>>
>>>>> One thing I realized was missing from this proposal is any interaction
>>>>> with partial clone. It would be disappointing if we could not adverti=
se
>>>>> bundles of commit-and-tree packfiles for blobless partial clones.
>>>>>
>>>>> There is currently no way for the client to signal the filter type
>>>>> during this command. Not having any way to extend to include that
>>>>> seems like an oversight we should remedy before committing to a
>>>>> protocol that can't be extended.
>>>>>
>>>>> (This also seems like a good enough reason to group the URIs into a
>>>>> struct-like storage, because the filter type could be stored next to
>>>>> the URI.)
>>>>
>>>> I'll update the docs to note that. I'd definitely like to leave out any
>>>> implementation of filter/shallow for an initial iteration of this for
>>>> simplicity, but the protocol keyword/behavior is open-ended enough to
>>>> permit any extension.
>>>
>>> It would be good to be explicit about how this would work. Looking at
>>> it fresh, it seems that the server could send multiple bundle URIs with
>>> the extra metadata to say which ones have a filter (and what that filter
>>> is). The client could then check if a bundle matches the given filter.
>>>
>>> But this is a bit inverted: the filter mechanism currently has the clie=
nt
>>> request a given filter and the server responds with _at least_ that much
>>> data. This allows the server to ignore things like pathspec-filters or
>>> certain size-based filters. If the client just ignores a bundle URI
>>> because it doesn't match the exact filter, this could lead the client to
>>> ask for the data without a bundle, even if it would be faster to just
>>> download the advertised bundle.
>>>
>>> For this reason, I think it would be valuable for the client to tell
>>> the server the intended filter, and the server responds with bundle
>>> URIs that contain a subset of the information that would be provided
>>> by a later fetch request with that filter.
>>>
>>>> I.e. the server can start advertising "bundle-uri=3Dshallow", and futu=
re
>>>> clients can request arbitrary key-value pairs in addition to just
>>>> "bundle-uri" now.
>>>>
>>>> Having said that I think that *probably* this is something that'll nev=
er
>>>> be implemented, but maybe I'll eat my words there.
>>=20
>> I didn't mean to elide past "filter", but was just using "shallow" as a
>> short-hand for one thing in the "fetch" dialog that a client can mention
>> that'll impact PACK generation, just like filter.
>>=20
>> Having thought about this a bit more, I think it should be an invariant
>> in any bundle-uri design that the server shouldn't communicate any
>> side-channel information whatsoever about a bundle it advertises, if
>> that information can't be discovered in the header of that bundle file.
>>=20
>> Mind you, this means throwing out large parts of my current proposed
>> over-the-wire design, but I think for the better. I.e. the whole
>> response part where we communicate:
>>=20
>>     (bundle-uri (SP bundle-feature-key (=3Dbundle-feature-val)?)* LF)*
>>     flush-pkt
>>=20
>> Would just become something like:
>>=20
>>     (bundle-uri delim-pkt bundle-header? delim-pkt)*
>>     flush-pkt
>>=20
>> I.e. we'd optionally transfer the content of the bundle header (content
>> up to the first "\n\n") to the client, but *only* ever as a shorthand
>> for saving the client a roundtrip.
>
> It still seems like we're better off letting the client request a
> filter and have the server present URIs that the client can use,
> and the server can choose to ignore the filter or provide URIs that
> are specific to that filter.[...]

I've tested this a bit now and think there's no way to create such a
bundle currently. I.e. try:

    git clone --filter=3Dblob:none --single-branch --no-tags https://github=
.com/git/git.git
    cd git
    git config --unset remote.origin.partialclonefilter
    git config --unset remote.origin.promisor

You'll get:
=20=20=20=20
    $ GIT_TRACE_PACKET=3D1 git bundle create --version=3D3 master.bdl master
    Enumerating objects: 306784, done.
    Counting objects: 100% (306784/306784), done.
    Compressing objects: 100% (69265/69265), done.
    fatal: unable to read c85385dc03228450cb7fb6d306252038a91b47e6
    error: pack-objects died

If you didn't do that config munging we'd create the pack, but it would
be inflated with the blobs (after going back and getting them from the
server).

So aside from any questions of how you'd hypothetically communicate your
desire to get such bundle from the server, I don't think it could serve
one up.

So I think this is moot until the bundle format itself could support
it. I'll need to "git bundle [verify|unbundle]" whatever I get on the
other end.

I really don't mean this in any way as dodging the desirability of this
feature. I'd really like to have it too. I think implementing it should
be relatively simple, and I've got an implementation in mind that makes
this future-proof for anything else we'd like to add.

I.e. if you look at that v3 format bundle you'll see:
=20=20=20=20
    $ head -c 100 master.bdl
    # v3 git bundle
    @object-format=3Dsha1
    e9e5ba39a78c8f5057262d49e261b42a8660d5b9 refs/heads/master
=20=20=20=20
    PACK

Wouldn't this just be a matter of including extra lines with:

    # I'm assuming that the promisor url can be assumed to be "the url
    # we cloned this from", but maybe we need @remoteURL=3Dhttps://....
    @promisor=3Dtrue
    @filter =3D blob:none

I.e. exactly corresponding to the .git/config we'd end up with,
config. We'd then (I think) create .git/objects/pack/*.promisor with the
OIDs of each of the inflated tips (I'm not familiar with .promisor
files).

And a thing I need to include in the bundle-uri protocol is that the
client should not just include a "bundle-uri" attribute, but have a
"value" describing the bundle format it accepts. I.e. now:

    bundle-uri=3Dv3,object-format

And for supporting the above:

    bundle-uri=3Dv3,object-format,promisor,filter

I.e. currently we die on any bundle capability except "object-format",
if we're going to discover what to send we'd like a less crappy way than
parsing the version from the "agent" field.

> Sending the full list and making the client decide what it wants seems
> like it will be more complicated than necessary. However, I'll
> withhold complete judgement until I see a full proposal in a v2.

I'm very thankful for the thorough review, and it's exciting that you'd
like to use this feature in some form, and I'll definitely do my best to
support (and if not, future-proof) any use-cases you have in mind.

But I really don't get how this wouldn't effectively be functionally
indistinguishable from packfile-uri, sans a nit here and there.

I can see the convenience of having say 100 bundles, advertising 5, and
then after a full negotiation dialog pointing the equivalent of a
packfile-uri at a *.bundle file, just because that's what you happen to
have around already. If bundle-uri is your main static file distribution
you don't want a duplicate *.pack (without the bundle header) just for
that.

I think a logical extension of the packfile-uri feature for those that
need extended negotiation before deciding on the static URL would be to
teach the packfile-uri downloader to ignore an optional bundle header of
any PACK it finds at a URL (which would not be the same as this
proposal), just to support that use-case.

But, isn't that essentially what you'd want in those cases?

Spewing a "here's my bundles" at a client gets it started quickly, and
also has the side-benefit of making those assets more cachable, as well
as creating a known base for the caching of any subsequent "...and a
PACK negotiation to make it fully up-to-date" request.

The bundles are also our de-facto sneakernet and format, and can be used
for incremental replication. All of which is also a sweet spot for
bundle-uri, i.e. the combination of being able to re-use already
"replicated" files for CDN-ing, and providing wider access to CDN
features for "dumb" servers.

But once we're in dialog with a client to discuss its arbitrary filter
preferences before giving it a URL we're going to be most likely
implementing that as a mode of upload-pack.c anyway, and when it spews
out an optional URL at the end of that dialog....

>> I think the sweet spot for "bundle-uri" is to advertise a small number
>> of bundles that encompass common clone/fetch patterns. I.e. something
>> like a bundle for a full clone with the repo data up to today, and maybe
>> a couple of other bundles covering a time period that clients would be
>> likely to incrementally update within, e.g. 1 week ago..today &&
>> yesterday..now.
>>=20
>> I agree that adding say "full clone, --depth=3D1" and "full clone, no
>> blobs" etc. to that might be *very* useful for some deployments, but per
>> the above I think we should really add that to the bundle format first,
>> not protocol v2.
>=20=20
> I'm focusing my interest in this topic not on "how can we make what we
> already do faster?" but "how can we unlock scale not previously
> possible?" Allowing blobless clones is an important part of this, in
> my opinion, so it is my _default_ mode of operating.

*nod*, I'm keen to support it using something like what's described
above. I.e. stick it as new headers in the bundle format, then be able
to advertise those for common cases. I'd think most of these would be a
few combinations (usually something copy/pasted from a relevant dev
guide), e.g. "all history, no blobs", "main branch, no tags, no blobs"
etc.

Aside from this bundle-uri protocol proposal being able to sneakernet a
repo you cloned like that around as-is seems highly desirable, and just
a feature gap we added when those features were added to "git fetch" and
friends, but not "git bundle".
