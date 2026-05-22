Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31102287247
	for <git@vger.kernel.org>; Fri, 22 May 2026 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779430344; cv=none; b=UroqMxCnJPFu2S6dNgFscbGd2+iKe9cU+OnZRjlvpLeWyJZY63qXx+8J2iWNovnHAaq3TxH+QltmKOJZoOYMGm96YIjMnE3zxO2lg1MT/sr52ax2RYlARwHVlJMrJqHGGy/1cIaMT/b4iVpufWUu/N3LCUfyUpCd7vRvTwKDdnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779430344; c=relaxed/simple;
	bh=P7U1AhYN3FHVcsjaS8SVfnOPOJtQfKUu6eJNixOXpWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Alg6S2DSoklm2YmDxJavf/WxFdqiVtpnpF4oojnZ9OkLq/yJ2C/N1E243LvlqjtDw88ndHlCzkZz3mtn+kz/pBakLdE27ojSvAFv33ns4GtxZISrmtyTPLjEQcwOil+P84Gm4b1ZPD8sj37khvHk2klsBypp6lLIfdvDiYdArqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BagTag+5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uo7bFlVY; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BagTag+5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uo7bFlVY"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7CCDA7A00B2;
	Fri, 22 May 2026 02:12:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 22 May 2026 02:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1779430342; x=1779516742; bh=9vQF2XYeiB
	CDFJlOol3Vue9+1EV7GYf0veC41UXrKks=; b=BagTag+5bh5Wmppn86YNMOOWIJ
	BQ1JUsgaIAj1lC1n85mj0KRF8509AlvvWQlVVs9JmXsm3Qx8Pvv7Oldk0KNANjeL
	aRrMPF6ggOIMLytrcBtOwLt3daAq9XM6xRINaUIQjQBde7RjgOV+zuzGVxW6Wr3z
	nwGgOjHoO1Y9X0OEkV+/y4qEUdCn+cW5Tc+X5Wrh96GvmluZ+sWD7lrbAjGeckXn
	DVMNF5lGmQ9ylbxPF81BmmWxLsZSvep1S10Mii5vv1f1SdWuAlDDpX2nhZiIKUSM
	6z5ieJkrLGmYQ5vY8xjiOnOCkF6YNqJDTHivP/mD1l/tSCTgslgybrtnpJiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779430342; x=1779516742; bh=9vQF2XYeiBCDFJlOol3Vue9+1EV7GYf0veC
	41UXrKks=; b=uo7bFlVYVKjYog6sgWM2I804vJzw/9TfaJrNydgvc8z2zdT/40t
	fCXzq8aBKt/Sc/lre//UgLeYJxQTxxmJi985AvJlDO00ystCC3xX3cfACVBranSN
	wfA0G5uEosWpQM9sEbg70KLRPXwyWd3iLfAB4+axtErC6Zt/smOrHeLJts3hwa6X
	CQNTv7H/zHvO/V0pNQY61sV4NNVWtFK4i8tLtykGcoJvywQpHDFq47Xllo0UUrZc
	M2nwg4Rv8OaIb/aGfMqP6AwJkTlVBQ8wqT/wCWiV/4c/RWWE4JHTZTJT4Oh1xqit
	LeEPR1FiggWmqfw39XDY+fH4TPJ+h+Mlrlg==
X-ME-Sender: <xms:xvMPakITlA-mzS5wrCvF3qRLjL00KLqVEnxzXpOBpgPi7fbgurzkBQ>
    <xme:xvMPaqIexYA1k3Ar2_L2yfxFM05dO_9YZSnMdYV-5g7d6bOh42yDkic7JJ0lf60pv
    7Xyzw6fuyUgcZ-gB0z2T6r-mbGQMUrBqTmfEbl2GqCpHijK7cM>
X-ME-Received: <xmr:xvMPaiWNFNuC7LgvK7BW-BgnqmBi8C6Ea7uYlixHs8V_npf_hifC3RHNUyUoEGEvkHDD5g2BkposDRGL8KAphbPTZL6GKxKkKJPY3Fkx-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeelheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xvMPasifhRqwuoOmhW2L3IrzWPy0wWzivajCX_hI8QWoEcvzXgqAkw>
    <xmx:xvMPat81mf6fM5Th-LKU1dkfdy-wvYmbDOPssklhhF3rjXiSNqaGcA>
    <xmx:xvMPamA1zrYIt2bUwJilyuClBQE6fMfHAHqaolRyKnRqZGP92huSsg>
    <xmx:xvMPaqKs1Wk70-9hRMO___n01b9AKNaphDTu5O3JdMgW6dnZPaef6A>
    <xmx:xvMPanjqjfmFMGUqc10EO8l5wn_D05w7N35_b7OcQolsZkY2edFyO9uc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 02:12:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 778da8a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 22 May 2026 06:12:20 +0000 (UTC)
Date: Fri, 22 May 2026 08:12:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 16/18] odb/source-loose: wire up `write_object_stream()`
 callback
Message-ID: <ag_zwVpvjig6XbMW@pks.im>
References: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
 <20260521-b4-pks-odb-source-loose-v1-16-6553b399be2d@pks.im>
 <xmqq8q9czm8r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8q9czm8r.fsf@gitster.g>

On Fri, May 22, 2026 at 02:49:24AM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > -int odb_source_loose_write_stream(struct odb_source_loose *loose,
> > +/*
> > + * Write the given stream into the loose object source. The only difference to
> > + * the generic implementation of this function is that we don't perform an
> 
> "difference to" -> "difference from"???

I guess this is a difference between American and British English. "to"
is more popular in British English, but basically not used at all in
American English. Will adapt, thanks.

Patrick
