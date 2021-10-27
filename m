Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873F5C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 19:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 635C960296
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 19:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240590AbhJ0TOW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 15:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240552AbhJ0TOV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 15:14:21 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A345C061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 12:11:55 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z20so14816503edc.13
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 12:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=p0VZ69z3Wx+828/LZY3P8xp482ibkzPJIZT6CSdyUI0=;
        b=baxAX1bia2qULnPIVMWDVmExtU4gzA2/0tywt+dmlw04jQC7KGbbuVvVRTe5bUKc7N
         d90EVMjtloSSzgFivnxKfaQ4A9+l3PTr50KwsnXJkOs5K8WIfblh49zKegMx1NkGI7K5
         TUsg5Tv8jNTVQZNTWRMlTUpu41myEsB+ItgBkP7LruI/aXeD/E5yCwvvxq189n/di2Z7
         0s0LXbTxs25NVJ0/PdtBJTY5v1UaAEQYRM31N4OLDsk2EOiH64tPnnJmm+EYzeI8vzLR
         Y3Y74IIfWMOogX9PE422k0SvH9l4A6b3xY4Tuw/WijNIAYVcyPezC+zb0KR9VAhtwe3C
         B4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=p0VZ69z3Wx+828/LZY3P8xp482ibkzPJIZT6CSdyUI0=;
        b=HZdjGV2c3ynnST8MhAxQPBZXgPzNowuW7ZR37bXfTdOw2Ic40SnH5qCESTqlxqSVGh
         c0qY0JCqAOF0UPN0GpXXLVVg2I8RnyNP+OxIzbnMXAh0+wizb86XXIcpnL7p8rPDrfBd
         PVPllQ+CS+CD7BZ6HfSkLscShZ0Rizfv6fNPIIMC5e7rOC9JO3xhUEkwNhelm74kSQxP
         bKYch963CVSuszEilwgKY/g2bIGoIRtbbizIKEWOZIn6OLX+KfY05asFLILCE69747vM
         /SyAfW0QQWIGOp6vHu3trQg1zlSBHJMqlBBCgTQXsMsHRVanu7C60hOdbLwK1/MdvLts
         RWSQ==
X-Gm-Message-State: AOAM533KnKGyuoMIAEVAV+6mZ8ZULoX1BKC49cN9ld3Ec+Bzihn/sPC6
        9EJLNMlsDVWhtMWaa9XHdOTFc0OJeCA=
X-Google-Smtp-Source: ABdhPJycq36crGEjD6QMog7odf+6+VD1hta/wrtTW9Tbti5hxNAQtP7OtX6gqThG9C6FQY9RXv1rbQ==
X-Received: by 2002:a17:906:248f:: with SMTP id e15mr38852928ejb.541.1635361913542;
        Wed, 27 Oct 2021 12:11:53 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qf38sm377459ejc.116.2021.10.27.12.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 12:11:53 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mfoL2-0021G6-5V;
        Wed, 27 Oct 2021 21:11:52 +0200
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
Date:   Wed, 27 Oct 2021 20:01:47 +0200
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com>
 <patch-2.3-3ac0539c053-20211025T211159Z-avarab@gmail.com>
 <7fab28bf-54e7-d0e9-110a-53fad6244cc9@gmail.com>
 <211027.86r1c6yh52.gmgdl@evledraar.gmail.com>
 <756524c1-a3b9-29b5-bb72-f75a0c76ea1f@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <756524c1-a3b9-29b5-bb72-f75a0c76ea1f@gmail.com>
Message-ID: <211027.86ilxixoxz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 27 2021, Derrick Stolee wrote:

> On 10/27/2021 4:29 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Tue, Oct 26 2021, Derrick Stolee wrote:
>>=20
>>> On 10/25/2021 5:25 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> Add a server-side implementation of a new "bundle-uri" command to
>>>> protocol v2. As discussed in the updated "protocol-v2.txt" this will
>>>> allow conforming clients to optionally seed their initial clones or
>>>> incremental fetches from URLs containing "*.bundle" files created with
>>>> "git bundle create".
>>>
>>> ...
>>>
>>>> +DISCUSSION of bundle-uri
>>>> +^^^^^^^^^^^^^^^^^^^^^^^^
>>>> +
>>>> +The intent of the feature is optimize for server resource consumption
>>>> +in the common case by changing the common case of fetching a very
>>>> +large PACK during linkgit:git-clone[1] into a smaller incremental
>>>> +fetch.
>>>> +
>>>> +It also allows servers to achieve better caching in combination with
>>>> +an `uploadpack.packObjectsHook` (see linkgit:git-config[1]).
>>>> +
>>>> +By having new clones or fetches be a more predictable and common
>>>> +negotiation against the tips of recently produces *.bundle file(s).
>>>> +Servers might even pre-generate the results of such negotiations for
>>>> +the `uploadpack.packObjectsHook` as new pushes come in.
>>>> +
>>>> +I.e. the server would anticipate that fresh clones will download a
>>>> +known bundle, followed by catching up to the current state of the
>>>> +repository using ref tips found in that bundle (or bundles).
>>>> +
>>>> +PROTOCOL for bundle-uri
>>>> +^^^^^^^^^^^^^^^^^^^^^^^
>>>> +
>>>> +A `bundle-uri` request takes no arguments, and as noted above does not
>>>> +currently advertise a capability value. Both may be added in the
>>>> +future.
>>>
>>> One thing I realized was missing from this proposal is any interaction
>>> with partial clone. It would be disappointing if we could not advertise
>>> bundles of commit-and-tree packfiles for blobless partial clones.
>>>
>>> There is currently no way for the client to signal the filter type
>>> during this command. Not having any way to extend to include that
>>> seems like an oversight we should remedy before committing to a
>>> protocol that can't be extended.
>>>
>>> (This also seems like a good enough reason to group the URIs into a
>>> struct-like storage, because the filter type could be stored next to
>>> the URI.)
>>=20
>> I'll update the docs to note that. I'd definitely like to leave out any
>> implementation of filter/shallow for an initial iteration of this for
>> simplicity, but the protocol keyword/behavior is open-ended enough to
>> permit any extension.
>
> It would be good to be explicit about how this would work. Looking at
> it fresh, it seems that the server could send multiple bundle URIs with
> the extra metadata to say which ones have a filter (and what that filter
> is). The client could then check if a bundle matches the given filter.
>
> But this is a bit inverted: the filter mechanism currently has the client
> request a given filter and the server responds with _at least_ that much
> data. This allows the server to ignore things like pathspec-filters or
> certain size-based filters. If the client just ignores a bundle URI
> because it doesn't match the exact filter, this could lead the client to
> ask for the data without a bundle, even if it would be faster to just
> download the advertised bundle.
>
> For this reason, I think it would be valuable for the client to tell
> the server the intended filter, and the server responds with bundle
> URIs that contain a subset of the information that would be provided
> by a later fetch request with that filter.
>
>> I.e. the server can start advertising "bundle-uri=3Dshallow", and future
>> clients can request arbitrary key-value pairs in addition to just
>> "bundle-uri" now.
>>=20
>> Having said that I think that *probably* this is something that'll never
>> be implemented, but maybe I'll eat my words there.

I didn't mean to elide past "filter", but was just using "shallow" as a
short-hand for one thing in the "fetch" dialog that a client can mention
that'll impact PACK generation, just like filter.

Having thought about this a bit more, I think it should be an invariant
in any bundle-uri design that the server shouldn't communicate any
side-channel information whatsoever about a bundle it advertises, if
that information can't be discovered in the header of that bundle file.

Mind you, this means throwing out large parts of my current proposed
over-the-wire design, but I think for the better. I.e. the whole
response part where we communicate:

    (bundle-uri (SP bundle-feature-key (=3Dbundle-feature-val)?)* LF)*
    flush-pkt

Would just become something like:

    (bundle-uri delim-pkt bundle-header? delim-pkt)*
    flush-pkt

I.e. we'd optionally transfer the content of the bundle header (content
up to the first "\n\n") to the client, but *only* ever as a shorthand
for saving the client a roundtrip.

The pointed-to bundle is still 100% the source of truth, and when
retrieving the bundle-uri we'd ignore whatever "bundle-header" we got
earlier (except insofar as we'd like to say emit a warning() if the two
don't match).

(I'd not thought too carefully about these shallow/filter etc. edge
cases, my main intended use-case has been pre-seeding full clones, and
having this feedback to make me think about it is very valuable).

> You continue focusing on the shallow option, which I agree is not
> important. The filter option, specifically --filter=3Dblob:none, seems
> to be critical to have a short-term plan for implementing with this
> in mind.

Per the above this then just becomes a question of "how do we produce a
bundle with those attributes?".

I *think* that currently there isn't a way to do that, i.e. the PACK
payload of a bundle is the output of "git pack-objects", but due to it
including refs, tips and prerequisites.

I don't think you can say "this bundle has no blobs". The
"prerequisites" hard map to the same thing you could put on a
"want/have" line during PACK negotiation.

I think we could/should fix that, i.e. we can bump the bundle format
version and have it encode some extended prerequisites/filter/shallow
etc information. You'd then have a 1=3D1 match between the features of
git-upload-pack and what you can transfer via the bundle side-channel.

But the more I think about it, the more strongly I feel that we should
always add that to the bundle *format*, and not as some side-channel
information in this "bundle-uri" protocol keyword.

To me *the* point of this feature is to have servers provide a shorthand
for something that's been a well-established trick you can do today, and
of which there are any number of pre-existing implementations.

I'm not trying to break any new ground here, just make "git
[fetch|clone]" support a well-known trick as a first-class feature via
protocol v2.

I'm not the first person to whip up some custom
"git-clone-via-bundle.sh" that takes bundle URI(s) and a repo URI,
wget's the bundle, calls "git bundle unbundle", updates ref tips, and
then does a "git fetch".

The benefit of making that a first-class protocol feature over a full
negotiation is essentially synonymous with how it's easier in practice
to widely deploy static assets on CDNs v.s. guaranteeing the same
network locality, caching etc. when serving up the same payload by
running a custom binary.

One reason not to add any side-channel information not found in the
bundle header(s) is that we can also guarantee that there won't be any
feature gap between the "transfer.injectBundleURI" config key I've
already got implemented (and is in the earlier RFC version of this
series). I.e. you can do:

    # You can specify this N number of times to inject N bundles
    git clone \
	-c transfer.injectBundleURI=3D"https://something.local/some-repo.bundle" \
        https://example.com/some-repo.git

To inject CDN support to any remote server that doesn't know about
"bundle-uri", or add to the bundles of a server that does. That URI can
even be a file:// if you add "-c fetch.uriProtocols=3Dfile".

I realize that all of the above does *not* answer part of your question
about filters, which I think I can accurately rephrase as:

    Ok, so you can dump a static list of bundle URIs from config, but
    that's always going to be a small list, what about the combinatorial
    explosion arbitrary upload-pack options? Filters, shallow,
    include-tag etc.

My main answer to that is that YAGNI. If you need to spew out an URL for
a PACK after a client describes any of its arbitrary wants, needs,
filters etc. you've exactly re-invented what "packfile-uri" is today. I
think that feature is very useful, and I've got no intention of trying
to replace it.

I think the sweet spot for "bundle-uri" is to advertise a small number
of bundles that encompass common clone/fetch patterns. I.e. something
like a bundle for a full clone with the repo data up to today, and maybe
a couple of other bundles covering a time period that clients would be
likely to incrementally update within, e.g. 1 week ago..today &&
yesterday..now.

I agree that adding say "full clone, --depth=3D1" and "full clone, no
blobs" etc. to that might be *very* useful for some deployments, but per
the above I think we should really add that to the bundle format first,
not protocol v2.
