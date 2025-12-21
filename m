Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F9122F01
	for <git@vger.kernel.org>; Sun, 21 Dec 2025 03:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766287661; cv=none; b=XkIgFNL2zkv94DNnkc08HeTF0TD//Pnbb7Ypv86u+2V/wgS2gnfFqKJ6R+9dq+gV3jOub5IENroXk9lZBnBavCrn7ep3Aw6wxdAkUJKHNimOEv8gjNxFlknfzA4kY5t/3R9OP2PTVaU0/ShEVGNnLhJJ+sZXcGC6RCJM8iW1FuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766287661; c=relaxed/simple;
	bh=LuZB0/1uYk8bmPU50FVKEMMghoscaU4wTaXogNxzvUs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L3qlFl3bDfTwcQdGlBPzeCcGJWzGXpjENkv4Vop0mvqwW9l43wPTlIERAbYHC2/GFpMbp25cdXiQ4Pqm0ERnuP3pz8SvUJKF0YvYB21ZkGHJCJLjVJaBYJxQpxkT1znxg5FrTFsUYqrkGwDMdgMC/+0TauXaIny6t1aIzS8Ykms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dhPyXQWl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u/AqFwst; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dhPyXQWl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u/AqFwst"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 063211400039;
	Sat, 20 Dec 2025 22:27:38 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Sat, 20 Dec 2025 22:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766287658; x=1766374058; bh=AvEv2bX0Uy
	/S49SOO4MkejXkoqfTPph6uJ08Jd2o7Ow=; b=dhPyXQWlOvjyA6RIn6JtRXh9of
	QcgR3s2Ido6G/ebHR8iY0CjFg8okp/q97TBYxMnWGN4GHZCyFEUWZNTfjVJpbwYu
	n8mW9gY1AxHTnnxDQ1RTNxUcctWQElpB9xeKAT5SMz/yzEo5HZf52cJ8CQEI6kG8
	iykr5QwZoXDCKfuageHo5blZBAYSwzwPeqzItOyKjjgXJb/CNluMXUKm0Q+9YMW2
	zqA9gI83t2+PUMugqt+34SyiXXzo2b9jZ4OtzmnOsAf70ytHnxG41XuJxhdH9mF+
	UKPcEgdBCs44QCwHn2cEcZMsNCOIfl6DjsZBAtLbw5ELjKwN+duoqjPK8Xgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766287658; x=1766374058; bh=AvEv2bX0Uy/S49SOO4MkejXkoqfTPph6uJ0
	8Jd2o7Ow=; b=u/AqFwstjknT0uyk9jqTOFO07ivJ6ykO3pYAhhaspzWptWTVXHr
	EZN+NWy6lvPrQfOAmoOL8f4EReaCzXw3c2Orf/Dni9i9RFpu9NMSB3S6uPmDYvcf
	uW0ABiQPI54qc9mJVfD8D9rxm59StW0iixylYEzr9VSeSafZa6uWZ2vIBYEqanop
	yU0K7WkfIjVeOe8Jo6uIjGzMZiaJzbqRtR21OGvgXxF1Am5UC0dTf42GpUvmwYJZ
	HL0BAR2l6ks9Bke/3DqWZTkfpNlxTurqxbaKzXhDKF7vrBNje2LhAuiONi00V6pI
	1IdFwpbmqTsGCh8NUHQcYlohaO0TiW2+sDw==
X-ME-Sender: <xms:KWlHaYD0e2ZqD-hz0cXooIgaKdPpRuUpvmwDn5izVOGC2sdQ_NIrrw>
    <xme:KWlHaWWFoyMxn3buD6JkdRQ2LsEoYXQ2Okn58wb3KXhOhDfmqHu7xjXFwaiy_vN7C
    uyQ_jPWcODxpnV0TOu6SGxHT_vTbvn-xuY-wSIE-nB0oGK2QPkRgA>
X-ME-Received: <xmr:KWlHaW_D5W1w4LL_V1_MrD9heUpg1iTlkG3kZXoR900Hu_Lwv74mNkbiqqY20iYuqfStQbnZpdIvyXy3xNrptndgL4NSK1jIig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehvdeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrug
    hrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghmihhlhihshhgrfhhfvg
    hrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehruggrmhgriihiohesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegrrg
    hrohhnsehstghhrhgrsgdrtghomhdprhgtphhtthhopehjrhhnihgvuggvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhtvggrug
    hmohhnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:KWlHaYQtbNdHIVqTSatOPOWQHKglQbZntsZjHtTGxC5jvLzY-eze8g>
    <xmx:KWlHabSPLp58bLQwAgOtxd9yJrTlFf7fBTH1_piuxvb-Ha0KPo7ceA>
    <xmx:KWlHaU653euGnd28uf1--KyPXh7QamBapt2arvjoCLqSSpizc4dtQQ>
    <xmx:KWlHaQUIZeN0CjPxfZDiuff9Xm76r5qlczV-EwGli5HjXofiHCeZEA>
    <xmx:KmlHaciH0XmIAZzk1l5X_cPgm9tTlhbPueny6TUizfS1Kn3RXSL1HTRT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Dec 2025 22:27:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Rodrigo
 Damazio Bovendorp <rdamazio@google.com>,  Jeff King <peff@peff.net>,
  Aaron Schrab <aaron@schrab.com>,  Jonathan Nieder <jrnieder@gmail.com>,
  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon <steadmon@google.com>,
  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v7 04/11] submodule: introduce
 extensions.submodulePathConfig
In-Reply-To: <20251220101528.1227487-5-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Sat, 20 Dec 2025 12:15:21 +0200")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20251220101528.1227487-1-adrian.ratiu@collabora.com>
	<20251220101528.1227487-5-adrian.ratiu@collabora.com>
Date: Sun, 21 Dec 2025 12:27:36 +0900
Message-ID: <xmqqy0mwsedz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

This comment is not about the primary contents of this series, but
I notice that the whitespace immediately after "errors like" is not
a SP but a HT here.

> +* Encounter errors like	`refusing to create ... in another submodule's git dir`
   123456701234567012345670

I have already alluded to it as a #leftoverbit in a different topic,
but we probably want to have a new whitespace error class to detect
a HT in the middle of a sentence that should have been a SP.

Perhaps the rule would be something like a HT that is at the column
that is at (tab-width - 1) modulo tab-width (default 8, but the
usual attribute applies), that is surrounded by non-whitespace
characters on both sides.

I may be counting off-by-one, though ;-) The quoted problematic line
has, labeling the leftmost column as 1, the HT at the 24th column.

 cf. https://lore.kernel.org/git/xmqq5xa76z0o.fsf@gitster.g/
