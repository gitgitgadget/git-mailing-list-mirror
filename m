Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951E318A6D4
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691293; cv=none; b=gbJx9ilTa9f23TuWjvmZX3H8sVV7wT3mQJ5V1UX2io4qCoUmg7tm4Ae7aKkwoxxZvihm9Cr54AVXV3lS8IKlhG1ViDG3i8C2C35/bmDC57NPZMnF4qcIvbKIWE1kIjQvs1hWIuj7ww4aOr7DBt6v8axFfJlalXpnazQo5t2sojk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691293; c=relaxed/simple;
	bh=a6QvXcb65eDASKdmoSbtktGDuEM8QyBjkaXAcIXvHF0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qVObdp4vePytMPKZFilvHUvY1EU3+SNow0y4+pRZqqUFKECVcBhgR+II6Gdrm/fyAX5oMt0khda+w+oYZp3VFVlI+PjBA7Q45OAOXdMi4kpM3unTvBC/xogvKPTUUkuWApPtPhr+jp7z+/0hZGgI5EjbnQ6ItKeusf5UIHX58ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=H9tX3s0Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GDxl47e/; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="H9tX3s0Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GDxl47e/"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A5DF32540161;
	Tue,  4 Feb 2025 12:48:10 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 04 Feb 2025 12:48:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738691290; x=1738777690; bh=tiZqVUIZII
	/+0pYdEot6hwM4c3xBAm1DCynGQPALJEA=; b=H9tX3s0ZSX3OAE66Rs/aPjRb4X
	JmVPXy+rOeqFtnwrToR3iulRCzNHmVc5JwAhVUQ47ZwTwigS3jsK3v07nNgqA7K7
	R9DLCQ+JplOy10qozkzIkAi8dXwJc8M/7EtSeCh1g88Up4eC4/jOz6/AEUiXMvRV
	opmih1n2oeCdFUoLIJt/UDp6Lk75ydek5c5+Ykh7OMUwIuknyZzwuuKDThnaampW
	xQdWUpIJdnMYRi5nC6iwwS/LqCgz34Zi/OqbTO8NiPSGKWypt8sndQT/jIra5LBA
	+INo/whB3v039+idAgmY9//5WTP1xn8DdhETA5Tz/XEz8Ol932jvr6MiwD2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738691290; x=1738777690; bh=tiZqVUIZII/+0pYdEot6hwM4c3xBAm1DCyn
	GQPALJEA=; b=GDxl47e/xwqIwh48T0swd4BFnVu+AYOVi8pwNodZQCdE/vG4iLz
	tkF7HojRTq1KHJQBzPisi6PtPc7jwFRec1EGXaWIfpPO78LAfc1Bs40E0CSlQlwj
	ouARe6SzB2tfcXnrCFORDbbidMBA8gRzTlMmqxFlyPreagYkXtvEPWU1VMwcOGcv
	7b7LhBuHlJRcUt1VjjOWzt1mCzanfPs4Ul3+vesWrwRUFKkLgPc7i4tVfrv3RIrl
	Pm09zc3NIZsivv5sxsTBCvYrsSNdHwRQu2pbPaJfkn3uHp2v0d+lWT8XQq/xuQZD
	ASlOUXtwQ1eXUqW8m2J2w9p5u8DIpf1bMZw==
X-ME-Sender: <xms:2lKiZ7DY-gg48tGu0xmFQie2NQYcf4NVsrdcgkFIrNa11ijcNxF7_g>
    <xme:2lKiZxh_stvDbWucqL0D6RqnlMzULD6a5_r-uzMbLC4fzbC8spg0nIHhcdoTlTzDJ
    F1ZzdrwiEduNUu-9Q>
X-ME-Received: <xmr:2lKiZ2kFsNqbPjTsw0ogSljlQpJ70CVgRfS263ndcf2Y11VgTcj4Q5fQXSz2STCU0CALOfxs2r7cDBfqP-_ervTcTyuXvBx8p9_R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2lKiZ9wPfpEhQpwOGK5e4lyZzblchHCw-sWJgqVT5H0MurD_kPbv1g>
    <xmx:2lKiZwQtANgTpYS86H79Hi4Bc2E_kqsOIz4SGucPvU4-5Gk61z9r9A>
    <xmx:2lKiZwZfG5mYkKDlwtYS9H9PTBy7IcCPRxE3uLjjuIEnT0hWJq6Pfw>
    <xmx:2lKiZxRrLAhcysLEH6fJ_XvzBClW7gR6ayTOyZwjYoBecXbPPoWIKw>
    <xmx:2lKiZ2dfEhjbcXKzMyJIfr5Dvd0Q54_Xp3y-rpY-65ajBBVZ6CbKb5m8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 12:48:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #09; Fri, 31)
In-Reply-To: <CAOLa=ZSoiEeJqP8GDdyStOjNaw6itAHjJH=t28jp1tssjAun5Q@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 4 Feb 2025 02:07:58 -0800")
References: <xmqq5xlu4bt6.fsf@gitster.g>
	<CAOLa=ZSoiEeJqP8GDdyStOjNaw6itAHjJH=t28jp1tssjAun5Q@mail.gmail.com>
Date: Tue, 04 Feb 2025 09:48:08 -0800
Message-ID: <xmqqo6zhtxd3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
> [snip]
>
>> * kn/reflog-migration-fix (2025-01-15) 1 commit
> ...
> So all in all, this can be moved from 'on hold'.

This was on hold until the kn/reflog-migration-fix-fix topic
you did around "max_index" on top of this solidified.  That
other topic needed to be in 'master' if this were to be, and
I think we already have them in 'master' as of the seventh batch.

Thanks.
