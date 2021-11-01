Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BCCC433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 21:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B924D6054E
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 21:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhKAVDd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 17:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhKAVDc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 17:03:32 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF71C061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 14:00:59 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id bd30so7077040oib.13
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 14:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eGk02KrlxfATuQ2fbEhvF1c5gMzq1v5qnlUZ0BiSAnk=;
        b=krh7bVpbX/RR0YrkccJQxQKAz1PwIJ2simmY5oEd2zDbnGtsbHNsy7BEFrYMlh95LQ
         0HrAFdog1CElvIXAvOzxJLbz5b3db+oox2boAp6Zsfs6VwKqvo9/sFyDgahoqdLUNFOB
         oxbRUa+3y1DbKdHsHbhpfVtPCcmavzAQcTkxUrIAS/+xdtlEIaCW/sv/YePgFflMc52q
         TiI7zyVV4uvSL+MdMNaldHFnpOwG4kBhMKb/UEF4/2cfNH6kjaa67LqAr9+ojcSyt+nD
         0shM9CqbA7XwwDfpyn5h2vza2iap09gVv+OxXiU6OwHhDQ7SWhOW9++1hyVgOV5duqGG
         vb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eGk02KrlxfATuQ2fbEhvF1c5gMzq1v5qnlUZ0BiSAnk=;
        b=giq/trfBrK2Tla0rYuiyoaUfr80xQA33Ug7/RjD0iFgGTwTBjMoxrEkDjnK9Tm2aCy
         K/QDdmXr2rxz680so3iUiFaLXmeXw695tUFo5QuCpm91/EQm4R+ptxfI2bl72jyyMXa0
         5kphxiNPs2Pduh2aRt95r10zL3Y9KBAPvP85dj62kPkZFTu2wpkHyNV9xk35hGenNkN7
         FHIE2mnol2q76QkExL2Wubhpcig81V1FAxF6Htk4JGwiEjWlp7HbPyI60uG4BxbvM7Gb
         g6LOziBZzpqvywsVK21FvgLgQjDGrZgFm6vul/122elIbp1PcV6zuQuLqvt5ScncbB9I
         fZew==
X-Gm-Message-State: AOAM532/cv2YRVZORjF8ljW4KsvqwsN00yCjrKgKwmauU2Lf4VIU73Ay
        kL3drl7ET/hu0sSzUw0vXyk=
X-Google-Smtp-Source: ABdhPJywhrLLmgwgNLFFvLigdOzx709o+c+daM32IsSQN+KclE4T5gGQs8H7dwugVlm0kgmmyrqt4Q==
X-Received: by 2002:a05:6808:13c4:: with SMTP id d4mr1284031oiw.92.1635800458023;
        Mon, 01 Nov 2021 14:00:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:798a:aada:ab03:5d10? ([2600:1700:e72:80a0:798a:aada:ab03:5d10])
        by smtp.gmail.com with ESMTPSA id q81sm3205257oib.47.2021.11.01.14.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 14:00:57 -0700 (PDT)
Message-ID: <05262630-2e53-3edf-8fa1-fd1a41cc2d28@gmail.com>
Date:   Mon, 1 Nov 2021 17:00:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 0/3] bundle-uri: "dumb" static CDN offloading, spec &
 server implementation
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        "Robin H . Johnson" <robbat2@gentoo.org>
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com>
 <c9c4e1e7-aaa2-bbad-355b-8439fad93fa7@gmail.com>
 <211030.86mtmr3po0.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <211030.86mtmr3po0.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/30/2021 3:21 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Oct 29 2021, Derrick Stolee wrote:
> 
>> On 10/25/2021 5:25 PM, Ævar Arnfjörð Bjarmason wrote:
>>> This implements a new "bundle-uri" protocol v2 extension, which allows
>>> servers to advertise *.bundle files which clients can pre-seed their
>>> full "clone"'s or incremental "fetch"'s from.
>>>
>>> This is both an alternative to, and complimentary to the existing
>>> "packfile-uri" mechanism, i.e. servers and/or clients can pick one or
>>> both, but would generally pick one over the other.
>>>
>>> This "bundle-uri" mechanism has the advantage of being dumber, and
>>> offloads more complexity from the server side to the client
>>> side.
>>
>> Generally, I like that using bundles presents an easier way to serve
>> static content from an alternative source and then let Git's fetch
>> negotiation catch up with the remainder.
>>
>> However, after inspecting your design and talking to some GitHub
>> engineers who know more about CDNs and general internet things than I
>> do, I want to propose an alternative design. I think this new design
>> is simultaneously more flexible as well as promotes further decoupling
>> of the origin Git server and the bundle contents.
>>
>> Your proposed design extends protocol v2 to let the client request a
>> list of bundle URIs from the origin server. However, this still requires
>> the origin server to know about this list. [...]
> 
> Interesting, more below...
> 
>> Further, your implementation focuses on the server side without
>> integrating with the client.
> 
> Do you mean these 3 patches we're discussing now? Yes, that's the
> server-side and protocol specification only, because I figured talking
> about just the spec might be helpful.
> 
> But as noted in the CL and previously on-list I have a larger set of
> patches to implement the client behavior, an old RFC version of that
> here (I've since changed some things...):
> https://lore.kernel.org/git/RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com/
> 
> I mean, you commented on those too, so I'm not sure if that's what you
> meant, but just for context...

Yeah, I'm not able to keep all of that in my head, and I focused on
what you presented in this thread.

>> I propose that we flip this around. The "bundle server" should know
>> which bundles are available at which URIs, and the client should contact
>> the bundle server directly for a "table of contents" that lists these
>> URIs, along with metadata related to each URI. The origin Git server
>> then would only need to store the list of bundle servers and the URIs
>> to their table of contents. The client could then pick from among those
>> bundle servers (probably by ping time, or randomly) to start the bundle
>> downloads.
> 
> I hadn't considered the server not advertising the list, but pointing to
> another URI that has the list. I was thinking that the server would be
> close enough to whatever's generating the list that updating the list
> there wouldn't be a meaningful limitation for anyone.
> 
> But you seem to have a use-case for it, I'd be curious to hear why
> specifically, but in any case that's easy to support in the client
> patches I have.

Show me the client patches and then I can determine if I think that
is sufficiently flexible.

In general, I want to expand the scope of this feature beyond "bundles
on a CDN" and towards "alternative sources of Git object data" which
_could_ be a CDN, but could also be geodistributed HTTP servers that
manage their own copy of the Git data (periodically fetching from the
origin). These could be self-hosted by organizations with needs for
low-latency, high-throughput downloads of object data.

For a concrete example, a group with a build farm could create their
own bundle server on the same LAN as the build machines, and they could
mirror whatever Git service they want. This requires the users setting
up the server and telling the machines about the URL for the table of
contents at clone/fetch time.

By having the origin Git server advertise the table of contents, hosts
such as GitHub, GitLab, and others could have their own CDN solutions
that clients discover automatically. This is clearly the environment
you are targeting. Allowing a redirection to another table of contents
further decouples what is responsible for the bundle organization away
from the origin Git server.

One thing neither of us have touched is authentication, so we'll want
to find out how to access private information securely in this model.
Authentication doesn't matter for CDNs, but would matter for other
hosting models.

> There's a point at which we get the list of URIs from the server, to
> support your case the client would just advertise the one TOC URI.
> 
> Then similarly to the "packfile-uri" special-case of handling a *.bundle
> instead of a PACK that I noted in [1], the downloader would just spot
> "oh this isn't a bundle, but list of URIs, and then fetch those (even
> recursively), and eventually get to *.bundle files.

This recursive "follow the contents" approach seems to be a nice
general approach. I would still want to have some kind of specification
about what could be seen at these URIs before modifying the protocol v2
specification.

>> To summarize, there are two pieces here, that can be implemented at
>> different times:
>>
>> 1. Create a specification for a "bundle server" that doesn't need to
>>    speak the Git protocol at all. This could be a REST API specification
>>    using well-established standards such as JSON for the table of
>>    contents.
>>
>> 2. Create a way for the origin Git server to advertise known bundle
>>    servers to clients so they can automatically benefit from faster
>>    downloads without needing to know about bundle servers.
>>
>> There are a few key benefits to this approach:
>>
>>  * Further decoupling. The origin Git server doesn't need to know how
>>    the bundle server organizes its bundles. This allows maximum flexibility
>>    depending on whether the bundles are stored in something like a CDN
>>    (where bundles can't be too big) or some kind of blob storage (where
>>    they can have arbitrarily large size).
>>
>>  * The bundle servers could be run completely independently from the
>>    origin Git server. Organizations could run their own bundle servers to
>>    host data in the same building as their build farms. As long as they
>>    can configure the bundle location at clone/fetch time, the origin Git
>>    server doesn't need to be involved.
>>
>> While I didn't go so far as to create a clear standard or implement a
>> prototype in the Git codebase, I created a very simple prototype [1] using
>> a python script that parses a JSON table of contents and downloads
>> bundles into the Git repository. Then, I made a 'clone.sh' script that
>> initializes a repository using the bundle fetcher and fetching the
>> remainder from the origin Git server. I even computed static bundles for
>> the git.git repository based on where 'master' has been over several days
>> in the past month, to give an example of incremental bundles. You can
>> test the approach all the way to including the fetch to github.com (note
>> how the GitHub servers were not modified in any way for this).
>>
>> [1] https://github.com/derrickstolee/bundles
>>
>> There are a lot of limitations to the prototype, but it hopefully
>> demonstrates the possibility of using something other than the Git protocol
>> to solve these problems.
> 
> In your proposal the TOC bundle itself doesn't need to speak the git
> protocol.

Yes. I see this as a HUGE opportunity for flexibility.

> But as as soon as we specify such a thing all of that becomes a part of
> the git protocol at large in any meaningful way, i.e. git.git's client
> and any other client that wants to implement the full protocol at large
> would now need to understand not only pkt-line but also ship a JSON
> decoder etc.

I use JSON as my example because it is easy to implement in other
languages. It's easy to use in practically any other language than C.

The reason to use something like JSON is that it already encodes a way
to include optional, structured information in the list of results. I
focused on using that instead of specifics of a pkt-line protocol.

You have some flexibility in your protocol, but it's unclear how the
optional data would work without careful testing and actually building
a way to store and communicate the optional data.

> I don't see an inherent problem with us wanting to support some nested
> encoding format as part of the protocol, but JSON seems like a
> particularly bad choice. It's specified as UTF-8 only (or rather, "a
> Unicode enoding"), so you can't stick both valid UTF-8 and binary data
> into it.
> 
> Our refs on the other hand don't conform to that, so having a JSON
> format means you can never have something that refers to refnames, which
> given that we're talking about bundles, whose own header already has
> that information.

As I imagine it, we won't want the bundles to store real refnames,
anyway, since we just need pointers into the commit history to start
the incremental fetch of the real refs after the bundles are downloaded.
The prototype I made doesn't even store the bundled refs in "refs/heads"
or "refs/remotes".

>> Let me know if you are interested in switching your approach to something
>> more like what I propose here. There are many more questions about what
>> information could/should be located in the table of contents and how it can
>> be extended in the future. I'm interested to explore that space with you.
> 
> As noted above, the TOC part of this seems interesting, and I don't see
> a reason not to implement that.
> 
> But as noted in [1] I really don't see why it would be a good idea to
> implement a side-format that's encoding a limited subset of what you'd
> find in bundle headers.

You say "bundle headers" a lot as if we are supposed to download and
examine the start of the bundle file before completing the download.
Is that what you mean? Or, do you mean that somehow you are communicating
the bundle header in your list of URIs and I just missed it?

If you do mean that the bundle header _must_ be included in the table
of contents, then I think that is a blocker for scaling this approach,
since the bundle header includes the 'prerequisite' and 'reference'
records, which could be substantial. At scale, info/refs already takes
too much data to want to do often, let alone multiple times in a single
request.

I think the table of contents should provide enough information for the
client to decide if they should initiate the download at all, but be
flexible to multiple strategies for organizing the data.

> Specifically on the meta-information you're proposing:
> 
> == requires
> == timestamp

Part of the point of my proposal was to show how things can work in a
different way, especially with a flexible format like JSON. One possible
way to organize bundles is in a linear list of files that form snapshots
of the history at a given timestamp, storing the new objects since the
previous bundle. A client could store a local timestamp as a heuristic
for whether they need to download a bundle, but if they are missing
reachable objects, then the 'requires' tag gives them a bundle that
could fill in those gaps (they might need to follow a list until closing
all the gaps, depending on many factors).

So, that's the high-level "one could organize bundles like this" plan.
It is _not_ intended as the only way to do it, but I also believe it is
the most efficient. It's also why things like "requires" and "timestamp"
are intended to be optional metadata.

> == requires
> In your example you've added a monolithic "requires" relationship
> between bundles, saying "This assumes that the bundles can be ordered".
> 
> But that's not something you can assume for actual bundle files,
> i.e. the prerequisite relationship is per-reftip, it's not the case that
> a given bundle requires another bundle, it's the case that tips found in
> them may or may not depend on other prerequisites.

No, not all lists of bundles can be ordered. For instance, if you
use the "here is where the 'main' branch was for each month, minus
the previous month" as one list of bundles and then another "here is
where the 'dev' branch was for each month, minus the 'dev' for the
previous month and the 'main' branch for the current month" then you
get a partial order instead.

I agree that it is important to allow for full generality of cases like
this, but for large repositories, users will probably just want a
snapshot of all the ref tips.

> If you're creating bundles that contain only one tip there's a 1=1
> mapping to what you're proposing with "requires", but otherwise there
> isn't.
> 
> 
> "This allows us to reexamine the table of contents and only download the
> bundles that are newer than that timestamp."
> 
> We're usually going to be fetching these over http(s), why duplicate
> what you can already get if the server just takes care to create unique
> filenames (e.g. as a function of the SHA of their contents), and then
> provides appropriate caching headers to a client so that they'll be
> cached forever?

This assumes that a bundle URI will always be available forever, and that
the table of contents will never shift with any future reorganization.
If the snapshot layout that I specified was always additive, then the URI
would be sufficient (although we would need to keep a full list of every
URI ever downloaded) but also a single timestamp would be sufficient.

The issue arises if the bundle server reorganizes the data somehow, or
worse, the back-end of the bundle server is completely replaced with a
different server that had a different view of the refs at these timestamps.

Now, the 'requires' links provide a way to reconcile missing objects
after downloading only the new bundles, without downloading the full list.

> I think that gives you everything you'd like out of the "timestamp" and
> more, the "more" being that since it's part of a protocol that's already
> standard you'd have e.g. intermediate caching proxies understanding this
> implicitly, in addition to the git client itself.
> 
> So on a network that's say locally unpacking https connections to a
> public CDN you could have a local caching proxy for your N local
> clients, as opposed to a custom "timestamp" value, which only each local
> git client will understand.

I don't understand most of what you are saying here, and perhaps that
is my lack of understanding of possible network services that you are
referencing.

What I'm trying to communicate is that a URI is not enough information
to make a decision about whether or not the Git client should start
downloading that data. Providing clues about the bundle content can
be helpful.

In talking with some others about this, they were thinking about
advertising the ref tips at the bundle boundaries. This would be a
list of "have"s and "have not"s as OIDs that were used to generate
the bundle. However, in my opinion, this only works if you are focused
on snapshots of a single ref instead of a large set of moving refs
(think thousands of refs). In that environment, timestamps are rather
effective so it's nice to have the option.

I'm also not saying that you need to implement an organization such
as the one I'm proposing. I am only strongly recommending that you
build it with enough generality that it is possible.

> == Generally
> 
> Sorry, I've got to run, so I haven't addressed all the things you
> brought up, but generally while I think that the TOC idea is a good one.
> 
> I don't see a reason for why most/all of the other bits shouldn't be
> leaning into either the bundle header (and for any TOC shortcut, dump it
> as-is, as noted in [1]), or in the case of "timestamp" lean into the
> properties of the transport protocol.
> 
> And just generally on overall protocol complexity, wouldn't it be OK if
> any such TOC is just in pkt-line format?

The complexity either lives in the code that parses a well-known format
or the design of a format that is sufficiently general to handle extra
metadata that we could use for the future. Pick your poison.

> We could just provide a git plumbing tool to spew that out, and having
> some static server job call that once and ever more serve up a a
> plain-file doesn't seem like a big restriction, and would mean that any
> git client code wouldn't need to deal with another encoding format.

I agree that it would be good to have a Git command that prepares bundles
for publishing on a static webserver, complete with table of contents.
It would be especially good if this incrementally updated the table with
new bundles as time goes on.

Thanks,
-Stolee
