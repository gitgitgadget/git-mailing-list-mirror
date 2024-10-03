Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFFE8BF0
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727979624; cv=none; b=NWluTTaETqZ3jAdv41em6xKnQmO+hSb0NP+ds5Bl2fi7FxBkSMlVSvljKOr513zJp1/Od5z8Bte/x3maOTfC2pgKoyPiHfSJ4VwhNCXFD6VmckJzx4HnYOTNCNij8o3ymVpHnf9IO859YHJGu7Ay7RD+9WzjDedkvxGmK2WKCXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727979624; c=relaxed/simple;
	bh=JbQdmH1/SUduuIjV795OjevrCOmT1Gw01QX8Pi3n58s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s6IzW5B5J6u0PAn7HVRGVE98TGDRiAO8SUJqv9TtzHHPrwJUG55ySmSxusrv5raycLXdIcWYMA1ye3XKfc1827X+zsa2KIkqbkIw3j9uhAheWvvnPpTvZ0cXPYC3nxeE9VGhCl4Iz4f3j7Z6we/YXa59gHCkxBQXs4mmiF3nIYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VvgW18U6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LY3NCc4V; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VvgW18U6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LY3NCc4V"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 80A9611401E5;
	Thu,  3 Oct 2024 14:20:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 03 Oct 2024 14:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727979621; x=1728066021; bh=8P/qDdIMYN
	rpCUiJA6NGFyvIgU7/sSu5sLLoApLqEyQ=; b=VvgW18U6hvtxWH0/tzOkPYxbQa
	WlqTy83r9iwZeN3BkVtwwq6l7msON/0LbL1mFukG8F28TC5mJ0cdr9Zndd32cT1v
	/YZLL1xHPLqVf5/YjBm/oUOV7CZjKxX3RZrHiC9kCGjvbvTaJ6tIUeX6dTKdByUG
	f5ER7CeB7cOjeLzgnrJpwfezg8LO0UxHfbzb7JAlXsqdIj5YQBzEZvQw9Vs0gItJ
	Qr0EgtLSlHdcvEAa8cL+ErPrd70Ql+kzRwKVJ2Z4kZpvD932VMEuDQhlqKla6VrD
	J81TIOd/41N3MmLa2j/2/1YFTLBuO/sUfQ2j+YD5Pg9CCi7F2jRHUYvge7dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727979621; x=1728066021; bh=8P/qDdIMYNrpCUiJA6NGFyvIgU7/
	sSu5sLLoApLqEyQ=; b=LY3NCc4V6cF82b5sMjMdOItCGidWKPHmaysi9/elMjlX
	IP7xtw8yszZK6ePnyOSaPbzU9BMZOxGwPvVPjwQg685XlJV0MZLn1HkOPt33BtbE
	NMdtVtbh7P3rKLoTkjRlMBRd8VO9FcuRBuga8R59RgMWCJJhsRYllYJOK+xSJdyM
	GZtY1p7nrk0Wej+OgyT++EUGyEP93ROXqxUEFo9pSJ7K8plFn82mr8RQMmqkGUew
	64cEKJ5y2Xrs7FmepgG9xbbklEXhub14TcYEOhc4dVTWTHB4mRkhswEIWq1iaLob
	MxeVmSQNpcldZsChc0FcH89fCoEkrRyO3YqjQ6y8AQ==
X-ME-Sender: <xms:ZeD-ZuY_O0trxX_HZsrwlLWAAw8xcH9iqr4G_mCY8FuFrY7f0vl0ww>
    <xme:ZeD-Zhb1oOceK4PSFKnQki4B3dyJ4KeGgNdHp0slYWN20d0fIjyLP-qN24HE49bsb
    60GlB4zkd1-WdGRHA>
X-ME-Received: <xmr:ZeD-Zo92YjfLrfycgSGXo50vK3ghx39C7M69ec27CEFL7uqBlDRpsrxKq0w1KZV5gl_Azh_QqaQGM7ktkyafGw2w8YkW90fVF7JvyV8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ZeD-ZgphKJ4W63O1yvqKuuM9y5TQg4ZfWH8tOFsz_Ap7-Y3-izdvrg>
    <xmx:ZeD-ZpoR3PtoBdlpIEJdkgYP_8Np-swHlzzLM5enZv7k58TbuwxohQ>
    <xmx:ZeD-ZuR2YjvIAMjBdve6LfukJxpWCJf4bbIxPJrCNxpljBYFBUn2bQ>
    <xmx:ZeD-ZpoIi4SLWbj-8EWLnZZcccOTWxwoHIByniRGD0KcPS_Wd5I_Bg>
    <xmx:ZeD-ZqlQd6myF7FVC9alEY1mL2WlNsMojyC95y38GRqwmq6nG5iWZ4Ye>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 14:20:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH (v2.47 regression)] hash.h: set
 NEEDS_CLONE_HELPER_UNSAFE in fallback mode
In-Reply-To: <Zv3r9FBd+Nog3wb7@nand.local> (Taylor Blau's message of "Wed, 2
	Oct 2024 20:57:24 -0400")
References: <20241002232618.GA3442753@coredump.intra.peff.net>
	<Zv3r9FBd+Nog3wb7@nand.local>
Date: Thu, 03 Oct 2024 11:20:19 -0700
Message-ID: <xmqq8qv5hwv0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Oct 02, 2024 at 07:26:18PM -0400, Jeff King wrote:
>> diff --git a/hash.h b/hash.h
>> index f97f858307..756166ce5e 100644
>> --- a/hash.h
>> +++ b/hash.h
>> @@ -82,6 +82,9 @@
>>  #  ifdef platform_SHA1_Clone
>>  #    define platform_SHA1_Clone_unsafe platform_SHA1_Clone
>>  #  endif
>> +#  ifdef SHA1_NEEDS_CLONE_HELPER
>> +#    define SHA1_NEEDS_CLONE_HELPER_UNSAFE
>> +#  endif
>>  #endif
>
> Gah. I could have sworn I wrote something like this myself, but I must
> have dropped it or hallucinated writing it in the first place.
>
> Thanks for finding and fixing.

Yeah, thanks, all.
