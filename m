Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65FA22A812
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018801; cv=none; b=d4sworeRGQwvu0aLwXnS3+Y/t80nDY8V0ZLGb1ZtK50glRBi28LBzhUYQUZqjgTShdHdUNGkrQkAA/Icm1e3wpfVmKuCOG8rL+VCQ1E6lJap+Ix9ade04jhqf/nfsYJtG4nIwXwoDatZyN/c9E1yNkTtbN2ksGYaRv0lFbPUtkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018801; c=relaxed/simple;
	bh=hve+fuB8JPRKjjNnz3ahi41TkNEWOYEFJda138LhTyM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b9hlwppiRBKV1Hzy3XoB0Bo/2VhHOpMztgNW4WRjq3REoilZaDbL6qs1gp9IdiDk7zbsLRFtcgdg/GyHUZrYFZw3gGOSPwLNKsanPR3nNOT3dmx2CGzSchTE9NzlF70VmbcXSWNA32RI2AZj+7B307nm9bVJaL7b2kNQR78Wif4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wVZIcBiw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H+mZop0s; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wVZIcBiw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H+mZop0s"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C4183254020B;
	Mon,  3 Mar 2025 11:19:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 03 Mar 2025 11:19:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741018798; x=1741105198; bh=Vi1cGf+kkl
	oTcEYYiIcTo15lBcKcjXQb+rFssohIPAU=; b=wVZIcBiwZhLxh9+vxFHcQZY0hx
	TBigGLJl7QVDRNfDEOUAYmWttTjQ2WeQTrvXfW54qhBUSK9PpY+fD1wQXFFt9MQ5
	fUbGj3+JUHiSBwWRWHNJG+WD2cwFISHEfQl/mkoymeM6/iUW0aO2vLw+H+tBbWTK
	1XSMgGXlYyJO1ycZ4ja2IATlXsA6qyyiTatfqLD4iWQz87mOXEdsVdGUWdZG4HsH
	iC8lFyxI5M0BWznLNwP/BuSmbmOVhqM8gSjvxtlRth8PFsYsp/GsWNDI5Ah8VjWL
	D354+Ej1dc8XaaHz6hVn00yw5wZyhvHSXsZErZh9UDixTDpmHW2TDUP5Fzkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741018798; x=1741105198; bh=Vi1cGf+kkloTcEYYiIcTo15lBcKcjXQb+rF
	ssohIPAU=; b=H+mZop0sgtyAMHeq+oNNo8kRUWapcoTDugSfZ/nMHpssuL+MvE3
	LDGyWlydFlr55ohNYv9CBRbD2iiwYWKGrhCDECc8vwDIAM5S4rsfDFk4l2PtX7e7
	krBjpy8wunU3Pg0gcSd9kLPoS6OO8e7gLJ9SXsc3MfeZnNFgYidNchcBTsWAfKmL
	o9GrrSB/i/4MWM/z4zT4stdQ0kuPkuKDSMFm9NBU/SBRYg4S3O2/iBXBd+YMl+iQ
	v4xeGFWLzcMrc+vmmrbtI+RdWGj4bs5SbaQny/kne+QXyQlSeENpiyIf4ohL0h6J
	KKSIVpMgoIWtcDWce2sQWS8e3xUDpmJpXTg==
X-ME-Sender: <xms:rtbFZ-0BhoLrjFlrCN8Zg5k_5qHqtbPsxZC9UzqXqyYwlHL0WSaeoQ>
    <xme:rtbFZxHcO43gAJq3bpscAlXRrwXbyyfOkt1wGe4w9woyWFDFoPlSETaAgF9ZQvnq_
    r5bh6udKTXTAC_WCw>
X-ME-Received: <xmr:rtbFZ25RQH_GaW3McMx8gHUFLhGlhRdB30fxAyYzfTqzAAjKQ2p7coLXybSO_rPkds-WkNZDKA0ogIs8juBe_dQXE8n7cAB8kqWG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddv
    feesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:rtbFZ_3r1rEZvkiGd97EHcWDxdTewV7vhYZ-FSyS6RZuT2Zr-NC-4w>
    <xmx:rtbFZxGNBwDLL2BL7doOR8JFKoqCk6XA3UceP3FZKbROs58M5qPmIA>
    <xmx:rtbFZ4_yhhZqPMA1dzC2mk50JxDYmzaKolEuDnlO51ZA02zHgWZkzA>
    <xmx:rtbFZ2lS0-WbLAFsnwM9ElRC-CKNNwpYdipbEjNK5Orb_2o-qaTBbg>
    <xmx:rtbFZ26825osOwggBZvXCO_j64K7z7CtJnGBuBLdGMGAfOaeDsV7mC0b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 11:19:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v5 2/4] diff: add option to skip resolving diff statuses
In-Reply-To: <20250228213346.1335224-3-jltobler@gmail.com> (Justin Tobler's
	message of "Fri, 28 Feb 2025 15:33:44 -0600")
References: <20250228002604.3859939-1-jltobler@gmail.com>
	<20250228213346.1335224-1-jltobler@gmail.com>
	<20250228213346.1335224-3-jltobler@gmail.com>
Date: Mon, 03 Mar 2025 08:19:56 -0800
Message-ID: <xmqqldtmxf0z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> By default, `diffcore_std()` resolves the statuses for queued diff file
> pairs by calling `diff_resolve_rename_copy()`. If status information is
> already manually set, invoking `diffcore_std()` may change the status
> value.
>
> Introduce the `skip_resolving_statuses` diff option that prevents
> `diffcore_std()` from resolving file pair statuses when enabled.

Makes sense.

>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  diff.c | 2 +-
>  diff.h | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/diff.c b/diff.c
> index b5a779f997..37cc88c75b 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -7081,7 +7081,7 @@ void diffcore_std(struct diff_options *options)
>  		diffcore_order(options->orderfile);
>  	if (options->rotate_to)
>  		diffcore_rotate(options);
> -	if (!options->found_follow)
> +	if (!options->found_follow && !options->skip_resolving_statuses)
>  		/* See try_to_follow_renames() in tree-diff.c */
>  		diff_resolve_rename_copy();
>  	diffcore_apply_filter(options);
> diff --git a/diff.h b/diff.h
> index 63afa17e84..fc791ee2cc 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -353,6 +353,14 @@ struct diff_options {
>  	/* to support internal diff recursion by --follow hack*/
>  	int found_follow;
>  
> +	/*
> +	 * By default, diffcore_std() resolves the statuses for queued diff file
> +	 * pairs by calling diff_resolve_rename_copy(). If status information
> +	 * has already been manually set, this option prevents diffcore_std()
> +	 * from resetting statuses.
> +	 */
> +	int skip_resolving_statuses;
> +
>  	/* Callback which allows tweaking the options in diff_setup_done(). */
>  	void (*set_default)(struct diff_options *);
