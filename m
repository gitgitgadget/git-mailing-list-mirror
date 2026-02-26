Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B7F3F23CD
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120057; cv=none; b=MNZZuu6Pyg9lH8Um0qQhONnugh0aIKEaclys4ceXBg6lQEYa9S8I1+YEweapF5KOGHp4ygB55a/sTYqCE1tWjc9Z0b3shsFzdj2+fWDZ3LayVF2J58Xsn/rAteLd3+lme0itnkZCZCRv5PiawXGg3gd/NDVT8HJDyOjbsebM12k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120057; c=relaxed/simple;
	bh=rvY1lPH3oROLezzwgtB9wU48Cm725DCcBo6MB7j8WuU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZnVuuY6k+KvPYYefF7wyRwEUZ8sOuQmSBNHRaxabpTx/+wUDW1G6gufNfFxTa55JjLjwqPrTRFglhFzfnIeWatxqScyxVyTaiKs922EX2XH7yyKcLPtM7EtbfzO/EKtwfjSiB2Gbu5ZgnKP3thLzSE8A6WGT0+gXj2VLOowPV5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DXh7F86F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BB8QtXtz; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DXh7F86F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BB8QtXtz"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A179AEC05B3;
	Thu, 26 Feb 2026 10:34:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 26 Feb 2026 10:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1772120055;
	 x=1772206455; bh=jKgVRL4b1PCjUtcy9NAMDSSXvQcNBmduXoho/9kBSXU=; b=
	DXh7F86FYUnFScc0QEVqwelUoREgb+GWNiE6ihALLAtnYgJlsfGJqd2o3MTBZEFN
	jd8r5tcoo+TubiNU9bN/Lhujm5I5x7q/cP9PpSdmCgYNK2kUeiDOISjD+1dSkkCu
	HDV+unT9Ml0+tk3/MecIgaa65YZxU2nkHCMOZM0eKyDNKdVKDYpCJzMjVNDIdp4u
	GpAR7yILpkeuaqsHFJTtykTfaWuUvi1+gjDOLllNBXDb+nZ5LHZTIogFQNKDgraD
	O5n4SzjNQYN7LFZtkCDXqi8pB+XDDF2zXJAVtf3zTCXgbLOTn+EH+l+CZPkxNsXx
	Cx6ZNQM2IYRdsHsIkjlYNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772120055; x=
	1772206455; bh=jKgVRL4b1PCjUtcy9NAMDSSXvQcNBmduXoho/9kBSXU=; b=B
	B8QtXtz+qtCroMvwxK4XnwP8lg+HTm3Rst7pYJEFRPcFNaptbquXLTaOVfJ6PP+M
	ssrCwBoo9UWGXO5rHrLuMEfqHB3gEW6DSE1DCGfiPovIzaBSTCK7cRc1BP45oCIT
	tOR2eG1sCWLwLW/5YGhut1pzWz3NDwAHFAo8YzwJadnexpNkcBjJFeJX1FHQBr5x
	8208EX0p7PSuBYJ6LYoECUdwVC8tMJJigv1dodbhYBh1ZY+itpcr2meb5psnLD5J
	PvszSdMdBiYV8tkygaJuBlyY9bREsa28IAF9e5b3BUbRzb3z9n0ehjeFLNjBRGcC
	zh4fYTVl4ijs7yUaHHZQA==
X-ME-Sender: <xms:92egaWcfu1Qj3xh3hiVspzucnbuxKNHK8hLLLoLfvveCqYtO7YqFnA>
    <xme:92egaXHPA5I9-fEdK1Fvji7t8gtYCiHJiQFZFtsSek8coS9E-3RYJdb3XY91ghFvC
    gzQCH3ISibmzaV_FPMWO-HUlrO67aUsAh7GB9WyB76jHVE8jbcoIA>
X-ME-Received: <xmr:92egaf1rPXUHBGwbZX1-D2ICtZWKXsgALYfNDWsWuuozlJsKodQtHciVRbalzuEISsCtGodSesF38NF7tsJw9ZaGSFFAcHjGbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeigeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhthhhusgesphgruhhlihhsrghgvg
    gvkhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:92egaflyCZPw8_KeHcPcTKvljoZCXFUa9-2twHqJHTHY2IoJ9Og2GA>
    <xmx:92egaf9m8zjXY5HSI7rg5k9szK5xs42R9DSHsckziv_XsY3JdMM1Tw>
    <xmx:92egaUpOPAdYSdtJqfa-5c42-A2mj7uMy8wt_EN_jgqpuqM6ZRoFYw>
    <xmx:92egaYkZdfHtHLdLxfRvaakFNEuiIv6Ir8h_yKJ4z-NpS0Gk5Z4VIw>
    <xmx:92egaVAXPiOi_lNgGzvxg6SwP5xOROy0OJrkZd3OtWMT13-B4yQ9SbQM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 10:34:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Paul Tarjan
 <github@paulisageek.com>
Subject: Re: [PATCH v7 00/10] fsmonitor: implement filesystem change
 listener for Linux
In-Reply-To: <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com> (Paul
	Tarjan via GitGitGadget's message of "Thu, 26 Feb 2026 00:27:13
	+0000")
References: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
	<pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 07:34:13 -0800
Message-ID: <xmqq5x7j5xje.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v6:
>
>  * Introduced FSMONITOR_OS_SETTINGS build variable (set to "unix" for macOS
>    and Linux, "win32" for Windows) to eliminate if/else conditionals in
>    Makefile, meson.build, and CMakeLists.txt per Junio's review
>  * Moved fsm-path-utils from FSMONITOR_OS_SETTINGS to
>    FSMONITOR_DAEMON_BACKEND since path-utils files are platform-specific
>  * Removed V9FS_MAGIC from remote filesystem detection (9p is used for local
>    VM/container host mounts where fsmonitor works fine)
>  * Removed redundant #include <libgen.h> (already provided by
>    compat/posix.h)
>  * Fixed cookie wait comment wording ("see" → "observe")
>  * Rewrote commit messages for IPC and settings dedup patches

I saw nothing unexpected in this iteration relative to the previous
one.  Looking good.

It would be nice to have another set of eyes on the inotify part of
this series before we mark it for 'next'.

Thanks.
