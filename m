Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D6438239F
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 19:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984885; cv=none; b=l+oEfb47SrMNHwJ9IbtTfrHwBbSKFRNaaHuwsMIoDiSpEprIXXF7UH8vF2nxrRz0AqCAFg6uJqBFa9Qyq/8QHTbiVaGizKqmEFwNwWvNsJNi012eUAHnOJIol0OaQhFNgrNIwOIvkUSd1fLlI6OOTpuopBcNCwSb2McCHWnoGEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984885; c=relaxed/simple;
	bh=yvcRa6Msd14abqX+UJk1tQ3C90vqpa6BURTiABjiGM0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aJGPqk8Ck6ilTUgEwlbloOe4lyK6GciYW1w4OofwJFtE70sch7rL06jBus1124vRgKYC5PEaFuVZDD8O7oLAn40qz4YF4R3p1UZoW4LrY5mJVnl2MTCZDjYQxLtb3xQA9peU9+rcDDbU9p7UyWuJj8JjzPO3BLHOw5xruiOs9yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oBBnXiUK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nIttpqvh; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oBBnXiUK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nIttpqvh"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4079F1D000D7;
	Tue, 31 Mar 2026 15:21:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 31 Mar 2026 15:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774984883; x=1775071283; bh=a1DHkko2I1
	wZgj0auxb8qD48qteg12B7OyXLIzadbj0=; b=oBBnXiUKyXasKS/7FK8CxQBvOt
	LUXsfUpvAqCHscgP9ifrGdH5zA2/v85fSAFDXdZdvumbHV444SeWF9+rtgsjTW3O
	ZRH5AzpRL2HSeqrmY1azw058ZbqAI3eEDbrIefG6ejgpYcZOYhYaWgEH+/iPFsoj
	WRjpnr9iOq6SfkRwdrz1HvG/4o/lsbRKSpSc58l0y8ClRD/b7Uo4Nr+/FNrcwW+1
	oLJldiSSJbCePV4ReFfoBW/j3PfospNWsX67SPEA7EmoNkNdOuhIcXj3EWmWw47E
	PupNA+4k0DokHg3pn5OwY1dlinHCXCtGwzguBqyGgqxQAQB7vRBH2RTjkbzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774984883; x=1775071283; bh=a1DHkko2I1wZgj0auxb8qD48qteg12B7OyX
	LIzadbj0=; b=nIttpqvhUI1FjyiLtz1TZDUuyQHG7lljXyMrkf6876wR/UUyKUt
	wXdpP0rzdO2O93m6IRFHzi2eFwIhVZ8GB1UOXAGtGoQJv7WWk7GZcaMIg4+IEGtP
	clfyUBLu5XrxV6vi/7YKteejWG5Rq9a/xvrRejTGOSG9lYbPGK3FcZU+gCSSd84l
	fc8mFTo1pLFDo1fPZHCbEsFiGSMRqZ5dtllKcYczX8arX8OfjgVBH9isABgtABuq
	YABed2Jby8qYFZOl3eHyftBEgYMQ8QFR64/SD4K9mjulW0E13AOcDLXGK7NAQ5dl
	USGSpNb6M+aMyAFO6IROaLW7xfzZAbdr2KA==
X-ME-Sender: <xms:sh7Mab35ToNPsQAPakQlyUJ1EpKB42UZjx7ym-uI2siCMusJ5EMB6Q>
    <xme:sh7MacUnCvx_WoE1oJXoHDB5HOH20IgkRUG3pnlbF1moaXnTrZt43lP_WmvP5_lEQ
    qApCwMrq6GQq_qUK80RGV3g0WVOh2OLzxZEkE8_3v5IThIwfWFNMJs>
X-ME-Received: <xmr:sh7MaeLI7dpzgMueO-hlAiN76NRmBljy3lh4jFGPW_GwuBjjJfQlxzQAwMofV5Z4TKHOjdNIm2dFZF0qMlQZAhPBohO1uljW9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptg
    hhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhs
    sehpkhhsrdhimhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:sh7MaW0CwZT_MTIqq5pEvkDxQaBcy74rheOh0JHV02WfedXAVZVrEQ>
    <xmx:sh7Mac7KjMhEki5KefhbBR3CfY7rYTime8BQqmPHyiwvDsEYiQC64A>
    <xmx:sh7MaX_NXM52B9V9K7KL6FcuiREIq20rtXH2cT7C3TSviswKdj0law>
    <xmx:sh7MabX0EUW4CL4qfzincpdDPllEHqFTQwx4apZfL4ot1WZ1J-nNHg>
    <xmx:sx7MaR9mMXp5XxJeiImgLQsQjxpAppMaFEPFjbmLZ1QxVYVna-sryT59>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 15:21:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com,
  christian.couder@gmail.com,  ps@pks.im,  toon@iotcl.com
Subject: Re: [PATCH v3 1/1] cat-file: add mailmap subcommand to --batch-command
In-Reply-To: <20260331121111.9614-2-siddharthasthana31@gmail.com> (Siddharth
	Asthana's message of "Tue, 31 Mar 2026 17:41:11 +0530")
References: <20260329082808.12609-1-siddharthasthana31@gmail.com>
	<20260331121111.9614-1-siddharthasthana31@gmail.com>
	<20260331121111.9614-2-siddharthasthana31@gmail.com>
Date: Tue, 31 Mar 2026 12:21:20 -0700
Message-ID: <xmqqo6k3ztxr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> git-cat-file(1)'s --batch-command works with the --use-mailmap option,
> but this option needs to be set when the process is created. This means
> we cannot change this option mid-operation.
>
> At GitLab, Gitaly keeps interacting with a long-lived git-cat-file
> process and it would be useful if --batch-command supported toggling
> mailmap dynamically on an existing process.
>
> Add a `mailmap` subcommand to --batch-command that takes a boolean
> argument. The command now uses `git_parse_maybe_bool()` and supports all
> standard Git boolean values. Mailmap data is loaded lazily and kept in

I do not think you want to say "now uses `git_parse_maybe_bool()`".
Nobody is interested in the difference relative to what you did in
the previous iteration.

    ... that takes a boolean argument (usual ways you can specify a
    boolean value like 'yes', 'true', etc., are supported).

> +static void load_mailmap(void)
> +{
> +	if (mailmap.strdup_strings)
> +		return;
> +
> +	read_mailmap(the_repository, &mailmap);
> +}

This, especially the early return condition, may deserve a bit of
in-code comment, as "a used string_list has the .strdup_strings bit
set" is not a generally applicable rule.

    /*
     * The mailmap is initialized with .strdup_strings set to 0,
     * but read_mailmap() sets the bit to 1 (this is true even when
     * not a single mailmap entry is read), so it can be used for
     * lazy loading.
     */

or something, perhaps?

> @@ -692,6 +700,21 @@ static void parse_cmd_info(struct batch_options *opt,
>  	batch_one_object(line, output, opt, data);
>  }
>  
> +static void parse_cmd_mailmap(struct batch_options *opt UNUSED,
> +			      const char *line,
> +			      struct strbuf *output UNUSED,
> +			      struct expand_data *data UNUSED)
> +{
> +	int value = git_parse_maybe_bool(line);

As "line" is never NULL, one standard way to spell a boolean True is
not available to the callers, namely, "mailmap<EOL>" (like how a
configuration file entry "[core] bare" means "[core] bare = true"),
but that is probably OK. "mailmap<SP><EOL>" may be interpreted as
feeding an empty string as an argument, which is "false" to the
git_parse_maybe_bool() function.  That might be surprising.

Nothing actionable in the above comment (other than perhaps as a
hint for documentation update).

> +	if (value < 0)
> +		die(_("mailmap: invalid boolean '%s'"), line);
> +
> +	if (value > 0)
> +		load_mailmap();
> +	use_mailmap = value;
> +}

Hmph, why not use use_mailmap from the beginning of the function
without introducing the local variable "value"?  Nothing in
load_mailmap() pays attention to the current value of use_mailmap
so I do not see much point in preserving the current status until
the last minute.

Thanks.
