Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A76D2AD16
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 05:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761025474; cv=none; b=JUMg1xJd2TeANppEqz4Of0jpvozvlRczWkoUlGxBIaKKULhJxjNIdvEuOkcFfpQU+UPBNwbDjTQOm5Q6CABnY18dHHgwZF8q627+Hv7NYe5t+F6gXhLabRoxi1j0w5BZxrs/1nnPqm1zb7ufIwajDnNqHzbF6kp8eoM8GHNC02g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761025474; c=relaxed/simple;
	bh=QEbbOIk1jCW/YuC0pOOo/FvnPKym2rUz7qACh4gyuDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXtLAufxEcFyHBQ/g/Jtx0aClkzP9kEiEtSKdTb/msiDhWPvw3aj1y49zRCzsbk1hKRJWFWZEUOXVzK3M0EUjlhsCPCQXDBQriYNjJlx97VH3TO8SNbTr2YwW8qW4yLmOBuwqxHBTL/bWmrzby7ZlX9jJYQWAydUAA/tz1tlP44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SFpk8rQb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pDPX7w+c; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SFpk8rQb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pDPX7w+c"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 531CAEC00C7;
	Tue, 21 Oct 2025 01:44:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 21 Oct 2025 01:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761025471; x=1761111871; bh=wOhKMnmF09
	QLkdpBfusXRDNJ9uQAMrhsFsatIhPGU8Y=; b=SFpk8rQbHA2tbtZWtIq5Ac5MNf
	v9tYkprcNk/RJL/FFMftPt0RSvC+Pz/6mbyLAk35sULc3weVpo/kqzy6Z0yEuOzy
	iIRnk26DpjOtO7EE0B3SEGxpmpdakUooZzb+UngT23sbLHCW/pqGv4T7uZ2ReDyR
	xDRuyN8DdFvb2UX5cuDbNVaZAKnrFVKnyNUarXr8bS+JRiNr7nL9+yv8bq8mUv4C
	Eqe5f0bokdQL+xjtGEImw638c/bR3p1Wjzh84UTXiKgYeA5Rb2UoDWM1BINtvJRr
	XRE/ojeusA+WvriMVAQzZ0LLOCoJq6Xf+8t7rhU+wqn+y8g/q0vSTXynxgFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761025471; x=1761111871; bh=wOhKMnmF09QLkdpBfusXRDNJ9uQAMrhsFsa
	tIhPGU8Y=; b=pDPX7w+cWtEx3YPmLXdeUNseGoc4eVyBg9Y1gGpWb0KYj2FICmR
	Ah3n897e46lBQdcfMAKDAjajnyw/Ly22ArUhB3D2piOtOeIpz51HRDdHlLYRRiBa
	2MJENZU4yvDX6uX7ygJhSrtJYc59+9tqix3N8/kw8zNb/9F5jqQPVFK8YV94r2v7
	FlDPUCesTrJ+5v8OaeDaw+zkuaCFUPV+8cO4RXqA6jI/kFzjr8X4w1xV7YUxAfOG
	imk/EhH5opKmz+XVrPhsVDnXccJYpQmKvD5T2K7DKBOhPfL5WD9eWTMW30SDcAQx
	4nRWFXZjc1N0nH5scjZ+ntAQlGXXMAJXaDQ==
X-ME-Sender: <xms:vx33aIn9un5vdqqhlA9DzrRTDOjF7DFyixu70-8lQsSmAUNdc1AA1A>
    <xme:vx33aO3J4eAr8rWyE2PO0xBfEzTrhrpAi-fTf4GwcbGykVw_9LT5pEuNPoRa4kBNa
    d-J-XWOdVMTCI6OERJrnCsEjo9-tzTGu4l47gyX9sl__TAnKVOs>
X-ME-Received: <xmr:vx33aLr187XzdmPCQGAiyF-u8B5iHtiOYqkGaTdXAizQoWHeZRYqke01-DScUgSKAOjyBh7w-8X1-3nus6saaf8zSZfqcJ4BvHUk9OBijJbpdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeelkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilh
    drtghomh
X-ME-Proxy: <xmx:vx33aDfKPFTqTDn6H7GMg2JJbGICcg83oma5ISTpHMaPNJ1hh11FOA>
    <xmx:vx33aCq5hEVUF6qkXJELgoe9SXhGlfy6uOCq77YE2rutgxA_gSTAJg>
    <xmx:vx33aMHgLEUgqwbA8m4nTnPWUwlbo5HEsLk28r8MtI9hxVraBaSOEg>
    <xmx:vx33aKsr4N0ZUtasKgyuhs7WfrBudEiFLVnYz0TqGGd-BZyJQcdoAg>
    <xmx:vx33aHLIA8-v4-79KrZcxmbrMfgP3a27lJlps5wibMGpeM47oYvHZnZV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 01:44:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 99479a38 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 05:44:28 +0000 (UTC)
Date: Tue, 21 Oct 2025 07:44:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 2/2] repo: add --all to git-repo-info
Message-ID: <aPcduvnjD0yphja2@pks.im>
References: <20251020181943.6314-1-lucasseikioshiro@gmail.com>
 <20251020181943.6314-3-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020181943.6314-3-lucasseikioshiro@gmail.com>

On Mon, Oct 20, 2025 at 01:19:47PM -0300, Lucas Seiki Oshiro wrote:
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index 209afd1b61..1a9d0c50a9 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -8,7 +8,7 @@ git-repo - Retrieve information about the repository
>  SYNOPSIS
>  --------
>  [synopsis]
> -git repo info [--format=(keyvalue|nul)] [-z] [<key>...]
> +git repo info [--format=(keyvalue|nul)] [-z] [--all | <key>...]
>  
>  DESCRIPTION
>  -----------
> @@ -18,13 +18,14 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
>  
>  COMMANDS
>  --------
> -`info [--format=(keyvalue|nul)] [-z] [<key>...]`::
> +`info [--format=(keyvalue|nul)] [-z] [--all | <key>...]`::
>  	Retrieve metadata-related information about the current repository. Only
>  	the requested data will be returned based on their keys (see "INFO KEYS"
>  	section below).
>  +
>  The values are returned in the same order in which their respective keys were
> -requested.
> +requested. The `--all` flag requests the values for all the available keys.
> +Keys requested after `--all` will be duplicated.
>  +
>  The output format can be chosen through the flag `--format`. Two formats are
>  supported:

The synopsis now disagrees with the new behaviour, as it looks as if you
can pick either "--all" or a set of keys. But we now support both at the
same time.

I know Junio mentioned this as one of the ways this may operate, and
said that accepting both is the "most logical". I personally don't quite
agree, and think that having it be either or is a bit saner. After all,
what is the use case for listing specific keys twice? I cannot really
see why one would ever want that. So I think we should accept either
`--all` or keys, and die if they are used in combination.

If Junio continues to prefer the version you have here then so be it.
But in that case you'll have to fix the synopsis to reflect that.

> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> index 2beba67889..28635d0f92 100755
> --- a/t/t1900-repo.sh
> +++ b/t/t1900-repo.sh
> @@ -110,4 +119,24 @@ test_expect_success 'git repo info uses the last requested format' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'git repo info --all returns all key-value pairs' '
> +	git repo info $REPO_INFO_KEYS >expect &&
> +	git repo info --all >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git repo info --all <key> duplicates <key>' '
> +	git repo info $REPO_INFO_KEYS object.format >expect &&
> +	git repo info --all object.format >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git repo info --all <invalid key> warns about invalid key' '
> +	git repo info $REPO_INFO_KEYS >expect &&
> +	echo "error: key ${SQ}no.key${SQ} not found" >expect_err &&
> +	test_must_fail git repo info --all no.key >actual 2>actual_err &&
> +	test_cmp expect actual &&
> +	test_cmp expect_err actual_err
> +'

Yeah, these don't quite convince me that using them in combination is
sensible :) In fact, there is one more argument against this here: in
the current form, the order in which we print the key-value pairs
depends on the order in which they are specified on the command line.
So far so good.

But with `--all` that's not the case anymore, as we unconditionally
print all pairs before the individual keys. So `git repo info --all
<key>` produces the same output as `git repo info <key> --all`. Now
we're in a mode where only _parts_ of the output depends on the order of
our command line arguments, which is inconsistent.

So... yeah, I think accepting either or is the more sensible approach.
There is no use case for printing keys twice, and if we do then we have
some weird inconsistencies in the ordering.

Thanks!

Patrick
