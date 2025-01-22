Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647DC8F7D
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 21:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737581523; cv=none; b=O444O2PDYuatopJcf6iPTg5MIEFUZfhLlx605nP2TYyXPgAaBJ9uJ8hevbIHwQIWWzNrCeYb7JBBHhLXAue8TpX4MV1bMUPOY/pjPxyqxJH1Bos51c+qcJImAC8G2Cm8vJ51HbAkvkrJxmohT4KHw1KgfJy4cOkBhnH10oXe9Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737581523; c=relaxed/simple;
	bh=Mrd031jjFzSb55VOwt6YhtbheCpj1wwe1HQTaFES5vs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hpl4Igyt0Ft68xAkyJA23vh+xgsEoF1YSZDtHcP0phdUxttULeZqDDvS7E543k834Ceu0jyz/Qpn3ZCDxTgtAldnjX+aMPlclzgl1SBJOnRd+VNuLmusUtoN369w4Oxjz5vYTf9jNEIPsgv2k4+ylTgGkmbHEArFf/UQDgYMhew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZwLqpyTV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HN/fkLBb; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZwLqpyTV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HN/fkLBb"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5ABE513802B8;
	Wed, 22 Jan 2025 16:32:00 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 22 Jan 2025 16:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737581520; x=1737667920; bh=PRbU0wXMf8
	s9TBanboLaxK9GZwVl+y0mvsrddbxPtLg=; b=ZwLqpyTVY4ZIpETsptJE/y453z
	R1L3LH/9fJV5uFdTaK1+gB8WmtH8Ve4bnhCsrsQ+rIVSpFSBQerAbVep1U9UCrRX
	DQOv8pyfZ4pEWAwip55YjpBmHp4WGEk6Wij3s4FDgwnt24NHPDYxM/RN7xWq/BF3
	JR+cdMLYvqdD5XTzOCqMlOa1NTePi+WEK9IYnEQ6NuQp7DAEIbvJqQ9hGJh1BcpT
	PJfWNML7hifHBaDUAWK36kfedKrW7NinAW57DMtTmpdjmJq47kqoORBqNAnQ8Tzc
	n9Wy/cYOtsWrfNEUkF3s8AdNheH3Co/jYwM0K6qDnDHTHkts6I3JksDjPRxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737581520; x=1737667920; bh=PRbU0wXMf8s9TBanboLaxK9GZwVl+y0mvsr
	ddbxPtLg=; b=HN/fkLBbb03ROvinp6tVNnrU6BuSTIqKPqDORAtq953J9xCpYM7
	U9QlLQn6qDbKRBJdFGvX19DrsY47EpBl33C72NXhCwvgfD0DtsJ9IU+ZHOXHAthW
	wbGkjJlTQ3tAauJ5NEDw7qDiH6i5GxdqiB3ma7B9UhqZpxo+LEaEcK+rHP2jLAm4
	X/XXF1dK4acBrrcI2rs3CEqOR82TILHPWPIJ59bScRUgbiGOr/7iELVwoFQCxUL6
	+4LnwS2X6ghl9unwUltTPXNVElm+sJB1FYiIcEkJquatiH2z50qy67Jn5D0uIfeT
	V6aEZ2xyWOM+pdKc8My+U/1JTKTchW3+5ew==
X-ME-Sender: <xms:0GORZ2Su108JGpMSEBr8PF3U9CNWNohCgc5auXijqkxcjy4IsxVoEw>
    <xme:0GORZ7w0qYm_AqRkaGY1iUwGc3pzOitvCE0nq0N6Evg3SoNvz-9IUsbmyQyIXwqIT
    xJEtPI45fDFI_ftMw>
X-ME-Received: <xmr:0GORZz20HD8ucgc1SF4oJX-Dvdv5b1ctEEUMFC2O-hwb9Z77ck35-q9lprjmpHrR7R66l6wsV9NP2OElB49nWjSrjP-gwvHNQpfG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgvdejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0GORZyD4Rvx_ZwSLFMkcpf0NOvBQraSVb6oDzD8dQObOHuqDraTbQg>
    <xmx:0GORZ_gp6Ob3IqoY93NyRne5PnL1ZMcbK1TJHnBiceANwCUG8sfukg>
    <xmx:0GORZ-pKFSjYFnGFWrlI76Ws1XPfkxxFdN1xQm8-DsmtMNO0wrQCTQ>
    <xmx:0GORZyiztKD15QqAfHodEaiaVZhMhdf5iucfFwNSoRPTaacZ94Nd8w>
    <xmx:0GORZ6V03SVS7NJaSxlmobu15ju3XxzGHx-ZPdW9a5l771xQI7lAdE4W>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 16:31:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 0/8] hash: introduce unsafe_hash_algo(), drop unsafe_
 variants
In-Reply-To: <20250118124343.GA3828177@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 18 Jan 2025 07:43:43 -0500")
References: <cover.1732130001.git.me@ttaylorr.com>
	<cover.1737151386.git.me@ttaylorr.com>
	<20250118122831.GC3510721@coredump.intra.peff.net>
	<20250118124343.GA3828177@coredump.intra.peff.net>
Date: Wed, 22 Jan 2025 13:31:57 -0800
Message-ID: <xmqqwmemv8ky.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> .... But maybe
> returning UNKNOWN (as above) is a safer bet than losing the inverse
> nature of the by_ptr() and by_id() functions, which could otherwise
> cause hard-to-find interactions?

Yeah, that sounds sensible.

>      I think it "works" because the backtrace is:
>
>       [...]
>       #5  0x0000556d436f6b71 in BUG_fl (file=0x556d43790e8b "hash.h", line=324,
>           fmt=0x556d43790e73 "null hash, return is %d") at usage.c:335
>       #6  0x0000556d4357c2f9 in hash_algo_by_ptr (p=0x0) at /home/peff/compile/git/hash.h:324
>       #7  0x0000556d4357c437 in oidclr (oid=0x7ffdf5810ea4, algop=0x0) at /home/peff/compile/git/hash.h:392
>       #8  0x0000556d435801c7 in prep_exclude (dir=0x7ffdf5811190, istate=0x556d608959c0, base=0x556d6089da50 "nums",
>           baselen=0) at dir.c:1699
>       [...]
>       #16 0x0000556d4344dd4a in cmd_grep (argc=0, argv=0x556d60895ee8, prefix=0x0, repo=0x0) at builtin/grep.c:1257
>
>      So we probably write a totally garbage algo field into the
>      object_id, but nobody ever ends up looking at it. Probably
>      something we should clean up, but way out of scope for your series.

Yeah, that looks bad, but I think it is fine to leave it outside the
series to fix that.

>      But I do think it reinforces that returning UNKNOWN is an
>      improvement; it avoids undefined behavior and anybody who tried to
>      use it should get a BUG() from calling git_hash_unknown_*()
>      functions.

Sounds like a sensitive direction to go in.

Thanks.

