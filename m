Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4913834BA4C
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 19:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758138911; cv=none; b=TFWuDV2yccKX47vb/Xhdl+sTEotz4/9Np3eBkOA0VVajYBujmXfdf9EJjbPFE1Fhhl7tdOSZr74yT2yThNd6udAgiW9SqxxIx2puKe+XDliitDNPfLSCUe6iYl1y113QP2P6e+L4gZeUXvyewYBBt5W9NPwv1VSm6t6rHWFZY3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758138911; c=relaxed/simple;
	bh=k++FuRhMhB87avNK8lR7GF2ZVyDhDbHJBTi/tAJYlAw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H99B9AkiyLQkugpFfdpETyY8Ykwow7qzbJ6sM+xKUC6BeVMxDiIQkXBFm46It6jtRkuHjhGUxmRA+HPNszby43wupGYcDRoqsrWN4quoi2ecCNuAqDzf8hJhhXYaajyuEtE3OerEf5xpeTIVD2Nzmg2jQ/cH3dRaABHUZDtIQ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CSLQYpeI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XsqnAhjJ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CSLQYpeI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XsqnAhjJ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 420F51400195;
	Wed, 17 Sep 2025 15:55:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 17 Sep 2025 15:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758138907; x=1758225307; bh=+B+JaqLW47
	w1ij0N6KDXT5sbktzsj+EyEg/9Rb4r/GE=; b=CSLQYpeIcjfnK9GEpcKtKaXFTV
	Cq5BGof8m8IOVglPRMSKSEwQ6tJTstMBrfJ0rrVeHXPmay0j/qT3LhS2Pvls/kiJ
	9jSTw0Ai9CTGaz0/vJvRLXxe7m8Mv1fRemmiDA2+IntAYhdIbwlXw4CLqaxtTI2z
	xo06/Pfxjo9En+37Tt9z6FDSILcrHYFnX0/ihttMRnEV3lmPno5NP8IYNDvGGwQ2
	zCJSboMxlHcp1V7YmhBDkq0gZVT3MMuOG5z28aR7eL0PjsV6aKyopS6ERqE1kCol
	Qp1nKgZ6uGcODhQP4mmYw6hgW4+tLOzukDZbTAsnWdP/u5Scmd7LTBUlNgrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758138907; x=1758225307; bh=+B+JaqLW47w1ij0N6KDXT5sbktzsj+EyEg/
	9Rb4r/GE=; b=XsqnAhjJ6GLnA0xwjL1B/nPFAdensXY1fQrvrc7Kpm4gGX+7VRI
	0QYmSJWNL1PqR5+IOLVqeFPa5/CQLgl+921W8wMCxj7jOh3lH8moxQg8Rc4l8a7p
	UF+VfFU3x3l2kTsutZKwiwfiBXVX+zs1loqCQG85FgAa91Hp6f1xgIkyA2oeofjO
	k1zmtOLqgHu7blOu4SRuoERNC1y/MgPka1WHYg9UERJnAAt2lai3X1yD7a070iWz
	uHi2BPF3kZ6DP3QQjhyeiBsfVYHBq31u6dofHbLqiYRR/1GTy4XmZyGjhkbjDxSb
	1T4d/eak53QuAKgJ1oIMIUJtB+cgft1DQcg==
X-ME-Sender: <xms:GhLLaOJ0-zjpzxYfHexwY8HtMd-K6Efw8wkL1NtXjdkhmBxgAyORmQ>
    <xme:GhLLaDGO-H2nhmTrHDi1gxWTrbHSIGIMkaVqkliwnDRu82kJ3ku00wZeS2nCKn2jm
    XagSfPlw8Upbh3qMg>
X-ME-Received: <xmr:GhLLaKWuqfrtjEhKjMbfenn6SrTMsU5KsEFgIXbEri9Pill4iIy8oR267nFND6C7pyIeRKnhKEUX7ZBpNgCSpWnrQnH-sxg78tXm48Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhope
    hjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehjohgvrdgurhgvfiesihhnuggvgigvgigthhgrnhhgvgdr
    tghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GhLLaLwogmu-0GHnFA-VCVBEjDMkzMtunCIivjY4rPfCn5vaE-z21Q>
    <xmx:GhLLaPQ9DC3MWd0u-zn-WBzgHDO_Zof7-qruDuvWlbTuRRkFxGDGVA>
    <xmx:GhLLaHjpkmXWByrrOX7tHnkaauZi_yXdXFaTsOpMtrUco2UlNBby5Q>
    <xmx:GhLLaGkYo7o7jD5z2ITRd3FyzNlb6_O073_Cl83mykuSINM35ezh7Q>
    <xmx:GxLLaAmHZeBq21h62i6otqN00v0EvheN9IIzoTGHtuuqVMZEqwIP-z_b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 15:55:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Justin Tobler <jltobler@gmail.com>,  Karthik Nayak
 <karthik.188@gmail.com>,  git@vger.kernel.org,
  joe.drew@indexexchange.com,  peff@peff.net,  ps@pks.im
Subject: Re: [PATCH v4 0/4] refs/files: fix issues with git-fetch on
 case-insensitive FS
In-Reply-To: <871po4or7m.fsf@iotcl.com> (Toon Claes's message of "Wed, 17 Sep
	2025 20:43:09 +0200")
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
	<20250917-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v4-0-da3c74a08ed0@gmail.com>
	<pjvwiyrcdrtpkeyro2mvmfljj6a32u7bhli7ry2cndjhn4pi22@6hzanr46cyij>
	<871po4or7m.fsf@iotcl.com>
Date: Wed, 17 Sep 2025 12:55:04 -0700
Message-ID: <xmqqtt10c0rr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Justin Tobler <jltobler@gmail.com> writes:
>
>> Looking at the range-diff, this version looks good to me.
>>
>> Thanks,
>> -Justin
>>
>
> I also have got nothing to add.

Thanks, all.  Let's declare victory and mark it for 'next' then.

