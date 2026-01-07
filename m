Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D022202C5C
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 07:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767769299; cv=none; b=nYKhAWBIN8RV4mibrMFysjuwmaOaLyoPQfrsL4AzyOv0OOBgITF6Z9jJ2EoK3SQYSXgqjxc+K0GZOmMVXzayIJDBw6wD6jrnoxj6j5bh+4MbiNXLbLkkzo1FF8hnRGY2xutmP3hFDf0EHZMsM30TslXv5ZKSjN/g96GpjbCLss8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767769299; c=relaxed/simple;
	bh=utR5P2vHUc0Q0IiW0h33HNDLUZiu1Hr49Ya1AVAbleA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ttc3QKCqy0RQxK3YDROyTJdkhkZ4zJpikidTKddM/zvi0WoHYjOtVxrfZ41HLTjsATklkW9ZtSW3BTjbt/OeeHMhEplBiEk+F4m071309fUkBthGIx4mztdqJZSvlEfeDeYLXUa0r2YHva8jxToroG12swo2B9MYYJc/ew95aXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hbJ2jMRC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hSyiA0oX; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hbJ2jMRC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hSyiA0oX"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 44636EC00EB;
	Wed,  7 Jan 2026 02:01:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 07 Jan 2026 02:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767769295; x=1767855695; bh=sEgRnOfrmJ
	+clFnE67tc6xekHLADfmV6WbwJ9eDEOx8=; b=hbJ2jMRC3jKI2euwrWNcItvgti
	pNTYTeZwJWDLE25mdiiIh4NQTCoZHRzuyOlybPLrQEdAyEGRVSMb2nAadgcqCxqW
	DeH0LRZdIS/JQir+nI3IakTE+x5T9WO50zpGOvTcpDIn9FmUkhhNr+6xRBiMlQeM
	l32dcnXJ0wDKNY/0m/s5A66n8LwyA4W3s9WWOGEG7EqBrkPaLjn4I4hUgiY/TiJ8
	5gOfLZaVf/D13lO++Bp255GsSjrx37Ybr3hu+kJCq+xOLx3CN+un0rPA3j8PSTWO
	2rJO6AU6ZkwVBVN76iVu2jgcT8tnNKIOYQ1E+yiYrfTmi+dMPJwZYbm2IYVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767769295; x=1767855695; bh=sEgRnOfrmJ+clFnE67tc6xekHLADfmV6Wbw
	J9eDEOx8=; b=hSyiA0oX7geopJlxoNsGZ0hZvxmy+d459KbEJpBS820+N+d5t+s
	oNUXYlZVBU4htqEu6Wcubbloiu5EaSuD543liMaUaIMlCGhDUDDC6rrnbB7hdfMK
	+nxlk67CC+DoJMh2tRgQkXiktJy2oPKXE0b435xLZx9duHka+160JjXTnx8WVnQE
	pi3uVUYwLw0U7XoRGTdySb7i2Rwi5buFtM1frF82ggmm2tIFwB2ye8aX6djBiQNp
	Rm6Exq7veG1cyjg/LXS7c1EOceHYjJkbjDSo0K23fCo1cZt/OzFcJgIU2veilnw6
	YyF3xLZVnBmqrXQG3kNeflHcTI+1b2CiGJQ==
X-ME-Sender: <xms:zwReaW38UTteNR2Can3U45rbGJiN7z0gSKEKqkI-006SvLAabtyUWw>
    <xme:zwReaf9OW0C-2sJUN5Gc1PMZjuZi7FNw8pZWQvyLebwOUtzEoK27TDT-r-JqT_T0W
    FyqnJGm-s6raKzg-00vktMJpvkh-dh48fAuylKE_AmPsjW_XU1w9g>
X-ME-Received: <xmr:zwReaXNPAAgQgEZhyis0Ua9E0X43kTtCN8ni4zKSAw4RFElgsEyMS4Qn2V8lxfL4CGPbnxv_cHaEyPDxFcDsw6QPFCytSjKUtrUcv7BaMgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddvgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeevudeggfffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvd
    efsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:zwReaTdQKC2WoU1L6vKYNwfxzaKNoGIcF7TcYxlewgVmAPf-9xWl_g>
    <xmx:zwReaWVOBUxG9gGqan2nF72N7t8tOH7pppNmpt5ko9UHe7cyk8hAnw>
    <xmx:zwReabh4yQGuGmi9m5ODk74eAR7G2AyCEFOpWwy7rlm7hXVz3o9P7A>
    <xmx:zwReaV_-FvVbJggcpOZoMJT7mKRQKt-ZChtEUBXt6h9iCtKPD1iZzA>
    <xmx:zwRead8cIW7sLjsNf2Z4FsUFg21_9APZ_E2t6jGxH0EXgdFvl72AJg-X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 02:01:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f8159a44 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 07:01:32 +0000 (UTC)
Date: Wed, 7 Jan 2026 08:01:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/3] Update clar for improved integer handling
Message-ID: <aV4EwmNdnHyv9wXR@pks.im>
References: <20251205-b4-pks-clar-update-v1-0-fd70aac2ab90@pks.im>
 <20251206-b4-pks-clar-update-v2-0-9a14b10c1a36@pks.im>
 <CAOLa=ZQrx2T=mPC58oSW=1Y4i1cOCtneN+U7rDUmKAke9ifp7g@mail.gmail.com>
 <aVzvBnwsuPB_zd3_@pks.im>
 <xmqqjyxuhyd9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjyxuhyd9.fsf@gitster.g>

On Wed, Jan 07, 2026 at 12:53:38PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> > Changes in v2:
> >> > - EDITME: describe what is new in this series revision.
> >> > - EDITME: use bulletpoints and terse descriptions.
> >> > - Link to v1: https://lore.kernel.org/r/20251205-b4-pks-clar-update-v1-0-fd70aac2ab90@pks.im
> >> >
> >> 
> >> Easter egg? :)
> >
> > Oops :) Thanks for your review!
> 
> Looking good.  Shall we mark it for 'next'?

Yeah, I think this topic should be good to go. Thanks!

Patrick
