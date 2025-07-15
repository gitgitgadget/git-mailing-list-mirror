Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6EA15B54A
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 19:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752607427; cv=none; b=VAYDYXEpG8zm0F8CLNU5Ad92Fr5gx9xLgckfeAfuV6uhdl7rBdAw9iQDVsztCNZZt2FfLV6t8CjVqfq+kYSakG/0hTrNXyZ2sMDIHbjS3ltaoGPGmhps1lNJ+CVE4kTmBk8Fh6pnCLSOPWJKOVCfLjx/i4pt6KhRDGkUiGeSb/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752607427; c=relaxed/simple;
	bh=v9VGud5r5EA4ZRCZ8qpDzpv5b2zfwDh+sDxWwOaljQ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FkBcm+fwgkgsyv0ugOF0pHKxxZwr+N2EUvgQZOGq5akbioFkCZHUNwpzlQT4g41evhYj7mWYYwwavLi9tyfc5qb3uC+Viccr89D+XwBlZM2g1bs3gKtTvvDV4fRTJt5E1kKykiOz8rGfstwlR60s7Gdc4+6Us2R0yvsg/EUti4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=q+N7eeFX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JjV4df+b; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="q+N7eeFX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JjV4df+b"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 512F67A027B;
	Tue, 15 Jul 2025 15:23:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 15 Jul 2025 15:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752607424;
	 x=1752693824; bh=sCQrFu68kx+xEHpWYLGfSF0qD7SmkNzVMg3mMH0bWec=; b=
	q+N7eeFXcFPNOD8RtoeWZzazkSVBAI1l5UF5gqwcVMpT3IfscUOPygCHD9U1CWOx
	laiTaIs+5m1C91DSVOxIPQces8Qwx88n01AekuHXKoh1G+owmQZ/+8ENMkqmomzh
	iv9mj/xBCxdFBGyDecivD+R+ZnSJt0zQRGEYD5p3Po5PEkjygISa+cLGymY6Xit7
	a+utTQJCXQDEpFK2bA44gMUWNYVKr0A8EiQZGiQYFxt2e3pYYiRueKbGKuJ3U3aO
	jD+BxOFcq3k6qSYrEJjJjk1evH6RWbW32pLRjupqJaWqxNEiy+4bj71fVhQ0SajU
	2r1IK5KTbwyIiC+/jgEGfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752607424; x=
	1752693824; bh=sCQrFu68kx+xEHpWYLGfSF0qD7SmkNzVMg3mMH0bWec=; b=J
	jV4df+bdAxKwvs29/XiDB3Lm5ZUuoXMeDPAV+yyg+8zdWyjx7h2H/igRZOazbkmT
	hGmnHnerjSykSnG+fiabOGiFxHZA71jIu9RmcqhKDoMoj4cAOahJPSLhUZck2Ero
	+w0fG92CqoyhVr5HolWepxlbcDZ8xTjBbtkKppnY81Pauvzuf2xNUyNsHEwCUwu0
	nOvhm1da3TNhIZZ8u6qzHtd2jvsrZyvLCnEn32howffXMQX1MgYain1zQKKrlpvm
	LxuMDPbpnHV1Rzqq1JIDkFNCi2OkO24QRBo3i+HxC6U5OJWBFBV1Ub1k1papeDGx
	0NbT+r7AXaj+9+wvwnnhg==
X-ME-Sender: <xms:v6p2aAcXhYcepxLlubj8umHPOSLJQHQZrs1TQSHMVqUMBKWZ2KWXYw>
    <xme:v6p2aMwluQCxvVGgWh8M-UDFy-ETra3CtS4_ALw1tKt_ueiPr4TKro_ASs_R-e_tG
    8DucCYb2ja-sD6hFQ>
X-ME-Received: <xmr:v6p2aOFt-j8fvrS9-gh2KlnC4YqcuZr2Gm0nF5HfBpRX16FMAbYbUWZsJux8iWTtp0U6Rx0B7mx1SfFqwfsRseDmyvNvvfqRDS3sBJM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkeertd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevle
    fgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlrdhsrdhr
    seifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:v6p2aIwkBlNxZrtqzWbKN9w88xV5FGYvd5mq51rb5PbfiqKJX3Qj_g>
    <xmx:wKp2aHulGUZLh029SYELnlkvebxXXBWvzoWVNV_5Ji_yY8EGyAuK9w>
    <xmx:wKp2aN0K56IK4-Nj1M31z7T4ezAbt1xs898C-h_XQe_2UD7VTbN_vw>
    <xmx:wKp2aK8UC7WROatX954ivzce_CO9XC6LE7-nZa-4s2AzcpLGgHDs5g>
    <xmx:wKp2aPv3-4DTnC_mocxI7XQO6u_fzYphiYzJZjLhRqASKyjC22P_KPrP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 15:23:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] commit: convert pop_most_recent_commit() to prio_queue
In-Reply-To: <bfb0a65d-c9dd-47d9-a88d-9fec43538b0c@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Tue, 15 Jul 2025 16:51:07 +0200")
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
	<bfb0a65d-c9dd-47d9-a88d-9fec43538b0c@web.de>
Date: Tue, 15 Jul 2025 12:23:42 -0700
Message-ID: <xmqqldopgsw1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> pop_most_recent_commit() calls commit_list_insert_by_date(), which and
> is itself called in a loop, which can lead to quadratic complexity.
> Replace the commit_list with a prio_queue to ensure logarithmic worst
> case complexity and convert all three users.
>
> Add a performance test that exercises one of them using a pathological
> history that consists of 50% merges and 50% root commits to demonstrate
> the speedup:
>
>    Test                          v2.50.1           HEAD
>    ----------------------------------------------------------------------
>    1501.2: rev-parse ':/65535'   2.48(2.47+0.00)   0.20(0.19+0.00) -91.9%
>
> Alas, sane histories don't benefit from the conversion much, and
> traversing Git's own history takes a 1% performance hit on my machine:

;-)

>    $ hyperfine -w3 -L git ./git_2.50.1,./git '{git} rev-parse :/^Initial.revision'
>    Benchmark 1: ./git_2.50.1 rev-parse :/^Initial.revision
>      Time (mean ± σ):      1.071 s ±  0.004 s    [User: 1.052 s, System: 0.017 s]
>      Range (min … max):    1.067 s …  1.078 s    10 runs
>
>    Benchmark 2: ./git rev-parse :/^Initial.revision
>      Time (mean ± σ):      1.079 s ±  0.003 s    [User: 1.060 s, System: 0.017 s]
>      Range (min … max):    1.074 s …  1.083 s    10 runs
>
>    Summary
>      ./git_2.50.1 rev-parse :/^Initial.revision ran
>        1.01 ± 0.00 times faster than ./git rev-parse :/^Initial.revision
