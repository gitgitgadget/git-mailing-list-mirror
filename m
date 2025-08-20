Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275B228489B
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755724338; cv=none; b=VustBk4r0hOxlM8PClcrMEBtiLg3hk3+lCl3VWTiwudTz2puYoOhbgKE84Z72OZdrUMfplJ+VZnEedxOgvkfbhtqLaxgHPhtQVPOc026F2KQX+UFiNuD2YNbnolcdPb8AEbBh0/v5FcKj7Mod+blJQuOmi17cTzKvxIcn30xl0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755724338; c=relaxed/simple;
	bh=vx4CS7uEDMD2FxgUbRNu4MUQaq8CKQd+6dsli5fM+6w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MV6HWLXhd93+BXcE47HtB/REZO85i6SNUOAsMfTj8nx4x3Nfpa9S8fBCB0XmD6578hqqeXY4a5qkDYphcyNVgxfp5Lhq9vVKbrDHh56l7+Fk5OcWxMsgkL1tNvLxlKvV7wEbmyjRXCUcRQXaxsiSYtveywGEmbOzFkuRoGv8tjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=p7mcKtGx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RzXB3Mpa; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="p7mcKtGx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RzXB3Mpa"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BBD0E7A0140;
	Wed, 20 Aug 2025 17:12:15 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 20 Aug 2025 17:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755724335;
	 x=1755810735; bh=Lk2NQR2PcUTnZ2XkIeZ4HtIgPw7k9uvUNLRTiTWazmw=; b=
	p7mcKtGxF6YcpTGAI9DPlaAkBym7HArUHsdz2jCMT9yfCYihxxtAQT/eTFqUyA+4
	f2tMuVBbyO9D+LMvqAAVdfAaI7ZY5KqNE0b0vriIoEtNsjZfLGp2SCgcyYd/uWzv
	a40nJeMp5eshGQZU2rTWlnuHHegyWvJkGFE6AtY7uatulwJZc+Lp4GqwhU6bfa7B
	vBEsbJG4f0+V+AdkwiFLFNufsl5l2A4bP3MmttvBo8fmNoCPwilWYBik/pi6Hx1d
	CW/uZF5yiKmAcP0/hXj+RdyZv3p0UF/w2UzriW+GVtmc0DPkfunwNTy9irijE6jL
	MbtyqAsFfNW2kKKx4tPD8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755724335; x=
	1755810735; bh=Lk2NQR2PcUTnZ2XkIeZ4HtIgPw7k9uvUNLRTiTWazmw=; b=R
	zXB3MpaSOUaQiHYBO/OOI5Tmxi+xNNxqPnG7SFai5IIDMheSzpo8Kxw+RGOIDImU
	uznVbou7V97UXPSennPibwdPztM0fOxtr21U4n4sCaPf7vvTZM0I+2Y/H7XaW6zH
	26c0d0EK5mE1k1rTWTvsFjBQNXqHjCE20SV7uPQXmqaNmTRx6t7ndOFXRbz8tNPp
	VBjf4B6EQ0gZAx6hkjTOW4ky15yV4YOrHNrQNCSdHONiUFt2TQ9ssO+zMlDNoKpD
	xgOCHXgYfHd+r9/y03rRbS4TTxiMDDuhfbg+9YecOl2I8ryujqLtp7H9IzYAzCwz
	hpdewuyx/t5tuPB+d1fAA==
X-ME-Sender: <xms:LzqmaMQUdgauyus9SGxEzyzbRJIl_iCCwS-n9pIyrLUycvns6CHoWY4>
    <xme:LzqmaJwLlTsPK2UMEBaoN6VVVQXDRuj-7HQS9_jZe6lS0U1TStLX8ctWMCY8FVb17
    Kuxl3qcheJB5PPe0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheelgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsrdhjuhgukhhinhhsqdhfihhs
    hhgvrhesughonhhorhhstghhohhoshgvrdhorhhgpdhrtghpthhtoheprhhssggvtghkvg
    hrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LzqmaOZO7SIDFe5_B9wfCG7IIWu5PGdh7WFWu-ToGBF9bAGV957KoQ>
    <xmx:LzqmaK1xNvEyffyt9Nu7bG_qpqJe3XnRuCdtNIQIALp1FiaEvrfJgw>
    <xmx:LzqmaIgiYr7UNrTVRxHETN_ibwg2WW7WB36ESlZaO2goBaOlm4sDZQ>
    <xmx:LzqmaGb3GYgkyFVOCVSzE0Yw1FGESurmAf_uJkEQGBD4B5tQLoKyEQ>
    <xmx:LzqmaHjFLKB6B2WKGginlgxeHiRhdrUtZawdSPaja11WqKrswfBOqQ_K>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 50AC21EA0066; Wed, 20 Aug 2025 17:12:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATa01O-RMF1w
Date: Wed, 20 Aug 2025 23:11:53 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: rsbecker <rsbecker@nexbridge.com>,
 "'Chris Judkins-Fisher'" <chris.judkins-fisher@donorschoose.org>,
 git@vger.kernel.org
Message-Id: <3d919d08-4919-47a0-9583-d029f377a035@app.fastmail.com>
In-Reply-To: <xmqqsehl8zt8.fsf@gitster.g>
References: 
 <CAAn3O_2n75RGpvxv1o14BE3KFdwiJW9OOKaHp6_c0rd_MqxC2Q@mail.gmail.com>
 <011801dc114b$f38bb130$daa31390$@nexbridge.com>
 <37da14fb-fead-448b-b6a0-853c9fbea653@app.fastmail.com>
 <xmqqfrdmaqg4.fsf@gitster.g>
 <790a24b0-a799-44dd-b97d-c4c24e5d23a8@app.fastmail.com>
 <xmqqsehl8zt8.fsf@gitster.g>
Subject: Re: git whatchanged
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025, at 23:10, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>> The message itself reads like it could be read like: tell us and we
>> might put the brakes on removing it (and that=E2=80=99s it).
>
> Yeah, that is a wrong interpretation we did not want to trigger.
>
> "If you are a developer of a script that uses whatchanged, then
> rewrite it with 'log --raw --no-merges' and be happy.  If the script
> is very widely used, dropping us a note would be nice, as we can
> redirect end-user inquiries of your script towards you.  If you are
> an end-user of such a script, bug your supplier of such a script.
> Thanks."
>
> perhaps?

That looks like it covers all the bases.  Great.

--=20
Kristoffer Haugsbakk
