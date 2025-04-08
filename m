Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E350FB664
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 00:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744072398; cv=none; b=XDQ17+tP0b5tEYM7HUuDnzLRVE3KPbF5WeUFNuhaqwHbTPDpbmq/avJwcNoIGddKnk0vO5e4BlnM8K8x2W+fj/Vb8q5li33YOdJ/EoeysXzkzKYTgXN9VkPacrtug5Xh7bOcnuuCc2Xrj3Ddq+q9SPwWvi+eVnrUINfLxY9xATE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744072398; c=relaxed/simple;
	bh=J6CdVu67BF7OAl8BaVOVyBw6PwKpf6YI9dvx6sTuTcY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t1mhEaibt5dhSbjsC1L9tKBMJSahNpQ0wzGBDwOs1qKFNYbhrEzbpxP2a33BMNZ8dTO3ZdtlX0dvOPUHjG0BzYGHxspOMpA47Eb2QrscZJA6CMfaU4O5iCV2IsWNRgTNQWa361/qCbdKI/HGCurEURD/uivP1A7IGvkR8ilGEzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ueSeAT7Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eXcIjq6Y; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ueSeAT7Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eXcIjq6Y"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BD2F625401FD;
	Mon,  7 Apr 2025 20:33:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 07 Apr 2025 20:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744072395;
	 x=1744158795; bh=/uMe1YvNjy6Lp7RcRw0f+Go6t3yJ9OVW5qWFHIWIVFY=; b=
	ueSeAT7ZWNtI53VF+9k5GPo7FnaV4UVt2yLTs4Tq9X0xbcUpStq6O+HzFOFwubOU
	+43mdtr3XCwwcvtzerq9GgCujshzY3sLCa3RBybUybXREzpASFHegqud6CatOi8M
	FbnL73oH6IokqYRez33+9k/dhS2/U+ASOrXz5MYgonahyYQQqUKgsFkzbtY2Mpgw
	PzrUlJEfHezCPxsM9leWjJSrtKcANih3yVX8U75ClS5azq10lEDyeUotElgmYo3B
	kjpP8FFRcdEt/vB5SmJFbW71iLPup2CvKO4dUUMu2HRtd6lpVApXxxSGo4tQXdAq
	qbwCguWlpEsqbsa5U3qF6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744072395; x=
	1744158795; bh=/uMe1YvNjy6Lp7RcRw0f+Go6t3yJ9OVW5qWFHIWIVFY=; b=e
	XcIjq6Ye31/XElnEAcraoBBRa2JWunRbomOk4XX5nA8RWkUDMB9dOY7rtP9zvlzs
	LBcZ1P5U3GWmVZnz4fRouUI55ILCRq22TlptNePTmazjY4adAuG9gPbqlxubCBxc
	YkE8jshJN3yS03Sj2QRZu9iwQHMuffKE55VSaCjseQA0E5JIkpDTfOEQLxV6cxAf
	HWDHbsFtH2aAQ0Lm4g+i9+uXIMOilNm0BR7P8HlzPvdJjW8zPvrbw9eYmnUkCozk
	SM5L1DJncYiME+wUAVgDO3wJhN805taIV4WlycQq1BW/+FF/aoUHztzVcwDOP0Do
	bTJaWR0lCsTmxmHS84DFg==
X-ME-Sender: <xms:y270Z80qZGf1631ECwKnAOYpuQSR5t3vBkpN0CBesFWQFo_X6ic8Cw>
    <xme:y270Z3GDDIeDmRn7PWOSnLG2c68ieNOVK2yfDcCZN_zWPbzWZ7nkF2bey1TJrAhJn
    BeQQvpALA_L0uWJ0g>
X-ME-Received: <xmr:y270Z07V999SZ9v08D3S4ABGC6imkd2vU2qg8l_8L5AHJeGhZ2x2xLRl_I6qwxkjw2r3jIfAEZA1ZkFRjU9D-XUdTSU2fD63zNDL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdduieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsth
    hirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:y270Z11S9ZI_LqjyMGCijUAXbdTfga3hhgz_5Z5ICh6LBU99g1m_HQ>
    <xmx:y270Z_Fjc8pSRK1m8thEBMwVzBO1xqmnXJaSDdvoVgnjzWvymyBslw>
    <xmx:y270Z--v_n-G0p9iXItRYb4_Y_Vj-J41JijXGEztUOPMJEqzcDjAPg>
    <xmx:y270Z0k0czZb3zEePgMsWFyG7Y37naktxq-ghlbbAa0XWraDOkJfmA>
    <xmx:y270Z2V1iie_BmTCfvU_d4a7_1I4AT804rqMxVleEV0qQ4a_3ZDcMBV4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 20:33:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Justin Tobler <jltobler@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] help: include SHA build options in version info
In-Reply-To: <CAP8UFD2a2hA5CEYgr9i5jtw+k8U9gu=Jb01x=W1zekSRBy7B8A@mail.gmail.com>
	(Christian Couder's message of "Fri, 4 Apr 2025 13:06:33 +0200")
References: <20250401203630.285451-1-jltobler@gmail.com>
	<20250403140529.497876-1-jltobler@gmail.com> <Z--kT3fIvz8k7h96@pks.im>
	<CAP8UFD2a2hA5CEYgr9i5jtw+k8U9gu=Jb01x=W1zekSRBy7B8A@mail.gmail.com>
Date: Mon, 07 Apr 2025 17:33:14 -0700
Message-ID: <xmqqo6x7ze45.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Apr 4, 2025 at 11:20 AM Patrick Steinhardt <ps@pks.im> wrote:
>>
>> On Thu, Apr 03, 2025 at 09:05:27AM -0500, Justin Tobler wrote:
>> >
>> Thanks, I'm happy with this version.
>
> I am fine with it as well. Thanks.

Thanks, all.  Will replace.  Let me mark the topic for 'next'.
