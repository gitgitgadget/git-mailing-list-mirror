Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4B82765ED
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 23:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759188132; cv=none; b=QNozEcTxnj+dLFdN2c7sIWJAv1I/NA3fL1+a1yxGkQxQ8omNUryfX0png3IcEmDL5g3JZLEsvJ3TOPjnXZKInCI5iu8gzMxiDnz5gEATCGhTMkdkCWVslch7fEDqlTdTC8k7fI6pL6TlQfqRU71lD91cK6UCqfpoLNqxcHvYtSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759188132; c=relaxed/simple;
	bh=0zBnogpe2PINW8W/+Wbph38cA4gvBeCkkTo/9TlKphQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdXgKOhqCHvhVvc9jN7i48su1gpaRLOQr43e/+GsNuc9s30Gs+U6MBxm6D+aYv+/3RqgahiWzo4WGEgzoJ6YDm5x23jJoarjUc6534zhdbpMftpagFtNTXErjT1uAAtGQi+WVexfGmKc2qDZOCw8J6ggQhNx9QAo7G6uPwX38v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I/4xHe1R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qp+6TAVx; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I/4xHe1R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qp+6TAVx"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 66BF714000C1;
	Mon, 29 Sep 2025 19:22:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 29 Sep 2025 19:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759188130; x=1759274530; bh=+9LPVfdTEU
	HCl/PLvebYh38voc+iRzCLjMI3RhkDF64=; b=I/4xHe1RiDZsltyonL7V6/1eCM
	4fGkETCD88Xp+qFCvsXHcwN/FJmeKglX4tTumruI7VD+PtZ05LWelgmN1DOJB3Au
	6gKppawP0Nj6CO9WNPL/9r0/Yf1v2pavzF+B0Pt2U81m7cpQPEmfCT3wuniHyaCo
	iDnavZnIeD3xgC+Ff1w+VZ48LEUVvPf3gwEoXq+p+mohDBpIxLVLzW0lQuTrbWgs
	9Lg4jo9Wdo9Rfopl9YCCyg47BKw95QDCnIeVMIgsXQAHeX2WCtQ/1qrt4bDI4Esw
	6ZTrlz34GQtbHGwerQvGSnmjevh8ulNf3E1jO5nEu7VH3rsFRnQN98Yg6AaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759188130; x=1759274530; bh=+9LPVfdTEUHCl/PLvebYh38voc+iRzCLjMI
	3RhkDF64=; b=qp+6TAVxDHx4HMkQkOlzU28VeLSWmQvO61ymFcEHcMoeJHog19w
	lnol2x+Cuyb0N33tPiFIYiRrwEO4tcG6TyFU82k8AtAm8+oeblzq+UY3jnI9bvMS
	5rw49eFHRavyRwfVMqcqDsxNzOI/qYlVMYq/R18fxK+ahWNUd9nmqEhuw/UrYGQQ
	mM2iL4vElOgj6eZnLQTQ6oVw3T9L06qbian+V1D5rjT/R6eNFKb8uAhX7OciKXHi
	/XaJv1ZT//TNnIlIOA9NXzzvABnSpFn8r59THIQN/KkvXhODm1vO9VfcKS96ZOh1
	V0wvKLY930W75PeMwN7Qsg4Thx/63JJJwiw==
X-ME-Sender: <xms:ohTbaNPJQTyYqzTc-yFXsthBI6QwRCK9ES-0lvWwYRZsRx-euR_iYQ>
    <xme:ohTbaDrCS8NJU-ZcMAiiZ1kT4oUFk_pFQIAne-nBVZe9742r2N9Vm8ezdmLNRm918
    RcBbk2nrq4IdvMn8l6ElAWWd75h_3Tfyw1dJmz8kORtIIK1HYBGGi4>
X-ME-Received: <xmr:ohTbaGEp_dkMHpTLb2J0cpk1GAEpb9WDXicIbhbmPo6IdQOuPnXs_ZgP2w5OvHvS3md0HK_UGx0o5cGj7S5XOoAN2Ai68DOKi4sA2bP3Ms4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosg
    hlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:ohTbaAo0UWuwzQGurSC6Yihz1fihHhwIxPwHC4dYPsLCwjMd9gEm6A>
    <xmx:ohTbaHbzAbLu7h0FJ_cEJrFqqwC1qVftPPLk6e9RTPwq7v2yYFcnYQ>
    <xmx:ohTbaBXMiN-ug6ZBIFzGkAvYJZiyz3voEfgAJ1lPMkTk5OW06eHA1g>
    <xmx:ohTbaI85_nturXutq0jaVS9s2cFVTle8kLUMMeJcDM7C4VWB4Q7qgQ>
    <xmx:ohTbaFqJF23b9u4cARPAT50_KfFAtiDsxbheHVQj-RRSGEPMLPa8P9m0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 19:22:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 78989d45 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 29 Sep 2025 23:22:08 +0000 (UTC)
Date: Tue, 30 Sep 2025 01:22:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 27/49] builtin/repack.c: rename various pack_geometry
 functions
Message-ID: <aNsUnfRPi8cYwGkm@pks.im>
References: <cover.1759097191.git.me@ttaylorr.com>
 <dd67366476172eb1b5b0d2bb2a4dfe92b96b83ba.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd67366476172eb1b5b0d2bb2a4dfe92b96b83ba.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:08:54PM -0400, Taylor Blau wrote:
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 18c3df7200..2ce1ae3364 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -115,17 +115,17 @@ struct pack_geometry {
>  	int split_factor;
>  };
>  
> -static uint32_t geometry_pack_weight(struct packed_git *p)
> +static uint32_t pack_geometry_weight(struct packed_git *p)

This rename is a bit of an oddball as we don't work on a `struct
pack_geometry` here.

> @@ -332,7 +332,7 @@ static void geometry_remove_redundant_packs(struct pack_geometry *geometry,
>  	strbuf_release(&buf);
>  }
>  
> -static void free_pack_geometry(struct pack_geometry *geometry)
> +static void pack_geometry_release(struct pack_geometry *geometry)
>  {
>  	if (!geometry)
>  		return;

Okay, this function also gets adjusted for the new naming schema we have
around free/release. Good, but it might be worth it to point it out in
the commit message.

Patrick
