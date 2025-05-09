Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C096224B15
	for <git@vger.kernel.org>; Fri,  9 May 2025 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746801349; cv=none; b=hIoJJmO1NUgCJjhukdERO579TkSrIAEPUJcJzlvUp3g9Y7ugOi17w1Dhn0Ou/uSytd02sphyZ7vXGe6tfewp9Pu3HEcmM49LgD3UZuARnHDZLlwN5p/9+iFtSSgWxsenl7BLyXKtW0vsZt3FKRkE7traVcbUoXaI2yk8ESYql4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746801349; c=relaxed/simple;
	bh=zPCxuTroj55IgEesABPA5Ajn3wlhgBekzLe2Us4E/VM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aOcvGaC43GWjqVmBCe1QhYeQJ38GXLCcOTmKOl0/rMSACes02u3xwNpTJjrlvVnE4ca5412StlJTz+RySqCRdZfcS3kueWa8Sv5e8szrj7eZDRAll8wFkiK4+6lS85tvYe/FBfWTc3e1MQRxP6PuHbLGxepkmcif+RKg5CjPpGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y1ZfT9gp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aurhQY99; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y1ZfT9gp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aurhQY99"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 38182114016F;
	Fri,  9 May 2025 10:35:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 09 May 2025 10:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746801345;
	 x=1746887745; bh=62bAu6WisX2ksGJVdGZko8BeoCBjk87QR6j46b+LjQQ=; b=
	Y1ZfT9gpStpVrZNn5mRavUcB4zP6d0mOI6TU25EO5/4n0srlCDLZ4yNmu1jN3oCC
	CV0duzrzqOjWqVa21UN8xsnL34EBxPDwwbLVgYezeoqy7ha1hRGQ9gBBTHlfZtrn
	2qTBHBjNMkx2pButBXO14g8hmklRT8CDp7LSBaB/sFk3WzEZmNaze7Ae15DSmXuv
	bH67s1U8ADAoL/5fEyVcpL7YAQS53j9p/ajcnq+c+pWwyszO1EUvXVg3HbxExmhh
	1K3tlWAbU4yPJNeeiy9KaDwxTqwfYRTtT3ULFEWSbhkzTx7ZhylL7VoGvYFAo/Sy
	M+++mRZrPr4ldUbvcRPUEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746801345; x=
	1746887745; bh=62bAu6WisX2ksGJVdGZko8BeoCBjk87QR6j46b+LjQQ=; b=a
	urhQY99sjVLMFa7FTeoX3EIh5hDZC6lhXsl/IVw20oYKwJ2EC1RBWGuQyVgdwOjl
	hLVkyPi11NOP936DKIHgGJ3+MLooyj0iw/m/P0gBfxcILKRODxhfNOnM5LT2hOug
	SayXo1mI1QOdVJ/Qy4Vlw+temAqXybzbFa9IYLdumFQdbquHSx4UiDqLNHHHrHVL
	w1SQtVzDHEzWzCyBMOSs1JWkv+EnhanRkgpI7LA428MUcCPArl2Iv1swJtJAJ46v
	LWi5skq2EHamBeREDtSq0RrRBiuKRieZDccXnK/vSg7gH/urxakTbhBVrWAir+E7
	h9/Dl9Mh+TPrYAAnwGl0A==
X-ME-Sender: <xms:wRIeaBFRzlTmPH0mN6_exgCSmVw74UUSmCvhJ1hwfRBFgdaC-Ooqtg>
    <xme:wRIeaGXmTzpJfcOl_JJ4IjPpkex9E5tGJjzfQxA6MkYrKqjeze5eLdftYfsVySViV
    t69PPjqqqVAMaP0xQ>
X-ME-Received: <xmr:wRIeaDIvgI8YuBcp2i0eZr7u16LYX5Alkz5VRbksy8MIK8eNYr2skw7i5O2vk8oxctlSoRzIcjFxS6Y4erQPnXpjkZtbuGchgNk->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjnhdrrghvih
    hlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wRIeaHFw9mZ5Y4JoNb-LkQP18RZJv3b7vhulnGIwvNUmKlNUUS23QA>
    <xmx:wRIeaHUqYyKYP6PJVkQbZk-XZjcqphds8rlv6Zi76pxzTT2Cc3-GqA>
    <xmx:wRIeaCPOINdDVg7A_PVDkcN0KEd-SPn3B8BwJXHPRnRPmIOrY9dbnw>
    <xmx:wRIeaG3IDOec3mBT1Sc0CcUE41h3nYNG_svnnDnfZGDx8sT5oprh2Q>
    <xmx:wRIeaFolpEi7ULs2wh7Cja7_WMcPaCApjWoGIxAzs6qHiYUHwcVWOCwy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 10:35:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Additional changes
In-Reply-To: <5040970.31r3eYUQgx@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Fri, 09 May 2025 14:12:53 +0200")
References: <20250503011537.3035416-1-gitster@pobox.com>
	<20250507210104.26709-2-jn.avila@free.fr> <xmqq1psz878f.fsf@gitster.g>
	<5040970.31r3eYUQgx@cayenne>
Date: Fri, 09 May 2025 07:35:42 -0700
Message-ID: <xmqqr00x3l8h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël AVILA <jn.avila@free.fr> writes:

>> I'd assume it is the former (as the three-patch series hasn't hit
>> 'next' yet) and start updating htese three patches.
>> 
>> Thanks.
>
> Sorry for not being clear. I was wary of what the provided patches did not 
> address, so I reviewed after applying your series and bundled it in another 
> patch, which was not signed off on purpose.

I see.  In the original, I deliberately ignored what the patches did
not address ;-) as I wanted to limit the scope of the changes to
reduce the number of things the reviewers need to look for.

In any case, i assumed the former and squashed your changes (which
looked all sensible) and the result is what is in my tree right now
(but it can be further modified as the series is not yet in 'next').

> Of course, the proposed changes can be discussed. If you prefer, I can 
> dispatch them and propose a v3.

Surely.  Are there particular things that you were either unsure
about (which may lead to possible partial retraction) or want to
stress on (which would help other developers and reviewers recall
what they need to watch out for when touching the documentation)?

Thanks.
