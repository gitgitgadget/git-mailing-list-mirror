Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E3D28DC4
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783870569; cv=none; b=bHkWHQG/71L650B9MWRWMAKOQ/OqSdde4+64wxqtwBVR5EkyUjoJUEHgChq+MAa3TFT5UV0sgdEB2ymitkN9E+BeGE6C7A+E4D8LvWUMNJDyGJ11A1aGrM4aa6mIGOiJS0X1I/ppw+zKN7DXEMQ/fSEzd12y/MGOso70UXLwkbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783870569; c=relaxed/simple;
	bh=HCEbX079r4nE0T48QlsW+4YnA/d4ZC6DKfqIuvEgrhs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pUlIqQpx6iKHbm1LLk2aqllhPAYkOUBfydya3IaDKx1BUwYQmTSEagS4mo5FusVCJf6adjlfgsVXitbTJP5tHI2n04MG+MrV62qWQYiARPR7O62GW6V5KAnzGRit+jjO3XJkQ+xKQFYrq+QBZo7L/5Ew2xTIz4bPvJw3kIzzAGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WuSiWRzN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wi8Sdr9+; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WuSiWRzN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wi8Sdr9+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AE99914000B7;
	Sun, 12 Jul 2026 11:36:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 12 Jul 2026 11:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783870566; x=1783956966; bh=b3Q32XpC/S
	t2GlgJ8N99OKqbUeak7rUQw83rU6baSj0=; b=WuSiWRzNogWUjH22HUzRd1llQk
	EwtcMHP6wMGJHXR665xIbrozGu8Ynlu5hNtdBaGZTm3Hwd1E3xx8q3T4thYVxXmk
	Z5OQ9doUbBqKs2Yk0dflMaDJRy1hla9gXOL3Zl5zsJgndePTZj9YYbkLtBa158S6
	UtLWn5Pym8v5zta9RaKAT4FGS23Lidihy+OrjsNZL+RYEOgtFAFKZHQqlE9bXgrU
	JTGe+FtBJy1FnE40n0qIqoPJGEDZjok5vUnUGvCAiDla2UydAgODiHkzz/y//bKi
	5WSSlKIADR55qMHkbnRlXsEsOqjCpcVso0jF1uplmdJ5/VkDvBnFk0D3Sh+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783870566; x=1783956966; bh=b3Q32XpC/St2GlgJ8N99OKqbUeak7rUQw83
	rU6baSj0=; b=Wi8Sdr9+bn+Y89vzbXqE9MjtCq5z+6qRwr6TFsB1o00No7wuisx
	5WN1HITBRXrbiZ6iarZwC2z9cUnqtyfOYGNbgtSgEwViVDMAX1sQkgT07GnKrvqt
	XA0qOWaI3SWSH0NN+dWZ+a0w9REK07evbDRQe1MYrsakucfdDRlKSu3tHHszXFDP
	oh4AXCI9eeTa4G1AcicuNeEi7BVlaEjG81jXy9NDXQejlWRMe/NF6a40QuD+FYM3
	7ZTC3QdfKz3yrIHnXnMzi8zCCL2s7LMHO3Fg51ycuuPV1Feue/iSiBNICXUNJp6u
	zoYOHUPgsqiEkFI1oMmSX035Tgm//9Y9XyQ==
X-ME-Sender: <xms:ZrRTai1Hgxi_Gmcjhl5tuZGhvJpV01avonznQY9QRizaFlSIjtrOlg>
    <xme:ZrRTanqcBzha1c1oHFjFbh_uXxwHKOkMlI6BIpwNWA5X9MJZfPu36e98744g84m6m
    kG1kzPkroiw2ZbksrM19j8giVy2BQT7ap_b61hQ0tTuhWcZxbmZTw>
X-ME-Received: <xmr:ZrRTaugQaUWzTD-QioIHaIrvOQqsGNUW8r97O_FD3Mvfb75PrFXR-GT_WVoN7ksXoSBs2Y8pI30I1RQEew0YH_3ZtwOiCsr_ZfcXyX4>
X-ME-Proxy-Cause: dmFkZTEahxN9B/24xAOGTGcBH+7g74vqQn1DKTSBx7VePk21Foic38NPVTG4DAu6Cfw4fX
    OVq7uZGOFwd4GDZ4T7qFhGgtpSg2xvvgADurdIHEHoojTBWc2Sdxd5t3MHO4edUsCxwwfy
    3smzB49rfhPm4Fs6szzD55sch//MTw5htiMpQNaXsX0z0dq+VuK3dDpC/QCvCn/flyBs4U
    gX1V0qcMg2XNWoOA+HoXPjtKGkldnx4+kuwHi3K/HpIucOMRvnFpL6ZC6uSTV6SOI3z+n1
    MIswRgfgoPUys07Pek5fOrvpWL/U7R6k6kIgkBMWSpHwSrK0FdyBgQjq50BKoU+Liw0lfJ
    3y9OdZK6NDUraZU/O0MdjEUsygFUyzi3vQPat7/jjgwi6P0xfa4a9MEsWf6NiaP5pI/piP
    Yq8aXI1TXXRnqwGphq74I+fWu+cQSDQkShbh8D/kxOc3fhwx4WLelOogp/A1pzgwThC+RR
    ktlwt+OgaQSWIIoIJwRFK4Lrh9022rmk6P/9wJPlXnUsC5WSOs1b0S2dcCKA4KFYng9sPK
    2TtIIloPAyc3UnYNel3Aw2k+Q5F9I25d2BmdQ6EFHYmREL7ohu3jpFzaqyHSsMu1NSNF7u
    e1kBAsheWhaGP87ntmo+hkyeut/XnqYdI3g9CK9KoeByq86lZBGulom8VU2Q
X-ME-Proxy: <xmx:ZrRTaj9YWcYT86yjtGcHGaXSeAiy5e_rtacFh69mqjHsN7ONsgFHuQ>
    <xmx:ZrRTaqVc5zaZ37kcE-Vt8dhzTg5XNgUwpxaOd1GAaEvAB4l2df99dw>
    <xmx:ZrRTanBmfM384brjKdOeueefQs9RHEj1rl1sFD1eYT0ysrNpt3GWWw>
    <xmx:ZrRTavE5R5rbndCgo2KToRYCZFvi4bY2jaTWvQ-GL89WhnNCCkQovA>
    <xmx:ZrRTanMlExKerU58UR9Ou4tK8_a5QcWD27kjMgmQLc2_iOnPd3X-DviO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jul 2026 11:36:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  pabloosabaterr@gmail.com,  cirnovskyv@gmail.com,
  szeder.dev@gmail.com,  Christian Couder <christian.couder@gmail.com>,
  Ayush Chandekar <ayu.chandekar@gmail.com>,  Olamide Caleb Bello
 <belkid98@gmail.com>
Subject: Re: [PATCH v10 4/9] environment: move pager_program into
 repo_config_values
In-Reply-To: <20260712111734.1073514-5-cat@malon.dev> (Tian Yuchen's message
	of "Sun, 12 Jul 2026 19:17:28 +0800")
References: <20260709161145.13349-1-cat@malon.dev>
	<20260712111734.1073514-1-cat@malon.dev>
	<20260712111734.1073514-5-cat@malon.dev>
Importance: high
Date: Sun, 12 Jul 2026 08:36:04 -0700
Message-ID: <xmqqy0fg43vf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> The 'pager_program' variable is currently defined as a file-scoped
> static string in pager.c. Move it into 'struct repo_config_values'.
>
> The configuration parsing logic remains strictly within pager.c to
> respect subsystem boundaries. The read/write operations are simply
> redirected to the repository-specific structure using
> 'repo_config_values()'.

By redirecting to repo_config_values(r), we now enforce that the
passed repository must be 'the_repository' (due to the assertion in
repo_config_values()).  All current callers of git_pager() and
check_pager_config() indeed pass 'the_repository', so this new
enforcement does not harm them.  However, it paves the way to later
lift the assertion and allow us to configure different pagers for
different repositories, which is a welcome improvement.

>  static int core_pager_config(const char *var, const char *value,
>  			     const struct config_context *ctx UNUSED,
> -			     void *data UNUSED)
> +			     void *data)
>  {
> -	if (!strcmp(var, "core.pager"))
> -		return git_config_string(&pager_program, var, value);
> +	struct repository *r = data;
> +
> +	if (!strcmp(var, "core.pager")) {
> +		FREE_AND_NULL(repo_config_values(r)->pager_program);
> +		return git_config_string(&repo_config_values(r)->pager_program, var, value);
> +	}

It may be just me, but I would have preferred to see this written
more like


	if (!strcmp(var, "core.pager")) {
		struct repo_config_values *values = repo_config_values(r);

		FREE_AND_NULL(values->pager_program);
		return git_config_string(&values->pager_program, var, value);
	}

which will make it easier to see that we are freeing the same thing
immediately before we overwrite it.  It also shortens the lines.
For a temporary variable with a very short scope like this one that
is introduced solely for readability, it is OK to use even shorter
name like 'v' if you want to ('r' certainly has a much longer
lifespan that it, and I would probably have preferred to see it
called 'repo').

    Side note: we might want to give a hint in the coding guidelines
    document that a variable with larger lifespan should get longer
    names, or something.

>  	return 0;
>  }
>  
> @@ -91,10 +97,10 @@ const char *git_pager(struct repository *r, int stdout_is_tty)
>  
>  	pager = getenv("GIT_PAGER");
>  	if (!pager) {
> -		if (!pager_program)
> +		if (!repo_config_values(r)->pager_program)
>  			read_early_config(r,
> -					  core_pager_config, NULL);
> -		pager = pager_program;
> +					  core_pager_config, r);
> +		pager = repo_config_values(r)->pager_program;
>  	}

Same here.

>  	if (!pager)
>  		pager = getenv("PAGER");
> @@ -302,7 +308,9 @@ int check_pager_config(struct repository *r, const char *cmd)
>  
>  	read_early_config(r, pager_command_config, &data);
>  
> -	if (data.value)
> -		pager_program = data.value;
> +	if (data.value) {
> +		free(repo_config_values(r)->pager_program);
> +		repo_config_values(r)->pager_program = data.value;
> +	}

Same here.
