Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5EA3A63FC
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 08:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768982969; cv=none; b=NliLTZerAfgeYe3p+yA25L+OEIrSR6TNj4GAPfmu2wQDMb2FxgiofcwixkDt992TxlvKdCr/A5cNoz9cQZ42VMRO3fYCuZyYvqKZQJk83OlXTQw5BFMcGXNQ7M39BxkAVhJlYzl8nm8BAd6fnF0PLhkFjz2WeK93kb57IExPijU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768982969; c=relaxed/simple;
	bh=n9SUu0q+nbAx0jU0+dXyyrtkVGi8BNYAn7QMTzRUjWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8TFq10Y0HrsJ2iT6/+6404h0aiKsG/+tcHHQv2BZOC2tu/EHLY+CTSY/PN6k4qH8kRLv/oBqZH9OAX67OErtYMz12uYafIvKBiDM5H+HPj+LQIW5wxKFZVv8F6MymtDK+zTTrLT1ITVqL+cQMaJBdsjXJCdB9x1bsztpk9RMnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jTylwpVH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o5rCtguO; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jTylwpVH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o5rCtguO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 912F47A0134;
	Wed, 21 Jan 2026 03:09:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 21 Jan 2026 03:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768982957; x=1769069357; bh=n9SUu0q+nb
	Ax0jU0+dXyyrtkVGi8BNYAn7QMTzRUjWY=; b=jTylwpVHp4b6AHCzUjHXpQ3jDE
	ZpLSXGrpjieBt4rfH51eh0s7tFZy8RwFBRIwdnujCYFM0DaYYDDufdntl0U+1mKG
	a5vVQO3G7Zl5OeMp1OYnP+YBUvxCropzcd3JPlWhbCO700/ELeRe31ZDr3lMuRXA
	g7dfGwuOogzilLMU5XoHpkUC4WZZ+bT/Jg71yS2S6a0E0/+FD5g3NElaaANX/5gb
	r5NTZ/HcB6Hn+cLkWfGEvE58ZHUzO+WMmauwPx3YDg9jruK3kOX/ior45TREkT4O
	8eF2Zbdj2IAdDzVRTZQHW9T9Cxdxd1BbSY3OO1dD7wwlc7eRS6+D1DaSyt/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768982957; x=1769069357; bh=n9SUu0q+nbAx0jU0+dXyyrtkVGi8BNYAn7Q
	MTzRUjWY=; b=o5rCtguORVwbDH+2LSq0bvndkHntBHUxxtlU7LQuomrXezroeKo
	rpltyPU+HkjF+b48khOdhj0eisfOpkju0p+LPImoFV6S9gBZQrvJsJoWZ9k1WvFr
	DLUTU+IfqrSpF727+s1xW7l88UzIokHKgrwHf1/omzHJPJFKBCF5YmyDhvUyIFxW
	dI3M8+SCv2uG5XptWJqtg+MBsrJIUv2p5ebjdvLPpiisjCkyC+CUadOXfFnDBWz+
	JYeiJiwm3/6tV1q0Gmx+Br7w5elZyfZmX0HU2wwXd+oNsZRFT4OWu3Hwl2asnMJk
	g0P6yQsKaPBoOoWH+/M9GLodVLszlsrDhjw==
X-ME-Sender: <xms:rYlwabfI-UBPtocVAjuFySL357vHyM0jBcyuNJtVnWvR9nrBAiah8g>
    <xme:rYlwaYrXNIHyYwKY07RaBsNm-2ivGrb-mgrziQLb0ah_mbBe97sFtgWJQP3av06oA
    XN1S-GLO-41e2oOI90z6PwlEeffUbqYVof5UIIDzI9fTLEwd7Vc>
X-ME-Received: <xmr:rYlwaR7K2xDB1zow-zfDNq-D5wiAXVMBaajswnviA8y7ZHnYplu1e4iNwjOK6yZ_BnMh2u0jvDQ1Hc3SlFJEeKGbHO8S31ozf96VSjCyfUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedvjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgihrghnshhhphgrlhhifigrlhgt
    mhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rYlwaWqGnuUEN7oNkgwadHG31OgFTzIIZD4sqFnj7ZjE_InbsyxieQ>
    <xmx:rYlwabjyW3HqWaHu2SHRQV-pYa9hvy6J9QJdAJvDckBN8sHgD0BMRg>
    <xmx:rYlwaYIpaTyojqZS01MpW9o6T1ARpBpT8HWYmdQ-iIo5Q3jpdilJkw>
    <xmx:rYlwaTCCvKHB0itUJv6o_aOlzaXM7lkTy1gzbKkv5EmzLqIQKQwruA>
    <xmx:rYlwaUqSPbMBO4HabCSkQelVkqN8yehU2xRBu8NSkvwA2pIP_j-zqGD8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 03:09:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3e92d74d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Jan 2026 08:09:15 +0000 (UTC)
Date: Wed, 21 Jan 2026 09:09:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 1/3] show-index: implement automatic hash detection
Message-ID: <aXCJp_rGPetsXE8J@pks.im>
References: <20260120140901.517928-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260120140901.517928-2-shreyanshpaliwalcmsmn@gmail.com>
 <xmqqzf68yx75.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzf68yx75.fsf@gitster.g>

On Tue, Jan 20, 2026 at 10:07:42AM -0800, Junio C Hamano wrote:
> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
> > @@ -71,6 +60,40 @@ int cmd_show_index(int argc,
[snip]
> By the way, what happens if we find SHA-256 also broken and end up
> choosing another hash function that is 256-bit wide in the next hash
> revamp?

Yeah, agreed. The index unfortunately does not carry sufficient info to
clearly identify the hash function that is in use, and second-guessing
via the hash length doesn't really seem like a sensible solution to me.
If we cannot tell for sure what the hash is, then we should rather ask
the user to specify the object format. And in fact we already do that,
as we have the `--object-format=` option for git-show-index(1).

I think if we wanted to fix properly this we should rather introduce
index v5 with a header that encodes the hash used by it. Like that we
wouldn't have to guess anymore. Whether the hassle is worth it might be
a different question though.

Patrick
