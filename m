Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEF637F8C2
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633156; cv=none; b=eQ8+FxNIG45x3/+qJm7bpe/2eERFHO2DSnMn9bYOiIdl4FP7Ztho07z8yeM2XlSbCbyf57WOoHdSg5b5mEmRtuy1OC1sBiyHMiMKJr5MjxI4Merbs8q9LQNAbaDMOyGSpECUaM2+YZnbQ6LS1o+Dh6u/8ZF9ltORal87R+1YQyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633156; c=relaxed/simple;
	bh=ynTMLNf7iHVh9Uu4UfzGECqNbwFMRWoaHm8CpprsKJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QntgdO6efuFRydxpgblweT3crI+sxiRdMpimJAJ+jqWb+uD/Qr+twHmyY2jE/JW4hf92d2Sudup4KjWJYIe7cuelthtqedwE0KcXgc7uNQFlnn2B2hKOkMLp+eWVF5l4LA7G40AZBM0A7XcuHukqFJXkqVQTaY7kH7lM/1So+YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gIEJ8Tmb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QssxIkiS; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gIEJ8Tmb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QssxIkiS"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 87DFAEC0450;
	Wed,  8 Apr 2026 03:25:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 08 Apr 2026 03:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775633154; x=1775719554; bh=uEsUG+yIDG
	KW/ymUSHr3b5iaBF79Ce6n9I87/Woss9k=; b=gIEJ8TmbCW86F06USAza/zdggH
	6SK0dKIF04rsSnL02ch8ApGUbSuwzti8S+AywFzLtmBc/8IVwk5ZmJ7mWQEdusLz
	dSKjHcq8kaAUoiFzeeNZ8V0WmLLmrosG6oux369LVk1rQW2dU4h/05oG4LW+meHX
	RqWkX7sLr4aYWkPAQ0yjWepc9uhWXTl6BrHEJDfKs8WMGcGPFUb6OkRDmnfwhFfh
	HY1QNZ5RJL5BihIT+R71vn3u44ALLJ+NJMXOv98I4Gkg1eXa1OjACNxp/xypIyKP
	Y9QSkA9gFntjt3eZEgZKeDc/zUpdEfSdUmEyCdNJ1vRGiOFiEzSp7jyxGl3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775633154; x=1775719554; bh=uEsUG+yIDGKW/ymUSHr3b5iaBF79Ce6n9I8
	7/Woss9k=; b=QssxIkiSm4r2lQ5+TTtc1pYej1fick1/vnNs2oIsSRnB/Y1m9F5
	vEVH1R/hydST4i8A/H4+wy0iartGRWYvFtwK/gU1vrtqiWOe8oBCpMliy12m6XeX
	dX9/gNQ7UMb4ibW3Nd3KC+jbamtGWBhtSVcx1IMYhb1qZhI0iMEMqm63aiZRKnUE
	Oz+ZnGjGZWuNbqY5KFMfycyA+cp9Zku6DIHGn12ymR3A3/iq3czra4+hfBhcaLts
	Td+HG8bTYDDvmu0BrW3jdNa4XhlHyHE/j12v9hNGwhuUb3VV8nfy1CZI6jO6/doV
	vIXNCubDCpoe3f4Ce2F2fkYtKSVZ8bewM6A==
X-ME-Sender: <xms:AgPWaWA0Xg5In4fu6GkKnT6YjEiMQVbyjIfJjon_kkwVZN4sxMxUkA>
    <xme:AgPWaX-EfPts13rWQ9FtRiICvZ2rXPExqee4ijanVWsTi9Ht_L7EoPMEYI1eFrFtc
    Dx1_rJX_EWaLK34hwrhDYcr2sYvOqqykHiiKTeYDJVWx0sVmLS5qm4>
X-ME-Received: <xmr:AgPWaW-MoG51z6ir1qqEjFe7o6kQyKOIThoTwEnfiECUTUt6rIW3Ezj_iUFs4OK1EAIOKZKh8QMl5Hevh8f45VzAtimRuR58pfRvGk4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvvdeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:AgPWaecIpvlyQO9TR-yB2gB9mGmGLLrZgbSp7Cdxs1igmQ2LkYhfOA>
    <xmx:AgPWafHPBmnbYVvNEN1oF0QaENab-aNTbIVoSqR1z3bbzxu4r4rEAg>
    <xmx:AgPWaceQdpHAEMTrhzbsh-29VTVHSgN1xQnp6gqNeJ7KgZzDSFwKTQ>
    <xmx:AgPWaZF41expcn9RHu2OrI0LiCdMSjK8VuFHLCsHcraFK9ag8TsNXw>
    <xmx:AgPWaX8j7mLo0G4jSl4vdCi2kcuTa_fY824DNZ4hiqzVzfLU7GEfHktZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 03:25:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 61a55134 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Apr 2026 07:25:52 +0000 (UTC)
Date: Wed, 8 Apr 2026 09:25:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 0/7] odb: add write operation to ODB transaction
 interface
Message-ID: <adYC9Z1sryoepwSl@pks.im>
References: <20260401030316.1847362-1-jltobler@gmail.com>
 <20260402213220.2651523-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402213220.2651523-1-jltobler@gmail.com>

On Thu, Apr 02, 2026 at 04:32:13PM -0500, Justin Tobler wrote:
> Greetings,
> 
> This series lays the groundwork for introducing write operations to the
> ODB transaction interface. The eventual goal is for all object writes
> performed within a transaction to go through this interface explicitly,
> rather than implicitly relying on the transaction to reconfigure ODB
> sources so that writes are redirected to a temporary location.
> 
> For now, only `odb_transaction_write_object_stream()` is implemented and
> wires up the existing logic for streaming "large" blobs directly into a
> packfile as part of the transaction.
> 
> Most of the patches are structural refactorings to enable this, but
> patch 4 introduces a behavioral change in how packfiles that would
> exceed "pack.packSizeLimit" are handled.
> 
> Changes since V2:
> - Renamed some variables to improve clarity
> - Make `odb_write_stream_from_fd()` fully initialize the underlying
>   `struct odb_write_stream`
> - Move `struct odb_write_stream` to "odb/streaming.h"
> - Make the `hash_blob_stream()` helper more generic by operating on a
>   `struct odb_write_stream` instead of reading from an fd directly.
> - Introduce an `odb_write_stream_release()` helper to free the
>   underlying stream data.

All these changes here look sensible to me, and the range-diff does,
too. I'm happy with the state of this series, thanks!

Patrick
