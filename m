Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFBA24BBFD
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 23:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758325388; cv=none; b=BUboZNCWdtOTp1CSBFwtKcO6FAlMv+FvZvVbLNmHYrcqF5Y2ZdRFvo6xCns9BNeFCCAi017tjW9HSzAv3Kb9vjGJ6A6N56PLm4wN7o5LJpJJ6fEiZoHM0KN+Y0LlX8Sufg4mQk/ydH9LMVamDqj0FABKbvIXdeJMe6y+q2GM7rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758325388; c=relaxed/simple;
	bh=eKAHRmDAgWGw/SSxmLSpAMfVmQs6f4KvH78imUMM148=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n2jAx3I926S+CoF2I+FiTd9GQoFI/8fGll3MFWGBsG3VbiBKGX2FSVhYI0nAqMgiT//PGvZ8J2SzeAl7w2gVO/X/qAA83zQpsJp3BvujHTmXv4/IpLU4Omw7QQnpJe856/L30fZqPAMSdl108a62fSmECQV4luLq+303YdF5z+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RB2Z+6ol; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ILef+4T0; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RB2Z+6ol";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ILef+4T0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4CAB71D000FD;
	Fri, 19 Sep 2025 19:43:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 19 Sep 2025 19:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758325385;
	 x=1758411785; bh=W+tBjrkCUjreaRd0Wzb5+D8yIYAY/Xivuje58qia0JY=; b=
	RB2Z+6olJpUdakGhHBCYA5pKbTjabvxSYgusAV8bsWS+252myyy3UkQYw1D4/AAe
	P1hkriTsBaapXSeEBxKzec46wbhh+VHHqbEP15NT8dvgVdBXDqQseuUI37dcMuMN
	cXYZVV6Bo6slHeSy/ZhkoALWGkodYHiEUDb3Hk73Dehjk2asrIHrUO3Iz9LWxLE6
	KHlKZLO1Hhh5UC5in7Y3wjOqrHoFCAkVpJbxvJ4c5p2g1fHVJttLNMhoUE8PdBxk
	PUpXkz54Fd0bMi3NORY5hZ2RBfl3wI9Pm9T3eBL/aQrz1o6udtfJz3XY4GjMJ4uz
	yl+jDuvf+Nk+buhovSbfCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758325385; x=
	1758411785; bh=W+tBjrkCUjreaRd0Wzb5+D8yIYAY/Xivuje58qia0JY=; b=I
	Lef+4T0TxkikTpteVa/KoSechpJTH0siT55QcMjNR2RNCNMFP/g4MBw4UYMEEuwC
	gbuM88r04+EIFsZK4p7DCtQSVY3ra6B8hP0Zz94ZCF59w08lr8SxpJOcDUbZqiHB
	7Ddwxo1e9Cg7JKt6uOAAOGvPMnYiVBoQ1jQ+HWOfjvQ+i7NnGaHSFq7jHMiix7bO
	YzgWOjjiwEw+/qiolRn6U3YexAnmclD5HXddA/H6/wyGnL70JoZuJN+4FOM6uwDZ
	6NYq8JTOU3iBYkl6bfACs3bfKEi5acNvQTxp7vhGx0TOS00nqPGGp2CSRqIbSLJ7
	uhLGl1g2zuuo22fhTZMAw==
X-ME-Sender: <xms:iOrNaK0812TgcqcrbmxOn3oDDYq3jjyJjOq2Rnxmv_Yf0O5CNosRZw>
    <xme:iOrNaFieZ45OgV-juz_Kag8CI7TUh_ETef9YVrd7T2yiD1l6n0m0LB06Wx_HqFw6o
    gzaj2_BiFIeyyKI0A>
X-ME-Received: <xmr:iOrNaDXrbucz1TBc3y99Mq0foid-PrTSYuXRPOz3LOMkgBENiAo2CojblpdUJ_U47X9_uF_-Il0s2rGtMbFob-LzV83o8SYgLssn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtdehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtghhithhgrggughgvth
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:iOrNaMWS3WJzwB26YrJgIOONPnS7DrY0KVmaNUQEdBJZPfKk-CmUGA>
    <xmx:iOrNaLiaAN01veEEgBCTFWl2CFmkAke1NGU9rTOSbk7hxI76AW7kNA>
    <xmx:iOrNaPam6-NycVfsYJlz2pFPceUqWG2XxKYk49o9srpFnG82dmFdRA>
    <xmx:iOrNaAof7QDC389STBoo6PK0gN_zU3jr3o3mqaVemMe3r6fo9bnJ-w>
    <xmx:ierNaDUR8mG8tgIMOuz02BqGNenCDf790mWh_QTV3xPxXccwCQGUXRsN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 19:43:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
  Patrick Steinhardt <ps@pks.im>,
  Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 02/18] make: add -fPIE flag
In-Reply-To: <CAH=ZcbDvwbCdnpeNv6vp=+Zy1h8RpG125ZCQNUzNOc5qLi8gNg@mail.gmail.com>
	(Ezekiel Newren's message of "Fri, 19 Sep 2025 15:52:53 -0600")
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
	<7082e32c5975d2aaa277eddae7497eba0f2131e0.1758071798.git.gitgitgadget@gmail.com>
	<CAPig+cRGtMX9bQhb+7g5aXRVjpLKY-qDdQP95f9TmbY8j_BweQ@mail.gmail.com>
	<CAH=ZcbAOBnEVfyNy_4hdpe_dvsqDxsKVTcvurJz_iUWiqOzG3g@mail.gmail.com>
	<xmqq5xde435i.fsf@gitster.g>
	<CAH=ZcbDvwbCdnpeNv6vp=+Zy1h8RpG125ZCQNUzNOc5qLi8gNg@mail.gmail.com>
Date: Fri, 19 Sep 2025 16:43:03 -0700
Message-ID: <xmqqa52qypo8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ezekiel Newren <ezekielnewren@gmail.com> writes:

> On Fri, Sep 19, 2025 at 2:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Ezekiel Newren <ezekielnewren@gmail.com> writes:
>>
>> > I was trying to get the rust compiler to link against libgit.a. Both
>> > Meson and Makefile produce libgit.a. No changes were to meson.build
>> > were necessary for that to work, but but with Makefile I would get
>> > errors like:
>> > relocation R_X86_64_32 against `.rodata' can not be used when making a
>> > PIE object; recompile with -fPIE
>>
>> This sounds like a workaround that is somewhat platform and compiler
>> specific limitation, at least to me.  Does this need to be conditional
>> and if so on what?
>
> I don't know, but I have another question to add to yours. Why does
> Make need -fPIE in order for the Rust compiler to link against
> libgit.a created by Make, when Meson doesn't seem to specify PIE
> anywhere and yet the Rust compiler can work with Meson's libgit.a
> output?

I do not know what the build procedure using meson exactly does to
create a library archive.  On the Make side, we do not compile for
position independence, and don't do anything other than bog standard
"ar rcs".  Patrick, any hint?

