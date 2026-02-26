Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFAB3290B6
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124089; cv=none; b=urDui8p+IW7KPT8MFNWdFmPtjLk2gLkq0p5PydMHXeb32Qx4M7wwAATg6AfnprFoZsS5u9EB/bn8dXWkJXLm4Bcf2KSsfmCYq9VCG/WavFfdbztXsGUO1Ks09xIAquqvY2Oxjr7t8kL/D7DptVAZMcLNjd+GE3wCJKoEDB4lCNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124089; c=relaxed/simple;
	bh=KNW+HfgbjS0C2jqaxepT2nTrJMMQgUN50I+0UOPz0kE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YCoKIETh7yxipMHy2zm//J5nHHtZpBI0qQ2hDBmoqR2gZTXYZ6JHj1LqgLP/Ce60b/PrH1crLtUKaCTNCwXnWVnbDDP9gP/Q36XAcRoupmQTUVBXIsGBWadx8/7e4vPiTiQEl3OvCpwtX39Lh6ZmdhFJ5YMY2hO+ij9LhjpWysc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=00p7Grnc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DVgsW+65; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="00p7Grnc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DVgsW+65"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 38F25EC054E;
	Thu, 26 Feb 2026 11:41:27 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 26 Feb 2026 11:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772124087; x=1772210487; bh=Zt4N7uZOGR
	SeDggJuIvL5meUauGixe3qWONT3KoOpi4=; b=00p7GrncwpSWuA8P6j2T3/YBW6
	slSuzUCS4qvYCPpKx5k17qNiQPLPvTtFzBBgOH8ZcQhDDZ6Jyi7DItcDpUD6e04M
	zknC4v+C7WAJc6TZOfzpGoLnalCd7QE48m3b3EFgtF6lN8CN4w2vU8LcDvSC1ayl
	vqabuq5nYC7WjimZfWbhNDEf+CEBEuTAqnoxZnz6tQqkfwLVXjbgO+hkZBZCf5ee
	P2LTwAVoGUrTlj0lbcE90TCxdr+4tn1VcSs6fXzCzafnxPEEar79gDg2ABIOwVsv
	v4eSLzXktymawSvHL5fG8/0AAovA2MymU/ZRxKDPFG2DSTHfegusx+PKWutw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772124087; x=1772210487; bh=Zt4N7uZOGRSeDggJuIvL5meUauGixe3qWON
	T3KoOpi4=; b=DVgsW+652V6v2ZNopMVXfEpRAkowtJHTeGfhhupGcYOPO4rVotH
	VBnb059dFQGPxyjSwt2KTU9yK2bTrCgeBEMFok/n6uVMQnx8KOE3y98SEV8/s4Xt
	UkPC4MsEdncenf9EJ1WoiiQo5xEyCukc1jG4RUSmiRURs0SFvKQG0PeDU8+uYcUn
	j1iBqchGhlIhVqwzH9auv0tw0ZPMcFy70QiRdacozXsamtbfq2QamnDtWYWX3d+W
	42zfR+WLOS6m3msY2O8whf7HyxwYHIZMt6op1RNQZJgWzcAkzwk9C9+gQpOaC41N
	VKB34ULJ1yu1KD6wDm4sgKZTDyfINpHetCg==
X-ME-Sender: <xms:t3egaRZaxVSLwjNnJy_xQ0aLNqqeo1TMtPGYg-j4_hPpSDOFOb3D0g>
    <xme:t3egaQKjCXCaLUbf251ffyJZ8J6WYXaMHguwwYThEZtkr_oU260VYsQN3D5mZbvuq
    cRJU-WHLzpfuRCp_prHJdJiwLUvLhDjIjCN3119KlhDvIt6Fv5Nvw>
X-ME-Received: <xmr:t3egaXCvx8h9OhG-vsR4AAyfLSiHiomhAh5kKG0WBcmglAOvD8iEMtO-IHIjHjw1qu0VIgccR4elnHhveCTqHcByxWuHIA1Txw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeiheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegugiguthes
    uggvvhdrshhnrghrthdrmhgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:t3egadrTdcrRyxFGfwPcmHD2Vfh-SrDG5NrZnueDqjXjvYqouGTRdA>
    <xmx:t3egaagZTNcWLSRD5ZRH9xPvRr9OM8P_RHeQ_oYJ43xwrMf_N3SVtQ>
    <xmx:t3egaSCdgsS8kaHCOPkKt2x57jGdZpwdDaalO0d_tuWdvQOdC691IQ>
    <xmx:t3egaXG0MQzK74VvodYaJzF573LlcS-P6UIs9OHn7sNJpqdJGjI8Bw>
    <xmx:t3egaTypXZuAD3-4VgLKoBo8Roa61attdUqzyTsB0TWZuanESRxOWyNZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 11:41:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: David Timber <dxdt@dev.snart.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v1 1/1] send-mail: add client certificate options
In-Reply-To: <319bf98c-52df-4bf9-b157-e4bc2bf087d6@dev.snart.me> (David
	Timber's message of "Sat, 21 Feb 2026 18:16:52 +0900")
References: <20260220081717.555185-1-dxdt@dev.snart.me>
	<20260220081717.555185-2-dxdt@dev.snart.me>
	<xmqqh5rbz83b.fsf@gitster.g>
	<319bf98c-52df-4bf9-b157-e4bc2bf087d6@dev.snart.me>
Date: Thu, 26 Feb 2026 08:41:25 -0800
Message-ID: <xmqqo6lb4fuy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Timber <dxdt@dev.snart.me> writes:

> I'm just trying to expose what's possible with the Perl SSL interface to
> the user as much as possible. Paranoid people(like me who would want to
> set up mtual vertification to deter bot attacks) would want both PEM and
> PKCS12 because major implementations including Thunderbird and K-9 only
> accept PKCS#12(imposed by the application and imposed by the operating
> system - Android, respectively) while the openssl x509 stack is more
> suited for PEM(separate cert and key).
>
> It's a niche, I know. But something tells me that you'd want to push
> this feature forward. Thank you for the rest of the comments. Will come
> back with the revised patch that I hope may unconfuse you. Good to know
> the project is in good hands.

OK, please incorporate what you explained here in the commit log
message and/or in-code comment, in order to help future readers of
"git log -p".  I'd prefer to see it done before the topic goes out
of my short-term memory ;-)

Thanks.
