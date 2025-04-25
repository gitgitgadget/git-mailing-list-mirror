Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF031EA7CA
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745575351; cv=none; b=UIa60S8auyV89ol2IZrOYOkI3NkY+y0m2qGuJ/gu3sKm4AYMU64M60bwdcZaX/lKWXSdSoO53DIGDhQJ983ViNRUm78NxTDNgxyhI4MH471LOoCpGzjmKIrtrRiTMs2fRk1kJ8I3LpNhdjC0Y5nK2SUWtkH8XsJ9e60PJZX4cdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745575351; c=relaxed/simple;
	bh=o1Rzr488QTvmCiOkyQLWWQc/QkjbTS3BUWnFDxA7gbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlmmucSV4Y/5ettJMmKV9Su4pARa2VrV0YrI9Ad0FB88ZN8aWmOR55nCgs2C6IsNHWpFZYlEMDQWoMmFvjlGAmv5W/aMeLBKHWcKfo+SjNUVw1rSjwI9hWmKDFpXRj5cOJ8QoWjtVavmPAPy8b21DKG7zBITOLhw2qV1f6jNq2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BSTDeNUO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vjs2BYDG; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BSTDeNUO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vjs2BYDG"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 83748138015C;
	Fri, 25 Apr 2025 06:02:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 25 Apr 2025 06:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745575348; x=1745661748; bh=XBJnpE3AZV
	2GX4WMZ83zlcPPpxDa1sa2CusgkeWm7ek=; b=BSTDeNUOaUWhXSpzkG94gBYlv/
	OS1tPUlE0oWEbN2XMyTfCRQgM8GrN/rn1AzJVB5K6A7vYu43vKSQldeajjThnICv
	+c+CSvrB8vsu2KRAMtKEri0QsPHoIo0nLGLZ0yAABYK8uxmEqIER9/CBIGEciOcf
	xg3OT1zl9Frw/uayQLWkvID34Kq+hI7GDNHPVE7Ui9I5oLeiLi6Mo8mB4nVywJMh
	QWwgyVeF3jbGbW0o1cbdn3vkq4sE9yilFiq4Ht32l2yJmG2RJK8YMrKTvlLssFPH
	keYb3j73Ix5F1HX3AC4WG6Q5Go0NyeibR7vF2es0FHZJuG0qxj2aI5Fkm+bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745575348; x=1745661748; bh=XBJnpE3AZV2GX4WMZ83zlcPPpxDa1sa2Cus
	gkeWm7ek=; b=vjs2BYDGii0vM/0Y7cj45Lv3ddDwNMkRoPcYCl1AAY5kw4armkc
	KrghovOFE+bQr5SA99oCYQdBWcktAElf/FyN0CPqyCsYr7eUVF/VQEAcBtwgKp9i
	y9w+7A9mvwpFIdG+TmNZU+/2MtNFphG9zJGyZqjjrQy2X4dbclKhMwBlqW7dxK+2
	k0aiM0u7trKtjx4FJLdlkLZ3ux4QKpm8TZoX8fQXQ4qvHk63qeGNAiPtC8i1U6Fy
	ZlVjOiqy97/kK0fAMAF61RFnLHYrZe9llNev6BUTKrb/DRGucZiCl+0I1GonifC+
	bba18Bz2ArybuubwEhM4j5sA2fQwyloPkHw==
X-ME-Sender: <xms:tF0LaHHmjoxxPtXna3z7WmLXuYGqg_zXxHGhI2ZsL9slgFsuPtKI0w>
    <xme:tF0LaEXAA_KXnaHHkMHpC-2cqFpkr2BDPtRUFWsI6NWl8RrD0lcwTF2XUEXM_1N2n
    1A2M8WT_7iEhM99aw>
X-ME-Received: <xmr:tF0LaJIzU3fq10JIFhbavAdwlai6X5f5qTKvMELC_g_Hku2mjNTCwVQEPX09QYdHahnPTnQURBudeTftiGzbwHUh584VfKOj8PZ4FKLL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:tF0LaFGNPfqiKnAlCKBZXi29MHEa0NgkBZ0GiIoeNZlimfihVgetGQ>
    <xmx:tF0LaNW1G5odD00AAmatz71zqz68lAm006QzIHyahpceDVVC2uqZDQ>
    <xmx:tF0LaANmbFpxAGWvSA7Yt_gL6g3eX1t4ejUMyrg9fMEM1JSWaymVfQ>
    <xmx:tF0LaM2yL_szr2YM28dwYADheg-K5jAl-ufpmXVWNDABRv4mT8Zx-A>
    <xmx:tF0LaDENlQqhuAUf7ctviAFJk4ZOPEkGL_cxADkMDdHuoRmZOzpV6J97>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 06:02:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f8a5ff6a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 10:02:26 +0000 (UTC)
Date: Fri, 25 Apr 2025 12:02:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] ci: skip unavailable external software
Message-ID: <aAtdsURaaxYO7pVt@pks.im>
References: <xmqqfrhxtdg9.fsf@gitster.g>
 <xmqqmsc5rw94.fsf@gitster.g>
 <aAsNUYUKJZbrMCf2@pks.im>
 <xmqqh62cwoya.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh62cwoya.fsf@gitster.g>

On Fri, Apr 25, 2025 at 02:49:33AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > I think it would be preferable to only handle failure of wget as chmod
> > shouldn't ever fail if wget was successful. The same is true for the
> > other downloads -- let's be as strict as possible but allow failure of
> > those actions that depend on the network.
> 
> You may think so (as I thought so too before hitting a snag or two) ;-).
> 
> The thing is, failing "wget --output-document" leaves an empty file,
> and an empty file does not still cause "if type jgit; then" to take
> the "else" clause, and the invocation of "jgit version" would fail,
> taking the whole thing out, due to the "set -e" thing.

But shouldn't the failing wget cause an error, too? So the `|| { }`
cleanup branch would execute in that case and we can prune the empty
file there. So in other words, shouldn't the following work alright?

    if wget --output-document=...
    then
        massage output
    else
        rm output
    fi

Or am I still missing the obvious?

Patrick
