Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4A0314B66
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775681671; cv=none; b=prCf1B3+iYmENQjrMGz3ESFHIxvscS9JX0b6E3u1WXUmWXkZRO3UrQcaKVZFg8PwjEOGH/CT0GblcTgwO0S7GnxTkEp6aZtVPUfkmuw1SHr3Mp4j8pGlhhBV9ytj/KXXOoE6dkOP82lEEdcr6o9QkbuV2MuPbpfp3c2BUUHMaM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775681671; c=relaxed/simple;
	bh=tkczZAk5otQ0ura//tkQ8mLClrAwlDpVsuWe2Gzk9DQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SVfibHSx9ar8n9ivqCJbaKPqHB7QYJMn6zRJ8Z2B57Fgjx3CrOEL6rM36wthSkz6lUV+K0OljTLC475y2CHhc8EF6g9xhjzu1QsMM0CKGHHkTzfh8zFiCY20GO5frn9XKR6XYuS1/0lNsmTq87q3q4nLahI3MM+jIy/tPUjovMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XyBb82Ip; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dCPZseBX; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XyBb82Ip";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dCPZseBX"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B7F74EC0190;
	Wed,  8 Apr 2026 16:54:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 08 Apr 2026 16:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775681668; x=1775768068; bh=NX1RRxMR/u
	9FNqSwc42FnTHIR41MrlxM89C1CNpzaI4=; b=XyBb82IpQLnHzwy0pZQIB3NBtw
	P+KW7UGz1Uni2B6Y+rF10BlKYyPAryeW2J9MdSIweZ9nX/s7+AZRxwkvHSNZ2vri
	S2U5dWNUbQkezIIW10/ymC03i4/UgmIRRR/wvP6VUl22Z95rUAoXGPcCJTQv0K/J
	VC4SprGiVQWGTBCbdgBRfOYRjO6IO01KqgiRpK4LfmBjBROGar1IWZq7MEC6s4DI
	1uVPkf6ukOrZ6C5XOSyBy5Mi3+/56zhfviRsXQtStWlLcICQAG5hiRG6Trt8vFFe
	OwqL67m+4elC86fLERbHLAtlIBjbTgLgs0ywc3LTyWo5pze6FJrYImKJdyVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775681668; x=1775768068; bh=NX1RRxMR/u9FNqSwc42FnTHIR41MrlxM89C
	1CNpzaI4=; b=dCPZseBXlZDP+TFV/x8k9K6G5nWK+j09BeHoTZHImdixfba+VUp
	Lxc0WpxkCnm4h4kmZWFGJ9hc4t8rycnzpcOnqQgleIfttCTe24XuVhNrqE9S3Pr8
	eY3ku7+3G5icDmHkP0LzbiWIcFW8nW5mJNSaQDXcVMqreofJ0jkpGcwuJAyljqCi
	9HqFclIs57jrAkzEQH3isngpsLRuYm+1l/km0W2ni4IAHZvDZPZcwikJ+xIVyuf+
	D571u1YX0E6L1HQVhHI+k7zJuNWUeKhyEy6zseGM6uO//QsfytCtNu3NOtpz5IOC
	I34mY4wHdFLXgc8a2q0iwBArgOEBYlBUodw==
X-ME-Sender: <xms:hMDWaQ6ld1jhxYkB7eYw6ChpnSgtKsfv3DaSc7ZjW4-XpHvebd0ueQ>
    <xme:hMDWaYzBUJHSp89QOn4Uk0djbjms4QT_jjqnMGcRF-P8oRkUrTMdH9_qn4-wXJyhJ
    2on61moWTGoa_wib-5WYiQwQil3HD6QQZL-SLphVzwySzmpeRFXrA>
X-ME-Received: <xmr:hMDWaXzDaOW7zGKRRl9pQkdloD4KCLsu08ElWAe6hvR9stQ6ZCp4dPhS5SsTuuI3HkWyQ5HLPcp3ucoLEjcXrbifcudRwaGImg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgeehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprg
    gurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtoheprhhs
    sggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:hMDWaQzOLRFt7Gq8zGEQfnKudOwHDfTSj42lZdyTb2wZka8ovDOcsw>
    <xmx:hMDWaRZAxQc2tjP_oSGyFAQCeugHfcn1olLz1ixvklaZ8BGSCSk3Xg>
    <xmx:hMDWaRVn1LJ26Kx16sgUtixjY6cej-AF-0PkqpmBpRYZRYyaSTbnEQ>
    <xmx:hMDWafgJoozmlXtvt6LGyp1D9y44b7eJ07ennNXElcHVOOLGMEeO6Q>
    <xmx:hMDWaeHY0qd7Nq08VZgkfvWMjy_15l_S1QKcizEtowXsYjQSVoy8o-AD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 16:54:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,  rsbecker@nexbridge.com,
  git@vger.kernel.org
Subject: Re: [PATCH] run_processes_parallel(): fix order of sigpipe handling
In-Reply-To: <xmqqcy09z62e.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	08 Apr 2026 10:59:37 -0700")
References: <00f501dcc6e7$8ef295c0$acd7c140$@nexbridge.com>
	<20260408052031.GB1324339@coredump.intra.peff.net>
	<xmqqpl491mfd.fsf@gitster.g> <87y0ix1kq4.fsf@collabora.com>
	<20260408172055.GA2293804@coredump.intra.peff.net>
	<xmqqcy09z62e.fsf@gitster.g>
Date: Wed, 08 Apr 2026 13:54:26 -0700
Message-ID: <xmqqmrzdxjel.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
>> Signed-off-by: Jeff King <peff@peff.net>
>
> Thanks, all of you, for addressing the issue so quickly.
>
> Applied.

We have a few places where we sigchain_push(SIGPIPE, SIG_IGN) then
run start_command().  One is in upload-pack.c where we spawn
"rev-list" for reachability check, and the other is in fetch-pack.c
where we spawn unpack-objects/index-pack.

Currently neither subprocess is marked with the clean-on-exit bit.
but if somebody is careless and flips the bit for these
subprocesses, start_command() will call mark_child_for_cleanup() and
causes sigchain_push_common() to set up cleanup_children_on_signal()
to be called, which would lead to a very similar bug.

I wonder if swapping the order of start_command() and sigchain_push()
in these two code paths have downsides, or is it making the code worse
just to futureproof it against a future that is unlikely to come?

