Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D217E
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868205; cv=none; b=q2EoxTCyS3EzrXov6sxLEjxgUdRUmlnXHgPrjpEAlR971W6xoSbR1Ax8hkEkoS8m1CmhG5elTZkX/ZxqNoJ8V9EHqiiRCaSJoswAZEWJ1ZYlEZyhOuofcmwjPzI7UU+Bw9kRvgWAKJ2QXfxyEpbT4MPSNmU+zR874kR3rIifnGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868205; c=relaxed/simple;
	bh=UfMmxeVG3aGuUAmNSG788hF3HU5G32dCugZDgP8q2Pk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rxb40cRiDQiBfGCom9HUCB95ZJ0821TYGpGvkc4EQXudobUguaQ6JQi8K5ls6fseGP8bW24O0BWggb7JiSIUibt34K3XB0Lu1epVBxtm0Txf0AdKiET3VVa/RLPJij4B5rGqJNjT5QS6tGG8cAQMIrClkKA4aCjW7xJFLNtiXI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BK/upj45; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mMG1Ch0O; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BK/upj45";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mMG1Ch0O"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 607131382D03;
	Thu, 13 Mar 2025 08:16:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Thu, 13 Mar 2025 08:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741868202; x=1741954602; bh=nkf9njxcsz
	qIRHv2nIc1ZVUGj69yuG1p1DPcIbOglZo=; b=BK/upj45dYAvCni7Sq/DGTs144
	l+5pDZLFKGwxBEfrt5COsF74mytachlK9Q6pp11d3NNImw4eO78QhrvAGtlwn4q5
	UbEDppMKxKQ6dsHJlZUlfCcFRw4j46tmq7K3I9NSnOvnk5kKSWw2mn+ssYEMFXCK
	70leQ5QaIZ663VB4w++UWnCVpnVne+w/vJl+V/ACbcF+syAiMwi9APDz/A/LNPan
	eidA4hMXJ9ebFzN1Ng3MeOr0wWVaV2eTsKLKZ9Jyh1t1+1MI/h+JOKFGoC0m8tOg
	Km4nF7/MAimvzZ0B9Aj1zmfABPch7hI3RiTqIdGS2Cyg50b7gelyPe8PVs7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741868202; x=1741954602; bh=nkf9njxcszqIRHv2nIc1ZVUGj69yuG1p1DP
	cIbOglZo=; b=mMG1Ch0O65AFm+6ff5du5zGRSV7qobMxs1w0leIg8wQfkf/C1oh
	n32EU91hDIVrRTaRLWLAK3342LH9UAC+pINyy5EKnONuen9o5iReFKa/niUV1E9I
	/laXq/+X/Z4mDSLZNJY6fo3ezPGTiGvqgOz/4vSM5lVrceqGJ0sPjxwoucS1QQX6
	B2KJymNrxG664XfI5X/BQuyaPypkUC76Y2BAElqo/Mjj20/xbFauLX+NBU9T5NpV
	t0CVUAcrfpIWUesv9UKQgZ6dN6x89mVFZUlsjAH9c8pXR5NKBX3j99z1N+K68vJC
	E3TbRZGDgcXTfSlX9SsCRVhBOVRwCCmXddw==
X-ME-Sender: <xms:qczSZ5Ju-dc4yP_2VUQsvh60umMrTLogprkS8TDF0Q9VGkyx7dlPDA>
    <xme:qczSZ1JcGeGNzZieu8o6-D7TnNgG1gJS6rmrmH97G4PlEy9bDEO3tQqYR0Vss2675
    hcTE6c5MHe4cuZICA>
X-ME-Received: <xmr:qczSZxtTts-6wjgDbygVbm9jRf8_lI1ZFTcANL8IOc11pTH4IO9bxdwwM_oSrDtoiMS7ky2scVSeMZQ0PZaX73uhftX3_aZQ6wjOY8Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdejledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qczSZ6YQE4t-Uj8fV4_ilsOUyyKx1nJdWihGFFCeCAGht1KWUDOLmw>
    <xmx:qczSZwb_XuG8JqWtlhjHdeB_z56bJTiVFBJjhXJd3Q0qg8GEGIsjOg>
    <xmx:qczSZ-CVAB2dhRx_OReBtByZJlfdpbKWmsNN0JLEZezRvqcX02tO9g>
    <xmx:qczSZ-ahBL3mK89W-SU8GG6imj7Ue0XEo1fq-j-0zXtg-6ITYoFsgA>
    <xmx:qszSZ1Ocx05S5Q8pKAXXT5dTnYpHSnkm2OREG7ElY9L28U41nhtk85ES>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 08:16:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 4/6] pack-objects: generate cruft packs at most one
 object over threshold
In-Reply-To: <CABPp-BH35cn1nXSaF=U=dbSKUxTFL5uP+yUvhbXMi66tJMuhLQ@mail.gmail.com>
	(Elijah Newren's message of "Wed, 12 Mar 2025 13:49:17 -0700")
References: <cover.1740680964.git.me@ttaylorr.com>
	<cover.1741648467.git.me@ttaylorr.com>
	<f2ca92245ada74825806b50f786aab312275fd85.1741648467.git.me@ttaylorr.com>
	<xmqqikof2pqp.fsf@gitster.g> <Z9Gmo2P3Fnt3JeOs@nand.local>
	<xmqqjz8uxfyq.fsf@gitster.g> <Z9HaYEyYgBYTiia3@nand.local>
	<CABPp-BH0rbieCV4Z11pHOX-mwrtEO-FPNdywV0P5HxXnusdRKQ@mail.gmail.com>
	<xmqq5xkex9md.fsf@gitster.g>
	<CABPp-BH35cn1nXSaF=U=dbSKUxTFL5uP+yUvhbXMi66tJMuhLQ@mail.gmail.com>
Date: Thu, 13 Mar 2025 05:16:39 -0700
Message-ID: <xmqqmsdpruqg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> With below-size and max-size set to say 180 and 200 respectively, an
>> attempt to combine the crufts may end up filling a cruft pack to 170
>> but the smallest of the remaining cruft may weigh 40, which means
>> including it would cause the max-size to be exceeded.  In such a
>> scenario, there may not be a solution to satisfy given constraints,
>> i.e. go above the below-size without stay below the max-size.
>>
>> So I am not sure if the approach would really solve much.
>>
>> Other than that a separate names, especially losing "max" from the
>> threshold that really does not mean "max", would solve the confusion
>> that comes from naming, that is.
>
> --max-pack-size is a constraint.  --combine-cruft-below-size is not.
> Think particularly of the case where the user doesn't even have any
> cruft packs yet and has only accumulated a little bit of cruft.  That
> option is merely a guide post to say that if it's smaller than that
> size, then feel free to keep trying to add to it (so long as it
> doesn't violate constraints such as --max-pack-size).

That is correct and it is why I said the suggestion solves the name
confusion.  But think about the sample situation, before and after
such a repack with two thresholds.  You had below- and max-size set
to 180 and 200 respectively, and a cruft pack of size 170, and you
failed to grow that cruft pack beyond 180 because the next available
cruft weighed 40.  Then you'll repeat the exercise again, find 170
that is smaller than the below- threshold, try to cram more and
would fail.  Isn't that what Taylor's series wanted to prevent from
happening, and isn't the two-threshod approach supposed to be a way
to improve on it?
