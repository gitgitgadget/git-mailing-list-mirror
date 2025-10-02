Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C302797AF
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759405474; cv=none; b=h1zFzR3UxefoOJphTB7HxdaFxieqmKxFiIJuE7nkCbbTol4UKMNWJhgSmpsG21J0KYi1a9nB4HudWc6TNdxINQMj2L+GiiG/CWWvd26IzZ5dQm+LK5SGeGjSwaJFvZA+2tnBRatzNMAMG2FEJ6G6/h7iVcQ2unD7ZEq6BgMD8RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759405474; c=relaxed/simple;
	bh=BuBmuCm1OQPn0QwJY95kqlyfeg5D2wrZain6S+5ZXdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1Wf+P/oyTQBdZ0ax0hyZNT0IiSPnV4XUbzSOg00Inofer5teufondia6pry8LkYi0yNsKIvX3mjxYt2wUbYaXcHqExqGQLyQt08wDmPKaN/0Okv2MsIoPOhefm3EyiOjBpG5OUjLM/mPd464G+GpZg07r7NJYnJdttDZPIZAaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ksrhJoRd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ycVnkLSW; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ksrhJoRd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ycVnkLSW"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 7A4CF1D0012C;
	Thu,  2 Oct 2025 07:44:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 02 Oct 2025 07:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759405470; x=1759491870; bh=29s2c6btHf
	bed4nCJHCxZewVCoqUQJJZMX9ZvZ1nByU=; b=ksrhJoRdaZHtsPGgpacapi9ila
	2Sm19sy6WxpskF9Q9+KRdsg/sgVR52xL6kzOnIRNO05XL9aP/oct3RZiPMxPHvZ3
	In9dcqQxwRSle6lrBlwDJ6PMJHh1p1+caVNcdnc8tpZ5k+hM1nGzw1qrTBqtXwx4
	TY9HsGQyPfN6gUGGU6/mKMxQemxduHvNDtTY+Lv0nN69hMbwGEa4pqVrBadEVH4s
	xB1Et8TwcIxn9J9cAzBc0cm0GCZ41u9RBPtzDHff/Dp/RNGr06VzTEXnOHqGv+Zy
	SEPLb6xpn86Crfi/O9znzKLLoaiaIUtPOV71Qjw3UNnxGdADFAN004KkdUjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759405470; x=1759491870; bh=29s2c6btHfbed4nCJHCxZewVCoqUQJJZMX9
	ZvZ1nByU=; b=ycVnkLSWCeq52czogK6pDFz2lGrRJOR7N5KyJZc7hCIPZKYR5Le
	UXfLbbi1HCZF45hP+MtIs2GKMAotbFrzHjq6uTRWPQr8NuWzSXZyPWVBih4PYhMH
	tQrHEqfD/SRd8kbLZ2T+KEwHRyc6FYtGSOi/4DiL2dTTVZLkFKMkmxfXeShEAD2U
	AltfgU7eHf9yMSMcboNG4uqIhI5rTyvKEMCBHIDjzb6G6hTxOBB3Ll/iT/aC3PWK
	TLOh6/Ug+Dc9hvJ6OuFEfwvdpizjxVtQCd8c3lml+9Hkpo9rft7SswOVPbbAj7Nu
	pBtdujof8y4hGvkDiZ3CKh0eDbUijj9UD2A==
X-ME-Sender: <xms:nmXeaI5UWjSlw-JTOdWooJYxHGmzB7XHZAYFP1y0skTOmxbc-9_k_w>
    <xme:nmXeaA5VhOyoNLoC_lsIPnYiotk6A5sIKNldJsZGgs65imCKZAUaf8MO1_VI30hbh
    lxyI32KGvOCycE3fCRkVmQFT6SvVH-poius--TGw5zCZNSe20HOjA>
X-ME-Received: <xmr:nmXeaMfYlJNFCu2fbrTSmObwSQE5Lx6j0QyxlfAd8XPqM2aqZjDtNNlKxFVK0eSiUAR96eyci2RvqFA1u96PS7nTO2LsHKP7q8V5xOZh0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlh
    huohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:nmXeaMAkt9OIhOuAmgvsyqjHNy6InAK_V0agxfJ6Cbo_n_M3IewMrw>
    <xmx:nmXeaH9bQL4CtzqzTizoBXLeshHi7QZZrGxBgkEVRushMiSx9VZ_sQ>
    <xmx:nmXeaPJcRZ1aTaHEzCicpO7h-0kUd9V8SQP7emiVxAJqoLxqh68vEA>
    <xmx:nmXeaIgSDVvR0gWtCg7y7wkdtY50fUT07pVN1uRjMCLTO9mQNfbFvQ>
    <xmx:nmXeaL8dTeQfOB9OtfS_9zvyzR3uUOvLPArwEGB4M7HvX4_O1dqdh_aS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 07:44:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 43855f03 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 11:44:27 +0000 (UTC)
Date: Thu, 2 Oct 2025 13:44:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, shejialuo@gmail.com
Subject: Re: [PATCH v4 3/7] reftable: check for trailing newline in
 'tables.list'
Message-ID: <aN5lmEx7Q57YEyHH@pks.im>
References: <20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com>
 <20250926-228-reftable-introduce-consistency-checks-v4-3-c96fd8551c0d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926-228-reftable-introduce-consistency-checks-v4-3-c96fd8551c0d@gmail.com>

On Fri, Sep 26, 2025 at 09:25:46AM +0200, Karthik Nayak wrote:
> diff --git a/reftable/basics.c b/reftable/basics.c
> index 9988ebd635..e969927b61 100644
> --- a/reftable/basics.c
> +++ b/reftable/basics.c
> @@ -195,44 +195,55 @@ size_t names_length(const char **names)
>  	return p - names;
>  }
>  
> -char **parse_names(char *buf, int size)
> +int parse_names(char *buf, int size, char ***out)
>  {

Yup, this changed function signature reads a lot nicer to me now and is
more in line with our usual coding style.

> diff --git a/reftable/basics.h b/reftable/basics.h
> index 7d22f96261..693db9524f 100644
> --- a/reftable/basics.h
> +++ b/reftable/basics.h
> @@ -167,10 +167,9 @@ void free_names(char **a);
>  
>  /*
>   * Parse a newline separated list of names. `size` is the length of the buffer,
> - * without terminating '\0'. Empty names are discarded. Returns a `NULL`
> - * pointer when allocations fail.
> + * without terminating '\0'. Empty names are discarded.
>   */
> -char **parse_names(char *buf, int size);
> +int parse_names(char *buf, int size, char ***out);

Tiny nit, not worth a reroll: we may still want to document that a
return value of 0 means success, and that it otherwise returns a
reftable error code.

Patrick
