Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D52816BE17
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743582072; cv=none; b=tq8u6YMDQYczYVEkgr2Sx6zKbjHmQtGK6ZG3AnAtUyq393/HIlLwZclRWZuEa7vNgpTDDrlXLEho5ORR+JpHLgstdAgOgnktWgma3P98z8UI2foP8AsiATE6nq2lUmXmJz9opcoYapxicR3EV8IlDWDMqxn3ZOljxUYk1RSIEL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743582072; c=relaxed/simple;
	bh=ktnvmSAzcjw7Lij4WZ3y8wJwzmaDM9hUaJVaQzKh9z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8EBq6NualHzYWkfWgtPsKNXgQz9o0o6BOp9J5B/4ffeAoTx2sKUEtA+cizyhECLbxExH6TufSqJzBRNndxOG5phebONDpIMy4/upioTLkn8CtLGQxjzDYzP37gb6Y+36sknwcdj6FifT+jjHfvbstM+aDNk6C6ngkjhTSS2pbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EbmbNstS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=djNhtFck; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EbmbNstS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="djNhtFck"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2516E25400D7;
	Wed,  2 Apr 2025 04:21:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 02 Apr 2025 04:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743582069;
	 x=1743668469; bh=kHnO1ymS+t9aXJhRLYP4ZoUhxYE4ZgM6NkpG3/8ROWE=; b=
	EbmbNstSQG/U9zX+Pt+kGz7F1lIgKkzZgBuc/7dZ1KaCXcGH56BCY4RMLDMfVAZz
	o7Xt54J6RrAg8qObP0YT2QGPEmBqqH9VbXZzRCfA8fo8sHMiO/ufyU3FpsyMrFNN
	o3uSlT4QPLrouszD/RGH8g0VkfYHEd//WB+5UmNT23oO1TKg1P8gc1kZZRuGC/Gr
	rhNR1oBN0e3aZzAxi8Es5HFVoUjK/XbVkIBIHJVAs3NSRvECfMe2lsaIIBEoexaz
	elJD2EKGFxKxtMJTrBPmXgHuGrgIKvhdO7pZCcqX62Qd5kdF1PQC730phqk7Nt4L
	Guq26+5TNx2O2SQlv1m/DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743582069; x=
	1743668469; bh=kHnO1ymS+t9aXJhRLYP4ZoUhxYE4ZgM6NkpG3/8ROWE=; b=d
	jNhtFckrul+p+00fyjgL6afLZ0j2rPS3z486xZ6jmZXb+eI7CslbKPvRlZ448g7D
	OdP241Ll1/Ffye4D2szeVx/CXMcc095cDcyjFsyb+gqTfRO2jyif6a3WcVKYtIW5
	bJ9/CtVQT5qNjv3/dTctJ8WPK+5MqhxELTeNTyrXMBPHSaB41cCrzVL+G5Sy0k4Y
	qRGx+P+ng25dcUeXvfLrg4/8kzD7+DLqoWwlkkHMEpoLJTY4VbhIUT0iJEdzYcAq
	cNqd4PSR5inf/qcDqutyolNQpiHqiR3S5f38sTyI8DEv3126BnZVrimPsy1AjMWD
	J4Xrp4+B13qhlBbirCPOA==
X-ME-Sender: <xms:dPPsZ1tykLQOJNpeVQhG4P0Mlzvs0KtNKI2yYUS4Qk0W5YrdLlXFQw>
    <xme:dPPsZ-eOGEZkE3CGheb3YAVwO2jZayBArt6bjcdjAlabRk-GikOFub3a-1zBzMqBU
    yEq4vd1WWKApKuPQQ>
X-ME-Received: <xmr:dPPsZ4y6LO9hH7Rcs7blwD6o-s63ln4vZGjx850oeFXMCDtmdBTDn58RAUFeDO6jfNV7Jx3AEcipTGJs4Za6lo_Gil4D1vDGMaQANp0jdN86DQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgu
    rhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitg
    hkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhn
    peegiefgtddugfduvefhuddvudehhfeuudeuudefveegfedvgfefueeikeefteegkeenuc
    ffohhmrghinhepghhithhhuhgsrdgtohhmpdhgihhthhhusgdrihhopdhlihhnkhgvughi
    nhdrtghomhdpghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopehmvggvthhsohhniheftddujeesghhmrghilhdrtghomhdprh
    gtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhh
    higrmhhthhgrkhhkrghrtddtudesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:dPPsZ8OhmKvpGyvENwba1Om4nMLUmbJ0P8vfVBwr6ki7MeR7ENd7Aw>
    <xmx:dPPsZ1_WWaeTVUK4ryH-sNva21M69nYx2rI1es9KOA_aKnbWYfV23w>
    <xmx:dPPsZ8U8VHqeQaTGtHmlwASeaEuIPr-Ah3dxuvFGSQk1t6LClixtEA>
    <xmx:dPPsZ2dvsBL0h_Ei7BaYtEmFqgh-Er2cu7j57AdmGvcGZ1IqZS2y8A>
    <xmx:dPPsZ5GQxwp8C5MzYLeKnloRMsps4gIfelBvzDRtyQlfkRNQ_c1fk5YX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 04:21:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8046ecf7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 08:21:05 +0000 (UTC)
Date: Wed, 2 Apr 2025 10:21:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, shejialuo@gmail.com,
	karthik nayak <karthik.188@gmail.com>,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: Re: [GSoC][Proposal RFC] Consolidate ref-related functionality into
 git-refs
Message-ID: <Z-zzbOrZde8B1kA6@pks.im>
References: <CAPhwyn3McL-2rwjkexsDUWqxt0Kr4UsDVy_G=s1DmKhrw5BZ-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhwyn3McL-2rwjkexsDUWqxt0Kr4UsDVy_G=s1DmKhrw5BZ-A@mail.gmail.com>

On Tue, Apr 01, 2025 at 07:07:21AM +0530, Meet Soni wrote:
> GSoC 2025 @ Git | Meet Soni
> Consolidate ref-related functionality into git-refs
> ---------------------------------------------------
> 
> 
> Personal Information:
> ---------------------
> Name: Meet Soni
> E-mail: meetsoni3017@gmail.com
> Mobile No.: +91 9054520887
> 
> Education: Silver Oak University, Gujarat, India
> Year: III/IV
> Degree: Bachelors in Computer Engineering
> 
> Time-Zone: UTC + 5:30 (IST)
> GitHub: github.com/inosmeet
> Blog: inosmeet.github.io
> LinkedIn: https://www.linkedin.com/in/meet-soni-4230701b9/
> 
> 
> Pre-GSoC:
> ---------
> 
> I got into Git’s codebase in November 2024 by reviewing various documentations,
> previous patches and began contributing in mid-December 2024.
> 
> Following is the list of contributions that I have made:

Quite an impressive list.

> The Project:
> ------------
> Currently, Git’s reference management is distributed among several commands,
> including git update-ref, git show-ref, git for-each-ref, git pack-refs, git
> symbolic-ref and git check-ref-format. The functionality of these commands is
> implemented using the functions from refs.[c|h]
> 
> This project aims to streamline reference management in Git by consolidating
> functionality currently spread across multiple commands into a single git-refs
> command. The project-idea page specifically mentions update-ref, show-ref,
> for-each-ref, and pack-refs; therefore, this project will initially focus on
> these four commands, with the remaining ones slated as stretch goals, more on
> that below.
> 
> The updated git refs command will offer subcommands to list, retrieve,
> verify/check existence, write, and optimise references.
> 
> Since the project involves developing new subcommands, selecting appropriate
> names and addressing design considerations will be one of its primary
> challenges.
> 
> 
> The Plan:
> ---------
> To tackle this project, the consolidation of each command will be divided into
> the following steps:
> 
>     1. Create subcommands:
>       Develop the actual subcommand under  the refs
> command(builtin/refs file) by
>       leveraging core functions from the refs module. The implementation will
>       mimic the logic of the legacy commands to maintain consistency
> with existing
>       behavior.

It should mimic existing commands where it makes sense indeed, but we
should also consider whether there is opportunity for improvement. That
is of course a harder question to answer, but I'm sure that we will find
some subcommands where it would make sense to break with existing
behaviour.

>     2. Tests:
>       Develop comprehensive tests to verify that the new subcommands function as
>       expected. This will involve creating a range of tests, including shell
>       scripts and/or unit tests located in the t/ directory. For the existing
>       tests covering the legacy commands targeted for consolidation, the plan is
>       to retain them initially—even if this results in some duplication—with the
>       intention of deprecating them gradually over time.
>     3. Update old usage:
>       Modify all call sites of the legacy commands to invoke the newly created
>       subcommands, ensuring a smooth transition and seamless integration with
>       the consolidated command.

This would be nice indeed, but it's not necessary as part of the GSoC
project from my point of view. The old commands won't go away anytime
soon as they are extensively used in scripts outside of our control.

>     4. Documentation:
>       Develop comprehensive documentation for the newly implemented
> subcommands to
>       ensure clear guidance for users and maintainers.
> 
> 
> Command mapping and naming:
> ---------------------------
> 
> I have taken reference for potential names for these subcommands from Patrick’s
> suggestion (https://gitlab.com/gitlab-org/git/-/issues/330):
> 
>   # Replaces git-show-ref(1) and git-for-each-ref(1).
>   $ git refs list
> 
>   # Replaces `git show-ref --exists`.
>   $ git refs exist
> 
>   # Replaces `git show-ref --verify <ref>`.
>   $ git refs show
> 
>   # Replaces git-symbolic-ref(1) to show a ref.
>   $ git refs resolve
> 
>   # Replaces git-pack-ref(1).
>   $ git refs pack

As I suggested elsewhere already, I think `git refs optimize` would be a
better name. The verb "packing" mostly stems from the "files" backend,
where loose files are indeed moved into a "packed-refs" file. But with
the "reftable" backend that name makes less sense.

>   # Replaces git-update-ref(1).
>   $ git refs write
> 
>   # Replaces git-check-ref-format(1).
>   $ git refs check-format

I think this one could be improved, as well, as it doesn't quite
indicate what format you're checking. "check-name" might be a better
fit.

[snip]
> Options/Config sharing:
> -----------------------
> For sharing configuration options, I propose a structure-based approach that
> centralizes common options while grouping subcommand-specific settings into
> dedicated substructures. This design embeds common options directly in the
> top-level configuration structure (struct refs_options), and then uses separate
> structures (such as struct list_options) to encapsulate options unique to each
> subcommand.
> 
> Below is a representative code snippet illustrating this approach:
> 
> struct refs_options {
>         ...
>         // ... Common Options …
> 
>         struct list_options list_opts;
>              struct exist_options exist_opts;
> 
>         // ... Similar fields for other subcommands ...
>         ...
> };

The other structures probably do make sense, but I don't think it makes
sense to have a structure that summarizes all of them. If there are
common options that will need handling for all of the subcommands (are
there?) then I'd rather go the other way round and introduce a
`refs_common_options` structure that gets embedded in e.g.
`list_options`.

> struct list_options {
>      // ... options specific to 'list' subcommand ...
> };
> 
> 
> struct exist_options {
>      // ... options specific to 'exist' subcommand ...
> };
> 
> 
> Since we plan to maintain the legacy commands for the foreseeable future, we
> must ensure backward compatibility while developing these new subcommands. Going
> through this I wonder if we should make the commands as a standalone
> entity, like
> a library. However, it needs to be thoroughly discussed.

Much of the functionality probably already is somewhat encapsulated,
it's mostly the option handling that we'll have to unify somehow. In any
case I expect that the exact mechanism will vary between the different
subcommands and it's fine to decide on a case-by-case basis once you
start to implement them.

> While studying these commands, I thought why not try out one of them to better
> understand the project’s requirements, scope and get a firmer grip on the
> codebase. So, I developed a reference implementation of git refs list that
> mimics the behaviour of git show-ref with [--head], [--branches|--heads] and
> [--tag] flags, which can be found (https://github.com/inosmeet/git/pull/1).
> 
> Although this reference implementation is still a work in progress and not yet
> ready for merging into master, it demonstrates my understanding of navigating
> the Git codebase and the process of creating commands and subcommands. More
> importantly, it indicates my ability to execute this project effectively.

Nice :)

> Timeline:
> ---------
> Pre-GSoC (Until May 8):
> * Continue to work on different things like the pending WIP patch that I have.
>   Be engaged/involved in the community.
> 
> Community Bonding (May 8 - June 1):
> * Talk with mentors and discuss potential names for the new subcommands and
>   interface design. Start the consolidation early with mentors’ permission.
> 
> Phase I (June 2 - 29 June):
> * Consolidate update-ref command along with subcommands/flags to refs… command.
> 
> Phase II (30 June - 27 July):
> * Consolidate for-each-ref command along with subcommands/flags to refs…
>   command.
> 
> Phase III (28 July - 24 August):
> * Consolidate show-ref and pack-refs command along with their subcommands/flags
>   to refs… command.

Part of what git-show-ref(1) does is also covered by
git-for-each-ref(1). So it would probably make sense to implement those
two parts in a specific phase, but single out the non-shared parts (e.g.
the `--exists` flag) into a separate phase.

Also, given that you've already started to work on git-show-ref(1) a
bit, wouldn't it make sense to move that to phase I?

> Final Week:
> * Some final touches. Make a final report about the work accomplished and
>   outline future work.
> 
> I have not allocated separate timeline slots for tests and documentation, as
> these will be integrated into the patches that introduce the new subcommands.
> 
> I think if permitted to start early, I can consolidate one more command within
> the GSoC period.

We cannot keep you from doing this, but please keep in mind that if we
end up picking a different candidate for this project we would favor
their work so that they can successfully finish GSoC. So I would
definitely wait until you've been selected before starting to work on
anything.

Thanks for your interest!

Patrick
