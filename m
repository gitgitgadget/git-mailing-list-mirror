Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0221DE2DC
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752616327; cv=none; b=hFIpCdQGWYsjXQCApq9T4zejMUIRnMWh/T+f6x1c8ivimBcwFFTa8hIfgR1wy6venHWmYsMHEzWr5GOgPBkW1ZmXl2QUq9UWRGFqluCzwQ7i2jhwxcAzKFZLfzCVrZ6yGmRlKh2YlSr7xnJKxlepCU0aGtvvk5RdsoiPFurxAGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752616327; c=relaxed/simple;
	bh=aeXfXprqU/IdGxcd5tt8FrJrV+BXIdFKp7isQMlJw7k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nmbjwwsCv17gQHKLtquynKRyH2xMt46+O+W9BoMc+XtM2CMnU3j7Hey3ewRryd6rRm2AdKLiuTyjvot7k6zZSzSxSWzqI/Kx+3GH80PrM0kBxqtFSostNmZdW3/kM6bh/Nr/rE3b5qBuSVwob8+dFnRJt8vRw8xaaJRNKTMvR/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FHmrCRz3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yh58slGL; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FHmrCRz3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yh58slGL"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CACFC7A00A3;
	Tue, 15 Jul 2025 17:52:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 15 Jul 2025 17:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752616323;
	 x=1752702723; bh=pdLIkHr/wQ//Tci9p3KveB8EuAOqgWaqbmSGJ7ziwe4=; b=
	FHmrCRz3/YyWvO5KxklcQWk3CSA4T2x+SyrfAh0qYf0fclxwuGmQ+wBYI5JxsLcs
	Zt3T2iLHi5lueWbyGtSm6r57z2U2JGvsjhddeGtHZfQmjelbl+kSkjKso1N2qwxU
	rCvD2h++DsfU3P6J8NEHGG/cMQQ67WT40EU/7Zz5bHvKXG8vVIH1U3TNJoqBW0Fi
	+jphocAVAtgcj3kkhAOTa8vveSe7R6N5GQsxDDD1Ak325SY0B5ojPDy0aZTJywQ+
	KQmuZlVRvoUNmXQIyZnhHfoxtH8LHnWFTaER1xATM+UYi4tn4N49+PtEq/B564+M
	hGB857x0OcQKf8x8ETjBig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752616323; x=
	1752702723; bh=pdLIkHr/wQ//Tci9p3KveB8EuAOqgWaqbmSGJ7ziwe4=; b=Y
	h58slGLzhP6eMc9cD1xIM4nHRmC0x/Icz2yzOGeqKaA+Lr01GONOiplQf5vs4L1e
	eC82YAz/Fx2BB/ldBWiroQqBOu97SjQQMg/+1seDh+xtdiWXFJvWHJwj40DyuTvQ
	qrdERT2Ei/uUt4bHMwKhx0N0Dfo9uUxH9AIS5nsC47vFpaS9RLu+8WMLyEXWRJab
	i1c9tyFbA3+w2rNcLBRdc8l/90ay3kD9LPDboHdBU2ahXFNPi2vnOfxKWTmGOend
	oEN8uUF4J7eFQYn6mEwR1Gxj6S284xm/NOclLl5qrurzYbPcerFGrtwn3gbYV33A
	4J0tF3N5a+7ZAAD2P1//Q==
X-ME-Sender: <xms:g812aBl-revL_D-QPnNwIfdwN827tIUe1EGKvMoHBzuCzQAUDbtYvg>
    <xme:g812aFSB-G2DfnIcNyx9fTU_Qc7Nj0E4pUvUk5IT5pN-RZKRgHMoKLhAtQ3cezaL7
    oxnlFwwcauZhaH21A>
X-ME-Received: <xmr:g812aIH4XQx6SpRR2EJ8PI0Yi2tqlOu5DcsZ9xJfOjMhahM7wJ-RlRKiCiMkKbTFXPSpqakO3gQdE_G2zMtIa-CHc9PvvW_7-cAZ6Uk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhephfetvdejheduheegleehfeeivedtgeelfedvffdtvedtudffieekieeijedv
    lefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsvg
    gsrghsthhirghnsegsrhgvrghkphhoihhnthdrtggtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthi
    htohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudes
    ghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:g812aCGEqAz7O2MYGCG7GBOUlah_Unyv3f_KM0BJ2p8PmRlkfum3BQ>
    <xmx:g812aOQGEsagQ9o63QMB-QeDq00xBhvTuphSoPSxH8sMKLAQ3pyGYw>
    <xmx:g812aLI9Fqh_Cy7LfNfeOxQbRLi-vEOkGKNpnOh7VPTa3F0lchzrlA>
    <xmx:g812aBY1zMdMviWTgRJjOuARQpQ3kH56Ai4PItv8aapkNKBpTORGjg>
    <xmx:g812aBC29OiES3E6nzf8hVf5RdOpw9r0P-dGfS7S6Faj7btqwPCGH_34>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 17:52:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: git@vger.kernel.org,
    brian m. carlson <sandals@crustytoothpaste.net>,
    Collin Funk <collin.funk1@gmail.com>,
    "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 0/5] bswap.h: Rework ntohl handling
In-Reply-To: <20250715191230.12081-1-sebastian@breakpoint.cc> (Sebastian
	Andrzej Siewior's message of "Tue, 15 Jul 2025 21:12:25 +0200")
References: <20250715191230.12081-1-sebastian@breakpoint.cc>
Date: Tue, 15 Jul 2025 14:52:01 -0700
Message-ID: <xmqqple1f7ge.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Sebastian Andrzej Siewior <sebastian@breakpoint.cc> writes:

> this series continues the rework of the bswap32/64()/ nothl() handling. 
>
> I've been looking at recent compiler and they manage to recognize the
> manual shifting and use an optimize opcode if available. The ntohl
> version provided by glibc already provides an "optimized" version which
> makes an optimisation in git almost not needed.
> One of the motivation behind overwriting/ providing an optimized
> version was to provide a macro instead of using a function call. One
> libc that is still providing ntohl as a function call is musl.
>
> While ntohl() is provided by the libc, the ntohll() is not. I found it
> only on Windows provided by winsock.h.
>
> I haven't touched the put/get_be*() macros. gcc & clang are both smart
> enough to swap the content accordingly and perform a single store/ load.
> Only the msvc seems to strugle here and performs multiple bytes stores/
> loads and shifts.
>
> v2…v3 https://lore.kernel.org/all/20250611221444.1567638-1-sebastian@breakpoint.cc/
>   - Fixed typos in the patch description

Thanks for updating the proposed log messages with typofixes.  I
understand the patch text has no changes?

Cc'ed those who gave comments on the previous round.  How does this
version look to you folks?

Thanks.
