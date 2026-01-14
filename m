Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0298A3876C3
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768383423; cv=none; b=cXN1rxJ6XNID5m+OFsZfp4/uFgy9pVtoG8oKR5lwPpncrYlISN3CVxeUc8a04V2X3M3krhMIf60W2Nfp2EJOtRbQoIvh37ZONVV/RbZHp3dSUNqpOxwoKPgmuBTN+UOkH0q/Gl26VCz4RqG4DQ1k6//zfC+PiNQ7b3A/xb3EIO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768383423; c=relaxed/simple;
	bh=OjZppJXl0zyXEVD+L1BDJNwsVygKIUSFXIiPIohHceg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=M+3vGekSJ6yiSaWfzyTYEH0DSsE9nV2+YVmT9Mk+SSqTp1+hPUrJ83fOpNlshMDosjulJzKBqlCXxes6Dww32jGjmAvSg2AtTMjzUCloYOEJ+/qrHx4Ev4Pga3MfBQ7+flv+VRxbCmUSzbEgjsFprIJEdGk3Aq8szPBhSbynNjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=AZ3xFByu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R4foWkzq; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="AZ3xFByu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R4foWkzq"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2533EEC0108;
	Wed, 14 Jan 2026 04:37:00 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 14 Jan 2026 04:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768383420;
	 x=1768469820; bh=OjZppJXl0zyXEVD+L1BDJNwsVygKIUSFXIiPIohHceg=; b=
	AZ3xFByufplLiY4QZ5C7S7VjtSSRdnSn/wHrjcokyPJkvLz5PGgk1momwrG2CQoD
	qi9n5ciPMNkGHJJ3J+TUSWWs2VGK4T0fGnyBVPSlc6LOSJHmjoo7riM6/QMhfCVQ
	ivvKUSGhWbwHXCoC/Ap0X9/l7fWwwpTLbAab08d+wvDkImlDhKUaXKaaFL17uKMn
	+y18QvZCoyh4IpwYtgf+KTrznNBV3mYFRKBSX9XMl6rGHqbRNGl6W0/lQqwrw6dm
	lhjQqYCzDTeS44HOf0AUWeDEpqLx6acUemFm+FWT47VbmE3lr2IIJDa2mb3O9qtS
	SEFJwAE2XsVwBH58/4mkaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768383420; x=
	1768469820; bh=OjZppJXl0zyXEVD+L1BDJNwsVygKIUSFXIiPIohHceg=; b=R
	4foWkzqp+C/G+N8ali6mvbNeah6DrB+aUicjCHp6WogIQy0RWVB8hxo52LcjhzpU
	AFB+DnFaW8gGe4YjFByINV/tWMoCIL2cWGVM9Y2/Hk0kASPsQR0d60yYMgaztxX0
	Vv1vKwECojIMPvi7SFCTQAz0/1o2c7S+r0vs3wOz3otpTAj03WGDOQ4zOYoZsh8w
	qbT2Ht/PRxvVkNphodzQAqfsjztdxpAZ2jGuZAnMQzEcF6VPy5cHM73cylZ+GTXZ
	6Ty+fZc6+7SCoaHi6wlI1U5u0OBREm1eHD9D8F3ppyx8RvTtZJOs+U4IfN29K0LY
	SQrq8P4iLKa8xP9X4f6gQ==
X-ME-Sender: <xms:u2NnaTZKWVoKTeClsYFdK_O5hpOI1M-qVavOHYLL-VRwjAFcKPz4oO4>
    <xme:u2NnadPwB8rejMYcHvVwCQKmOmcI7oGMqmqqoJ45-mdKxrPINIpSmZLWls1RtkJB0
    HgKpdXDvgauufknF_DV7X8rYx-Ffd_4oDAdflaYDvVwA4o_5--W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddvkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeekpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsugesrghprggthhgvrdhorhhg
    pdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpd
    hrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
    pdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:u2Nnaeee_afvOE0SOmynb0s-3WD_Nb9h0TRJitYmSsFZdi6AJeW5-w>
    <xmx:u2NnadbA8lpTdTYDCeXt_AVkaabEs0FRVCbYlrNLYXTvDGBjt7fP4A>
    <xmx:u2NnaQZdnAzs9-S_1uh6XRnAgB1156XpDy31Oa61aqotjZogbYsNGw>
    <xmx:u2NnaSJQclIB8SiQ_W2GXFlBfGRWp2n_9rynkjoWCzhwiECTFxGVHA>
    <xmx:vGNnaYPTGwFysopSPph4ZcVLcys-o-OxVeOV1bS-CXR3mldjP2ASKb_e>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 942E61EA006B; Wed, 14 Jan 2026 04:36:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AevOCapFdhMs
Date: Wed, 14 Jan 2026 10:36:38 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Adrian Ratiu" <adrian.ratiu@collabora.com>, "Jeff King" <peff@peff.net>
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
 "Patrick Steinhardt" <ps@pks.im>, "Emily Shaffer" <emilyshaffer@google.com>,
 "Chris Darroch" <chrisd@apache.org>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Message-Id: <0ab59443-0c46-481e-9e77-9cbc182e9920@app.fastmail.com>
In-Reply-To: <878qe0zimo.fsf@gentoo.mail-host-address-is-not-set>
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
 <20260113234528.1749921-1-adrian.ratiu@collabora.com>
 <20260114031257.GA858646@coredump.intra.peff.net>
 <878qe0zimo.fsf@gentoo.mail-host-address-is-not-set>
Subject: Re: [PATCH v2] hook: allow hooks to disable stdout_to_stderr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026, at 09:46, Adrian Ratiu wrote:
>[snip]
> That is correct: my mistake in v2 was assuming Kristoffer and Chris
> reported the same bug, when in fact there are 2 separate bugs requiring
> separate fixes, so I will create 2 separate commits in v3 for each.

Yeah I tested your v1 before I sent the report and it didn=E2=80=99t wor=
k.

Thanks Adrian and Peff for explaining what is going on in the code. That
`cat` would hang and time out was beyond my understanding. :)

>[snip]
