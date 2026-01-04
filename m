Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EEB23535E
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 02:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767494387; cv=none; b=egjXysgBzLku7Hj065nQHts/xI8Lwt2Gvgth9nRTzcxJxS6k/ovwXByYIK+5IOSCYjDhehbhPRW6lVis22jcjiMJCxMcnOrP/m/mdEq5dogUd5I8rnsz4d7e4mzy5PYdS/LxuA96Pm/A9m3EoYSS6n4ciVMKb70ZjgeG3BOgBrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767494387; c=relaxed/simple;
	bh=cYyfqxGFIg0eoR5LSvhb0aXLx7SzaKl5Mgcp5W7X4b4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H0KmqnN93RqAnqkzt76eugooD7I1iRbZKZ865ZVXQmqB52q5eLUJFO0LVOu9RmCVS76PrhuDux8A11N0DAAvBZvecX3GZ01KWQ5cqkmJT1SkTS1ne8EOuNkbr9+iK2cQ/V8ZmfT3MA75iaU5V9WPxArvIMPhKbbk28s1Fpvkbbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MvyCIzeF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s6SgpXvs; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MvyCIzeF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s6SgpXvs"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8E8617A00CA;
	Sat,  3 Jan 2026 21:39:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 03 Jan 2026 21:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767494384; x=1767580784; bh=DkFNJkgkjC
	Tj1RoPhficjIxWxwxn5QwRzWwWl+6PaR8=; b=MvyCIzeFv6Rk5+qAfAMSI91mvr
	e4Jb/BS1ei+c931+PkgaYQIhsTaekH8t6K59kMXZE6nQEEkbcAvSjeKbFi7sjIQn
	ZRZfsbbMFl6BG/NOqSFgFDJ6zk3MwGCUToE4wsnsTNN5IZdb9Ov3YWJajKITM3gP
	tZxxm/Tm2h1o/uJe4D3sqaRdPGAe/Nv8ASU7VlU/gIzT8TWl6cRiPhiVUlg4hhlC
	LN1YbLk8beec3KekkIAe+zpyG3dlUce3PRA18qUvoJrghAgM6Uytzq/PYUy+h/eP
	Q6OQIah4nP3nkpVr9ko07Bn7+6BRRSXUMHHnZqq5Dx+5aHMHBddDGhg+VyVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767494384; x=1767580784; bh=DkFNJkgkjCTj1RoPhficjIxWxwxn5QwRzWw
	Wl+6PaR8=; b=s6SgpXvscZTPhvKSB5JvlxLSmnT8Kw2w1ywFn2cEMrG8Yr2Pb1N
	zWB932Qd4CEcwSN0jJb3WBb9BcTVrScPBbe1HC2tQp8ySUddSNGZvjHIpEMcqjRa
	snJXaZOxm5JeIZb8K0K7NcYAuHFrsuakU1RM46wQHEkaxUMCj7VY1w6c/3Tr0aas
	L5zhSiMxs1OYZf2TVQVwCSc/czS/WMBtQT29NeXbAjHPaGkFJPIug/drI7uhEHYk
	UzDJjf2WmHBwQwdvp/uQo8ukuwcsILfa6at0n3WMbBlRSfDKtC+XI7lmL2K9kDoR
	UGtJg2olpnwmGzN6eh0Cl4a7s7zQiRYqJQw==
X-ME-Sender: <xms:8NJZaVascAKHUsTbmyM1Ix4cD1gLwYw51Tns5pgQbpHMrxd83wfVKg>
    <xme:8NJZaT2c6Gmy_CCBVvCFibcEnppv3wtGtdjrH9Moy-GIVSMBGzC9PLFYxARGC2OZZ
    fClUW2d6q5GWd_LwZM1D-yDkX5e-VG7aS7K_JFTanR8BnDkgKNzkF8>
X-ME-Received: <xmr:8NJZaVVcIzeCK67-HIG_KWoX2JJqnxVKoOhCKhP782431NOB89UWre4v-xH0AWiT1nUjAVHX_2XkikEIjdpvUPoOMQGIi2KxJ20vEUk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelfedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhushhhkhgr
    rhhkuhhmrghrshhinhhghhduleejtdesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:8NJZadUxKfxqa7DMT4DWBCwZEVEsDilBc24G-lQPA1vzOuceiHkr9A>
    <xmx:8NJZaUcRDXFlB7XIZbMFbNeLGZc3wYOit00UAf5Gs_fPhtoQArRf_Q>
    <xmx:8NJZaWWmG2rH1v83IivWyc4v_ewLq-qJbN6B2mD0LuGFQk8JvygXwQ>
    <xmx:8NJZadegM25uH6FHJ4czXRTJykPdv-XNanvfqWgKe_utPW0zfAG7oQ>
    <xmx:8NJZaR-tkbcN5pBJGrrIm-e1JgMGktAsNncYs9n_skyX1FwqXr_n2-ST>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Jan 2026 21:39:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: pushkarkumarsingh1970@gmail.com
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t1300: use test helpers instead of shell primitives
In-Reply-To: <20260102062029.18210-1-pushkarkumarsingh1970@gmail.com>
	(pushkarkumarsingh's message of "Fri, 2 Jan 2026 06:20:23 +0000")
References: <20260102062029.18210-1-pushkarkumarsingh1970@gmail.com>
Date: Sun, 04 Jan 2026 11:39:42 +0900
Message-ID: <xmqqfr8mp0cx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

pushkarkumarsingh1970@gmail.com writes:

> From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
>
> Replace plain "test -f" checks with "test_path_is_file" and symbolic
> link checks with "test_path_is_symlink". The test framework helpers
> provide clearer diagnostics and better consistency across the test
> suite.

The "test" is often implemented as a built-in utility in a shell,
but not necessarily so.  Either way, it is not correct to call it
"shell primitive", as unlike "if", "for", it is not.
