Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C293F374A01
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788681422; cv=none; b=b91P+RcIAwDbukAriwL5kIqPEZHvw4TcY0xH4X2Ki7k6x8bUJBbJawOI8XlG2qbyDh5Fd6kyFMbcN5AmIQkgaiIzQR+NHvBSmhVwLk9/OEwJK4Inco674UtpBf1yLWnG9j54s6MkcW33E9HESkgrafkisF8tNcZ0Py57yZNxX7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788681422; c=relaxed/simple;
	bh=0EqZ9wzyyVWvTCmOT85EQhte1n3mck1CCo/yH8viMdg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jRfQjnabsHj95aCr3/1lkh7RUfVLjqGhrY6d/S2i6IDdLL8+rmks6tNC7ft2Xfl7MWidgoC19HfT51D/v56hfK94RITpJpc2ioNI2Sa9kXM//nNWGAME/MzCCTbOF3o1P/uCI3CJmEuFVWnQyG25hr2avNamu5t29Vy3/HNy55U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=mfqSqyTa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KBvIE4VU; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="mfqSqyTa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KBvIE4VU"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 55B42EC0098;
	Sun,  6 Sep 2026 03:56:59 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sun, 06 Sep 2026 03:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788681418;
	 x=1788767818; bh=mRjr1Rxx7lLoBVF6gVir1FTltQ5IyfZcuGoRuVSrCzU=; b=
	mfqSqyTaV8hbG5baw/BZmG1dAS19mwT8CjyW1H7YvOI30YP/oeJTIPOpZyBHxJlm
	jFtF5XmOidJbYfpy21MMIyNH20hDkTOlrhPffJ7RqWWH4HkNGYndHdBO9DgkEKD2
	UGD/k/eTqL3oZd5i6S+bQ4PAkvDrIDSOmV/qxjBLaTx9SOnehEuG34RsF4uFTzCE
	/NZUlh19AfRD4JBWsj9vB3oPBRNN2GnntV5DejarCfJkH4+yMgPYZcwIi1slPTSf
	4Wyv2e5F6rLjV4WEh2SfN1b398Iyt+NEM8mHTONHrn6u7sRrKDVcwzXtj8pmgwkO
	8EDefQ6B77Ugw8U/vBx1Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788681418; x=
	1788767818; bh=mRjr1Rxx7lLoBVF6gVir1FTltQ5IyfZcuGoRuVSrCzU=; b=K
	BvIE4VUm4q8jgm5hNHW/XVU6manrz/iDxjIbTKmojP+3dJeh/UU75JQ0ob5ebJwE
	GHhaTmdSVCVUhZWPaOuDfsfRyLiCG/c9PruzfzlPkEX1bPI5a3TvAyN1NqM0nk/O
	dsx24XFMH3eHkzoFj4avTx/ZlJwisi5weMtaMl2DZZ2PfZJlF+/cq2l0RpgGnOrO
	2lJ+wRu6tWJQxRj7dZG5F5IW1dmpLMLeBxuQLd48w8q4ewGLmlOboYE6AhgWmw7u
	jMLKaUHE/uxtVS14yveb29K6LzJOG7K4rkcFb+VydVwHUoqZTkujBb3Fualdu9FF
	rxS+9yYMgh6VEfTKCHSPA==
X-ME-Sender: <xms:xhydaumB3I2Za-6vpGLPeChTY5YkH-oAPmCWwwyll013V-uSI6LogqE>
    <xme:xhydagp69S_rFx16AC1tVHkmxr0YO43aEwMup7h4FpgfS2zRcU1Tw1KChEi7oV-1J
    gka9kjNtqN_UAACMNR-8PThIasZskqEGr_pHVJpKyZ5TDDc9WYCmg>
X-ME-Proxy-Cause: dmFkZTEKzVM/oEkbJJuYLfmd9w2ljK4VLT3PRc90UMuCGPKDBi4qtTwlS21bjt85kswFN9
    YuXveB4HRLbHTub5p9FSwm+jqt8JIFzA0A5lX1/W3J18AWKVFwCt6ooxJOtOm+ZOLPWmP5
    V7Qan1MgvKg37XNVSY3hx0pe+i8W9dYlRa1oxGUZ6ApzUxvwMcNI7WJiQa5/VnNPwMIlWM
    8ZLquGxkWVT2vq5JhdW9G4PCTzMspD9Z4LCz9KPxUexQR29UrdWU+KsxoV5sR/NLTcqdjE
    YBmSvlgeXDN3FPRm7ybIYxTjbT7uGFFZGfZ2kGlV4wr9IjQi0Wr/lbZqi4bgx5drLQNtp4
    0BVA6CDL4oZU/w0Mh8t99/AZCsBoTiPENJc26ofbtn8/G9JN4gSuUl0Qw2nbq+K/9E9pA1
    aF/A5Q7CBtS77j/vzmdKEWxkRCprmdj+/BqObPklDgO33xAEAHgDrFVDbOYHyLAj85HbIv
    4V804NAjZVI/B5QtSEEnN44y8/24UToS/iB0LAqct052esEGhqSRx2IXAA0VYj+zeMBGo2
    IUQ4Drd77lbGo7CcAMIRg1IoEnA7El+tzIbgbyGoSylHXZD5x882p9cGNC3IA4++UDZqLy
    Sn8XyT+bhA/omIVt4YWBntJzI6GFuvKpgadGHDcvXBBwbhGGrlVimA6SjecA
X-ME-Proxy: <xmx:yBydamJ7Znq1PlHaiuu8KhuYRwV-gcDPGIQkBWyOJuQawFPNveGQFg>
    <xmx:yBydavq-dXBWqSXOBB8KdsbCO7f2lR8Xeb-HOdfDSpb0zRKOMZjbvA>
    <xmx:yBydamypRLufWIfRqnBSz2t1_d21dQCm6RDG4xHWN3Yqg1v6P-gECg>
    <xmx:yBydarOE_0cCFXS62aptftW2fbQ-ivxDbDmCNkWQOtE-d7DN7gyeqA>
    <xmx:yhydauP5SYuXgyIi9f4lCXjfcGbDy-8_OjW38MNLvh5IxuaUoSNAL-jU>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 6D08E22C007D; Sun,  6 Sep 2026 03:56:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdFTpIy9UMIo
Date: Sun, 06 Sep 2026 09:56:34 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: =?UTF-8?Q?Bence_Cs=C3=B3k=C3=A1s?= <bence.csokas@arm.com>,
 git@vger.kernel.org, "Jeff King" <peff@peff.net>
Message-Id: <2e2dcf60-4175-4cc4-8379-f6618340da40@app.fastmail.com>
In-Reply-To: <xmqqmrtyb2dd.fsf@gitster.g>
References: <2006115b-bcf2-486a-ac7a-681caae686b4@arm.com>
 <E4F5C2BA-B083-42F6-A7B1-93A5FB984604@gmail.com> <xmqqmrtyb2dd.fsf@gitster.g>
Subject: Re: [Bug] Porcelain allows creation of '@' branch
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026, at 20:45, Junio C Hamano wrote:
> Ben Knoble <ben.knoble@gmail.com> writes:
>
>>> Le 3 sept. 2026 =C3=A0 08:36, Bence Cs=C3=B3k=C3=A1s <bence.csokas@a=
rm.com> a =C3=A9crit :
>>>
>>> =EF=BB=BFOn 2026. 09. 03. 10:38, Kristoffer Haugsbakk wrote:
>>>> Not a bug (2024) https://lore.kernel.org/git/xmqqy12z7eti.fsf@gitst=
er.g/
>>>>
>>>>     I suspect that it is much more productive to deprecate and remo=
ve
>>>>     "@" that is a built-in synomym for HEAD (but "refs/remotes/orig=
in/@"
>>>>     does not act as a synonym for "refs/remotes/origin/HEAD"). [...]
>>> I would not want to see @ removed, I have abandoned using HEAD years
>>> ago, too much typing (especially if you want to express more complex
>>> things, e.g. `git range-diff long-branch-name{^..otherbranch,..@}`, =
to
>>> pick an example out of my bash-history).
>>
>> Ditto, though thanks for digging up the reference. It will surely be =
important to justify when proposing to tighten the branch-mode rules.
>
> It is very unfortunate that the quote is partial and incomplete,
> though, and would not be a good input for people to decide on their
> own.

Sorry that I misrepresented your post. The gist to me was that you
weren=E2=80=99t interested in more code to deal with the `@` shorthand.
