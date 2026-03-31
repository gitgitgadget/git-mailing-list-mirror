Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8CD3E3DAB
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774973641; cv=none; b=h/Cfl7IucfrD/5OWgpOyysFQJiEiIpMS7wH+sJMaEwLi3ebjwHi54UPYXx52/HjZRaI1N4NFW332lV0Y1zHumkULnyoychtBEZr+jo17iFMoGKmJKiG47oClMsMhlpcq76Q0ShAPYy+d8uk8DwMepQ9QS1Xk8AsaEvnN2+iJtMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774973641; c=relaxed/simple;
	bh=AAeVmaOw4uVJByuYx+Dtxs3a8kPVWtlZZyD7vOAfaw0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=giXRZykpIbTBhyXjaT+iFOCBsUOBqdYfmiGqORHqoxxRjzerI0w45ZQMDcYGyl9dpPVJ7VOES9TO07mRHVZEveGoAAXMYIqbotFTd9RSdKjH7OWTqggZHx8fcjNoiOiODA2MyYmy01rDeAlk9zUW57bbKMIfkwbxQGRvskmascU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xGJmvYMh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oM7IIsB5; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xGJmvYMh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oM7IIsB5"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id BDA58EC0143;
	Tue, 31 Mar 2026 12:13:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 31 Mar 2026 12:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774973639; x=1775060039; bh=7F+vrXtElM
	sWDxEHIobubDlmEVAZNOFn48L9/OUCVTo=; b=xGJmvYMhhs8FsTUGabf+udpYCS
	0ldAIP8YkBebtW+29njlphVsaGlwkm4chmJJn3a+DKlzkyrY6xUeKK74ZLTwsk2T
	Y/+HSI+y9gMI6eD9k8gPc4ZA9fy8ow82wVbSfB1HtHZmfIu49P/YJlwl/kfX31X1
	qtmRw6DWzgn0b0EdqI7Qr4itc3RfziNAJ17Sqy9RL/2L7Cac5iLxu6oT0S7aU2zs
	XOXYkucmOfK5gJH6GosznPd/AfIDTaFToCgLFiCdtPScC7U0G+NqGJumtwgDrrPs
	31uvwiaYUfVyc7x8DrJ9ZiBmOkN3os+zvlBUC+5LGvHgydF5FTYG3EKU1Dug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774973639; x=1775060039; bh=7F+vrXtElMsWDxEHIobubDlmEVAZNOFn48L
	9/OUCVTo=; b=oM7IIsB54u70lwEOMAN4eabI+E7jI9C6CtQXMDB+83fzeXVci7R
	xsLmuBbhwwYhadXQI4BUDcOJO1vmKrc9GALMn1SuIHsC6A/A7YCdyvCkmfeA4bpW
	csaV0AluFEy/3iZwZepx0PDsKhCDMKVXwGsWai5oNyhQrpIjQmhxEuBpL2cjMfGk
	zrEnZyZOkfyiEWrsDItPm9YqiqIpztgGporpp6UJ6zdxxNTfBGS+F4N/kThnyjfm
	tHrwCeL0B7rYkqYxHqN3yYRkxnoPyF9c6WJpjI77fefWdE2naB0iD55FBtpD1F8i
	vsjq+Tcym995QTqgbo5SOkVW9r4ClXK/6qA==
X-ME-Sender: <xms:x_LLaQbJcXRG4f6xxP9jL_01-ZCUtno9QdFpw-KkOUkKUT7OijiYXw>
    <xme:x_LLad_bSYemUYaqZWSkm6eJkzwP7HEcCG3uMJNeLIeeJCgVpt75Oeq4IU3iGir6-
    4wFxtpas82IzFUmZC7Vcb7F-f3rdhapwigMwM3LGZjDMITIqSP95Q>
X-ME-Received: <xmr:x_LLaenMrpCX_wmI0lnYab0Ew1oenlnRu4e6lCCDN-KRaXGs0PjQU77eOaNbI90AG2RZkEmewspT0WWAagSqni4Uy0_8Xnv_jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeihtghhih
    hnrdhgihhtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggv
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnrdhknh
    hosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghn
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:x_LLaaxK36gvu3PTCk7AsHWAduowzaBgsXGKrdpVOP67I2IGsvKZ6A>
    <xmx:x_LLaQ6DOQQ1gu3ctqap2yhRG2OiNcm44J2EFvEytZlcP7L7fTFq1w>
    <xmx:x_LLaSUXxX5_4UMUp0_pIb1FW8VSYu-8ZZ_r8SSZwRK1tpdqb1STCg>
    <xmx:x_LLaQIV2UHEDRi0qdcX3fjsUJo7PVZ41rFUt4SLLX5KPUBc6kw4hA>
    <xmx:x_LLaWezA_Eouw93uiC_TMvGoSk6-bYY_Bh_v3Y8gJazfbUrUo1GgxOF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 12:13:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Yee Cheng Chin <ychin.git@gmail.com>,  =?utf-8?Q?R?=
 =?utf-8?Q?en=C3=A9?= Scharfe
 <l.s.r@web.de>,  Jeff King <peff@peff.net>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v4 4/6] xdiff/xdl_cleanup_records: make limits more clear
In-Reply-To: <32c34d0d-9358-43e3-9d58-5999b3ffd6c2@gmail.com> (Phillip Wood's
	message of "Tue, 31 Mar 2026 10:44:15 +0100")
References: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
	<pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
	<75fe3ea1250ab7dfa4e029f49f2ad353185afded.1774890003.git.gitgitgadget@gmail.com>
	<32c34d0d-9358-43e3-9d58-5999b3ffd6c2@gmail.com>
Date: Tue, 31 Mar 2026 09:13:58 -0700
Message-ID: <xmqq8qb82czd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +	} else {
>> +		mlim1 = XDL_MIN(xdl_bogosqrt(xdf1->nrec), XDL_MAX_EQLIMIT);
>> +		mlim2 = XDL_MIN(xdl_bogosqrt(xdf2->nrec), XDL_MAX_EQLIMIT);
>
> As Junio has pointed out we now evaluate xdl_bogosqrt() twice which is 
> unfortunate. It would have been nice to mention that in the commit 
> message and explain why it does not matter.

Yup, that completely slipped my mind.  Personally I too find the
original perfectly readable, but the updated one is not too bad,
either.

Thanks.
