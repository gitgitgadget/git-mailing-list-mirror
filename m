Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C134F13775E
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 06:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729663537; cv=none; b=T3bQRy+2wBnLfzM+te8DnsMzXVf/nPayKr7QzhdWNGIHBc0Vh9XRk+1zuxdiRnmDZUvEP+ldlMFc43SPSHkDSBQr0tUWAPNqGGpa3biZWBv+d2hm+GoUOpXgZ6zmW3+PCLyVFa6zTLeiFKY3kI+UIkZZOKxNz2YYqkehvjIzevs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729663537; c=relaxed/simple;
	bh=+qTs7mlUoPobc2FwjwWYLtaDLyft4954ogWtrVt8Mnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqkvrS6ZVL2O/wSafGAS8Iu6deUZDnCe44bvyUkeD+RjBPFQgzibTW4jz6iLLfQrXVi8QP++C1vKd5D3Xo1DcdXauONC/NRG1vhPQXLoFetw1qVaIoQ/gGseJDKidXI2DRBLvYYVbvFGCTMeR2rv6bCFHED+tjKyLJaEQnnlzYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uRjvzKNS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lyWuhdgd; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uRjvzKNS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lyWuhdgd"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id C8C73138024F;
	Wed, 23 Oct 2024 02:05:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 23 Oct 2024 02:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729663533; x=1729749933; bh=8lhLDtHSQP
	YZjX3ufXyaFT5lMQ8tb84Xw/PL6Lx9aE4=; b=uRjvzKNS1yvHDNnsgFF6AdQNw4
	knadkB0KVxKEFZsU5ZytRsBImY0xwfogTG31gO/TnbbUY2b6/YTD5f8j/A0pYT67
	BubMuB/Keiyl2jeJcl8VYHIciBBn7Hp/mOllryrLeSKmWHmCmOYAhin7kl7dUm86
	5phkrO2LbPdEnINp3GxnX3HSQMeZn5qggtqKCR/W375LiCnFyW4WS7FllOuUTXWx
	D9jIDeNjKy0icno2lgJN7+AXOjYKQcR1cVTvauA+g8MvgsZZW3I3cCJeI9O7P+30
	M87A9pGB/l4ynZRceLlE6G7VOcvC1wFxuZtU0Aekaj1CKCYb4QIXFnGa0rMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729663533; x=1729749933; bh=8lhLDtHSQPYZjX3ufXyaFT5lMQ8t
	b84Xw/PL6Lx9aE4=; b=lyWuhdgdPd8keC22uMMfA4KYJbekmZ5WscEV7ssYIso3
	G+VzNEp62jhi5zUI8IVLjiNfFyngvzP8OOch6R6PwHYoU0ZXCoI6888NGp2gXt+I
	9QkSmOaO2Q2VwS3v8s+vwehwZyYhGcPW9Ianm5L0ucgb5vxdG1c+K/04QQ/yhtrC
	ccHy4DqIbA7OP4ZtH5qgxOZpUGEFvp24RpCxQTRdXZlR1474RZt45UWJhaKsNS6F
	ILWhZF0OVf+fI6XUKN/Mlbg/HB5moYEWyPYq8jG195dkXxiM47Jx4+3OFw19oO8X
	MziV/gGnRdL+PIbaL1PNvLkT/HIV0a1BKpi9ItT+jw==
X-ME-Sender: <xms:LZIYZ71sAlxIH4CdxdMHhZugZUoQDpWm7PVfcTVu64KWOfjMIJ5KuQ>
    <xme:LZIYZ6E27MZVQECe1fxu7AwHZw2JhS0QSqClNsS1NVgil58yMSdRphd0lqp4SyTbE
    ZKZt58g0jVTAt0yGw>
X-ME-Received: <xmr:LZIYZ75AdN2OTHzUAcwUrFn572VNQ2aYa8OeOWV7xMmgqpAA1_qydw-ULZftZEG8nBpVt528Lo9itjQqQknPgQ6OdMvgZWjWJZ3_LTpD0Vq4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeiiedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtgho
    mhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LZIYZw2xtXRkHlHRWTRoancgYvUzlGB5xKaJ0tLbsNglgn-Zrst5Gw>
    <xmx:LZIYZ-HUragBuU4-ty0l9EemY7iR3Bzwp723xmbjjSf_P0Hit3sW9w>
    <xmx:LZIYZx9mmN1xwKqfXn1ZVXmu8XK2q7h6iD1rZr7VXoq703vp9ki2-w>
    <xmx:LZIYZ7nm1L6Mkw4xsDHeIQ0Wjdf-LWuNiQbvwmhgbm1FnJKvxQX5-A>
    <xmx:LZIYZ6gzbWm_ev8EBdeIul7CpbHCCPD6UJy8u1-Ia-xukkLZVau1TLmi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 02:05:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 72b91544 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Oct 2024 06:03:59 +0000 (UTC)
Date: Wed, 23 Oct 2024 08:05:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH v4 3/3] imap: replace atoi() with strtol_i() for
 UIDVALIDITY and UIDNEXT parsing
Message-ID: <ZxiSIem-Gptk6Omi@pks.im>
References: <pull.1810.v3.git.git.1729574624.gitgitgadget@gmail.com>
 <pull.1810.v4.git.git.1729634937.gitgitgadget@gmail.com>
 <8982dca646db72f903bd4c20416d6118da1c210c.1729634938.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8982dca646db72f903bd4c20416d6118da1c210c.1729634938.git.gitgitgadget@gmail.com>

On Tue, Oct 22, 2024 at 10:08:57PM +0000, Usman Akinyemi via GitGitGadget wrote:
> @@ -686,8 +686,8 @@ static int parse_response_code(struct imap_store *ctx, struct imap_cmd_cb *cb,
>  		for (; isspace((unsigned char)*p); p++);
>  		fprintf(stderr, "*** IMAP ALERT *** %s\n", p);
>  	} else if (cb && cb->ctx && !strcmp("APPENDUID", arg)) {
> -		if (!(arg = next_arg(&s)) || !(ctx->uidvalidity = atoi(arg)) ||
> -		    !(arg = next_arg(&s)) || !(*(int *)cb->ctx = atoi(arg))) {
> +		if (!(arg = next_arg(&s)) || (strtol_i(arg, 10, &ctx->uidvalidity) || !ctx->uidvalidity) ||
> +			!(arg = next_arg(&s)) || (strtol_i(arg, 10, (int *)cb->ctx) || !cb->ctx)) {
>  			fprintf(stderr, "IMAP error: malformed APPENDUID status\n");
>  			return RESP_BAD;
>  		}

Two last nits from my side, sorry that I didn't spot these earlier:

  - The second line is indented incorrectly. When you have a multi-line
    condition, subsequent lines should align with the opening brace like
    this:

	if (something_something ||
	    something_else)
		frobnicate();

  - The braces around `(strtol_i() || !ctx->uidvalidity)` are a bit
    confusing and unnecessary.

Other than that I'm happy with this series, thanks!

Patrick
