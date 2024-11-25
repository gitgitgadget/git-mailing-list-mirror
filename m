Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092932941C
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 05:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732513959; cv=none; b=Q/IrqLJdyIQ7sTp1WQiUPZxOlrSULWgi8/IfN4QIWY0tnj/LoAmJzcdS73jdp72mn+9XKp8YQp7M9mKGiVSe52vcHu5Qd4Em1s1xKCNFxqt9fXvTcZIfVV22jiqTsRj8oljvHFq5nhkwClZURSnkOuTfW8izBhxWX6LDnHLe/bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732513959; c=relaxed/simple;
	bh=E4kmR9uSyHpFRJxOE9J+z5TMMpvcHV/ecnucSKL9Wsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqNXn4XLzj33hyTN55dMoePF2BNQTBBLli/M27fS4pMqOivr3139QP8vWVmRNwo4oiN6YdciH668tc0qRty8kYpZzmHTPemIMW4Iu1432HXlJ4v34q+K/mU2Ubkg2CJWbeuAfcZ7E49IoJZJ0IycVBKQ/QxxAvGzMp9sTD/b+A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LnWUJCv6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q2NEdaEy; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LnWUJCv6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q2NEdaEy"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 051372540118;
	Mon, 25 Nov 2024 00:52:35 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 25 Nov 2024 00:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732513955;
	 x=1732600355; bh=06Z5a59GcAZhyEzjglEvbsOaeBco15QL99CcPVSiUBo=; b=
	LnWUJCv6nDLISu1kv3JrgdHMll4daa6Nhb3WMRlR0u/8QLdAB17Pcd3FtTghoHxJ
	fSPXbdQyB0BFwwLZ4ZgE7vjPNsFLNzPxpbVw9mSXeomJPMmtu0ez7IdcY18WYh28
	bXaQOxXxRbWqOIa8ql1EL3iR4tKMvd73DIOFdXFMkP0HYww6x4WWFHgWk3RbBoxe
	A9VSv4PKT1/jGE753wVOyEgm4Ixjv0p4Sro4BjyvSvwLu66j7RWXxm6RkeYTdFEP
	e7WiC4gmVrSe11mKUuV0GVXB6p4le1Ma9IDjhHvauL/ex9Xrg/Z6WEPGfloq8m5H
	A3qJBtEF5luJElAa8XODpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732513955; x=
	1732600355; bh=06Z5a59GcAZhyEzjglEvbsOaeBco15QL99CcPVSiUBo=; b=q
	2NEdaEyJNxPoodbW5rYUOoizc92VQnOQMEWh83aWfSWYXvnCdnzRNa8ljd2xXic+
	EQJcY3NCK6C8FbZJN3LNHWYn/VnrARHoEoRpI/M3m2VEpshAJVDeJd3nWCGuBlZQ
	1ApYVibIrOVGY3RsxNzJhoAaoJ59IEcLcN/VxUZoc5Gf4eFHPfmsuTvr91HMbRr6
	EXUH0xdW9vl4t2A1NvW50l/1BkfY546Kh1p5R/LVZniHp92P304lFhj7PiRdjXeL
	tuJ6QUUpTY+sROhE0jKzi7XVrro0vtzG2pjbetT2ZvBSaO7N/dqVolW7c4YFdkc+
	EOHjUU1Ce0deE765w4AeQ==
X-ME-Sender: <xms:oxBEZxMEkYF4PRyyc4n2OrhtQ9VdbEvUg5mN2G6A4utu6JJinJIaAA>
    <xme:oxBEZz_q4fd6ZQriTbnGh_mMDnIMTn2jTEEuUa1La3p0jNBEUOdw7NClNGJ_GDG-O
    sz_E5V12ja_XkXQPg>
X-ME-Received: <xmr:oxBEZwSvGQ_ziEaSWLj-deEy2oaIqAvKxcsl5SpzoxU0yvPh6WPGE4Lgzr744UKENsb0SONQhFAyr3U2ZwFy8OCX_I6TLpbyWPj3aSpECDEjwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhkshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeekvdevhfeujeelhfefleekhffgffevffelffejudev
    iefffeekkeehueffkeeugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpkhhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghh
    rhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:oxBEZ9uIwJUzaPXs7sDyS-bJfrWAMUncjekMLt_xYaLdvI4xzrCgiA>
    <xmx:oxBEZ5fLFg5whHhvp0DyjS8sTv3JgtVuDAOpdCYF5w5aIV-uT687LA>
    <xmx:oxBEZ531uJzZftyVJ5s8CCQShmkpEcahnw5C4PEE2aISHbxXeoeBNg>
    <xmx:oxBEZ18zxey3KSP2OmHVpiTHg_rHAoUo4m74hLjEnC0zcvLY5JN8NQ>
    <xmx:oxBEZw4vAMMeaRVe8FooYJ2HRSZEkvccB11UWNOlRzr9SfRHnr7q4F9s>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 00:52:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fb2e67b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 05:51:32 +0000 (UTC)
Date: Mon, 25 Nov 2024 06:52:20 +0100
From: Patrick Steinhardt <pks@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	karthik nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/10] reftable/writer: optimize allocations by using
 a scratch buffer
Message-ID: <Z0QQlPXc0gcNohhp@pks.im>
References: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im>
 <20241120-pks-refs-optimize-migrations-v2-8-a233374b7452@pks.im>
 <CAP8UFD35YvWgQUcXT4z6k1foH4wN31KX1Xg_09GR16POs51NGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD35YvWgQUcXT4z6k1foH4wN31KX1Xg_09GR16POs51NGg@mail.gmail.com>

On Wed, Nov 20, 2024 at 11:21:54AM +0100, Christian Couder wrote:
> On Wed, Nov 20, 2024 at 9:07 AM Patrick Steinhardt <ps@pks.im> wrote:
> 
> > diff --git a/reftable/writer.h b/reftable/writer.h
> > index e8a6fbb78543e6e56920a2999601db0db9fe4d97..421a897dccd85ad0532860ff1b4f38b2813d438d 100644
> > --- a/reftable/writer.h
> > +++ b/reftable/writer.h
> > @@ -20,6 +20,7 @@ struct reftable_writer {
> >         void *write_arg;
> >         int pending_padding;
> >         struct reftable_buf last_key;
> > +       struct reftable_buf buf;
> 
> Nit: It would be nice to add a comment, so that readers don't have to
> look at .c files, or the commit message, to find what this field is
> used for.

Fair enough. I'll also rename it to `scratch` while at it to clarify its
intent a bit. Other parts of the reftable library already use that name.

Patrick
