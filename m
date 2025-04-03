Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ADC18CC08
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743675804; cv=none; b=VH1uDP9CX96SIzv5wdk66v2u3Oj4/JouVUaxbq4FeMgwLdgsx2CStXLUCbD8MzrB9DYEJkP5gRjK4COXwxq2GLsVpEdKFfQfkQBKr65gO+wjtn5fz3TqAWbG5FthyMHQQdXzghXZkeCl77HcprPxnVgTcxZ8L1XP46oJXn2Ghkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743675804; c=relaxed/simple;
	bh=fEXc6wiTaVFz08F8m5MvD5LePkbLtY2PXfqFAZtvEbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2fD26uXlPIU0SCqChtsfpKyQDE+jmmZT0e+2SYbeTpYW3ClWPPRF3wAohh+V+adSv1/12iToEjIoUCVIIi7Vb14xW6+XK0qrcM4tN00Xc6QybmzE6TIqCcG9G+Ok2pChoBHk38tb6/Ft9bID5kRvPPsvhKrpYPGDgVAWAyqJbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rdEcaepm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f/xm2ujd; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rdEcaepm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f/xm2ujd"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 664B1114014F;
	Thu,  3 Apr 2025 06:23:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 03 Apr 2025 06:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743675800;
	 x=1743762200; bh=iEXdxfJx8os5CaCEMVxiXZpZ58c7M94kRoSuzYtS7f4=; b=
	rdEcaepmbJbiyZc+gIpV77WWGR25rs8m7XBNw4h0NycVzjAxU1M4975+SV7JSCGr
	SdeKlb2jFCMFNhackTDAUOU6vr53RKLXP4UACt3dekrt8IhsxUpLFEP9zWPGlzDa
	Hz2MDPuLMeMow/XjFFOigiZ0bvF//IyFTJmAV4UgwvCUIii9jZ+AuLALgbZyrU1L
	QjntgIkVFQ/NtA32lbcZK5CVD6LZgsM3dlxaE7yl+raC0hYr6Rs7HyGQ4pzLLTms
	7St4BbsweT604VNcu+8FQ30+1ENLU5VIwfo9KImQHhGmQKHpASuXGhNO2Klrj0x+
	HJKQ7PhL/GHMHxGe9PxZqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743675800; x=
	1743762200; bh=iEXdxfJx8os5CaCEMVxiXZpZ58c7M94kRoSuzYtS7f4=; b=f
	/xm2ujdozVGHhpZf85wtIYRPVFMD2QxDFgiWwCewSpfJ41UZSHMWpnClXOxUMR86
	YHLHZpRNfKAi1EyafhnNN9b8JIBfzZDT3e3a2Gk8nlbgInphm4ZHRQ/TJiPv3cW8
	QKFEskdENaOcoPplyMoniEzLEEBlU7nh1eFKudGG+ierjqsSCz22n14E3wYzlIoK
	UTmR6RkF0Qe+SdGBS/rIzpJflI6iHzVifwwXSYJI2Bpyw0Ke7P3ieY6XCCPSOt/H
	KUIbfMsNLYHuVRFT9usocWPILAp6hD3sLI8THywczNDA0tex8UtYJIzJ8e+y1fqK
	7UGfuEoubSVm6Sm0gB0fg==
X-ME-Sender: <xms:mGHuZ0l3I3p_zDsXy7du88BJnwEPpad-E94wwRcqeQhPRo1zXoDjFw>
    <xme:mGHuZz18h2vb2TOenVanojSAfRg_8PrzxVsC4h_VkaGbpw6eONHCQTAnGCFsivt4D
    DHo7c7zEinhwuoKLg>
X-ME-Received: <xmr:mGHuZyoM6-eGVATkp0VAmPPFqQ-rxcNRJyHhHeKKZhR-TcR8ZBRUMD23eGvilQVuEhWS0XmGHW9fpwB8q4GF2RNOPw53RuSx_9qfiJmYXw_2pMo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeekfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgu
    rhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitg
    hkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhn
    pefglefhvddvveelhfekvdeigfevgfeiteetvddviefhvddtvddvgeduleeugeffvdenuc
    ffohhmrghinhepghhithhhuhgsrdhiohdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrhigr
    thhhvggvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtth
    hopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhihrghmthhhrghkkhgrrh
    dttddusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:mGHuZwlWndODSYJUVvtG1cfpwGm5WpAsMYplhMFa5CGhfWhWuAneyw>
    <xmx:mGHuZy182c-7zAE-GeQ20JFCPpr3r93SAju-466syoEBE7nMfIm58A>
    <xmx:mGHuZ3vpjOUicpRa1NQ6UxdAnjvJlJH6Cqdx0TBssfpUuP-bD-7_UA>
    <xmx:mGHuZ-V8xbD3VsvjReFihUngf4_BN0QCackqmYvSFchSGs94EN9qgg>
    <xmx:mGHuZzdNE_BnACPiTKPx8erau7hkwiRH3fKUzAV7Iv2kfxmdYeFaaszS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 06:23:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9793e38c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Apr 2025 10:23:17 +0000 (UTC)
Date: Thu, 3 Apr 2025 12:23:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: Re: [GSOC] [Proposal v1] Machine-Readable Repository Information
 Query Tool
Message-ID: <Z-5hlL1Gk0oi4fX2@pks.im>
References: <CA+rGoLfxZHdns=7FwQuYS=JANrR9zDP-dOpV2AxM1hC1Lc9wiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+rGoLfxZHdns=7FwQuYS=JANrR9zDP-dOpV2AxM1hC1Lc9wiw@mail.gmail.com>

On Mon, Mar 31, 2025 at 08:21:27PM +0530, JAYATHEERTH K wrote:
> ## **Synopsis**
> This project aims to develop a dedicated Git command that interfaces
> with Git’s internal APIs to produce structured JSON output,
> particularly for repository metadata. By offering a clean,
> machine-readable format, this tool will improve automation, scripting,
> and integration with other developer tools.
> 
> ## **Benefits to the Community**
> ### **1. Simplifies Automation and Scripting**
> - Many Git commands output **human-readable text**, making automation
> **error-prone** and **dependent on fragile parsing**.
> - This project introduces **structured JSON output**, allowing scripts
> and tools to consume repository metadata **directly and reliably**.
> - No more **awkward text parsing**, `grep` hacks, or brittle `awk/sed`
> pipelines—just **clean, structured data**.
> 
> ### **2. Eliminates the Overuse of `git rev-parse`**
> - `git rev-parse` is widely misused for extracting metadata, despite
> being intended primarily for **parsing revisions**.
> - Developers often **repurpose** it because there’s **no dedicated
> alternative** for metadata queries.
> - This project **corrects that gap** by introducing a **purpose-built
> command** that is **cleaner, more intuitive, and extensible**.
> 
> ### **3. Optimizes CI/CD Pipelines**
> - CI/CD systems currently need **multiple Git commands** and
> associated parsing logic to fetch basic metadata:
> 
> ```bash
> # Example: Gathering just a few common pieces of info
> BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "DETACHED")
> COMMIT=$(git rev-parse HEAD)
> REMOTE_URL=$(git remote get-url origin 2>/dev/null || echo "no-origin")
> # ... often requiring more commands and error handling logic.
> ```
> - The proposed command aims to **replace these multiple calls** with a
> **single, efficient query** returning comprehensive, structured JSON
> data.
> - This **simplifies pipeline scripts**, reduces process overhead, and
> makes CI/CD configurations **cleaner and more robust**.

I already saw this in another proposal, which indicates that the project
idea might be a bit underspecced. In any case, the goal of the project
isn't to write a single tool that is able to surface _all_ information
for a Git repository. It's rather that we want to surface low-level
information around the repository itself.

The basic intent is to give the options listed in git-rev-list(1) under
the section "Options for Files" a better home. We have a bunch of
command line options there that allow us to parse environment variables,
paths, repository formats and other low-level stuff. But these aren't
really a good fit for git-rev-parse(1) itself because that tool was
intended to be about parsing revisions. So this is one of those
organically grown commands that has started to accumulate all kinds of
unrelated options that didn't have a better home elswhere.

So the scope of the project is somewhat more limited compared to what
you propose here. As that impacts a lot of the implementation details as
well as the project timeline I'm not going to comment on these now.

> ## Detailed Project Timeline
> 
> 
> **Phase 0: Pre-Acceptance Preparation (April 9 - May 7, 2025)**
> 
> * **Focus:** Demonstrate continued interest and deepen understanding
> while awaiting results.
> * **Official GSoC Milestone:** April 8, 2025 - Proposal Deadline.
> * **Activities:**
> * **(April 9 - April 21):** Deep dive into Git's source code
> structure, focusing specifically on areas identified in the proposal's
> Technical Details:
> * `builtin/` directory structure and command handling.
> * `repository.h`, `refs.h`, `remote.h`, `config.c`, `strbuf.h`.
> * How existing commands like `git status`, `git branch`, `git
> rev-parse`, `git remote -v` access underlying data.
> * **(April 22 - May 7):**
> * Monitor the Git mailing list for discussions related to repository
> information, command output formats, or JSON usage.
> * Refine understanding of Git's testing framework as I've not done a
> deep dive into tests(`t/test-lib.sh`). Try running and understanding
> existing tests relevant to refs, remotes, or configuration.
> * Review Git's contribution guidelines (`SubmittingPatches`, coding
> style) again since most of my microproject time was related to
> documentation.
> * Try to start some more microprojects or actively converse in other patches.

Note that microprojects are supposed to be finished before submitting
your proposal. They are used for us mentors to figure out whether
candidates would be a good fit or not. So ideally, you would prominently
link to one or more of your finished microprojects in the proposal
itself already.

> **Phase 4: Documentation, Polish & Stretch Goals (Coding Weeks 9-12:
> July 22 - Aug 18, 2025 Approx.)**
> 
> * **Focus:** Finalize documentation, implement error handling, address
> feedback, attempt stretch goals if feasible.
> * **Activities:**
> * **(Week 9: July 22 - July 28):** Complete the first draft of the man
> page, detailing usage, JSON schema, and options. Implement the
> `--json-errors` functionality for structured error reporting. Add
> tests for error cases.
> * **(Week 10: July 29 - Aug 4):** *Begin Stretch Goals (Conditional):*
> If core work is stable and time permits, start implementing
> `--head-only` / `--remotes-only` flags or the basic `is_dirty` check.
> Add tests for any implemented stretch goals.
> * **(Week 11: Aug 5 - Aug 11):** Thorough code cleanup, address all
> outstanding review comments on submitted patches. Ensure documentation
> is comprehensive and accurate. Final pass on test suite coverage.
> * **(Week 12: Aug 12 - Aug 18):** Prepare and submit final patches
> incorporating documentation, error handling, and any completed stretch
> goals. Final code freeze for GSoC evaluation purposes. Write blog post
> update summarizing final phase.

One thing that I also mentioned to others: instead of planning for one
big batch of load, I would strongly recommend to plan your work in
smaller batches. You should ideally have multiple self-contained batches
of work that you can submit as early as possible while still bringing
some value to the project. This ensures that you can get feedback from
the bigger community early on.

> ## Past Communication and Microproject
> * **Blog**: [Blog](https://jayatheerthkulkarni.github.io/gsoc_blog/index.html)
> This blog contains a detailed communication description and blog of my
> microproject experience.
> * First Introduction to the Git Mailing list: [first
> Mail](https://lore.kernel.org/git/CA+rGoLc69R8qgbkYQiKoc2uweDwD10mxZXYFSY8xFs5eKSRVkA@mail.gmail.com/t/#u)
> * First patch to the git mailing list: [First
> Patch](https://lore.kernel.org/git/20250312081534.75536-1-jayatheerthkulkarni2005@gmail.com/t/#u)
> * Most recent series of patches and back and forth with feedbacks:
> [Main mail thread](https://lore.kernel.org/git/xmqqa59evffd.fsf@gitster.g/T/#t)
> 
> I've been maintaing the blog and will maintain the blogs of all the
> communication of mine to the git mailing list.

ah, you do have a microproject. As this is part of the prerequisites I
would like to propose to have this more prominently visible.

Thanks!

Patrick
