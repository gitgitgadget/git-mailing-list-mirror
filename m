Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDE42222CE
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742462285; cv=none; b=Sroj/wtbBs+pJj/s5j8Y1/GXLZJaUJCzqk1HH/WLmm60cgHq3koaK7KKx6SNQWoj0IfAE1f4nWRMifj5Z8wfsHT+1hfumLaK2Bc38p6s5jrVVke21qfDKYtgds0QAdHusL4+SvHT34hCgw/xAIGZ0R/HSPtsa6PLzlMtEL4vZEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742462285; c=relaxed/simple;
	bh=4uoOwntNo/k4mLp+QrL0g6zZ4Tw3xqEb1vc8PT3LxSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdDJxoxfPKjbHJTpdJYNiCiUOrkRActXXlLD37QquethQBNMerkAaAZ1FGAUIL4zR9ZUzHZeu6482SA6YKoe6TKr00EFBcAPBohjZ9OjkAQ5XuROQD8KJ/W8Fe8oMlxxtv5SpMYay+IS+Dn79ZXwjPXl8Y5T8DpidlYnOsa+sNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bpHBwQRP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e6jHWDee; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bpHBwQRP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e6jHWDee"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E30152540192;
	Thu, 20 Mar 2025 05:18:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 20 Mar 2025 05:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742462282;
	 x=1742548682; bh=an82X7ilnqwvi0j1tTJqhlFAbje93Pb86zFOEf7k94w=; b=
	bpHBwQRPSFJaI79DooNXxrGPI5DqW2Z/KcP/O494gKCq2Xxl5smdDD878kruI5w9
	MC7RW8/bHT7UZ0XPLRUEU+jr7GCXFZYrkZmJyvBttQm5pb/gB8lvbAunBCA+nC65
	kjN8Mz3bdaxwQcqai7RNs8eRO8AZ0BliPi2PzIk6zP2HnXwrFJrGrEBDRVWZrAWN
	fXcOx0aHuXmaC2gE8i+qM2nGUVdCCPC2nxtd8rrM00Ja9a+4flEKG1ubKotHF4Tg
	vejwhbz8jw7Pyf9ziy0aUR4uAWYxYYHS1MzQwsQasBbOoQVx/zh/TJf/AyyU7RLU
	69yR0SmFQxOc6boAzsEM3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742462282; x=
	1742548682; bh=an82X7ilnqwvi0j1tTJqhlFAbje93Pb86zFOEf7k94w=; b=e
	6jHWDeewwlffeoS72/dXmCzD5p7BNnyKzDq/ykdyR6rIXyi1ImPxmQCbKeOzw0Im
	vvEu3oqY2qYAc2fVvuqXeyz4AXj/dslfoY8HLCk7d8haLaMY/pprW7aWAzTHl1Re
	jSFEEksIwQL3ZWKwftdVO/SepQV/9G8iYF1HFA8iiTQ4+XM+K7tm8sYRMs0JCYfa
	rEkc0wKgR5OIUhcavtnAR9DAGEae9ndogMC8g563W15l4VhczYvD10v8Rc6FkHDI
	Eh5yxUSlp9nyRRnL9zxvGOyFkKKXnNIWJwy6jRG03KZbFvXVCwFX3haqthDu7Vvv
	zJmOYPgaa7VuH5kBcHxZg==
X-ME-Sender: <xms:St3bZ_6o6eR1mT08J8Ls6HyPQ8oSYu00FdaTxqFIx7gjtrhUSmrkew>
    <xme:St3bZ05Eb7uOoRf8amnMm8fWPIXEoG8mzcKs4WNBLLG8WXRseVu4wvh906x8ruzmQ
    rAN_M-TGnIUp9F4kA>
X-ME-Received: <xmr:St3bZ2eBBlnUQV74WcAdWlnAPxSBo-3t6YmOhF6haK7aJebmzGYbD0HHteBAAPMKPUI0YrkbHQc_4zmeFVwf8FqfZlG9F6t34Vjl9mAOOxAykQY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmrghrthhinhdrrghgrhgvnhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:St3bZwIP36HDSUnvBbfU188qJ2xcHOGE5IDMYIfori5Y4NntGsbPKQ>
    <xmx:St3bZzL0kCFPx2jAn8bQ3yYi9jaaCtI3b4ZSCZ4rBFerWH4j5FgO_A>
    <xmx:St3bZ5yBG4FwzQA3otCGT2HlzCaGyBjXvBfB2GeTysXYzlHVSWj2Pg>
    <xmx:St3bZ_LoleUEwsgO32YS8h4Mn_hK42969MmyPlegxyvOAhqE4aMfag>
    <xmx:St3bZ6WVX3GFG_2ChPQQs6v_RJrBJsop0MrJBI7nyNCSxdTyClBUjugz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 05:18:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 33cce583 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 09:18:01 +0000 (UTC)
Date: Thu, 20 Mar 2025 10:18:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/8] pretty: tighten function signature to not take `void
 *`
Message-ID: <Z9vdSBDfB0MHP-iD@pks.im>
References: <cover.1742367347.git.martin.agren@gmail.com>
 <192fc78dd869f28cb6ae91f3a26a05eb6b6a4bbf.1742367347.git.martin.agren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <192fc78dd869f28cb6ae91f3a26a05eb6b6a4bbf.1742367347.git.martin.agren@gmail.com>

On Wed, Mar 19, 2025 at 08:23:34AM +0100, Martin Ågren wrote:
> We take a `void *` and immediately cast it. Both callers already have
> this pointer as the right type, so tighten the interface and stop
> casting.
> 
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  pretty.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/pretty.c b/pretty.c
> index 0bc8ad8a9a..a4e5fc5c50 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1437,9 +1437,8 @@ static void free_decoration_options(const struct decoration_options *opts)
>  
>  static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>  				const char *placeholder,
> -				void *context)
> +				struct format_commit_context *c)
>  {
> -	struct format_commit_context *c = context;
>  	const struct commit *commit = c->commit;
>  	const char *msg = c->message;
>  	struct commit_list *p;

Makes sense. The function has been introduced all the way back in
9fa708dab1c (Pretty-format: %[+-]x to tweak inter-item newlines,
2009-10-04), and at that point in time the callers only had `void *`
contexts available. That has changed eventually, so I agree that it is
nice to adapt accordingly now.

Patrick
