Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D971C6B2
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358604; cv=none; b=FrpTRma20TxF9mwOakMs67kDoSABUVjsB5bpQB21G739boWVoMiNHuVNk2Aprm7owgtl38hvn8Pv20zNupb/J6ujSDskJQruwgvtBZOWyYkNUr+VZF/Ydo46XfczrvDEsZs7mV9Gbu9cfPlqrvzJlfOOVYvOtZOg9QPE/x/yt0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358604; c=relaxed/simple;
	bh=sMOEIq5btTOciS3wS2fYdsgrnKZ5MMlmx//XSwOBld8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q595idDw2mS76RIcGpVLAtRGpmQxq0xkv0rpwH7if1pdw/oxNJd/7S34Cxvq/JiEOX7Zx/08VC+sMtCuR2w6ei21eThiOUv55hUw17z8pzEKNF0J78iJmfdD8YngQQGoIJwuVJnOEME9YYg4Xe1eQNO4K0YOdt5cafoDXvdyRHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W/43lVHz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EVY1oOfA; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W/43lVHz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EVY1oOfA"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 2FBE913801D7;
	Thu, 26 Sep 2024 09:50:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 26 Sep 2024 09:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727358601; x=1727445001; bh=UqbOn2gTPU
	ewTCEoShvBOmEVSJF+QTsgtfp5lpTS+W4=; b=W/43lVHzo+8h02deb/0cBNF3W7
	mbWihKcrYyOTsKRdI5RTwul+a1OHtYeIIgiq03t0yOCcOFfdwCeBQvS6RYmqa0Hv
	vLrE1aKLJLjBYNTqBtcIdfwOhNa7Wh45LLnUI+Q1AM/zS+QpNhke+dDZydylVjSa
	2xOGBERl+s2XrRX0QdfEo7hyg1tdYP3viIZ74NGW92mOqumLI19UMDD3O2bJdkQZ
	UmxmdG0q/m11MJvLtMCWUH+/ntadwwXKXgmKrh/AokLtieAzEi/ph93a84yJ0W01
	mpZYyfqPpayV3YkEjf1EloSoAUqDaW9BnCgygQm6m8TQXAHIG+wM1PMzl7Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727358601; x=1727445001; bh=UqbOn2gTPUewTCEoShvBOmEVSJF+
	QTsgtfp5lpTS+W4=; b=EVY1oOfAQVgvTbdN/NmF6BwTqCAgsMpBnT+5eYgKJx50
	4gLDPG2E+9AXcwl98RQMtmMECTYnm79Ggc+w6xBU5vAoazlX3mUWKKW3Ks066IFd
	egt8NQqT2/KchAefPLFwfJt3Q4toLH//im6dM4V9G9RuLciAYPPMGtvRZtrcoZc7
	HPPWjIx5qVIckTqh2vNpEb789nMHyhaCii/JTg6neq0/xC3zXT8BBQ/5rs6Jm5VW
	v7PxT8DecDg/8hYRCrhgbw/JPHWOX7ZhGjnTe84CsOlPthwSqSffsYXdEeOuAsnA
	nS4lutYihz10jPgdtbY3kdzWOTL0JzfqQUdjkcJgBA==
X-ME-Sender: <xms:iGb1ZnJFFvNb3HZZfHX45JUyyV6E_t9ZOp4L3plzoBhJL4GXss-K-w>
    <xme:iGb1ZrIZ7qu6mnpwmAiqaR-uBgCgeB_uWa8Aq14fbYcFufZa8IiAof7XVmT2K6Utl
    Tau8xBVXj1ogxnigg>
X-ME-Received: <xmr:iGb1Zvs07yLTq8Jy93Zmk8Q3jBf2nAAGLYfHaUARM-6sFtapCqtgPiWE18pC90AonUXZB45v66lBpO06EZP2ghjqhIg9pXyd7tPHB36tw_khIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:iWb1ZgZ9uo9cWFrptdWXMN2BKUW6WWHKhIx00-i9WTq3VbI6XSeFPg>
    <xmx:iWb1ZuZjhnDTOhJGHLETTCUuLtPyFIsQRVf93D_uKwZI9DyH4KFZgw>
    <xmx:iWb1ZkDJ57PD_Lm_2Opci9hNn1ktkGpGLhrfre5UmTDmS-EMobOvaQ>
    <xmx:iWb1ZsbBHVKAtpyQtK7L12R9y7-BuOHeB9cDaaw49HlFmC7_CSiK_w>
    <xmx:iWb1ZtnHZwDxcHSu9aL0mRhBs9eqGJrdGZpa8FEzYzPtvWz_jcZbPDP->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 09:50:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 08240435 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 13:49:20 +0000 (UTC)
Date: Thu, 26 Sep 2024 15:49:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/28] connect: clear child process before freeing in
 diagnostic mode
Message-ID: <ZvVmeygAJ3GhhQoC@pks.im>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
 <20240924215124.GD1143820@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924215124.GD1143820@coredump.intra.peff.net>

On Tue, Sep 24, 2024 at 05:51:24PM -0400, Jeff King wrote:
> The git_connect() function has a special CONNECT_DIAG_URL mode, where we
> stop short of actually connecting to the other side and just print some
> parsing details. For URLs that require a child process (like ssh), we
> free() the child_process struct but forget to clear it, leaking the
> strings we stuffed into its "env" list.
> 
> This leak is triggered many times in t5500, which uses "fetch-pack
> --diag-url", but we're not yet ready to mark it as leak-free.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  connect.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/connect.c b/connect.c
> index 6829ab3974..58f53d8dcb 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -1485,6 +1485,7 @@ struct child_process *git_connect(int fd[2], const char *url,
>  
>  				free(hostandport);
>  				free(path);
> +				child_process_clear(conn);
>  				free(conn);
>  				strbuf_release(&cmd);
>  				return NULL;

There's only a single exit path in this function that ends up discarding
the `struct child_process`, so this looks good to me.

Patrick
