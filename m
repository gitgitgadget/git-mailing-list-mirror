Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9D1165F16
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791036635; cv=none; b=htD64ebTxEr4RGw06Q0B9EkCoLr/mUZZfDalih650+vkLpnLAX885hJvJzflblY6zR7XpyNCzzTP+amm5TNwfriiofQF/q6FGvyO1gE1Sl13HOpQETio39aSzc/uPV7FF/SQ7rizkJW5VHL/hdsWvWYHQHIk6uGgQBATyAF+rVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791036635; c=relaxed/simple;
	bh=KrYC9NLIvLfEu80d0utARzNcaZUMOCXbGhj2ntSTxUI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HpXH7env0P6hqtEBrpiuHZNJbn0mi1g3JTx1U7BJyb8iAQHk62k7qQDjoagjrChdDF5xg3t3tScJZADeMFjybt0MqumMF0ekGGaCZdldA/mjfIsQ5QMderyLy5uMq84v/kqTN8ysagG4RD2/JaZRP4sWxKECZi+LeppZxzZngW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=p+tjtZJu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FSRXiz5H; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="p+tjtZJu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FSRXiz5H"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id E85B3EC018E
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 10:10:32 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sat, 03 Oct 2026 10:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791036631;
	 x=1791123031; bh=KrYC9NLIvLfEu80d0utARzNcaZUMOCXbGhj2ntSTxUI=; b=
	p+tjtZJuHM0PRCyxmK3tvTeZzK6MhZ6YTr4EcRFciylfFP4HdoiLdkFb967W9DGr
	BacpG/pDwvJdO98viEvJpImA4DlLhHWD1YL2kulOKvrrHZS2S+KaIxlw7mS5szcB
	Ck9kyW5KsWcNf6Tv9qLMmo2f2+7okhMFdAcvvuhoKMAhcbgYdiwDwEZG94eOggcR
	mB7vnKR9LmUf/4ILK6rLeOg0ScuA1rhupzZ9DO+iWA9HRflP7PkvCf1nOZXN+nI/
	5wFGumLiGPKLMXnNepU/Jpxs8Ba5OEXOe8Qe7qPTvIpQxUxvCden2H6oVNJXCuKk
	rvupFwX/YDC/1Bj25p5klg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791036631; x=
	1791123031; bh=KrYC9NLIvLfEu80d0utARzNcaZUMOCXbGhj2ntSTxUI=; b=F
	SRXiz5H3BGP6uf8oczSRp96T130pI52lakc7nTNHYigHyV9OfYzOf9ZkWlaMsbzu
	r4Q6wXfYSM15lmERQZrAl7cFJAFZzIGCkq8SP0cs73jYOaVisJ70KJTNsKniy7d+
	PIG+dJ8Ds5g59Fr6jrpN3MEdprvyK8fY+KTpCZkvaBt6RwpFy4+W3G51GA+ivFW8
	3lT+kSiDvhnpygHATkLpOPFBgvTQ3W408+AqHDkfN2KWRsmjYZCRtaBaqLfmX7s5
	z5IPkOw+On12owLItF/67TW8jo4TGGVpJQEEkDKGuZCfrJ5/1PEtTJ3HLwpEWpEm
	tqREIs1t/9mFspSfgXp6Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791036631; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:cxtmG+E6dvJv7pQ2NtJP9W+J2M/ZkAWctpY4gHWm3z4SOGu
	iM3Zc0Cz7RXsTDDHqssybv+RBP0ANCOqOyt18bEq4dEDYoZdI/QvJhHMFwYUbyMN
	FxBOmfvkSyMOJfDRvLUxlzBtLdEd8Cp14WQ0yi5kLsXdhjY0tMGGEGPgG9xsVBGh
	TcfEVZfgCrPjLuPWzabLg3drXs+TNSJLlW2plJkre6q8g5PWtHlC//j15+2wyyyG
	LiDxrYnRYVvzrAn6APRVHSTho3a58A3FCSMfCoWVHGNm2uF/Tn5eRXX7AK0/FBOy
	kCbU1w6jg21f1s7rNXn5iB4YN/lbT3wd0lEObjA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:xXjj3fb/hSJbSgGXtP19A1A6kE0DMTjWVHLxzEx2dbc=:KrYC9NLIvLfEu80d0utARzNcaZUMOCXbGhj2ntSTxUI=;
X-ME-Sender: <xms:1AzBajQcBLdyI-fAef6yrONJfHUX0vdD4TLisDek35cc93erYP4gZAM>
    <xme:1AzBavmNlZHC-HwVZvnnDANvkX7Ch_YRgCuF_dnTBNLWmy3VcvQvFElPnbmjVeioa
    i0HjFh-1MLxZbqnHTQ-DWN6NnWKGw07JwQvLqaQMtnN5PBOxbfwHA>
X-ME-Proxy-Cause: dmFkZTEs+ESF21VWJ5wBAdrgqTQb8n9ljJRiRll6VgdI6cZQbNp9AHFOccPZkvQV+BGvMn
    szGL7o5o4cO5Jy8SzOIAly7Fww++GS7W0IC6u8yqKekHt7tRfhgno0vQxpfnM/AQO/jyka
    M+Vfkcw6UQ+QrawH7UL90fm2JIcih1EOt1fnDW0FQGn95ItiIiH8jEcSnkPfRkIhnndra1
    qmjBQ3zBYHNYiyMJhalqJ4S9ty3fM8h6FwFVRKqSX3455G0+Z9+vgeQ6i0NwEZ3Rr+0uBw
    rI7PL0fIH9LwZOL6JiHOgyZzBOWUVgBRT3AGYU3pd8epZUOkOUbj8B7PapsEtPPp2p5tls
    OQtyIYrl69SsL7pfo0TUcTmMlqEMNS+Z+tEyAMnY7yF7CLffLVEgh3WZim+m9Lu8GL1GFO
    Tu8DYnFaC5fHGxqPk5R6aazdXbrZ5OF752YbUU6UvLRya1UMfqsRxatE85LtCNFgTlRIFX
    +Om1gKe0qr7DDSe3vujztLgu7fqDDexwA/4K6+UdrFLVXqwIEpL9bktMZzNLx8yP0S033e
    tTT+uhbeWPP4WseKS10e0XZ/ajNm+nhLP0ay5guLzQjUzUTOD3LPyrfFR09u4ev85t5+7b
    EJcWFNJU2hcjoYUgwXs2P3GNplNZjurW+xhEPrG4do7QAD77t966QVJ+pnng
X-ME-Proxy: <xmx:1gzBauuUuf3iUnSPdK6LdyGEvjR7ylRHkxYZTcezxKqa_r1TVeNeHg>
    <xmx:1gzBarMNPr-LowivwADkWFq3iZsqZKyjKIuhnfnVjdsM9evSZSIy9w>
    <xmx:1gzBas0iIHNsZcemYVnbLXsMt73AUAm1wJpRRthvymQ4ITTm_irSBA>
    <xmx:1gzBanOAgMkoyss-Kh0P_o8e5kvi_L6C0YDLFvItwf5EXuxSIv2YCQ>
    <xmx:1wzBapksiCHX27ffIm2fL0SeCZrL3xJOjI-bxPoha831kzI3yLmkYKoa>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id B915322C0092; Sat,  3 Oct 2026 10:10:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 03 Oct 2026 16:10:08 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org
Message-Id: <06ab24bd-eb91-40f6-9a46-a2caf5aa523e@app.fastmail.com>
In-Reply-To: <533e2f52-2c9c-459a-9fa1-dff3ef4bb2f9@app.fastmail.com>
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
 <URLs_not_just_msg_ids.d1e@m5gid.xyz> <ar0OltAkeTiCx81c@pks.im>
 <xmqqeceaa5h9.fsf@gitster.g>
 <533e2f52-2c9c-459a-9fa1-dff3ef4bb2f9@app.fastmail.com>
Subject: Re: [RFC PATCH 2/4] doc: gitbreaking-changes: replace msg-ids with URLs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026, at 13:52, Kristoffer Haugsbakk wrote:
> [snip]
> And the exception
> for email addresses (looking) that are formatted as links are that they
> are `mailto` links.=20

Sorry. Replace =E2=80=9Cexception=E2=80=9D with =E2=80=9Cexpectation=E2=80=
=9D.
