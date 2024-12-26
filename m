Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88C1196D8F
	for <git@vger.kernel.org>; Thu, 26 Dec 2024 21:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735250207; cv=none; b=Y2NJhIYuGNDOM7oDu2Nq2JOwl0Mhjku6YmbvY6KstdTOvWvA2GUBkKjXO1e0zn0m7J2L/H3vjfTIWDoKAKvo+rK3mZpMmF1yFpHV71TstrAV/LOKco5qm7ws3PU1eeZAY1oXqt7atUxjhJjj1qOa5D004I+qMR+xHy5myRB8UwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735250207; c=relaxed/simple;
	bh=E4ShMTSU5Fpk6FIdyIegwCk7thidHByaOKpVwqoNZoo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jhp/WCTzDtd6kpYuMiFYAXTT7G0Mm9o03gcO+RMjWgRRqH7WR4v0P1WeuPTxVSkTIPaZcNIqNgqaEcaMi84nDnN10BPVcbMLffhG6jDbGXujZokg+kiueK6qNEnIJ1zRdpakV74LSv2no5erOiRpbIRq48c3b0nfLuukpUsSoiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=46sg9kdH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K2wRYO45; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="46sg9kdH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K2wRYO45"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C8DED1140086;
	Thu, 26 Dec 2024 16:56:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 26 Dec 2024 16:56:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735250204; x=1735336604; bh=/V7JCCuZ3p
	KrNMV929cOUsL9LS4kTSYk+21ZwzOQ93o=; b=46sg9kdH5d9zeIG0LJuYkpkUmp
	jbzRCSGNUCfFn7elKICbPiLx2owELfSE+3V1b/nE1C/a70GHuV6eCZ7iVwXthk/Z
	K3rg5Z0Nppcp2kN0Arv0UMBe+82nXTZ+nQiqwljHp0XiOjQCfVNTFaKI/O+QZK3A
	jiDRIbDJvRHt7EpYZWlCEusidwS2VfdS5HFyXMDoVDD6KTi9DFQNUgrohCzj95xD
	X1py2sUFfPhLBnwbsQ755iKTfFOtD9dRhxLXbomSwc2HF1hpbtTyYyqSoQ53Dy/t
	Aq8gVXEWT9jVV5PwuYvr1N9IY1wksHE65ml57ZfKV3mryzyRdlK5xINdSoqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735250204; x=1735336604; bh=/V7JCCuZ3pKrNMV929cOUsL9LS4kTSYk+21
	ZwzOQ93o=; b=K2wRYO45oUTnid9bkWqJUNVptEje4G0ffDY0Se8kp8MHlT/1VEA
	vIgoA2EpF3BMfoZmq7vAKVYiwSdGbqO1r7SPAJ66onXS2DcXjimtPNqi6QlMTyWj
	aGIwqEEH1EXHWF/LcZMOf+ebMmPOu8Ck3xjkVw0crmG6MHUG273IWfm2uGLFeQD/
	0gfCDsZjxX3rCXDkfbhhPgcM5xXQr8ItBB5znnTQAdJBaQb+vtxbUf3t2dsGZsvg
	jG6zlgFTOaqVToQwdfMHsEMUU2qHPPi2TSDPv33+snKF4MxxanAifUx+EDkVhi9n
	GN/bjX0At6Vhur1X6KpeosQ7AfJsKV5+9Cw==
X-ME-Sender: <xms:G9FtZ-5tHZJCQ2sTGJNGjTM8UH4jhi6Fc3mVdbW0S1XrvuLiCpXzGg>
    <xme:G9FtZ36-qapcN332n110mIuilazIlNzIS1akzoSOO9LISw2hAlt3IiFrFnxGSZQ6D
    f-U11W97tCHg5MOnA>
X-ME-Received: <xmr:G9FtZ9en8wJFiUPkWErN6aHDt6dhRnPrvJDKHhEHxu0C2lB5ulOAKF7s7o6J68-Rg4r4lOSYFva4O1UHdYKI7NFfzqpwu-3Xfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepte
    ehffehffektddufeejtefhteeiudfhgeduveegleehgfeiieeffedugeejffegnecuffho
    mhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvrhhitgdrphgvih
    hjihgrnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghp
    thhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehi
    ohhttghlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:G9FtZ7IMoZufbUR-E2y1XJC6T4_WEYjpQJFP1XquJLIBCMZcEn2SFQ>
    <xmx:G9FtZyIYVkEd7XxmdIXkazoCTosre4z-gJ8gAJk7hyafTl22ugdFTA>
    <xmx:G9FtZ8xulWfr5s6KQhSt7uc-PGcx0gg-UX7fib4FPgq0v2WM6sG5OQ>
    <xmx:G9FtZ2IG2dobwDazSLBYAb84PC3LJkgRbM44IAqOLm2UKUq7HXuMdw>
    <xmx:HNFtZ_W9umNzJAa_TVWB0N0tkhbzv_OhCycZezaHWjPVq5gwvqsMlaMf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:56:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  jonathantanmy@google.com,
  chriscool@tuxfamily.org,  karthik.188@gmail.com,  toon@iotcl.com,
  jltobler@gmail.com
Subject: Re: [PATCH v8 0/6] add remote-object-info to batch-command
In-Reply-To: <20241223232523.76236-1-eric.peijian@gmail.com> (Eric Ju's
	message of "Mon, 23 Dec 2024 19:25:17 -0400")
References: <20240628190503.67389-1-eric.peijian@gmail.com>
	<20241223232523.76236-1-eric.peijian@gmail.com>
Date: Thu, 26 Dec 2024 13:56:41 -0800
Message-ID: <xmqqpllew1k6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Ju <eric.peijian@gmail.com> writes:

> Range-diff against v7:
> -:  ---------- > 1:  c09e21a9d6 cat-file: add declaration of variable i inside its for loop
> -:  ---------- > 2:  ed04a4a7c4 fetch-pack: refactor packet writing
> -:  ---------- > 3:  bc52c4f80c fetch-pack: move fetch initialization
> -:  ---------- > 4:  4c1b989c41 serve: advertise object-info feature
> -:  ---------- > 5:  dbc95a9ae5 transport: add client support for object-info
> -:  ---------- > 6:  f244ec8a2f cat-file: add remote-object-info to batch-command

This is curious.  Did you compare the right things?

    -- 
    2.47.0

    Information Footer:
    base-commit: 8f8d6eee531b3fa1a8ef14f169b0cb5035f7a772
    Merge Request: https://gitlab.com/gitlab-org/git/-/merge_requests/168

If the base-commit information is relevant, please do not write it
below the "signature" like (i.e. a line that consists only of
dash-dash-space near the end of the message), as some e-mail programs
consider them irrelevant and omit from quoting.

I tried to apply them on top of 8f8d6eee (The seventh batch,
2024-11-01) but the last step [6/6] fails to apply (the first five
applied cleanly, and matched what I already had).

Could you help to figure out what is going wrong on your end?

Thanks.
