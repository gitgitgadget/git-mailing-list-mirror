Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D371F12EF
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743675253; cv=none; b=HxBOClJ9Mn5EOWvwDFbQ6W3T8g9aw8SJRD8HmZst5O1haEwVNkwljDtA1dp/fcxseP4887we/O7oDMjKXYQQAMc6oXZomP+Sag8wP7nANjmYQ2VTp6Bug7KR+7knFUzv0qTb+IFOAw77mSNAHqJ+c3ZzC76ep4Fw8ujeHn1Up9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743675253; c=relaxed/simple;
	bh=t0kKGaWNUGhIQ80TLRR8d+eA5sIJQowY2+Bjr2TKB0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxLmVBirGGmAmpC4Pt8N7JuZMsBr4ECZF1OJxI+SFJZovZM7FK3a3qhOvAmSTKoDMH9RqmbHVllIEtR1ZILa3aVt5J6WVcpCmwC5Fqom/MDMccdAfyhU2j2Ao+ehyiOahWz2Ooaz6X/gp52UUDpczv8SZEHmcv/v/vXUEoOpesw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FcWp8R0d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bUzXg2aR; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FcWp8R0d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bUzXg2aR"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 917F911401AC;
	Thu,  3 Apr 2025 06:14:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 03 Apr 2025 06:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743675249; x=1743761649; bh=HiATU09TPr
	0CY0V0ho/HTxIbpOGhCWPGZhprGrBCgDY=; b=FcWp8R0dFObsiTj41tpjv1CTlb
	REvpei1s0DXnBvxJDj7FCqrAkZJPJDREDMZsETC2rUYdEdj/irRLIoCRt2CyeEEU
	P08MFRd4DCiwLvUnee6jLQ6qIdiSJl25jfEvss1D/BR9zC+VYKKIYosY/wpE/uRB
	FYgdmoLRlObAgq7oVy6emsPdcmsYLMgrnkkWpfk7xqKw2NKfCMwq+yVgJ6Ca0QVU
	4Ef486Kw9DPFiC2KGKNn49sZBiXb2cVXSHVQJY7yzcXFlR1iVuMCUdzzxQKegXIt
	JoeCWuTphTbhivYS1IklHR+V3zAMUcXVeJGfBRCdM1QYOQV/FK5InWkeh7Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743675249; x=1743761649; bh=HiATU09TPr0CY0V0ho/HTxIbpOGhCWPGZhp
	rGrBCgDY=; b=bUzXg2aRXuVxRmW5BhPPkbdU3rwmnIhHa9Ej0GXyMeLJP3rqt7A
	tlaZAzL5mLFkARRafdJuIYtIgwXOfqx1apB8V+l65puu0IQPrRxcA52Dus23s8Da
	N4ZEFas3/NSqs01eE1B5VLI+gjHwHsGn2RyfhKa0ILueO/uPfAQ9qVy7LgL71mnu
	OVAEMODbuddYgKzgWQM6tDkLdvk6UJAJYYa4vtm0gG1clVIGTs1vluDsikN4R7Dw
	HVsT7weyDOg4ISaxzJ4CjfrFlsqC/9aYQ3ZKs4jMukVpN0NpLI+pcQMNaC2cuByW
	Kw8gVqSQqJMDVFqnQAir6gqs7G0HJ7hrK8w==
X-ME-Sender: <xms:cV_uZ889RN7KWfyFq1oDPsAL6aoaSs8LbP5_Oy2Z5njFl9LhUwk5CQ>
    <xme:cV_uZ0tnYLd2V3SAlTCO6MJDKqiM2_loLN8mPmtLRUptxajAAxbewV5XZRQbFsPA4
    vtlvkNhXIUVJHaUjg>
X-ME-Received: <xmr:cV_uZyC1Xev4xX13H-bHV1qD058nTrLqzKSAh9GpCk6zeZ8OtIa2wpj4BBPiIDCL0uojVQbTSsg-H4flauwbkxisxF7b_5hXjJ2JxDmaoVVyXWU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeekfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgu
    rhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkh
    cuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhep
    jedviedvudfhfeefveejheduteetkeegtefhvdelueejtdehgeelkefhhfevueefnecuff
    homhgrihhnpehgihhthhhusgdrihhopdhkvghrnhgvlhdrohhrghenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhihrghm
    thhhrghkkhgrrhdttddusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhutggrshhsvg
    hikhhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:cV_uZ8dKBGZ-TjYhAKCUbGP_g5bFBlnVcQ3IIYv9k1WYsBKM0X959g>
    <xmx:cV_uZxNlugjlJyHVXK9m8lGaxv2ol4K3LZrRKBFmUaCXrQ-hSFlJow>
    <xmx:cV_uZ2m3llZ_4rP_PA_TAfxfMYDpwh6VvfsXuZNheJtfezNFS53q-g>
    <xmx:cV_uZzv_Xdw1hdtfL1hz1pcXVcjpZ-foqWgcxHclUX9s3GcpxGbFVA>
    <xmx:cV_uZ40VdddeyJv0R48YlxAGHFXo0e6KnSLqg7tCTxKjfVHMjTobwRGv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 06:14:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b51ed7c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Apr 2025 10:14:06 +0000 (UTC)
Date: Thu, 3 Apr 2025 12:14:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, shyamthakkar001@gmail.com
Subject: Re: [GSoC] Project Proposal: Machine-Readable Repository Information
 Query Tool
Message-ID: <Z-5famP3CgaSfDc2@pks.im>
References: <7EB151DA-0BDB-4D54-BBB8-CEE69F51F13A@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7EB151DA-0BDB-4D54-BBB8-CEE69F51F13A@gmail.com>

On Wed, Apr 02, 2025 at 03:22:11PM -0300, Lucas Seiki Oshiro wrote:
> ### Activity in the Git community in 2025
> 
> Since when I decided to submit a proposal for GSoC, I sent some patches
> to the Git codebase and git.github.io:
> 
> - My microproject, replacing some `test -f` by `test_path_is_file`:
>   https://lore.kernel.org/git/20250208165731.78804-1-lucasseikioshiro@gmail.com/;
> 
> - Adding a paragraph to the merge-strategies documentation describing how
>   Git merges submodules (based on the blog post that I mentioned
>   before):
>   https://lore.kernel.org/git/20250227014406.20527-1-lucasseikioshiro@gmail.com/;
>   
> - A patchset adding a new `--subject-extra-prefix` flag for `git
>   format-patch`, allowing the user to quickly prepend tags like [GSoC],
>   [Newbie] or [Outreachy] to the beginning of the subject. This patchset
>   was rejected in favor of just using `--subject-prefix='GSoC PATCH'` or
>   similar. It can be seen here:
>   https://lore.kernel.org/git/20250303220029.10716-1-lucasseikioshiro@gmail.com/;
> 
> - Given the feedback on the previous rejected patchset, I opened a Pull
>   Request on git.github.io replacing the occurrences of `[GSoC][PATCH]`
>   by `[GSoC PATCH]`;
>   
> - Adding a new userdiff driver for INI files, initially target for
>   gitconfig files. Currently it is still under revision:
>   https://lore.kernel.org/git/20250331031309.94682-1-lucasseikioshiro@gmail.com/.
> 
> Beyond contributions, I also helped people on the mailing list that
> needed assistance on Git documentation.

Could you please also amend the status (merged to master, merged to
next, under discussion) for each of these items?

> ## Project Proposal
> 
> Based on the information provided in
> https://git.github.io/SoC-2025-Ideas/, the goal of this project is to
> create a new Git command for querying information from a repository and
> returning it as a semi-structured data format as a JSON output.
> 
> In the scope of this project, the JSON output will only include data
> that can currently be retrieved through existing Git commands, for
> example:
> 
> - `git branch`: information about branches, such as the commit that each
>   branch currently references and their upstreams;
> 
> - `git tag`: information about the tags, such as the author or commit
>   date and the messages they hold (in the case of annotated tags);
> 
> - `git remote`: the URL of each remote;
> 
> - `git log`: statistics about the commit history, such of the
>   distribution of commits over time and by author, the distribution of
>   lines changed by each author;
> 
> - `git submodule`: information about the submodules, mainly the commits
>   that they are referencing and their remote URLs;
> 
> - `git rev-parse`: the current branch name, the current commit, the path
>   of the repository top level directory, if the repository is a bare
>   repository or if the repository is under bisection.
> 
> Given that the information that we want to compile are currently
> accessible only through different commands with different sets of flags,
> the user that wants to read them needs to have an advanced knowledge on
> Git. Once having the repository details consolidated in a single
> command, the user will be able to quickly retrieve what it desires
> without navigating a complex combination of commands and flags.

I already noticed in another proposal, but it seems a bit like the idea
is underspecced. The idea isn't to make _all_ information about the
repository accessible. It's rather that we want to give a better home to
information about the underlying repository itself. To clarify further,
I'm talking about information like:

  - Which object hash does the repository use?
  - What is the ref database format?
  - Where is the Git directory?
  - Where is the common directory?
  - What is the top-level directory?

This kind of information is exposed via git-rev-parse(1) already, see
the section "Options for Files". But git-rev-parse(1) is not really a
good match at all given that its main intent is to parse revisions. Over
time though it developed into a kind of grab-bag of different unrelated
functionality that we didn't really have a nice home for elsewhere.

> ### Development plan
> 
> Since this is a new command that is not directly related to any specific
> existent command, it will probably be placed in a new file inside the
> `builtin` directory.
> 
> The functionality of this command can be divided into two categories:
> 
> 1. **Data gathering**: retrieving data from different sources, calling
>    existent functions and reading data structures declared in other
>    files;
> 
> 2. **Data serialization**: formatting the gathered data in a JSON
>    format. This represents two challenges: generating the JSON itself
>    and designing the schema for how the desired data will be presented.
>    
> Since the exported data is already provided by other Git commands, it
> probably won't be difficult to implement this side of the
> functionality. The main task would be inspecting the existing codebase
> and find the functions and data structures that will feed our output.
> 
> Designing the schema, however, requires special planning, as the
> flexibility of semi-structured data like JSON may lead to early
> bad decisions. A solution may emerge by analysing other software that
> export JSON as metadata.
> 
> ### Schedule
> 
> 1. **Now -- May 5th**: Requirements gathering
>    - Inspect codebases that uses Git as data sources; 
>    - Contacting academic researchers on FLOSS;
>    - Contacting industry infrastructure professionals;
> 
> 2. **May 6th -- June 1st**: Community bonding
>    - Getting in touch with the mentors;
>    - Present to the community a first proposal of the JSON schema;
>    - Receive feedback from the community about the schema;
>    - Present a first proposal on the command line interface;
>    - Receive feedback from the community about the command line
>      interface;
> 
> 3. **June 2nd -- July 14th**: First coding round
>    - Write data structures that correspond to the presented JSON schema;
>    - Fill the data structures with data obtained from routines of the
>      existing codebase;
> 
> 4. **July 15th -- August 25th**: Second coding round
>    - Implementing the command line interface option handlers;
>    - Write the JSON serializer.

I generally recommend students to take on smaller batches of work that
can be submitted individually. The way it is structured now means that
you will end up with a single deliverable at the end of your project.
But structuring the project like that introduces a high risk that you
won't be able to land anything until the end of your project in case
there is a bigger discussion around parts of these patches.

Instead, it would make sense to identify smaller batches of work that
are self-contained enough to be submitted upstream. This ensures that
you get early feedback and that you can iterate on your design as early
as possible in the project.

Patrick
