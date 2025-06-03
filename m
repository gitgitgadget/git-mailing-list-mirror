Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3C41D47AD
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 07:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748934519; cv=none; b=MvSpKV1R7hd63tkuW3viMUdPC98HrI6E0VQVft6KwOHkqwu1I2Z2AbVNj4vOvBleWrWsqgl24TjWpc4ypy7nT1HYN+ztjGH4Pa8CXn3SpuMHgUnVqm/ZUdPVxRasDbKjO9xuwMz7hlpq20Hj2fTFsYJfAkPt9IbJoJtAwM6msrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748934519; c=relaxed/simple;
	bh=hPE3EL+8T4OqWG3PWJaMzAu0Pta0q6bDlHF32wQEWQs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=szrM1wFXE/AWd6g5F+Ivv+f2G3Mig439aOgkDY0YUHEBiv0TFnNgX6odZ+tYuxCUZ2sgP4NGALuzSkOAwTGG+I9vofi0yNyBbCBzbS755MaoQumlOtsHzA+sAlJPwnpDmFnYdFjh/x/5onTQJioNTijYcRNa5ITFmXCMZOalt+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RcaKKXae; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MHb0lWvX; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RcaKKXae";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MHb0lWvX"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 0900411400E7;
	Tue,  3 Jun 2025 03:08:36 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 03 Jun 2025 03:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748934515;
	 x=1749020915; bh=Xzfn+02wsNJJE4BTomPRsJndzcPbEZYwdVATuR775k0=; b=
	RcaKKXaeZKoHJduUIc8LHR5UZzUi0IsIasZhCOYHZboqPHEdjWqENKtLpAD5ipwq
	sZvrggoNC4AgQy6vZ8o+EDTX6y1QavROr5yLp5AsL2sx/lVm+rbCMYS3TgM4bSnv
	D2x4/IBmq0dHMTchzZjrJSmK9w8PFb7eo7yFIKPzJ0+JLPV4reIju129n6HveI/n
	HXOVN9fDvrbxiliH9P/qBq3uvLpFlSVyGHEptrvrvTe+dTDKQebwL69EIq16BLnm
	hI9UZaRRFENMgAJmAwXXlLjEbFudI9TdknB2fOkgkqR+DfUhAb3wwfufXS4HTwMM
	7UIE+bx9397UNf5hCQrJEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748934515; x=
	1749020915; bh=Xzfn+02wsNJJE4BTomPRsJndzcPbEZYwdVATuR775k0=; b=M
	Hb0lWvXXHJuwOmYh9IARu7RWZqZrmTSQC+47yxDey0wsvSaJmQWo3cQxYJ3rVUeb
	DDtfMKEymoL2iiExLgcON3R9Xp7jvMxIne7Kp/itu/owLmL4wDldv2kOxgAvmcbx
	GzvShriDsAz0r9d4Jj2Av5njJEYYVByEBWIRKbC5s5yUG75HTxvHPh/M6ezWa7cc
	oqbMHPqNqU+z8KbixJxoMIlDOFKNivnRA4s4B2iNOolgzstx1WD75Fxi7U2LbA6D
	ze3M/xWIeZ0xTgwNwxT0yBKxeruO8sKptLHjuoq/B4AbV4rfvMP+LIELMoOUxpIC
	IiYL8JyRUEyt8fqo+ByUw==
X-ME-Sender: <xms:c58-aLA_upSEDeJ0hNA-OwV9-4zE2wgaUZNNJsQR_kluu_1AVQ6DXdc>
    <xme:c58-aBhau0aH9gNQbrtg0f-HXSffTYBWFYxXel7E2izCb3rGxtUQD08952CzDn7OT
    rx6b99Wr0Ev-OVOGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefleeludculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruh
    hgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelge
    duudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epuggrshhrrghfleesghhmrghilhdrtghomhdprhgtphhtthhopehnrghsrghmuhhffhhi
    nhesghhoohhglhgvrdgtohhmpdhrtghpthhtohephihrohhthhesphgrlhhorghlthhonh
    gvthifohhrkhhsrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthho
    pehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:c58-aGlEN0ZtsqWnGm_IPp2BecuCHNlQ4XjKF58Ss-5j47iXVUZyFA>
    <xmx:c58-aNzirfAOYI5mlmV2LeBS7znokBIRZciq13DqHV53GWnsebbMSA>
    <xmx:c58-aAQE79oyGZW-XPI8Js0mz4r3XsRkuo0IAuDXVk6CHn-_OU8xAA>
    <xmx:c58-aAbq9qHygoHMAx-F-ZbWEnHgkTdFx4e9IEw0IbV5cnN-8agTnw>
    <xmx:c58-aERlP58B-bs7CvW94kq8TSOoZUQd_zrhYdfP50eDh7QiyPa6q_kH>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ED8CF1EA0060; Tue,  3 Jun 2025 03:08:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tbe012f02e624288d
Date: Tue, 03 Jun 2025 09:08:06 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org, "Yonatan Roth" <yroth@paloaltonetworks.com>,
 "david asraf" <dasraf9@gmail.com>, "Emily Shaffer" <nasamuffin@google.com>,
 "Ramsay Jones" <ramsay@ramsayjones.plus.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <99de4d2e-ee78-463c-ba92-0f21bb1a4f27@app.fastmail.com>
In-Reply-To: <aD6Xh8kKUu0Y7sr-@pks.im>
References: 
 <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
 <20250602-b4-pks-maintenance-ref-lock-race-v3-9-587d44252dcb@pks.im>
 <cab8e175-e977-41b1-b53d-6b9170c9e416@app.fastmail.com>
 <aD6Xh8kKUu0Y7sr-@pks.im>
Subject: Re: [PATCH v3 09/12] builtin/maintenance: fix locking race when packing refs
 and reflogs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025, at 08:34, Patrick Steinhardt wrote:
>> [snip]
>> I=E2=80=99m a na=C3=AFve reader.  When I read this I immediately thou=
ght that reflogs
>> can be packed now.  But going by the last paragraph it is packed
>> references and expired reflogs?
>
> Yeah, I see how this is misleading. But indeed, it is packing refs and
> expiring reflogs. I've rephrased this locally, but if that's okay with
> you I'll hold off sending a new version for just this change.

Certainly!  I forgot to prefix: nit

--=20
Kristoffer Haugsbakk

=20
