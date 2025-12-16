Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2C031A04F
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 04:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765859863; cv=none; b=uQX/IAZqe5AyDnD+3EA7Z0GWmED38PqsIXLF0VPFAjLReSaJ56k3pdz1HZCyUGFhKuYyfJuK/eD6pMDHwcvx1OddYEkydqL0r6gi8zvXNlrisdEpb6APDxJIyUbSyawxb5Nq4Zc8+VqdyCXnw6DdduhJlCGLDcluFlIR8bNd3us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765859863; c=relaxed/simple;
	bh=vuuH+qMXPewTP/XsbcOHhP2SLLHep9cQoX/q5tP6sKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cLiRmgMxAuW0/vvdq3Onl/TwbmpOGBV3wtssIeQRmnP3gCNRCCsQrkmn77FufnStzmGSgj1ZNb8w9g1KKfQgc7O8G46Xgsx8td5Xwt9xAQHAOe8qMnbB9oFTRtA2N+FB7EaX9awMiyLtw+MVnt9Z505yMo3+mPa+271oD3cFxA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FoqWCBu5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ToIsHJ0U; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FoqWCBu5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ToIsHJ0U"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C51227A018E;
	Mon, 15 Dec 2025 23:37:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 15 Dec 2025 23:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765859853;
	 x=1765946253; bh=038zaJIa4b0AryKzldLPNFR2IDuEUB20a7rAkcPJSD8=; b=
	FoqWCBu5NIWOMYZQ0iyvCkHlhBQsQfOILStnuQyRpQezD9Z8dVGCmp3xCUHccQvH
	ma6sBNzWUeTGUlh9976gcwAYzlR+naQlRDC4GN478GkhXs98DKIUvjdxf3FJgVIq
	+iSclDLDjbayfuxnIXQkHP7kkamv7aF8CW9+PiarOKSYu3+CBpEsR296JZcbq7xe
	zTQutN2I550a7IUWM1VMsRNJmuqRRQKhxC65jn02m+8sH31wqKk7T4sKa2rBY+Oa
	kq7o0dVVn1ceXLz2XXFCXOtdHnIPjEDUk1KniwuuosrJqmpHC8mCOs7FQr7xCfsd
	DAEtEQRKmHidAbgOZBqt3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765859853; x=
	1765946253; bh=038zaJIa4b0AryKzldLPNFR2IDuEUB20a7rAkcPJSD8=; b=T
	oIsHJ0UWJf7CQ+K7NxpjqgKMvwODuMTbER6tBn6WgF2S70w2AR9hUJejzlL+2mOb
	w/7uzDYNZTl2ILQBUc/zzLBONIeiJISnLt1jwGW2ZWrbHefu89vjY1Hu/m6g4ix2
	+n/DZ4AOEbnknHeYx+/4w4X77V3h7G8E+gDGOkLCvtNi/ghVKkG7GfdhN7KYN2TW
	Ev0C7YV0mUnGl1C28LfN3ADFELPcYItYcoTxWa0ArcRJeoQWOq705CoE7L6yqGSl
	NB+xUYGu550T+klOc7onS/s7mvrNXgUJF7Lvcd2Zb0EnxgXjl6IMzfeEbbLveczv
	UOKCCSXM+8mGqEIZv2uEA==
X-ME-Sender: <xms:DeJAabz7ydoH5zrkTi5K04dGfwdnMDu8UYjFR2LZy6Ye5MWzo25rjw>
    <xme:DeJAaW9Y7LAnkZxp0LVeKs7KW-F7HO8DAuxc_2kHMvaD2PMpdIqUQk9hpP9-4Bp4M
    PHh0ef4jHlTHLAc3VDqdUleHrpIMcl1_OUuvQ96HvyUWsG_8JLbHA>
X-ME-Received: <xmr:DeJAafK7LL3G4TmPEl0cAD_g9kuEIlGuxhhSF7EXBxI2liyjU7prStugey1Tf5B4IrVzi0jUnPHjwEhcYP2BoIF72HHB-sF8VQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkeejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfihorhhlughhvghllhhordhnvghtsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepjhgvfhhfhhhoshhtsehmihgtrhhoshhofhhtrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DeJAacfh7L-4ZAYH13Li2YLJBXSipa6ECf1WWoOfStROuLuGnAULfw>
    <xmx:DeJAae-6nqY2AnCK1VtSoOZTQzybmAzYuzmVaRUdqHER-bdTD5M-HA>
    <xmx:DeJAaZpwDLPpjFc39YYK79aS7Lg4BuA5Mi9cWGtDYDImzReqEZvIHQ>
    <xmx:DeJAaTDEdtEpnN7Qa6POKWnFtZWUtQPO2zvZlL7Jz5L-9PRZjkVBHA>
    <xmx:DeJAabFQpyC1-wmAWgOONF89umYQUNc578fKQExd5r-sJxkfXP4BF8g2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Dec 2025 23:37:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 2/7] strbuf: split out logic to humanise byte values
In-Reply-To: <CANYiYbE3Tx6B5L5rEoDue7hTYzFGxw_qA-MRpC9RSxQ7HRczaw@mail.gmail.com>
	(Jiang Xin's message of "Tue, 16 Dec 2025 10:26:10 +0800")
References: <20251209225820.2861276-1-jltobler@gmail.com>
	<20251212223644.3090879-1-jltobler@gmail.com>
	<20251212223644.3090879-3-jltobler@gmail.com>
	<CANYiYbE3Tx6B5L5rEoDue7hTYzFGxw_qA-MRpC9RSxQ7HRczaw@mail.gmail.com>
Date: Tue, 16 Dec 2025 13:37:31 +0900
Message-ID: <xmqqqzsv3uus.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jiang Xin <worldhello.net@gmail.com> writes:

> On Sat, Dec 13, 2025 at 6:37 AM Justin Tobler <jltobler@gmail.com> wrote:
>> +               return humanise_rate ?
>> +                              /* TRANSLATORS: IEC 80000-13:2008 byte/second */
>> +                              xstrfmt(Q_("byte/s", "bytes/s", bytes)) :
>> +                              /* TRANSLATORS: IEC 80000-13:2008 byte */
>> +                              xstrfmt(Q_("byte", "bytes", bytes));
>
> We have already defined "byte" as a 10n string without plural forms in the
> file "t/helper/test-simple-ipc.c" via commit 36a7eb6876 (t0052: add simple-ipc
> tests and t/helper/test-simple-ipc tool, 2021-03-22 10:29:48 +0000).
>
>     OPT_STRING(0, "byte", &bytevalue, N_("byte"), N_("ballast character")),
>
> The newly introduced usage of "byte" is now marked as having a plural form
> (via Q_("byte", "bytes", bytes)), which causes a conflict. This results in make
> pot failing with the following error:
>
>     msgcat: msgid 'byte' is used without plural and with plural.
>
> This happens because gettext requires that a given msgid be treated
> consistently—either exclusively as a singular string or as part of a plural
> construct—but not both.
>
> To resolve this conflict, we can unmark the singular "byte" in
> t/helper/test-simple-ipc.c, allowing it to reuse the translation from the
> plural-form definition of "byte".

I learned a new thing today and am happy :).

But how does one "unmark" the singular "byte" there, exactly?

Would something like this ...

     OPT_STRING(0, "byte", &bytevalue, Q_("byte", "bytes", 1), N_("ballast character")),

... a good idea, to "mark" it as a countable noun that has a plural
form?

Or did you mean that we can simply drop N_() around it, i.e.,
N_("byte") -> "byte", to discard the i18n, because it merely is a
test helper?

Punting is fine in this case, but in case a similar situation arises
in real code, it would be better to establish a pattern we can
follow.

Thanks.
