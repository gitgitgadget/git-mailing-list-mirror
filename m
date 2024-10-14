Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33C71AA79C
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911389; cv=none; b=QHeaeHH/bGIhzNAx1eu73XtfvylASxv5t1oux63i5qfo7itP2YrEXvhd6Tl32DKK8xQYSa84+AcaHSkwuHYWDLfjgD29me1hnBrJWeBtVMBSJqOIJo9p0nVAuM2U13K76Htr0+jSv3V0f1mbNXE2M7OETV0YY4QhDhtJSPWhflM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911389; c=relaxed/simple;
	bh=3A1uvBQKHvcqohzJUWg9/f/cwpANKN5vLx9NAHTL8ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRtzdEBBhg+sBVdpDZp/gF4bYZIwr5HhfMq7hnmCLrZL3n9K59ZSuMGqsjgf4nuXpXADlwX//u8GxgLzOXQa/oiM4UHk1sef1YAq5AEehpZ5BADwPHBR9LL9XGTI9pnE6QnddRsLrqjG+uzgt2xs67crxFl+Ymr/bVy9mw8Ermw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PsGLDHqm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OK55+Aau; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PsGLDHqm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OK55+Aau"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E7D3D13800C9;
	Mon, 14 Oct 2024 09:09:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 14 Oct 2024 09:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728911386; x=1728997786; bh=lgIP7iRl5S
	NbmJi83nfbIpv2BVPBdUN14tOrUhSdw6E=; b=PsGLDHqmG406Xymvo7U/fplmK3
	/lHS8Dqm5S220MGj7LeJ/U6jzB6abk2ek4Ah9IJ8miBCmbD5rCRNulZeapNm42n5
	HePuK4pJz408dUnb9nGkcIqlYdEfFBC/2MVy5zvFLJp9XTWIjE+HEVCUIr+hWJcd
	I4AUye2yUnNW0IMADccE6K9w3/zrYW7xPDZjq/Z6e0I9fAZZWdxYwqGrtzjIGUFo
	xPw//vNO2WjD/1IsFMem0Yq9Po3PBlR+9ypxTuZeOCZfC8x8YTyDXDf7hPwlHwjw
	sO+9gBj8X2SF3jBM1BJSQZGxGhoSjFtKk7Y2GpexWvGONPCgC0L8A6zz8lYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728911386; x=1728997786; bh=lgIP7iRl5SNbmJi83nfbIpv2BVPB
	dUN14tOrUhSdw6E=; b=OK55+Aau0M75nt9P3O3oyCOrDwdELuGa78YKDyZ0fmD7
	Noa12cPBU6+1KgLUPLY0N443+L/xUeG2y6A100ahsyhs3QgJMgg+qRe4rxKN3Ip1
	lhpjedY5jCwimyqh614dTigp0fwZ7qyvdmIZxNcDcW/BVG0UXPz5qYmBEkO3mY7c
	oam3ZTeflnVoSzC1rLHgg3TtX0xRg317FD13iTRWjCJ4FjGhSrkfiiKvjifZbZtC
	Y7mazp8UPbFUSBz7FYqyLklxNdD1XcsjUhgdVL9oB3dcIkAGTZixCRB+q3xNCSkC
	PCPBMs6duZ1nLnBtVKsluJmsW1mtF/OcidNNXM9b2g==
X-ME-Sender: <xms:GhgNZ25-NpHL0r4W6Iu8DxN7mb7m2WuujUwySVVgGu9YSSAjPy8H_A>
    <xme:GhgNZ_7EKAPSZ4xH78QxZERtOReJNtaVmRwFsHhh_neasUYR5LRHtrB1JWhy4uiPG
    xAuG0cJ7nlQsQ7z9g>
X-ME-Received: <xmr:GhgNZ1ds4M6xqSf7-Bh0TheknezO0CW-3S4ilr6wwmoN5WKlXobRdVpAaNVqKLluM2c2KmSC0tMx_ypw-jWI2oM_8hnEzLBLQIey-nRmlD1qMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:GhgNZzK3-01XOlkzdZ4dCqkTX22h7h2JEb2g2yJtqM5qgVVlRgLBfw>
    <xmx:GhgNZ6KwH9W6pJ8SaHBj_QhZq45U0J0ogaow42lNh8d0CDuf66_Bfg>
    <xmx:GhgNZ0xdbgkAW2rSDoZ04WAGT_i9WQU2j40jPfBfzVkqcuM2Ra2JiA>
    <xmx:GhgNZ-KSfYiBR9kmEAZEzHA0ii3Mn9OzpkiTwB0S6MLd3TnZXyzx8Q>
    <xmx:GhgNZ22g0FjZtoF1I_h5SAZQ17PVFF5Vt8JYrAj9rMcju5hWabh0PfGM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 09:09:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 36fe6d5b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 13:08:31 +0000 (UTC)
Date: Mon, 14 Oct 2024 15:09:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 02/10] reftable: stop using `strbuf_addf()`
Message-ID: <Zw0YFKX7p0UpdT6i@pks.im>
References: <cover.1728629612.git.ps@pks.im>
 <abc28d7664f151e00568a6a3d18bf8a2de46470d.1728629612.git.ps@pks.im>
 <CAOLa=ZTHuWstTD56ZVTecW7ThHhpEqmrL28Emt5DtPL6pYhcpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTHuWstTD56ZVTecW7ThHhpEqmrL28Emt5DtPL6pYhcpw@mail.gmail.com>

On Fri, Oct 11, 2024 at 02:51:57AM -0700, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > @@ -1077,8 +1078,10 @@ static void t_reftable_stack_auto_compaction_with_locked_tables(void)
> >  	 * size, we expect that auto-compaction will want to compact all of the
> >  	 * tables. Locking any of the tables will keep it from doing so.
> >  	 */
> > -	strbuf_reset(&buf);
> 
> However here it is different, since we still use the strbuf. I guess it
> should be okay, since 'buf' is initialized using 'STRBUF_INIT' and that
> still keeps the buf.len to 0.
> 
> > -	strbuf_addf(&buf, "%s/%s.lock", dir, st->readers[2]->name);
> > +	strbuf_addstr(&buf, dir);
> > +	strbuf_addstr(&buf, "/");
> > +	strbuf_addstr(&buf, st->readers[2]->name);
> > +	strbuf_addstr(&buf, ".lock");
> >  	write_file_buf(buf.buf, "", 0);
> >
> 
> So when we do 'strbuf_addstr(&buf, ...)' it should allocate the required
> memory. But the reset removal did catch my eye.

Yeah, I removed it while at it as it is completely unnecessary. I've
updated the commit message to point this out.

Patrick
