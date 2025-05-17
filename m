Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075121DE3A8
	for <git@vger.kernel.org>; Sat, 17 May 2025 13:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747489184; cv=none; b=hcrBO3iu3p8G5F342pCjknArg3rxAI75oWnTCysy5GXgLJN4RD0EUtljZ/J70ymBI5iOkqufpUxN7uKrLBXtZj0QbSzLHcATRrzZaGIeujY7N01xgdHPa0ZCiaWK4Cd0RUCv6qeMqk1z9qW9k04kTVUUX/g6hOK/kwFNkgyacNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747489184; c=relaxed/simple;
	bh=3XakZub39tCjKsICFtP07ttXttFE2/+6ix8A+if+qtE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sVCJhnzZIAT54fnnaRrA2bB79XXrS5/kCR7h4DfpwACX7Z0tNkWy84It5EnXuhrvuPGYJN2AlA52+zZoXQvhuCWUtAxKjbPtxnBp0nU5epzI7gg/lq9g5N8QSsfMpauMPh4TVOxI5FglICEUAovcDWpjB0pvkrPGkIbwiL6qiGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HmUc4/Mq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iGp4+xA6; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HmUc4/Mq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iGp4+xA6"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id CFBA41140175;
	Sat, 17 May 2025 09:39:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 17 May 2025 09:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747489180; x=1747575580; bh=ci7/C+WpBm
	cqfLjQoOzjETk1621v3KvT8BLL9d7zJIg=; b=HmUc4/MqvAo9yYdMhXVcjblda/
	2DSe8dz4OeLHA5Wp8Dbf1HniibUM3snLu0ZYORwwfGHgDqxkcWUP9VjwwA6hcVVQ
	Sb5gJ0XJzMisOEoQJ8ZWpwcF+fGwF162G5AJJUVnP5xe6XgMvffIiITB1sZigGE3
	0ubaPlnuYIyPBLsrVS46VV/OPRJg3qn9P1M3NQ7URBKXgpeDMPR3mu8WFer3Gx3w
	/KqW8+bdEJ4Zhm3s9hJAUOHTln7LY8o+xoTo1Z7o2aiXNinUhvEJvb4KgboVFLw1
	IiSchPvAtubXgGC2qBDg6sTwPQeem62RBT10cTYg2RyGsspkTPh8tIIH9LaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747489180; x=1747575580; bh=ci7/C+WpBmcqfLjQoOzjETk1621v3KvT8BL
	L9d7zJIg=; b=iGp4+xA6ZoKTUygEG2Jg76PC8oqBnCz8zwxriX+Q7IMP2QChZqh
	yd+0T8+DoJEDgEzm+7ulyVjLQBOzPefMSfMJqTUhJ7gjUL7crGFRO/HOVPD35Ydc
	YzqKo0LbPOcVIMn1F2euaqzWFglQKOrcH0sm+FxGKSrVoy+46OQAZTAc/quJC4qM
	/+CEljhosYVNxjTguLW8HQ+HYNCjkfkiJUapxhC3aDAgedZV5XSi9JVJdakXyh0n
	NsElLQplp7LcGMOqaTQUhbEHwuc21qayw/PzdJBDEkBWV8NE2vcc5WekMGHjAm4y
	Hq2G6Ewx+nsnCzKJE0LbbUwBzQlbEMofJBQ==
X-ME-Sender: <xms:nJEoaFgWnnbtIbPjwDxn-ypO0Q8gEgk1lAEcDE1cxunY26FhnI_c5g>
    <xme:nJEoaKCveLp5ia9SxcYN5D_SDUnfG0lflosq5WRTrJPMrJ2HqNoSa9emVo4h2ibEL
    nWNWXrbZhoTwUO6xg>
X-ME-Received: <xmr:nJEoaFHfDHIBKDaX0aiymHvQe3o3C8exsZKqWxfRzRWJJnGV-XZNCTF4YCZBzCZ5_hC-LXvvNhcjwWup0gcsl4nw5jBS8pO6qAsPTk4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudehjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrhigrthhhvg
    gvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehn
    rghsrghmuhhffhhinhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:nJEoaKRHrYGzt3u5HTRChoaOG_-XM3ccgHrfIYaOM-kROiWoZyHW3w>
    <xmx:nJEoaCydmGSMPeYuVlSnClvGNTCmmQVlqrhiOjqVylBAM5w1MQ_opQ>
    <xmx:nJEoaA4Qp39hDjUsguOdRNWFW-pfA798qnCJeqX_j7vSznl33XRK0A>
    <xmx:nJEoaHz7E9a90DC5G77tYWblGUO02mDe9JoE5bS8drp03v4HOrkPeQ>
    <xmx:nJEoaGHCl8kCwWQD6OFoSI2fhHnRXdvwRIAeP2759UJU5BNt9Z4GAkoQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 May 2025 09:39:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: nasamuffin@google.com,  git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] docs: clarify cmd_psuh signature and explain
 UNUSED macro
In-Reply-To: <20250516185516.52311-2-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Sat, 17 May 2025 00:25:15 +0530")
References: <aCeAIqwvEVOdrsMg@google.com>
	<20250516185516.52311-1-jayatheerthkulkarni2005@gmail.com>
	<20250516185516.52311-2-jayatheerthkulkarni2005@gmail.com>
Date: Sat, 17 May 2025 06:39:38 -0700
Message-ID: <xmqq34d3s6ed.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> The documentation previously omitted the UNUSED macro,
> which often led to confusion for new contributors
> when they encountered compiler warnings related to unused parameters.

The above is not quite easy to reason about.  It is more like we
wrote this document, and then later tightened the default compiler
warnings for developer builds.  So "omitted" may technically be
correct, but it was more like "did not use it, because there was no
need".

    The sample program, as written, would not build for at least two
    reasons:

    - Since this document was first written, the calling convention
      to subcommand implementation has changed, and now cmd_psuh()
      needs to accept the third parameter, repository.

    - These days, compiler warning options for developers include
      one that detects and complains about unused parameters, so
      ones that are deliberately unused have to be marked as such.

After such observation on the status quo and description of the
problem you are going to solve, you give an order to the code base
to fix it, perhaps like:

    Update the old-style examples to adjust to the current
    practices, with explanations as needed.


To recap, the usual way to compose a log message of this project is
to

 - Give an observation on how the current system works in the
   present tense (so no need to say "Currently X is Y", or
   "Previously X was Y" to describe the state before your change;
   just "X is Y" is enough), and discuss what you perceive as a
   problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to the codebase to "become like so".

in this order.

>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  Documentation/MyFirstContribution.adoc | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index ef190d8748..f4320d8869 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -142,7 +142,15 @@ command in `builtin/psuh.c`. Create that file, and within it, write the entry
>  point for your command in a function matching the style and signature:
>  
>  ----
> -int cmd_psuh(int argc, const char **argv, const char *prefix)
> +int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo)
> +----
> +
> +We will use the UNUSED macro to make sure we don't recieve compiler warnings
> +for unused arguments from the function cmd_psuh.
> +----
> +int cmd_psuh(int argc UNUSED, const char **argv UNUSED,
> +	    const char *prefix UNUSED, struct repository *repo UNUSED)
>  ----

I do not quite understand.  Why do we need a new one here?  Wouldn't
it be easier to read for a newcomer if you just give the last one
and explain what UNUSED are for?  Perhaps like

    ... matching the style and signature:

    ----
    int cmd_psuh(int argc UNUSED, const char **argv UNUSED,
	         const char *prefix UNUSED, struct repository *repo UNUSED)
    ----

    A few things to note:

    * A subcommand implementation takes its command line arguments
      in `int argc` + `const char **argv`, like `main()` would

    * It also takes two extra parameters, `prefix` and `repo`.  What
      they mean will not be discussed until much later.

    * Because this first example will not use any of the parameters,
      your compiler will give warnings on unused parameters.  As the
      list of these four parameters is mandated by the API to add
      new built-in commands, you cannot omit them.  Instead, you add
      `UNUSED` to each of them to tell the compiler that you _know_
      you are not (yet) using it.

Take a special note on the last one.  There may be multiple ways to
squelch warnings, but it is worth telling your readers that use of
UNUSED is the right way.

I'll stop here for this patch.

Thanks.
