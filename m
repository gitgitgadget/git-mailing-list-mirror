Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00997173
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753976891; cv=none; b=aDO9OACU24Z5bDuLPhjcTT/H2uH4Y1BOlNoTouNP2n9Nq5DFXNEkDxlo2FLRKv/xHNy21HbByLpe+iccx7cbTuK2n7X2lAumvWY7hxn77OLGZvJbVu+oEq2vheQyXjF2OaZvKjrK+PjpuljYB2cMCqFQAsWFKbaSlrQEhkFd06s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753976891; c=relaxed/simple;
	bh=8Ko7DJ9/EqNWx8BL4m0TbwJepF1r7iv+b18wuZfv0Og=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dYLgeEocscoz7VHmjRm9QnI25XBTWVsNrVYmNCMfL1eV7tW65gy2vicZqkJSN4GSPk4aaOrHM78WRit/9VqA8a1wt0G/dJIbelxa2Yb4WjMhSRHJsPZUUPNwYwPpXo7h2mf4wSDS3ZQJP7bfUsBetpYN+VCejUlrCpkOPWDqH8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=T/uPWObZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W5Q6b3q7; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="T/uPWObZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W5Q6b3q7"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EB3567A23AE;
	Thu, 31 Jul 2025 11:48:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 31 Jul 2025 11:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753976887; x=1754063287; bh=/VUKOW3P//
	mPIVuIeorT8X7x4ifEvu+BqIxP5628F0I=; b=T/uPWObZAIuryihW6C6p56sgGu
	FkilBwQskOfBNaxaZWX/TadBQSQTysJ5rPpLCmu3d3LKmgJE3xbkVpjIhqqInNiB
	1bBJDSd5Vlb+3tO5PtnHQgAvVBlwJV1K51/shFT4KAf6emONIsSgTJBOYaiEbcSP
	22o508kfTpzrD4WhJOdB7TcAfKenIn8o2cQhtll17UsbtESic4ZvhPAP9o7Hp47S
	YbCwPoh+OrP4yBgn0xJz6os7mq4fX4jmTR8K2IHgxbKA1cvTOjQiykVJ45ukFE29
	j4/Q+zDDuWs5P92ZNkiofXw0nA7OCVuWZOS81O0CRTDNYOAT1qpd0ALmT3Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753976887; x=1754063287; bh=/VUKOW3P//mPIVuIeorT8X7x4ifEvu+BqIx
	P5628F0I=; b=W5Q6b3q7ieXTEGIMbKk6sASKwe+0xqe1cNd4g2xLXj0IOr+cP7B
	SH0MzSgqFgCbSE6gsJ19tCatiLblOb/6eb0vkASYVQ7kNVhGLmiZ9mair+lmmDZc
	k8KBMqualohs9DJ6HERy49gY1tfl323CO0k5Q7WrqJgvyeQGUaq8CsYYAc5pUw0R
	l+sPGZzw2UIwaRMHqH9NMkiRO0PKDdt7yBpMzU+PpMMdL9kCA7BU903BAHTy7l4Z
	6Fg8s4HljflQw9ITx3Q51icQIogjJ1Pftkk3E19AblAU8PYWghEEmDfFPSv82Ytf
	2xJa1RaZQput6l9Ib8CzS5+sRgACQMgQrJg==
X-ME-Sender: <xms:N5CLaCvNB9TbOM2ofGXPLIPEDU8kR_5irgUWb5llVOZu7UUN5kCx7Q>
    <xme:N5CLaEa710o9bAPF0CRYZllcBR-1xxke4JP35FtYUCU8BH1eJkGtCt6wePNBl3Zkl
    jaICXne1y174tlIkw>
X-ME-Received: <xmr:N5CLaJa-jH1I8nf8lNAi_JuiPa-tILCH57T1y2jRYXuZ7dx9A82Mdn9Z97se4G1UTR1-KbqM1p4IxeMeZKRx_GdvAIhwtCnL3iheBE8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdduvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvh
    hilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:N5CLaFl4rtZVnT44UvuBzORKnJGMajL2q_FLCN4KPzOqXVQGpe1qnQ>
    <xmx:N5CLaM0xLSlf6KEzoU86QB_VmlGYP0dBPW-JTYfWuNpnfmbkUoCJTQ>
    <xmx:N5CLaN2yu1SUFGCYj0GU8O5WGquJtUn3bhWyLlnyXIS-ol_ghDJqIQ>
    <xmx:N5CLaGqWDXOSc8rCjuj01rLSAV-f8y7kjid2WgHVWLVrXSu9rt-faA>
    <xmx:N5CLaH6xznwv5mfJ-ErDLo8t5KFovef6o2bKxcYdo1PySmbY9PJ2_amu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 11:48:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Karthik Nayak <karthik.188@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Jean-Noel Avila <jn.avila@free.fr>
Subject: Re: [PATCH v7 0/5] Make the "promisor-remote" capability support
 more fields
In-Reply-To: <20250731072401.3817074-1-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 31 Jul 2025 09:23:52 +0200")
References: <20250721141056.2283349-1-christian.couder@gmail.com>
	<20250731072401.3817074-1-christian.couder@gmail.com>
Date: Thu, 31 Jul 2025 08:48:05 -0700
Message-ID: <xmqqbjp0tl8q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Here are the changes compared to v6:

All looked sensible.  Especially ...

>     -+  struct strbuf **elems = strbuf_split(remote_info, ',');
>     ++  struct string_list elem_list = STRING_LIST_INIT_NODUP;
>     ++  struct string_list_item *item;
>      +
>     -+  for (size_t i = 0; elems[i]; i++) {
>     -+          char *elem = elems[i]->buf;
>     ++  string_list_split_in_place(&elem_list, remote_info->buf, ",", -1);

... because of this change, we do not have to do ...

>     -+          strbuf_strip_suffix(elems[i], ",");

... this, which is very nice.  Unlike string_list_split_in_place()
that can take multiple delimiter bytes, strbuf_split() can take only
a single byte as the delimiter, so leaving it at the end of each
split pieces does not make much sense (at least, that is done not
because we do not want to lose information), and having to strip the
suffix after splitting always felt like papering over a wrong
behaviour of the helper function.

