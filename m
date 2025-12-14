Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4802C0F63
	for <git@vger.kernel.org>; Sun, 14 Dec 2025 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765710431; cv=none; b=kv7EjFzKpg5HQYMJ87ltE/5TutqRI78AJnZ1bl1sV7UOA/ojvI3SXBRzuLS8c7QHfDYcxFBEMoOtJXQ114BGQdJf/i65iHsEjooLZta2x5SD+sRM4L+n8ai7b8pIa0uHP/EqjDCyR/XJ2OmwUIwEQrTsYmuDUSeNs+oOdsg5ZoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765710431; c=relaxed/simple;
	bh=Oi3yyZHlrriBu6f1zJyG8h2UxxvCHyDIZKvJ+1J2YoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jOg6DvAYvMWiSXW7xjKatFRrafhM+GbTsTIkcsgln39mgDJGgdNRkS1zW+3yA7fSqDb92OsjSiu5FapiCEahS4Y5YqmG4tGPF4+cS7wWUYCxCjljjD9qN25tj1qgCaQ/iFCrvocxhUnB7S7CJsHFi0ZbnBRP11DWK6j3t7pbLiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jAvccfPi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yImNKVws; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jAvccfPi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yImNKVws"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 755D41D000AE;
	Sun, 14 Dec 2025 06:07:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Sun, 14 Dec 2025 06:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765710424;
	 x=1765796824; bh=VXo824Ou2YUK+lSXak/whvxDjB49pp8l72cyAenfOHY=; b=
	jAvccfPiOS+CuMhCEkDQtZLde6ry9sGb6JPlM9MFBvci86FHKcJ9d3LlmBJaJ3Yu
	3wwaZuhX1OseKj6LYaLhzgRJ5buFyVa5hTc+psNkGJ0LVrDvF8WWEowFKJ7F15MF
	ImGD8cuPSDS8wqO/+sMv+Qwy8nlQZlWZVOieRd2VwpC6bf82j4Mwlc3Vw4IX5HFI
	UdPG6of5bf7iyo1s7V5D4CqMO68eZhtYtcbdaFf7D5yQB7pRxX4UiSp52T8seddo
	9WIxHtNChLdjq9W9KwD46RORoMpYTPlN9IsqLgS5OJx5eX2oL5QAA9TxwyQSPQ7w
	B7kFJtrTiBadOWUp7bKOWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765710424; x=
	1765796824; bh=VXo824Ou2YUK+lSXak/whvxDjB49pp8l72cyAenfOHY=; b=y
	ImNKVwsaWU9iWOJU3XF2+CyyGAWvozoP2J9182JvttFGIJJOGIkfETC4jSoiji29
	QdX1vaXan+OfYLTKeZIrmQkST3VjrQnh0JKKF+Ga7nOWfcwZeflG5/j83PMVXASl
	x0hOoBm1Uh9G7E+24Ga6kK9YQASzx7y+2ZgS22Xfcx+4WndpdIIlBfS6Dy9qG6WL
	yU/c41OrxVlEg9rz17AfMQ9h4CQZ4QyK998vV9N0ktbjWOK/9i5fu4JZLG9I/SJp
	dtfAPf2MCjFnji9B3iTV0R0+OmVd/0rzWIMgKhcBGDeEWn2aV4pnTwEWIrGZoQrR
	J5fsEKEmDTPYI1c/MO0rw==
X-ME-Sender: <xms:WJo-aWkV0a3hb7td0qAuTPdw8iWiKVfKAt6UMvpLZOFicw0Rg60_mg>
    <xme:WJo-ac5udzTBHQRotjqkMPL4NP8VFuFOAEBjNYkczdL7WTt5y-pOP2a5lPN55CAj6
    mbH0KvIYMsl5ndUddPjhu6MBZtYuJNg6Jr7_U2BvEFD2sprTBSTBg>
X-ME-Received: <xmr:WJo-aa3_2wFAqHrLnRpnH2Hqm8kkL_V8ZRewazzzq8FqctRg6F28ORBBFg5vTls0q7EgnRqbYyBqIOdVKT4nbJ1xnXKzoAheGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthgsohgvghhiseifvggsrdguvgdprhgtphhtthhope
    hlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgtphhtth
    hopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphht
    thhopehkohhjihdrnhgrkhgrmhgrrhhusehgrhgvvgdrnhgvthdprhgtphhtthhopeihtg
    hhihhnrdhmrggtvhhimhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:WJo-aXFoxqCNDgoCwARv-qopTqPtl5YvL6IeyL6sAN7lg8ZRAVuFmA>
    <xmx:WJo-aZiMuiTv4PGjZE29ShUxi73nfxLX1CXfpkrW1C5Gs6BF11e3Ww>
    <xmx:WJo-aaBqloq3b_WyYUI5YNmI8m9EUToOGSgFlm3HcUXpMq44YmBsPg>
    <xmx:WJo-abR2GrTLKsJirFnX9ZgRED06eIQ_sQO61D5Z1Dsq1du7qif79A>
    <xmx:WJo-aarMNFo2i-Li0mfPd8af4Q4y7vLmdrReI1LsmDlRTYugs9m2f1RC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Dec 2025 06:07:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>,  Carlo
 Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,  "brian m .
 carlson"
 <sandals@crustytoothpaste.net>,  Koji Nakamaru <koji.nakamaru@gree.net>,
  Yee Cheng Chin <ychin.macvim@gmail.com>
Subject: Re: [PATCH v2 1/2] Makefile: add NO_HOMEBREW
In-Reply-To: <20251214090209.GA28723@tb-raspi4> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Sun, 14 Dec 2025 10:02:09 +0100")
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
	<fe00aa37-e929-4ca6-ac23-84a693a48bc6@web.de>
	<20251214064544.GA26358@tb-raspi4> <xmqqecoxa645.fsf@gitster.g>
	<20251214090209.GA28723@tb-raspi4>
Date: Sun, 14 Dec 2025 20:07:02 +0900
Message-ID: <xmqq7bup9vah.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Torsten Bögershausen <tboegi@web.de> writes:

> The main question is still, where the HOMEBREW_XXX variables
> are used ?
> I see that we define them in config.mak.uname
> ...I understand these are purely _our_ thing
> That is what I don't get. It seems as if these are used when
> compiling under/with homebrew ?

In a part I did not quote from your message I was responding to, to
which you are responding to in the message I am responding to, there
is this gem.

>> +ifndef NO_HOMEBREW
>> +        ifdef HOMEBREW_PREFIX
>
>Question from a homebrew newbie, kind of:
>Where do the HOMEBREW_PREFIX (and other HOMEBREW...) come from,
>and what do they do ?
>
>Running
>git grep HOMEBREW
>gives
>ci/install-dependencies.sh:     export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
>
>Whould it make sense to have a few words here as a comment ?
>
>> +		BASIC_CFLAGS += -I$(HOMEBREW_PREFIX)/include
>> +		BASIC_LDFLAGS += -L$(HOMEBREW_PREFIX)/lib
>> +        endif
>> +        ifdef HOMEBREW_GETTEXT_PREFIX
>> +		BASIC_CFLAGS += -I$(HOMEBREW_GETTEXT_PREFIX)/include
>> +		BASIC_LDFLAGS += -L$(HOMEBREW_GETTEXT_PREFIX)/lib
>> +        endif
>> +        ifdef HOMEBREW_MSGFMT
>> +		MSGFMT = $(HOMEBREW_MSGFMT)
>> +        endif
>> +endif
>> +

So, unless NO_HOMEBREW is set, HOMEBREW_PREFIX can be set by the
builder, or from config.mak.uname (when homebrew is installed in the
default location), and is added to BASIC_CFLAGS etc., which is how
these are used, IIUC.

