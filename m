Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C4F1FC0E5
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733136883; cv=none; b=gEDr0HpVJ0unB5gGcOTz0HCD0EKA8KG0ObmFByRzD4MMpHmw3Gpbxv19otpnfyGvQVZaVpOGv/3VjRDh84HcyrLXjHlA3KQdceyLk+PzVsB4iheyLNE4DCm8fHJgV/UBACf89I01v279vpro/Z3KYNFS0WUD3+uuQiesylTwWms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733136883; c=relaxed/simple;
	bh=mVhK20aX164m3UEPsCi8zjWtkRtQXG8OHSPYbG218hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpfaCHUXzOMMLIoSS2jIifEhOoCp6yn34CLsvOsbFXlVdhDKcl/TP3FZgUrdA7vAGTs/1op4d7dHPO1tMEw9/Z2gSuFtRaAQ5yDXQrrDir63tll/AGPtXGrSaHn4QKYO41csp8N40Xf1u+zhwoZEL4R9Mh8kNrU83cWxVQihcGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SxuwZ9NY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q51Iuzt9; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SxuwZ9NY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q51Iuzt9"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 314AE11401B4;
	Mon,  2 Dec 2024 05:54:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 02 Dec 2024 05:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733136880; x=1733223280; bh=VuyB7AXE4H
	un8atDJGsqs6NmcNx/jFN86kDhD6hHpGw=; b=SxuwZ9NY1119SDeWtKCOHEe9XR
	1vSRDwBIcMQfO1w8WZE3fVcuLBZzBYc5V4QgBcg/VxBBrgVCqFDZbtwM8KqafZjb
	+jQ39MxmE+Kp7GNonRr3EgR9x7+0rMvSOL0FTUBKrCy0B2clM93U1s1VHfw0X0so
	wWEXW0rEQ+xA86h+COvN0Qo1bCqSzRd7lJM4zziwAMTOWkEQv/4MBtIOSEAh6HUC
	vkezJrSYb033IUrl0LuQKPlVV5+wZwP7x92/gW3tRSR165u/ZHEHSwlL59eosMMD
	33RTyA7Joe3fFckTR7KtW2juODRiUS98ej2O8l7if+rijkqhi3q5Y8w14j3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733136880; x=1733223280; bh=VuyB7AXE4Hun8atDJGsqs6NmcNx/jFN86kD
	hD6hHpGw=; b=q51Iuzt9D6HG/Fw+YqU2HCb2ZhqRmp3oFss98IsmxBgfwCJGSXi
	dcYE60fq7XO9bRnbfGVi5D9Czam5vDly9VMIvQeyPuRFMAkwwHsMHR0rBSIpOUad
	ouBN1m5i23JHfhn8xgdthCSg9YLGXvjKg2CIhMFlmNPKj5NL1El+BVnI1vW1t/uC
	7NY78Xh70xtnwJSzsHxJcNdVyIunhlS80XN4nfkQp69Tb1WxSQvlToyzi8KCz8kP
	SOFEpH6IBZCZe3eqOdpACiPtXoIFd8C76eHHH4NSLuNR/HHei8P6rbEDug6ZBOfl
	Q5bVerNZctX5j5A3XEznaCseAY0u81nDPlA==
X-ME-Sender: <xms:75FNZxY3RZUGAKzG0krRYBouBSmfF2C2vTyAb9klH6brW9ONjopKig>
    <xme:75FNZ4ZUNOJ7Q76w3-hteBhrG6XFCCWw0AoL0bSxxAdAlDyR_aKtYbP63o3Vrn3j2
    IjhsMjEs6hfYqaNsQ>
X-ME-Received: <xmr:75FNZz-5IGvE2Dcl7E13V7KPDQfZbIC8IMRGnJXJ1NGDK_19I9eDWD2TYIUKcqEqgrUkmyj2N6Rf6tcAoZ-Zj2_M-Zcbp5K8XQ5-3wDFZj_vOkB4uQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitd
    eludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihht
    sehjohifihhlrdguvg
X-ME-Proxy: <xmx:75FNZ_rlVLBxKoISOgR30C1BIA8nbATX3rlC1uW_ijz8VOLcre2L1A>
    <xmx:75FNZ8pLgGU6_Qhtoj0yN-CiQ3Q_eOXLL6SLfDHU2tBUkX4gpkTdUg>
    <xmx:75FNZ1Rd1gYPwPrwvuh6AkWPo6ULhMcobnctViVeH7y8otYAA-WlZg>
    <xmx:75FNZ0rGLNX1su0Gu89pG623zNQst0kTnijuSkxCRpv0TtLKTZ6Q7Q>
    <xmx:8JFNZ1kUkT2-jAYeLlFUCL09xx21MfjSdDcP4uLQhsH4HgWed7gke8Tm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 05:54:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a29715b9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Dec 2024 10:53:20 +0000 (UTC)
Date: Mon, 2 Dec 2024 11:54:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, git@jowil.de, Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] tag: "git tag" refuses to use HEAD as a tagname
Message-ID: <Z02R2Puck52VetcF@pks.im>
References: <20241202070714.3028549-1-gitster@pobox.com>
 <20241202070714.3028549-5-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202070714.3028549-5-gitster@pobox.com>

On Mon, Dec 02, 2024 at 04:07:14PM +0900, Junio C Hamano wrote:
> diff --git a/refs.c b/refs.c
> index a24bfe3845..01ef2a3093 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -735,7 +735,7 @@ int check_branch_ref(struct strbuf *sb, const char *name)
>  
>  int check_tag_ref(struct strbuf *sb, const char *name)
>  {
> -	if (name[0] == '-')
> +	if (name[0] == '-' || !strcmp(name, "HEAD"))
>  		return -1;
>  
>  	strbuf_reset(sb);

I was thinking a bit about whether we can spin this a bit wider and
disallow creation of any refname that looks like a root ref. But I don't
think that would make sense, as root refs are defined as all-uppercase
refs living in the root, and disallowing tags that look like this would
go way too far.

So I then wondered what a reasonable alternative would be, and the only
rule I could come up with was to disallow root refs with "HEAD" in it.
But even that doesn't feel reasonable to me.

All to say: singling out "HEAD" feels like a sensible step, and I don't
think we should handle root refs more generally here.

The other patches look good to me, as well. Thanks!

Patrick
