Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29297198E78
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737021671; cv=none; b=YIPVvSciLXgQ/AjDbVGo6zys9txl877GUzTHIde/z0oSSg6NCN4he0eSE6yCUTSLUXul1NVFGnuL8Qkao8tB2q+LJdGp2Rvs/2wul+2O0nS+eR7J10lPhyY4OU2Pg/Pi1FjXgqKYBNxVLd8NeCTEIg7SrvJDSYPhb1W3VmVfYLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737021671; c=relaxed/simple;
	bh=8OMs2ylpbVxyFo9xAAIl3GFfkCe4EJsZT3tt55fGEMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QA2AZzQeqzGgRwmS1DMK/E9FIpy+iVQN/nmXGSaK31dWNA3cIL76qQ/ENuFFURwSlzC1FWPs/mlpD8ZP4OARNe8/36Gbx8zbFc/0RJ8BDt/Uk0Xf4YXD5bqp72HzbPtB6lC5nZA5Wmp06BfnjrxephhIvMd6G7aD2wmn1f8p5lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rjb3Ji2k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ijrirZlv; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rjb3Ji2k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ijrirZlv"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 051CA25400CB;
	Thu, 16 Jan 2025 05:01:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 16 Jan 2025 05:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737021667; x=1737108067; bh=purSJf7zwJ
	zOD5b9VOGjI0CDojS7EX6et5sC2QyNVDE=; b=Rjb3Ji2khavO0vQuXyyMQtWGdY
	20m8SqIGTy/6DqVklGZ1oUHN1Ju2FpBs8VdhJbnIsTDhpn31KC3Qd2i+lH2pPjK4
	3UrfBff4Ex1aBX9xj4sCZYwJGOVMSV5H1raxGijU4h3Os0/4Tfto+oKttzuQCy2v
	JcEdtrmoCGgvgaidVd4MWJKjzpMGOcLxMj1ZW8sNKth2vi76VjYXJHj9inSFh/iT
	lEksIbPI2b/cPoOENrrsHBgQz3ys8zMXrm4ykTvvUglKgbL7tf1T9ynQmo9tvqxw
	YEpPHi8slB9FQytak67SX9H7uoy886/PKqB+XfbOdusgTA0oI+Kjikqgmh2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737021667; x=1737108067; bh=purSJf7zwJzOD5b9VOGjI0CDojS7EX6et5s
	C2QyNVDE=; b=ijrirZlvZd4nidI98Ha/opRSPhu3eE5RvIGVwQbxp6GKV4Geo+Q
	cxDVV7Xxz+C5lVFfPKGRmtmftAdJbxp4a+CgfPmD9vchRVTKIWwtDKMEjjhYxOEP
	V8Ec29HedqO1K9bfGaCEhmEJAfxMKSfl5umZvA6Oc1p1r7Gmu6yaGqXJYke2xKEe
	5LZrnhzTF/osZGU7eepnPUa2fExf4L2pb4Tqc4RjZH3aEvAbesjdyAt5ddTeWt9d
	BB4mzUdrjyPGcZeMzcQA3Ce7QS9Z3A8Em3ZI5bsFKGgOyIlhRkxc0uLPRf+sitgA
	EtkG0NUUQcuFo3jVXiFu6gFHLH+3bi99Lkg==
X-ME-Sender: <xms:49iIZ8qrOphbl4d9JO4Sn4buFe9J90ECKknXRnTdZACDip0khajomQ>
    <xme:49iIZyq9gFlukWcFPFOS0-F2-0oGH9tKHitH1HbvKcA5jkr-LRtCCEwKafmVJCS0K
    bwvIdFvSkUeIsQrjQ>
X-ME-Received: <xmr:49iIZxOf3ItBXqcaJUDCCIzyN6NlChhjA4zUS0XJrwasiXpKCACCCuV4XZ-irhBHtD4Rn9eNartHrcXxSj5k36JgahIX0JNa7V8qp0EMzT0i3Do4Cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepudegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeguvghrrhhitghkshhtohhlvggvsehgihhthhhusg
    drtghomhdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhn
    vghtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidrug
    gvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjohhnrghthhgrnhhtrghnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopehsth
    holhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:49iIZz45QiggbG8fkcxWgUuLgOtOprYIjkuVijpIdtBRx7UcITN6Sw>
    <xmx:49iIZ77XC2ny4vdmiL8O1kK01F46tndu-LXBhJhcVrUtswDObqdgxA>
    <xmx:49iIZzgs7oU1l9RazXaWQ_rMAneBr3XDe6ApV84fNfVqCSdqO0CmOA>
    <xmx:49iIZ161YMhPrMvHbSXJEj4dkJLolBz2Sr0B2Y7o7fWOs4UjYR7hjg>
    <xmx:49iIZ6TFrhs0BCFdObu7NEIJeXzr-Wanqgbtngr2byNKmSaJeZ4HHg_M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 05:01:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0146647b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 10:01:04 +0000 (UTC)
Date: Thu, 16 Jan 2025 11:01:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, me@ttaylorr.com, johncai86@gmail.com,
	newren@gmail.com, christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com, jonathantanmy@google.com,
	karthik.188@gmail.com, Derrick Stolee <stolee@gmail.com>,
	Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 3/5] backfill: add --min-batch-size=<n> option
Message-ID: <Z4jY34vmK1yj0Mzi@pks.im>
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
 <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
 <3fa32822dabb64266a0625c50530ae2ae0797de6.1734712193.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fa32822dabb64266a0625c50530ae2ae0797de6.1734712193.git.gitgitgadget@gmail.com>

On Fri, Dec 20, 2024 at 04:29:51PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> Users may want to specify a minimum batch size for their needs. This is only
> a minimum: the path-walk API provides a list of OIDs that correspond to the
> same path, and thus it is optimal to allow delta compression across those
> objects in a single server request.
> 
> We could consider limiting the request to have a maximum batch size in the
> future. For now, we let the path-walk API batches determine the
> boundaries.
> 
> To get a feeling for the value of specifying the --batch-size parameter,

This should say `--min-batch-size`.

> diff --git a/Documentation/git-backfill.txt b/Documentation/git-backfill.txt
> index ece887831f6..e392517869c 100644
> --- a/Documentation/git-backfill.txt
> +++ b/Documentation/git-backfill.txt
> @@ -9,7 +9,7 @@ git-backfill - Download missing objects in a partial clone
>  SYNOPSIS
>  --------
>  [verse]
> -'git backfill' [<options>]
> +'git backfill' [--batch-size=<n>]
>  
>  DESCRIPTION
>  -----------

Here, as well.

> diff --git a/builtin/backfill.c b/builtin/backfill.c
> index 177fd4286c7..ddccececc36 100644
> --- a/builtin/backfill.c
> +++ b/builtin/backfill.c
> @@ -21,14 +21,14 @@
>  #include "path-walk.h"
>  
>  static const char * const builtin_backfill_usage[] = {
> -	N_("git backfill [<options>]"),
> +	N_("git backfill [--batch-size=<n>]"),

And here.

> @@ -111,9 +111,11 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
>  	struct backfill_context ctx = {
>  		.repo = repo,
>  		.current_batch = OID_ARRAY_INIT,
> -		.batch_size = 50000,
> +		.min_batch_size = 50000,
>  	};

Nit: it would be nice to adjust the name of this variable in the
preceding commit already so that it doesn't have to change again over
here.

Patrick
