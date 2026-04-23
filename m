Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E803D29C327
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776934347; cv=none; b=rBaw1JUNQ6o/kWl82qi40SH4D+N8w0ej5Cukzxy5kG41brJ+8FN2QzgSv5M7lqVWXpdeRYMGgBgyuo5SuILcPUjHlnJKyOEje5VUTfBgoBQDEgImnK3vnuo/EFvW2y9Ssm2n5+YqlUB6OruqO7KiM8OGdQeFxzhNJ6wBnpo+kCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776934347; c=relaxed/simple;
	bh=v/CpKFDCc+HrylxzeFwvBH7/8jcoRYf1rml0rN7OnW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQr/4O0Nyp5oFgIC536CSqjf+MYvczbsFxM3BYRVBW4LrLvG0ClQ7IexB6/gUylcxaSy6OT5RJs4Iaw35UGxwkwCDfeFRJyTGmFoNpdIKPVp8Crk3L66QqEkpR4ZsvwhwfJPm1iKJBoaVxM/6le9pveIdSAKt34OhUC0rq5vcXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=wsjpB6AY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QbqIiFYA; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wsjpB6AY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QbqIiFYA"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 2BDEEEC00D4;
	Thu, 23 Apr 2026 04:52:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 23 Apr 2026 04:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776934345; x=1777020745; bh=v/CpKFDCc+
	HrylxzeFwvBH7/8jcoRYf1rml0rN7OnW8=; b=wsjpB6AYdEwYxS9Vw9PPf1P0D5
	JwzYtv1WIFoL5wvry5Dv3ZVFad1Rp3CvP969mwn7RTIiPTb5FLehUxqqfZlNABSp
	cChq4rklh8Yoz5Kc7QM8ckBk96qDxwRgUqwL0EcDK+5yNHfJ7szhKpFm2q+ATg0z
	t8rK842iNXtsXgMa+6U0xnZV1e2ajsibM+Mfl2OCT4pNHqof7GuIscwsJmpe73Fa
	ODmnpxOj3hy0UyP7rG6a17K00ubo3e0Xl4RD1LT5xxAYBbVa18OYjjlKCfKWsCdv
	om/lKyMTXz19k9bOSzpSNEi0wYd57+26Gc0fh4Lsq6OBYCddt+qq8NoW5BZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776934345; x=1777020745; bh=v/CpKFDCc+HrylxzeFwvBH7/8jcoRYf1rml
	0rN7OnW8=; b=QbqIiFYAZr/fkx8IXrV42B7VqslfqE31+05Z/le9ufwzloBj2fR
	Ya2vgybzRKz/Z9i/U8v4I5B9RimFYMdpEioJNUODDMUR8aQ9foCrVtJtsSC7oaDE
	/nbv1iu9dvgu97hxXJ1OJu/x+N7UzYP3yzzJFYo2aV1Ag26ULbIamcpWx2NhDwZ6
	s4YZLA/UCiH3LakgdXHKPstOEfzXrwjvlzT8JcClvJzKWM08CJaKuMmEh9rTcSbR
	GCDuOgVrG8Y3aYf8THs3XH5GvHKkl5sMlzvW1P/jl6bkjwBsoXuhoq6hVLX6Z0N0
	EYZ5Gxx0OHmzxWDitdUVf0HhwJxyfwTJfFg==
X-ME-Sender: <xms:yd3paRr2zZypLNnxajQ6MTPTBQNFdQrTEZ5RTA_XOSo5mtcllafBMw>
    <xme:yd3pabEcl-w1u-lfFyuprFubX_mOdwF-9cInClj4QYKB1Mr2i3f-iXOYO4BLFM8vm
    Xa0p3xtnE6Dh6ELne49Uhc0lRGP7s6FBoVgfuvBfzLeKK00Z5Ud>
X-ME-Received: <xmr:yd3pablFyKXjS51mxrQXrGWVfpj6R23YEkcqVkjyZ9xJxmcp9Z14BXnu1K0vRezmhm9IVzCHDEKnnTWnV7rGXfcuYHgesLo9oszDupYrpqk->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiieejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:yd3paWlpQCImsFzCgmxq65E-SDMrTtSVvGOSd3_Rb7HBmtLGwpAbAg>
    <xmx:yd3paUuzThm4C0rE6HVq7Z61EW-zLy2MPDCHyZlLG_LzUhe56is9Ow>
    <xmx:yd3paRk6TdkqP2OAtj-a5v3vnDFi2RAZADTW2OKa_QV_Jvj_UIWzkQ>
    <xmx:yd3paXs885I1aWfG0gFhr9nMDG2b_nAz98o7VFYCePQbTwDBQU5VFQ>
    <xmx:yd3paYO7Dv6zBxDengzdpHnYhm4oEoifgrzbYAAt1RuHCq2J0D-iSRjx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Apr 2026 04:52:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 58769d8c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 23 Apr 2026 08:52:23 +0000 (UTC)
Date: Thu, 23 Apr 2026 10:52:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 3/9] refs: extract out reflog config to generic layer
Message-ID: <aendxRyd9kTc2WC1@pks.im>
References: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
 <20260423-refs-move-to-generic-layer-v2-3-ae5a4f146d7d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423-refs-move-to-generic-layer-v2-3-ae5a4f146d7d@gmail.com>

On Thu, Apr 23, 2026 at 10:40:32AM +0200, Karthik Nayak wrote:
> The reference backends need to know when to create reflog entries, this
> is dictated by the 'core.logallrefupdates' config. Instead of relying on
> the backends to call `repo_settings_get_log_all_ref_updates()` to obtain
> this config value, let's do this in the generic layer and pass down the
> value to the backends.

Great, this is now a ton easier to review. Thanks!

Patrick
