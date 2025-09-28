Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCB61514F7
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759088262; cv=none; b=ZKj3Yc2EcGxtbs6WDNpsmeVDgG734SZ7z8vvSiVgkYJDrWCUy0UR0CicdvvaYys+yknJ47X0OpPaI8j30oLLbzflgxd52E+2Cu0bDj1fn2je1CgCIdyxyrty+cxuzaTA/1SByy708eyKaYoCZqNFusHYmjdTn6TzCFp8EeLYJX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759088262; c=relaxed/simple;
	bh=eUzeohf6093a7QhKkmqT/JCTdZFydGRWcGzeeqCH5gw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xso9mt677ydzg7jdtN/dlzfpzcvNMTKmvRWdvvZ7HqQFF2ckt9Poc+NRnaxHvrkkBEHwZ+5Cm0V/TVQCObmxCM/PVm9b5kD9X2F4pm0kEvkFN6cyFXqW3SDQO+T3gn+DXkOSaR6cvPxa8eVZ326XYMITi/A+7Ma/j9g6g0O1zuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eAbPEC8W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CDpX9olz; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eAbPEC8W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CDpX9olz"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id CB07EEC00CE;
	Sun, 28 Sep 2025 15:37:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sun, 28 Sep 2025 15:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759088259;
	 x=1759174659; bh=uQpsvaoViR1HvAcGSMp792+LajhEo/q3/xd03pdX6N0=; b=
	eAbPEC8WSHDbTU4DjmEeqPJ21tzmqEmZP+fh5P1Qbz+RpYJc9cmESk6XP3RONBMe
	gYT+v1hY33ZTib5DN7W23KoIfRjFasLHj7kCX8tkoHu6amIxSLwrdiiGrkhqSwBd
	kjVjAMIHJiHgzAhWfnxhACirZa/QaG5N89b1I8zSitZ9q4QljAOvNppRz3YyFVp7
	Rq2jR07xv6NJICKNptnF3h26RLjvy6P1r9dd/kZytQmKLXA7XSFYG4S7oIHKFjgJ
	eIyay/zugE3gS2uvsyewDccjqFFEaGZTEV0t/RPZalcFsdBAfK7Ncsl+JS11CD9M
	+2Bj+hxXFaevNiMq7KoqMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759088259; x=
	1759174659; bh=uQpsvaoViR1HvAcGSMp792+LajhEo/q3/xd03pdX6N0=; b=C
	DpX9olzjG6GxvcjVLhPyzgQuvGJ6Q+hMEnXeonaujMoHS7RsdQlgZAybfjYjkdBz
	hHLp64UQPI+q17xCEYz0phpYHoTk9oYBE3c7wyycExAsKKDoCfQiJgDOj7UlJD8B
	IJ7HnNueJRd1KaynI4yro+S/nVyYO4fTHpksD72kyTT66ewihAMxwj+MLqXxkTax
	LghhMCMm0us9yfNytaaHG3E+i9KAMi84wkDVNNxZssZ5N8BZjnUyP6Cf0/d6iGQ9
	PH0/4TfHMs7yhrAn9vbOHVJplVmPTCoTW/0gMFMTFrzEuzKhdoTP+aYiIZ5MPgo/
	i8mGz1KtjxZysvZXlDLqg==
X-ME-Sender: <xms:g47ZaBSU_xxWlDYfhPQBxLcpS_wAZLN3o3aaVCOFrF7zgPDAAr41Zw>
    <xme:g47ZaCP8HYR7geMwOuP2RGOYxh8GKC6xNJtUoCFJEevd7smAvUvnLTzL9oYhw-aWA
    E1R6-gvzLJ9LCKPcUsxo1rr15bp4m2JPijv72P6bPWeR43L218jNg>
X-ME-Received: <xmr:g47ZaEPVDTAlOb1vmEscxxFmmpM9bTdzJA-IgB256-jYbS6j9qpuzd3mcYENkrrOgspoqyBkg_8n26bI24U65_d9qhuYEYqcjmg1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejheelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:g47ZaCuDDIDVXU2pNrZ5y3Osnb93esfDGMOtO7c9m3lYD03SiMNDPQ>
    <xmx:g47ZaOX2MWNr1-Dxy-BCC1pDQqCvmm9lcZc2u0PFLG1lK68S0vWbhw>
    <xmx:g47ZaKtexVv4xIdZrbSOoairwB_KoSkjTjykJI46OubC2QPGdeQXGw>
    <xmx:g47ZaKX6jWOGNj59itywxdAY_enqfGRYoJYdPvOgPtRO7G9CjJLOXQ>
    <xmx:g47ZaKU3cZn_6BD4Uf7e6SEtyuGMzXKQH-WPTBVRNxIjs2vkSfwtMo9v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Sep 2025 15:37:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: patch-id: fix accidental literal blocks
In-Reply-To: <b7ded038-fc91-41cc-b241-1ace6b46069c@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Sun, 28 Sep 2025 21:25:26 +0200")
References: <0520e8f9caf.1759067095.git.code@khaugsbakk.name>
	<xmqq4ism7eh4.fsf@gitster.g>
	<b7ded038-fc91-41cc-b241-1ace6b46069c@app.fastmail.com>
Date: Sun, 28 Sep 2025 12:37:37 -0700
Message-ID: <xmqqv7l25pxa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> ...
>>> This is kind of subtle since only the last paragraph of each option gets
>>> rendered in an unintended way, namely as literal blocks.  This is easier
>>> to see in the HTML output since the man page output just has a slightly
>>> larger indentation on these paragraphs.
>>
>> Hmph, I've always thought that the practice breaks every paragraph
>> except for the first one (which is the same as "only the last",
>> only when you have exactly 2 paragraphs; when you have more than 2,
>> it makes a difference).
>
> I don’t understand why but `doc-diff` agrees that these last ones are
> the only ones affected by this change.

But in this patch, you are not dealing with a section with three or
more paragraphs, are you?  I think there is nothing doc-diff can
show you in this particular fix.

For example, the first hunk deals with

	--verbatim::
		Calculate the patch-id of the input as it is given, do not strip
		any whitespace.

		This is the default if patchid.verbatim is true.

two paragraphs, "Calculate...", and "This is the default...".  It is
correct that the second paragraph needs to be treated, like so:

	--verbatim::
		Calculate the patch-id of the input as it is given, do not strip
		any whitespace.
	+
	This is the default if patchid.verbatim is true.

and that is what your patch does.

But if you had three or more, e.g.,

	--verbatim::
		Calculate the patch-id of the input as it is given, do not strip
		any whitespace.

		This is the default if patchid.verbatim is true.

		For fun, we add a third paragraph.

would it render the first two paragraph correctly, and only the "For
fun, ..." paragraph gets shown incorrectly?  And would it give us a
good rendition to fix only the last paragraph, like so:

	--verbatim::
		Calculate the patch-id of the input as it is given, do not strip
		any whitespace.

		This is the default if patchid.verbatim is true.
	+
	For fun, we add a third paragraph.

That is what your proposed log message said, and that is what I
wanted to double check, as from memory and experience, I am
reasonably sure that in such a case, I had to correct it more like

	--verbatim::
		Calculate the patch-id of the input as it is given, do not strip
		any whitespace.
	+
	This is the default if patchid.verbatim is true.
	+
	For fun, we add a third paragraph.

i.e., the second and subsequent paragraphs needed the "a + on a line
byitself before the paragraph, and paragraph itself dedented"
treatment.

Thanks.
