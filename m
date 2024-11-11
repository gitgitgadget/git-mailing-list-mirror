Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F7116F8E5
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731316504; cv=none; b=g3v+Dok8gSjdYq3bWSW1kXaAO4umbYNWPVYfGdfsEqfwQbKD7kx47YtYckOxz28oqb5NxAlN+ghxdYuhhpghTNE7BisMWUxYwjpwL+Z+1NpkI0tygnYUD3uXXtXHbe79VZ7sHNe1D51hzRImHVtRLrLZvMel+qCC9TbPlMHejL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731316504; c=relaxed/simple;
	bh=USYRL8t2YyNDh2vLBI1UA0lJ99jGmmr1bo2w9o93PQ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UzZBzpFJbmtHZmC3nhpdkgozLbhz7GeMF2QKFsJVnWNxKXuiRiFct+LKYxioTl27cxkzn1ReSFHLp4lnYaqjVx1y96HGKv3abq0sbK2i8VnUs1LxYZAluMO02OR2ENSDgpl0DC8FRgjQiKrkyUAv2GbOjhLjlGGKWLQz4rS32Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LAUqjwVF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HQMpJxtn; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LAUqjwVF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HQMpJxtn"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 7611213805F2;
	Mon, 11 Nov 2024 04:15:01 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 11 Nov 2024 04:15:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731316501; x=1731402901; bh=CIPqI8Rx1X
	QqWjV3+rlJ+eLCP0UsKEFtefbV73UWExU=; b=LAUqjwVFbITnTD8imrQscr9lYe
	UDEA6MruH6Qi0n+Kgrs5vX1dK8BQpazZCvQcxOyiRUuB7AuPnx1CbbfnyjfmC1fP
	7BsAKQWRHPY6dhL1Zco2YvGlx0QJC/Tv4DnqOpxbmWRPsf4yUwF2FDWLiwN/mVaA
	sr1bU33UX27KYshBvJNBR8mMt3qbwLBUhUSVMXkqiwEyy7tC4Z3R/3ZR8jVeOX54
	dNBvCiNWDRVENA1tPJiA3cvNlVYP32puCE5op+v/f4Deev8jArQEiRQBfQCL1VRu
	IjEa5/U/O2lIx+MAtnwLMKz+9cYtGmxfXqEIMvigVU5PHE57bK/WlZrWb+3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731316501; x=1731402901; bh=CIPqI8Rx1XQqWjV3+rlJ+eLCP0UsKEFtefb
	V73UWExU=; b=HQMpJxtnNsNY4YzhJsbD5beDPF3c5Xs3TID7xrWifhF9bw/imy2
	DK8Bb8VYFoVrpOxvPfH4axjbOGZLlDJPPJ71vT61kouOScXtQ5StNTF5DXBMWScj
	4j1/2mavtgDMkzw372N3L1hC9BvquIo+CzXQyatI4+4oz/NpD6344xd1VVzZILBd
	UO01dJGNE5jyzRnZtXrcYqXSUNOxrjn5b+sjWfpOx6GNFcAEoLkXmTG4HBLulCge
	92NVIIzI0PN4+sHG/+D5F3Kp5voPAri0xKLR7y7JbqzUavGnpUegZ+IIuiY/ImlM
	KEuDVCzxrER36X8YMA1cyKhg2rRHo8PvZNg==
X-ME-Sender: <xms:FcsxZ3yV_pU9NgZzwseNLpzXorZYsyp68sWBOqo6eBGYblxFNmR-_g>
    <xme:FcsxZ_Qp-TVlYWKcKNbvGpwekTuXvS5ocbMLCDvYm9V9w4kLo282ghQVc7-3mQhLp
    z6SvBbeTV46Ufj8NA>
X-ME-Received: <xmr:FcsxZxVtGBPo8ThtG3SpJNpe_m8XHyeLQhfhRDoyTXe1CYPIy8khmPdeijX8K2OhyP09CMH_Yt34Sbj6I-svJqmN6U1m2nODkkc_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghlvhhinhifrghnse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshhtvggrmhguohhnsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopegvmhhrrghsshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhtoh
    hlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:FcsxZxi8ph0GGtwnnbZ7IY-K-pOgFx2LR5ibu2IopxLmUqk_xu6MOA>
    <xmx:FcsxZ5BqX9-NYiqCDCa-dv1CbBvhUMltPnEbXzf6VN5O7ANoHqt56g>
    <xmx:FcsxZ6JbBHMyG0x3JkPvziVv9zFJSww_Ef-YgqAgh3dfBffuPQANog>
    <xmx:FcsxZ4AhJEtOkidC-kJyk_4hM6iO3eN4-z22kf5ym19c2fFOX9XzfA>
    <xmx:FcsxZ93EQI9dtQJ9Vp8RSeopLq49wdjMBnvFnP1BKJtlQP5Q6lxM8zb4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 04:15:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org,  steamdon@google.com,  emrass@google.com,
  ps@pks.im,  me@ttaylorr.com,  stolee@gmail.com
Subject: Re: [RFC PATCH 1/1] maintenance: separate parallelism safe and
 unsafe tasks
In-Reply-To: <20241108173112.1240584-2-calvinwan@google.com> (Calvin Wan's
	message of "Fri, 8 Nov 2024 17:31:12 +0000")
References: <20241108173112.1240584-1-calvinwan@google.com>
	<20241108173112.1240584-2-calvinwan@google.com>
Date: Mon, 11 Nov 2024 18:14:59 +0900
Message-ID: <xmqqv7wub08c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Calvin Wan <calvinwan@google.com> writes:

> Since the gc task is partially safe, there are two new tasks -- an async
> safe gc task and an async unsafe gc task. In order to properly invoke
> this in gc, `--run-async-safe` and `--run-async-unsafe` have been added
> as options to gc. Maintenance will only run these two new tasks if it
> was set to detach, otherwise the original gc task runs.

Would it essentially boil down to ensure that only one "maintenance"
is running at a time, and when it is running the "unsafe" part,
somehow the end-user MUST be made aware of that fact and told to
refrain from touching the repository?

> Additionally, if a user passes in tasks thru `--task`, we do not attempt
> to run separate async/sync tasks since the user sets the order of tasks.

In other words, the rope is long enough that the user can do
whatever they want, regardless of what we think the order should be.

Which probably makes sense.

> diff --git a/builtin/gc.c b/builtin/gc.c
> index d52735354c..375d304c42 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -668,6 +668,8 @@ struct repository *repo UNUSED)
>  	pid_t pid;
>  	int daemonized = 0;
>  	int keep_largest_pack = -1;
> +	int run_async_safe = 0;
> +	int run_async_unsafe = 0;
>  	timestamp_t dummy;
>  	struct child_process rerere_cmd = CHILD_PROCESS_INIT;
>  	struct maintenance_run_opts opts = MAINTENANCE_RUN_OPTS_INIT;
> @@ -694,6 +696,10 @@ struct repository *repo UNUSED)
>  			   PARSE_OPT_NOCOMPLETE),
>  		OPT_BOOL(0, "keep-largest-pack", &keep_largest_pack,
>  			 N_("repack all other packs except the largest pack")),
> +		OPT_BOOL(0, "run-async-safe", &run_async_safe,
> +			 N_("run only background safe gc tasks, should only be invoked thru maintenance")),
> +		OPT_BOOL(0, "run-async-unsafe", &run_async_unsafe,
> +			 N_("run only background unsafe gc tasks, should only be invoked thru maintenance")),
>  		OPT_END()
>  	};
>  
> @@ -718,6 +724,9 @@ struct repository *repo UNUSED)
>  			     builtin_gc_usage, 0);
>  	if (argc > 0)
>  		usage_with_options(builtin_gc_usage, builtin_gc_options);
> +	
> +	if (run_async_safe && run_async_unsafe)
> +		die(_("--run-async-safe cannot be used with --run-async-unsafe"));

So if the caller wants to eventually run both, it has to spawn this
program twice, the first time with one option and the second time
with the other option?  Somehow it feels a bit unsatisfying.  If the
caller says "I want to run both classes", and if your safe/unsafe
classification system knows which task belongs to which class and
the classification system that unsafe ones should be run before safe
ones (or whatever), wouldn't it be easier to use for the caller to
be able to say "run both", and let your classification system take
care of the ordering?
