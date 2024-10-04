Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABC71DAC81
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 19:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070319; cv=none; b=hLOBWGFtWPQi1lJdjiBeydBTp1mtS0zdLZ9vbk/40E8OorSyQkgXDSUOa0Jl1AdTYFRMeAM9UFUdLOA5G8/SGSWIetaQb2XIdjnjDMk/qMAEe12nQh+K8HusQKIsdjL1SNMST+a0fpGjB+BsGpsxNAK/UzQ9lBQEpmGQBVtL/kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070319; c=relaxed/simple;
	bh=UJHKJ2WeKVCWrW/JTYnlTK2L6Z8oq9UwS1Vp8Y1p19M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eq27j7WkdyFPaBflGdsdFg8shPZhd1Lq4CLaBUqW5gDSLWbzshzxoYbrFdauw8myT8bqbdAF/ursJ9K4F5ho/Nc2xSta1+Jo0Qj5q4y6iVwS6QfSpdF6O3HLkweoYRwBmtMpWXK1bO+6febtSljvo5TFqrD8gkvFE6cQb03aCYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iLdhBj0h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oFCpYjOn; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iLdhBj0h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oFCpYjOn"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C94D811401B1;
	Fri,  4 Oct 2024 15:31:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 04 Oct 2024 15:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728070316; x=1728156716; bh=U7Gv3+5R8Z
	1UcD+Mpk/9Lh8tspnsQX8tUA1Ija6jGOQ=; b=iLdhBj0hHZL8kKy9pxKikqTtVE
	LJHtgxSh6M3iGPVkFILbLpnFc/JMX+7Q19m4sElsy/DIjtrehvW9vvPvNXPVpN0X
	XLyu/sv625QWdK/glNVIK7/lHey960jRtnGmjn7G0KExGDNy4yLPInzxfjSKMgGS
	Bqyh0KarR57MZF9ncYIJ00Lqf9bKgRxySQnB5pC5xVjUvr9rAkpfgifdG1woDdrb
	m9NTQ7dCFbviKSImtQ1T6+ezPmjAkqEO4Q3/pMkKyiNrbZtN+sva9vhe6TmA027j
	j87hFNls6/DSPoV1umf4r491WdK/yfc5MSZJCxhDKXEHWYtjURV6G2LVG7lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728070316; x=1728156716; bh=U7Gv3+5R8Z1UcD+Mpk/9Lh8tspns
	QX8tUA1Ija6jGOQ=; b=oFCpYjOn1gNMTFwG/AOIaKkaSF9S39H7q5+r7zLaNTM4
	4OELxTg4AizyJn1QXv/nXyTeFpzknCboD0vuHB9UxUfn/TGZ5Gq25lSsLgRVCNwx
	5XXP5I1BBhz4r75BI9Rg9L4s5kBJlIvfiHtZwSyYBWQGs7JgyEAxK8V5g5jJDh92
	Ec8W2Qr1MMlcgt9ylUBzCeGxTlx/C1izLDbrUA5/lLwDSm0OX7W+KYy9X5Av5dOO
	I5yFq1+z0H8j6n4FFobuwD4g+F1K8fS+mYEfOd/N0vouMyyHbRivLRAktKa1XTF8
	1/RUlUFmpVMdD6+ETC2C0QvwhiR043/PXtF23ozUmA==
X-ME-Sender: <xms:rEIAZ4YYhl7iAMgypj7Kf9-qcUm9mHG1Tal4ZGsSVIipQTbI-6Vwmw>
    <xme:rEIAZzbxntBCINdt5BlvbULEOVFASvgd8hzay5a-necjOmiCEf9KTBrL5xjM_0QFe
    KbqV7k5ypZdY6_y_Q>
X-ME-Received: <xmr:rEIAZy-Qi8kn99GTC3x4Z8EoHf4tELab1XEoZ-ttzR2UWIXboQdnbh8vTBc2yvhUusdW-7cwQX11_a9zO5vxPOEs_Jo5IJmetZcOCRU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:rEIAZyoKLibHaD4hEx4bnPUnQnn3boKj7oBM5vvpRhPdJia9yVYFeA>
    <xmx:rEIAZzrUt6XpTNGf8NftW1-OluM74BHLYEG6vZEOz17qLH8dW4htyg>
    <xmx:rEIAZwQVUCoQ_2mhZksLbbfVGqu-KRB1emp3shnGy-OJvYR3CLhCLg>
    <xmx:rEIAZzocSEHsbeXP1sZEXkulfQlCk5x86e1-ZrbHjWCSoovLid737w>
    <xmx:rEIAZ0CD2RnRvTb3sebnYyPVTwnyORafugn_kDSucGiziOqSJsJ7psx4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 15:31:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 0/5] diff output_prefix cleanups
In-Reply-To: <e38449d8-190a-49af-85b6-a628e14379d6@gmail.com> (Derrick
	Stolee's message of "Fri, 4 Oct 2024 15:27:14 -0400")
References: <pull.1806.git.1727885224966.gitgitgadget@gmail.com>
	<pull.1806.v2.git.1727956724.gitgitgadget@gmail.com>
	<20241003210548.GB11180@coredump.intra.peff.net>
	<e38449d8-190a-49af-85b6-a628e14379d6@gmail.com>
Date: Fri, 04 Oct 2024 12:31:55 -0700
Message-ID: <xmqq5xq7ekb8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 10/3/24 5:05 PM, Jeff King wrote:
>> On Thu, Oct 03, 2024 at 11:58:41AM +0000, Derrick Stolee via GitGitGadget wrote:
>
>>> Note to the maintainer: feel free to take only the first patch, as Peff
>>> replied that he may work on the remaining cleanup independently (but I had
>>> already prepared patches 2 & 3).
>> Oh, I wasn't expecting you to go to that trouble, and had already
>> polished them up myself. :)
>
> It's perfectly fine that we were attempting to save each other work.
>
>> So certainly your patch 1 looks good to me now. Here's what I would
>> put on top (but I would suggest making it a separate branch, since yours
>> is a fairly urgent fix and mine is all cleanup).
>
> I approve of this plan. Please only consider my first patch and drop
> the others.

Yup.  Thanks, both.  The result looked very sensible.
