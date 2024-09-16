Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCD434CC4
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726483549; cv=none; b=f9TCaq1s391/+jVw/zzLihqBPFlJb/PU/hiL75sWb3D4n48O3tjis2q16ifKfHFsVv5s5H3TFa1iLshpZ52kvdp3/jEb1EKgfiSI3hh/xSl6pKZDraHTATRYu3YKFwn38oE+9WjQzLX/z4ME+/PvCei5ztrBD2ZEzMN6pRD3w2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726483549; c=relaxed/simple;
	bh=rGgMjarPqutr1VnlLgGp6DNrWEwsgM8kOoME81SA5uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdA91+L0BIHDjKwZMGIPQPZ9HOiu7n46auQFyJLV7ZwMg5xEgGry7LTQPnxhduRtt4fIPthNZArjjk19Jc34uV+R2XEG03A8Fsl6CD+7TkzXbWOcsjyX4JF7qocyAAaaMALf3ZQrKhpi7rjXMmqAELzn9wlRfCRiBUXlD9m+Uu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MZFU9Mko; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FJLiR1l0; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MZFU9Mko";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FJLiR1l0"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 9324D13802B8;
	Mon, 16 Sep 2024 06:45:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 16 Sep 2024 06:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726483546; x=1726569946; bh=zB8pZCUd5y
	TbhNqWgEZ2YFAUQWHIJsPekpiA/gB0LSg=; b=MZFU9MkoSPggZhNb5AAstEZ2ow
	vyCm3SYxG03WUsLNWrsHsVoqshwFXTUzaLJmZYhGXZ1rL/M+1JAgLDnHIlW9+tCz
	ZuVYsE2VEFNAyJMUqebuHd3OQqZT4W7yl2dMCqTkYl41FsFfyPIDzsq68mvRKWVV
	+MCk2xSknHxpWjT42EB6USO+yIiRCP17Ux2EKaq+3SwKfIpW8waFlIydrhknF5rR
	AJOalwPViyW3eqfnW+tCXC4pFZaPR2Xh8B80i2J0iAepXe8A4cUuFdvM39Y+KR7t
	RCq/32aPZih/ilBavzd0tPMjrQdnNrFwx+oxsgGP8MuWrvGj+vyfHdr8YgjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726483546; x=1726569946; bh=zB8pZCUd5yTbhNqWgEZ2YFAUQWHI
	JsPekpiA/gB0LSg=; b=FJLiR1l0uFXKkdKvArjx9qzfNbnjGIdG0LB3MvtRvKNf
	lMMJ87/IXWza1iubqbG0tvHd65zwh3LGKJg2buVgweb/nPZAFlFO0gI9IfCGFjbX
	5SP0q+YSGrd01fxafBYVJyxpZajHUugDgp4CGrr8QnbF1jgk3ZmF7svPSf0sau0E
	GrLKwaFgqrIREqxngzcfHRwnqS0eJQvC1Zlx8gYii/DsUMHdWuIAS28UEWI2Wbw2
	EMLTmNtuSx7gvK9kT3toLqXpo5fJUbBI4LiQSU9zgokaT9fe8CvMXZJyF4HXHKWU
	SSJrEY09Ysj0vJGesc1juervC+XoCjcuy5xrVNOfDw==
X-ME-Sender: <xms:WgzoZvEpIite-Q1SqaeaGITLaG3fZjgRBMMfhk_80zDEcAgiXk8GvQ>
    <xme:WgzoZsV9XP-xEvk1ei4pfhKG085DnJ4hejwIM9UNQqfKUrkK4_Od7yQoAM8XfvsZh
    itV_lpu-yvYvjNBlA>
X-ME-Received: <xmr:WgzoZhLjXJIkl5kBIv8JXr764we8KSY8iUzxC3w-TKb3hseH12ONFFUctY2POWvKqc7SjUPgl01f_R9Rv49KCM04bdP3Bn8MUr2_uIFwonK3mmQY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtg
    hpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghl
    shestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:WgzoZtFGCvvYfBuFXya8hXzrkfl9ce8qIoy1FIzz_vHUE5YK2UsRig>
    <xmx:WgzoZlWx7-E5nqNKV2FEpRFCdl5491a747AL3eDFDAvG2e3Y5sDrDQ>
    <xmx:WgzoZoN7oz0d9O8O8O4FhXbfeK9lvC0e7oB-MYvTc5MxuMoDArUO3A>
    <xmx:WgzoZk3a9AjGruMA-cnT-MWV7NzdotSlDrkWJJkKwa9eYrtocvRTLw>
    <xmx:WgzoZkEDJV-69CP0K2b_b1jQQ1QggtPysXPwUjOlN7y-kN5nx_8QUJLI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 06:45:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d995b39f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 10:45:24 +0000 (UTC)
Date: Mon, 16 Sep 2024 12:45:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/9] finalize_object_file(): implement collision check
Message-ID: <ZugMUv1xbnjYH-el@pks.im>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1725651952.git.me@ttaylorr.com>
 <0feee5d1d4fc1e0aa1ca5d98f2f404ecdbb2f6b6.1725651952.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0feee5d1d4fc1e0aa1ca5d98f2f404ecdbb2f6b6.1725651952.git.me@ttaylorr.com>

On Fri, Sep 06, 2024 at 03:46:12PM -0400, Taylor Blau wrote:
> diff --git a/object-file.c b/object-file.c
> index 54a82a5f7a0..85f91516429 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1899,6 +1899,57 @@ static void write_object_file_prepare_literally(const struct git_hash_algo *algo
>  	hash_object_body(algo, &c, buf, len, oid, hdr, hdrlen);
>  }
>  
> +static int check_collision(const char *filename_a, const char *filename_b)
> +{
> +	char buf_a[4096], buf_b[4096];
> +	int fd_a = -1, fd_b = -1;
> +	int ret = 0;
> +
> +	fd_a = open(filename_a, O_RDONLY);
> +	if (fd_a < 0) {
> +		ret = error_errno(_("unable to open %s"), filename_a);
> +		goto out;
> +	}
> +
> +	fd_b = open(filename_b, O_RDONLY);
> +	if (fd_b < 0) {
> +		ret = error_errno(_("unable to open %s"), filename_b);
> +		goto out;
> +	}
> +
> +	while (1) {
> +		ssize_t sz_a, sz_b;
> +
> +		sz_a = read_in_full(fd_a, buf_a, sizeof(buf_a));
> +		if (sz_a < 0) {
> +			ret = error_errno(_("unable to read %s"), filename_a);
> +			goto out;
> +		}
> +
> +		sz_b = read_in_full(fd_b, buf_b, sizeof(buf_b));
> +		if (sz_b < 0) {
> +			ret = error_errno(_("unable to read %s"), filename_b);
> +			goto out;
> +		}
> +
> +		if (sz_a != sz_b || memcmp(buf_a, buf_b, sz_a)) {
> +			ret = error(_("files '%s' and '%s' differ in contents"),
> +				    filename_a, filename_b);
> +			goto out;
> +		}
> +
> +		if (sz_a < sizeof(buf_a))
> +			break;
> +	}
> +
> +out:
> +	if (fd_a > -1)
> +		close(fd_a);
> +	if (fd_b > -1)
> +		close(fd_b);
> +	return ret;
> +}
> +
>  /*
>   * Move the just written object into its final resting place.
>   */

This function compares the exact contents, but isn't that wrong? The
contents may differ even though the object is the same because the
object hash is derived from the uncompressed data, whereas we store
compressed data on disk.

So this might trigger when you have different zlib versions, but also if
you configure core.compression differently.

Patrick
