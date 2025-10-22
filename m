Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23BB2D0C7E
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 03:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761104916; cv=none; b=OYGgkt0SRZ4O7evyhOCBmVpqGUgYrsBwI0ce7YWN+c8esG3Jik0M62C9Y+0BDomHLMk41/PQ228g7sZ+zkBWMt1PsC6cI/RL1MarWwrJC39llH5MtqLYEjJSdkau4XYBMyOpxF4pG6bHHGUSkRA814FjjVH3+7zMByRIOk4bzrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761104916; c=relaxed/simple;
	bh=1Epzb+ToiKvTxJcelwXQ0kUEfGMKYZVaglT7Td+NbwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wtjv8/HNkssdf0UA34AyqKBLjEckWwz+cd1X/OYpWubP1bwwwfv772kEocHmqsazBH15+MHrN4AYnsRgdy3WX80sx6lipykQ42oibKEqQpGhSCKJZ99S8P4cFY2VZ5sh38twFaW8FwAOqWhRpuqnsPWty/4reCywFSZNK6tLoiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J2pHkCkf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rQyML71R; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J2pHkCkf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rQyML71R"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id B9EACEC011C;
	Tue, 21 Oct 2025 23:48:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 21 Oct 2025 23:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761104913; x=1761191313; bh=PCIQdWo67B
	Ve/WZZrm2lupXjl8OWobp/0QstLAvDMQA=; b=J2pHkCkfE5Fhc6Sj3vfiNloi5Q
	ZGe7ITqv4kT2uxZPZmqK0f1e8K3w3vbHIGzr/hP10WdjfAdWKtgaaqdohIhj/yjL
	BeVd3MnFL3hwa2HUAKTUuXnUrAgKGjzd2EDlKW8FPB8ElY8nVbpqYUdAs8iAZXkN
	vPM8P6M5hbHJ9NHeH6keTrt5/rFYri+KvMnkIdNPAbUQbtM+8oG+qmsjBWkiYa5Q
	6ZydL6IQYYuLfxgOhV85YJGD83zDVM0LXyklki9n0oYcAw6Zk/YqhZrhPGhY/pjU
	eo1m6XSgVEg8vZyFxlu1/hNwVPMAxoFYDpVE2ACq3RPXWmG9zFsf52BuOY0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761104913; x=1761191313; bh=PCIQdWo67BVe/WZZrm2lupXjl8OWobp/0Qs
	tLAvDMQA=; b=rQyML71RSh2Lco8/0tj2uQv52Y4w8ZaESk66LayQRyo6/ZXIgfj
	5GnkPYa0XZ0VPMsAmIA1A/oidD4lkxMnssndyvTV066uBzk3/N8cIA/EbN+1Xa0e
	pPSgRgCHQrHggVXVpA5rKubyvTcgHmmKRhpitrPk0oX4yfbWN6vQVohJoVoDIfqV
	NAx+pDXUeijLC/ssXqsxYR+XM3WRiECBMrjOGWmWcknHGokeD6/N5W6CIUnDMLOy
	IL9fMVmcx+KRoH+PdPhXNjw9n/PyiT8wheKQq/b6uu+yzNlcKvbkpEwjcmNCEOCu
	voGw1t/+b5Ue6jLKQJhDZlD1aAeBqmELupQ==
X-ME-Sender: <xms:EFT4aJOU2PuDpKfKg70mMiZ16z4oGI0I5WBFgbmlxMWsUSLqiH4IMw>
    <xme:EFT4aI4SxNUQEu9G85LXb6lDYXWdzL1qx2-Ie57QCr5sRdIMMwvITu3vOwygPwV3C
    7rPUK-XNGNk68gk5FO9v_uVftGMj6Y0Yfc4BUGGXKVmv2SuzJSEVJ0>
X-ME-Received: <xmr:EFT4aD6Y-OBkVQ848k--e2E6_mpLshTI6Vo2SW4cld1vz5yKr_CGrvT8yu2tOWEeK2ORXRxZgdinO4l8OS9peeakElSz4-m7DmCv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EFT4aOEUB2i8JAAAsEx_f3-qMfMNxOXK0sT_1AbqIkvDiqKH_sxIYw>
    <xmx:EFT4aLUH6uUt8NIJomkWSgsYUlrGAUUmHWAWtmKp0ARVvs-aXsWqSw>
    <xmx:EFT4aKU2MbuXa9CyhPUu8EYVsBVcDe7VTg53lYI6XS5npnqkPlr6zA>
    <xmx:EFT4aJJi3JMwXd_ckS_l2MzwayopVjKlJeMKvdiyfbVY-cGiatGuZw>
    <xmx:EVT4aHwiEcRq-Nm6G1XPLXfLfVvOuEB5Litk2uG03kSowQNsXJxByOp4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 23:48:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Justin Tobler <jltobler@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] last-modified: implement faster algorithm
In-Reply-To: <aPgkwnq87UeusC6v@nand.local> (Taylor Blau's message of "Tue, 21
	Oct 2025 20:26:42 -0400")
References: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
	<20251021-b4-toon-last-modified-faster-v2-1-f6dcbc26fc5c@iotcl.com>
	<xmqqy0p4uoqc.fsf@gitster.g> <aPgkwnq87UeusC6v@nand.local>
Date: Tue, 21 Oct 2025 20:48:31 -0700
Message-ID: <xmqqecqv1trk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Oct 21, 2025 at 10:52:11AM -0700, Junio C Hamano wrote:
>> > +		struct diff_filepair *fp = diff_queued_diff.queue[i];
>> > +		size_t k = path_idx(lm, fp->two->path);
>> > +		if (0 <= k && bitmap_get(active_c, k))
>> > +			bitmap_set(lm->scratch, k);
>> > +	}
>>
>> Earlier path_idx() wanted to signal an error by returning negative,
>> but the type is size_t that is unsigned so it cannot do so.  We
>> instead get
>>
>>     builtin/last-modified.c:307:23: error: comparison of unsigned expression in '>= 0' is always true [-Werror=type-limits]
>>       307 |                 if (0 <= k && bitmap_get(active_c, k))
>>           |                       ^~
>> ...
> Yeah, this is a true positive. I was curious if GitHub's version of the
> code also returned "-1" from a function whose return type is unsigned,
> and in fact our version of this function (called diff2idx()) returns an
> 'int'.

Yes, I think the tool is doing the right thing here, unlike "hey you
are comparing int with size_t" we saw earlier, and is giving us a
useful diagnosis.

> Practically speaking that's probably OK, since we are unlikely to have
> so many active paths anyway (or if we did, we'd likely have other
> problems to deal with ;-)), but it is gross nonetheless.

The case path_idx() returns -1 is an error case, not "there are too
many paths we are following" case.  I do not see what relevance the
number of active paths has here.

