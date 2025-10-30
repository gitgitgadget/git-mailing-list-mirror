Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F5C2DE71C
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814727; cv=none; b=BfRofXov8oZjpSkD8fH18JESvPL0u5kEnulnxWV5hdPMy4NkApc/hNe8TwyhXWwVJVRdzO6l98nOWgVJHcX5HxqvZjdFK4cmnA8Y8HTmHXwsDKN/ijAqrD6UOW6RwxPXxfcyllVv+NZ852Q2wNBCL1cwzEE1+AuQ5euYgPvL4zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814727; c=relaxed/simple;
	bh=9s+2EZkEdx9Rc1FvktafkIE3NLoYRjvdEXU5+Ccd/gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvdi1Pm7LNLYuCk4RYOCZbt1Rcrlixp7IXTP+zXr7t4Nm7lmYTjgCWf72DPXiIry9AT/jnqeV1Vue93XOjdKgoU9y+ACTOxjjSQzE6bnoBcLbmjPpQ32rQtN1KXyl9z4bR4MYlZwzcuEFa/R5OHAhkbNSTMQIeT8ukCFgJR+Igc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fu/t4/VI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LhL26aA5; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fu/t4/VI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LhL26aA5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AA3F5140018F;
	Thu, 30 Oct 2025 04:58:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 04:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761814724; x=1761901124; bh=k8E2DcAyBD
	42r4f0Drwir+GtNx3Lxq0gr+S4UIfBGGc=; b=Fu/t4/VI/bGBh4JsSdZvd02Xdh
	JJiOoQk9hiOJTpDYJYiy/AVQ4bGbSUyy8spm9teG865iKeBdskb5Ikssty7CbDNP
	MQPJfebabjSkfUaJ50WM1iRy/kV94pdlqjhymBRDPsI0n1iAAs7NOU1UD3EuS+qR
	mJ1UJCReIBx5jmkW4Y2Dq4etdFYjijQ/D2lL80AJNMbiIw4QHw2ogDKXUbBWWTZ5
	S9UmBlcFOvB0/rsYCGButYh1uD+ScND4x+BbZ/obzqZNKzzN0ObiCwbxq+85mjVh
	C2Ndyv0qvQh5pgBucKekVrJKA3DdnnI2QYRSPv2NAnHaS7o7cdWu5WAokgZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761814724; x=1761901124; bh=k8E2DcAyBD42r4f0Drwir+GtNx3Lxq0gr+S
	4UIfBGGc=; b=LhL26aA5THZwkgW6G8t3cYk4nFj9tTZmBuyGGRN295qa68icXDX
	fG2driEdhttvOH68r5tGE8FMW16/FqLa5a4diQyIDyD15rM1MNZ6NA+XyVFevUaU
	pAmdiYQW1H/7Pm8rjLM4n/ErXbiryh+3lotlNNDsuH0kPSC9uVbObgwwpX98LzJQ
	U0eubbI3SKtKDbC3TJ6N149VZumodJXsR0aJ36ElSiao9NrIuQmXhcojAwiGYECR
	TwqCH1miYCHHhhffT76P0oqQkKJO1vlyvjrrVqQQC5YNQU6O2iJtCzzFUPx4MVPK
	skvjje8CXtZbbUKJpjyemEr1s0Gj0bdIYAQ==
X-ME-Sender: <xms:xCgDaVI9by03FJBAGkxO-KBW06TG3B1q5znSwMO0Pea6jbLd5yfDCA>
    <xme:xCgDaYm_3p78naOgIVvATZ9K1zH-LaeCpgNoUp2bHezvujbGbAsfZPGCFWnmA4Lk1
    JbRr0BWBfhDkDy1ggL4L--cXdeU31pfvKfBWnPWDZyty0FudAnLkQ>
X-ME-Received: <xmr:xCgDabGrtlmSuETPC93jBoKOsE49CTnPc0bzoDEBenW8Kxo80kLZY2jGfQZBWppKHKz0dJ5HwLHLlkjJbBrjCM6I7YGRzlrYoZySRAIMkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeiudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:xCgDaQGk_v5E32USTGk4lwKpjH6Z9Y4TrWENcwAKmXXWNwRyMbh9uw>
    <xmx:xCgDaQM2EtPYO1SQHQs6svMVcaCT4Mh8O22yuPg44h-fxqBckVPLfQ>
    <xmx:xCgDaXEynaq4rjJ_-FCp1aA9n_SQS6_TRrNwQ2_ZBrAs0P0Wlc_jlA>
    <xmx:xCgDafMJP8zwsiiayr6SEyfMp4t_Iuk9SXXFuwCLZWVP1AaJ7DdElw>
    <xmx:xCgDaWCoeQa-EWDSDDtvg8GY61Kee6KgdUoY1kLflQMaHtDkt29eTtQG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 04:58:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 43cb20e7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 30 Oct 2025 08:58:42 +0000 (UTC)
Date: Thu, 30 Oct 2025 09:58:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/8] packfile: fix approximation of object counts
Message-ID: <aQMov9F59ZFXSqAG@pks.im>
References: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
 <20251028-pks-packfiles-store-drop-list-v1-4-1a3b82030a7a@pks.im>
 <aQKZ7FW925zvscgh@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQKZ7FW925zvscgh@nand.local>

On Wed, Oct 29, 2025 at 06:49:16PM -0400, Taylor Blau wrote:
> On Tue, Oct 28, 2025 at 12:08:34PM +0100, Patrick Steinhardt wrote:
> > diff --git a/packfile.c b/packfile.c
> > index 6aa2ca8ac9e..6722c3b2b88 100644
> > --- a/packfile.c
> > +++ b/packfile.c
[snip]
> > -		for (p = r->objects->packfiles->packs; p; p = p->next) {
> > -			if (open_pack_index(p))
> > +		repo_for_each_pack(r, p) {
> > +			if (open_pack_index(p) || p->multi_pack_index)
> 
> Do we care about opening the pack index if we already accounted for it
> via the MIDX path above? My guess is not, so I would probably suggest
> writing this conditional as:
> 
>     if (p->multi_pack_index || open_pack_index(p))
>         continue;
> 
> to avoid loading pack indexes unless we have to.

Makes sense indeed. We don't need it to have the MIDX prepared, so we
can avoid the function call if we don't have any.

Patrick
