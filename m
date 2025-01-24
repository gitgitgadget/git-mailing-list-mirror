Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DB723B0
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737738330; cv=none; b=YBENmCBvAfl9xLAWsOjo3Xc6bs+5fmoP5xS3lG19EmKQERDGJaEDq+rxhvApdoEXUXdsMf2M/UMzEztl9cExm66eZ447FfhBzDI9g5UqmU001KNfg5SOYLUrTlHMssQL4OIEUSQI+4YGFVDfvaJziW2T6Gu6s8vLxGoRVovZH9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737738330; c=relaxed/simple;
	bh=jzu1fky5pQkRTXg9FK73HMj/eSFViyRqzEiGwAnpE7Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hBXmpDk/EKBDGZpU+Csnw+YTnggehj4eqQBT4Ql4YoVSMwBNDP1VOiQb8KH6XXZ3lyVdmsKYy0ySJ2kIItAC2WalueAqsnHod4XCVT5m0WhhaNwH/eELHyBqQehxD05FdgLee+g3Q73SBLkkq16E4VeFPGECkuj+pG5hq/V97Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O8bgnzeO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=br3zbYTl; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O8bgnzeO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="br3zbYTl"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E15921140165;
	Fri, 24 Jan 2025 12:05:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 24 Jan 2025 12:05:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737738326; x=1737824726; bh=B2yu4NDFdW
	9qUhA225Az0laeNaeivjYRubOKV+vX9aw=; b=O8bgnzeOSBY349O7Z8T3yrZywd
	+92tBflkUY9VnuhJZYxC2VQO7o47E8NANvRtjMLRMYk7Yn/HWxn1lxDL2fBzHjYx
	ilZRg6R4qnCyL/XJcOdKw8a/bOky03Dnf4R3AcEyA3k9nN6vVES+wy4BJrzsRmjI
	z2jN+M5OrM6sYOiG/W3uSR3o945bs6z62mtXwrTfGzwzUJYhvmp3rPtEGjVUCXu7
	O3cF+l81TUkoxy5UhRp9bapR/A+k0CvU7Kxyo52j8QyItpSalxTVJnF+EYfZnNSW
	RIrsj3dH/fIEEu0vgSM/jhA5KerEdAUpxSwnBBu1RmmESX7ikAZhy1J4W0gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737738326; x=1737824726; bh=B2yu4NDFdW9qUhA225Az0laeNaeivjYRubO
	KV+vX9aw=; b=br3zbYTlAawaKKyH5391Qme2voX5c0HGPW2qhonSu9vFwvXX0mr
	8J9AeTJoShUMJm6yqWBqOYY0Oz8e+rqzpcdGg6XR7xwGbdgksgGLFUF1omUyJhtl
	vXlz6yIM5FBeSGxaEtf4q1ob9XGXKF9MZ92aAFHLgnj0DiEPoFsM10qtKxvWuhEF
	ivNZLQVYjMV9HRnTnJKORNMT0PIOZAu3kVR9iKQWhAtjo2byEqjJs2VmdOs+W/VK
	m+ci/ozUee3+g8cSaYwHDDU2SZjVyCTp4lKai5RDZJRnVZ/Cau2HVUiJoJ945ST1
	tgPs/p4ODAxICqgFd9TfAcoCC9vbq9ZwqRw==
X-ME-Sender: <xms:VciTZ8CUowLU_jDC4Jun6bT3P06YSqJl4pczH3oYk8fmStdIlE8CCA>
    <xme:VciTZ-jxQAAUbJbIyXnKljsUlOEz-hVHs-zsGcY-TN__x1_1Wf4qqLDwxVYU3G-11
    3b1W_xnMSckHib7DA>
X-ME-Received: <xmr:VciTZ_nHPZ5jew8DC4z8NKYPMp4XRfeNk5ekAIJR2HgzrINjCGJPidx2ihuRQrDgvts_9WkGicmfmKT-Co0ng9TFixiOTLT4eFLM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedghedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhoth
    gtlhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:VciTZyxHZ26Xt_eOw2QG5jzVATp2GTKZgWjyqZjWodjIQfIcU126Yw>
    <xmx:VciTZxSavsziMUewqaXbJKEyi9Ux3oxN7x_9TOcwV6k4oUNX9M4c_Q>
    <xmx:VciTZ9Yu7E53mS-s2Db20TVKGsPR4_w4Yg_kXhnNI7zBtPLuutfwgg>
    <xmx:VciTZ6TGiQC9Vlf7AIc4lDZoDVTQ827BAv8ZXGfp_OrWT3bozI8Zcw>
    <xmx:VsiTZ_MFyIr2FhB8jbA9jIqUN8qmGkxgNZb8b__RM5h6gY9Z59VRQnuc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 12:05:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #06; Wed, 22)
In-Reply-To: <874j1o5q2c.fsf@iotcl.com> (Toon Claes's message of "Fri, 24 Jan
	2025 13:55:39 +0100")
References: <xmqqbjvyv510.fsf@gitster.g> <Z5MuCd_GbbLK_puS@pks.im>
	<874j1o5q2c.fsf@iotcl.com>
Date: Fri, 24 Jan 2025 09:05:23 -0800
Message-ID: <xmqqed0s16ss.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> On Wed, Jan 22, 2025 at 02:48:43PM -0800, Junio C Hamano wrote:
>>> * ps/build-meson-fixes (2025-01-22) 12 commits
>>>  - ci: wire up Visual Studio build with Meson
>>>  ...
>>>  Will merge to 'next'?
>>>  source: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
>>
>> Ready from my perspective.
>
> I can't really vouch for the last commit about Visual Studio, but the
> other commits are ready for me as well.

Thanks.
