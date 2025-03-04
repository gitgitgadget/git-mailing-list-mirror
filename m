Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188C724EA9B
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 18:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111661; cv=none; b=FX1k953wTZViy1o0XruPelcxcGYvuDZdDnpS1PUnmImTpw0IvkaIW5h5llgQx/8ZIAqQaBn5/xePVoRXtlLOZZzB1XJb/l2lLKqmyIvYFLM0fGfGBwMRLIEgi199Tc1h9u3fJ76YRLG9wBNvVBr7meo7cXb09t96Tvar/KCsO+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111661; c=relaxed/simple;
	bh=D3KecSmVMGQdZIyX4tY+vcencrzKNLMwh2zBE1w37so=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nu+/NLQ5f/1oRWXrmTcLOu1g8VLA3XsN5Wk3WBLgVAnVvX3oxqLZ9M8Uz2oMrU76EeDsWRPStE6+UxoGyUsjRKnVNgFfneNaTcahKk0w/RZ+ek1ebxi4EbK0i1MVpVS+vQGPuwols2ndA+wpxHfTFcPJHqmyunKe4P1aZrSNUJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q99t4mgT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FxF96Iwg; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q99t4mgT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FxF96Iwg"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 63A5D1382715;
	Tue,  4 Mar 2025 13:07:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 04 Mar 2025 13:07:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741111659;
	 x=1741198059; bh=m+9Tuk3/lBy01jsAxRpBA3uiz/u24/AyyAF5QdeobhY=; b=
	Q99t4mgTO1uqGuxZH1Gk65i8v1B4nyYE05gI9vho9LSxdGMaqKJIM0BZE3MRWwC8
	RyVzvaSorok+hnHspGUiG90rcQWYrb0DryMFEBmUg6G4sJzleez1dKUU/S0+fZV2
	EezL9jct6dQvSwjHRB7cjYE7yGqWJv9s1+unjS5hiqWN90oTLr1w/koZ2Wjk26vp
	auUY7z/5cP76KZGfQja6AILwTY3J5n9aSJLtPevQd6RPu1SFFhDCI3mo47kMMnMA
	jUKGJNISYN9e4KRskkLEHnX3iJO9qvSe/Zmww5R7XP/pfH2y0+NyTcKFsqCrRGCJ
	E6NMfQbu9/hmBwG4/Y2lJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741111659; x=
	1741198059; bh=m+9Tuk3/lBy01jsAxRpBA3uiz/u24/AyyAF5QdeobhY=; b=F
	xF96IwgYh6ndSp8w5sKp2Z0AZ4XrE4WUUdg6N8hRUZwFRiImzKqvnvdqsFD8Z0hA
	85GjUW4/d8w0b7BOQnFc4HY3IVZPYfps3mqNFkhHtO+KUT9tj5YFj8z0e7K4oHIM
	Zdg2/Dewfe0952ggBPcaOfiOrBcMixPTJjc1RN5/OhepxXyTMbXbqUASzLE1HJ59
	1wwOPC09pKwC6upkyZRcwUncSxd7oIXcb1n58N9yQPGxhL98qpdouXHdGoEXGOxV
	0yhyo3EUoYf3eWHQH5ft8UcHfpBmTMSJnCwmn+qq1UtSIO5iZdsVKbmAoB62Yg3c
	REFUl1CiPPuDwsXjaRw7Q==
X-ME-Sender: <xms:a0HHZ2r8hWzIucQ4iFUG0Kck9JLQxXcPKegmny2kA3uyng0EcHJeNQ>
    <xme:a0HHZ0rRgXuz7BXmX_0Bq15DR-oAWyftScBdUePOM87gwyfckxHf6qfAfFRGKCfkv
    9qly8FsmdaC-2CKiA>
X-ME-Received: <xmr:a0HHZ7Pw5kvjbA5rJP-v64_P7Y5TuPmRBD0ZHtryo8CZoS3c5-FOIl_PgF_khhPUVkCIz3J81eDEhPPiFoL4eqM_TYWPmS98jC6x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddvjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghnihhmrg
    hhvghnughrrgdtledtgeesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:a0HHZ166fDERn6C8egcUrAKURm2iu85xySPHi5xbQ4Jyf6a0LD4gog>
    <xmx:a0HHZ16Sd7Cm9gLErNZmfoKAtmcskrecvt_qRN5kqkQ0Wd07fiv7YA>
    <xmx:a0HHZ1hi-IOF9f3X1luLJR9dMU5wZZbWIOaXhIV64piiux7QXjOBWg>
    <xmx:a0HHZ_6A2sTxSQ815gc8MgQrRpLtAh1M7QzzyfBH3TbaIolXpQoyyw>
    <xmx:a0HHZ43x79HVucigWF1u9nt_xJEqJMFp34_tbScjzJfNIWKcg5o1oWY0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 13:07:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mahendra Dani <danimahendra0904@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 1/1] t1403: prefer test_path_exists helper function
In-Reply-To: <CABGrwBBbtiWtMnwJV3Pefo8VDH2LYWsH2QKG-TG_AEdZq5585A@mail.gmail.com>
	(Mahendra Dani's message of "Tue, 4 Mar 2025 23:19:41 +0530")
References: <20250301105838.1481-1-danimahendra0904@gmail.com>
	<20250301105838.1481-2-danimahendra0904@gmail.com>
	<Z8WD2MeHpOH7Ni8A@pks.im>
	<CABGrwBB1-UiiPEOptN9csVP1WYg2X=SWeMxxiyDfz02VmDp1vA@mail.gmail.com>
	<xmqqldtlt304.fsf@gitster.g>
	<CABGrwBAaN3U8WCtPgd+UjVjsoBniCawWV3U+WdKOzBdG5LxmAg@mail.gmail.com>
	<xmqqwmd4r9jx.fsf@gitster.g>
	<CABGrwBBaHzM9tE6vWkuMSZuUbHVWwCZVTgkvMb04C=NYyGCLAw@mail.gmail.com>
	<xmqqsensr8r9.fsf@gitster.g>
	<CABGrwBBbtiWtMnwJV3Pefo8VDH2LYWsH2QKG-TG_AEdZq5585A@mail.gmail.com>
Date: Tue, 04 Mar 2025 10:07:37 -0800
Message-ID: <xmqqjz94pt3q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Mahendra Dani <danimahendra0904@gmail.com> writes:

> On Tue, Mar 4, 2025 at 11:14 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Mahendra Dani <danimahendra0904@gmail.com> writes:
>>
>> > Yes, due to the use of the "-f" flag, it's not necessary to explicitly
>> > check the lack of file using `test -e`.
>> > But if we drop the "-f" flag, we will have to check the lack of file
>> > using `test -e` or
>> > `test_path_is_file()`.
>>
>> Isn't it the other way around?
>>
>>     $ rm -f nosuch ; echo $?
>>     0
>>     $ rm nosuch ; echo $?
>>     rm: cannot remove 'nosuch': No such file or directory
>>     1
>>
>
> Yes, you are right.
> With the "-f" flag, `rm` returns exit code 0 irrespective of whether
> the file is present or not.
> Thus, the `test -e` check is _required_ if we drop the "-f" flag to
> return the correct exit code.
>
> I apologize for the mistake.

No need for an apology when correcting technical mistakes, which we
all make.

