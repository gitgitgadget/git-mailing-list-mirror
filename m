Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5161B4F04
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675436; cv=none; b=c0ht074BV5hgEoCUPvRf7UPmT/YGgzUI6hRoNf4WgXmXtwrG9JeRC6g95uQczELJWnZHNjOvy9gGPw9DIMhUXUMbkJTWv/j2at35GxlXHR/Eyimm5pdTI8NAzEesBAmv9RT81xffv3+RRk+A3Hm/9hMZ8H79BhWk06EsZzcuVg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675436; c=relaxed/simple;
	bh=UHTW7hLbCN9KlQFgOvR9TKaI2f/DSAbHVALvX5fQ/pY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AziDXKSxyYWyBqJE5JMJzO0IwdA4sCZYkcZHm++mCgTlvEKuHSCOMQHabiKkcxxzY6WE8Oh5OKV6ReMRtdw9w9Z+Kdn6YdafkUllhVRL9ZIeFeDBFalNOm5S6MIfffafpp+/0mPREm1Ln4G2cUfIakOLd7IoBZxfA4/PZEUNn5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EaLkuEmD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5ufLEPan; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EaLkuEmD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5ufLEPan"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 96E7F13826E8;
	Thu, 27 Feb 2025 11:57:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 27 Feb 2025 11:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740675433; x=1740761833; bh=ZbSdlehstV
	Tp4H9jXdDaTDCsF8/aj4k6y+7ynLtAvvE=; b=EaLkuEmDfJV9VJ/Oh2wAgZMc5j
	q2l94ap/Uca5mq/bHv565RHFvjifsuUpvQuHdbLblqA+gfz2csTSYrtcoTKrL7UT
	0jSA04yE7hxze5kgsaZce3AoO9iSbzRdyzu44EJ630IUCeoV/Hl8PhtsZx1CixkW
	6We7sdmOYNnidLhXLcEJ3UHlHmHsn51zLHzAmfCdP5IMhtVyp7c+BmO0wBkRtgW1
	h4GxI+RIkpCGZz5lZBjjla2EpkTzylv8CHWx9mUhKvnXnx8KvYtrQlveWZ+SCbnL
	+1GTT8oKha7ZIfq8+4wsyuurWUhRMliBezkdes0LE3ikxf1ch/T5uiQmq9cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740675433; x=1740761833; bh=ZbSdlehstVTp4H9jXdDaTDCsF8/aj4k6y+7
	ynLtAvvE=; b=5ufLEPanDZnLhphaxyjVG5YnNvW04I13aYtaM7r4d0uOORHfDh8
	6z/eNfZOwdz7SfkZlavUpsQJQew1/ezsUncTfBnBviclWIFHLAjt8ZzyeQSs+AW0
	h1OppYRT/r2xX2SertgPTwsrf5oE5YTesdt2rHcVcZsHtS9sINa/2z3QMHpeLekb
	C6R11lZ+r31ZryqrQYX3KTG9CHaz1Qi2ZR80FF3rTMFODjwDUwhFouWE2w+drYog
	VWrGGJp96X96Un+0TWUXZxeeVaCyAdnRmP2VZcuihqzC7kkxjsfJEo+g2ef/+8Iy
	E2Rlgqo7u3ONjjYIERvYgwC5S8eaFrdhZOQ==
X-ME-Sender: <xms:aZnAZ5Gi44REsQwEuAOXtSzBF6QyM0SbIkn8yoib1G-FrELs0fwcmg>
    <xme:aZnAZ-WZnPyjsIb7No9xKLBa8hlsR1LOiqs6WhkFoM-SyZg_YCVUMJGmH84oILKjq
    H-VxPs5gYdfzbw17w>
X-ME-Received: <xmr:aZnAZ7Kcba1Jtnd-uzwRiGcTKpbOeQuFGxreWU_M3krj47IgtXmhbScQjJPIhhpOEnLgdNNpLFj58-DM6boz1YOi1abgEOxtSIWx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluh
    hosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmhhgrghhgvghrsegrlhhumhdr
    mhhithdrvgguuhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:aZnAZ_EPb2cDK7MkEWc-xBXp_aleBDUpPsM4GaJz_5xY3TMJW8kReg>
    <xmx:aZnAZ_UTDL-ALMW9s23cPa4GqRFbWrHZwpDTqLJ3q7n1SGuKwBzwAg>
    <xmx:aZnAZ6M51Y5kk1s3S92Q3IW81fOA6iHUWTAh3qcfEAr5QXYZlI8bow>
    <xmx:aZnAZ-2Nc1GFmFzwARYOmqI51ckhHZMesK-yAhof61eW0cNXEmdqfg>
    <xmx:aZnAZxLOMjrjAVBKh_F104svaOYtv3nCkbFOOxkHb4qsQK7JLpkdJAbX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 11:57:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v7 3/9] packed-backend: check whether the "packed-refs"
 is regular file
In-Reply-To: <Z7-4XRCVvLjFCFR8@ArchLinux> (shejialuo@gmail.com's message of
	"Thu, 27 Feb 2025 08:57:01 +0800")
References: <Z78bmBSrDR20GY6g@ArchLinux> <Z78cAU69IUSDgpuD@ArchLinux>
	<xmqq5xkwd042.fsf@gitster.g> <Z7-4XRCVvLjFCFR8@ArchLinux>
Date: Thu, 27 Feb 2025 08:57:11 -0800
Message-ID: <xmqqeczj9vh4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> You are right. Actually, I just want to avoid assigning the `fd` to -1.

Why not?

Between leaving it uninitialized and explicitly initializing it to
signal that it is invalid, the only difference is that you can
programmatically check if fd is invalid and refrain from calling
close(fd), for example, with the latter, while with the former you
cannot.

> However, I didn't realize that I would initialize the strbuf later.
> After waking up, I have suddenly realized this problem.

Given that initialized-but-never-used strbuf does not hold any
acquired resources, the current code at the end of the series is
still OK.  So there is technically nothing to fix.  I'll take a
reroll if you later send one, but as I said, I do not think it is
necessary to reroll only to add fd=-1 initialization.
