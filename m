Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57D628F5
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 07:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770879927; cv=none; b=u0KfVnZS3tIzopfTXd8lEGFOtmisDqZo1AqwifTujWebVcoE6JPuexE9VSTPmCARtpHH+tEMU7v71xaBW2Pr7DSHbjpfndyYfLFIF8M+S7X7kJpMI9k5SDn+kBbKNkybRi4QHTg/nnfCLkBYRM7USA8m+L5audZ3vbTH1JdhzEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770879927; c=relaxed/simple;
	bh=dMrgdjqcdElELVQaDf1w75eCK6ObllKQS8O63PscO1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfJug9kcy4DFbwb5KcaqpcgfAy3aInv2tpsGloCqM+PCFd6PrPQ/criD2/gWfNweob98CAZawRl/bzIJf0tUqQ161tN0k3ZIEIWAiqsy9Po05WHgu0b+StqqcdxIg2m1e8abQc79yw51JzpQpINP2FKBoukSBojMAS6FoWj3EmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gwrapq6d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JuVimEzm; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gwrapq6d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JuVimEzm"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1EEC2EC05E9;
	Thu, 12 Feb 2026 02:05:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 12 Feb 2026 02:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770879925; x=1770966325; bh=4PZjT/bUAz
	HSjcW5XqKzHFIgZ4prqMpNu8DNb/sf/Eo=; b=gwrapq6dn30uAaRmW8O9Kscy2J
	vpBH2ZWaBOED13eQGvflKjw7boICf4UcyvZg/vvqkgJSbS0PNitBuY715jgu/cwC
	oWf/QmBliIM8Z+lxYtVqhhmvWDQ3gO/DwDNnsa4kuMxZxiLKDgkEcBWJ0XShVZIN
	15P1VO0yUsEwUqGD5DjgYQeJLABt3Ai+hT4bU9+T7eOo3RHCee0vOBxSg7QkBTjW
	i4LIJ9LlpfUYW3u0lEg5+6KJT872HOILDGMBcBf0vdKtVrqwrBTrz5laod61LkW/
	y/TXaw+awWxMz64VNHr0dE7LxFeYlTHVpcIYnVBYO2oj+P1xrVrrvYG3fNhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770879925; x=1770966325; bh=4PZjT/bUAzHSjcW5XqKzHFIgZ4prqMpNu8D
	Nb/sf/Eo=; b=JuVimEzmuBLUUEMsTC/7aoKxbY9NdQIKQZB43waNC6jS70WX5+1
	hLErcULXnhyFneRr+NYTZKoa3ObLPX8l8RDNqbOPOAMjXDV27Z6tem8jB5oYRZEE
	JO5E9udJSY8Ial9kbBx0/RBVXqHzsvYW5/TI9oHCqY1VrmVvLqCcN13XVsvxUyIR
	DoxPDfRVQHWLoP2N8vyjXS9OSLao+rQ6NNYzRBHomeE4ZNA7MpstStnsc566vuCC
	MhOgDS30pru8f3X0fzWSH3+17dg7yzh9xu1pnx1B8Dz1shbePKqODkhUtG8269Jl
	t3PZ9FdBZ2+xlPdKX0Wil/55qxpuFXrRPUw==
X-ME-Sender: <xms:tXuNaTayg6Uh2wcurBZ2IW3qr1IJ-h0mWR5HTxWAughSaxD-O9hGZw>
    <xme:tXuNaYYEi8HhNNtwJX_PBaVVWM4AGx6YDejf-jwg3mldf5cYHiTPe34iv7MeCOMX5
    WJdsjrQzwuzAfFVEPZnCq60BltvpY9PiK965FzBDCiFQwLHtu_l>
X-ME-Received: <xmr:tXuNaTlHEuJFQVzeRFi5D__v1s9PvXouqUovhl2yOKLSu5y_7sLS37COpFxskz0dVzGSkYV0gxtuuDv3O3FLOtJ3embFVPzBhTsU9sQIGtk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdegjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:tXuNaUzSK-wkYxwRFnAbezW7BnIK7S4UAQZXFHwkNRDoM0F69rKwwg>
    <xmx:tXuNaRNQb52Uox9KuirF8cBjiBn6yyrFWYZ8UzzC1TgS9AgZtqu8dA>
    <xmx:tXuNaYQVcvNV-X5YELTM7fJvUcoda11DH1jxlWFtYq76pZ5q5Jy3dg>
    <xmx:tXuNafZzLFDvBeSmo0R5LPCqEEUOCNYqAjbkQJgBKg2_4JPfFfMrrQ>
    <xmx:tXuNaWwTnO8ZKe7q_5lxBfCPzfZxhfEsBUvyTxeElSm2dG4GO6KohWFp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 02:05:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 080aeb64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Feb 2026 07:05:23 +0000 (UTC)
Date: Thu, 12 Feb 2026 08:05:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] CodingGuidelines: document // comments
Message-ID: <aY17sNHtr9ZM9qOr@pks.im>
References: <xmqqikc3t7hf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikc3t7hf.fsf@gitster.g>

On Wed, Feb 11, 2026 at 11:17:48AM -0800, Junio C Hamano wrote:
> We do not use // comments in our C code, which is implied by the
> description of multi-line comment rule and its examples, but is not
> explicitly spelled out.  Spell it out.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/CodingGuidelines | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index b358d6bfb8..507d52b0d3 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -439,6 +439,8 @@ For C programs:
>  	 */
>  	_("Here is a translatable string explained by the above.");
>  
> +   We do not use // comments.
> +
>   - Double negation is often harder to understand than no negation
>     at all.

Makes sense and looks good to me. Thanks!

Patrick
