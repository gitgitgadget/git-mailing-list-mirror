Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27BB189519
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 23:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726701513; cv=none; b=RqcKiSHcaMQdWpbKGG0iMMnnHEQWVdspiahqXK8e0J+wnQyBlDDFHkr6X3W2NJDDmTw+kX1ohwJgTsdBppA6zBJdSiJQOAWjCNvi23oQfxbNlI4TrWRhsaB43j2hpczBKJsz95jqregj0xPDwUUytCzN09HRQGyg1c6gZJZVJuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726701513; c=relaxed/simple;
	bh=CQCVFsHka0fNA1M6dUO8D21WO+9qLy1GT2aWvpLQ9B0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rmkusLsRfvKy/ZMw+c3msy+o6gUNSEyR0bNRSk0/RdKTTLUT5PDmFsDNvBWt8lFg9j5r8gj13Rg6G2VwGBhuzaHc1Hz1GfPjC1UVL0jCjgE9NIiyDf9R8kNgRtChV7DEwbwSjwV76W4nkJypBIbZr7EeZZ2/z2opPHcblHYD2Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHYrp/MQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHYrp/MQ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-206b9455460so1932095ad.0
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 16:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726701511; x=1727306311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eytcvXxTaXnNqY4leCh2td5EjhpYZRTVJQUT1ovNHN0=;
        b=BHYrp/MQ7Sr43H+AjrIXI3WhTy7y2ewrXWNvRPsAv4pem7DgsUYcwCkfT9TDuu7quR
         UhY3InKJGmlXYEvEHhmqzUdcK7SzIBUtbP65eGk5gowEvH5E+5CwNiT+843hjVLcTT7D
         klHYkF0eimxiJyak4TRyeFtFCarPjQ19EORPUKNHzENm8c5mIoaaw3r+CHCYgPE+I92q
         7iZTgVKVN71J1uwPcrRXK0Zp+1sLqAT54CWZUSutT73p27+RQw5NzEjE0h1RYmr5g2J4
         w8fvo2Wi05238wSqaxhv058HG6C94h9wIGGEnAqCLJjDUdTC5xmFbCCSXSAk7KazQima
         KkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726701511; x=1727306311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eytcvXxTaXnNqY4leCh2td5EjhpYZRTVJQUT1ovNHN0=;
        b=QoM9JTrLh9ZQc+qdAvqSgoabKBTPdQrKGIDYt3Z6IvR9Qcd4dkly77UhHo6Ru1vYb2
         WXJsvZsqOjy1dfFjFmaXUMbSGjDt08gNN0sMFYGLrSLzb+vcbytsEnpRnt/mu4+1TfdH
         S4aWzs8LCWcCVX413u9Nfv8jegnlVM2F/gkqZ/IkkXg1/K5lTb2BYLld52RSnAeyCXWW
         1eUGou64Db0FPYqPPreN+i0UE3Sqvj45KNdRZicj4sfpiIEkcU/aosi5/F2GexCoZqpd
         DsbjR7EdF6lih1AuLOaFTiOalB1R6JRmI3b/gOiHABYFG8UKeSjy71jdi8WSAvFCzPQ3
         CCGg==
X-Gm-Message-State: AOJu0YwVGW5iDasH/FQHaM66LR28+c7tjSioCXOUMiYW6bT0c5iXA6Hl
	UbfunnzEb2oZakXdTOxF7BvckiRFYUvtWydqT+jTTilANix3W77Mwsc+cg==
X-Google-Smtp-Source: AGHT+IHxGU/LxYQNfK/8QAZVScAcrCD/LmkmZK9sepTJ3THFapYhL2Fji3PVIjWT6ax0RXjoAnqSLA==
X-Received: by 2002:a17:902:e88b:b0:206:8915:1c74 with SMTP id d9443c01a7336-208cb902d2dmr18957725ad.21.1726701510463;
        Wed, 18 Sep 2024 16:18:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:8559:eaef:b03f:6f5f? ([2600:1700:60ba:9810:8559:eaef:b03f:6f5f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d63c8sm69572895ad.156.2024.09.18.16.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 16:18:29 -0700 (PDT)
Message-ID: <53dc17f8-82e5-40fa-81b7-af89f987928b@gmail.com>
Date: Wed, 18 Sep 2024 19:18:27 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/30] [RFC] Path-walk API and applications
To: Christian Couder <christian.couder@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, ps@pks.im, me@ttaylorr.com, johncai86@gmail.com,
 newren@gmail.com
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
 <CAP8UFD0uyVk5WPX12sGhWWXkdQWGpBhG29Q-9EmBxHos1XQ_uQ@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAP8UFD0uyVk5WPX12sGhWWXkdQWGpBhG29Q-9EmBxHos1XQ_uQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/17/24 6:41 AM, Christian Couder wrote:
 > On Tue, Sep 10, 2024 at 4:29 AM Derrick Stolee via GitGitGadget
 > <gitgitgadget@gmail.com> wrote:

 >>   * git backfill: a builtin to download missing blobs in a blobless partial
 >>     clone, done in batches and grouped by the path they appear in to maximize
 >>     delta compression in each batch. Allows focusing on the paths of the
 >>     sparse-checkout to only get the blobs necessary for history queries in
 >>     the current focus.
 >
 > It's not very clear if this would be useful when doing a `git
 > sparse-checkout add`, or a `git blame` on a file path not covered by
 > the current sparse-checkout, or both. I think it would be clearer if
 > there were a few examples.

You are correct, this doesn't help with either of those examples, as
they both require blobs outside of the current sparse-checkout. The
idea is for users who are most often in a given sparse-checkout to have
the experience as if they were in a non-partial Git clone, as long as
they restrict their activity within their sparse-checkout.

If they increase their sparse-checkout, then they can re-run 'git
backfill --sparse' to get the still-missing objects in the new paths.

 >>   * git survey: Jeff Hostetler built this feature [1] as a way to get
 >>     functionality similar to git-sizer [2], but using the internals of Git to
 >>     do it faster. It also displays information not available to git-sizer,
 >>     like the on-disk size of objects. This RFC presents a simplified version
 >>     of the builtin focused on listing the paths that contribute the most to
 >>     the on-disk size of trees and blobs.
 >
 > Not sure how `git survey` works, but `git sizer` works on a whole
 > repo, so, if they work in the same way, I am not sure I see what a new
 > path oriented way to walk repos would bring to the tool.

`git survey` also works on a whole repo, but with the path-walk API
implementation can talk about a group of objects that appear at a common
path instead of only talking about single extreme objects, such as one
large binary (that never changes) being singled out over a small file
that chnages frequently and across all versions contributes more to the
repo's disk size.

The main benefit of using `git survey` over `git-sizer` is that it can
report on things internal to Git's storage that are not accessible to
`git-sizer` through the `git cat-file` output it uses.

 >>   * git pack-objects --path-walk: In order to find a way to compute deltas
 >>     among objects of the same path, I applied the path-walk API to 'git
 >>     pack-objects' behind an optional flag. There are overlaps with the
 >>     '--sparse' option [3], [4] that can be used here. This provides perfect
 >>     partitioning by path name, without any possible collisions from the
 >>     name-hash algorithm. It also allows using the name-hash values to find
 >>     cross-path delta chains in a second pass.
 >
 > Do you mean that the new way to walk repos allows pack-object to
 > perform better in the general case or maybe only in the case where
 > partial clone without blobs and sparse-checkout are used as described
 > in the git backfill related point above?

 From what I can see, `git pack-objects --path-walk` outperforms all other
repacking strategies that I have found, but it does have some weaknesses in
how it interacts with things like delta islands. There may be other concerns,
and I _was_ able to find a repo that compressed slightly better with `git
pack-objects --full-name-hash`, but it was also storing computer-generated,
single-line JSON files representing configuration of production systems. I
would like to have a more generic thing to say about this, but it will vary
on data shape.

 >> This feature was
 >>     already sent to the mailing list as a fully-reviewable series [5]. It is
 >>     included here because this series allows testing the --path-walk option
 >>     against the --full-name-hash.
 >
 > Do you mean that the new way to walk repos can be used along with `git
 > repack --full-name-hash` (maybe with `git repack --full-name-hash
 > --path-walk` or a config option or otherwise?) and that it brings some
 > performance or other kind (better packs or which ones?) of
 > improvements?

Combining the two features actually ends up with very similar performance
to what `--full-name-hash` already does. It's actually important that the
`--path-walk` option does a full pass of the objects via the standard
name-hash after its first pass in groups based on the path.

It's more that I include performance tests that compare how effective the
two features are relative to the existing repacking strategy and in a few
different situations. This helps with both time and space performance
measurements.

 >> TIMELINE FOR CREATING THESE APPLICATIONS IN THIS ORDER
 >> ======================================================
 >>
 >> Here's the story about how these applications came about: I was tasked with
 >> understanding why certain internal repositories were growing larger than
 >> expected. (Feel free to skip. Otherwise, thank you for indulging me.)
 >>
 >> I first prototyped 'git backfill' as a way to download some of the largest
 >> repositories without being blocked on a full clone. This batched download
 >> mechanism allowed me to essentially have a retryable clone, since the client
 >> could restart the process from scratch and skip any objects that were
 >> already on disk. It was natural to batch based on the path of the blobs in
 >> order to theoretically save time and network bandwidth due to better delta
 >> calculations.
 >>
 >> While investigating these repositories, I had some data hinting at the total
 >> size of the objects by type.
 >
 > By type (blob, tree, commit, tag?) or by path? Why would the size of
 > the objects by type be interesting? Could trees delta poorly?

The previously-existing data could only group objects by type (commit,
tree, blob) and report on the size of the reachable objects in those
categories. The per-path data was not available as no tool that I knew
about had the capability to expose that information.

 >> These
 >> paths were typically binary files that appeared only once or twice and did
 >> not account for the scale issues.
 >
 > You mean they couldn't account for a 55GB to 125GB change in data size?

The numbers were so small they didn't seem like they could have accounted
for any issues at all, let alone a hundred gigabytes of data in the repo.

 >> RFC GOALS
 >> =========
 >>
 >> The goals of this RFC are:
 >>
 >>   1. To demonstrate potential applications of the path-walk API to motivate
 >>      its generality
 >
 > Yeah, the "Path-walk API and applications" title summarizes this well.
 >
 >> as these features are sent in full-quality patch series,
 >>      but in a different order.
 >
 > I wonder if the patch series could have been separated and not all
 > sent in a 30 patch long series.

I was not clear about this, but the RFC is 30 patches so it's possible to see
the big picture, but I will be breaking it into at least four series in
sequence for actual review. They match the four sections described above, but
will be in the opposite order:

  A. `git repack --full-name-hash`
  B. `git pack-objects --path-walk`
  C. `git survey`
  D. `git backfill`

(It's possible that `git survey` and `git backfill` may be orthogonal enough
that they could be under review at the same time. Alternatively, `git backfill`
may jump the line because it's so simple to implement once the path-walk API
is established.)

 >>   3. To demonstrate the value of the path-based batching in the 'git survey'
 >>      feature, and to inspire others to think about what other statistics
 >>      would be valuable in that feature. (I anticipate that once a base is
 >>      established, multiple contributors will help expand its functionality
 >>      long into the future.)
 >
 > Yeah, a better git sizer would be valuable for GitLab too and probably
 > everyone hosting a significant number of repos.

This was definitely Jeff's intention, and I agree. Hopefully we can establish
a baseline quickly and then make room for extensions as people discover new
ways to investigate repo size or performance issues.

 >> PART I: 'git backfill'
 >> ======================
 >>
 >> These patches introduce the 'git backfill' builtin including its
 >> '--batch-size' and '--sparse' options. While this is the first and simplest
 >> application, it is also the lowest priority in terms of user need.
 >>
 >>   * path-walk: introduce an object walk by path
 >>   * backfill: add builtin boilerplate
 >>   * backfill: basic functionality and tests
 >>   * backfill: add --batch-size= option
 >>   * backfill: add --sparse option
 >>   * backfill: assume --sparse when sparse-checkout is enabled
 >
 > I would prefer a first patch series with all the above and the first
 > patch creating a technical doc called maybe
 > Documentation/technical/path-walk.txt which could contain a lot of
 > information from this RFC and perhaps technical details of how the
 > path-walk works and how it is different from a regular walk.

My rework of the `git pack-objects --path-walk` series has a draft of a
technical document as you suggest [1]. I regret not having time to get
it done before this RFC.

[1] 
https://github.com/derrickstolee/git/pull/28/files#diff-d8a8f04540e5fac6727529dcabf05501ba2447a7de340b540f2601e071b45260

 >> DISCUSSION OF NAME HASH
 >> =======================
...
 >> The --full-name-hash feature does the simpler choice of replacing the
 >> name-hash method with one that has fewer collisions, but loses the benefits
 >> of "nearby" paths having close hash values.
 >
 > The benefits of "nearby" paths are only available with --path-walk,
 > not in the current way object packing works.

I suppose this depends on your definition of "nearby" and I think we are
using it differently.

The --full-name-hash mechanism groups objects by their full path name, with
a small probability of a collision with another path, and thus we can think
about it as grouping objects by their full path. However, this lack of
collision comes at a cost: having unequal but "near" hash value does not
imply any similarity in the full path.

The standard name-hash algorithm has a form of "locality" that provides a
nice property: paths with unequal by "near" hash values will have some
similarities in the end of their path names.

Between these two mechanisms, the collisions of the standard name-hash
can cause objects that should delta together to be separated in the object
order due to too many objects with the same hash value, even though they
have very different full path names. While the full-name-hash mechanism
helps keep objects from the same path close together in the order, it
fails to compute good deltas across objects from different paths, even
if they may end similarly (implying similar file types or even renames
across directories).

The --path-walk feature has the nice benefit that it first attempts to
compute delta bases are grouped to exactly the set of objects that
appear at a given path (no more, no less) but then it _also_ does the
standard name-hash sort to help look for delta bases using the name-hash
locality heuristic.

 >> One natural question to consider is to think about storing both the
 >> name-hash and the full-name-hash and doing two delta passes, each one
 >> sorting the objects by a different hash function. The first issue is that we
 >> don't want to store two hash values per object, as that will significantly
 >> increase the memory pressure during repacking.
 >
 > Is one more uint32_t per object really increasing the memory pressure
 > so much? Isn't there a way to pack bits together to avoid that?

I hesitate to conclude that four bytes per object will not have a meaningful
impact. One thing that I'll be reporting on in my v2 of the --full-name-hash
feature is that I've gone and tried to prototype what would happen with this
kind of approach.

The short version is that I failed to make the addition of more data to this
struct helpful in outperforming the --full-name-hash option. I thought that
a two-pass approach would work, but something about how the two sorts worked
caused problems that I could not overcome. (Maybe someone with a stronger
handle on this could make it work.) My WIP branch is here [2] for anyone
willing to try to succeed where I failed.

[2] 
https://github.com/derrickstolee/git/compare/full-name...derrickstolee:git:full-name-wip

 >> This could be side-stepped by
 >> storing the full-name-hash in the packing list and then a second mapping
 >> from full-name-hash to name-hash. However, that still leads to the two
 >> passes taking extra time.
 >
 > Isn't there a way to sort using both hash functions in a single pass?
 > (That is to perform a single pass and when considering an object sort
 > it using both hash functions before considering a different object.)

We could sort the objects using both hash functions (say, name-hash then
full-name-hash to break ties) but then the full-name-hash values keep
the similar-sized objects with the same name-hash from being sorted near
each other (at least, within the short default window, which I use for
all of my testing). So this ends up being ineffective. In [2] above, this
is something I tested along the way and am pretty confident that it does
not work as well as we'd like it to.

 >> The --path-walk approach is faster than even a
 >> single pass.
 >
 > Is there a reason for that?

My guess here is that we are finding the "best" deltas quickly, allowing
us to short-circuit the possibility of other deltas due to file size
differences. (If my object has size X, with a current delta of size D,
then any object smaller than X - D will not be a good base.)

 >> First, we can consider the total reachable objects in each scenario:
 >>
 >> TOTAL OBJECT SIZES BY TYPE
 >> ================================================
 >> Object Type |  Count | Disk Size | Inflated Size
 >> ------------+--------+-----------+--------------
 >>      Commits |  20579 |  10443669 |      15092790
 >>        Trees | 276503 |  40212070 |     244429615
 >>        Blobs | 294500 | 635365661 |   10791187920
 >>
 >> TOTAL OBJECT SIZES BY TYPE
 >> ================================================
 >> Object Type |  Count | Disk Size | Inflated Size
 >> ------------+--------+-----------+--------------
 >>      Commits |  20579 |  10450605 |      15092790
 >>        Trees | 276503 |  31136263 |     244429615
 >>        Blobs | 294500 |  94442401 |   10791187920
 >
 > Using % of size reduction or increase might help make it a bit clearer here too.

True. I could compute that manually, as this data is not available in the
same process. I'll try to do that in the future.

 >> Now, we can consider the top 10 file paths before and after repacking with
 >> the --path-walk feature:
...
 >> The nice thing about this result is that we can point to files that are
 >> taking up space because there is no other way around it, not that the naming
 >> convention for the files is causing confusion during packing.
 >
 > Yeah, nice result. I guess the result is the same or very similar when
 > the improved name-hash algorithm is used.

Yes, similar results happen there. I haven't dug into them very much to see
if it helps point out anything about inefficiencies in --full-name-hash, but
I don't expect any of the big differences between --full-name-hash and
--path-walk to appear in these tables.

 >> WHAT TO DO NOW?
 >> ===============
 >>
 >> Thank you for reading this far. I hope that this has added context on the
 >> patch series for the --full-name-hash option, but also provided the right
 >> context for when I come back in a week or so with a review-ready version of
 >> the --path-walk option.
 >>
 >> These patches are rough and I want to make sure everyone knows that.
 >> Reviewing them for style or even basic organization may lead to some wasted
 >> time. I know that at least one of the patches got mangled and its diff does
 >> not match its description (I'm thinking specifically about "pack-objects:
 >> extract should_attempt_deltas()" but this could apply elsewhere).
 >
 > Ok, I will wait for the next iteration before reviewing the patches then.

Yes, I only meant for them to be available for those who were curious to
explore. Please do review v2 of the --full-name-hash series [3].

[3] https://lore.kernel.org/git/pull.1785.v2.git.1726692381.gitgitgadget@gmail.com/

 >> But I think that interested parties could take my branch, build it, and give
 >> these features a try on their favorite repos. I'd love to hear feedback on
 >> the usability and effectiveness, especially if someone finds a case where
 >> the --path-walk option is less effective at packing data.
 >
 > I might do that when reviewing the patch series later. I think it can
 > still be valuable for you to get some first feedback from just reading
 > this RFC.

Thank you! And thanks for the thoughts on this very long cover letter.

-Stolee
