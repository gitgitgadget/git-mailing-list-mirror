Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDBF524C
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 07:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100534; cv=none; b=Swf4wokeFT3tN5RHEIbVPL5SVblMLBidx4WYJ2lIaF7Maj4x+I1tXUGRSOCRqkOW1SnBHViC8T7/OjHjhVOp3HA9UYDZzRgAYWwxKk46Yg3LCrZNres4DVQPSdiKbVc+JBcwXtr/hrh6upT06xUlg2Aw4Qqf3rIDW2J3NXI0R9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100534; c=relaxed/simple;
	bh=zZWqWJMObgNWM5KBZJsv12RDs2QXQT66y10vCyPxlvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txUPg08cNkNRqP05XEuZrr94NacFE1OEiC5IKmXbA9qhC9dHEvP30qH6fKcWfZJiHpv08cVbvAA5VOuGeTfndv6zQ/yYUzEAlkFZFGTLzfF0luhMdt56iSDyg71GEDhSz+RdyMP3CNG0Y+XEYBRTzc9mWUWfltPFchuGGMym7Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZpvdEYRl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IFCUrbOp; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZpvdEYRl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IFCUrbOp"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 2B0A111400E7;
	Mon, 28 Oct 2024 03:28:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 28 Oct 2024 03:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730100531; x=1730186931; bh=zZWqWJMObg
	NWM5KBZJsv12RDs2QXQT66y10vCyPxlvU=; b=ZpvdEYRlM3pxDbkEBQsFPJKA4j
	XJpdlYHhrOrJUitVIE6OZ+OGNuKV7Yi+nK0BMoORrKCaoy7FfzZRbywLTl7cx8vK
	60JWHTtqlJ/IuJ8ctmJ1X8wCg/e9PAe9ix0wmOQUD3EL9Fe2pAHW1zCAj9886Z5j
	jTTqRAUv+h8btRUHmT9lr7qbm2WE36vJvpHCsnb8ACbzsQdsfcI7+QiQ5+HXWO5r
	Hg5ggki34PCZ2t3oDeotO/opfccCOjJB93SoxK03cvVYqVYSumn6MUFwdWrKyVlx
	tZIYSuVXLmPHFZ64MikPKiQjxtfr9fLzI7vdodu4rymVz29rvOrJCBGl8+lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730100531; x=1730186931; bh=zZWqWJMObgNWM5KBZJsv12RDs2QX
	QT66y10vCyPxlvU=; b=IFCUrbOpdkZgwl+R0o5i0ou30KK+D2uzzrihFrB6XWg0
	kg5B6LC85AzxAvlqQzzG+u649aIJn06ePu9S//L8xMV+ifjyBYW7QMnViXTEyaGY
	dNtnnE7W/r8vxB0yfLEwPbKw4xvmlG9m/Tw1y5kUabiGXqRiaRmBVzBTHe2J4YBw
	i4XXP4vnfRIphGjTyudfcyDf8HMTby/vjja9IWQC1lARgWLUM1J10tbeQNiKArYf
	RI5maV5+Hmgm4wMm5pqosYLSatrMIQO9AbcMa9lOOGyvugLSqSSgFc74G/2+hiR3
	BllYyIFtKIeiW14zs6B5i9rjj7k/HGEM8WLBDfa4rw==
X-ME-Sender: <xms:Mj0fZwwRQIUbQ9g-fXKX4a3rGBWl0BvvUTJz_o6ccRDpdwWjsJoKOQ>
    <xme:Mj0fZ0QmnrLxvm96pdFHW9T9mxwV08Rfeey2krujUGuc6NVfTElXjjnkNavWN9g0X
    HMFol3_7aLIztVYxw>
X-ME-Received: <xmr:Mj0fZyW7x1l2483oMUHkhZWku4ZdxvSIsxp6FN4ffIHcgHHYGBj3Pmyp9ibeL6MQUNKnUcfVeBPDXIx8hgfVsMy2_1IdQAKR_r-Q9nSmFBQKGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejjedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhiiihosggrjhgrmhgvsh
    dvudesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughu
    nhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:Mj0fZ-hYLY013ARBzsLlSJQsjc3HIyfvmpPUEgtqaZhlMNSaNY37Sg>
    <xmx:Mj0fZyAPUzzsXKzp1a-dGXU3o6OeIvgo9WXg5t8QOf0nKzcO1USkeA>
    <xmx:Mj0fZ_LMWoFjAR-uQy_lf5bK2C0jSy1eIrsgkX4X8BpcUw4cXmzLxw>
    <xmx:Mj0fZ5BAgOUa1m3Lc1CrZwSQOKTjZ4V82Rs3yHjGMVNtA92t9TZmMw>
    <xmx:Mz0fZ9MeoeTBS9RLcKj7TY1UK6TSuPkaUYadNeuvdmfVodB2rLqQ_T1_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 03:28:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a273a4f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Oct 2024 07:28:41 +0000 (UTC)
Date: Mon, 28 Oct 2024 08:28:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Chizoba ODINAKA <chizobajames21@gmail.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy] My Final Application
Message-ID: <Zx89J7V4WLA-BIGX@pks.im>
References: <CACwP9aqFY6kPOSzv2JWWZejwAiYbMEJJx2qxomEnyxnxKFvkvA@mail.gmail.com>
 <Zx8ouGN5ln_VtsHw@pks.im>
 <CACwP9aqXr8+VLEQFHmmbmCaXAyec=84+m+fO_W5JOZO9+CrcXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACwP9aqXr8+VLEQFHmmbmCaXAyec=84+m+fO_W5JOZO9+CrcXw@mail.gmail.com>

On Mon, Oct 28, 2024 at 07:38:12AM +0100, Chizoba ODINAKA wrote:
> I would like to know if I need to send in a second version of this
> proposal to the
> public mailing list, where the changes are implemented, or will implementing
> them on my final application on the Outreachy site suffice.

It is not a requirement, but mostly done so that we can provide feedback
and help you fill in the necessary details. So feel free to send or not
send to the mailing list, as you wish.

Patrick
