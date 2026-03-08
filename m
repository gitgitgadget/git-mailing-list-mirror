Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C14A28150F
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 06:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772949855; cv=none; b=VN0+gGaIUsjYF7YpU/m95L5sT3HjvRqJOUD1F4ZasEfvUJvpClbNgXj/06wz4E8RlZvm2mKMIvKWW6O9QBFjiU9xlMKsOFgXL1IB3mNTFKQkHLmjMNA/sD9qG+469AxFWLtvU6BMdMS7FzuPSAB2cP8bRsNGzciHW6M89X7EqSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772949855; c=relaxed/simple;
	bh=PR2BjO+PTGQbuobZB3rolUrH78zls7xAZitwuxnvGuc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Oiviqg8N9aoFbcFWyu2bVYpOFEbSNXj8A1jmhFAOUreRpxTP8rXUfSxKVcqxNjj4ffsy5KsL6vnUCKlSGdOBCQgOtedP+FuYOoYO6hjkTMh1Yn2ftIiud0gZHx7URZalrED1VBDek2rod+2bliAg4R1i78T6AFI5U2K7T3tWwkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ULXMSKxK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f7H4D8GU; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ULXMSKxK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f7H4D8GU"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AFD1E140017A;
	Sun,  8 Mar 2026 01:04:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sun, 08 Mar 2026 01:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772949853; x=1773036253; bh=F7z7BTLtkF
	AdU/ijDf8Nk9ggLmIzlV/cpoS7qD5v8c0=; b=ULXMSKxKHab7bLaNsWWA1CUAex
	HulOAcGnfaRTTu2khV6Tc7fUqlAWRZKrHl22Y5iezsqZFblitIozCWU3G6TteP5q
	hCBCae/WUATq+r8LZDvQD+ki/NoGBbBRUXOplet1RAT6zU4gsTIYREcXFCHKQO2d
	OyUCPi4KI2vmyy93Bj4Kvb7oaB+RaK7CyH5cPPPyW7p7dbzMpXAU57QkVtxXTn9M
	YsMrVg06pxbfvrP2f1Rke8Q+dbhJmDjoN7R9QPuvqfPmzhppy2q7WuAMpvIDQZwB
	urHGqDlw7cxDfkIdKaeEvgotWamy99gwh2N4sSQRLehkTbRhrA49Fk3Z7zAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772949853; x=1773036253; bh=F7z7BTLtkFAdU/ijDf8Nk9ggLmIzlV/cpoS
	7qD5v8c0=; b=f7H4D8GUsprOaA2sjvohuC0NL1I/g8w/76zQpUoVq8cA4zLMO4R
	ma+Oguc87zZw9FAn5DOWWIjBg5ijz+qFFzVgAp8pfg8AkQIH+xPhM24k5H6ZzpDw
	ZbtQ3nJGRtlAhAYKKzS4f/IbQgCnXsxNni8imCM5vkLidb6Cp5xnIJ45VJ2wtI59
	UiRKHrQaPMc/HJvk9QpmpIvvUamGfR/qCG459Zwetb2BF9+pCbYAXoRCGZsN+RCr
	UsDrx6NbgHjNhuCK7dcjQ59dkkOY1J32+zwjHLKOZB78Cec5FJJeP74YUg06X00m
	DvSH/hTNo3NctaDNMG+atdj3BWZ2olRWcYg==
X-ME-Sender: <xms:XRGtaaf9ub0woFxvU5ss24pJQ4DD-Z1WIULz00jOyGYqfDWyfaL9Rg>
    <xme:XRGtabPKN-3b6iQoQkOuZ4Cm66MWRGkpxdUT7m0UbTxrjhDnPCKi0qDM9HXFiX2Nf
    t7x_qGmE9CU4KKBLm8ErC3jpUBrSAxNukj2fhIQEcSkOoILmMv0KA>
X-ME-Received: <xmr:XRGtaQguzKU-IP8Jqom7Ngaq3ekdH5lR0JxfAAqXCzrCSxtU9i6IrdhwX8_iAV53fO7hbvr7Tcj2gy4_dGryVFdxe7b8uTX3DQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeegfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehfrhgrnhgtvghstghophgrphgrrhgrthhtohesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XRGtaW3XykHKR0hn6dLMOZJow5f5AjxyL_NXP73dcubKgQGKblsazQ>
    <xmx:XRGtaSjdpgxG-acCoE2gZ8a1ifxNvzrODl6zv7xv1BNAv3PkpLr80A>
    <xmx:XRGtaednNC0ONm3gUntS51Nki-s93UUmeTRzypCVjkEGdywQ0CGezg>
    <xmx:XRGtadnaiPdBz9WV9H2DnHvbZkHEXkGZU4rTZ3AjosvGBLXf8rDhMQ>
    <xmx:XRGtaQQoEQsIukC8EZJBtT62ioqVeVIHlQFJAwVF-SDJGkWIRPrPCZfP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Mar 2026 01:04:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Francesco Paparatto <francescopaparatto@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v4] t3310: avoid hiding failures from rev-parse in
 command substitutions
In-Reply-To: <CAPig+cTmRGBjV=yG4PvyyvFOgTZ0zK4GtkiO1xGSm1+OeM4ScQ@mail.gmail.com>
	(Eric Sunshine's message of "Sat, 7 Mar 2026 23:13:00 -0500")
References: <20260305225128.54283-1-francescopaparatto@gmail.com>
	<20260307103631.89829-1-francescopaparatto@gmail.com>
	<CAPig+cTmRGBjV=yG4PvyyvFOgTZ0zK4GtkiO1xGSm1+OeM4ScQ@mail.gmail.com>
Date: Sat, 07 Mar 2026 22:04:12 -0800
Message-ID: <xmqqecluuaar.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

>> @@ -569,13 +578,15 @@ EOF
>> -       test_grep -q "$(git rev-parse refs/notes/m)" output &&
>> -       test_grep -q "$(git rev-parse NOTES_MERGE_PARTIAL^1)" output &&
>> +       oid=$(git rev-parse refs/notes/m) &&
>> +       test_grep -q "$oid" output &&
>> +       oid=$(git rev-parse NOTES_MERGE_PARTIAL^1) &&
>> +       test_grep -q "$oid" output &&
>> @@ -606,8 +617,8 @@ test_expect_success 'switch cwd before committing notes merge' '
>> -               echo "foo" > $(git rev-parse HEAD) &&
>> -               echo "bar" >> $(git rev-parse HEAD) &&
>> +               oid=$(git rev-parse HEAD) &&
>> +               test_write_lines foo bar >"$oid" &&
>
> Thank you, this version (v4) looks good; it addresses all my review
> comments. For what it's worth:
>
>     Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

Yup, looking good.
