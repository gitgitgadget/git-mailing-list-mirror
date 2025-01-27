Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B212191F74
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738009142; cv=none; b=nvwwqSBJ+t0fOSbFjDZjJRmLtok9YenAUOO1XrV2aimskb3822z6wA3X5UdHwJawyIK16BF7a7thb77VRKIK66j2ROaaR7AyTGnUAZ0UqJU7g/LVprEX/8snDtaH/JtkKD5Tp+059p5wvvCC0mzepjTbtE2zI1/1V4nIbLKLk7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738009142; c=relaxed/simple;
	bh=Lj+DZBct5x9Vy7uWcokfSeFjBDAlGWp8vXMo2wRBKmg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ihqmQaevFNDPzRy5KWbWv7OYrVaqABUrVamsQSlnmTOEx0eJ3fuXGshkNPz1TUYJs86QDPGWMiOgdNWdXqj70zSWg2MpILE/O8H82etJxSI2Wm5Vr+S6rWjQj6L/JrGHrmrYuP6gax39aVz6MZeKJrmZKsInaGCgor21EfZUYJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XywGc9e6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CeWAb3KD; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XywGc9e6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CeWAb3KD"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 1979A11401C7;
	Mon, 27 Jan 2025 15:18:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 27 Jan 2025 15:18:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738009138; x=1738095538; bh=Nj0J+tqIQG
	XjpnXxTYnIslyATNYFf9c+bgNgtOiLNeU=; b=XywGc9e6/RWigYn3rTu0+nP0Wc
	co4QdFPNu09ZCcdEh5/65domOAQu3/7dG+R7+dZbwNPkqf4j588Q+j4up9wxE6Ew
	WEYiYAGBHoGB77hjE/q9tEX/3+Ws/+SZeCdJ8KqYYcnRJU7PCf/9kPoayLanReLN
	OnjLksZn30D29wSY8ZNyZyRYapbHK7V327cd/UtrA5FWcr1rq4W92InoQ3pHPJRf
	ws/RHLVP/v/v2r0+wgjG494sc9HHXRkdKwkZeMxMJf1JnxPbzNRX3ANBkNbe2vi5
	LFAsKdQ9MHmbHAw/YUX+srIkiuosaUMYOpry4JsKQIcbInDEIOv8UoZrqzHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738009138; x=1738095538; bh=Nj0J+tqIQGXjpnXxTYnIslyATNYFf9c+bgN
	gtOiLNeU=; b=CeWAb3KDBcqgBrsXtVSpU1ichMzAQDlMFvDodrY509k0kgNHvea
	x7t+kY9qpLcNrb3E8RY6P36IyB5bv6Pg3zvtuuhCYY4nLk0jSrR2rga92seQL7U3
	8mQFy1liJGZ8Cs5AoZv5oQED+rMtIXTn2haRJ0pFYsKvSDm0LwBoMP9x9BWSlmUx
	JFICkTwtEX/9iCp5DBzWtjfD8hgW3+Et3IP0m61tCNPk6d59LiQuDVnyKCQVe6xR
	/TyerUlxopWrPabZO02ITXOt31OYGjKx7rA1y9fAUEF7UuWcjggWN6mLCKzXvHaL
	Jlf5PR/l4H4GXwsEEvl8VJF9Hl2DrK/yFtg==
X-ME-Sender: <xms:MuqXZ7Yls0Tfl9KLG2guNs0NciyydKENJ3PLDbxVFZ_9Z8iRc_O4BA>
    <xme:MuqXZ6au5hNrUDGcAYV_6yFcKYUtkUH9kSr7LJNaxfuv3L7FCcAa7d52EJUdVjrDD
    ZrjxjMURCKphYFAHw>
X-ME-Received: <xmr:MuqXZ9_YiabLfZukWrUf1UAP2M-I2AoJ_tl2sXylMsiBM0jwCfGSMgRs3-2ocW4mZ9BSbqt9p-7rB8gWHQIaqL8UUi3-LIqcAboj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudeguddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopegsvghntggvsehfvghrughinhgrnhguhidrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrihhlse
    gvfihorhhmrdguvgdprhgtphhtthhopehlihhsthesvgifohhrmhdruggvpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:MuqXZxodAVYDu6SRklggHuhv_Kj7ohU9D34ugnSNXKzauxO9WMazgg>
    <xmx:MuqXZ2qE2jp08bBeI8FOz-zech5tBaiO4894heXFqrd5gXIXnV6pow>
    <xmx:MuqXZ3Q5oOCfhDSVCLanlTEAfPZvYoRp6K1l5UPEqmkexUEux2fJmw>
    <xmx:MuqXZ-o_ZJmqXKe51XrSBplI3UVm3US3x1fIYbQOjIRD98Xv140VyA>
    <xmx:MuqXZ3dkrdnl3HPoi-Aw7FfBDsNvMQ10ZkpWiRTaRUP_qRF_JOGhlT08>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 15:18:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Bence Ferdinandy <bence@ferdinandy.com>,  git@vger.kernel.org,
  Christian Hesse <mail@eworm.de>,  Christian Hesse <list@eworm.de>
Subject: Re: [PATCH v2 2/2] fetch set_head: fix non-mirror remotes in bare
 repositories
In-Reply-To: <Z5c2CKpYM3KevMyD@pks.im> (Patrick Steinhardt's message of "Mon,
	27 Jan 2025 08:30:16 +0100")
References: <Z5Mrk02wMdABtrVZ@pks.im>
	<20250126220403.289742-1-bence@ferdinandy.com>
	<20250126220403.289742-2-bence@ferdinandy.com>
	<Z5c2CKpYM3KevMyD@pks.im>
Date: Mon, 27 Jan 2025 12:18:56 -0800
Message-ID: <xmqqjzagqabz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Sun, Jan 26, 2025 at 11:02:11PM +0100, Bence Ferdinandy wrote:
>> In b1b713f722 (fetch set_head: handle mirrored bare repositories,
>> 2024-11-22) it was implicitly assumed that all remotes will be mirrors
>> in a bare repository, thus fetching a non-mirrored remote could lead to
>> HEAD pointing to a non-existent reference. Make sure we only overwrite
>> HEAD if we are in a bare repository and fetching from a mirror.
>> Otherwise, proceed as normally, and create
>> refs/remotes/<nonmirrorremote>/HEAD instead.
>> 
>> Reported-by: Christian Hesse <list@eworm.de>
>> Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
>
> Thanks, both of these patches look sensible to me.

Yeah, they read quite well.  Thanks, all.
Will queue.
