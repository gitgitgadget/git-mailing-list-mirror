Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4463A5456
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460968; cv=none; b=Jz3rIZMo2XzN8dlaHgWQMTufzZIaWHsvHiVeDTABX8sobUzZUF0yxz5Eb9blKSmYXyZ90LxvJW0Ski2jS7Ytn4oYSHLw6YQYeNu5QWbmz48i4+fnfx6IQoh6gj4MLPynnAH2iM43kVSe8lV+sRe69z4XWAREyMrX6q3W5Cw3guc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460968; c=relaxed/simple;
	bh=hDV4it1sF0lYr7xperAAUpfLB8oXKhj6xC6L/DG/m6M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U3JcGG+i0aRBKE7QqozKWNrOgjn8U2QztTi7fkTunb4eug8XMwSkAyiyX7kHfRdO1zGm7zzrgNKgKqrrnGsD91wEOdVbBCy070YBmIrYegYUQKR7Y32vQfKPAs7Vo4VynLB0v0CZG/awiNS1DlzLsBmE43IVTrRKlTnJNsBie8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TWGFETh0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PXi5yhxP; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TWGFETh0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PXi5yhxP"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1B1C01D000E7;
	Thu,  3 Sep 2026 14:42:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 03 Sep 2026 14:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788460965; x=1788547365; bh=wCBBCs/12v
	1BqKyl/KLXD5XevdoRtsvxIm+Ny0mvIJY=; b=TWGFETh0hbzgQm5LzByfKM86WG
	niUd/OLeTPyaX8XpIXf/kqieVOcZ3ZZOjZ/0el5/+VKVeb+/qnsKG5ft6bWCNAda
	z8nql/Tk2GN+6Km3HE9UbZEM7zT/ecp1BBcL06MAGMWUE6Rc5xlI3SgJVvsht4h6
	z8FjA4MbRtQCRddZ8aLsvmKTftijWjQL8Tphoj7VXBw/sy3NJfxPAxP9We/+1GX7
	1Nz3pWuAO1lbYt7kEwEOt3Qvfg0XQ5zRWF8AJiKErinlRIsn3QJTQR4uaPkNlObN
	qu7nQS4ZMiia1k2rj73kwdw/LnKS/YjpnzIFAscdIScqTQY9LUdfl3be+Flw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788460965; x=1788547365; bh=wCBBCs/12v1BqKyl/KLXD5XevdoRtsvxIm+
	Ny0mvIJY=; b=PXi5yhxPbat1dcW1947ISGWpg39nm8KteCzb/NRNE6GjGipJDOA
	IcSHbdZcf5yhColxZ7MLY41nAm766nsBpPyYYOMRV4RcRworCg9vp37X+158DKaz
	P2ebtBoj3Wfy1PvSVdUBJGmV2u9OjNxHYoXV9TNLX/8ECGtbErQSjAEHV4Fnd1db
	TfoFC25MdmXtjpNATfg2h09R09oDQNuoQTBwI9vWSPfxtujViYSKxd+hwnZJ4rBk
	jnQ5LI6nL8oGeJGCh0vt3FyR6dqPL7U3a5Vj1RUSikmGv+GQRPAnP6AgHClYb+5x
	udK80VmYKjYWueK5vtEeDft4erOrI1BZGnQ==
X-ME-Sender: <xms:pb-Zao5Qgw99wsy5-_X2A-oPnNPXfaaHBxED5wl5nc2h0qv8tsgHOQ>
    <xme:pb-ZarYK0oEBDGImDBrSTUFruZG-9Fjz_4XZ3VvOzijd7wP3FjaN2xyO68UVBxDOJ
    kBNipM-OgEPpkFQHI8Ui0dsch0pgsTnXUzni0QRypPEWfDFieaG>
X-ME-Received: <xmr:pb-ZanjQ6-TbNjxp2NCpJ6XzbggCPxk8gGe5QdCLBtVJ-VTTRqab0kV9hmwKKbkPF1cYfbbbp28Jah_56wT7-w1FD4d4wSCyoA>
X-ME-Proxy-Cause: dmFkZTGiRriy1Nun6dnJi82FMgBGlfRYUKZf9uoXWDCNDf9mABjwlwUrIE2VNLyO75Z2F7
    Khtp0HHafIvX0e5mfVUX6CC2O8Uio8ENNzN0VDDPFFrcdaZPwqh4VHulS2XCFCNZN3Ivi/
    8AjX7sqUgAYYXB4XQD++LeSUmpEgPXnF6q71LAHrLCHADIfUiusYQo8XJVpQAcrIMWylR2
    zO5AtClh9tuI/AAd85tfwcwxe2iS/WLveDxlEwFngsR8o6xHPPiPMoglaqmlaufkB4nBG/
    YDfBKGTgpkuHqwTMt2Q2sdYKTweniH0tckGUmu2kW4LQUNOOdFyfvR7BvO0ITOCoIlrAIT
    9hE+PpxxhCZjHoHSAi/Dt6VM2B+fos27XfKp7Kw91ChlwjWfLHf2EeDUbwxs+wVfsOFBRV
    LkzcA6ksKdUNGNtV6KBwnm+K6sf8ip8awfljsqaHJjwHy7FfTZ8/YQb+oyw6Gg3jNx3jFn
    Y71caIdci7aM5NU5wpwZkkPszwDjk5LlInekF1vwCiUcNANTzdvdsi6/iGnq/AtHxHiHBq
    MTI3WS2zsxkVJthhkB1ReaF0gS7OPnr3auEkAxzAjlEaOmIvBz4CyHFrrshSBYr2jcju7y
    lq2KQW0YJ/MJke/cNp9IFsCxRsPYp5gaxVExZGLiMtfzjqVGuVwXKhsGNtBA
X-ME-Proxy: <xmx:pb-Zas_sT5jfA3F4s7uyctZua9DlCrbFdI9q-JC2abMbSgrQ02ATVQ>
    <xmx:pb-ZaioW188M9JfizcGuXkRsZiSX365qOEzFfGR4trMHtKJVw1L4sg>
    <xmx:pb-ZakVtp47BNOUrcscO63m-AF9glHygwJTOmKRo8a-NEW88-N_TSQ>
    <xmx:pb-ZahDf1APr4D-Imj4goepZPjOFQP6PuPLtDN-pyKiPG_fGdG1F6Q>
    <xmx:pb-ZamNIib7rWsu8tGk_Us-a7ZLYxawINwmd_7IxjGX9-hXTLOCtsQLm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 14:42:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Harald Nordgren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v4 1/2] stash: reserve exit status 1 for conflicts
In-Reply-To: <CAHwyqnVp6BVGx3+UCqBC_gOCuyq1c62uNi1f7Wyfpxd1KdyM9A@mail.gmail.com>
	(Harald Nordgren's message of "Thu, 3 Sep 2026 16:45:53 +0200")
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
	<pull.2364.v4.git.git.1788373743.gitgitgadget@gmail.com>
	<ff4322180294c784bcd5f4e92b35e4b334324ddc.1788373743.git.gitgitgadget@gmail.com>
	<xmqqwlt3h1oc.fsf@gitster.g>
	<002b1324-0f7f-45ec-9f67-624a41801ff7@gmail.com>
	<CAHwyqnVp6BVGx3+UCqBC_gOCuyq1c62uNi1f7Wyfpxd1KdyM9A@mail.gmail.com>
Date: Thu, 03 Sep 2026 11:42:43 -0700
Message-ID: <xmqqqzjab2ho.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> >> +    if (fn) {
>> >> +            ret = fn(argc, argv, prefix, repo);
>> >> +
>> >> +            /*
>> >> +             * The subcommand implementations return 0 on success, a
>> >> +             * negative value on failure, and STASH_APPLY_CONFLICT
>> >> +             * when applying a stash entry resulted in conflicts.
>> >> +             * Map failures to 128, the status die() uses, so that
>> >> +             * exit status 1 unambiguously indicates conflicts.
>> >> +             */
>> >> +            if (ret < 0)
>> >> +                    return 128;
>> >> +            return ret;
>> >> +    } else if (!argc)
>> >>              return !!push_stash_unassumed(0, NULL, prefix, repo);
>> >
>> > Style.  Once one of "if", "else if" and "else" cascade gains
>> > {braches}, others should do so as well.
>
> I would love to have a linter rule for this, since I keep forgetting
> and it's a waste of time for others to remind me.

Does our .clang-format file already cover this?

