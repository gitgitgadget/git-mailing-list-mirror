Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FFF1714A0
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730789551; cv=none; b=sYa4iyopjfllfxxFqxKECQVuvnGz55ZRdbAwjP6OO+lU1+ptSw4KaB3XpyGHgdPmgg13svy0luf2hM/7TSVperypnccI79IThz28N9VJFr4VVpBYpEE8YpO1LLGhLFylB8X3bflp9ChvbO9eAxuZJZDOx8SN72NYP+JDPYVmn0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730789551; c=relaxed/simple;
	bh=vIKMi+XnTQOwmor+j3WLgJEdQfI/dbEj+AUWow+7Lmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPwVaSoZ+nr5R4seMfqqP1Rq36MFPL0ClCiG0rv/FCKEcdHXDMCrrvdEbtQfFUGeAItkVIQ7vR8fMS+MGL497Req5wY8u+qJgfDDOczgonRye+ayvLXeObypGsEAME0nN2AR0Lj5WHtdSq8G99g6IDWHJ+BbTAq/oa+am5No1BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rf4wvgqi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dLvm12Ik; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rf4wvgqi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dLvm12Ik"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 82A5F11400CE;
	Tue,  5 Nov 2024 01:52:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 05 Nov 2024 01:52:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730789548; x=1730875948; bh=TFJIS1XuMt
	gA+aFVMU1r8oeCmM9WajasTZfTF/FLjDg=; b=rf4wvgqiaYHZGthhrigVJ8dJK1
	VVKj07LoGwx0gUGexUIfw9Z8gDhOXEm62lbL9k2WidOSGxlJsI+pgyK1dxmo6/Qb
	dpSu7dmYHe2F3lVmJSZq9nqcCqMm4O7PjhmpEqYBwhvN04oq3jXs0jnsWXtxAIYb
	cBbW7R0B0qdF82287txmcviUa3Rl6RirlOLh/JHpdnoPdI4pHQ8vEr0vAhvfENnw
	Mr+vcLVrJYigqYvMtL55gt27GPvjhPUKCX7PkFNbRznWB4g1Q6AlgOaxHVzOZgdd
	15HNNt+YIqGMGPK6y1TGu0jbTRLqYaaEt7Jf+bCZL4elVrIUzkuZnDV7LnCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730789548; x=1730875948; bh=TFJIS1XuMtgA+aFVMU1r8oeCmM9WajasTZf
	TF/FLjDg=; b=dLvm12IkmnrpzjApKxAABCn7Olj4UAwUbAw3tKE03XpqG1RiOxT
	Bmb9SjxfaQLsZgL1yICTvdhEvlr6A9UGHz4D3vRrh+D0s6dzRpFQCo+8fpntQsxD
	TkBLZ/YSvKNKBKVLb09snYBClGB21144prtShR+CmUK0eOVC7FYqlszal2go/t3x
	PTsz/cm9/NFaOEF6C0uCiTvgDLiNZaJDkAUqudjitq2Bmw0QCvb0X0W0Qbfx6eI2
	EX9OuKg6VLJj83h2yiWF1dDCH6KBcD3C6N5HtJtbqKiajdz5KsOAIY21XuTbyc6k
	dbauqhODAyEbDXOmepvogqtTxJb/UIMGDyA==
X-ME-Sender: <xms:rMApZ_svDLKfa9jsbFjsTOecL9MrIIHtzZhgSTEwGGgVmlPI8wZ7eA>
    <xme:rMApZwcMpu9AWgWSmWCNweGickK8eJLTMY7CH-qFumdZC3LBkJLD9qYqMlM-03LZc
    h17DHu-AuynfkzZbQ>
X-ME-Received: <xmr:rMApZyzBVVjno-HwUVf21s2XeDbyA7egejinM_BbAebuunXMpuD6GIBKr0RmN0qonAJN1JlPFlTag6H0yRLgDj4shrq2J_iu-lO7fifSHSztlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepkhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:rMApZ-MzhCkNDzH0rpTzwT_D3F6Zk9g4V27myQ-Wf5iXksQqC9HTXQ>
    <xmx:rMApZ__Nb1-6YuzEGjaKOnmJtgbPZvdsFYzjKiD5fKmDOCfFx-uBQg>
    <xmx:rMApZ-VrqJ-eBznmpTGV_w0UBQMpDyDCU8cMluz06O5e78s5vdAjig>
    <xmx:rMApZwdAX8vrvDYyfOha0NuoE3Ffrwn8GTobby7AwG-ZgmpcS0X2Dw>
    <xmx:rMApZ_yJodZJDPoLCmwwzZdoyQVmyMU0e6sHAOIBRa_xkMe81aJKRzqf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:52:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b4baba85 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:52:03 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:52:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 00/22] Memory leak fixes (pt.9)
Message-ID: <ZynAn6VGChtZX9Wb@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1730786195.git.ps@pks.im>
 <xmqq7c9itbq9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7c9itbq9.fsf@gitster.g>

On Mon, Nov 04, 2024 at 10:51:10PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Changes compared to v2:
> >
> >   - Remove an unnecessary cast.
> >
> >   - Fix a duplicate newline.
> >
> >   - Polish a couple of commit messages.
> >
> > Thanks!
> 
> I spot checked the ones that did not change from v2 and the ones I
> checked at all looked sensible.  Perhaps this is now ready for
> 'next'?

From my point of view it should be ready, yes.

Patrick
