Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF67019F46D
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976383; cv=none; b=o3IxrR7SMP2CiHnQzNwMJ7z5QUgiXtDh2+dP9txuQ3urQaXX8bBq8doj7UhQFgfeptN+VRL879UvOjn4vWR9T5cT/LE/ozQoVoXiw9qL5wcE4UD2gFt2yigR4MeMtM64ECCUqw21xJmiXp6Kl6MifqPFsW4wzWae8rvZ9/NvEsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976383; c=relaxed/simple;
	bh=8VRCfc/bGWtj2L0yI3Rm/om8Qhhydd+lT9dqGhXMU20=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qf1QVkaOYYuwyoC/spKlRXIyGrmOxLhdlIZBNSlrAK2PDHbXnAX5GJ1KFYINmf2ESD2F2LZZZUpI5fJBF1jF2x0jANEBNFnGawCpeI2ew4WHYsAi4k71qHGruorznRZpktOGdA3QqnrTaDAwC7SHMUv4p3vGJ/uShrf6jVNv2J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cQesQ2o2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jgBCpnKG; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cQesQ2o2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jgBCpnKG"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0923A1380174;
	Thu,  3 Oct 2024 13:26:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 03 Oct 2024 13:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1727976381; x=1728062781; bh=8VRCfc/bGWtj2L0yI3Rm/om8Qhhydd+l
	T9dqGhXMU20=; b=cQesQ2o2RlHMJIyjy6yvUO0XBDqLAgqaMmKZj8ar/Ajvna33
	bGp0u4eRGBpSq2vDRmN/IBUHZaoQ3bT8IIXQP7PW9k2eDXufzpA06+2XPEyEHnEx
	UajhNX4XexXqrFbjkpPY3NAeFuPpCkdSPl3AAXnObsRhf2GzS/AAD/vlA7KnewlD
	eSClJHOEYjrZ5AQHysQ2Skft6e6mrABWbj4iCSHfh6jEq4k71vA5bcx8+hJo7jfk
	0PhO/ggQA71bX6afwlQZzqhkWT8iXvrPOhToW/ck8hPYf8hmsYv7e/n5EGF8y5L0
	ouNRzliDtp3wzrwsriprnzVXlVi5WiBZmymMdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1727976381; x=1728062781; bh=8VRCfc/bGWtj2L0yI3Rm/om8Qhhydd+lT9d
	qGhXMU20=; b=jgBCpnKG+HBl1DOletyq417mOJSrJJhvMH0AyuNDPRosA7ivKEN
	DTJ4exXbPom2wUjoM6BgEPhdguOkShVV/ENkkcHr/oHf9714x8CtAkrGbjvwsQjj
	gVuYHWaXYPlxFvI/+o0qeSRUgD3Rlxmv7ahmq2cdE5tYtt/ZRbtjeKK3M09hzUdg
	I/POn3xQt3Ry9t76JDSZAIc+r7bu8KvPJImAAeVVzxeo2gBtlGjijjgcTxDGswiK
	2FLK+ll6+ioo9nQ0W8b7JzUHbAGhRfmkaR7bXN/416HAR5bIKeYcBtSkeXW9eewh
	5Rv+zYRVNoJ4607gZ4Rn4fG36mSiC9yhAGA==
X-ME-Sender: <xms:vNP-ZkF2wDlKwVBczqb3tQ1WHaAbL2-_5fsV6WXCP4FVPeFenSj63A>
    <xme:vNP-ZtXbEitL2P-KWdiUMUn57vvrVW8J478g7rkKoESuvpJXLQIvKc2owaLhvkgRu
    kSWcx1p6Sjlchcjiw>
X-ME-Received: <xmr:vNP-ZuJPRZ5L9kWUAZugdrFjFY-PvX0WevjOI0MM132PY8bneQkeMAfrP12R4vj_3LurABTF3m7HATUMLFv0GojXlih2rDdw9R0osdI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    ffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcu
    oehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeelvdeftd
    eftdekfeeuveelgfelteeiueffffekhffgkeevheekhffgteejhfffgeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vNP-ZmF7g46i-h6eyMfDhse_yTzh8PTwaodKEorl_AUGKFP0_usDKA>
    <xmx:vNP-ZqVyhObJ9Coj72jt-uAjC75UgYSoQnAFrKk14cQ_MVGenZGm-Q>
    <xmx:vNP-ZpOqZ2xI_g6Qz1ydXgk8zv7tGvmbgtNsVyrFYRhOdqoAyCHNmA>
    <xmx:vNP-Zh1EhXfwADe4Z2Oj7NBOd8cDiidHiYWl5vNAcvIXtKx4QMctLA>
    <xmx:vdP-ZnhP68N4XInuRtb2g7SRXb-jRwwaJacROYc_yWxRP6jxKJX86wgI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 13:26:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: the latter half of october, the maintainer goes offline
Date: Thu, 03 Oct 2024 10:26:19 -0700
Message-ID: <xmqqh69thzd0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I plan to go offline for the latter half of this month (I may
sporadically pop up but may not be engaging deeply in the
discussions or picking up patches).

This time, can we try a fire drill that I do not nominate or ask
anybody to be an interim maintainer and see how well community
manages the discussion and patch flow during these two weeks?

It can be somebody stepping up and say "ok, I'll self nominate and
run the project as the interim maintainer, just like it was done in
the past years", or "let's do something differently, how about
everybody throws a merge request to this mob repository, use this
(possibly different) review procedure, and give back the tip of
'master' when Junio returns", or "OK, we'll discuss and exchange
patches for these two weeks among ourselves and we can cope without
a central meeting place".

IOW, I am interested to see if the community comes up with a
day-to-day project structure that may be better for the contributors
than what I have dictated in the past during my vacation time.

Thanks.
