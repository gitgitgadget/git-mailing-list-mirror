Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D2E178372
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954513; cv=none; b=VfOmk5cPGub8yydnO5NLRMXXERORhdMYUoB4iU62+CHeCqvTVrvjWIsAsixlZaTlnM/w6fliDvX0gvcC5v+GUYLAs9vE0eZULg2hULIk4jyBkIjbdovjoMJia4UKmfhbZSwZAOA1UO+ORkRyshVV+b284VS6yRQ4hOvQRpDpuDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954513; c=relaxed/simple;
	bh=ZfUVTFIU/kjkZBZed/9d1x9e76//LMIhipQhakasUuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9uM88LoS1wW7AWP2aLBNdYJNF+7SNX5BlwJnAUJ8GO3EDjDHmGnnwaY5b2KiGP3iZIczmX+uRFZLtZENK8owKUwGWuQUaGFxncFyL6kn+F0vW4f6/B+VbaZE1QpgVwT+2K/YjfYXX/fJ80/70Fc2vHWYbPnec6ufexc9Tkt6To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J+BUuf5v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h1vtRcpp; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J+BUuf5v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h1vtRcpp"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id B36AE1380263;
	Tue, 10 Sep 2024 03:48:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 10 Sep 2024 03:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725954510; x=1726040910; bh=9pVDAl2K7C
	aZ0VSsx43JhBhGrGHyIbioAm3fwtk+fUc=; b=J+BUuf5vTznHMUW3xQNUAm8VEC
	Iusl10yPC9qAgfnz6HS5ekEyAewaoG2b7NIOnAbaGk4Z1YCD7Ov8aORgeRGAyNds
	mLX/+3uAAvtllq1xEgg4d+0BT0OKbtdFUdkTOuwZCXoD8/4dUjYfr3MLOTaSH0ns
	BAUjbm54rZ68iiBH2/hc6ZA933r/jtT12sW5VjFT/9CEDpAAaeIJhVvcRwlTda0T
	ykTCEt7MKH9/y8mduTcPtNuOSfZwr/LOQj+5+ZPE0UMk+HHmF/s8awrnZWx20dSI
	k7GL6ZEUTmTyxjXdwSfnJMZQZuu7QKGQdm8UxOd+oR05DQ/TKBsMuKO/Xldw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725954510; x=1726040910; bh=9pVDAl2K7CaZ0VSsx43JhBhGrGHy
	IbioAm3fwtk+fUc=; b=h1vtRcpphLHGffHgjLIszVPUSk7293QaNP/PMz+X65p8
	iDTbyH1svLeCR9eFi4FSa1pACQMLEZXPzPGxGsa0TaabY7HXPqC98J8xEmeU4t4c
	Ii2QS+xzatmBQR2htIuAhzOpis4ei382YuH8VDcH+e9xKkEhFut70yAISqVmHFyY
	hpJ+uwEuc/HZ/r4Qex/hkU3WWj9ldBimz1NH20sqGrETmJZF38wixdfubiM+1f4j
	rbBqrz9V/fjwrGE8wd39+4gsfTdXelSYEY8dt8grXtG5zpQ+ak0qC4q0X8OiwCi6
	kRjh0j5jBlQrUMha4ff5Y8OuPWnbG9poFmuRPiehhg==
X-ME-Sender: <xms:zvnfZp-HzT-rIx927hL_TjCKHJOHtxQicmSFrT0YEk3YuLar4A4K9g>
    <xme:zvnfZtu05QJjw3NdGzEAnyKTpy1ziCLXE86YUBk4L6RXLNUOl28P7cxt3Ysl5Y-yM
    BUaSo9QFHytJvWDew>
X-ME-Received: <xmr:zvnfZnAbjzcvvXKUQP0JjZIG2YqL5tpfH69OO0B0ScBnh3Ck973KG4SvNXNEPXE1U3VkM7ijqdhVhVf7aIYQKsvgXFG54UXe5x2nRnZCsYvRkLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeikedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvrhhitghsuhhnshhhihhnvg
    estghhrghrthgvrhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:zvnfZte6uOpcVMXt04_U392OumRjaz_A3dkrXqF9UpygClNd8okQqA>
    <xmx:zvnfZuN7_NRVIE0J3Wqb30wjBQdUf3QYIiVFrLEsSq8F--jAZ8_w_Q>
    <xmx:zvnfZvlN-RYx2SPaJ-BeqhT1UQbG2gnQZJz5Wq1v5mfXUYZK-mzSWQ>
    <xmx:zvnfZot6XQZbpGhjOIRbt2AS9tgP5hVX4qkBr3aRwYuu_J8KSUvzjw>
    <xmx:zvnfZl3kyeXPLERh9_FcMfy4mY7gkDa_ChjpcPP0jpmAn1nD8oY9qiIA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 03:48:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9d0e6e53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Sep 2024 07:48:22 +0000 (UTC)
Date: Tue, 10 Sep 2024 09:48:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/3] chainlint: make error messages self-explanatory
Message-ID: <Zt_5xyDwG6YE1rFl@pks.im>
References: <20240829091625.41297-1-ericsunshine@charter.net>
 <20240910041013.68948-1-ericsunshine@charter.net>
 <20240910041013.68948-3-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910041013.68948-3-ericsunshine@charter.net>

On Tue, Sep 10, 2024 at 12:10:12AM -0400, Eric Sunshine wrote:
> diff --git a/t/chainlint/arithmetic-expansion.expect b/t/chainlint/arithmetic-expansion.expect
> index 338ecd5861..5677e16cad 100644
> --- a/t/chainlint/arithmetic-expansion.expect
> +++ b/t/chainlint/arithmetic-expansion.expect
> @@ -4,6 +4,6 @@
>  5 	baz
>  6 ) &&
>  7 (
> -8 	bar=$((42 + 1)) ?!AMP?!
> +8 	bar=$((42 + 1)) ?!LINT: missing '&&'?!
>  9 	baz
>  10 )

This looks a lot nicer than both the old state and the first iteration.
I certainly like it! I'm not really able to comment on the Perl code,
which mostly looks like gibberish to me (which isn't your fault). I'll
leave it to others to comment on that.

Patrick
