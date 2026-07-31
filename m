Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFF8331A76
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 12:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785501232; cv=none; b=sFpZvQdq72BZfGplJN0qypVrTGStwcBd/alBrpty8Rk6gtT42hk6WUbrQduylwQ4+f3cw6H4FWDgcJrIYN4Tz0Rz0lcEY8w4S2HpwJqMMMdnbjfwqeXt40BR7lE41t/vxFcahMYhNYHcbqqojMOtGwiHbxxSUpkDD5bCKDSEPm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785501232; c=relaxed/simple;
	bh=kpDDuKFfWWwSHY3/w9ldwQuhjOBOpmEyyBkmR0kDIu4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=goCakeAkL0EcGkhRcp9dLFw8MJsB3hvske1MOfO+Cj7qxcpIx6+vF2RwEBZqYuxnO/xIJ9KwiyJHFV3tqUwNfJGYOkMZomjMD2vcbQbQQ2p2RWoPVk2XkBCQ1WGwm5s0F2l3kqcV9pV6tws42tPrPylsTMXkntAm8TLGOwZ8JHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ikj9025e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ThjbAlaQ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ikj9025e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ThjbAlaQ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E7A39EC006D;
	Fri, 31 Jul 2026 08:33:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 31 Jul 2026 08:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785501229; x=1785587629; bh=BfES9Qu2rQ
	1vUd7uzKqChLdLy/u6ulM9gthP1gmq6do=; b=ikj9025eLPPRAzCrkxAiIl7xQE
	2L42oGMb38cBT+hf1mf6XW6ACHiJAWFtA8BiGY0K6fqsh4U4tQE074RagzZCDNKj
	BcZY52l5ZeV70Nd7zS85d7K77kcLd5iqRypmUFtbBmmQ9fHu1FSKihdCT5pShfPW
	SO3XuzCgX9RXMafJPHhSxa9hh2GaCzUPeaW9QytSerySF1GGnwuGXYofn6QmDUbK
	HJjPCCzKUMb2m6T4tAULABbzjWtxHBE13AU50hapYXsnKe9uAPLcRb2N0ypyM6kV
	luQ9neyR9YAw0b0CnsIX19IPdjvcxh922b4ghZMVulq4lzdfal6YV8vJuHZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785501229; x=1785587629; bh=BfES9Qu2rQ1vUd7uzKqChLdLy/u6ulM9gth
	P1gmq6do=; b=ThjbAlaQTXScqeBdcjEjV/md2Gak9GlbXfgQpvFjE47FqLBP3UP
	xdPvKEPmlS0dpZLf9DTZnnXwFRnUneKa7c81bZrRgIbgsOUpJtEz/ulUgQEdUkbK
	rX+SINq7Z68wycnC2HF5Fvexbp3epuHYubbzvvvGKgbBEj5iNFZ0xwengw6dlRoh
	zPoSpuWY++81pmHVGvWsnirBbUsko58GFqfZS28SvBA/thEHDU+sQ1bwgbwUTtFh
	IGYXCkYXNoCH7JEH5bZWUI5AcnYq2iPda463DAe/7DeExCbGHzQMWdFdukOUi6sy
	03C1446YuOUVQJfp0n9mvyN9kbIF10zqjBw==
X-ME-Sender: <xms:LZZsatj1PmZ89p5kTZEZQPszXT9SYzQM3rJUX34qkYKzcKnjjnzNVw>
    <xme:LZZsape0oL6Wn7xLdbNOa-YmLcc_nH1xbzGavwMW1lmrLeW3PsGLbKqJe7VgMVTG2
    09c8GYgvqh6J7ZmyNBErI67IrkupkIsGamFnn48mukdxVNdKEQ0Ow>
X-ME-Received: <xmr:LZZsaqeWXi7KpOI0rhYYv1O19yAUNMhN3KOCeTeo6N9KhT8NLT_JUc1vG5V4VmBPen9P_i33InCFZ4ZrEEHH7WmtHo1-v6aOkA>
X-ME-Proxy-Cause: dmFkZTERsDiAOW8GcvJzOGsolNaUARI2R/JiKlF6BsBiwpyKId5tTwlwVTCJOUXIn5yCOB
    5UYcRDhsF/POE5uFxio3QHzbQ0ZaoxR2HoWKcALZsNdhp6k9dFaoorc49Qoky3WRXYMKgX
    RIuMVEI7qjePwePVwtvE6gk5nrtMB4jlForgjaCFrzaByoQc6dRs9vEDHmjZHlNcdfCmBq
    jWcqIL105AU+Ml31xjoT21R9Xn6eJ9WKrTEpsZQvaSD6XC+sHHZx9c4cdn0wTxWlXFGGOz
    rwHO8ODF098IdCobpcnR1ehRwAYhuX9pxV6mWTRrIPOr+1wf3dS4oc4W1yi1HIjcdzYXAP
    VH+buRsQwlC2ci9fDuHSvjYlrduseNMbMlFpDwaL9BkSPFly4UNaXS4jI5ul0hf2X1ne/E
    LyTUNfEyRxqt1uOsCpswktJKdDSQRzBRzWkzz6HfL1I3l5AFYCLeNDnObuOvg1fU6olE/e
    +bw3lsb3lpy18M6vSw0PFV5VRdeT3q0G49FBYb++4cHanDP2zQPdjQRd0vUWjqvkMvVt63
    VriXGJ/rp4mWDTS/zrTKJ8NbnaeRUSvXWxwGr6KvpqGL6hDDbtSdbgH7KCjI5gxa0ZYlfG
    2zBr9JvYMfSePEMu72XlqnIkhZSRvRTzO6/wuvNTIoZW5UO4hrjH1yCBTgvg
X-ME-Proxy: <xmx:LZZsar-yXlbARlevVBZ_2rIDiImYw9q9yRfUWhr_f4Nk74qOLyZzzQ>
    <xmx:LZZsaukwX698GkcrW7jEWW3mYWw2QwD6YAbVD17VrKKA-s5mnJmgeQ>
    <xmx:LZZsal-q1mAJzXG0Ox1AAEPbeTlpxyTs4oH5_PgqzZ8nwOMm6q_uqw>
    <xmx:LZZsaknu3vdXuyMh49oNKXoqdkcjBXrEes6ZXTtbg52GWK-hapalgg>
    <xmx:LZZsahrTBS1pJAiveL_GlDeGCIOXZgNXIDDaC0Dsp4YFHwRCTaPxl_Ee>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 08:33:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>
Subject: Re: [RFC PATCH 6/6] hex: allow only lowercase object IDs in
 breaking changes mode
In-Reply-To: <xmqqv79vha69.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	31 Jul 2026 00:48:14 -0700")
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
	<20260729233215.398654-7-sandals@crustytoothpaste.net>
	<xmqqv79vha69.fsf@gitster.g>
Date: Fri, 31 Jul 2026 05:33:47 -0700
Message-ID: <xmqqtspffidw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> Git has historically allowed either lowercase or uppercase hex for
>> object IDs, but it has always emitted only lowercase.  This has caused
>> people to expect only lowercase and not handle uppercase.
>
> It is violation of Postel's Law by other people.  We do not
> necessarily have to follow suit.

Imagine we somehow misbehave badly when we have two loose object
files storing the same object's contents.  Let us further imagine
that we can download these individual loose object files from
others, perhaps via the dumb HTTP transport.

If we tried to be robust, we would be liberal in what we accept,
even though we try to be strict in what we produce.  In this
hypothetical scenario, if we talk to someone else over the dumb
HTTP transport and find that they have an objects/AB/ directory, we
may try to be liberal and say, "Ah, that is a fan-out directory
housing all their loose objects whose names begin with 'ab'."

This is the right thing to do for those who liberally accept
others' data.

But we might further say, "Let us enumerate and download what we do
not have locally.  They have a file 012345...EF (38 hex characters)
in that directory, which stores the object AB012345...EF (40 hex
characters) in loose object form," and then conclude, "and we do not
have it," even when we actually have the file ab/012345...ef in
all-lowercase form locally!

However, liberally accepting AB/012345...EF and storing it verbatim
in our own store will break things because, in this hypothetical
scenario, we will misbehave when we have both ab/012345...ef (which
we had from the start) and AB/012345...EF (which we just downloaded)
at the same time.

The approach taken by this RFC series is to stop recognizing their
objects/AB/ as a valid fan-out directory and their AB/012345...EF as
a valid loose object file.  While I agree that this is certainly
one way to avoid entering such a state and triggering bad behavior,
I think the real solution that honors the robustness principle is to
still recognize objects/AB/012345...EF as valid, recognize it as a
loose object file for ab012345...ef, and notice that it represents
the same object ab012345...ef we already have.  Then we can avoid
misbehaving without being less liberal than we used to be.

If the system had been case-sensitive from day one, and ignoring
uppercase hex had been the norm from the beginning, I would not have
found it so disturbing that we reject case-insensitive object names
and being stricter than folks with those other systems may feel is
necessary.

Tightening the rule after twenty years is the part I am most
hesitant to accept.  So, I dunno.
