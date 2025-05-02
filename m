Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C511C2356DE
	for <git@vger.kernel.org>; Fri,  2 May 2025 09:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176900; cv=none; b=J+QFWQrkAFyuN4HZ/qBwRuxSbmytjuTmmegmRrL44OBXy0I5vjfOJX+jR6lS/3X/0rTF+T35sN28apun14CywzE5QVCmyBAtNLo1hddiiUm/9C4gmJxXkplvIO3qGLJ6n65hZQKXJ3FTXrd3Bk6swn2wJt0o+YLxTdym3PaRvSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176900; c=relaxed/simple;
	bh=+3/Wsf6bAc+gOzftm75OhO4Vp+gz9H+HHWHs3drk4eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJd5SkAybBtF8IZOpS0HY90S0DTV5N+N0luh26B7KE5hG5+FvVXe3nX/iLRQxMG7JrZA38FOUIJvJrPLf/tgXJ4U7B+1P7FAepJJI/qkGRl4a7mkr286ib5PqwT6IrLuUOSD7teKNnp2Ir9oM3sezd9DgCdqssfcLJx4rWs0nbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=t+c4AMpW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ox1oj2w0; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="t+c4AMpW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ox1oj2w0"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id DA7CE1380F2B;
	Fri,  2 May 2025 05:08:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 02 May 2025 05:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746176897; x=1746263297; bh=+3/Wsf6bAc
	+gOzftm75OhO4Vp+gz9H+HHWHs3drk4eA=; b=t+c4AMpW7DWnkXxqn0Qg51nvt3
	sTxxE/qfN5h8iocB7G9IrSLmWYLtDdmIWgLA3DY+mA5IvYeniR1erk8Umb7FV4Xt
	F1KKk1SYY1jA7ddhYS4UiqIcln0KC/WpShvttUjq2NkE1TwESc17mPOQK6zWirtc
	0vunTmnMNZ5AUPYFVh1w/Ejti9O3Zco8U0t0CgVDmVcDdK0QEXjFX000kJXvDaWf
	xqKTqT0PmvV9J3yC2Mb3J5PFUrHyy+ojHSGkU4wrcDa0zXSrPDPJrwnJBf7D2er4
	AROLdSdXIG3b72WztdblZU1lXQQA28RKrPXIMThQ0uADH9JeovQyqPib+6gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746176897; x=1746263297; bh=+3/Wsf6bAc+gOzftm75OhO4Vp+gz9H+HHWH
	s3drk4eA=; b=ox1oj2w0NgVL6EP0x/lHpVAtWAdOxTvhSeoGFKIwT7iE+7bJWqT
	yZsMzuYfQ1dNBrzZTDwz1n4vCgEU/LAgrFyCWm7ozj896xCXsaQ9zJfPcqDLMDdd
	te0u8op7P89dxmnqESBXSFRlEaatoNe9zO7A/OG1OxZx7MFm5FHDTdUNKOxmsBDQ
	u59WLfo2X2LcZbPZJgjOGVn6XJ5cclh2IGnHkeQDrXl6hLz4d1tYpxvNvvXijRBD
	ywpUurvSA8ulmC8+35KM69CSxBGdqVsIx+HrOLG2iG2VOpGBvyXQMhtVqQdb2emB
	xRhosmfKUmkGxfzKUIHi0GJPC1lzBAseF8A==
X-ME-Sender: <xms:gYsUaNbHv-A35MvV7A4e3Wk9zWsMWTKT5ax9oztoDnBt0w0IJstDPQ>
    <xme:gYsUaEZ2cBTR4C48-9ievCzUnlKQXQYRN7wrLhIHl2JGmlw-BG2cj5Yio7xQjBBWb
    qeYyS1xYdvFJ7u81A>
X-ME-Received: <xmr:gYsUaP-XDXLxkRIjY9iCoA5VcHr7pVzqdDtswT-fE49cycMxqhPkfbIZokOsMXMK3z7wJVckvPBIEYaaO14pIOAFTwqCjg1mYnUHNJ8ltKI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:gYsUaLo9UEyLKhYq91vpjWvdwstfBqx-pFcYY-JjnIyhtBAKaCB8lg>
    <xmx:gYsUaIooWwXUOB-yPLUpKXlQaiRf0y0Q7fdjk_azbhrc9NjJKUkLig>
    <xmx:gYsUaBTbWrqFeyrRO9EvX8coE8F1aFVOgfaz9KdCHehxocm6bmXsZA>
    <xmx:gYsUaArRkLqb3igQKBbAp3EH_vkjRM_gwr6ClTB9P_zVDAGiT3yjXA>
    <xmx:gYsUaBaFU6VgYlMVH0K1qL4fghBhvZsRWeh9aFPMHjg2F8TuImuHsT6Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 05:08:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 36fe3c45 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 2 May 2025 09:08:15 +0000 (UTC)
Date: Fri, 2 May 2025 11:08:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Nominating "whatchanged" for removal
Message-ID: <aBSLejDoqomUO3xE@pks.im>
References: <20250501213452.370729-1-gitster@pobox.com>
 <20250501225958.2947677-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501225958.2947677-1-gitster@pobox.com>

On Thu, May 01, 2025 at 03:59:56PM -0700, Junio C Hamano wrote:
> This does not go far enough to touch the "Git 3.0 removal" list in
> Documentation/BreakingChanges.adoc, but is a preparatory step
> necessary if we ever wanted to do so in the future.

I'm a little confused. These patches very much feel like starting the
deprecation process for git-whatchanged(1), so why wouldn't we at the
same time list it as an upcoming breaking change? Or is the intent
rather to figure out whether anybody is still using this command so that
we can then deprecate it after a couple releases if we haven't heard
back from anybody?

Patrick
