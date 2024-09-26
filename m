Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE3976410
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358623; cv=none; b=oT3PUew+TMJMMLPDH/q4CrdfPWsYusyXb/4TU7MBMKAfWgF8wga8ad73IDPZAZPhXbQx8MWemj5rD1i0w/L3G1OS/LaJqti5YM9e6NMmbJY2S3OURMePHyet6saZwn6gs+hF0DMiFhwp3WPsTz/rLPNrYqcdz2HxjJizPIsYImQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358623; c=relaxed/simple;
	bh=XaiZKeVDP8kasXiGkOLC6Smu2SvqhjqwpJnqM6jezw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDwZWhTvkp9Z2F7yD3n6FfmN1AnX9dHe80yzU3Z+cYBszZjqrzWn6p0QblWnhC0irmaByZbaz4OSMpmPQvUCcUBgahYykQr/n13+mXSv59Z24sg54xOEwGvaDwwaYzDI8i1hOZrGRpmqG88J70o+HUDazYSlv3yy6j8q9z/qnW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SyjPopPv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b55i2f/H; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SyjPopPv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b55i2f/H"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id ACD091380176;
	Thu, 26 Sep 2024 09:50:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 26 Sep 2024 09:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727358621; x=1727445021; bh=YkXuUHr6Ps
	i2YSWgwscva+Oeo+VQRsPg3Gb71TpJlvE=; b=SyjPopPv9yPi4LN8u3xNLJYuqz
	DxM4XL6iXwpQp7P1+7CsfxFKnkKAfDgEXR0vx8gjai3Ve+OL++7BaUTPaVx6afaz
	CIxyNCl97kHSBGvqniRGZJaYewSP3ySs2z/wcvW9bdWQ4rOXDpqhGpNQexsa+d1r
	qKbqlQZm1FgifSmKtTG+uCW0gnWxjTAM8sNiMWG1lYtFBGgaDAZkkXoObg+Nqg3i
	+I9C4eujWmDGt6RCl/gDPOpzfDzypYnn9QNgU9Kf03yy6I0SNMlR+4G1zQQKeZ7V
	i/te45giUTM/Q4Ouzx3pt4n6ONLY0ZG8AsHG6JVt/zforEd9vDMli0tQ9QVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727358621; x=1727445021; bh=YkXuUHr6Psi2YSWgwscva+Oeo+VQ
	RsPg3Gb71TpJlvE=; b=b55i2f/H1BT6o7IYtsc7rkLwrPpOJzDzz6q+RLDvyibJ
	UuG3nIj4WDB0r7Du8n53TiM8SfWrbrKI37A3rKwdRbRDEvyNk2ylN/mJcRpJ5auY
	fI8jnInqtsfmcje20WvdpbAsYerCw/zd9mY0FA0giog8KN5OWNrz2pNQWkmnZYo6
	PEbCKZpO2Iqxgz7Cg/mg3Zhk5YSztM4CmotrtZPLm2WfX3xTo08bqcNTwY9gd1sP
	7YwKPMXE4WFCp6hydAYFamkFgf8+9k+jwurcLWST8SOhWh4q4K9Uzdu8X4CWtdTJ
	MUgTkcu9g84eFNOZAoEVC/pqElHNTmupQB8KbwJSsg==
X-ME-Sender: <xms:nWb1ZnT1SZKd3RYllTwhzp3JQez1NFE6tOuSS-q0waaVnSf-D54vzw>
    <xme:nWb1ZozW6eJFrT2AFBvRIpqUYEcfyDbmVaDq0pabkxxQldUga1C4YrLrJZczPDpEN
    jai4DGQt3n00VTPhw>
X-ME-Received: <xmr:nWb1Zs15wtzhD7MoXk2In2n9HAy7tNk2tjg_nwTwgM0PcsSNA7g2XBxIa2OKLpvGSH7TnDXy46FITVt7SW3dVhnLG9od6Q_0ct9spfGzai32gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nWb1ZnB2GwyzhcSiAgpaz8tZ-xW-KOzv0SJgHKq2C-C0B1VdNOe-mw>
    <xmx:nWb1ZgjSnV9uB1Ol-9OHqpCiwVUlodgfmM2RGapDSA1gvp6EWcXhzg>
    <xmx:nWb1Zro5LJEYfPu95Zwi9zWEJ_cu2uJxqIrsPy__vVD8mAc2-vnzOA>
    <xmx:nWb1ZrhBx4E6FJYJuSbqYIwO5E_UMAUlypYio01ucdlHIgoehEdlRw>
    <xmx:nWb1ZjsYvmg0bE_UK_sk16R-As7x-v6LMlcqk_xl42HKvZgXyYDNp8w->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 09:50:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 52caa3e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 13:49:43 +0000 (UTC)
Date: Thu, 26 Sep 2024 15:50:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 14/28] http: fix leak of http_object_request struct
Message-ID: <ZvVmmV0nYq_cEnj3@pks.im>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
 <20240924220109.GN1143820@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924220109.GN1143820@coredump.intra.peff.net>

On Tue, Sep 24, 2024 at 06:01:09PM -0400, Jeff King wrote:
> The new_http_object_request() function allocates a struct on the heap,
> along with some fields inside the struct. But the matching function to
> clean it up, release_http_object_request(), only frees the interior
> fields without freeing the struct itself, causing a leak.

Oh yeah, I remember staring at this code and being completely confused
as to how this all works.

> diff --git a/http.c b/http.c
> index cc136408c0..d0242ffb50 100644
> --- a/http.c
> +++ b/http.c
> @@ -2816,15 +2816,17 @@ int finish_http_object_request(struct http_object_request *freq)
>  	return freq->rename;
>  }
>  
> -void abort_http_object_request(struct http_object_request *freq)
> +void abort_http_object_request(struct http_object_request **freq_p)
>  {
> +	struct http_object_request *freq = *freq_p;
>  	unlink_or_warn(freq->tmpfile.buf);
>  
> -	release_http_object_request(freq);
> +	release_http_object_request(freq_p);
>  }
>  
> -void release_http_object_request(struct http_object_request *freq)
> +void release_http_object_request(struct http_object_request **freq_p)
>  {
> +	struct http_object_request *freq = *freq_p;
>  	if (freq->localfile != -1) {
>  		close(freq->localfile);
>  		freq->localfile = -1;
> @@ -2838,4 +2840,7 @@ void release_http_object_request(struct http_object_request *freq)
>  	}
>  	curl_slist_free_all(freq->headers);
>  	strbuf_release(&freq->tmpfile);
> +
> +	free(freq);
> +	*freq_p = NULL;
>  }

Okay, looks simple enough. But I found the whole code in "http.c" to be
quite... elusive, so I had a hard time finding my way.

Patrick
