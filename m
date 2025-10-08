Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5655914A0B5
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759945158; cv=none; b=ZQ5Ek5S92vdQ658gUN9C7Ty8L2q1l+eSewVHk6d0wx3Okyx6HaSnlaN+wt/jwID+3LhEQKanZxsd8vdVqj6MnJBD7hz02GnUD4Nb0oIDz5YxtZJSNY6KKgaTp8Hryu9Hzd22Qn/eyM0t+8arEY101GAMA708p6aL32xLBm7GQZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759945158; c=relaxed/simple;
	bh=/fa7t9p6hwRpFdYcgKqlrVnOm99LXkQ0PCcb7W1o4gk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ILXc1Hy6rBRBaVALl3SpY5GZ1RKmV9403Ft2OaSURELZZv2xVyBpMsR/tFQzYVTYYyB0ZL+9R3PIHWA8YD5htxZYRqyFJxtkR6kVxUW3i4+Ib3FoNIsfniZYrtmGXnHlZUrY8XPMw3+HkeDrmK96pdQCjDQSWreG2IfMAZMqIjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WT8hP3pp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n1uHavPI; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WT8hP3pp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n1uHavPI"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6DAAE7A00CB;
	Wed,  8 Oct 2025 13:39:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 08 Oct 2025 13:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1759945155; x=1760031555; bh=qx4LuZT3E2iliDyhylYf8LZ61tAJ1iP2
	XlnHp3YH9os=; b=WT8hP3ppVI5HZIJRC4DlXDrUuDc+GTamtWKbzyt5uCUEqzT7
	lLMS1Q+d80DjIWumSxxy2NwYeLT3GNe6qXuX8Td1BLURRfhZhegUqQrYvVonmZsA
	VX6rV8uNaSoWkdWqyot1Or97EC/2j0/qNwbN6kAKDfcT8MRCBlUn5o3m8moTZ+K7
	IjcdJxrtv02xcYUe/VBJIYD5RngX9vO2fMDed7jQ8lsEkkjtFhVF79OdkQju51wl
	KAiAOoZ+/AitQo21HtrD4U4eHV8dajU7sS84GKkxOMR3RtKxLopOHKsK0VaGo0/T
	xkRCZmk5FVV3gZsb9717Vq81s5MvHrUOJKI49A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759945155; x=
	1760031555; bh=qx4LuZT3E2iliDyhylYf8LZ61tAJ1iP2XlnHp3YH9os=; b=n
	1uHavPIHktSOFl0eC1zz6AuDR/a2ZOW0tFOJsDMAz3rKthzX/q4AxdKwcKN/KRkN
	kPplamh77kJbYxcAmYlwy6edKVBzczcN0H/TzMGfUREcQS3KobolsQMhvA5qg1pQ
	zSsmQsHzQ7CnAc9dA2hK3ufyrnhPQAayzOSS3asKj8Iy0xX5FCIlqWMTvl12il4Z
	I3R/Eqt3O0afWTRVb9dZnNKkKXR1f1LYCxEM33sIedEpuVPGoqy7XxAw1j+aLvJh
	h/AQtsJJ4GdMB45JyX1NnqGHiRwcZbWhowR2y5iNpLknDzF5J8rIeB3UHeklvbMk
	ridtvAicSe9Qbxn71MsTQ==
X-ME-Sender: <xms:w6HmaOgP0RzasEhOHa_ei4kWYEit_PA1cCZZED7XD0BEN63zyeQebg>
    <xme:w6HmaFDVwcsOLGHqeKLOkJ0IGsKWkg_9U6Y9yDVNR5KSaa5bd44IeqKx1FCJLp4vt
    VwXTp2SbzK0vA9CyDxX9CIvrjgU6Vpl1v0qFgFKyPNI3vgAav5Csg>
X-ME-Received: <xmr:w6HmaDupNiGReJLmmE4iHGdbf1RMpMGnvKY3Lh6NXDE1N48ISfGTQ8omjGD_DeB0SAxwjQ6Relxg9aacchtdawmM8D8pG8-OrbIy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepledvfedtfedtkeefueevlefgleetieeuff
    ffkefhgfekveehkefhgfetjefhffegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:w6HmaCZZj5QY7rWnyUXNBXB042AY_h54pqKOWiPFbrqwQ85BQ2712g>
    <xmx:w6HmaOWW7xclbpIpMqZHCws6WE0u9g47B6jv_lhVTV1qyqrl7Z8Bdg>
    <xmx:w6HmaO7oSMGkedRaJdiG6wbHwRzA1WxKrKsF5zmaJp0_CBa439668A>
    <xmx:w6HmaBi0TchZKui8JVCj1yZ0Y8DrYUHS4lO4UwCL361bv7lLrmKXgQ>
    <xmx:w6HmaB4ytEosjliRhYfOCFUaUWXy9Kqvct7NCLXfyPLfuctHNvgwInGY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 13:39:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [rfd] a new core.whitespace class "\No newline at end of file"
Date: Wed, 08 Oct 2025 10:39:13 -0700
Message-ID: <xmqqjz15fg3i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

It would be a good sized internship project to introduce a new
core.whitespace class that is about a file that ends in an
incomplete line (it would be way too big as a microproject, so I would
not add the #leftoverbits tag to this one).

The student needs to learn quite a lot of things, including

 - they need to study the diff machinery to learn how existing
   whitespace breakages are reported, in order to figure out how to
   add a new class of whitespace breakage;

 - they need to find a good name for this new class;

 - they need to study the apply machinery to learn how existing
   whitespace breakages are reported or corrected, in order to
   figure out how to add support for this new class.

Thoughts?
