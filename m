Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD73A30F809
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624792; cv=none; b=kzjRFyNfaWfbhtRRYvw1yNDLgsub4y8/YRzM5V6G6iZ9DJlO0EhqRxR/eOhp2QCt4UXMhasNFdLBvgo1h+w2hxVvdOZkXBLw94IDCkrcX6MGttiQLpb1yRu5cb7pAfl95FAie4nuaxepLnNTVVUCszydwv03f1WbX7ZDUvw4XUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624792; c=relaxed/simple;
	bh=sIqVQVcselVG5tFrtSteMe6ZwlgdFP9xjO3lRQzFxS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyKIzhYMKjLxF95v/hh0LF4OqqLmpAi+75YS+zEYMv4l1Od0QqMp6enoSZmx/R3cQzaUTsOopEvJammGYB39MrYXTHLwDdkeBls/QMromf+HaKC9sEiF6beg47uGd2je05IPGhBEMoF5Q6myuNInSg54oKsI+ib6fb93cQEmt0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GoSQZ+dK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kyeVJFVm; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GoSQZ+dK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kyeVJFVm"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id AFF5B1D00269;
	Tue, 23 Sep 2025 06:53:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 23 Sep 2025 06:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758624789; x=1758711189; bh=zk8KrPqSXC
	Dpb9Oap/ZuR+YYguZkBJhbciZFp+lHymQ=; b=GoSQZ+dKESL/7Nm6hVcPO/KG34
	hXJ3sVGJcVYnKYDzgHPnQOCCYOuYNdxS7PLSW91NhRl8byaULz5nUIVplqtbQAMp
	+HC5dfu9iVswxKx7d3lkiLojvKKIKGmSbt1DSZdJBtl23E6xO/K1QGp/79BzmRkf
	6+fGQzMJkw7Qr20p1gU9UArAYbShJYgA/94cWFYGSZz+AaVEWb4CvyXcj5avwEBw
	eKkcyL6iod+XF6PG2cdnStQnRH/n6t/OELAZY0gSrs7t5iHnhqEFClQ2gpwF0L4f
	DwBwtJXtZ8hcXC61W1pq121d0TWGI/Ug4CiFpogkd3TTd1V2pQ4fpklC9XYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758624789; x=1758711189; bh=zk8KrPqSXCDpb9Oap/ZuR+YYguZkBJhbciZ
	Fp+lHymQ=; b=kyeVJFVmFUybEvU8i7TdmggbfEoQ8GGRhBV3pTJEoKb188o1apJ
	x4qcxSnEcfi1YvyHPpZXAgD74bAN+NORHhPSlxTen/opt0WAnQ0EE3G0r0uKOzEE
	kWiYfnnKgUus9dAgD2yFfT3EvPUtRCVJF9BqqDdUfT72nO99D8s0asXb8kGuV03M
	TL4bwX3gfF5MFamhM8+FXQzXu0C4pGZ0QaLC2PZFM8RjrTtegP/3JDbZZmazmxrf
	5mri3PPVGth7pKvEFk2q860opJN+B1dFlLRIbKopiSN9+UD3VLK6irt5406IBxD4
	O1LryaZtyi5BsdwSjeODwIPui9m1RC6P6CQ==
X-ME-Sender: <xms:FXzSaDu0j8vblj5w8jY5HpNDN9YCYz0mQ-fFbNAA_28nmFRRJcgI5A>
    <xme:FXzSaL62Usoh2BTui3ZXDlzPN2Y2tkPsgM6b6ggnN9K5YRc6UeybvTfaoOy6ukfos
    MhitNnPyfh7bEv73SiO_WGZi5h0MSL6G0PqZzCR70Cpz8z7MwFshg>
X-ME-Received: <xmr:FXzSaEKLDOUmmlVV1Scm6Eu1JH_1o1eqU9Q9G0bSyDxC8wQIhg6wF5nyrgSJ_goij4fG68wN2fq4sj4HnSFyTjgG32YXPZDYtZg49z2FZdaD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:FXzSaL4aF1F_RlM2BnNLitv9JaaGOy65of0IV5hyI88dxsAyLy6oRA>
    <xmx:FXzSaHySZh7yCmJjuUoTpHrj8Plas9D4ac8CWhVTjqhOo3QlZ3fKyQ>
    <xmx:FXzSaPZHKbZZg6isbLSvwKrkEVgdcSxCrGyd0I1_G1VuNOiM-Sle7w>
    <xmx:FXzSaJSx1b7SEpXy2YbwGuqB90csA3WI3Ri7P6rYTSIe00nvkFmJrw>
    <xmx:FXzSaOVKT9oPBRNB16IOr9IgdM-VVEYDjcYHytJugB9TZ8VLrzRjq2rD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 06:53:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4bca944a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 10:53:08 +0000 (UTC)
Date: Tue, 23 Sep 2025 12:53:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH 4/4] builtin/repo: add nul format for stats
Message-ID: <aNJ8EUT_QVCqfFo7@pks.im>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250923025700.3046260-5-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923025700.3046260-5-jltobler@gmail.com>

On Mon, Sep 22, 2025 at 09:57:00PM -0500, Justin Tobler wrote:
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 4c16a68e4e..37034e6347 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -291,27 +291,31 @@ static void stats_table_print(struct stats_table *table)
>  	strbuf_release(&buf);
>  }
>  
> -static void stats_print(struct stats *stats)
> +static void stats_print(struct stats *stats, int nul_delim)

Instead of passing a boolean-style option, can't we pass the expected
delimiter directly? Makes the callsite a bit more obvious.

>  {
>  	struct strbuf buf = STRBUF_INIT;
> -
> -	strbuf_addf(&buf, "references.branches.count=%" PRIuMAX "\n",
> -		    (uintmax_t)stats->refs.branches);
> -	strbuf_addf(&buf, "references.tags.count=%" PRIuMAX "\n",
> -		    (uintmax_t)stats->refs.tags);
> -	strbuf_addf(&buf, "references.remotes.count=%" PRIuMAX "\n",
> -		    (uintmax_t)stats->refs.remotes);
> -	strbuf_addf(&buf, "references.others.count=%" PRIuMAX "\n",
> -		    (uintmax_t)stats->refs.others);
> -
> -	strbuf_addf(&buf, "objects.commits.count=%" PRIuMAX "\n",
> -		    (uintmax_t)stats->objects.commits);
> -	strbuf_addf(&buf, "objects.trees.count=%" PRIuMAX "\n",
> -		    (uintmax_t)stats->objects.trees);
> -	strbuf_addf(&buf, "objects.blobs.count=%" PRIuMAX "\n",
> -		    (uintmax_t)stats->objects.blobs);
> -	strbuf_addf(&buf, "objects.tags.count=%" PRIuMAX "\n",
> -		    (uintmax_t)stats->objects.tags);
> +	char delim = '\n';
> +
> +	if (nul_delim)
> +		delim = '\0';
> +
> +	strbuf_addf(&buf, "references.branches.count=%" PRIuMAX "%c",
> +		    (uintmax_t)stats->refs.branches, delim);
> +	strbuf_addf(&buf, "references.tags.count=%" PRIuMAX "%c",
> +		    (uintmax_t)stats->refs.tags, delim);
> +	strbuf_addf(&buf, "references.remotes.count=%" PRIuMAX "%c",
> +		    (uintmax_t)stats->refs.remotes, delim);
> +	strbuf_addf(&buf, "references.others.count=%" PRIuMAX "%c",
> +		    (uintmax_t)stats->refs.others, delim);
> +
> +	strbuf_addf(&buf, "objects.commits.count=%" PRIuMAX "%c",
> +		    (uintmax_t)stats->objects.commits, delim);
> +	strbuf_addf(&buf, "objects.trees.count=%" PRIuMAX "%c",
> +		    (uintmax_t)stats->objects.trees, delim);
> +	strbuf_addf(&buf, "objects.blobs.count=%" PRIuMAX "%c",
> +		    (uintmax_t)stats->objects.blobs, delim);
> +	strbuf_addf(&buf, "objects.tags.count=%" PRIuMAX "%c",
> +		    (uintmax_t)stats->objects.tags, delim);
>  
>  	fwrite(buf.buf, sizeof(char), buf.len, stdout);
>  	strbuf_release(&buf);

It's a bit unfortunate we have to rewrite most of the function. I'd
either have the `delim` parameter right from the start or just squash
these two patches together.

> diff --git a/t/t1901-repo-stats.sh b/t/t1901-repo-stats.sh
> index 5bc6d9d5c4..061b2fbbc1 100755
> --- a/t/t1901-repo-stats.sh
> +++ b/t/t1901-repo-stats.sh
> @@ -127,4 +127,31 @@ test_expect_success 'repository stats with keyvalue format' '
>  	)
>  '
>  
> +test_expect_success 'repository stats with nul format' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit_bulk 42 &&
> +		git tag -a foo -m bar &&
> +		git repo stats --format=nul >out 2>err &&
> +
> +		cat >expect <<-EOF &&
> +		references.branches.count=1
> +		references.tags.count=1
> +		references.remotes.count=0
> +		references.others.count=0
> +		objects.commits.count=42
> +		objects.trees.count=42
> +		objects.blobs.count=42
> +		objects.tags.count=1
> +		EOF
> +
> +		tr "\n" "\0" <expect >expect_null &&
> +
> +		test_cmp expect_null out &&
> +		test_line_count = 0 err
> +	)
> +'

We already have a test for the keyvalue format that looks mostly the
same, so we may just as well test both formats in a single test.

Patrick
