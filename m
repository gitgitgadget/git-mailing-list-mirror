Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88DE3A6418
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 22:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782943620; cv=none; b=LdEIakojPFXUQGHZCB7G87YoHB8eL7fyT9TnIF0yuE7moq14QsLZvsxPEPJAHvaE6M9C8Zwwa6rM7lXEAN/HgJXljuhCHaXaHLxtq3jr0WKy+b4Dfrv9Xr36VPn1+zvw9EHgpdnYPvNYsS6Cq1IxxyPygZWgbTruYDs0I5s9zys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782943620; c=relaxed/simple;
	bh=p2KgyNqKfv6dmbqElXM5154qhVZpgskLgmex5BoIYOA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q0/hcWkJzxIkLDsbAPqCQfAE3Cn4tXnWNFQTvY9cSDyL4e3UIvsXvGirAI/pDPzC31AE9lETKJxMqdjOMK+ErbAsZeWYOKTwsEbReaT1EkkO5GWa+wGzZwW+qnowMRt/kqUIlkPWK1Oi04UsSwfwK19Vo/are2gsyQF6hK3gFCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FkBh3ny8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G6fZh3JR; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FkBh3ny8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G6fZh3JR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E05211D00073;
	Wed,  1 Jul 2026 18:06:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 01 Jul 2026 18:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782943614; x=1783030014; bh=I1vJUgVPV3
	ELAadXRn4jOjoVvyyglpzt+WsvdvQVmLc=; b=FkBh3ny8tEXijhR1BjyYQ+GzmE
	UxdejiF9YPcAAeQOMMVl5HuUlyt9vpt6BiFnHiBBs/YJI5UuzdByRsIuoiiB9VJ2
	6NP1uUpllTBUqakY3XG8VdFdiDdRAM6hQiP2XUPs2Y+Yc3qtwL11yvFiCrsgmbLr
	gWLeeEjMxZcC0j1jcMCoh54CFzY38TKXrvVmjOUaPbqW0+1VOxobeyzUD6D7o3Yp
	gU1MYhjGHt03NIvYc1MsPpRDe7lRufDdyxiCs75c8NXVXeNcSvzqR7R4x8kWvyen
	IEApU20VxsytqnoT/oB1WVO/+PGOGdFvXm0LdAxnTAg08FsLn64Qo/boNLaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782943614; x=1783030014; bh=I1vJUgVPV3ELAadXRn4jOjoVvyyglpzt+Ws
	vdvQVmLc=; b=G6fZh3JRTmVuC28KkhUXy2NdRRz80/GerBKfvxpPdG5be7LsTKb
	J97kqE+vgY5hZBRSPCi/hnd1MSP3EqCOSGret3p565P/g5sTW4W1VjefxJTvt1ti
	/E7AKgN5QoyyJUSQdamZjrPmVD2K6/wQtR4Ju3R8ihPVNaDvpbONxy6IAS7IPzie
	NPFr8qdLFxvAZc19St0tjQk0nAKzcNsYp7nzaSJt/LnmJ284D/EeM94Pkhx9ErFb
	aVXmutb4ftTn7C3vMPWIEDiHNNzo9RGttx264n5blcx2xTibXjuhm8QFXFn7hrle
	E7hTODwpec3S83dT68rvRB1faGx5NvNbGSg==
X-ME-Sender: <xms:fo9FaoMLaqIzTx9KWVmfthNlKsqDz2DJOfDfbyHdKWzP1v-zLM4OwQ>
    <xme:fo9Fal9ZcQd7fhWgAqSfCya0YGSxFVnfhYO_ApYougG2T4LQB9ziTYTVrOImgmZ8I
    sml1pxwEkXWZcK1L7ufbcAO2IM6AhEz0rDXPZV2f5Yq5ch394IFMQ>
X-ME-Received: <xmr:fo9FakR1DDUG-7IKi_flyqLAg1HfWQ7Wyy1oBRA32k6gUXlyi_oOTX3U5_pY6gT0F-msp11Hh8z_SzszLpeGxYsBSqoI99Coz60DN6M>
X-ME-Proxy-Cause: dmFkZTGNZ7H1kxEQrTvdkNM8dy/Nm3CrwvnvlOvfoJUunHjv/mtFvLV8TYTr9FRiSf9O68
    +3yNnFEvqaqubVHcT0H1lU8qUIqqifDXvnjPexj5aEqGe1EaaRnuo2b74nszQEg/KuOHrs
    NrGhCeOsbtOuFzun4vrp1mRV02lEtME6QnlrQHyR9hun4cvkoXyRfW9/FjLVW5abJW0+x4
    TXmmMKISN7i30wtJGK52uNpcPgZQ3qPIjlDVTCagG9MQQ/pqDJtDdWL+6peA0H2K4m5LlO
    2mz+4rKc3/A3OCLmd8Q8cqvohBGVekoezdFiC87V4d3SleL2/zL8HiuriPIncLDL9QXrEb
    ZHuaS5CIxj1OQsqDlaWfdjFsuOf64hA4JKZ0BnfDcHGdreZEDgCEltMKnCFhKX3qBFkQpl
    GETifwxyVkAdj+cb2dvfFo4lw3oS5v/wbr7vZ1cCQ6OmMYcDa5x6rBJJC/7kXp2Rqk8Rr5
    oNTowuBylJkLDwVinqf3q9xXjUneKTnJIpAmurLE+tljC2kxSP2GvkhUhuPJig/J0Z2sdi
    MAJVv39ymSCP+z0XFDzfb9GAl3v7+5uxtsK205Nwxsr8Zq1+jao+2ctTMLITfBoBVEZFL+
    o1enid1KwWzqPGQl4e4rRQT1mDo3Q07tq1t2E476xZlHcKyepYG9lJdgeQdg
X-ME-Proxy: <xmx:fo9FavkTebOreEG1AjDsjtijiP2QAxs-32zAmChkMuPOydnsK3PzVg>
    <xmx:fo9FasRsTDdFS3f6lXSSiEGXUjHaqERMJ0qMvyD3s3ukOOSJcnoVKg>
    <xmx:fo9FalO1iMAO1lPL86fMCWz8mzGCWVNE1C4FkaCc-ggocrVuEkuNAA>
    <xmx:fo9FatXZjHc0lA1qi2BwRXQvaf0ESm_Xy4xXl6uCftCm6URDpvVW9g>
    <xmx:fo9FahTJEJvJ3ps7JorML1lDSq9nTRXbRTVxeq3ns7z7ZsyuBi796j_H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 18:06:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/4] rev-parse: exit 0 on --help
In-Reply-To: <20260701212442.1430084-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 1 Jul 2026 21:24:38 +0000")
References: <20260316220742.1286157-1-sandals@crustytoothpaste.net>
	<20260701212442.1430084-1-sandals@crustytoothpaste.net>
Date: Wed, 01 Jul 2026 15:06:52 -0700
Message-ID: <xmqqcxx6mkjn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The standard philosophy for Unix software when a help option (such as
> --help) is specified is that the software should exit 0, printing the
> help output to standard output, since the standard output is for
> user-requested output and the program performed the requested task
> successfully.  If the user specifies an incorrect option, then the help
> output should be printed to standard error (since the user has made a
> mistake) and it should exit unsuccessfully.

Hmph.

> git rev-parse --parseopt properly directs the output in both of these
> cases, but it currently exits 129 when it receives a --help or -h option
> on the command line, which causes its invoking script to do the same.
> This is not in line with the usual behavior and it causes scripts using
> this command to exit unsuccessfully on --help as well.
>
> This series introduces some changes to distinguish the --help and -h
> options from other cases in which we print help output and adjusts the
> exit code to 0 from those two options.  We continue to exit 129 when the
> options are invalid, which is useful information to have for callers.
> We also make the relevant changes such that `git rev-parse --parseopt`
> does the same thing as long as it is invoked in the way specified in the
> manual page (which a quick GitHub search shows almost everyone does).
>
> One of the patches is rather long because we have many cases in which
> we've hard-coded exit code 129 into our tests.  However, the changes
> there should not be complex, only somewhat tedious to review.

It is borderline for "yes, we all know it is obvious that things
should have worked this way from day one, we regret that it is not
the case, but it has been working differently and users' scripts all
have been working with the current behaviour, and it is likely that
they will all break".

Two big things that make it much less likely, saving grace, are that
this is only about "--help" (which is unlikely to be a part of
end-user script), and this makes the invocation succeed (if we were
changing from exit 0 to exit 129, we would be breaking tons more).

;-)
