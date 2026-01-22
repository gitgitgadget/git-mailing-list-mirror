Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10B438B7AA
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769113052; cv=none; b=fJXY9d5sHaw4v30dRWsO5QtUfif0eAKHUsHhnaS93xkzp9wheKM8hFoWuQtFlynKyyIovYGoewPUdnT6uNTJnbZ6uTG2kHGAs/CRpFjU2cxVFry85bZAd6Wn0XCFvHWyeV+yPSAHwWpkaJXf5fGLvObPdhf7c0mXFwB4nfCeH6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769113052; c=relaxed/simple;
	bh=jraS67SCAhxUQ2V61Khqx8XLJdhnm+TcrZ4tgk6J2Jw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OECoWQ9WmQS0CvvpUa1TgtcScQa//g03mUb6Gde6BcpGuZGp6X9vqeyFVDOT+LVgkqdaMcvAtHAvAPhKaEgQ2wb0QWrMpy5cM9qU/dvlWW/fcL72BiJRfEETF88FuJpeHJf3zs0zBnN6FjUerRAin3DrL+4rp0XlXg9reoUHu7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=p9tREIPO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WxQeSB+K; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="p9tREIPO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WxQeSB+K"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8CCF0EC09D8;
	Thu, 22 Jan 2026 15:17:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 22 Jan 2026 15:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769113047; x=1769199447; bh=adSQxnl3ZK
	cvyMfgy/m5KIjP5DhV+IPWtjShU1qVWdU=; b=p9tREIPOX+ALM76PqKlbodyy04
	tj6rsspZhhhpbXawkjQQdboMzEsF29vBYsASkNAjDmfAoEnehLIR0mH/IxHAniXy
	SlvwVrF+VwNOj4qk3uWky6C7q6jAuOgU3RzOhiLTNuXX9bdZLOQt3t8dolQ0xhU3
	a8F3ZNi8S0UAwxcgocf3NEmz1UKK6gl9cQyA7aUw9KhW2j4x5SmoDECuS3Xf9aR2
	XZPurO5csrIGV4jHWqN9B5uoJLkRWzsAvmHYmyKwswUW5qGONUNM2In86DgFTeg+
	DWkixE6jO+eYH70/tCQnnm6guTBTUPkg4eUQrmRf0v5VXFkqQeKpQiR3qnhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769113047; x=1769199447; bh=adSQxnl3ZKcvyMfgy/m5KIjP5DhV+IPWtjS
	hU1qVWdU=; b=WxQeSB+Kyftw/pBa7zuDPf2o5RtjwEFFzv/jWeoM9TK5vUlnPRy
	mNk3t1o3PE9VQNJKUC3fKlvgVf8h5TzXpOm4+uN6+Y53Nfx1F7Jl7WQ+G8ln42S0
	KctpWu9bWprn+uIc4NOrVj0OMjVrkil4JpKf0yj2LdEHSqPew8vCR22nRR0knPLB
	w07zwMvPkfZ+UehhvV395vqbKAlTjs6mGPsIUlj16gylYJijDSG7GWp4p90El8pc
	YKyU5rqjOF9zyH7ERx2GtG7gYPxztje50G/MH5TVNquPVeORTc/PlH9yJRIpaK4G
	2Ytzvl3Da72bH2/0JwqdsQb5umM7vsjX6Jg==
X-ME-Sender: <xms:14Vyaa7V5piDv2Rtkq5Ozz5-m1NRKq4r-XsfUTgIQf-vGiB7JFeZAg>
    <xme:14Vyafu53BvT2tUfcm-FIlNivVic7Y_kqvPLeAIC3Hp57kJJV9D1W7_boKe8hFLdi
    lmL2jnUIkhz9iBiquaCn5g4AB287Z4fyfoIeYzbXH4ecK07aX36WAY>
X-ME-Received: <xmr:14VyaU3rxxFwwjYsfN-QEK_2C22MMG76xNhMIJl4Hg_I_tuE4qPX1fKmfdMz70QpHTSLbwkFVNDfkcf8IIj9Fs87rYjKMqkJf42MNQs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeejtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepthgsohgvghhiseifvggsrdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtohepphgruhhlohdrtggrshgrrhgvthhtohesshhhohhpihhfhidrtgho
    mhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhunhhshhhinhgvse
    hsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:14VyaQqbMBM0IrqyQIKyYXqA6z9Fxm-P3Y-S-izKMKQ5UEGWPMGL-w>
    <xmx:14VyacKVv7ZgLhw7yeXXUqUeM63nq6s5PRhPOkKduCmoQ26vJ39uSw>
    <xmx:14VyaUTh9WUFRm9R3zG8AUAFshLLEjcDnCs2O-515mwnKAJMtqEuVA>
    <xmx:14VyacMPXb7BlHkNpA7WX3QIxaHg8Ag4HPVFBuIYI4VIyB6-x_gMJg>
    <xmx:14VyaWeRU7W9_GXHNOtQ7N58RLN6bEcjUG1SW-aC21wRGyaUTdjSGLLh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jan 2026 15:17:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Paulo Casaretto via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Torsten =?utf-8?Q?B=C3=B6gershausen?=
 <tboegi@web.de>,  Jeff King
 <peff@peff.net>,  "Paulo Casaretto (Shopify)"
 <paulo.casaretto@shopify.com>,  Patrick Steinhardt <ps@pks.im>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Johannes Sixt <j6t@kdbg.org>,  Paulo
 Casaretto <pcasaretto@gmail.com>
Subject: Re: [PATCH v6] lockfile: add PID file for debugging stale locks
In-Reply-To: <pull.2011.v6.git.1769109815197.gitgitgadget@gmail.com> (Paulo
	Casaretto via GitGitGadget's message of "Thu, 22 Jan 2026 19:23:35
	+0000")
References: <pull.2011.v5.git.1768933954845.gitgitgadget@gmail.com>
	<pull.2011.v6.git.1769109815197.gitgitgadget@gmail.com>
Date: Thu, 22 Jan 2026 12:17:25 -0800
Message-ID: <xmqqh5sdmmga.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Paulo Casaretto via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     lockfile: add holder info file for debugging stale locks
>     
>     Changes in v6:
>     
>      * Applied Junio's fix-up: removed unused fd = -1 assignments and the
>        unreachable if (fd >= 0) close(fd) cleanup at the out label in
>        create_lock_pid_file().
>      * Kept close(fd) before unlink() in the error path for Windows
>        compatibility, as noted by Eric Sunshine and Johannes Sixt.
>      * Reverted the unnecessary whitespace-only changes to builtin/commit.c
>        and builtin/gc.c - these files are no longer touched by this patch.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2011%2Fpcasaretto%2Fpid-holder-file-v6
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2011/pcasaretto/pid-holder-file-v6
> Pull-Request: https://github.com/gitgitgadget/git/pull/2011

Looking good.  Shall we declare victory and mark it for 'next' now?

Thanks.
