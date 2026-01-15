Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE63D3C1FC7
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498392; cv=none; b=JDO3Y4ULE8Goa8goGoaZVVR8nWtE9wP5TbIAWDsu3BmklRbmPL+SHKlnusOWCgjC0cKdgSMQUhXf9JO3HZxpF0MYhweRQah7ii70hh+VbVxV8NDTvAINeZpuPoPkVu2ZsHevBxFYL8/wknLHRol8AP5Qxw9eItMNz6SVW4xNgj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498392; c=relaxed/simple;
	bh=VDP3OTqO9LigAfbyD6PCrN+Lrl6EUpY3Pam+CFlplUg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SZQI4BGXnxRowmqYQo9pKKlfk3wW+O25M88IV9WbpXD6DpPvtobjzQZ9C2v7WDfVBLM3sYlsjK/DgYEbiLZDZscPBwklMDVHLzPZ7RdBf0+o97S6/lRxHoiYRVcu8oYkSNPXVQKwcfZgPML4nCLEQfkRx4vxuIbI6BD2iL/zygM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=i9SkyT0Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m/JxgasG; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="i9SkyT0Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m/JxgasG"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0777A7A0092;
	Thu, 15 Jan 2026 12:33:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 15 Jan 2026 12:33:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768498389; x=1768584789; bh=GlY2GKHO9M
	CjEEhutSjo5sdCU2RnZMnR+65gSRWIbSk=; b=i9SkyT0YL4LyfR/CrdX9xVvptt
	5Dv6YrKJ7j0GzMyq+NKL3xQVGcpRJirGx7eiwzojnpPQKm/jx//58Y/Jn5OGwHII
	RszWN0FQ05oST4EK2F8XzHYswbZQSEMTJY4gnKPVONHa/UousGTSMX2WvH0MNptF
	WiH+phC+GTHQQYuAWU14hL0mOFtVvPNLeCF1Ge2J0r0q/rJm6GdkAUdZWsAKRG9z
	QaFUicS6OIYDy511S8SzNgOakoLU36iwteD5a1xYpxG7x8J1HZXXhSsGrf7ygTJ+
	YPoBMf4YjqQz3m2UbQYwjQ1hmwAWO2dz0q5F21md0zsz6U4kfUyINctSgF4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768498389; x=1768584789; bh=GlY2GKHO9MCjEEhutSjo5sdCU2RnZMnR+65
	gSRWIbSk=; b=m/JxgasG/Nq1dYry/d9Q0d19qF3XLUxTA0bsX3rEsn6gIavHHXR
	DQ56BYoJiRaVDSIO8GzVRnpkXYZZZhhy6aJQ5Ag7ScNrcqWokAYR31UuURa4tHwc
	JoEQkVz1jmFkdKLxqzCemwNz9+eY5n5Wzc4x6l2OUh7E9iXXW7Ldz77Vo3GRFKHZ
	8yATpW1RiMGIavKxy+YEKGzSEd2/JDRu7jRs/tB2vhESNeTlmbjI9+KhXNOJIHzO
	WXQmIxatWKvhmn/innFxsYmY2yd/S3Se5QVu8RWvim6llr2GRCWqCmQzt5any/XU
	LZFDfR7S+BGc0opx+wcsmHXcJ78P4Wbjnzg==
X-ME-Sender: <xms:1SRpaU80VBR2t8ku7OAT9ELGzfDfCiWcC2dmFePKePvZIq9K7gW1bw>
    <xme:1SRpabw6FpgCazuc8DUyF1R0h6h0Ju-0WbFrLj_T1lPmghHUiD_P7jZXQQwBj9v4l
    zys20NpvH62Ydcie-mAx1Rir10KbE9r5ACSHt4_v1NN9Vf5ofbXcg>
X-ME-Received: <xmr:1SRpaQOoGHvqCWGukPME8ZqNTboj9VCu_oIYKlnxTdNxPf8FPoPYpwhNKiJZJyQtalvhVzglHLENa3AY6oS_kK8yvKjmX4mCg5u_gwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeiieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggr
    khhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtoheptghhrhhishgusegrphgrtghhvgdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1SRpaQ9ZH4JZAzJ0HBSe3-_Iuh_1fNzW-QkJoEfKOkdsUWDhjeHZbg>
    <xmx:1SRpad7zbtU50SfywhxIOCz6QgtJgQh51JUZ8WK7jrOLRz_gMJlkwA>
    <xmx:1SRpaW5Ht8SJ2RMX2YlQn1UFudTCmoMvuFJmodgKhulsSGlXeNTHqQ>
    <xmx:1SRpaWqOYSzjWMoWMnJUP-0_TDg_TMhxnr5pkw-2qsgeRm6_I8Gddw>
    <xmx:1SRpacIewgvjo10UE-jhrC51i8NM_JDJMwIzvlpflxmzau2qvMrBoJQ->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 12:33:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Emily Shaffer
 <emilyshaffer@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Jeff King <peff@peff.net>,  Chris
 Darroch <chrisd@apache.org>
Subject: Re: [PATCH v3 0/2] Fix two hook conversion regressions
In-Reply-To: <87o6mulrnq.fsf@collabora.com> (Adrian Ratiu's message of "Thu,
	15 Jan 2026 19:19:53 +0200")
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
	<20260114185731.2381550-1-adrian.ratiu@collabora.com>
	<xmqqpl7bc68b.fsf@gitster.g> <87o6mulrnq.fsf@collabora.com>
Date: Thu, 15 Jan 2026 09:33:07 -0800
Message-ID: <xmqq4iomdbn0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> I agree with this.
>
> We can't let these two regressions enter a release, so we have two
> real chices:
>
> 1. Merge both fixes to 1.53 or
> 2. Revert the 'ar/run-command-hook' topic merge.

Hmph, at this early point in the late release cycle before -rc1
(yes, rc0 is scheduled for this morning, but that is not really a
release candidate that counts as anything), it is tempting to take
#2, actually.  I just do not know how much damage such a revert
would cause to the tree.  I'll experiment after I finish cutting the
-rc0 preview release.
