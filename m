Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B6329A5
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737739066; cv=none; b=Gy88xV+G5NL69g2NsSLunoqikFuUY5m6O6yFXalZ/GN7nXME3ClAVRR4SS+YrvQerp2tTIZdDAXvqsZtIETi6so9cTyysPSK+oXVj7k8qJ7cPFRn2e8exT/avIQ5+IBEbGS29YaJ8WK3llP5PSMaJJBNOdH8r5GOvnJs+Cn6Am0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737739066; c=relaxed/simple;
	bh=sz5IbeHuhElSHZNYxvzv/sKMOhx1FB8lNTPobDCA+18=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GbuuItfFEr6cGO+dW7m7jb8dSMJscBu01D6q8eZ9/8p+vtXXU957ghSMvr71G3tLjjcJVJcBW65eB8DRKt7LKUxa5K2f+XQDlpwv7lyW3FK3yw3ZMfNEXZVLDdEPXPLYKT0iGFyq7e2/wPp2JLSDIJWgJkkHLaid6Y+1Cm+nAoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fNgj18nO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Feqsimwt; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fNgj18nO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Feqsimwt"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4497811401A4;
	Fri, 24 Jan 2025 12:17:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 24 Jan 2025 12:17:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737739063; x=1737825463; bh=31mfEIQKfe
	NqiyfcDRkwpjVf5/nWwLbDIfkoWCgmEEM=; b=fNgj18nOJ44qP2c7ymgvcSFXgq
	d+1olILVMX3YNVoV7qd+79mqKzCujGbLLzu2l+3GuML6CG/196Qg5LiiLFxnKpP5
	SAt3qihMvu+PIX8MmMNb3ZtKLNeQZRk7W6ZbwEEdGAz2entUyILpVTIq6y144DMX
	1DK5rCXJMqoOC1R23Ka8vGcyvzdGYs73LNyd5l97urZPJ6LRrzUDy7CdIhCY/3sM
	Sjf19cGHnvE8bKfyBxMdUQyG9as2+9y6GtDkBHbVh7uw/spam9zvx+y5YsoJ9Kfo
	dGgDNuULV1SE0EbwW61/EJGAanYiXT6DhR7Tnj/h+R5ipkG7VwdX62G3btvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737739063; x=1737825463; bh=31mfEIQKfeNqiyfcDRkwpjVf5/nWwLbDIfk
	oWCgmEEM=; b=Feqsimwt6caoEYM+UyCy++r9iOpgNPcVpXAJl1iVUFKB9vKedJy
	N9dwb0SxEwONGRhGooRb7FYQ6XZURJWqKKtKK2TRwqaNAi5eHOS/7zwT3DiBskdl
	Bfn7DzgomZOiyddn1yxJnvpLcWGPoIzMJJ8Zuw1SUUNNumZvHkcvbCLTUk3xGOjZ
	+d5NEiHdVBTASnJza3Z+ce66SA9QOMpHt38iQullA3xdkMH09P/g2snh0F2ckN8q
	McCCVxV3XAdrDu/4nTgs719bxEwYIunQ7u94VJSb36IXxtOnX0wZNGb5kR0Q8Jrg
	qMJ8ZZbUeipdvBgWFFku2nlQgXNJ4YTFDOA==
X-ME-Sender: <xms:NsuTZ1dKS9Z8UKHUA6P7fe86-vw957LYC5VKt-ofL-uNJQQ77D1hHw>
    <xme:NsuTZzPtAiVD2OEJsm_1uLXSsclJMJ6fpZqQgRhT587fk5QvRMbEfEiYTx22Ppu4y
    gtBL8E64vEAH9fXqw>
X-ME-Received: <xmr:NsuTZ-govz-7e5QX-e9EilDwns_WW_xwQaiVJ6oHWorSlP4mfcS542ckBojJXqnCvivGK4P7beyBuseS_1ypGJNYSGdTurL87s0E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedghedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhsthesvgifoh
    hrmhdruggvpdhrtghpthhtohepmhgrihhlsegvfihorhhmrdguvgdprhgtphhtthhopegs
    vghntggvsehfvghrughinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:NsuTZ-9G6A3Bvh3ClmL4IcpgnB_211FoXv7mZZ4KHiyKyXWc-ycX4w>
    <xmx:NsuTZxuyOH6dOqvuKPYEXiAlmY2JQNkkk5TUl8ZChnLfnwrXaDSQAQ>
    <xmx:NsuTZ9Gz8smm2I8Ao_BKrHebSoZT3v-RSNR5pPD-4AwDhgfrOdMJPw>
    <xmx:NsuTZ4PnLX-14-mQ1R82gqZiE35zwkHMPdbqUqRLBgxEPpVQssTScg>
    <xmx:N8uTZ_U09yhpjAi6MD4NhwUh1T9WltiOHVSGNr1R5T3jNf-nSB_xO5kQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 12:17:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Hesse <list@eworm.de>
Cc: "Christian Hesse" <mail@eworm.de>,  Bence Ferdinandy
 <bence@ferdinandy.com>,  git@vger.kernel.org
Subject: Re: [PATCH] fetch set_head: fix non-mirror remotes in bare
 repositories
In-Reply-To: <20250124150745.105593ea@leda.eworm.net> (Christian Hesse's
	message of "Fri, 24 Jan 2025 15:07:45 +0100")
References: <20250111202628.0e5894e4@leda.eworm.net>
	<20250112165125.130400-1-bence@ferdinandy.com>
	<xmqqr04tqm86.fsf@gitster.g> <20250124150745.105593ea@leda.eworm.net>
Date: Fri, 24 Jan 2025 09:17:41 -0800
Message-ID: <xmqq5xm4168a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Hesse <list@eworm.de> writes:

>> > ---
>> >  builtin/fetch.c   | 15 ++++++++-------
>> >  t/t5505-remote.sh | 10 ++++++++++
>> >  t/t5510-fetch.sh  | 13 +++++++++++++
>> >  3 files changed, 31 insertions(+), 7 deletions(-)  
>> 
>> We haven't heard from Chritian; has this been tested OK?
>
> Sorry for the late reply...
>
> Yes, with this patch applied git behaves as expected for me.
> Thanks a lot!

Thanks.

