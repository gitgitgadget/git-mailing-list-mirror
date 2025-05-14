Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944E6276038
	for <git@vger.kernel.org>; Wed, 14 May 2025 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747226942; cv=none; b=P7Ajtfw7Aq7IEyux9Ou8Xy75G1g3znscw0De5xcbi7qiPGVCUOPN5dMcHPSqrP/FuoryrGq9XFo5tuRjfihSRpO3tS9e/m1A4AR1iQYUUpU5kcRzNd4whXNINxU47ITo5uzvluB0XYeW2J2vFN4P09n+8GIk/HCEDRgXbX0yD24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747226942; c=relaxed/simple;
	bh=ZCTymuapyT+vrI8C9CcU2eEiR6JXrsl4y/kwDPHAou8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rXJZZ30qWyQpX1h/El0futEpBY5TBk5fW7wVv99qYc6dtbAgHQNtwJVqugyuuJex+qPkXYFXyLS8FvL6mKf0wm1IyAcy/24Unki5JRgxxHILWi38yjJVL/cH+CV/kND8GZ27KGBqfY9GVW/g3kSKmKL7qLBn3xlJVDSxdX5avoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TL+VCCFS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OXbypy2q; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TL+VCCFS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OXbypy2q"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 90D391380460;
	Wed, 14 May 2025 08:48:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 14 May 2025 08:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747226938; x=1747313338; bh=fTZVR07NJb
	9lAi0CVh1tT/MLg9Z7xe+QqLTI1J61aTo=; b=TL+VCCFSdUz6RReU6d5e6g2gAu
	I5mXUGnTgJsAQxhUmzcuP4JUIRJauFB7XkwjCP9+kPCQmJHYCcWMa1JAx5fIa2KP
	N7q/hRt88AqJLJsLiQaWY/lAUXTF7/7NQ7IvplHYP8a+HVk0nS63PqymJYhlYklQ
	qprZK9H31WN4Ak/880jj28oyLcBP/4/otUoCmo5wDXbtXLAhc7URJPI+BVmWRS54
	kOcjGHSbDGnPUpeC1bHTPQvhOCRWIk9/ZN0336+Z5a38jaSm27nxGrtlWYFsb2wz
	H2TuSBoB1bd7/np4wNc5SSdpk0dfj95u7tYs+uUn/sypcK6X/YuqmxgrJEUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747226938; x=1747313338; bh=fTZVR07NJb9lAi0CVh1tT/MLg9Z7xe+QqLT
	I1J61aTo=; b=OXbypy2qMm9yXZtcHbq6ZoNh7Cjose6GndOhvnlArUaci+0CIr9
	8BfMez55ctEz8yVhxbPxmeEescc5Kh6mqTftDuDT4dMqG1Zprr2m28g4eDSQVCm4
	UasgfGg9YBQHxYyaOJSySCVUaEjvgvoYjT0KHoAuOOvNXkg6ixFuOQz2xiiwT4gy
	obfgZuHho2eNk3/BGNPGgNt49GtDNbyb0SDkURFSPKYgMRVV+LPB0yGvIbV+fkC4
	gR5gCps6nj2mLgMkNiGN6CZ0vT+PjFfywcA8QpM5o/h2u9X3mSJiQdnm3WXO/c8a
	3bsYH3F1b4f0FQsF0ZFBQ5HeQ18r0R5Hh/w==
X-ME-Sender: <xms:OpEkaDtKBg6Uk74Dc72J7lyLkzn7XS9OxQkew3WisVPyZyRlBdn61w>
    <xme:OpEkaEe5uH8535ODSmh3NIMl67ABx2T9vXnhUPtpeTt8dr8dyxUIC9yJxw7RzkM0t
    QTB7mzYt_Yom74Sow>
X-ME-Received: <xmr:OpEkaGwF8a7LqdnGWsU4eamJyxWwiF2kjKlKO0LGZUMPhrsBU9HDYmdXVIOksivLkTDdBtnZ8nRtddTyMiJ2DAHTPPg06qInOX9M7TY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehjrgihrghthhgvvghrthhhkhhulhhkrghrnhhivddttdehsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OpEkaCPD8fNw4p0T2XZBkHFY2WzV5Xai6Sbssq4SQoPhLK2tJupwUA>
    <xmx:OpEkaD9MyY1kvq_c_oYEXF_lzeqXeNONEb3AIk5vzOyfOeyHYMKgig>
    <xmx:OpEkaCWtMKbWvArXpq6QKv5AvmnysvZPcmNZfBEVoG2xrcbZ499_EQ>
    <xmx:OpEkaEeIAqULDHcNMHu2aIVXpugcvtcrHr7huGtTwv7oa7o71VB_XQ>
    <xmx:OpEkaMLjhuLOuj80mQZ7-ch30t0rrNHMxHZ0gWJp4m8OO8Pu20FZfmcH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 08:48:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] update MyFirstContribution with current code base
In-Reply-To: <CA+rGoLfbshrkPvvQorMq4n1RkVnyL8XfJ9UjMFRA-6dG4QKdcw@mail.gmail.com>
	(JAYATHEERTH K.'s message of "Wed, 16 Apr 2025 20:08:24 +0530")
References: <20250416061450.25695-1-jayatheerthkulkarni2005@gmail.com>
	<xmqqr01si441.fsf@gitster.g>
	<CA+rGoLfbshrkPvvQorMq4n1RkVnyL8XfJ9UjMFRA-6dG4QKdcw@mail.gmail.com>
Date: Wed, 14 May 2025 05:48:56 -0700
Message-ID: <xmqqtt5ncq87.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:

> git shortlog --no-merges --since=6.years -- Documentation/MyFirstContributi
> on.adoc

That would not work; due to mass rename, you'd need

  $ git shortlog --no-merges -- Documentation/MyFirstContribution.{adoc,txt}

or perhaps

  $ git log --no-merges --follow Documentation/MyFirstContribution.adoc |
    git shortlog

or something like that.

