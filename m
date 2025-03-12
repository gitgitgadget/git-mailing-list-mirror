Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773171D63C5
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741765851; cv=none; b=JNEQKHrnzTUrZVesGMGbg9PDPG9NBqQWnfTGWBFfOp+aDHjpMPaV9XvjqjG4/YokVC4XDZkTAGhp2zzKe4eNsAy5XvgUAlMl+b/p5Ub46UQqiCyI7IdC3NGlUptyRQVHisdXBvqdZmH8/YCNyBhRVReT+rJUlYoZBERzqYou7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741765851; c=relaxed/simple;
	bh=IO8Zes0hLF3ay9E2OkPrXS1TlX+rJpAIvbxglBsayys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDbR72wxRs41tjunfHjbTxupcfZbWJfmrmflgHPrJxkxAHOnlyNm2ihoE32zjnInk+lTj6rGcjgAWZ8M0vIZm25KBt+X0B53ChGErU0slDoEv0CNGqJqKx38RjUdrnFJwIOkvYfUKWiulBGpUcSPDsjhvIWUN7He9ewUU/E4Vho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B9R3fJp3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=62cDYS5N; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B9R3fJp3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="62cDYS5N"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 8695111402A7;
	Wed, 12 Mar 2025 03:50:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 12 Mar 2025 03:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741765848; x=1741852248; bh=T3ZPchhy/S
	Ghp33WBtX1lKVKaNqL9q0SLXO9tPFBYsc=; b=B9R3fJp3JnLnLhrk2s0Ve7SdcI
	hdy9qhTmYOXKPDZUdDNKnl1EzvUFA5iFvH1wKJVaSea/7u2JPNS8wRam+n3vzrMy
	jXKEmrRsFYaoMJ2YIIdWzjj6eqaVOjXztZm2QgSbpVnWlZvVCx8bswN9lQT2RoZ9
	B7/qzV/M93BIkYem1hak40vBWZJ6VtJa5V6yd4RK4PS/ymPOCYK6GymnBCUi2hw5
	cPMwBspHinmwoobavPwGJ9iGbIgRISglA7utO2VHiyJqgpxwEhQuj9fQvKKoR3g/
	0N+1dxExLoQj37gt0de9ARJuOFwS+rMAD63L2qvKRB/lJbMe/SzPsCjihDSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741765848; x=1741852248; bh=T3ZPchhy/SGhp33WBtX1lKVKaNqL9q0SLXO
	9tPFBYsc=; b=62cDYS5NYWzCMOpOIU2dp6SbH2cHntVK/qQRwujRsp0mG+Ofyyu
	79mLu3Ga3ILUssI7NrJMZBpVTRJ7zKlkiQl3OPYIBGQ/BWjaooQo+rmEhfncGORk
	kJIBXtF81iARhdZdwkE0Fojao0K6bq0VAAn7EFVkUiBoSBir9zTOmrlCZDBAcPVt
	dqzeCGKso6GTzO3NPkp+y1bDIAi9F5FLeyAzrjr7hNDzk90ehqELaWWU5K7CLIan
	doXuJUAhZ3xfKiPiRCZs9BtKaLFiEBYvwbkzB0ks8I/DITdVVRyELqslAvuAbPZf
	Tt2fqgpLSOqqETvfWZeIRxCiWrbctdOw0CA==
X-ME-Sender: <xms:2DzRZ115kwfEClVUH4yi-tnoky7uLBGkyg2u-vvkhlZ236JQXgYfug>
    <xme:2DzRZ8FWhoi3lZ5GtcElW6jCCt5gUINxNYzjWJpATwoCxowyH-VhA7UKl6K-PsZri
    WOjWrQ52Z0CXA4KHQ>
X-ME-Received: <xmr:2DzRZ16ucCLkxoJF8RV6fa-MfLPUTk69FF0_kn8nigIG21TWZkFgWwjt_eIQ54StVbbC2H5SWis4txjr62y3lvkvvW9F9SiVfQ3OU68JhVnYeUJEjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdegheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:2DzRZy0eLm7Qn2tuTdiezpsex-aHRrvwgfwrN4MD25cFIcI0QxzQHg>
    <xmx:2DzRZ4ELf2yGBdPL7vKYVOcQpvc0msO8YdmDTpWizzVp4Zk6tUOnwg>
    <xmx:2DzRZz9oQFBqMJaNMB37ljUSDios2afeMzM8fjKQPOjl0ueQ9_um_A>
    <xmx:2DzRZ1mOxjctXCFFg-JOPe8z6NBedNvvLw1S1ltPVGnnrdqNR-brCA>
    <xmx:2DzRZ8D2z3C8Xshe25JPepNvc3GEb5BXRDCNMxKp0T0NQQZdLNi-UysB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 03:50:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8ac2ad24 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 07:50:45 +0000 (UTC)
Date: Wed, 12 Mar 2025 08:50:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [PATCH 3/4] rev-list: support delimiting objects with NUL bytes
Message-ID: <Z9E81I52prH-ROab@pks.im>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <20250310192829.661692-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310192829.661692-4-jltobler@gmail.com>

On Mon, Mar 10, 2025 at 02:28:28PM -0500, Justin Tobler wrote:
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 04d9c893b5..86b3ce5806 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -757,6 +778,14 @@ int cmd_rev_list(int argc,
>  		usage(rev_list_usage);
>  
>  	}
> +
> +	if (nul_delim) {
> +		if (revs.graph || revs.verbose_header || show_disk_usage ||
> +		    info.show_timestamp || info.header_prefix || bisect_list ||
> +		    use_bitmap_index || revs.edge_hint || arg_missing_action)
> +			die(_("-z option used with unsupported option"));
> +	}
> +

Not sure whether it's worth it, but do we maybe want to add a comment
here that mentions that this isn't an inherent limitation, but rather
that the initial implementation simply didn't implement compatibility
with these options? This would explicitly keep the door open for any
future improvements in this area.

Patrick
