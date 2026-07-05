Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADD5260580
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783268402; cv=none; b=kKxQCyJgKRsKbAfSZ3DN9IxagO3pHc4XJCOKXOwrNuZtAaSd2I+R6/5pmuFDOgCDbzgCW7n90aujMVfjR/LeHtdFRHAqi/HITSNJV8NMfr5d8d7gBjuvxhVZ1rpV51+xxES945zftfHJMfxTo9zPqNWwqJg0otbOJDcy8GjItMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783268402; c=relaxed/simple;
	bh=AhTrbUoPJWP542+I1yMX+Jkxn//Q0U6/0AeKiZByUWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NQpIlKojC866YtbuwbqzKL1Vu/Rn4UYxAB9R9yfp6ex6wlucadOKIl30GPTIg3JdKdCMYA5QAeDXyAEUYFBJmCOy8Tpq4el+qL1mQzS6UKLyw3Gh5tWJFOjK9xY6X2T5UvkDtN+eAfDJi6+wk9kbZEj76crsw/Q90HpgM087vW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rv9l+oVY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F8JxFHDG; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rv9l+oVY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F8JxFHDG"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 330471D000D8;
	Sun,  5 Jul 2026 12:19:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 05 Jul 2026 12:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783268399; x=1783354799; bh=H4jgQeQPf9
	EQsG969c5UygR6tvWd/v6zrSrVOrBDAv0=; b=rv9l+oVYvamUX0GsI8u3DYWZjg
	HBNn3zTQVCPOSX5NpuhIJcXuR9idIYuJqcL4talZ/NEYlkwj9Wl0oCSVyPaEUMF2
	T7pVkm0vXzC0FPhOPbKm0+tA++OBmEt8/FBvp4Qg8yutFUIalX7nYAkz2ekXvqrL
	aYknMtsXRpvE84FPqWnnptfYnEgK/GLtLG9Hc25L15vF0pwavR+YeYQPPvgaJfoO
	YpuVK7yY2c0uSDNsL47t2T/RAoiyw6fG+W54CaGl2hFpp10DWjiO88AOsbH0iYjH
	qZq3MPBop+ywIgDptiVCfAy6PgnKqkPNwBdEKwFJtE5Wx+74/00AJkitrYFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783268399; x=1783354799; bh=H4jgQeQPf9EQsG969c5UygR6tvWd/v6zrSr
	VOrBDAv0=; b=F8JxFHDGCqiHUQmdLBp0YXp7RglG8oxrNocZXNpb513RLJryNJ6
	aHOzPefT6+2VFaZYNV8Vg1ANWQ3pZDN+svfoYjNXWRhABtxa8E6vG5FzqNPJmgMI
	EA6PTWVTG3tVcP9Jguc3WBFGSqHV3NMlQXXN23QFopB90Cal4EA2BIWnsj3BoGxn
	0mrohP2GFUPIE1ioEDlM5h164IORF5GAq9yEz8haAF1oyBlqhrsxfbGiQ4tmhNDp
	FEbp4TMZg43yDiec1E6Xy1MHU0wZeq0NgSVkUgQWzXMh57TrDtWLnWnUbNgOiUKw
	2gd+9pwpIaAbjeKHUxagweWNgCESAX4p3GQ==
X-ME-Sender: <xms:LoRKauetZHoM4K5BGyaNVIturM_SgMOgdEWirLSNzrKCa41zecb_7A>
    <xme:LoRKavqM4eW11VUZmEcXtH1KZD9ZDQtnPN_TOFI0eE4LUppI1ehmpUgOx7Z9KaPir
    IMdHx9SAy6LP2TFzOebJonc1TumxpS-oj_55QaSfReJsa9FAEVhPw>
X-ME-Received: <xmr:LoRKas6qp3ymh81uGY8L7Q2GWQcC8wlUOBdcSIiY_4yg84a59trcazeqBdfEl0AQ7E3-BwG0a7CGH0Rdy49zFr1OR1N3VrkBNQi8KWQ>
X-ME-Proxy-Cause: dmFkZTFTr6xQtxk7IXvrFOQMGsTiIjwhTY517mPF3n/1vRf2ZsZN0266EcC84KE7Y18tRu
    Cq+xHQujDsJW5Sj2RqPJmcpxGD7Im1nSOyzgcmkCn467GyD+gs37DzrX8DHLGjD/oVrQgD
    MpI+BrdSvgMHNXq8p+VoDcjjtPiTgSJwSuo/nJnGluusjK/T/OA/6VHJi0VYvYHgnWqlbm
    PH9uBwyg434oGttLNT6Y0+SL0u3g62sLuZuvYKPktlbAMKaGKmS4h3epRK7cjKzeFyN6Sl
    bTQq7lrdWQzh+vqtyZyPT3Df0IpL2HuK4Kfql8r11uLHrxbY/0cHHxJKYG+uyyGBxjYDkL
    st2K/y9SU6GDgDN1YVJH8HzWJ+tIFHILJnmmIa5fYU1G752w3jQs/ozyORU8JNdAIuxHP0
    trUU/+WClvWCsKeXCPzxJ8YkDngffSUGmh1SZo9nLc0mGDFREdjUPwf7CE0wK49ddT0h1p
    NxBL66BnELJsJoXXsi3yimB1P3V1AbZvytbqqm1TyEmrM/OkGyNLPYkIc36+PtlF9vT36Q
    /U8/0dLyretts8i1hUk90sWWWKsBcARYdWH6m/F19/MxyG6uB8oQK9mGbecXuRczITyZcJ
    VkA1rPvwokBg8ShRyX0qZtmILaz2rKuuQeM4pTqgVQ17UcY/D5cqaV/IH44A
X-ME-Proxy: <xmx:LoRKalpRi7kyCUz-PGO_ziHvwlg81Rx91waRX8_pz7pXVAKRcwtW5w>
    <xmx:L4RKauj6waA9vJ0P1gjC4jzrhgdBma2urZGSkIbY5kV6H__m4MRoHQ>
    <xmx:L4RKavLFdUIa6mbOOKySPlIdXP-jL3g7XTU2g-AW80ZFHLwNg69Wlw>
    <xmx:L4RKauC95-CdAustWooF55pA7G4Jom5crh737gWfj4CyLK9jNvYCFg>
    <xmx:L4RKarpzae9fRLVaunu6ChGZWTVse581GhFhgj0MMf-1Sje6UREll9d8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 12:19:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] diff: give --compact-summary a short synonym --sstat
In-Reply-To: <4fa47057-0a14-4749-96f0-0efd3d50386d@gmail.com> (Phillip Wood's
	message of "Sun, 5 Jul 2026 14:42:18 +0100")
References: <xmqqldbqdpri.fsf@gitster.g>
	<4fa47057-0a14-4749-96f0-0efd3d50386d@gmail.com>
Date: Sun, 05 Jul 2026 09:19:57 -0700
Message-ID: <xmqq4iide7de.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> ... this is saving the user much typing and it clutters the UI with an 
> obscure option name that could plausibly be an alias for "--shortstat".

Fair enough.  Thanks for a doze of sanity.

