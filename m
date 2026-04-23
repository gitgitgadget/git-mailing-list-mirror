Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ABB3DEFEE
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776934352; cv=none; b=IcC0fiM1E+JXbvp7qed2aHYDn1lpcXAermUkVhYppvOEOUnE2tbN0xBaY5ON3jG19u6rjknlyw8PWp0Y2RVLWhN9u8MjtLbnbuocghuvz64zRk9A9cDGY0iXtM9vkO/amLEQlrUkxyl4EoJSaV4PokcAwouPZC6bIHO3C8qHfhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776934352; c=relaxed/simple;
	bh=fNioFE+3orobuRZyJA2l57MCWy9R+H74mr5Nj5Xfhqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qz4bkDQP5964FXG5LJQHjl9OAtDqFDpCRohZNwtvXKwTHAT0jEmnaWxhaXYlqV6zKM/6z15HEvOMofW/xwJT4vaWkYpPy0qJYGJYVVIWa+dqRj2zY8HKck7FAbPkCuQvJomvKIoecXnSLQ3JO6WjpPnrDKxQsa3HVMTEIA+EFuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wrcd7Th5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QIMQMUux; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wrcd7Th5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QIMQMUux"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2E1651400065;
	Thu, 23 Apr 2026 04:52:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 23 Apr 2026 04:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776934350; x=1777020750; bh=jFja50kMMz
	5nfS0tFlM/ACdbDREHjcnYGWdCDl7fNUc=; b=wrcd7Th5+fVUN8VdTMGHou2YmP
	q80IfLOzGsAZ5HT3ZTVb6AbY0O0A8K1YMTdr4f5vqERqwoANhrdLqEOLcVQ8sXaE
	IArtnRZYesVLC+TcMTwgANanlqkdeK7Ei5YbyXjTV4b4AK/sVXYd38nYXLUljLAx
	5ZB6yF8eyWITrIzxE8xd1auQ9p84S0R6gRXpwdRN9eeRPemKXATZXTseKXo6yyU6
	M6pYDetTmqdAPNLeBCcQ5CQS631JesB5+vn5bqkdREAJv25WaGfrXZAqYFWwSgw7
	F/AIkPFrMqGWPBXo+dIJwB5CZATgFeh4mnmM5JyrUsu+V0sW5yCA2j/Xkn5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776934350; x=1777020750; bh=jFja50kMMz5nfS0tFlM/ACdbDREHjcnYGWd
	CDl7fNUc=; b=QIMQMUuxYlPaoGGwkji4coLu9CSlgohxA9YatFI+QcMfhgq2GxV
	u0E9PbrfwHbQKSsGZBFyesxeB2ccKsi2R0dEMYx56ntTQQQBlR/nh5OxQS5/1BeT
	j/RmNvo/KiId0LAXw6FkQ8Hevo68XvW0ch1zonXc3HodyEbjQHeclrsffm3MZRq7
	+CjDFZVzA3zBntIR0TNpRe5L0/gys1mC4nivR8zdo3wmOC1bNMic6xEVEllAy0Df
	hlhNyJV1zqrru2+GOKc66rq1oCJb8NBV7LElY1CnYK5aohUSzqOSVcNmViGVw30g
	2Y88wNMU5ln+300su6gaaj+YpYDlC4qLQ2w==
X-ME-Sender: <xms:zt3padCprjiqzUfkFGbTI2KHN6w4bC7IpVj8v7VwqdNEKqZD_r96JA>
    <xme:zt3paS8lgazHBKUpzlHZhzYvCV4PIwo3_Dtol9kLBW7DH7PMQw08iohL_heWVlb-v
    YLpGsuEtURI7iRMKkWIn_2QK8_8Z2PGOxwqilORgn6-4NloSil-yFg>
X-ME-Received: <xmr:zt3paV8XN7iKq9cLx0DXXkP9qz9cXSOEXogXbNiwxv_ydiKvvqb6cAulXUlEa8SP_H6mm_-85JbNxNInU8zKJKjIG4Gvcrr2o6Cf2WCvcFPN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiieejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejtddtgeffkedujeejgeduhefghedtgfdtieduleeulefgueetheeludegueeuveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:zt3paRfR0sT6XPyAG7dk0G9livUN58bBEO1IVsaYcAptD6Xe5yV63A>
    <xmx:zt3paWEsM1O6o91NjtFOe_h-Hr4RgxeH6QbgzHl7Hnpo_DgX3nWCZg>
    <xmx:zt3paXeMpnihu6XXFklMdZBm0rn372xDU9JJFuRyMlUEOY_3pCam5Q>
    <xmx:zt3paYHCox5qXopzxpUb3bNbwAL4Tkwh_BEssnQwcAB1b4jG74XAxw>
    <xmx:zt3paS-AEF01ZobL0iXcFJdm5RFBdw9fcb1-ctBvoqYg70rlK816YEvC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Apr 2026 04:52:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4513d8a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 23 Apr 2026 08:52:28 +0000 (UTC)
Date: Thu, 23 Apr 2026 10:52:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 6/9] update-ref: handle rejections while adding updates
Message-ID: <aendymWafXrTblbQ@pks.im>
References: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
 <20260423-refs-move-to-generic-layer-v2-6-ae5a4f146d7d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423-refs-move-to-generic-layer-v2-6-ae5a4f146d7d@gmail.com>

On Thu, Apr 23, 2026 at 10:40:35AM +0200, Karthik Nayak wrote:
> When using git-update-ref(1) with the '--batch-updates' flag, updates
> rejected by the reference backend are displayed to the user while other
> updates are applied. This only applies during the commit phase of the
> transaction.
> 
> In the following commits, we'll also extend `ref_transaction_update()`
> to reject updates before a transaction is prepared/committed. In
> preparation, modify the code in update-ref to also handle non-generic
> rejections from `ref_transaction_update()`. This involves propagating
> information to each of the commands on whether updates are allowed to be
> rejected, and also checking for rejections and only dying for generic
> failures.

I noticed that you didn't address my feedback on the changed ordering of
errors I posted on the preceding version. Was this intentional?

Patrick
