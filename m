Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C9835839E
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932368; cv=none; b=hfARdBy6fuRRqcDsfvlDexUtDr7lCKDNq2g7ELSHKQTjKvRyNGGa8+FxST6/yV0NKAuwxRQnC9Kmuhnmj9nP7y5Bs+TlALrNfK2jpZBpF7srssSgdVntKQhaGx7h5VVAo/9h7FrzFi54CGv4hpbE/qYFAbUxoFZLwyY1Mq/a1Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932368; c=relaxed/simple;
	bh=Jf993rrK9hPRTln3rE0/7gE3HNwOF9ce8EYXtlQiAVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CH+1Gp2CuhgKxqN5PCo02ouObSbWBQWTEjSetTAXo6yLyw8tn1H2FQ4U3efLyRvTBrOfe90U6VlQw4NeDwDWbSyznIo2FPuKS/bPYvBXDjoDLhJcGi9ZdnISpsRZnNhLROaB5GK8fOj99/eSy9VDFH4c5W1O3Sr2/l0v43eaksc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hboRqhsx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E2u35vbZ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hboRqhsx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E2u35vbZ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id BC5B91D001B6;
	Thu, 19 Mar 2026 10:59:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 19 Mar 2026 10:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773932364; x=1774018764; bh=Ck1TasJeOH
	OURhKvNtgw832asuNZHIWThKoaSIyHkKE=; b=hboRqhsxZ9/iFxb0kWNCUwiDxy
	1Low4Svm7MXvLTlTO3xOAfBkhNglX0Fk/IMPNPFRzHvp3HHqZAcPqE+kSAnyggOs
	S5j+T0wll1J3eJilLa3b9o0DKV7TtB84EOivJm98zmyCNx6RxIhVZLfiizF2nPR7
	dxPjtTvOpai9jmKUIgCaaXyKCiFfojVdRv8JPyJvca9OQ6VeRc960U+OfUaSy1wv
	OSNKGrTwnwIRxR4RyVhzX/EFnptpxtItoKzU7S4DAUtV05rCIMjzRHyEk2H9g0LE
	wCEIob7Gbt6LY5TSZeL7o8k0qCME/336doXLZmAr5KqjmpnJm65xve5nxrCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773932364; x=1774018764; bh=Ck1TasJeOHOURhKvNtgw832asuNZHIWThKo
	aSIyHkKE=; b=E2u35vbZsfqzVLm/9s/me795NreKs3NuQwwn57posDd23dMX8pL
	LDT7wE64mt1QgTU3oYReOss4z6sof/gLelGqL8/moeQdMtJ36NA2vTyoDbw2mIed
	YfwqRhlV/u8p/S66InDC379gAupFhkQV1WRWZN/hFIKJMkj213YYtmMX9z65e4EQ
	1LeloMuT2k6sLoqBNQAe76fXxP8buRFcbCIs95Xn+2vwec8pXa+45nSDXAH6jM3T
	v3UDyI13u+rVxqhwT7+t/gxdjKWn8A74WrY6lOhyQty9+Vu3SF1wfx46JIJZfWP+
	d8t6B+S3kylG7tMhodSKMb5FWfqCJWVxy4w==
X-ME-Sender: <xms:TA-8afOzKKEuXBDMQr9EZ7IIXJfSFBk5Amzo_RcB4TDhBqt0kTneqA>
    <xme:TA-8af-PmKZabpvOd1aGEVKwezGmUk3lX17tdbu4uBEKeSwEMEWRnM9gZB5SS3jqf
    M-5-YAgYwyxqagMcMgFx6axAwXrXc_mXgWN-uXEsUed15DB9ARZ6g>
X-ME-Received: <xmr:TA-8ab5fsRXWcSLXGcq5aVl24fi_dM-ZF_nGHzAuHsATjiiWUnmlOYTTwRPnC-yPAHUzZu5sz2b7eeEWolSfqG55LYOPxObcv_rr4kRTqaMa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TA-8ae3AjMetBRzfGr8PMFgXE-2tjSYKJUIBBBR6iOVvAkXqIwfuCw>
    <xmx:TA-8aaCQhbani9E5WplJjDnX-9HDoxKoi6Islf2C8fCuSHXzw-ogKw>
    <xmx:TA-8aY0_5mcbdKSooK9OoUTV7xzobTGhpF5wIrJ7bZDgZigCdc1ihg>
    <xmx:TA-8actvstEqVeVScHNmOn4BLOPfFr257r0s1azitnPATPMl-Gqs-w>
    <xmx:TA-8aam33V-aCyN-5UXKV7lenOFnUHDTOO2h0BlJLypz9GfkWZZLammi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 10:59:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id da6a77c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Mar 2026 14:59:21 +0000 (UTC)
Date: Thu, 19 Mar 2026 15:59:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/14] odb: introduce `struct odb_for_each_object_options`
Message-ID: <abwPR1NgOShKXh8P@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
 <20260319-b4-pks-odb-source-abbrev-v1-3-5ddebad292b0@pks.im>
 <xmqqse9vnbgb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqse9vnbgb.fsf@gitster.g>

On Thu, Mar 19, 2026 at 07:25:08AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > While we could of course add the prefix to the function signature, or
> > alternative introduce a new function, both of these options don't really
> > seem to be that sensible.
> 
> "alternative" -> "alternatigvely"?

I prefer "alternatively" :) Will fix.

> > Instead, introduce a new `struct odb_for_each_object_options` that can
> > be passed to a new `odb_for_each_object_ext()` function. Splice through
> > the options structure into the respective object database sources.
> 
> A lot of churn, but we only need to suffer once and reap a lot of
> benefit later, I guess ;-).

Right, that's the idea. I also got the intent to eventually support
object filters in `odb_for_each_object_ext()`, which will be required
for example by git-cat-file(1). This would require splicing through
another parameter, but with this change here it will only require us to
add another new field to the options structure.

Patrick
