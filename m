Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CDF2BDC23
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 06:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759991786; cv=none; b=kUvq++0gAfn43AwlnUuAxQ6qA49WDWb2KQMyzApO3QSNNfVEIdpCSBTmQ54kNrZCSEvXqCN7T4cQ0rUYxWl/n2o90XUwWdFXLWx3m5EIrO0MqE0ySoEZ+FW1vyvJr1ncNsG12qASRRywpXlnMsgWUDfACmr9b6vsbohwT3NvYHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759991786; c=relaxed/simple;
	bh=R7EAbNLflB/yGcAdbbABwlDELvJhXH+fywG19cNU4hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d57E+L5yf/0Brh3BSfmYWnpCDHQkDg+AvXlNkT9ewBARY956u5iO5hhXHwda/ZNdWqpg34qNo5H5HSDT5lhLsIEPrEelIiZl+H5wf+hxRwLsOC00RRkOUBOv7Rh48R6stXuUD9nV8QjKiViyJ3Sanl8MohhVmxjkbI6J7Ca9xMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nI2atbuZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZyrPlxm/; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nI2atbuZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZyrPlxm/"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2A23F7A0091;
	Thu,  9 Oct 2025 02:36:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 09 Oct 2025 02:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759991784; x=1760078184; bh=MGKmMVUq4c
	/s8XDMR84lIpj9P1p4WbcIXzlTLTZxyGY=; b=nI2atbuZeV/px4/bHja9WjUMDD
	JeWFMT74XIr3T1QjN/uTBMv1jxgBjOnvt/tG265M5rgr8HMhfWZA99GdarFgWPq+
	4u1E0JdrB4lvbZP+rFwQeeHOdJ5uV4R2SrYGjOsfM4/fm3CcDJwJxBDw/iMC9Zmk
	r9lBv+KomjjiSGzcChmgk2WyzuGspOIYRpbUuZX3LI45/AULqJVx282synjjIc/L
	WMk27IVIlmMUZ1ICZsmm3o0ZyLRxmZXPrCY1tn2t5B/fjbTSvlWLtHpWo68YNUlz
	sCFCr/nN7w0sbzXZH8qlQx0FOHPPNzxCnE/LTuF9PZs3TGDzwhOSS+PLxOKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759991784; x=1760078184; bh=MGKmMVUq4c/s8XDMR84lIpj9P1p4WbcIXzl
	TLTZxyGY=; b=ZyrPlxm/ZTxcLpervzEiJJqx6XVfvAf2LOhO04BC/F2WYyrPzOb
	tqJq4SOnrnOHScsAIKc24lhUOR+E8jUwEPOupnqCRzHOJl1TAp3HDO5xxXZ5EF9g
	duT0CpkbrVnh+kLpUl2TVkNlJiGnonQ3BvKQXbr16rvhJJ4LQiFgp9uwt0Pg/6rS
	5ao4Lf6EI6FvyjeZKUKfXVrFbXL27XNJSmX1wm57qYiaQ9XeE63H3J+6rhRTYBPi
	fkkxagW4uUja4I1viD96/02QqnGfLQnXv+68Qn2vvV3ZpN3Dq4qcV6WJ/EC93YSu
	XZTP1/zuZw2PdB8Nw6omZpXS+afD+gasQUw==
X-ME-Sender: <xms:51fnaGT9sJuYXhUA88guuWjIbIcH9pKUJQ4ccy7nJUyX23US3GeTnw>
    <xme:51fnaBxbx3bsGfsNfWJM1Z-czHPa_zYiczIxrU4LSM4uo6X-FO3UM2m7M6Aa1fefn
    JXbOcUfiYjQjYgAx5RZI9D71hmbO7y7AbNyJ8We_RqVLqk18OTQpQ>
X-ME-Received: <xmr:51fnaBfp1SibIlsqSEeGPzV72NNe8IfvOKe2bxMv2aUKgPlBj36U1z0iPCfX4keKWz-fB6G57cZ1yioZVoIH9O6A-EDoyTULI_zouVDIYLo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdehgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:51fnaNIxjY3jyx83giom1t50LEqq0mK_tq6zqN7AwggIgP5i2it8fQ>
    <xmx:51fnaCFgPxOud1DwozYbPKpsMrlwPA7-UA2Ztr7OdePAPFs_WAwX5A>
    <xmx:51fnaHp_XfziDDIjj67HprLrXD35Qz8VxciOsSgTV5HiY6BqaAiYnQ>
    <xmx:51fnaLSVY6CXDtAcEvDFI5LhylfDZMKxwafPZGD6WjqRdvQyEeib-A>
    <xmx:6FfnaFZqvQzhDZTQNbNDk1T7z0hA-qI_Q5cF5Wht_kCqHyOA7E3FQ1de>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 02:36:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fcf512d6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 9 Oct 2025 06:36:22 +0000 (UTC)
Date: Thu, 9 Oct 2025 08:36:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] packfile: rename `packfile_store_get_all_packs()`
Message-ID: <aOdX4_e9K_1p1pyv@pks.im>
References: <20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im>
 <20251007-pks-packfiles-convert-get-all-v1-6-428227657a89@pks.im>
 <aObOFciwYsvTWT0e@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aObOFciwYsvTWT0e@nand.local>

On Wed, Oct 08, 2025 at 04:48:21PM -0400, Taylor Blau wrote:
> On Tue, Oct 07, 2025 at 02:41:12PM +0200, Patrick Steinhardt wrote:
> > ---
> >  builtin/fast-import.c  | 4 ++--
> >  builtin/pack-objects.c | 4 ++--
> >  packfile.c             | 2 +-
> >  packfile.h             | 4 ++--
> >  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> Hmm. I wonder if we should perform this step at a later date. My fear is
> that another topic in fight might introduce a new use of the "get_packs"
> assuming the old semantics.
> 
> Merging this topic and that hypothetical one together wouldn't produce a
> textual conflict, but it could introduce bugs where the hypothetical new
> code expects the old behavior.
> 
> Perhaps I'm overthinking this, but figured I'd write down the concern
> nonetheless.

I think that in many cases, a callsite that doesn't handle MIDX'd packs
specifically with `get_packs()` is almost guaranteed to be wrong in some
cases anyway due to `get_packs()` and `get_all_packs()` influencing each
other's results. In this series we already saw that the callsites handle
this correctly even though they use `get_packs()`, and any new callsites
would probably have to do the same.

So I don't think this is too worrisome overall.

Patrick
