Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5262A8C1
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606499; cv=none; b=VzDEU2cp/M8KjQ8ENKewuMKqkR5l+Q/c85v4V6uSVJH04aM1m0UioSQ24GnNbqJeNVrtR+7O4vUaG42Nl1Hmk9gvvJPV/j6q1pd5tmi2X0UvHrxLqj1Y8qHPWuRPL+UChe4Ng42lFC/Nd3YyfcLS/02gvQ/8I5dRnoZMqcJqYk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606499; c=relaxed/simple;
	bh=LiGk6YzbHPrZfmNPM4gfTJp/F7PpuBuOVYPBp7KF5Ss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LFbc+qvxOpueanYZ2Smqg+y98qOGote3arjet7/dobCYSys/uihzQ++sMjx5vg0EoS6XLR7gHITNQ0JdEftZoXWC6vGmZZU+vMMkmi6c8c2KZKCX9GAAqJnFHKl81lIGU3JUVh8NBcyRNjl+lFwTxvP1ZKWOn05hrG4/q/LtjUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Lq++K+7H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZAO257A4; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lq++K+7H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZAO257A4"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E13AC7A0348;
	Thu, 11 Sep 2025 12:01:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 11 Sep 2025 12:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757606495; x=1757692895; bh=NI+F2nTYlv
	uQViVnyg7L0lokQEIYdohWEZOWmxFvUgs=; b=Lq++K+7HnTLGk1tFiVaV5RBzyu
	f4Qags2bPjrWTUdveVY3sB7rfa+N4QIownDAUKkQ3YY9b+8OZEmy70w8JdLC41nu
	EjjTCwqwRBJ6+A0mChxs506FcET0nWzzQxEJL5XW5rNyswCFo+FyOLkdU/b9PygW
	QX9jrUIg+sg4doElo7km79J2R/G1TxGkioeEDcfNAPuLp0k5icV+WW9uLFL8ug+E
	d5r2n8fZ0nuLwQ+pFq+BEXP3Ws/HdQjclcmcuLabxEfb6UzDNug8f96YQLKSOfeS
	/iDLGp+/aS214gz6Ehxf0/9nz+WlwwfoK7igbCPEkY9GRuA2BlXzAG5YfTdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757606495; x=1757692895; bh=NI+F2nTYlvuQViVnyg7L0lokQEIYdohWEZO
	WmxFvUgs=; b=ZAO257A474EN8cpx4gCh/AI3JJGaWfd0nPBY4ydF3CxE9JQKHBr
	qnFWKsJ4zDiRAajftudMEGkU4XGApVzSNv6Zc9IUGd3zIMpvDbbsCay3vZu0pL3q
	uud3Pzc36EpdPnVKMo1kn61VKjEpUuNJJ1yfdvGEk8i27OumB8JOGLfuSEabypVV
	U44Ykrf2uaQb3wpeyNtp8Ic87W/iDR3NqGEy5tvnY6eEedsNerJPx5UxCQ9K6SV4
	J/BKrpWxWzlXog3qcpklDtW3tU0VeXpnvmArunHgoqhTYKzs4J9tI43b9WiqI2La
	qkHH2hZsy9a8IVrf3JuZYp7x+Fx87DAMd6g==
X-ME-Sender: <xms:XfLCaFm4pn68cazvWnAv0oPvGl2zXoDeTiiJBaNcn1iJoTkDi0aDmA>
    <xme:XfLCaGAC5_5YP7aKO5vqV6B_NovC0AKsJ2W6kfUmSEDCTPchgKv5bcxyzitbEKMK_
    wmHczhSdBhd6_s2BA>
X-ME-Received: <xmr:XfLCaMhAtmV0Sf3-vglpvy5n3cgpmRs1QQ-pcHx0vF17sVkSilu3p8qJfOdkfH0OS-QEowSMrtEye_Rn_dSMgDzUfUK9wMeiygUzCdM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvieeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheprghskhdoghhitheshhhofiguohhirdhlrghnugdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepiigrtghhrdhf
    vghtthgvrhhssegrphholhhlohhgrhgrphhhqhhlrdgtohhmpdhrtghpthhtoheptghhrh
    hishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehprghtrhhikhes
    phhsphgufhhkihhtrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:XfLCaLyV8LeDgNEFvRrl3pHDsnvB8enQ-_EjPZ6Xsoy8FThwcdo14w>
    <xmx:XfLCaF2J-rsmj7pxRCI26WV-rjmtW94Zx57qtyMd5Ysp1etC9QJvXw>
    <xmx:XfLCaI_f7-8Age0J5TcAj9L7BN-k8HKtI5i0bi4rXxjAfbQNsIkW7g>
    <xmx:XfLCaFpfXdPe0UeXmcsmC89S9211ZSxjkthLD_YV1BGycdVT97ckyw>
    <xmx:X_LCaGVPy4OoE9uQ97LWKOCM9jIjnKF4k3NQxjcC3R_FGE2qnKW8oaYY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 12:01:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Colin Stagner <ask+git@howdoi.land>,  git@vger.kernel.org,
  phillip.wood@dunelm.org.uk,  Zach FettersMoore
 <zach.fetters@apollographql.com>,  Christian Couder
 <chriscool@tuxfamily.org>,  Patrik Weiskircher <patrik@pspdfkit.com>
Subject: Re: [PATCH v3] contrib/subtree: fix split with squashed subtrees
In-Reply-To: <dd71ebee-8629-43c3-aa2a-40124400f262@gmail.com> (Phillip Wood's
	message of "Wed, 10 Sep 2025 10:39:00 +0100")
References: <20250824191048.1938340-1-ask+git@howdoi.land>
	<20250910031124.1807856-1-ask+git@howdoi.land>
	<dd71ebee-8629-43c3-aa2a-40124400f262@gmail.com>
Date: Thu, 11 Sep 2025 09:01:32 -0700
Message-ID: <xmqqms71ou5f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Colin
>
> Thanks for working on this. I'm not particularly familiar with
> git-subtree but as far as I can see this version looks good.
>
> Thanks
>
> Phillip

Thanks, both of you.  Queued.

