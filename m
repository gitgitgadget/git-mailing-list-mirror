Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5710EBA34
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 06:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738562709; cv=none; b=RkcHKDlbObM1gGWCaRiHLzyXyCSctWHqcvnVO3E4pa3mx6KSPXug9QXcwiVtXoIOLLLXmm1Q3pEXZAEhPhUyG2V+TGH8UpB3+tLpzz/RExyfGd3YHmN1QBFTB5MM0IZjDQ3gRdkWThAwDNFmhCInQCByobt459U5m6MT4sLLLzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738562709; c=relaxed/simple;
	bh=wYK66iSh3cLey3g3AjhJUf/XM+Z07E33+NykH+KVViU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXSq9jt4+L6ueoLwXKCRV4/gDf7qSUHaJeAL25XyOF4vWaibIRr7H4DCLRc7fmN+HB1OeCINjCfaHxheklQWGzhPqznwL5UawLL+e4NH0jzYpb4bCGjMZ0zxgi1S0DQBn0NOgppqt6tE/Qvmo8t6QQ4SgYVvJWexqC1CY+KWNhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d8ejCgZ9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ovXOxMy0; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d8ejCgZ9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ovXOxMy0"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 2804A138014C;
	Mon,  3 Feb 2025 01:05:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 03 Feb 2025 01:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738562706;
	 x=1738649106; bh=PE1Rpid/oFemN6O+Bh3O0ANsLBJJ9zU9RdNYdvtvpeo=; b=
	d8ejCgZ9vuL1mQdcZmogt8v5L3OK4pNKk3bbEahXwUQx/OE4oSRnC+gNSr70q8wv
	kU+6jQztEhrcd6Pzoq6fVQifGsdUhYn2rbRsoM8uLaNYJCaO+9D/hl/DdjVyLcTk
	FGG+T1FQaXkogosUGcNfWDajQQfv1t/0K3Ia4RldN6zkLWdlKmw6a2YtUE4ijzja
	kUGrJePtBwl8+AK8EtVWhDCCjadHrkKPFNe7TbT9CripIKySVmY4axXHcnanmSRK
	/WxRKmba0shPqhaGdy9MTZMM9E4k1eHfU1KnW7NjbSgkjBNbhpzF0WfHXhNV5fkM
	q9osSGEL3bg9Hjg7E/6C1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738562706; x=
	1738649106; bh=PE1Rpid/oFemN6O+Bh3O0ANsLBJJ9zU9RdNYdvtvpeo=; b=o
	vXOxMy0wSUZ6Gc237l/V2t9l26f7bxBFN9fhKyubIS1ej7mP0tRrLi0i8KTzG4hG
	7jph2uy5Ez69nezGYQPLaMKkMDiWXEyBqXi122nSQjePaMNjlSwUvkj6Z0A3IQrL
	ObQBpNnT/HyLbvuYt0g907Bgk9IgMxT+tFD96UGbN7bUbZ558qW9iVkfJlWVug9G
	1tyZBqZxX1Sw8hdXNYJvmmO+AtxLZcAqlWhvG6bkCyb5kR8fQMzragYyiz4wO/K2
	pzJSaHLGnSMDhH4llroyNS70uVcIpP9f+858lA1ruvi+x+29swVf03Vzw71ZtwY8
	q9py2iiAx6ouXIQJlxOEw==
X-ME-Sender: <xms:kVygZ53AdCX1X7kDbn6F4ZgrYoS56YlB9RY6oDtM_S5_J3-b5ElA-w>
    <xme:kVygZwEtddZ48tBJacPsxG4Iesaut0zYrLvTSxHkPC1zkoCbR0QJLxA5pWkDJdjSl
    gqb8AlKf_qbrT0j1g>
X-ME-Received: <xmr:kVygZ55nn-hygsMp6h04rR_eMrP2VNiHGYiMB72DJsNWnVgpdmWfjKhgNrB1ptlGmvi6qC78a-9_-t_bhEk3apQelIoxCNfMzX7w6XvIV1siog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdev
    teffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtoh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopeiihhhihihouh
    drjhigsegrlhhisggrsggrqdhinhgtrdgtohhm
X-ME-Proxy: <xmx:kVygZ21-ghGI47JcYOSP6gXn81qqVKQzwxtirut6z0S4OXT8N7p90Q>
    <xmx:kVygZ8GG5QBMmwuqtt70B7KTf-us2nEEHNaaqE259HQpRDBu06Kjmw>
    <xmx:kVygZ39inrFtTdz1oCmnricQP1qxqGUU5OYUGSuNHqfnKvUwgdz8CA>
    <xmx:kVygZ5mbn07Zdts5RSqO7DfAeV7nyk8MddzaK_cpr8GNVIQK62US5Q>
    <xmx:klygZ4ikRR2LmMpBGUJg10KU3LSWffd5LQbfPZXcViURdZFqWItlDP6k>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 01:05:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c70d3a8f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 06:05:02 +0000 (UTC)
Date: Mon, 3 Feb 2025 07:04:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Jiang Xin <zhiyou.jx@alibaba-inc.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/8] t5504: modernize test by moving heredocs into
 test bodies
Message-ID: <Z6Bch3I1UvL-qTcQ@pks.im>
References: <20250131-pks-push-atomic-respect-exit-code-v4-0-a8b41f01a676@pks.im>
 <20250131-pks-push-atomic-respect-exit-code-v4-1-a8b41f01a676@pks.im>
 <CAPig+cRnm9z06YsCRyTJGqTCF_208BuD+3QoEKqwO7eWTfesAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cRnm9z06YsCRyTJGqTCF_208BuD+3QoEKqwO7eWTfesAw@mail.gmail.com>

On Fri, Jan 31, 2025 at 09:28:01AM -0500, Eric Sunshine wrote:
> On Fri, Jan 31, 2025 at 5:53 AM Patrick Steinhardt <ps@pks.im> wrote:
> > We have several heredocs in t5504 located outside of any particular test
> > bodies. Move these into the test bodies to match our modern coding
> > style.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
> > @@ -64,12 +64,6 @@ test_expect_success 'fetch with transfer.fsckobjects' '
> > -cat >exp <<EOF
> > -To dst
> > -!      refs/heads/main:refs/heads/test [remote rejected] (missing necessary objects)
> > -Done
> > -EOF
> > -
> >  test_expect_success 'push without strict' '
> > @@ -78,6 +72,11 @@ test_expect_success 'push without strict' '
> > +       cat >exp <<-EOF &&
> > +       To dst
> > +       !       refs/heads/main:refs/heads/test [remote rejected] (missing necessary objects)
> > +       Done
> > +       EOF
> 
> It's minor, but to make this conform to modern style even more, it
> would use `\EOF` rather than `EOF`.

Yup, indeed. Will fix, thanks for your review!

Patrick
