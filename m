Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4230232D45B
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872539; cv=none; b=cIdUrYGk77xCwIpWbkQmDyIiR/zL4uVZwNuQlAj7RRNemay+uKEbBFBiPKAhHtdaMlrido7j4GklCaBSS9q3iITyGOhlQ393wZe1Eaz+7jvYENFwkrqkoZjYoI+MO219BdE02k7IM5K5TXdfNdXtZwxqb00vAkRNtlfOIwZMVtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872539; c=relaxed/simple;
	bh=C9YzbWckBN55qSuHeNEgGM4xtpdmxkdDRoK9Zmfr5MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uqxm+9bUVQ8+A1Ks6cTuuUyoWkcHgkK5t4WySmQlwu1bNIw04e2oje/iVWH+KngUyLa1kDJCthXISKoQYLnkblJnMzOCOOWG9cBikNwDtw5fuowSsI7PBkg+bn4hRtVOU7vD3VQMc547lI3fPgLAcxMdUTJvT22KYWqEVi/+XS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fTph85BI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b7ZMBdJZ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fTph85BI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b7ZMBdJZ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F50C7A01E8;
	Tue, 16 Dec 2025 03:08:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 16 Dec 2025 03:08:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765872536; x=1765958936; bh=V7XoowtDY2
	8reot0i7KGxRdiDKxjv5TxRCEDnoekWfo=; b=fTph85BIIuPw92ZAMZT1E0Ttkw
	ZXFhUNPPbsC+S/mcJ3uXJClhPSpyH2+O1TRFz3rHcg0jgQusXy7mHlwWs+LDjPsi
	p/IjxAud2V5O7XKUTSODk6t+bQ45fP61AfooIiEmOiAtzOc7kR6gmCIRfKBJsuaH
	7Oa1wkaoWijjxczvPatp73FcMCLXxm+R+80iDbC2Yn5lz8eVG41NvEG0WPj4dmDa
	Ri2/xCJiD21JFviqJTdiZOrE4dTr2qcmHLewH4CeZM9vYzNzHoynBp3LcTYWdUsx
	nFNBhYzRh3RR5oHpeORZq9n9g+tJY7FZs8zOVyvaqoe9yQZ1atMINnDMEzRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765872536; x=1765958936; bh=V7XoowtDY28reot0i7KGxRdiDKxjv5TxRCE
	DnoekWfo=; b=b7ZMBdJZ0IUNTM5ZQ2POXIQ6mvl1zC68AUGrMO37+kNRU4Aqnyk
	4On1cVpO3mN91bnU9cAqlboTMANhq7WNUUwH22ROJ+LujOZ8Tjud839t13nhmfFq
	h3d/15krEAvP+i6mNuqdL5mT+m/fVIrVLiNTG3hWjjgSbj2AS4YmWMxlc0vq9JJ+
	9RyOqb1ZfVDffWqY3ndvB3kW7Pf+mf4b/jYcZU/aqtjSvJcVbp3aYELPnlu86cxo
	GKLsutS1hTiVXC0FZQqI/ZIZ8491gc1ImQb2XDYTevml5980Czx2DYEJX5+Aq+69
	8wqvzVZloIEtyjqAJOKYRjHR1flWNMU20GA==
X-ME-Sender: <xms:mBNBabWxnNaRonMG7miYiegaD0RnYKO7-161vmn-tC34I9Kh8pgq3Q>
    <xme:mBNBaQIvCGkN4YaUMMbOCKSKsbsVS2Kj-pNHaa_Ep_O9z5R9Tt-wnNq2lYlawtpYs
    4gf9-M8gfL2nAWwCYc1ogwTtoMssZ3ZbNzEBlSJVimF_lqBbRL5>
X-ME-Received: <xmr:mBNBab0INpgF2lOEV9uOsD1vau0Spm1etnRIuYZr--myvEooKeg7dPlByXpv7-LlBHqnVEFJAFDovh6Rt2Jz2gkDAhxnEPhDxGbvYv8_tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefleduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    grvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopegvmhhilhihshhhrghffhgv
    rhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhgurghmrgiiihhosehgohhoghhlvg
    drtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgt
    phhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthht
    oheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mBNBadKHjH-BSyiwL76sx58MADK3VX1-4RB_-pxJ2T6lx8D1OKT_gQ>
    <xmx:mBNBaWhYkj5FPg7RYq35s-fOtY0ncNTcyTkyHNFySBo-uqaGujmpsQ>
    <xmx:mBNBadCLn6iOHazf4uQudJMyZDLimI7DzodqxkMqhtH9d1scn9Bi_w>
    <xmx:mBNBaY7QC_t5glg_91NVq73wNxeGLxMWXi2RuPSAF3f2C44py0k7pw>
    <xmx:mBNBafYUy_d7NNSF8SAuEGhGqeRmJe0mYoglrcbefDKP1XqR064gJOBW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 03:08:54 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c4d738ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Dec 2025 08:08:53 +0000 (UTC)
Date: Tue, 16 Dec 2025 09:08:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 10/11] receive-pack: convert update hooks to new API
Message-ID: <aUETkJZe_qCS6ZV0@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251204141535.1986263-1-adrian.ratiu@collabora.com>
 <20251204141535.1986263-11-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204141535.1986263-11-adrian.ratiu@collabora.com>

On Thu, Dec 04, 2025 at 04:15:34PM +0200, Adrian Ratiu wrote:
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index e8ee0e7321..d95df748cd 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -938,31 +938,26 @@ static int run_receive_hook(struct command *commands,
>  	return status;
>  }
>  
> -static int run_update_hook(struct command *cmd)
> +static void hook_output_to_sideband(struct strbuf *output, void *cb_data UNUSED)
>  {
> -	struct child_process proc = CHILD_PROCESS_INIT;
> -	int code;
> -	const char *hook_path = find_hook(the_repository, "update");
> -
> -	if (!hook_path)
> -		return 0;
> +	if (output && output->len)
> +		send_sideband(1, 2, output->buf, output->len, use_sideband);

Nit, not worth a reroll: the buffer shouldn't ever be `NULL`, should it?
Checking for `output->len` does make sense though, as we may receive
empty buffers for keepalives.

Patrick
