Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976D749504A
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549140; cv=none; b=Rf//AFu9ItddCUJMWStRrGq8oHRucUyXHQDp5vmuP8AGSDuS60Ta5ZXgE1ojij6xyDkvoU65fRn1gZOz/Yzp4230qdaZlMO5sNryQ2FCuNdd34XHnOe7KWxcHwHh71yMxQHGhXvcXKsoAQWePYnGrsHh6/+P3DywuCMmj1NSgjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549140; c=relaxed/simple;
	bh=V+OoLRQEwYfJYmTlqun0UTuTc9pwGnF0WiN9sEqzE1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mCLy2F/UCP9KhVxZuKQmNI3GZchfWRZoQro672Tg7Yw37ViKKL7mG/qSO+2PgijszDPJtT3cOqhW+hW8d44PQwk9W4E8Np5WXGMGmR16se4t1YYxFitnxA4RW9azKSorVUXsNGZlel+kzSRx7dv+bBaMHtkaLzhE1/vaGcP+zsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fudcnedz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RwHQBgvM; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fudcnedz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RwHQBgvM"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id AD676EC01F6;
	Wed, 12 Aug 2026 11:38:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 12 Aug 2026 11:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786549120; x=1786635520; bh=yviJw6Wa5R
	ebMmJ/hmoyAad54RA+/+JwNyUIVWgTjqI=; b=fudcnedzx8L7O5sSyMCxHSNltI
	oFMc39mZko3JI7+Nm6T0cDcfdguIEoQxGJIBIjiBZ90YcZPe0Mydck3FyPznX5rV
	7tkWl2lQDVMwV+JeggO/Bn7ca5OYGIZrQMQpxwZEjrGxMJ5GodOHstjjPQvbWiLN
	U+5s+axTSe57kbqTKF/onR9i7Mflb7lfvpd1PdNIRDT5+ZNIYfxATm934VMh21u3
	5jAd3Zi8sYCFqeSuhvQuuvh4NDrs10PY708sALno25gPWhqvwWEfzJIzN4kV6075
	bPhznOKdTHgk/nok8Qmlh8LpbVpcVmkqDyGRYjcmdF3Sp/UDD7UhVN254P6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786549120; x=1786635520; bh=yviJw6Wa5RebMmJ/hmoyAad54RA+/+JwNyU
	IVWgTjqI=; b=RwHQBgvMJ1lKAPrge663zTxpe3I9xFunTDaAmjLbr034Csty3Hx
	YLev1mqa9G6vyNbw9XqfF1tDMHtCXIzGVnd9yl3Pk5JUztTNzfpd0Nqv6FTbepMO
	zlq579ZcMjQPir/30nXGImlhSDQx4AstfUXXPu+TUGZWuZJ0fuibtVf8w5nIIcI4
	MofJ3N5/qhRRiVuMr1RDQOqhKdz3DsC1Kprlaq6nwdycesf8Fc+Vf4za94A7So/u
	vP5shUSRJgc9HQHBEMlzWuKAACaELj0bh+9bnVcvv6HubYynLB82YXTD2qgaAsST
	fu8KaB+EFy8UXMeMwB01YKIKxLyyUE/ovAw==
X-ME-Sender: <xms:gJN8ampley8xb4Un8B2A-ag7ArxiYUVK7gxj_OZkYYCqLp4NrXOsXA>
    <xme:gJN8aroqjuHfFqUHZTkeOqnF1C_ZTIWs-p3Je1wkoH4o-8dlEz_lr9_eVs2DvN6XN
    USljNPww4orCR0VmUtF4mr48UKtciwqX00Kb-j8aOfv2kDh5fhrlM8>
X-ME-Received: <xmr:gJN8agNbTeFCaswmenmfDmuf7CvWkvED2JyWd6v2YYm15jvwLwZeNJZ0uAkEixTkGRQT2P-HV7cPgEt4-9CmAf3XbQDdOnh3-A>
X-ME-Proxy-Cause: dmFkZTGvvPuNgXiu8GmSb5xeTrCx/ADam2V4E3cIg324W5YNHrtXNjflPWOzh6lfuygken
    wmkSQeGbJeL/ShObq9sP2d7gd3yo0tnhWOmiZaVaznS4JZHcR7C+Z097OPeUi+IoCuNeNX
    CfgyJGIWFvUWLJUTaQFcn0EvAfcpD5K6rX1B2JspGi5Srgun5ovqLgUQq8Xq7fXEJuStOH
    fC0REmJLO5HYhI+MyL7PCZIrXBRYB/VMEmvYy7/3NWA85FDfPozwinuH48tJonBRi8TrCt
    XuQ7HdQMnZboo4FQFQEgLgUraJoHeRhNiC2fOcJZXU9SNAHTZVrrSN6W0xd1YU6XWkqCAa
    4wlXIZsC/w3ziI1CWBDK9sY1qz0h3ahPtKI0qvVLaYyFY5aMKzhgxB3h8ZuFv+Tml78yBw
    CINKPS8s4knICVnVNhVxWpeSJmS9xB3Kvst8oK62ZO+on4z9X5i5aXyOkg2I+XTeKRDbc4
    F0spXEP7ojLrJdwELMuvsWVsJxSAwPmR9caOXEZ5HMbC1sJeP1/E0jmtX84nmyB4vJ+H+P
    AeSv4dW81cKzLPDJY7E9WGyJusXCZ+aMH3kjYwOXYz/wGXmbzKdjLKza0Oo5uK1nbdQ3yl
    IKAzyx3/hl9JWC2H/oqArJK5Ppze0xX4FmF5SF7966sTvCIZQGcSmb0ji+UQ
X-ME-Proxy: <xmx:gJN8akyAmMehmL5PXC-gGq2sOZIE5Slk_zreQHrYd1_U2lle0NIOQQ>
    <xmx:gJN8ahsehNoZcYUoC9hKYb0jsAcLBL9jOFxzeiI4YPsuYg8YEOzvZg>
    <xmx:gJN8al5hxzZs5gHnMOnXEqzuN_hxJeaDCU5It_zNxuJbp6bqQeIEiQ>
    <xmx:gJN8aoT88UIhMl7QNaknnp7B9Xa4d7RuIcyZZV3S7pD7hDYrzvIQnw>
    <xmx:gJN8avtCLH0GYr7eWt0aSZKZknQeMj0fljqslTm2Z9KHae7RwDH7hn5s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 11:38:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 0/4] odb: eagerly load alternates
In-Reply-To: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
	(Patrick Steinhardt's message of "Wed, 12 Aug 2026 11:13:56 +0200")
References: <20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im>
	<20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
Date: Wed, 12 Aug 2026 08:38:38 -0700
Message-ID: <xmqqy0ebxsap.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The series is built on top of 010afd3166 (The 12th batch, 2026-08-07)
> with ps/odb-make-creation-pluggable at e927cfeb21 (odb: make creation of
> on-disk structures pluggable, 2026-08-07) merged into it.

It is not a clean merge, though.  Please double check the
synthesized base when I push the integration results out later
today.  d296c52baa (Merge branch 'ps/odb-make-creation-pluggable'
into ps/odb-eagerly-load-alternates, 2026-08-12) will be the merge,
unless I notice and fix a mismerge in it before I push it out.

Thanks.

