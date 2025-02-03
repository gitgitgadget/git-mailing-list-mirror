Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E741FBEB3
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738572048; cv=none; b=kX7iLX2tbQuH+meGsktm4tYIfSspt49P8t9tcUgUXFebrp7k10AwiFm8P2BolZPND42F+LywVpwuZ14aEDMRkpq9voRS1cyqOp5ID18wmXKX/bqUNoTgKxldjCeCpK+8QkfOaGq1PdLpxWtfgM1rEH+5odxox+KrR8N5pGe6MaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738572048; c=relaxed/simple;
	bh=Ew4/rMnGqO/RJgIfULSzdb5ZBSKDfTwwmmNaW5NBN/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmf+EhcIz317V8U5R1HDKqSvJ+v8xg2bd7ZFfZ2j6T5PuhrpFLxV+PJShn0Yia2aAGBtB4xDuoFAs16R0iTtmvvFHKFojjftM06JZTXrvH9b2W+son3BC2HcLMX3ZFbhVFyHGplcznXZhd254s33mRWiv+Kk4Ip0PL72la4Oys4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iayRmLC9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cenVIXOU; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iayRmLC9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cenVIXOU"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D248D1380860;
	Mon,  3 Feb 2025 03:40:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 03 Feb 2025 03:40:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738572045; x=1738658445; bh=/ZemaAwj+9
	HzA63fROnyBNWDRIxAbhLQmIBMlopv/NY=; b=iayRmLC9UDmfQ40y69KL6EHFBL
	0UBd7UxCJIcsoLxQFRog10+QGrVhBYvaO32IIIEpqO6p+M0KNcy+bFuhRNckIQmR
	Ye51/j4oKLDtH0bEV10egZ3g+4goZLDTBATZ5uJH0rsatt9OZNOye4zBXvZMcwS0
	YzSiowkNJSVbpXBcuhaTzshX3IiL09omenCcIznbi5R0fXqdbN0BK3H3uxrBUPB2
	zx1ng26ADDlNUZWYbdR3K3LbqgwS0gLBE+wysGoF8Q8h/9g00OcXBGdVwWBX2N7h
	HZPYBrhIswogA+qUg8ryY/8BHPu0mOl2A3An6SuD9cEN1PfBwJysX0u0FCCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738572045; x=1738658445; bh=/ZemaAwj+9HzA63fROnyBNWDRIxAbhLQmIB
	Mlopv/NY=; b=cenVIXOUwnLUaMctARnbPPfm6XivyGO6mzdJl2ZxXZ8G6mERpvD
	iEB3IrsQGEVSLAV10/oC3jN5HMqX7pdB79qxXHtAIpApG1j/23L/HJdn7ep5lgR+
	GaS9L4XEQ9AshN3+XpqWroTYODlDCugZDBTuc12v4nGOBsu128iwJLqDr+ylucim
	5ML3lXDWle0DYNvG8ec7mcoM4ZzPUNbev+YMAroI61hzT6WQpcWcUtAqU8Y8iC6/
	WLryhNkwoL+jlFuboZehXubcwNMAJspyHe7PjrytGhSDMWvyrjAqvZEI7VhmvZS/
	v+K5chmiPfg6I/WVhDP4XvmehSFxWO2W9Nw==
X-ME-Sender: <xms:DYGgZ08G0avE8Dh456tNXDmLouQFXIw8y9UWWs9rVtpwjykyUDMqiw>
    <xme:DYGgZ8vFdI5Bcg0IdddZcfypY6XhBbp9zXSYPvvBmfLUZGMgZ0D2ACwSDZjVkkQpK
    f_0qiydh-nB3duIXA>
X-ME-Received: <xmr:DYGgZ6Dx8OmMJeD1B6syDIh8EqQTotZfGJmu1PKZwJZsMQWBjUsBmyUksnQZxEdD6fknOb_Vac_p2cHFvogKfijq2Kvc2QcAS_UMdOB2Wi8wdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhhrghgghgvrhesrghluh
    hmrdhmihhtrdgvughupdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:DYGgZ0cNENlEX1TRGMiTGHVZC2KWxNwWG07n0ti_gabFv6FbyeABaA>
    <xmx:DYGgZ5M1e-N2u4kTn1KS3qf3KuihDnOOZm9hQ2hbw2lpPXuSk_uPrA>
    <xmx:DYGgZ-l9Auyicw_WeOuUZUosTBydf_0jiTczY_VhpxJla6BwX1ktdg>
    <xmx:DYGgZ7uDmE27ELCqK0PMApYH7HCTzNuamAvX6RKhds8Ht4S1-HsasA>
    <xmx:DYGgZ82r-_-C3WeE-9rDci8vsfpKtSC0YZLkEL1dgb0I47bDnLRPLtVg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:40:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 377d9a6b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:40:44 +0000 (UTC)
Date: Mon, 3 Feb 2025 09:40:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 8/8] builtin/fsck: add `git refs verify` child process
Message-ID: <Z6CBC5kyvIhBuLk6@pks.im>
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux>
 <Z5r7NnzvirWEljwV@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5r7NnzvirWEljwV@ArchLinux>

On Thu, Jan 30, 2025 at 12:08:22PM +0800, shejialuo wrote:
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 7a4dcb0716..9a8613d07f 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -905,6 +905,34 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
>  	return res;
>  }
>  
> +static void fsck_refs(struct repository *r)
> +{
> +	struct child_process refs_verify = CHILD_PROCESS_INIT;
> +	struct progress *progress = NULL;
> +	uint64_t progress_num = 1;
> +
> +	if (show_progress)
> +		progress = start_progress(r, _("Checking ref database"),
> +					  progress_num);

Hm. I don't really think that this progress meter adds anything right
now. It only shows either 0 or 1, so it basically only tells you when
you're done. And that is something that the user can tell without a
progress meter.

> +
> +	if (verbose)
> +		fprintf_ln(stderr, _("Checking ref database"));
> +
> +	child_process_init(&refs_verify);
> +	refs_verify.git_cmd = 1;
> +	strvec_pushl(&refs_verify.args, "refs", "verify", NULL);
> +	if (verbose)
> +		strvec_push(&refs_verify.args, "--verbose");
> +	if (check_strict)
> +		strvec_push(&refs_verify.args, "--strict");
> +
> +	if (run_command(&refs_verify))
> +		errors_found |= ERROR_REFS;
> +
> +	display_progress(progress, 1);
> +	stop_progress(&progress);
> +}
> +
>  static char const * const fsck_usage[] = {
>  	N_("git fsck [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]\n"
>  	   "         [--[no-]full] [--strict] [--verbose] [--lost-found]\n"
> @@ -970,6 +998,8 @@ int cmd_fsck(int argc,
>  	git_config(git_fsck_config, &fsck_obj_options);
>  	prepare_repo_settings(the_repository);
>  
> +	fsck_refs(the_repository);

I think there needs to be a way to disable this. How about we add an
option `--[no-]references` to do so? I was briefly wondering whether we
also want to have `--only-references`, but if a user wants to do that
they can simply execute `git refs verify` directly.

Patrick
