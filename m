Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9115C13BC0E
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358621; cv=none; b=BIMQsd2DLZpNRFrZLQmLnpAoKT6KLACwtgBVmH6gWOvZ4DpHw07ZFJc+6EzTxeqXNYGwelHqqb5KMCB2hvbuieEZ7E4Q6w4yvjbFEnkJ/oKAGsFooGnRstad18IvDufu/BL/tV3NqR0LLTY+paNnTW0ARGD+ymwBPwwLu3ycMCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358621; c=relaxed/simple;
	bh=aYY0VY4dpfikmNP9WxY6D39mRWzwvbO7MtxjXrBlYM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOfkmUEf0QR3F+L8N5vjoiWkGxArsHAFmnrtihoR01Vkku6Uc0xPH1LGdyI7dy25XTls342rK3kT+yvevu2TYXdt7KxNHy5nCIYDYRKkfNt6vlldxpvaM0PQfBvMSwiu3AYqUKabRN19Yn6lwRxHLSnbq6j8VLINeHqLh8QaeAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JPmbwdSn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WbGl2svc; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JPmbwdSn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WbGl2svc"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A751E1380176;
	Thu, 26 Sep 2024 09:50:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 26 Sep 2024 09:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727358618; x=1727445018; bh=qgb3YLV5ge
	sU/ejCIGb5IzOD/xU+riNaVZG2KwoZElg=; b=JPmbwdSnSC8MFhbzY+obiE5vGs
	9jFlWICqycinGHd2S33z1X/I2y968H3tf5CxSQujyiqIJxAMI7O40XAw6AKDljp1
	gpE4mG9ASpAx7xD/tC/RzRZzk33fmMovtkVd96BqMpu5moBlAlWTXvbZV+LznHVK
	hwJDemUtu30R725PB+f4GC84yqHsF4MCCSneGtn/hJm+Wh0fwqMC/y2GmO+dbzFh
	klnOBihMmkzwCGd/2msilyte9PTNMFhcbUcgwrHPEfb8JHHXdOKlvos1PIX5Bqkr
	5P8PqmlRNh+pVt52FfF7ToPt64ft5eCtUDQlQxrpydarjwHoCuRI1IDkQSCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727358618; x=1727445018; bh=qgb3YLV5gesU/ejCIGb5IzOD/xU+
	riNaVZG2KwoZElg=; b=WbGl2svcyFbeEUE0ZZ8BqGvgHRJIWdBHoyzVUb/bEeYW
	mf/Ed7xP58oGqM2ArxVfJjSiRtGLYyYHsVcDlLdmLdFKyv/wlTvs4GfJfoz8jriU
	anMMOJ48Cp6bVF8Py7UNqj0IEzggZ1ZKh+KEQIQ1H5j7Ofkwe6ww3QdJnuqHD+zE
	Y/UODiln1hRfAu4i74qHnX5ORxahdpU9+4AIAIaLuap8KdGRRAegtPk/Hn9ECA2z
	eE4dHjaCs66XjYEZCmnMMaOZlNzJUQEGherizsKkAnX8yOpDBn/YNKA/Qj2rFTWD
	KbDMVB71EfDGuC3m1AQJvyJLLs2ws4vxbcE2Mncqjw==
X-ME-Sender: <xms:mmb1Zk_snctCYVSuVGMEfd6233FBCnHuX8hl0UFKBEwLdLg5Rhmvqg>
    <xme:mmb1ZsuzVjdEPqERixCdYtJm_rmULN-6zLZ3Q_hkcS51R-9uGjr2cAFsc6NULEZAN
    dDNBrTM5zzm9oZKzA>
X-ME-Received: <xmr:mmb1ZqBH9zXjVeQYBUJoPiu6kFKxVWJfZySfIABO9U3ukqGQxo70EeJYBAbWKSC4mh2E_YVsac4kfC7rfdyhb21LiRgoK_IzCZeYVj-SWrhJfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mmb1ZkerBjHUd3JX7SEwX7OMR4Hps9Is5bKT6_a7obmJYwFAhMjvNQ>
    <xmx:mmb1ZpN7cJFN1CX7B01VuEfGX5YBNYuOL9ggSfFzkNao-DIucgFqyg>
    <xmx:mmb1ZulLVeIKA6MNQ2T2CsVwnu9Dod475-xkc7QhYn1adp6fSLBovw>
    <xmx:mmb1Zrs57ntEZFwP7PX_OwU56uxLaRsA-sHeiOYvMzf0KZA54W3GaQ>
    <xmx:mmb1ZiZISoIFj2lu7y0xvrgkyJa5Sk6aE-p000KJWDhHQ9qf0udJXxTk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 09:50:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5d48e0e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 13:49:39 +0000 (UTC)
Date: Thu, 26 Sep 2024 15:50:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/28] transport-helper: fix strbuf leak in
 push_refs_with_push()
Message-ID: <ZvVmllrUvOC3pGJy@pks.im>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
 <20240924215634.GI1143820@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924215634.GI1143820@coredump.intra.peff.net>

On Tue, Sep 24, 2024 at 05:56:34PM -0400, Jeff King wrote:
> diff --git a/transport-helper.c b/transport-helper.c
> index c688967b8c..9c8abd8eca 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -1023,6 +1023,7 @@ static int push_refs_with_push(struct transport *transport,
>  			if (atomic) {
>  				reject_atomic_push(remote_refs, mirror);
>  				string_list_clear(&cas_options, 0);
> +				strbuf_release(&buf);
>  				return 0;
>  			} else
>  				continue;

What's not visible here is that a few lines further down we have another
early return where we don't clear `buf`. But that exit is conditioned on
`buf.len == 0`, and given that we never `strbuf_reset()` the buffer we
know that `buf.len == 0` only when it hasn't ever be allocated.

So this LGTM.

Patrick
