Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733D52BD03
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759509000; cv=none; b=fLbUZ0nvaKJk1Cn3jNNbtDkY/4jHSbu18O0r/ArPCwgbhZeUFr4laYEFr2o9aApVE7v2/VyTT17XpHy3OAwyqrv3cSupxjNuv+BmnJbrZUdEgFaKWwXrq7ozu3Ugi2For1ptS3CES6A6hgOIbTVwI6lkNJrbVvn5m2du5ugGvOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759509000; c=relaxed/simple;
	bh=4gjSTadApCT0SeLE5rADRDZTvXlcFM58tOcv9hadejo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j2hS9CYbkGhOmvtzjuYMmKVxede2nGWIHq7WLIPAC4/BiCyjgGqjNGcy1yTJxHJ3bc9Gsf6H2yxCz72TPfEkUOTgkOh7qcZitrSc2FORv4hxZ4s+4apJ7LHsjZiYzKnKjECt0hB/EBxx+gnqu1aG5GELxY2Ys9y8G67NVifTTdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c6yr7vIY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K2UJtORt; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c6yr7vIY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K2UJtORt"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9FA561400192;
	Fri,  3 Oct 2025 12:29:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 03 Oct 2025 12:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759508997; x=1759595397; bh=oQ8h+bBIKW
	qWw5+GJEorsFer2+rkx6QtCxXhh6YAD8w=; b=c6yr7vIYwlhpqXPIQAw8Jghitm
	uLvpSUlweq3fWqG7Q4rbuAU39NCbZjl+5GNZPe1VseF4MFsglNVH6U+wItrGCAxo
	iCL6esyvxugUf3KwELfcHWApl/8U3NLflphQAFkYRbLdvo/uznXSaHZzBZ2BHTti
	PbcExtCBWJamtH2W+w4a8bl+nAF7ReVB0cmsYtnS4R8HeQLojfo0lJzFwFE3vUth
	s/vd+CBIad1yQBlZHO3Cx7YmDVLgpSInNCy689Idx6WPyHSnCe8EOSSi/GHrUPG1
	4xHqyX+M8ncRswZmK7zMXf37DpNbTo7YreECVSI/qEnBqF+pS7Czc0RwF47g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759508997; x=1759595397; bh=oQ8h+bBIKWqWw5+GJEorsFer2+rkx6QtCxX
	hh6YAD8w=; b=K2UJtORt52eDNbaZvu6gIZwwvoFBMPjPgm9ExL+G1aYnes6R1Dm
	l0Y6s1rpVpEol0EfDO1Yr4VuJ7/Nl+wH1+0TnAAGEw+NGXg0QSqGPRjq6Gzp7Ydv
	z8/qV07YGOqnTuxa68tXHHyZCHj5Nbu3loTGy+P9xiKtd9u+igiHVp79Z4WPSp1/
	+d/SU7DVRyF0goMCtUh0MIjoUbznIae2blpyekpKQOJ76ATBppEV7bKpojnOBXZG
	Naun2EGNlXlApEJz66rNH8SZRMCMZk0Q3xrYy6ERGrR4Yb60JhbfVh6w+Lzt3fmk
	n1BLkcBBWVuaiHZyGQAVD7CUbCu8Vgl9Stg==
X-ME-Sender: <xms:BfrfaCtuLvUuXl9ImxoclvpK_N5IRprOKKJfwss3RTkHPeSt_KvJYw>
    <xme:BfrfaOVwkBC3R60PFzQ8rOWH7l5Hcpmk6eqrKUq-u7WJ3RQuGPXA8TKd8bshQ-im9
    zQ5mk8wKU5ucey01rxfFYNWrPKWLBhP6mRP8A66EK5pwa7kFw1zyg>
X-ME-Received: <xmr:BfrfaGFiHB-mZwNWp4DQY6Gq5ZvZn7YmKenEkREkj0-N9K9NH0oh5NV-zowvurQ1b4s0BeAk1ci9kO1A2R0jnqJgZh2b9Q7sbf8P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjh
    hnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BfrfaI0zhhS9PoIL6fcNtfqAVvU0ppcDsxPRKLshGpu9vwC5LQZwxg>
    <xmx:BfrfaANehlA3haGo-C66NYArd6PkL83jajPaM24YGjEvoC0HoN3VrA>
    <xmx:BfrfaP4SbUogVI3ZK_fgCS73VzINDTboUc08aXMeax4vQNh6rC3xrg>
    <xmx:BfrfaC2S4svuUr4FDwZ8Lba8U6BDL5eqVs9C076vrhatoS0N6zGC1g>
    <xmx:BfrfaA8M5Oi25yv9dyqzibn_xzyUkrtJcURq6ogxpwcgr4rc00-m_L2M>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Oct 2025 12:29:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
  git@vger.kernel.org,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] doc: change the markup of paragraphs following a
 nested list item
In-Reply-To: <20251003034134.GA625140@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 2 Oct 2025 23:41:34 -0400")
References: <xmqq5xd5aqa5.fsf@gitster.g>
	<20250927195032.37223-1-jn.avila@free.fr>
	<20251003031113.GA6381@coredump.intra.peff.net>
	<20251003034134.GA625140@coredump.intra.peff.net>
Date: Fri, 03 Oct 2025 09:29:55 -0700
Message-ID: <xmqqfrc0uews.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I think to appease both systems we need to put the inner bulleted list
> inside a block. I think that is OK in this case because there is no
> inner block marker to worry about. So:
>
> diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
> index 49a7598ca5..aaea8c107f 100644
> --- a/Documentation/config/extensions.adoc
> +++ b/Documentation/config/extensions.adoc
> @@ -55,8 +55,9 @@ For historical reasons, this extension is respected regardless of the
>  refStorage:::
>  	Specify the ref storage format to use. The acceptable values are:
>  +
> +--
>  include::../ref-storage-format.adoc[]
> -
> +--
>  +
>  Note that this setting should only be set by linkgit:git-init[1] or
>  linkgit:git-clone[1]. Trying to change it after initialization will not
>
> on top of your patch seems to do the right thing (no change in asciidoc,
> and eliminating the regression from your patch). It's a little gross
> because we are reaching across the include to realize that
> ref-storage-format.adoc contains a list that needs to go into its own
> block. I wonder if asciidoc implicitly opens a new block for an include
> but asciidoctor doesn't. But at any rate, this is the only way I could
> come up with for both to render correctly.

Sounds good.  Thanks.

