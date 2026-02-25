Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2EA3ECBD1
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772034551; cv=none; b=Bffa4n5Qo3teZ6OT8WQtDBsHFwP3oio8+1yYVE9MPC7LKR48soyEbx1GvctqzKe2+YtVlQOvh9kPP15oOFWDyr3W2/tCecvjyKtJezz5/iwHyeHGcDHVuZHUhVYMtxaP49616bwfOpbtKnCuDtCypevuHiRMLzYlQNofLko7KiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772034551; c=relaxed/simple;
	bh=PgkQmtA/LlmoJMJyDdL8Vc0zf8Q9GDAVbtNhAIPZNb4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SEJRWGwsfCvENf5Ym0VwfXQ3bx5Qs00l5JKvTBQS4QS229uQX7OJm5dgOMpsEFix103cWuxcnPg/j9oRnwe1ryOmRqPbb7U7fbh505UwF+bE+NumlRlxA/omv1TSptEKT22pYxZAk2vVP1ycT1/LVyO5AEjmUt5FeKibtfpXNn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=XMyq0MZW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aQGs4Xgf; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="XMyq0MZW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aQGs4Xgf"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 37F80EC02EA;
	Wed, 25 Feb 2026 10:49:09 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 25 Feb 2026 10:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772034549;
	 x=1772120949; bh=GmNNdwT2LsUiQJeiX9JUbzgwAc+yg1SJjaakZbxuT2U=; b=
	XMyq0MZWT9WzA03IN/kk4J6USTKzSwuPmY5LZeYhCJIjHAUHmrNotIrWpKpXMpD8
	jdOoZvLnhbOU45NRolfyov01wIA6sT60ftxXTLwc5vLJPM/hiMQh21RfgzZMVUh4
	AcxOxrO2qt5iKnp1DH7XdXzKTy430XGyagsdhCHdnvu4Qmhqi3M2MvPeNParGKWu
	X2PdL4f6OLYOCOB/DGedwOIUjFJQ+D+40joUrMHNkBXd5raPsdIJ7n9J8LGrU3x5
	nwqGrT2B+EjQ+R46oVtsc8K9S8sqNNTCyrPPgDSWC4zCBPbvq69u5qJjebV1IPtv
	6/9ZBL1CTA/kl905+Fcb4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772034549; x=
	1772120949; bh=GmNNdwT2LsUiQJeiX9JUbzgwAc+yg1SJjaakZbxuT2U=; b=a
	QGs4Xgf3pPvT0WGnt3MNIUgY1wKoUITjgTQMoyZYdbOnAoxFt88Oht1jzSUbFBF6
	jwO5RjxQDoPJSgOwGhdlRsKnNRmLcpvNs192iQqZXGwpXcey144Umg3/erxt+3A2
	l99JxzwB410A3DiPpbZDtmikHBDyrYqr3Nh3l9XQ7ooalZj6ReZj38opm6CfVQ2P
	LTsqv/49OWOXVJTROWquo6QoaYzTiRAXMXsY1ZN/3zS/VO7FSh5RimJwrcjOWbmA
	wrICdG0BA4sHMKWTmmkLQu+QR4dXhksvaPB3nPuWaz0R/4L8CI31ZwMUeTzTftpx
	lcAffIOS4NtgsMq5fX22g==
X-ME-Sender: <xms:9RmfaRrOdPHwRxmADKYH_32C3bOLiE3sqkyh78D9Xoit7SeZkmApHzU>
    <xme:9RmfaefwbSetuljg2Sp4eP4RXReorClGhE7kTOtsnoo0vcSbkNC-S5ZCCMEeiz_XU
    hDyrrKfa5hwY2NcbBOdajedjg2uvpg5JhdeIMXgUgU8fU_pzWtshg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeefhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeelpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepjhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtd
    dtheesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepvhgrlhhushhouhhtrhhikhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9RmfaWn3h2R8GR-zumAz4THE-J1s8lcXGRaoZuvle3gg2ZIZpqN3cQ>
    <xmx:9RmfaSxjhSbIPJNqLTqsxsUySQTAlgWGVF-p6Rswi-bL5WTmErwxQA>
    <xmx:9RmfaY7x9FN-dfuFk8nwJUfIuxeGcWmznSzmmYt874rLnLFpMvBPAQ>
    <xmx:9RmfaaUj2rSbNMeOmZVoj51Ko3ZkeuaklQLZgcHICJOXsCmfbZiReA>
    <xmx:9Rmfafa8SsalvYJIa-DU2_LIROMQK8HDzt06sQiaPzTgT-L2qQTsvFwe>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0FCE21EA006B; Wed, 25 Feb 2026 10:49:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AktaiSWdNU4o
Date: Wed, 25 Feb 2026 16:48:47 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: SoutrikDas <valusoutrik@gmail.com>, "Junio C Hamano" <gitster@pobox.com>
Cc: "Ayush Chandekar" <ayu.chandekar@gmail.com>, git@vger.kernel.org,
 "JAYATHEERTH K" <jayatheerthkulkarni2005@gmail.com>,
 "Justin Tobler" <jltobler@gmail.com>,
 "Karthik Nayak" <karthik.188@gmail.com>,
 "Lucas Seiki Oshiro" <lucasseikioshiro@gmail.com>,
 "Siddharth Asthana" <siddharthasthana31@gmail.com>
Message-Id: <24b2c512-2ea5-485f-b286-ed79aafa9d5c@app.fastmail.com>
In-Reply-To: <20260225153414.7461-1-valusoutrik@gmail.com>
References: <xmqqjyw1cziy.fsf@gitster.g>
 <20260225153414.7461-1-valusoutrik@gmail.com>
Subject: Re: [RFC RFC PATCH] builtin/repo.c: change info default behavior to show all
 fields
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026, at 16:34, SoutrikDas wrote:
>> Thanks for clarifying what I left unsaid.  Very much appreciated.
>
> Hi, after reading that part I realised how pointless my mail was,
> so sorry about that.

I didn=E2=80=99t read it as pointless at the time (and not now either). =
Just
perfectly normal back and forth on a patch.
