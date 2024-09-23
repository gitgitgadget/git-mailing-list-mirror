Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22DB1FA5
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727117044; cv=none; b=t9nPNGMfyh5Ao8kgFEUFNDtqsyfzUs7xqIEshNCz6n6buPx28hCr7Ej6x7+BPPVGm5vrmh8GuwruVCmEPypd6g7scRVuIFDWeVByhUY9s1YNESDoynBectg2+mwMmM/55/ih+Z8JgR/fPAyufH4M01syUDm4vzw1dP+/harLEyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727117044; c=relaxed/simple;
	bh=zUZFZEqjV1slK4CaHQMcJbrpsvG7icwCnVNsBDX4jC4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JB+Vj67D0nDcJZsFj++Ebja/I5TFGX16UJIoyOvHbrTJXXYp+EdN/TI8ETClUt9QZwyR6dytc1sWZsbBllSqGXr7hhdvRlsTn5krg4K7cVhfev/ntWK2fgWQxRHFd5vn+HdrwEAnDkF5EUEgT2iAoJVQokZwq+0Sg3e9nu1vjOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=T0kcWZoN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j783hv55; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="T0kcWZoN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j783hv55"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AEC251140258;
	Mon, 23 Sep 2024 14:44:00 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 23 Sep 2024 14:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727117040;
	 x=1727203440; bh=zUZFZEqjV1slK4CaHQMcJbrpsvG7icwCnVNsBDX4jC4=; b=
	T0kcWZoNa+BT8mtgnNDq5S0XTzND3K5c5TGHfn83WV7PFn+cRcNJdnrPaYwAdXhq
	lQIwUtqBoMxSK0eaygZZndGiwLhDpkD8MahNqunjSDrUk3lq78v71+Snnczw7vxe
	SoTG7/t0YT5YBQEVWpqVdpGyxdTz53R2c77P53Kvi1tRgrvAQ+vciYNpNB3WvVcF
	g9RsxERcl6RoSG+IPTV1mx86zI9B7mVClf0tCpChsDhSQ0Bi4QtjPpyWZq2EucNW
	rryy1+ExYkLyqyXRIyQcZXjQrKikfjUt3PDNovpLVMfP/Ov943IxYuypSkfICH0u
	ms8KMqmnBCkW2iLRSReBDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727117040; x=
	1727203440; bh=zUZFZEqjV1slK4CaHQMcJbrpsvG7icwCnVNsBDX4jC4=; b=j
	783hv55otZEId/3jO/qNfBFfjk41TeoxmMCdFA7nUrHNz1aYeP83o5NyIwd2vmT0
	sJefDHDKRLiVKe3V0fpP0m2DnhdiiOIeOTxyse1Z/adx+TECIldKEYRlROOgXcHW
	GJB8OK0SjhLOHTGwNKJeqT3nnqTkgDj0jWVqNMVEQ4sou3Qavc8c+ktn7g3FMDwt
	2a8I7GDHYxxlYP4FXAnFDylN+u19dpc9mkpWZOEQwdMZghGj/BfYBeLkcK8y942V
	lehmoeG8F2mVJhYyBXnBACFvGSloNRcr4x7Zrk8Jgef5nLUtufyFSZ4q0AzBETIR
	1/hFjaWEYYMDV6ym1Ivuw==
X-ME-Sender: <xms:8LbxZjQSamp1FNIWSzVSg7PhQ7DPAyw4Mh6iwSXQkvpZxY9OkGykHKg>
    <xme:8LbxZkyUasOJEPLu7qpoG1JJxgrrlw0O0MiBRCDdOZaEU6eZX95ct657uHYOMzr93
    jTJsb7maPhXt0Kqcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudelledgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigf
    efkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlghho
    nhgvlhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnsh
    hhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:8LbxZo3EDYv2NW2vsqDq7yzommIjaKU2iuJXfDu-YljwGxsVT4BpvA>
    <xmx:8LbxZjDKUlAsw_Ql2AsppvdCIB_Kp75oRSVnv_j-_Tg1YFkzpY7eEQ>
    <xmx:8LbxZsj6atWRyxSw6vcjqIPL7G1qXVU1mkwnbQ4S6JDk5Zjcvkg28Q>
    <xmx:8LbxZnoTIx1Do5OTrDpd0rKt83Scbai5QreGAWQf-Q1k-sZhrK_MiQ>
    <xmx:8LbxZvuYPyjLFVekgqDk5b3lU3EbbjSAThw5ihI6_2JaflSYW4EgiHx5>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6DE25780067; Mon, 23 Sep 2024 14:44:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Sep 2024 20:43:39 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Eric Sunshine" <sunshine@sunshineco.com>,
 "Andrew Kreimer" <algonell@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <85ed3ec6-fa4e-4ab8-872f-6bd500b2bb66@app.fastmail.com>
In-Reply-To: 
 <CAPig+cSZmKCwy_sFKPR-w+DjXeTJJec1BAM6wDXMyEMWhoAY6g@mail.gmail.com>
References: <20240923110343.12388-1-algonell@gmail.com>
 <CAPig+cSZmKCwy_sFKPR-w+DjXeTJJec1BAM6wDXMyEMWhoAY6g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Documentation/config: fix typos
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Sep 23, 2024, at 19:51, Eric Sunshine wrote:
> Depending upon how dramatically the patch series changes from one
> version to the next, the range-diff may end up being unreadable
> gobbledygook, in which case you may instead want to include an
> interdiff ("git format-patch --interdiff").

What=E2=80=99s the benefit of interdiff in that case? Neither
git-format-patch(1) nor git-range-diff(1) seems to discuss what the
differences between these two are.

--=20
Kristoffer Haugsbakk
