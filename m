Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1096E1C5D5E
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743414169; cv=none; b=iAI8eX+zqkUWWOt55+E/Ki14m6QPq6fnEh2qZvFGXD+RHxDvJBQOCXA6eIK6cP6SbPqo9FDnS3g3hkD/NiERKTE31See0nvpo5iJ1D18RDSptQsbjkpMnaKO2MND/Fs/31OzKDbd21XH97PVZXLEy6lFnjg+tHSfPDzqkSy3ISU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743414169; c=relaxed/simple;
	bh=TV6pOgk3z7Jqdz+UkorJlxpL6i3kUCBXPgfC6iEc3cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDTfVWD2GjRapGFpXR87blg3KI8Q+lTywi0zk8b7Z7Vr0Ymy560LyhNUv3Lc+UdBgK4fsuUsGJSvAHQO5+IdvuxwxPhgCaS/pNCsRxnqXn7BveZfiBj1oHNGst3dVUMsvgZDf5U0ZzmxcMIPhb2zqeFcQC31wKmd5Bx1IUN7KRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BHT0ssrW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LKh3zXcw; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BHT0ssrW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LKh3zXcw"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 09CEB1382D51;
	Mon, 31 Mar 2025 05:42:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 31 Mar 2025 05:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743414166;
	 x=1743500566; bh=TyZFsdVSVnQJZ+JLkcRp8ylxTPftzzattXWxzl0klYM=; b=
	BHT0ssrWVWqJ18GfV0Ecl9cmMbKuuhXdnjpKQ7koX9vGKQH2LJvCj7k0SfF1Swsg
	8SW2TgrkvV0drX4g8uKS1Go+QdS4xRx62vboHg9WBu6IUc5CMUqOC+eLkC63sHLF
	WyaJL9oeVTmkoQcnjJjBNPFyxnJquwT591jld0E6iydk00/B7o8xQvknJOQltPo6
	5VPx12Yd9ONhI4u0NOTa4ylh2xlj/Lh+JbqDUj2eOksABLPQlH2D7r+7maVHU+Y0
	Q6vXc9Ia6GYPJ45RA6bmkJaQ/W9fjw6gtzgYoxL00YxqIdxUMR9EIdxF5z6YgZ7V
	MfDZ2fbJgI19ykIViaU/Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743414166; x=
	1743500566; bh=TyZFsdVSVnQJZ+JLkcRp8ylxTPftzzattXWxzl0klYM=; b=L
	Kh3zXcwkLQYJB6WMI0NBMk/avww5lQCAr0bJBanudlmAj/9FD78FnKz5OdX/gSzK
	sMxSeznUNWtVZCW22Jq1XG80XO2ZdG+JuO9+jmzgKQVczHKzOM2qh5ooLavLRWIm
	55YAI4F8HwOvtiwuss2aSE1/VnpY4mr3z0U4F0juQgJkLZT45xGlGj0Yo95HFBIn
	pEOM9yYcWJDCMkhX6weDVOsOiXR8KIrCgR5wkOKyWidERU/EKrxJNyw26+0mT/kR
	rohYxBgXCJQdl0v2DtdHG9KnUxgZpRTxSiVIp9tZ/X0OEQ7knSu43vceVLRQqWib
	EEYFfXOFhXxSbrIqkjV5A==
X-ME-Sender: <xms:lWPqZ-jFd5VM9C6mu9lf4K0irBAJOnPWNs42ze6WX9qMwT8olaT9Hg>
    <xme:lWPqZ_DPoylZ38YlAoXkPmObkhA5xX9OMBm0lZenf9IUCa14FO3oTK2-7AUT9YrVH
    _hu2_Exa_V10uUwgg>
X-ME-Received: <xmr:lWPqZ2GBMbBkzUD1wR0Dva2bEvUBhcrCEPji7W16k9xe_q0wRpHBr-I4ug2iThNZ8tIO8AVb0vzYL-SMteLOJaY4PXJsCfxO_-F1pmjWS_IOkVN9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefje
    eitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptdeh
    iiihtheftdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:lWPqZ3SooCfpQkIZgv9PG3kwfQMb9meNxjp1hsrQvuhOPHP34NXulA>
    <xmx:lWPqZ7y181XLuTxV5XA06WUTNpM4hE7wJAVjc02_bnAIyisWjMjXaA>
    <xmx:lWPqZ17lQaASWBY_obYHEl2KU7umFDPq1Fs2wnEOuyxY6ujW3qjqhA>
    <xmx:lWPqZ4yuZtkvlLWIFKUUMGV1npCBLmrxPEfuMS56CfHyVLVHr47NbA>
    <xmx:lmPqZ28-QTcQsZHPgah-IFr1g9dh-HXSqHUYc6Fq0IDkjD5j9XtLbpU2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 05:42:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 576fd7d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Mar 2025 09:42:42 +0000 (UTC)
Date: Mon, 31 Mar 2025 11:42:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Zheng Yuting <05zyt30@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC] git-refs proposal draft
Message-ID: <Z-pjjQhtCjLvghGl@pks.im>
References: <CAMvj1+rbYKFNeWEvvN76MTpzfuWc4TN4ViXRE4nTfWy7ZMspWg@mail.gmail.com>
 <20250329150248.2274482-1-05ZYT30@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250329150248.2274482-1-05ZYT30@gmail.com>

On Sat, Mar 29, 2025 at 11:02:46PM +0800, Zheng Yuting wrote:
> ## Name and Contact Information
> 
> - Full Name: Zheng Yuting
> - Email Address: 05ZYT30@gmail.com
> - Time Zone: UTC +8:00
> 
> ---
> 
> ## Abstract
> 
> The current Git reference management functionality is fragmented across
> multiple independent commands (git-show-ref, git-for-each-ref,
> git-update-ref, git-pack-refs, git-check-ref-format, and
> git-symbolic-ref), leading to code redundancy and increased maintenance
> costs. Based on Patrick Steinhardt’s integration vision[1], this project
> aims to introduce 8 new subcommands (list, exists, show, resolve, pack,
> update, delete, check-format) under the existing git-refs command to
> achieve the following objectives:

I have a couple of opinions on the exact naming of the subcommands, more
on that below.

In any case, I don't think the naming and how exactly each of these
commands should look and work like needs to be hashed out in this
document. It's nice to scope out _what_ we want to achieve and propose
how this could look like, but ultimately I think that most of the design
should happen during the project itself.

> - Feature Integration: Consolidate existing reference management
>   commands under git-refs, while maintaining backward compatibility.
> - Feature Enhancement: Introduce recursion depth control for git-refs
>   resolve.
> - Testing & Documentation: Add test cases ensuring consistency and
>   update relevant documentation.
> 
> ---
> 
> ## Implementation Plan
> 
> ### Command Integration Strategy
> 
> #### Design Goals
> 
> The project will unify scattered reference management functionalities
> under the git-refs subcommand framework, ensuring:
> 
> 1. Complete Feature Coverage: Each subcommand fully replaces its
>    corresponding legacy command.
> 2. Parameter Compatibility: Preserve the semantics and output behavior
>    of legacy command options.

This one is something that is up for debate. While I do expect that most
of the commands should remain current semantics and options, we could
also use this as an opportunity to think whether there are any issues
with the current design and improve upon it.

> 3. Code Reusability: Minimize redundancy by sharing underlying modules
>    (e.g., refs/files-backend.c).
> 
> #### Subcommand Mapping
> 
> - git-refs list
>   Replaces git-show-ref and git-for-each-ref, merging reference listing
>   functionalities with support for formatting (--format), filtering
>   (--heads, --tags), and sorting (--sort).

Yup. One thing to note is that git-show-ref(1) and git-for-each-ref(1)
are very similar, but not quite the same. One should find good arguments
which of the two semantics are preferable to us and why that is.

For example, git-show-ref(1) outperforms git-for-each-ref(1) due to the
default format:

    Benchmark 1: git show-ref
      Time (mean ± σ):      99.0 ms ±   0.5 ms    [User: 55.6 ms, System: 43.0 ms]
      Range (min … max):    98.0 ms … 100.8 ms    100 runs

    Benchmark 2: git for-each-ref
      Time (mean ± σ):     134.0 ms ±   0.6 ms    [User: 82.3 ms, System: 50.8 ms]
      Range (min … max):   132.7 ms … 135.8 ms    100 runs

    Summary
      git show-ref ran
        1.35 ± 0.01 times faster than git for-each-ref

> - git-refs exists
>   Replaces git-show-ref --exists, providing reference existence checks
>   with positive (<ref>) and exclusion-based (--exclude-existing)
>   verification.

I'm not quite clear what exclusion-based existence checks is. How do you
check whether something exists when you exclude it? I don't think that
this option is relevant in the context of `git refs exists`.

> - git-refs show
>   Replaces git-show-ref --verify, validating reference correctness with
>   a strict mode (--strict).

Yup. In contrast to `git refs resolve` this command shouldn't resolve
the ref, but directly show what it's pointing to. And this should be
true for both symbolic and normal refs.

> - git-refs resolve
>   Replaces git-symbolic-ref, resolving symbolic references with added
>   recursion depth control (--max-depth), while retaining deletion (-d)
>   and quiet mode (-q) options.

Not quite. The difference to `git refs show` is that this command always
resolves the ref to an object. So it's rather more similar to `git
rev-parse --verify`, except that it only ever handles references.

> - git-refs pack
>   Replaces git-pack-refs, packing loose references with support for
>   filtering (--include, --exclude) and automatic cleanup (--prune).

I would probably call this `git refs optimize` or something like that.
git-pack-refs(1) is mostly called this way because it was introduced to
pack refs into the "packed-refs" file. But nowadays with the reftable
backend I think that the command name is somewhat inaccurate.

> - git-refs update
>   Replaces git-update-ref, providing transactional reference updates
>   with batch processing (--stdin) and atomic guarantees.
> - git-refs delete
>   Separates the delete functionality from git-update-ref, ensuring
>   explicit handling of reference removals with safety checks and batch
>   operations (--stdin).

It's up for debate whether we should even have something like `git refs
delete`. As you rightfully notice `git refs update` already handles the
usecase, so it feels like needless duplication.

> - git-refs check-format
>   Replaces git-check-ref-format, validating reference format with
>   support for normalized output (--normalize).

Ah, nice, this is a command I forgot about.

> #### Implementation Strategy
> 
> 1. Option Parsing: Each subcommand will reuse the argument parsing
>    logic from legacy commands (e.g., git-pack-refs --prune).

We cannot and do not want to do this for every case. As mentioned above,
we may want to iterate on some of the subcommands to address historic
warts. But overall I agree, we should of course aim to reduce
duplication as far as it is sensible to do.

> 2. Shared Backend Logic: Calls to common functions in refs/ (e.g.,
>    reference traversal, locking mechanisms).
> 3. Error Consistency: Maintain the same error codes and message
>    formats as legacy commands.

Same reasoning here, we may want to adapt some of them. The old commands
won't go away as they are used everywhere, and that makes it more
reasonable for us to change behaviour in their newer equivalents.

> ---
> 
> ### Example: Implementing git-refs pack
> 
> #### Functional Implementation
> 
> 1. Modify builtin/refs.c:
>    - Add cmd_refs_pack function implementing git-pack-refs logic.
>    - Update cmd_refs to include pack with
>      OPT_SUBCOMMAND("pack", &fn, cmd_refs_pack).
>    - Define REFS_PACK_USAGE:
>      git refs pack [--all] [--no-prune] [--auto] [--include <pattern>]
>      [--exclude <pattern>].
> 2. Register New Subcommand in git.c:
>    - Add { "refs-pack", cmd_refs_pack }, to the command array.

You don't actually have to change "git.c" to introduce new subcommands.
We don't want `git refs-pack`, but rather `git refs pack`, which is an
important distinction.

> 3. Reuse refs/files-backend.c Logic:
>    - Ensure cmd_refs_pack calls pack_refs correctly, adjusting as
>      necessary for new options.

We shouldn't have to touch any of the backends at all. You should rather
make sure to integrate with "refs.c", which wraps the backends and
provides a backend-agnostic interface to refs.

> #### Testing Plan
> 
> - Test Cases:
>   Add t/txxx-refs-pack.sh, leveraging t/t0601-reffiles-pack-refs.sh
>   scenarios to verify:
>   - --prune removes obsolete references correctly.
>   - --include and --exclude apply filtering as expected.
>   - Packed references match legacy command outputs (diff .git/packed-refs).
> - Performance Benchmarking (if needed):
>   Add performance tests in t/perf to ensure no significant regression
>   in execution time or memory usage.
> 
> #### Documentation Updates
> 
> - User Manual:
>   Add a pack section to Documentation/git-refs.txt, mapping options to
>   legacy command equivalents.
> - Developer Notes:
>   Comment code to highlight functional parity between git-refs pack
>   and git-pack-refs.
> 
> ---
> 
> ### Timeline
> 
> - May 8 - May 11 (4 days): Initial Testing & Subcommand Framework Setup
> - May 12 - May 28 (17 days): pack Subcommand Implementation
> - May 29 - June 14 (17 days): check-format Subcommand Development
> - June 15 - July 5 (21 days): update and delete Subcommands Development
> - July 6 - July 26 (21 days): show and exists Subcommands Development
> - July 27 - August 16 (21 days): resolve Subcommand Implementation
> - August 17 - September 6 (21 days): list Subcommand Implementation
> - September 7 - September 16 (10 days): Mid-term Review
> - September 17 - September 23 (7 days): Mentor Review & Final Adjustments

You probably underestimate the time to review and land a specific change
quite significantly. Landing new features in ~2 weeks is thus not quite
realistic and you should allocate a lot more time for each of the
specific subcommands.

That of course raises the question of how to squeeze all of the
subcommands into a single GSoC. And the answer is that you don't: it's
perfectly fine to implement only a subset of the new proposed
subcommands. I'd rather you spend more time thinking about how to
improve upon the status quo for each of the subcommands and thus spend
more time on it than trying to do everything in a hurry.

So: there isn't any expectation that you manage to implement all of
them. I'd recommend to pick a subset of commands that you want to
implement as a realistic goal. You may define other commands as a
stretch goal in case you manage to speed through the implementation way
faster than I anticipate.

Thanks!

Patrick
