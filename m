Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832771DC9B4
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675993; cv=none; b=UxGyqd+ULlmJJZa3+OMqTWWr9l06QVwR2iK4rz0Wt6QHN0X4DARuXfe0c56iN9T45Oh+To80F2S625bzwKh/NnV9cHFZnOb7iuSQCydwmGCLSGpQuKyo/B0/XgmL46LfITp2jJRaOrY3X/c2SnigLbFb+ipGW/DEtJUgqyW+YdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675993; c=relaxed/simple;
	bh=01qyW4VfjbHaiInRhPvrIRKkkxyWOcAGzFYlGJz4xfM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e0UM2ik28bee4Dp+c0/XmMOEn0f4UcoADd8YJ3sSv6jKXeimPXqR+W31l+amsKcGmYYgLCh2vEHTgKEovUtliTa3zB0gDSdSdyKG5OMHsN6yRiSudwI3Nk47+UZs9pF0b4GWLsopEgDvK5pFFSXAUSuBjYVR0bkZiGprZsuqVvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IpsdgG8V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sy4sVAVH; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IpsdgG8V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sy4sVAVH"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B28613826E8;
	Thu, 27 Feb 2025 12:06:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 27 Feb 2025 12:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740675990; x=1740762390; bh=5iR65nyr+M
	aGcwOxVUY91KZhIwP7SaKQgKZTWUb3QyE=; b=IpsdgG8VMQXLVkTk2jxDQJvPd3
	2j6Dpp+wO65k/oJk5U70VjUDkktj6NWMz2I1I8i6xr7EQVyy2yh9X5tAC/+LqEGe
	eXga9ct4rRYtm9+aGLeFZJQoAjJp4b2VulSJOmE4dnLYf+CkmK1Q34kjheGP2npP
	LXNZ+FawJ+21DMjGqHfphZPN3/ukBIzjmiNaUX5wwQZwvpDnItt9bSQzbRHCMyfN
	L9blsjwYNtr1Oc+yr3ylTIbpYvrWB4Qe1xlB3TNAeSeIS3ksEf/zEd1awDA7rNFE
	aEhCerh6JNV/lA2xoX1oWPmJ9tAUEbTkIzyJrXFp5JqM3pZvvcn0KxlfdIrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740675990; x=1740762390; bh=5iR65nyr+MaGcwOxVUY91KZhIwP7SaKQgKZ
	TWUb3QyE=; b=sy4sVAVHa+XQqkohcgGNJEKVSYwCzMBgGggO+xdVWxRYc0+Y1Mz
	g4nBnzgpmXbD/sft5vYjkqtwwMl39nXcH1Ss/b7w7zJ8l4jqDtg2Cyt/h9TYAryZ
	kOXL7HjPsWNAMGclfVT5ZSTaMyDKdJ9BtEt+zu9rBrmzckH4X9JrQ9jHwCJSeoPt
	luzjigIw1Igsl8JD/y2c3eRfTWZSEDHzERLCLBS+jyxyzB//mqoYbNsWTS7StlxI
	J1ntoZc3ws9KKWWJjMv2s2uhh7qiFW7ytrYhpmvSMg8IMq1EhIHNccLF21TRk5R4
	MF+OuyysZz+iV4xV0iwJkKNPYmvmh6Q7gew==
X-ME-Sender: <xms:lpvAZ1ReH2EdmipiAjMoM6-km_lQk3oR92M5wAzZvsxGm9182MVKRQ>
    <xme:lpvAZ-y9gJ4AAop2DSLfvkacuBKApWfspB1TdDavM1eiIEBVm0ez3nT0PM-l-YTFP
    w0iWl9-HFlJO9Fdlw>
X-ME-Received: <xmr:lpvAZ609Y9wGcZRPpNTFFXfilUaEEdPdechDXQV_-y1tnFFNkIlPsCGzSH2LAZVKLD__lJacI5A_TiH-luE_cCskjLdgQ-DCQPmL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrtghnrghrtg
    esgihiphhlihhnkhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthiht
    ohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohephigrrghkohhvrdhsmhhithhhseifihhsvghtvggthhhglhhosggrlhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:lpvAZ9AcCibu6a255AFn0yiL2q6DQw7BfxfpQQZXWr3NaZJvze1_RQ>
    <xmx:lpvAZ-joNHQkOhJQLjnGr3mbK_iuvjeMJB6f8vhZZ-Ur13FRGDLVFQ>
    <xmx:lpvAZxo3jmrEsZb4zYe6F0iGOtZG6mn_6u7LZVo6nsySeiSoHItzsA>
    <xmx:lpvAZ5hjpO6uRMsxodLb1xqk9JQPNZlMuBZ7PUJaD-nttxAHYSRzKw>
    <xmx:lpvAZ5UAMdH8pZ1rz3HM8kPwZX_cBgcIt2pyCMJ7hz8M3Qrw-K9IuQPE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 12:06:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Jeff King
 <peff@peff.net>,  Yaakov Smith <Yaakov.Smith@wisetechglobal.com>,
  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: General output formatting
In-Reply-To: <3a58720f-a572-4e3a-bed1-cc7e8f46e3c7@xiplink.com> (Marc
	Branchaud's message of "Thu, 27 Feb 2025 09:06:52 -0500")
References: <SYBPR01MB579278DD5EC6E13CA9A213FDE2C32@SYBPR01MB5792.ausprd01.prod.outlook.com>
	<20250226073822.GA21138@coredump.intra.peff.net>
	<Z7-lbGnlzGbhrHZN@tapette.crustytoothpaste.net>
	<xmqqplj49rul.fsf@gitster.g>
	<3a58720f-a572-4e3a-bed1-cc7e8f46e3c7@xiplink.com>
Date: Thu, 27 Feb 2025 09:06:28 -0800
Message-ID: <xmqq34fz9v1n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marc Branchaud <marcnarc@xiplink.com> writes:

>> I wonder if isatty(1) is a good way to say "ah, we are not captured
>> in 'foo=$(git blah)' and not feeding somebody in 'git blah |
>> somebody', so we do not have to worry about being machine readable".
>> If that is a reliable way to tell that we could butcher our output
>> for the sake of keeping the terminal state sane, we then can always
>> do the C-quote escaping, or even information losing '?' redaction.
>
> Modern practice seems to be moving towards explicit format options to
> let code that's parsing output directly specify how it wants to see
> the data.  Such options eliminate the need for isatty() heuristics and
> other guesswork.

I am not opposed to an explicit "please avoid raw binary output" or
even "please make it even more machine-processable by formatting in
yaml" options.  What I was hinting at was what the default should be
for interactive use when the output goes directly to the eyes of
end-users, which is pretty much orthogonal.

Thanks.
