Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8D33B47FC
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775642681; cv=none; b=jgNmNAd9rsRixJ2bYQPYJ8YaPb6chl6T52gHdDEPseRhW/HFUNAkhXJdr6nLByqJXFNRANm9vVUXlXcFuBV+1TSoHf3QpCjJOZXqc+NaSknB6v4K8nEkXjAF0bZ+aAH/8QpebyGp35CO4ZIci8tRziKGJ8kwkQAPaVOZySPhoeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775642681; c=relaxed/simple;
	bh=amXNuLhfYf93hCsDWZDdfolI97Pfip7bujrcvce89hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWH2gE3lppe0XOs8/Pg/5dy9EozQX6kWDLJMhJGpXP5+2XR0XiZmfiB0rb7oksW05ZapnYDZ3gUYlqCCz+Ln+KT30YxUKS7r/mwrgC4TvG+WCmhs0+9Wb8avsHIlemFEZWkTR+j6SMCGjfynhW/un9qDpbCV0h1tG1S1XUoYFwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=zKqtz8KW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=je9eFfpo; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zKqtz8KW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="je9eFfpo"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 543D8EC0447;
	Wed,  8 Apr 2026 06:04:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 08 Apr 2026 06:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775642669; x=1775729069; bh=VxvXgOO6VT
	TZSahu8htr8KZNQsDlnP2I+WTU1ovBz6M=; b=zKqtz8KWLSD6f7yVgJZvW9/gAs
	A7RsGE3CbIcbwM3+tHlWzUhcEY96sIcnTigLmaZxeTN2rD26pf7nz2L56NtQGrkh
	BE0sGG2vrXFkQ5zDKCIGaAxJOUVJgB7t9TuZXJF5b+CcvXrCanFDOwb7fAyJRTtu
	MIUH0+NzisESB5yRWh6V0MKDK+bXI0BLslLkW764JHGeQk4vzu9REemsxCiQpflD
	rpU3CcMRwpsjsWCp46tYGM7yXnCk9lcKZp/rPwjoU1WuPUXI/vQwlWmiSs01MnxV
	GpzsgCrawcGI22NxfS07FugR/2MD/QHotYgoK4EpDa0vL7ceuNdNsarSB1Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775642669; x=1775729069; bh=VxvXgOO6VTTZSahu8htr8KZNQsDlnP2I+WT
	U1ovBz6M=; b=je9eFfpo7k76ho4wUFlrcoyH1kOUuEMbenQB/vwt5FpvTA0zTUr
	FClBAGE9np6ZCJIU5g0AyTqOufMGv21fh3KhtbEKckUmuFN/tf8Mz81MkeROVuAH
	mR1MRUetQZQ5WxwhKJ4wevp0YCHoIDLijDoBIwMSIzA49MkiFsmtGOvN/jvY3UlO
	r+D5JJJMTvPu39SX4JJ/TxjQWQQiDHS0Pd2TsTkcEXGWGR3Eak+9qJFS734VuHYq
	LQBdHIcJ1x5uZXnk08H8ZfA4QFo94hXd4miNNOZ1y1wueCEFVndTTfvGHxQY5dyJ
	MqN7ghyhX9htwq5BcvGLaOspRiGYSP0uiVA==
X-ME-Sender: <xms:LCjWaRrYtcbhDMdDHC9FPoTZYn3-1t_AMW_66GHuOr6g1fNpmgA_zA>
    <xme:LCjWabFWXnFT6oAMkSXfvuz26kY4kS3zGzeo6E6qeZuiIpE5sFt8ZS5ztP7H3iVca
    BchdZHB7oVg-UYLknEamZAasEaIBsvugRTKVVk4ZdxiS1hfzRHeCA>
X-ME-Received: <xmr:LCjWabn3t6SAGHW-e_a0Q-HHX9iMhgtnc_sLNXDkkENlhbaMMQKpBTwpONSY2o8yzjrN-bMNtgBkNqiD3ziA3g7qzhfvKHpWcJhd2G0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvfedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evheeileetkeeiffeludefkefgueefgeeitdeuiefhvdelvddtveeiteevudffjeenucff
    ohhmrghinhephhhtthhpfhhrohhmrghsvghrvhgvrhifihhthhhmihhstghonhhfihhguh
    hrvggusghunhgulhgvqdhurhhishdrihhtnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfe
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:LCjWaWkzOyBAQqyjI7X-yQc9DMncd8hsFJhWnIdvLOWHLNuJ6lIN7w>
    <xmx:LCjWaUu1ksYouCOtvi14GIjdL52bII5syeOCU19r7MX7scSgucg9Fg>
    <xmx:LCjWaRkUDpGI7ALshqWXtli-cvVFYZxB_moXtYPnjLtjn6ixZM9c-A>
    <xmx:LCjWaXsO7AvquNYafOMaCBRJY99fE0SWopy5Qdul3o9ZyFO9cVCm0g>
    <xmx:LSjWaTHoBwHxMMoEIc0X32JqT8sdOHiNP1d4L5rNXS5g0WSpPSKd7Qud>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 06:04:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 52400373 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Apr 2026 10:04:26 +0000 (UTC)
Date: Wed, 8 Apr 2026 12:04:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH] bundle-uri: drain remaining response on invalid
 bundle-uri lines
Message-ID: <adYoJxHqoJ7c6Hin@pks.im>
References: <20260408-toon-bundle-uri-no-uri-v1-1-d4a0e3937eba@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408-toon-bundle-uri-no-uri-v1-1-d4a0e3937eba@iotcl.com>

On Wed, Apr 08, 2026 at 10:58:28AM +0200, Toon Claes wrote:
> This patch is a leftover from [1]. In that series I've submitted two
> patches. Because that series was submitted a long time ago, I'm
> submitting this as a new series.
> 
> The first patch is in meantime superseded by [2], and thus is dropped
> from this series.
> 
> The second patch fixes a misleading "fatal: expected 'packfile'" error
> that occurs when cloning over HTTP from a server with misconfigured
> bundle-URIs. It is modified to address Junio's concerns[3]:
> 
> > I tend to agree.  Instead of papering over a misconfiguration, it
> > would be better to let the users know, so they have a chance to
> > report and/or correct such a misconfiguration.
> 
> To reiterate, in the previous series I changed the error() to a
> warning() and Justin and Junio both didn't like this. In this series I
> didn't remove the error(), but instead I'm ensuring the read buffer is
> flushed before get_remote_bundle_uri() exits. This leaves a clean state
> behind and clone can continue. (more details in the commit message).
> 
> In reply to that other series, Justin also insisted to implement a
> server-side fix when bundles are misconfigured. I'm currently on the
> fence about this, because I don't have a good idea how to address this.
> I see a few options:
> 
>  - Emit a warning on server-side: Personally I don't think this is a
>    good idea because this might just end up in the logs somewhere, and
>    no one might ever read them and they would just make the logs
>    explode.
> 
>  - Exit the upload-pack process: I like this even less. Bundle-URIs are
>    considered to be optional by design. Breaking clone operations
>    because of a misconfiguration of something optional is too drastic.
> 
>  - On the client-side, read the return value of
>    `transport_get_remote_bundle_uri()` and exit the clone in case of
>    error: This would make the user a lot more aware of the error, and
>    that would encourage the user to inform the server admin to fix the
>    issue. But that breaks their clone, and they cannot continue doing
>    whatever they wanted to do. Their only option to continue is to
>    disable the config transfer.bundleURI, but that's cumbersome.
> 
> Because bundle-URIs are optional by design, I believe the changes in
> this series are sufficient. Also, the series [2] takes a similar
> approach: have the client gracefully continue in case of misconfigured
> bundles.

This makes sense. The only thing that I'm wondering about is whether we
now "paper over" such issues in all cases. I think it's totally fine for
us to just continue whenever bundle URIs are configured as optional, but
not in the case where the user explicitly asks us to use them.

For example, the user can also explicitly request bundle URIs by saying
`git clone --bundle-uri=...`, and if the configured bundle URI is
invalid due to whatever reason we should bail. We don't have any other
explicit toggle in git-clone(1) to the best of my knowledge, but if
there was I would claim that any such toggle should also cause us to
die.

I _think_ that's the case already with your patch series, but it would
be fine to make that destinction in the commit message and maybe add a
test that demonstrates that we die when configured explicitly.

> diff --git a/connect.c b/connect.c
> index a02583a102..e323455d3b 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -536,10 +536,14 @@ int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
>  		const char *line = reader->line;
>  		line_nr++;
>  
> +		/* Do not parse if an error was encountered */
> +		if (err)
> +			continue;

Let's document why we don't bail out of the loop immediately.

> diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
> index 7a0943bd36..514cc881b6 100755
> --- a/t/t5558-clone-bundle-uri.sh
> +++ b/t/t5558-clone-bundle-uri.sh
> @@ -1302,6 +1302,31 @@ test_expect_success 'bundles with newline in target path are rejected' '
>  	test_path_is_missing escape
>  '
>  
> +test_expect_success 'bundles advertised with missing URI' '
> +	git clone --no-local --mirror clone-from \
> +		"$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" config uploadpack.advertiseBundleURIs true &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" config bundle.version 1 &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" config bundle.mode all &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/no-uri.git" config bundle.bundle-1.creationToken 1 &&
> +
> +	git -c transfer.bundleURI=true clone \
> +		"$HTTPD_URL/smart/no-uri.git" target-no-uri
> +'
> +
> +test_expect_success 'bundles advertised with empty URI' '
> +	git clone --no-local --mirror clone-from \
> +		"$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config uploadpack.advertiseBundleURIs true &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config bundle.version 1 &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config bundle.mode all &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config bundle.bundle-1.uri "" &&
> +	git -C "$HTTPD_DOCUMENT_ROOT_PATH/empty-uri.git" config bundle.bundle-1.creationToken 1 &&
> +
> +	git -c transfer.bundleURI=true clone \
> +		"$HTTPD_URL/smart/empty-uri.git" target-empty-uri
> +'

Shouldn't these tests also verify that we see the expected error
messages?

Thanks!

Patrick
