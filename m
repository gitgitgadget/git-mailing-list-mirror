Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764384AE8A4
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380873; cv=none; b=WNEXuFqRcCh6BTRaNtx8JWD2Y2wW9tPtOyUz26mh7j1Kw+nSHXrG0IMmJDNOqmr+HWbUkzY6hItDgNleIhZRoZjlvr55WnhR+ePNfGSnaMee8Rk6bE3oHkSzOruNDTLYyoXmpb/ed2FBu1+wYZWw7oSWLBolV1E0HBXj0fuEm+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380873; c=relaxed/simple;
	bh=AE2wDGl6ZpV8CSYdgVjAVRwr7BtpG0aP4BL5BoXXEww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=scIt2VWPAsYKqseypksAEYWnqmcMFEjHg8RdRgkwf2TC8oQu3nVNKxLXB14euf02EDR6rN/eq/Z/ULWRtSqlyUE9a4vIY+3eKA+3PKafJgEiQ5MWt4kXz9qJUTxADYNoRguRCivM2wVFh7LUeFnkb+Hw97dbAtOEEXL412SyjU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J9kU6Eqc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MND5tu0a; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J9kU6Eqc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MND5tu0a"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 44671EC008A
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 09:47:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 07 Oct 2026 09:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791380863;
	 x=1791467263; bh=do1GLrwgr6XRTCm9mCHMwfELHTu1OfdsrarfX6BFHCo=; b=
	J9kU6EqcO3jesi1PkwF7W76DEKRqTL9mvGshUoZQS3r+s/pHr9ZdtSS3R7wpbFzp
	8LpV5cBQXHmQUC1EbXCy0j304xSmnYKZzhYiXC2yZHe/GbpMaFS82NAnUv2w6bPC
	uVAZ0E52k9NvQfXsTeumfKYVfV8kIVlF8kXSBmVw0rEI41Jukpdqc50bPrqG+Qh+
	C9AvLeowneihQcLTfDWiLujHJNLoDCxGHG8+lA1M+kBbeeO3cUeESQwo2OSPOGnG
	BiSNi5TKCB2D1s6TvrIwUEFE8ilypIqySnMR1cQkhnJCSnOVyHIF1WBj7M3rFxjl
	MHIU3cbjAERbY/Ke7/RgRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791380863; x=
	1791467263; bh=do1GLrwgr6XRTCm9mCHMwfELHTu1OfdsrarfX6BFHCo=; b=M
	ND5tu0adODwT/rv0OzC0GYHUoNijsHevLKCk//TFVkTGX9WeyDEKjT2feFcvuuzH
	siju/G1/l3Ab6oRczJvRVvTlwuKDr3CoKWXaJJTzv2D83AL8tFDbH/fDf//MTC8J
	+Y9kBEHlQJJN2o3xrHEvzYTZLsQGlktZIKrNSgWTQZT8mwrvJQw6ROIn1JL7p8qF
	5J5gnOPlwtOZreII8KC/KVsvKY0jR3G396hePhOeCTpkVxjWHWhc22blQoFYzwGz
	gn773m7ka6MUzsX9u54PBgfdJgXJGNUPfGKx3A6pke1fYKRQ3MawQdjJpiTXHd4R
	3L7OsL+us+IzI0gA/28Vg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791380863; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:hafi4S2vGK14s4Cos9k4R6vJ7F7jxfhZ5UPOuXy57PBcUgw
	x8E5+UyCdG3eyC0Svv6+rcvUGBnO0Mm3hdoPJe18iCngReV3ldvsqPIrkj2FpQY2
	0voZgEwDMVeCKhbgCfd44LHVWrPRixSKSgitXWiBR5gre+rTx3WCrH2wMsAy7/71
	Lu35fVVz5J5ZgYAkWwgGhjM91EmNMg6TsXg2g3btfBgIxP3FVj02KWXAVPiUy2GD
	gXzQTFjuIBK4mvLQZe5+XgPiJ+wzRyPYILeUnRAZpINvwHDngFh+vxYAkMW/sYw2
	TQytcwWWAEakCck4O73XIOMqUC7gfMsuMjbOXsQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:MObsrxuBQuGdjNaEGlNrPZUpEOuQIPSwBo4U39Mi3jE=:AE2wDGl6ZpV8CSYdgVjAVRwr7BtpG0aP4BL5BoXXEww=;
X-ME-Sender: <xms:f03GarMXGyRA5jS3wW3rk6tg55o_37WM5AwnSR9WzPUavtBIjdf_Gw>
    <xme:f03GapoqScFoil-LL7cjdi6AUfbF11Se6fHUdTppTrUVMM0kQakbT419Lp7YBCS8v
    AE63MfOsSS7_JJfaJ5WppA7Te8nT4Ztq_PLN3aj4H7mXeQ10LoIFIQ>
X-ME-Received: <xmr:f03GakHaKCObhZcCiqD7bIk6Kcb3g2LfSAg-hnJqq-IvTeUt7eQUPmLiUb1TCMUQa8Qm8Jgi8ddNvmSGVw19Dfflw-nSanQ4F2wV>
X-ME-Proxy-Cause: dmFkZTGRRXGOiIDLALQU3AzBOb8o5FL97U/gP19yTMyMElzAUll6N1coWavGjnz4PR73IR
    n5Xy1gmcgLRar/l3H49Pcgd7QIxOACKdrfQaMbDm3XgD6Y1DQiJFnLZ+7ZkM7gStcze6IH
    JOPS1NihUGv10GPGhrAhy50EMbYdpoSiK688QQTqB8+ERxYlcMRhoEz7JCMNPBNVkjRPNi
    PPIJYvbOcSQwdvSICtS112cDuWo4pnfDLzYByr7tEFTQ4TPBfYbA3v62EkqzDQCxaJ2DK1
    x69iu46vnXcuLVkeug3SKYIziF1XRLzCDwFSwDWbJY+Z+rahkoMD3fE8zmnHqAXs5RknXz
    vgiUs3Td9kxRFz8foqOmJiRxCrZSEwYFGwZBdXUxqXsH8WPsY5xl65IJHTFjp2Xz5Z0Q6n
    C8coZhWEqNZIFAXlnk23fHoUgzHsSFccZPr7z5lxipIPRVXJ9Hmyag4/Wr1905x5FpludD
    YtoB+r2YTT+i/z8mC755rX3czSy/oJSCE0DfORTd4ghZ8P+eUcuThR9EE1XfQpshw36daV
    xpdngM0vNypHJMSPG6MB7IjlGYlNzQbEmL6UbJEsQubUag9VjW/KsdIqxYHUU0vadvymSU
    RrcJHhkqKq0inb/57yo43rSJRvmIohX0zV8jEuZ3eBCLZamWgr36bCrvOM2A
X-ME-Proxy: <xmx:f03GamrDVCJuxkx94YH-I7FEIKYFR3LkRmvLY3NhEe2GfRbt_t-s4w>
    <xmx:f03GalY_1j3q4ZR7dnSJX1p4YKiVIBeXBBLjR429juG4M4fw8TS3dw>
    <xmx:f03GanVamFdg9wjblFzQANcFBRUMFdYzvXxfw9HLDYBgF41vGQObEA>
    <xmx:f03Gam8YCBUHZYu7C_bh9t0RKlUkaEVVWl-0lMUIHegyzhj82E_3Eg>
    <xmx:f03GavwqEoS_i1CD_b0PkpaU60v0FX6dw2k8u9aYBbXep--yeemDWkbC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 09:47:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
  git@vger.kernel.org,  "Julia Evans" <gitgitgadget@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2] doc: use `man git` to teach users how to navigate
 the docs
In-Reply-To: <99bc9624-47a5-469d-bcae-8daa9b01581a@app.fastmail.com> (Julia
	Evans's message of "Wed, 07 Oct 2026 08:13:22 -0400")
References: <pull.2242.git.1790627574093.gitgitgadget@gmail.com>
	<pull.2242.v2.git.1791317163584.gitgitgadget@gmail.com>
	<ea29fe74-7f76-440c-9597-fdbc173be90f@app.fastmail.com>
	<99bc9624-47a5-469d-bcae-8daa9b01581a@app.fastmail.com>
Date: Wed, 07 Oct 2026 06:47:41 -0700
Message-ID: <xmqqv77dbp1e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Julia Evans" <julia@jvns.ca> writes:

>> Nitpick: Okay, but with the current commit message I don’t really
>> understand why the git.github.io link is gone. I have to guess that it
>> is an effective duplicate of git-scm or something since git-scm does
>> remain after this change.
>
> Yep! It has the same content as https://git-scm.com as far as I know,

Correct.  That is direct rendition of what we ship.  git-scm.com has
some fruff around it (grouping and other meaningful usability
improvements besides coloring and fonts), but I do not know how
up-to-date the contents or the grouping is and how they are kept
synchronized to the originals at git.github.io/htmldocs/git.html.
