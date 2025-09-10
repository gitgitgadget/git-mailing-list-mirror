Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3823C1BC4E
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517062; cv=none; b=FNjnX22MIWALgk8CmycXWL/zQWs5b6nI3Su89HB/m0n6LnPDjgA16dRMCRMJPb5GLVnR6W9jE4FD7Idwv85n5220ucyF/ByWy2tUlkWwkiOed8fd/mrv1T3h45aFhKl6FykePA2YY7WhQ68meALRo4CWBkfQUT33FOvmmSxWxt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517062; c=relaxed/simple;
	bh=CqC/bXZezoO4X8RpKsqZ1AfHHMLxsA9epKiEqY9/Nl0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SYvHQdST3LsCabSHyKpl2JhmIZ4wQqZ8DAop2T9iEAoK15NiKVRAzljMvFZJHGehG64weiUHrnErOhNaKPp/NTWieE0xec5B/otBv9eMUdV+/PUnr3u7+740fuIyyYYrnk/j4yzIRWHjYKBS+3wGW5DpX4Va2qlG3NyVVLe+Ei4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FxL4lKgF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PTdC9UJV; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FxL4lKgF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PTdC9UJV"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3BD877A017E;
	Wed, 10 Sep 2025 11:10:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 10 Sep 2025 11:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757517059; x=1757603459; bh=hU/CC6WuI0
	I2+pBrZ9pKyFkwFectJoQ3e3SHQFz6cBI=; b=FxL4lKgFxQR9HZvN7FOpDwpxom
	Sq2rMcvVO4V1du4qa4i/4f5MsYc7XIYV1zzga2tNs7yR9FpGZltVBWbOtdKmE1ai
	phRQD8MJwKZV3Sr5F5gVVV9CfgqXM8F8Ohkk0C3vaT8ZwAp1x17s54q6bacCuvS5
	43IBFr4xBXI+vFqjG2Kov5lO5jqXca85vBkkEjHDXs0kLllLzbMQGJWLkHWbzfTp
	2ksXxUNYXn9deRV45/wrBecZ+ILSCh4YwwfxNXbOHS1MxcBxyOLBcVtlX2ejWC+Q
	HpyRF26OJcmf88pPXvcY5Ac9+IPWQ9l/TyRXtS2Vx1NDPe5dDvDJ880pE+4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757517059; x=1757603459; bh=hU/CC6WuI0I2+pBrZ9pKyFkwFectJoQ3e3S
	HQFz6cBI=; b=PTdC9UJV3JXp+I9djpqp5T3cjSDUvdcsk69uNdjn8OptY76vCpP
	F2LX8s19V17kQ5iHR7S0ias9JptPpV+axrQMZchjpDciX8pDdp4ydo5S4ErcPA+A
	yoXpVjjEmIAbcd4GNKJLd1hBpPgmKrMDM6X/+UfpYyJMRe/uWxBH+L/i8ZnhAneq
	87NQMF4XwREYrLAUOh5xU+7EUyttfzfGaJaKmuX+Yq+AC8nWfY09EpvsbMdMZwE6
	GnmUU2I6h4DrVavfvPna14uZp244o9jays8wEaUdKsFWJtpEx92SD0HED212SDGi
	R4O+Kphl/PID9xET9GnzvUlIUbn87AK7lnw==
X-ME-Sender: <xms:AZXBaLqr7lL6_DMfnVnC-Zbvp9SVJczOJMxDnSffh1BGvWh0Go-CbA>
    <xme:AZXBaJcOFaH0fks-TcENq42DbfKGVlpCwWxfbqPTEWmgJtEs9fmGaDaQdkF_Nk5bX
    HhX-hot-bVDxvqAcQ>
X-ME-Received: <xmr:AZXBaBRAlDgrED47c_pItFtEtmgH7SLHxw6U8qeP5ZvbApVg8SB252G6T4i-1tPjnAFH-xIYb_FQGYEjd9hUVgxLYFwJu-hUwv8PLF8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrshhkodhgihhtsehhohifughoihdrlhgrnhgupdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeiirggthh
    drfhgvthhtvghrshesrghpohhllhhoghhrrghphhhqlhdrtghomhdprhgtphhtthhopegt
    hhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepphgrthhrih
    hksehpshhpughfkhhithdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:AZXBaCac-yZy25YT0t2i64cjfb3ZA9b0ycpaMIj0E_1y30ndFhCZcw>
    <xmx:AZXBaEeb3Bxx1J7gMrDVMgi94rT_dKcqZbq8K7ykDgvlVDseyYw1JQ>
    <xmx:AZXBaDKlcMitckTQ2g-0viHzhpLgr86Zy0KRnNyAkFRL8WEwoab1Fw>
    <xmx:AZXBaBJgYqfD5dcr1m2he_87eO3x3M69M7_C66qWwkNb-PjKNY-sAg>
    <xmx:A5XBaEGiuJIEdeBtFSQJf1HO_hmRkjRlQXk-hkA-zODe01h9SEciBQcI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 11:10:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Colin Stagner <ask+git@howdoi.land>
Cc: phillip.wood@dunelm.org.uk,  git@vger.kernel.org,  Zach FettersMoore
 <zach.fetters@apollographql.com>,  Christian Couder
 <chriscool@tuxfamily.org>,  Patrik Weiskircher <patrik@pspdfkit.com>
Subject: Re: [PATCH v2] contrib/subtree: fix split with squashed subtrees
In-Reply-To: <641aaa9b-2b23-4faf-a13e-f6205e9ef5a2@howdoi.land> (Colin
	Stagner's message of "Tue, 9 Sep 2025 22:00:18 -0500")
References: <20250824191048.1938340-1-ask+git@howdoi.land>
	<20250905022728.940664-1-ask+git@howdoi.land>
	<b78639ee-021d-49fc-8b8d-0140ed8fc010@gmail.com>
	<8d341a51-2135-4c62-9df1-5be351e73275@howdoi.land>
	<xmqqbjnjt67y.fsf@gitster.g>
	<641aaa9b-2b23-4faf-a13e-f6205e9ef5a2@howdoi.land>
Date: Wed, 10 Sep 2025 08:10:56 -0700
Message-ID: <xmqq7by6tkan.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Colin Stagner <ask+git@howdoi.land> writes:

> On 9/9/25 21:02, Junio C Hamano wrote:
>> Besides, "if test -n ${subtree_dir-}" without colon would be the
>> more proper way for those who care about "set -u", wouldn't it?  It
>> is not that you want to substitute with an empty string that comes
>> between that "-" and "}" when subtree_dir is unset or set to empty.
>> You are preparing for the case where the variable is truly not set,
>> and the variable being set to an empty string is not something you
>> are worried about.
> Yes, "test -n ${subtree_dir-}" is definitely the more correct expression.
>
> At the very real risk of embarrassing myself in public today... in the
> particular case of a "test -n," is there actually an appreciable
> difference? Either way, the output of the substitution is empty if the
> input is empty or undefined. Here, "test -n ${subtree_dir:-}" is
> merely less efficient. Right?
>
> The difference between "${x:-}" vs "${x-}" really starts to matter if
> you want to permit the empty string (or not). It also matters if you
> call a command that has side effects.
>
> (And in the context of this patch, neither are necessary.)

Correct.  There is no practical difference.

Your explanation for using the "default values" parameter expansion
in this script, knowing that "set -u" is not in use, being it is out
of inertia, I would have expected them to be written in a way that
is suitable when "set -u" is in use, which is without colon.  Doing
something "different" on a variable that is set but set to an empty
string is not something you would want to do to deal with "set -u",
so I found it strange to see the colon there.

There is no practical difference, since the "default value"
specified is an empty string, so a variable set to an empty string
will use the empty string between ":-" and "}" instead of its value
that is another empty string, and you can tell these two empty
strings apart in the result ;-)

