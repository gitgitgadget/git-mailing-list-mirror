Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AC9EBE
	for <git@vger.kernel.org>; Mon,  5 May 2025 06:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746425443; cv=none; b=UoG5p3Fa5GVGFFEP0VaEuR3QK82vZ3ZhB2+5RiKwaWzvzO2L4JuK3u2o0LEiiyZPJQ/cO1wJ6r9fBSBvtVAPUEnx8TVH1GBv4pShMK8AbCwcEgsYnhRhDD4qB50K7y0TDGDt18gTe0RWgNOyDmLBVhOl5FnXf4kNJ+/YfX485As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746425443; c=relaxed/simple;
	bh=q37fUeai24N9OfmdE2SCj1RFmkwhGSobP8cFXFwX784=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1DIwP7N2KHezLgm82bKyNQffRNKcfUx1PnkVME9/MnLFcnGiKPAhLChh5CQcU882oiPIhcE7qtwDBc6f1OdIbgVYKr09dEGwJ0Td3XvXrve6c3+Ebwmiz8hoxL8CwvOTqG3rwZoR9izdFBQoyqADRtKv5+FHrzXBV22yM6DC34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=zaoVTIYq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AYmjvFuM; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zaoVTIYq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AYmjvFuM"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B42AD1140180;
	Mon,  5 May 2025 02:10:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 05 May 2025 02:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746425439; x=1746511839; bh=jEV5JjtnJh
	RzLkoq4mZbOMpDtqiTYWs5hSlo82CBcuA=; b=zaoVTIYqvJ+y4L9ThNGHNxqdHv
	iMlQSmVEQY2Gj/h8hAAL6Bhh/vjKT1TthsJBmbjF03yZWyMm1yCUYPoAAvAOh0dv
	j0b1qAG3C5skQFsVGXV4ENpaIb+/o2OIKXDAU01K5FrkxB5Y1e/QiXok31j9J8bI
	Q067iNbGPXjoFhje+2D+jeHwn9lxqYa6pyEs6fj4olimIB8dXDZYS/bAvJxB7YdN
	gD2gXxZtFjXGgQ1m6jEGdvkCxoBUSX+8O4IoeRn3AvPO+sZjc4k42O9q6fDMRPPF
	WjrpXYflxOxyRQWUVOAcdAKkgo93Pn1qZ4x53tEflFz6IwbDHwwjrOkhPSxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746425439; x=1746511839; bh=jEV5JjtnJhRzLkoq4mZbOMpDtqiTYWs5hSl
	o82CBcuA=; b=AYmjvFuMKj5muvfW/BO9yfiU7isRspJb4haRumsDOAAfgRoktkK
	jou1gX30eXVP0tU3Z7RBGvg/eruyAKjmvk2EdTLF8qONQwqkeXunx3ZdaKVtI7Z7
	5Jv/MG+qXXOw6k8aqfrwRWdLRf4OO8+tDHU4RVCfgqzn79RKN4zsbq8yCuPFFeK9
	eBOZh/kHNDcsn11fgYSpvUXC92C8kJe+pEs5VrYagp9EB5GZJMUCOVTzQuUfP6UU
	7bUjYqDkLOSOvcnARc8gCbHZkXF7L3h6rN0thM6uPvT94g2qoGGUcyWZN43QdzM0
	K13O03K0NTXWmmo08yBECuu1MlU2/N6QrMg==
X-ME-Sender: <xms:X1YYaBTPCZTjZDtOthX2pFCg5h61KU3irb2tAzUqSgJoXPOhpS4a7Q>
    <xme:X1YYaKw_n14eWDq-bkMFayEsSUmM-4Ni3QtP4bgc1TRZg79bTv60fYKA2iiktSEgx
    BzDcJpxoQROng_HZg>
X-ME-Received: <xmr:X1YYaG388i56UU2hoU63mlj5MNxAeZT9FyGuWmQuf8A7Hh71v4QOnsuP4H-Y3FjbrZwLHqgGP68DQoOBTCzjSTbF7ilLJqWPioIYv0RaxQj2iA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedtfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:X1YYaJDUnst2k2DfUWej0ZsBAw2GNhHmdE9nOz0fXelJ2KFMuAAVuw>
    <xmx:X1YYaKilnXb7reauk8LkdzwSy5MIwFW4UjX_Cpokv63nsJZJGUbGQA>
    <xmx:X1YYaNoUuwts8l-uS9yvnHhnDOBK3Uf6hzY23N3V81P6nFfS7O8qZw>
    <xmx:X1YYaFhO-cr1_UUxi6vJ9kyYZOa2QVehTJfUZeZpsXt31FNcwS-PUA>
    <xmx:X1YYaFQDmGZ2JFKIdFVYcZHCsJCSb6efKr9DFzJsa0hIoRB2fxl3BvVe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 02:10:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 621e3661 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 5 May 2025 06:10:37 +0000 (UTC)
Date: Mon, 5 May 2025 08:10:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] whatchanged: require --i-still-use-this
Message-ID: <aBhWXFj4M9Alj4uw@pks.im>
References: <20250501213452.370729-1-gitster@pobox.com>
 <20250501225958.2947677-1-gitster@pobox.com>
 <20250501225958.2947677-3-gitster@pobox.com>
 <aBSLgTlfwSc1u_bH@pks.im>
 <xmqqo6wbufel.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6wbufel.fsf@gitster.g>

On Fri, May 02, 2025 at 09:49:06AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> >> @@ -656,6 +665,10 @@ int cmd_whatchanged(int argc,
> >>  	opt.def = "HEAD";
> >>  	opt.revarg_opt = REVARG_COMMITTISH;
> >>  	cmd_log_init(argc, argv, prefix, &rev, &opt, &cfg);
> >> +
> >> +	if (!cfg.i_still_use_this)
> >> +		you_still_use_that("git whatchanged");
> >> +
> >>  	if (!rev.diffopt.output_format)
> >>  		rev.diffopt.output_format = DIFF_FORMAT_RAW;
> >>  
> >
> > I think it would help potential users of this command quite a bit if we
> > explicitly told them what the replacement is. So maybe we can extend
> > `you_still_use_that()` to accept an explanation?
> 
> I doubt it.  The reason why we remove something is not "because a
> better alternative exists"; it is "because everybody *HAS* switched
> to the better alternative".  If we need to educate folks in this
> message, the plan to remove that command is still premature.

That's a fair point indeed.

Patrick
