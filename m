Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5694C433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 00:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9923360EDF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 00:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhKBAKC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 20:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhKBAKB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 20:10:01 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C574C061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 17:07:26 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id m14so16854646edd.0
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 17:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=+PENVsOqRoUq/+Pjppc3Zth1clNgmXUMzZIT2uO6l2I=;
        b=YRpcteF2RVx/RlFPOzjkTs+6SzyMxe/kkWJpXtRTQWNncNwNZTev0YQV06qP/skas8
         O8V1MyvtPxbBY8jFwAyMlxNVGg9atHePi5i2ddTRRcB9ZJiCoRupNwodgorgiAfrxgEU
         7GE6nh95Rck6wwj17MtaT7bWgvWykJT0bu4VfdK7oB73H18tDePudnldYPeHsbFJ4t6e
         24OrouE0DFgYe4EUybZbkE5JRt+PPZPaTYYmvmQq4c6lVge8O7T1H01BtEbZRZT8vc0n
         BTaBwAombzNZAmC+xWVMxUDyCD9EFy1uwCVjQ9xeX/WHdyUPtYUEaS+VIfP3bizlIEe9
         8vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=+PENVsOqRoUq/+Pjppc3Zth1clNgmXUMzZIT2uO6l2I=;
        b=G4/f5phCJK7qKHN+C/U2aBNw8W8SQExX0Yb31KDchA5da4IbXHZlhioCkmEqR41A01
         uEEeb48is2pmS22hoD4e/spfgu9mVvpyWXNDe24Cg8zN4KHfCHv81d6YA9TszdOjj8zS
         Im12Q4R8NsNohgFIIh87/J/obUOQ/MlRjcOa50BcT0yGjPUWZCPyTCPGqfv7Sh5fRDL7
         5hZ3hx2I+aN/339a92i540zpK5/6WjAqk97frAwL9i9cj4illq+k/m506TCVvtxoignO
         q04ZfxN6cfxng+sAeC92WNqaX1zRWX73s62JaW5oqGM+DGR9G22XQmNCl0K7mGYTpBSW
         tRiw==
X-Gm-Message-State: AOAM532+kx+FBpRX+9XaajbdfM/cWq/3p5c68EPPivzB8hPW+ciX2Bc4
        +V3jDMf4JtIrZYlAjSoGmGbULGE43deUzw==
X-Google-Smtp-Source: ABdhPJwZ0SlkhXf92T/0RmCMGHv0GktuIKw+BwXgieFdHQZaKo0b7aVBT/a89c24lmQHnQNUFEm99A==
X-Received: by 2002:a05:6402:405:: with SMTP id q5mr2112961edv.62.1635811644673;
        Mon, 01 Nov 2021 17:07:24 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id et23sm354900ejc.67.2021.11.01.17.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 17:07:23 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mhhKk-002CKj-Tp;
        Tue, 02 Nov 2021 01:07:22 +0100
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
Subject: Re: [PATCH 0/3] bundle-uri: "dumb" static CDN offloading, spec &
 server implementation
Date:   Tue, 02 Nov 2021 00:18:21 +0100
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com>
 <c9c4e1e7-aaa2-bbad-355b-8439fad93fa7@gmail.com>
 <211030.86mtmr3po0.gmgdl@evledraar.gmail.com>
 <05262630-2e53-3edf-8fa1-fd1a41cc2d28@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <05262630-2e53-3edf-8fa1-fd1a41cc2d28@gmail.com>
Message-ID: <211102.8635of2zet.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 01 2021, Derrick Stolee wrote:

> On 10/30/2021 3:21 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Fri, Oct 29 2021, Derrick Stolee wrote:
>>=20
>>> On 10/25/2021 5:25 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> This implements a new "bundle-uri" protocol v2 extension, which allows
>>>> servers to advertise *.bundle files which clients can pre-seed their
>>>> full "clone"'s or incremental "fetch"'s from.
>>>>
>>>> This is both an alternative to, and complimentary to the existing
>>>> "packfile-uri" mechanism, i.e. servers and/or clients can pick one or
>>>> both, but would generally pick one over the other.
>>>>
>>>> This "bundle-uri" mechanism has the advantage of being dumber, and
>>>> offloads more complexity from the server side to the client
>>>> side.
>>>
>>> Generally, I like that using bundles presents an easier way to serve
>>> static content from an alternative source and then let Git's fetch
>>> negotiation catch up with the remainder.
>>>
>>> However, after inspecting your design and talking to some GitHub
>>> engineers who know more about CDNs and general internet things than I
>>> do, I want to propose an alternative design. I think this new design
>>> is simultaneously more flexible as well as promotes further decoupling
>>> of the origin Git server and the bundle contents.
>>>
>>> Your proposed design extends protocol v2 to let the client request a
>>> list of bundle URIs from the origin server. However, this still requires
>>> the origin server to know about this list. [...]
>>=20
>> Interesting, more below...
>>=20
>>> Further, your implementation focuses on the server side without
>>> integrating with the client.
>>=20
>> Do you mean these 3 patches we're discussing now? Yes, that's the
>> server-side and protocol specification only, because I figured talking
>> about just the spec might be helpful.
>>=20
>> But as noted in the CL and previously on-list I have a larger set of
>> patches to implement the client behavior, an old RFC version of that
>> here (I've since changed some things...):
>> https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T150534Z-=
avarab@gmail.com/
>>=20
>> I mean, you commented on those too, so I'm not sure if that's what you
>> meant, but just for context...
>
> Yeah, I'm not able to keep all of that in my head, and I focused on
> what you presented in this thread.

[...]

>>> I propose that we flip this around. The "bundle server" should know
>>> which bundles are available at which URIs, and the client should contact
>>> the bundle server directly for a "table of contents" that lists these
>>> URIs, along with metadata related to each URI. The origin Git server
>>> then would only need to store the list of bundle servers and the URIs
>>> to their table of contents. The client could then pick from among those
>>> bundle servers (probably by ping time, or randomly) to start the bundle
>>> downloads.
>>=20
>> I hadn't considered the server not advertising the list, but pointing to
>> another URI that has the list. I was thinking that the server would be
>> close enough to whatever's generating the list that updating the list
>> there wouldn't be a meaningful limitation for anyone.
>>=20
>> But you seem to have a use-case for it, I'd be curious to hear why
>> specifically, but in any case that's easy to support in the client
>> patches I have.
>
> Show me the client patches and then I can determine if I think that
> is sufficiently flexible.

I'm working on that larger re-roll, hoping to have something to submit
by the end of the week. I've snipped out much of the below, to the
extent that it's probably better on my part to reply to it with working
code than just continued discussion..

> In general, I want to expand the scope of this feature beyond "bundles
> on a CDN" and towards "alternative sources of Git object data" which
> _could_ be a CDN, but could also be geodistributed HTTP servers that
> manage their own copy of the Git data (periodically fetching from the
> origin). These could be self-hosted by organizations with needs for
> low-latency, high-throughput downloads of object data.

*Nod*. FWIW I share those goal[...]

> One thing neither of us have touched is authentication, so we'll want
> to find out how to access private information securely in this model.
> Authentication doesn't matter for CDNs, but would matter for other
> hosting models.

We've got authentication already for packfile-uri in the form of bearer
tokens, and I was planning to do the same (there's recent related
patches on-list to strip out those URLs during logging for that reason).

I was planning to handle it the same way, i.e. a server implementation
would be responsible for spewing out a bundle-uri that's
authenticated/non-public.

In practice I think that probably something that just allows generating
the bundle-uri list via a hook would be flexible enough for both this &
some of the other use-cases you've had in mind, as long as we pass the
protocol-specific auth info down to it in some way.

>> There's a point at which we get the list of URIs from the server, to
>> support your case the client would just advertise the one TOC URI.
>>=20
>> Then similarly to the "packfile-uri" special-case of handling a *.bundle
>> instead of a PACK that I noted in [1], the downloader would just spot
>> "oh this isn't a bundle, but list of URIs, and then fetch those (even
>> recursively), and eventually get to *.bundle files.
>
> This recursive "follow the contents" approach seems to be a nice
> general approach. I would still want to have some kind of specification
> about what could be seen at these URIs before modifying the protocol v2
> specification.

*nod*, of course.

> [...]
> Yes. I see this as a HUGE opportunity for flexibility.
>
>> But as as soon as we specify such a thing all of that becomes a part of
>> the git protocol at large in any meaningful way, i.e. git.git's client
>> and any other client that wants to implement the full protocol at large
>> would now need to understand not only pkt-line but also ship a JSON
>> decoder etc.
>
> I use JSON as my example because it is easy to implement in other
> languages. It's easy to use in practically any other language than C.
>
> The reason to use something like JSON is that it already encodes a way
> to include optional, structured information in the list of results. I
> focused on using that instead of specifics of a pkt-line protocol.
>
> You have some flexibility in your protocol, but it's unclear how the
> optional data would work without careful testing and actually building
> a way to store and communicate the optional data.

Yes, it's definitely not as out-of-the-box extensible as a nested
structure like JSON, but if we leave in space for arbitrary key-values
(which I'm planning) then we should be able to extend it in the future,
a key/value could even be a serialized data of some sort...

>> I don't see an inherent problem with us wanting to support some nested
>> encoding format as part of the protocol, but JSON seems like a
>> particularly bad choice. It's specified as UTF-8 only (or rather, "a
>> Unicode enoding"), so you can't stick both valid UTF-8 and binary data
>> into it.
>>=20
>> Our refs on the other hand don't conform to that, so having a JSON
>> format means you can never have something that refers to refnames, which
>> given that we're talking about bundles, whose own header already has
>> that information.
>
> As I imagine it, we won't want the bundles to store real refnames,
> anyway, since we just need pointers into the commit history to start
> the incremental fetch of the real refs after the bundles are downloaded.
> The prototype I made doesn't even store the bundled refs in "refs/heads"
> or "refs/remotes".

*nod*, FWIW I've got off-list patches to make that use-case much easier
with "git bundle", i.e. teaching it to take <oid>\t<refname>\n... on
--stdin, not just <oid>\n..., so you can pick arbitrary names.

>>> Let me know if you are interested in switching your approach to somethi=
ng
>>> more like what I propose here. There are many more questions about what
>>> information could/should be located in the table of contents and how it=
 can
>>> be extended in the future. I'm interested to explore that space with yo=
u.
>>=20
>> As noted above, the TOC part of this seems interesting, and I don't see
>> a reason not to implement that.
>>=20
>> But as noted in [1] I really don't see why it would be a good idea to
>> implement a side-format that's encoding a limited subset of what you'd
>> find in bundle headers.
>
> You say "bundle headers" a lot as if we are supposed to download and
> examine the start of the bundle file before completing the download.
> Is that what you mean? Or, do you mean that somehow you are communicating
> the bundle header in your list of URIs and I just missed it?

It's something I've changed my mind on mid-way through this RFC, but
yes, as described in
https://lore.kernel.org/git/211027.86a6iuxk3x.gmgdl@evledraar.gmail.com/
I was originally thinking of a design like

    client: bundle-uri
    server: https://example.com/bundle2.bdl
    server: https://example.com/bundle1.bdl optional key=3Dvalues

But am now thinking of/working on something like:

    client: command=3Dbundle-uri
    client: v3
    client: object-format
    client: want=3Dheaders <pkt-line-flush>
    server: https://example.com/bundle2.bdl <pkt-line-delim>
    server: # v3 git bundle
    server: @object-format=3Dsha1
    server: e9e5ba39a78c8f5057262d49e261b42a8660d5b9 refs/heads/master <pkt=
-line-delim>
    server: https://example.com/bundle1.bdl <pkt-line-delim> [...]

I.e. a client requests bundle-uris with N arguments, those communicate
what sort of bundles it's able to understand, and that it would like the
server to give it headers as a shortcut, if it can.

The server replies with a list of URIs to bundles (or TOC's etc.), and
optionally as a shortcut to the client includes the headers of those
bundles.

It could also simply skip those, but then the client will need to go and
fetch the headers from the pointed-to resources, or decide it doesn't
need to.

> If you do mean that the bundle header _must_ be included in the table
> of contents, then I think that is a blocker for scaling this approach,
> since the bundle header includes the 'prerequisite' and 'reference'
> records, which could be substantial. At scale, info/refs already takes
> too much data to want to do often, let alone multiple times in a single
> request.

We'll see when I submit the updated working patches for this, and in
coming up with testcases, but I think that you can attain a sweet spot
in most repositories by advertising some of your common/recent tips, as
opposed to a big dump of all the refs.

> [...]
> Part of the point of my proposal was to show how things can work in a
> different way, especially with a flexible format like JSON. One possible
> way to organize bundles is in a linear list of files that form snapshots
> of the history at a given timestamp, storing the new objects since the
> previous bundle. A client could store a local timestamp as a heuristic
> for whether they need to download a bundle, but if they are missing
> reachable objects, then the 'requires' tag gives them a bundle that
> could fill in those gaps (they might need to follow a list until closing
> all the gaps, depending on many factors).
>
> So, that's the high-level "one could organize bundles like this" plan.
> It is _not_ intended as the only way to do it, but I also believe it is
> the most efficient. It's also why things like "requires" and "timestamp"
> are intended to be optional metadata.

[more below]

> [...]
>> If you're creating bundles that contain only one tip there's a 1=3D1
>> mapping to what you're proposing with "requires", but otherwise there
>> isn't.
>>=20
>>=20
>> "This allows us to reexamine the table of contents and only download the
>> bundles that are newer than that timestamp."
>>=20
>> We're usually going to be fetching these over http(s), why duplicate
>> what you can already get if the server just takes care to create unique
>> filenames (e.g. as a function of the SHA of their contents), and then
>> provides appropriate caching headers to a client so that they'll be
>> cached forever?
>
> This assumes that a bundle URI will always be available forever, and that
> the table of contents will never shift with any future reorganization.
> If the snapshot layout that I specified was always additive, then the URI
> would be sufficient (although we would need to keep a full list of every
> URI ever downloaded) but also a single timestamp would be sufficient.
>
> The issue arises if the bundle server reorganizes the data somehow, or
> worse, the back-end of the bundle server is completely replaced with a
> different server that had a different view of the refs at these timestamp=
s.
>
> Now, the 'requires' links provide a way to reconcile missing objects
> after downloading only the new bundles, without downloading the full list.

[also on this]

>> I think that gives you everything you'd like out of the "timestamp" and
>> more, the "more" being that since it's part of a protocol that's already
>> standard you'd have e.g. intermediate caching proxies understanding this
>> implicitly, in addition to the git client itself.
>>=20
>> So on a network that's say locally unpacking https connections to a
>> public CDN you could have a local caching proxy for your N local
>> clients, as opposed to a custom "timestamp" value, which only each local
>> git client will understand.
>
> I don't understand most of what you are saying here, and perhaps that
> is my lack of understanding of possible network services that you are
> referencing.
>
> What I'm trying to communicate is that a URI is not enough information
> to make a decision about whether or not the Git client should start
> downloading that data. Providing clues about the bundle content can
> be helpful.
>
> In talking with some others about this, they were thinking about
> advertising the ref tips at the bundle boundaries. This would be a
> list of "have"s and "have not"s as OIDs that were used to generate
> the bundle. However, in my opinion, this only works if you are focused
> on snapshots of a single ref instead of a large set of moving refs
> (think thousands of refs). In that environment, timestamps are rather
> effective so it's nice to have the option.
>
> I'm also not saying that you need to implement an organization such
> as the one I'm proposing. I am only strongly recommending that you
> build it with enough generality that it is possible.

On the "This assumes that a bundle URI will always be available forever"
& generally on piggy-backing on the HTTP protocol. I mean that you can
just advertise a:

    https://example.com/big-bundle.bdl

I.e. a URL that never changes, and if you serve it up with appropriate
caching headers a client may or may not request it, e.g. a "clone"
probably will every time, but we MAY also just ignore it based on some
other client heuristic.

But then let's say you serve up (opaque SHA1s of the content) with
appropriate Cache-Control headers[1][2]:

    https://example.com/18719eddecbdf01d6c4166402d62e178482d83d4.bdl
    https://example.com/9cfaf0ef69c3c3024ff5fe92ba84bf7f6caefa2a.bdl

Now a client only needs to grab those once, and if the server operator
has set Cache-Control appropriately we'll only need to request the
header for each resource once, e.g. for a use-case of having a "big
bundle" we update monthly, and some weekly updates etc.

One reason I highly prefer this sort of approach is that it works well
out of the box with other software.

Want to make your local git clients faster? Just pipe those URLs into
wget, and if you've got a squid/varnish or other http cache sitting in
front of your clients doing that will pre-seed your local cache.

I may also turn out to be wrong, but early tests with
pipelining/streaming the headers are very promising (see e.g. [3] for
the API). I.e. for the common case of N bundles on the same CDN you can
pipeline them all & stream them in parallel, and if you don't like what
you see in some of them you don't need to continue to download the PACK
payload itself.

1. https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cache-Control
2. https://bitsup.blogspot.com/2016/05/cache-control-immutable.html
3. https://curl.se/libcurl/c/http2-download.html
