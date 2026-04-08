Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63D039DBD6
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775636566; cv=none; b=NWRaz19wX7zQQxScv/0CW9BnsAe16sAZmoEeUi4h+NC4gdR7JLYAXvVi/7d5uXWu0BdQYH9hzl8WP3WjSZ17b7SIt2Px6ecWYyWH75mD0cJocmSvIiwdzYYbKlpY+RDVPDTqUV7+H4HpEvgwZnfCHWa9kGxvhjiQ7yPGFcUnRiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775636566; c=relaxed/simple;
	bh=69K8t0a18C3Pg+N+cEdetDYSs5xkWgZXB2aNcUU+N14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s24TpHwVgNcgkSWNjzrkNcB4Qws1JgiQhBhjtn2kd13w7Gtr+2AgM5I4mq+bJSCO+PwCZfeQuRaQTjsm03mRlTaNt1GxSOhetifmTworhsdOgDaqB4JiNLkor96PQdbgazPURv98LCuymKs/iV4iwbmFkud18MqyVQHpSdxV7kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=r52Jtj/3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v/gsX/yU; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r52Jtj/3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v/gsX/yU"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2B0C8EC01D7;
	Wed,  8 Apr 2026 04:22:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 08 Apr 2026 04:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775636564; x=1775722964; bh=28wpr+Zh5U
	WETEDKBpBIIcd4xK1mfNDSw0w3pS7mUSk=; b=r52Jtj/3RSZs/gonXR6ih2Ja90
	IDK4MjX6843EDhb+mQcCf1PCru+IlLiKxxs9CI3GlZupUJHRP6hLyre8MSh8Wg09
	CLmexh6FlNhPJiVx8kmmg3dgW/uRS5R5ZOEIcVPlT/V7PSjVwVyuOQvsf9axdJli
	/PQ+5h16nLOEYb8Gqrn+4wfPumt49woHW6YnHszUwof0O1QtJnP7YgWZNURbXGQn
	DjtMPeQvulS2oocUoW55xlNYGsdo+v0VU0onIBrdRq4kksBT60sgbKH02FQ2h90m
	Hgf4Z/3ji+b4pNR/nyc01YwS/U47M1q/PfjwvnShXDdRRtIvNZBAAyecD87A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775636564; x=1775722964; bh=28wpr+Zh5UWETEDKBpBIIcd4xK1mfNDSw0w
	3pS7mUSk=; b=v/gsX/yUWqkP0/2hxj1EV5UvAdL2HntkLWDfPRkqAC8lx1RO3pt
	nEzSO/Yt3PAB7Bi4b3dQtEk9/Blf2gK//GBdzJr5crKMbMBvMfTFzMifkvuuLgR/
	3HaEhIKKihIjRPM7MBJNdrf99teilF7xGrW7aYfe1I4g2ONR+feNaaSaM0fugaqv
	vHwN58NFX8mu4DYHRhwUx09Fo5HujuKOQZomPZpdlwRAeCrPJk7daCiJRlI3pa3C
	EXKwxjEeJvvbSlgSHpqAIuQ1qHrlWEjvqWto1qklsD1fHOuUTh6PZB364NlsqUDI
	nWn15pZHbdDy2p5mHMk4/kQ4q3Txjw/1RAQ==
X-ME-Sender: <xms:VBDWaduNYDsAriz2lKuIcP_yRq0d1690qdi6U_81Gs-f_kEnvSh97Q>
    <xme:VBDWad4fRWkCFjWK0PCdIMF9R6bn9jcanQFO6NDQgafQBexIs6Fr6Dae-ElUcPPb8
    5yVNKQygyu4QRVWExH9MtMNznjsxslkwFhUvMzQedoSmXvf1EM8>
X-ME-Received: <xmr:VBDWaeINNgaVWTMXUpvMuGvRjfQCokmt31WlGNFODOLrr_ejn7I8fS-JqK-vLYYzkMkTHt7CGnnJlfi8os6BiInz4FG8G5BVNR8_Iio>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvfedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejvedugefgffffieegtefhgfeikeevfeefheevvdegieetgeeujeeliefhiedtueenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:VBDWad54n-YWX8eSeCexH1hZeMsx5u3NS0ng0wZ2mONoBxv7b5FKQA>
    <xmx:VBDWaRxmh9M96lhV7iWOh8wIkb5moCQnXD31Z4BhJJn-tj2cJeHGmw>
    <xmx:VBDWaRYjxSqmw0bz2HUUCwoe2z_FBEduR5Gx1Wwt3syrVlhz9ecL2A>
    <xmx:VBDWaTS-kC0DsPUutwZhzF0EucLVkKqeOpHnH_do1yRMAsZ2PgwYlg>
    <xmx:VBDWaZ4LiJIXbS4LFhGoOOpwgNhhWOCct9ywEVEPNfmN94aYWMIySRLN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 04:22:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 61b59f6d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Apr 2026 08:22:42 +0000 (UTC)
Date: Wed, 8 Apr 2026 10:22:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 07/16] odb/source-inmemory: implement
 `write_object_stream()` callback
Message-ID: <adYQUNdsmbVgZ3AT@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
 <20260403-b4-pks-odb-source-inmemory-v1-7-8b8d1abaa25e@pks.im>
 <xmqqzf3jlmnv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzf3jlmnv.fsf@gitster.g>

On Fri, Apr 03, 2026 at 03:11:16PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Implement the `write_object_stream()` callback function for the inmemory
> > source.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  odb/source-inmemory.c | 40 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> 
> As the signature of the .read() method drastically changes in
> another topic in flight,
> 
>   https://lore.kernel.org/git/20260402213220.2651523-4-jltobler@gmail.com/
> 
> this needs a bit of inter-topic coordination.

Fair. I think Justin's patch series is close to landing, so I'll rebase
my patch series on top of his. Thanks for flagging.

Patrick
