Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6442033E37A
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 02:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774836738; cv=none; b=JQghTWmQBpL+MDIC76/kiFsPgNNIOhlps5hfXxkCVEKmmGi3cvrxEvorXkNS6DwX95h4UDCVNwxrjVxKaAFM/EWz+xmovT1ClylqI/y1gvu+E9HBr0Hqf2ahxd/WH2+JyuHbououBXEGBXSOY4Fr2h34159r4FfRt6sqo3HHz7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774836738; c=relaxed/simple;
	bh=MXUc5DgeoUvN3eLcKcsZbSlhdD7Oe+Vz2PLzy+KrcBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rGnZ8ehgCXqoJUZHZT2xYWcJ5OaN/I2XS4IC36PMiCa4GqsGhvUqYXfBxhftRUHKMqCPIGTz92dYbTViIybHSX4HlBbiRxh/QrMy4F2uabGSgqFob0bU0tX5u+NzrGocPWVq+tnTYQbhe+ydfrYlGv5H2w1qkfy7wQ2G6IZL0Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hMhE6WWk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QgcqcLeH; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hMhE6WWk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QgcqcLeH"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 510397A01C6;
	Sun, 29 Mar 2026 22:12:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sun, 29 Mar 2026 22:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774836731; x=1774923131; bh=XLK/TFDyUQ
	irhg6uPunVyqsgndoPqyfiGcWX7vYiDS4=; b=hMhE6WWkYiBp7tfMc5oZMw6GCB
	ffzt+xFnsDAY2jftLQpAmc28FoYojdGOcs9mTePCTG+PYNBLeS8odaJztGVB8f5x
	LVVkwCqKAMqFfheUzhpSxYQKCAZXE4iYXhtA3R5PRKg0LUx8h5VwOZM1ZIvzyVpu
	Gs+u2U3F01uUO3Xz0bZVre/nwYAbSRdVLjX/xMRKufWDxgkCY6XuvYPnHeL1vRRV
	6NzJg6SxcrZy6UN1yAv31WxscIJs73AKya7wkTcuU60Zsr/VkWAKuyEOYNEQveDh
	K346rtStzU1qpzkkeSeHeReOXHr+eYlGzsxq0GOLV1Nm5zutV64J65jE+dOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774836731; x=1774923131; bh=XLK/TFDyUQirhg6uPunVyqsgndoPqyfiGcW
	X7vYiDS4=; b=QgcqcLeHgr3Vc8dfT2fQ2jeGZJJCakkdGvD0FWDABmGg9VkxzOB
	3aSRyd/vBBUAXSckUmg3XbMhblU7sqrWFk51PZmWu70CBqD4MaDffKmfLYyMIJqy
	NjkRz/pDmuZXOBrvCotvWVCTm0NYVwya5bqK/Aqq2l2H76qTgBCY6TadbZFNXarK
	qgx7DjrDPInFS/X2fBhjm43nSj3uIIPuynFObNRCV645BPXfk0e071DU+kMXzfZG
	LLlRGomlaPzTByrYooItjE3+d+58t3erogywNUO2e929VkHKCFEZRAm3EXBLDMwN
	aKd9xipJOkC/g7bpaE4vLNgW8X1cUPPpuPw==
X-ME-Sender: <xms:-tvJaWOmYra_wQ9EW2yQl_9umbwrUsPQ7pGZ2Hj1AycKJW3ec1RL5g>
    <xme:-tvJaXPOj4Ul370Z13XXmYtsq8AAyEZXdeO20w2-ivAxFISjk8oFHG4YX_Rx4vAma
    NWAj2p6umUUprRKE1sGDrZeAJRhq_ofsZa5eZyYH1cNJchYu4q0Eg>
X-ME-Received: <xmr:-tvJafgU_gjalWAHRKnRDhU44GOPxJcmD_ZQD93gQpso1pwbircZubjGrZYBRk0M76da6z2olN01THoA5XhDXjKKQtWs9VUWOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeejjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-tvJacsrVQ7tyrdfVyxmS7Xu3cSiqJej11ORoREMN_ceACNmsqU7Yw>
    <xmx:-tvJadTbdFAM5Sgvfe7SazAyFbWWWcQuzHWAMskSYAzCkpH5PZqxPA>
    <xmx:-tvJaQ1x_xBYXyR-xlLrXsjxSzusrDpIPAlxt5mXNKMZOytxZlzcYA>
    <xmx:-tvJaSssK66Yg126oOaYYA3nZ3Z1R_nNA1lCqkG4hA32MYAYNMXJjg>
    <xmx:-9vJac1ZrneQ67JzQ7-TM02UctXGDDvD8H4fHYIKQ82rNSL1_q8qRgYF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Mar 2026 22:12:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com,
  christian.couder@gmail.com,  ps@pks.im,  toon@iotcl.com
Subject: Re: [PATCH v2 1/1] cat-file: add mailmap subcommand to --batch-command
In-Reply-To: <20260329082808.12609-2-siddharthasthana31@gmail.com> (Siddharth
	Asthana's message of "Sun, 29 Mar 2026 13:58:08 +0530")
References: <20260328203615.60402-1-siddharthasthana31@gmail.com>
	<20260329082808.12609-1-siddharthasthana31@gmail.com>
	<20260329082808.12609-2-siddharthasthana31@gmail.com>
Date: Sun, 29 Mar 2026 19:12:08 -0700
Message-ID: <xmqqtstyf4lj.fsf@gitster.g>
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
> At GitLab, Gitaly caches git-cat-file processes and it would be useful

Would "keeps interacting with a single 'cat-file' process" be more
accurate than "caches"?  The latter gives, at least to me,
connotations that may not be necessarily true, like (1) there is a
pool of cat-file processes waiting for Gitaly to connect and serve,
(2) a running Gitaly may decide to disconnect from cat-file from
time to time, and then reconnect to one of them when it becomes
necessary again, etc.

> if --batch-command supported toggling mailmap dynamically with existing
> processes.
>
> Add a `mailmap` subcommand to --batch-command that takes a single
> argument: `yes` to enable mailmap and `no` to disable it. When enabled,
> mailmap data is loaded from disk on first use and kept in memory so that
> toggling back on does not require reloading.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>

This is over-crediting me.  The idea to unify the two commands into
one may have come from me, but that is at most helped-by but it is
perfectly fine without any credit.

> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> ---

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index b6f12f41d6..a53926d2bb 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -54,6 +54,7 @@ static const char *force_path;
>  
>  static struct string_list mailmap = STRING_LIST_INIT_NODUP;
>  static int use_mailmap;
> +static int mailmap_loaded;

Not part of this topic, but in case less experienced developers who
are watching from the sidelines wonder if we want to add this
file-scope global variable, this is perfectly fine.  Anything under
builtin/foo.c are meant to serve a single command "git foo" and does
not benefit from "let's sift globals into classes that belong to
different concepts in the system; most of which will be per
repository, so make them some part of the repository object"
movement as much as more library-ish parts of the system.

Until a specific command starts working on multiple repositories at
one time, that is.


> @@ -692,6 +693,24 @@ static void parse_cmd_info(struct batch_options *opt,
>  	batch_one_object(line, output, opt, data);
>  }
>  
> +static void parse_cmd_mailmap(struct batch_options *opt UNUSED,
> +			      const char *line,
> +			      struct strbuf *output UNUSED,
> +			      struct expand_data *data UNUSED)
> +{
> +	if (!strcmp(line, "yes")) {
> +		if (!mailmap_loaded) {
> +			read_mailmap(the_repository, &mailmap);
> +			mailmap_loaded = 1;
> +		}
> +		use_mailmap = 1;
> +	} else if (!strcmp(line, "no")) {
> +		use_mailmap = 0;
> +	} else {
> +		die(_("mailmap: unknown argument '%s', expected 'yes' or 'no'"), line);
> +	}
> +}

OK.

> @@ -725,9 +744,10 @@ static const struct parse_cmd {
>  	parse_cmd_fn_t fn;
>  	unsigned takes_args;
>  } commands[] = {
> -	{ "contents", parse_cmd_contents, 1},
> -	{ "info", parse_cmd_info, 1},
> -	{ "flush", NULL, 0},
> +	{ "contents", parse_cmd_contents, 1 },
> +	{ "info", parse_cmd_info, 1 },
> +	{ "flush", NULL, 0 },
> +	{ "mailmap", parse_cmd_mailmap, 1 },
>  };

Mixing style fixes to existing entries in the same patch that adds a
new feature by adding a new entry to the table is annoying than
having a preliminary clean-up patch that only fixes style and then
the main patch that adds the feature.

>  static void batch_objects_command(struct batch_options *opt,
> @@ -1127,8 +1147,10 @@ int cmd_cat_file(int argc,
>  	opt_cw = (opt == 'c' || opt == 'w');
>  	opt_epts = (opt == 'e' || opt == 'p' || opt == 't' || opt == 's');
>  
> -	if (use_mailmap)
> +	if (use_mailmap) {
>  		read_mailmap(the_repository, &mailmap);
> +		mailmap_loaded = 1;
> +	}

Hmph, interesting.  Two points.

 * It would make it easier to follow if these two lines are made
   into a small helper function to be called from here and from the
   "parse_cmd_mailmap()"?

 * Can we somehow make mailmap object itself slightly smarter so
   that it knows if it has already been asked to read the data from
   its sources?  It is a pretty dumb string_list, but from a cursory
   read of the code flow, it seems that mailmap.strdup_strings is
   initialized to be false in builtin/cat-file.c and then one of the
   first things done in mailmap.c::read_mailmap() is to flip that
   bit on, so the "yes" part of the parse_cmd_mailmap() might become

	if (yes)
		load_mailmap();

   with the helper load_mailmap() that may look like:

	static void load_mailmap(void)
	{
		if (mailmap.strdup_strings)
			return; /* we know read_mailmap() flips it on */
		read_mailmap(the_repository, &mailmap);
	}

   The first bullet point to introduce a small common helper will
   help hiding such an ugly implementation detail there.
