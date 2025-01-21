Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196D61B041B
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 22:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737497420; cv=none; b=EnHCTRjKU93oI7OGL+sIRxWHqTDXd6T8hWuwBUhNJlbq7yfRNTNAdvnJXJO4PWBO2O99WT73q1zp2F+lRX9baVGkWhJS/8R/Qoi+3WORlKgynPnV0qEtEKQiOglbp98NAh6lepgXOtTrnz6eWJgkAgOYwAQOqFIAW73gZ7aDWRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737497420; c=relaxed/simple;
	bh=mb7ZjccvcjJBFNSjUTIuTT+Xo8ApR3oOTsmw9e4r8mU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XSVBLXOrreFzUIPrnuiYGHJIpitouSaS9MhDD8VBntSj/2e05uy+x1xsmbWM3UljJ1LyNxP/ZZab4/42Ia72WwOaGVGD7WofstSGJs2WABiQr6ppI7VzoeCXv39LkQCVBfY5wBPKX5KrWNJXxLgj3EQpAW7EYfrNMBKdyRis7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xsw0U2wc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KxnN1JNR; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xsw0U2wc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KxnN1JNR"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 054D325401A4;
	Tue, 21 Jan 2025 17:10:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 21 Jan 2025 17:10:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737497416; x=1737583816; bh=sle6dyjtqH
	BNuhRhLIbFlm8ML6zwMoWaMj6A4nVADYk=; b=Xsw0U2wcW+eDgpkVFkT/QKjG3Q
	lkwjLvXuYO9goDok271/LOnNuC5KiNweY8fwRWEST83vZ7JgoF6IEGG4irvQjjAZ
	zqwMt1HS+hNHD55Zhj0D+aNAoQrcXpxLcLAI6ah5cQkPMmfi2D/ugz4QcFeky7Qf
	DIPwiteW7Vangz56LkNdxmveCjTrw3sDoA+dJnocEQ+cx9p7v1hrhtCJ0fK107zc
	cM4jUnzCmktjT9VaqSakfvb73D6nJo1VX1dRUTV7u9W+XFLRfIU0XVvWwe1qY7zd
	bQMBc3TDsd/8PIlN9jF2EBY2/zlKV+cNr8qdsRdWwEneZMzOR9cHLjmWKJuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737497416; x=1737583816; bh=sle6dyjtqHBNuhRhLIbFlm8ML6zwMoWaMj6
	A4nVADYk=; b=KxnN1JNRWrvIsQOr7LuLP8HawhS0hz9wKPKUZkjFQYStA+qzHyv
	SCFfX95L+Azxf3yoq6LfRcbpLIkG/CJQG+lLF3O42u/MQU92lBJiNnKUfx7oYcSK
	NqJVp5TRGqcIDNjEytav2te/i7WKFtayv2LdtU6e3tTDgrigZWejpgMlKLagBOX2
	35QMKyEltKMa3UA2Ac78Ugy9c6jnks+VCWyfWm3A3dHfARmnkYeXeoDAWr1v8Dlb
	/2u7AEz/7PQLw7ksuRY0aBLMI4a+DmlWADrqImX5sjHSQKFTj45Itccgm1whlonG
	+Pbu+nuvEENBMCdHyKD3QBJBMylQpY4eS7A==
X-ME-Sender: <xms:SBuQZxittW_jGWXec_-ME0X7Mqb75D-8k2KYpNtPim0WO6uR1VC3MA>
    <xme:SBuQZ2Bf9HNDFT_FI-nv98dQQEoLuRvHJOLCCvzLuQ918jTSQu-YJQLwF4jZMP1k5
    haxnrNfGcifpg9oXQ>
X-ME-Received: <xmr:SBuQZxE0nRCZXvfwD9yJVNBaQPzO5SjEj9d8UTDQvpJb9kNZAbHiCszq17erC60O2TMny3ywK_0X0B2RikWGWQ9xP7xZxc6xerRV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejvddguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjphgrlhhushesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:SBuQZ2TdRVLtFR7rsQjlhQvkjyRBopwmjMOGCrbAA7qKmoEeVjVZKw>
    <xmx:SBuQZ-zfGtkj_bqi3hlNRjw3c4yg3Scg2qSDfJliqEeUmBAErAHHKA>
    <xmx:SBuQZ877FSykrC5L6SZmD5FLIFrG2ePnjGXVqpSpLuqGEUS8t6Fjzg>
    <xmx:SBuQZzzcHL5P53HEtnPDpdE-gX_IEYOx8f7qJuAAqEo7Uy90BGPNFA>
    <xmx:SBuQZ4s2H9zdHQVW2MxTx-PzlLYVNkFfGuFXgm2rltEWHQ5VvaWrDagd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 17:10:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jan Palus <jpalus@fastmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] t8002: fix ambiguous printf conversion specifications
In-Reply-To: <20250120114106.2844157-1-jpalus@fastmail.com> (Jan Palus's
	message of "Mon, 20 Jan 2025 12:41:06 +0100")
References: <20250120114106.2844157-1-jpalus@fastmail.com>
Date: Tue, 21 Jan 2025 14:10:14 -0800
Message-ID: <xmqqplkfyg1l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jan Palus <jpalus@fastmail.com> writes:

> -	$(printf "%0.s " $(test_seq 11)) (<author@example.com> 2005-04-07 15:45:13 -0700 1) abbrev
> +	$(printf "%11s" "") (<author@example.com> 2005-04-07 15:45:13 -0700 1) abbrev

This obviously is much clearer than the obscure original that
concatenates " " 11 times (for 11 arguments that printf receives).

Nice.

> @@ -146,7 +146,7 @@ test_expect_success 'blame --abbrev -b truncates the blank boundary' '
>  
>  test_expect_success 'blame with excessive --abbrev and -b culls to hash length' '
>  	cat >expect <<-EOF &&
> -	$(printf "%0.s " $(test_seq $hexsz)) (<author@example.com> 2005-04-07 15:45:13 -0700 1) abbrev
> +	$(printf "%${hexsz}s" "") (<author@example.com> 2005-04-07 15:45:13 -0700 1) abbrev

The fact that $hexsz was not quoted in the original made me look at
how it is defined (as an unquoted variable reference is often a way
to lose unwanted leading whitespaces, e.g. bytes=$(wc -c <foo) &&
show $bytes), but it seems that hexsz would not get any leading (or
trailing) whitespaces so this rewrite perfectly fine.

Thanks.  Will queue.
