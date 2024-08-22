Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6861757EA
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 05:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724306250; cv=none; b=lOTEz7fJYNB5i9nJlDEYGQzaz9KNXWsfUxHd3Dd3YtOEoc4BwCodqO7JnATXfFfoSJqdjtMYoQkS77ITCQoGPB+RNlN1jXrSKSSt6NxFNSYb1orEiXhkczMoz1sRgMwsYnpzH4PZhPl9HfnJw6v9z/RB6QFuSYxKjhlmAGFXSKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724306250; c=relaxed/simple;
	bh=ycfulgDuaYi/izldoqRONyX0JLlzNQNFuok/Q4BAXck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lD+wm/IqpJBcFWPHYI5lEyIWeUkJXOALCVhmvkJxBNKuMqhfCX8Y5yhh89AcqGMIDBPq5TiABOyRCfCSKeZkqSNcP/M2mHIWKbv3+hNctt1ouekOMLQy4diutlmXm68x+PpmRwJJ5Q1tnGdKlpn6UiHZ7Uv1zd+XFtLCzx5V25o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YK+St1+B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WCS3o36t; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YK+St1+B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WCS3o36t"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id C1049138FFEC;
	Thu, 22 Aug 2024 01:57:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 22 Aug 2024 01:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1724306246;
	 x=1724392646; bh=l59kyfXK3/1Ub2t7up2KKEqHh4oA2owpjjNNL2gzwjw=; b=
	YK+St1+BO9UDep3WE8hxQARyymgrR7FmMTNgLdvnS67GSjal+BcGl2qynjG86a54
	ceUbltlyDYyLnoMjsxmy1hAdiHCUl2S2KtM9KCED9KSlG7lVSYz7hAAh+XG+P/Xk
	/+ALOpC90RZFAQ6CiR4pObj0RmgD4ukubJQPCN/QGo7Ly1qGp+V9q3Yaus4u7SEJ
	xs/wTmc71UwGyIOSAEMPuwtdhzzm6scTjpweHWbmawvWxWtwWP1UJ7WXDMjAOq5P
	LSsZQXX/2LCEagZ1gswXguO3tVpRQnKmrSv3qKCyXGeNvYG0dUuSTijzkvBlRwVT
	aAJT0I2ExxTD9R0RQLrSMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724306246; x=
	1724392646; bh=l59kyfXK3/1Ub2t7up2KKEqHh4oA2owpjjNNL2gzwjw=; b=W
	CS3o36tCrRB+JgPCgypDQpq9yv0x0ULFj3Em9hcmClWod+IBjtMw+9OOL9Uey7GH
	JD7xObHL7+T48hVg7FD16lxMpJU4I3bzuGU4sxpc/kAPMT5q17B3cksEjrGXHzKn
	mfvelmmyIwwEupDEAcPnG5JE9EspT1DbgWMhbHi/PbU97Jm53ZMMZhYocs5oGXjF
	cyvmxiWb6GYje5UA18xOcVYmZtmo9MPeC7ZiXsGdycwUK42xLi6FGBCZuwVut3Tr
	RK4MGKsQgV7hOS/LAbiMxxdHW28R3b1oeTNE39laMfXaRO7qTKmMPbVzFGkuvwkZ
	gjM8exPxJb8PNJdhOx1tQ==
X-ME-Sender: <xms:RtPGZvLGpB6Jdoe3G6szzRhbIFpJNbunTLcavDc72BtTSFYiIArhyQ>
    <xme:RtPGZjI99KHSP02hZ0OKkT71a8i-E505giBRyS7gaQ8-yMoeHCutUwWsVRGPSGYw_
    0gbIifUg-hxfnARxQ>
X-ME-Received: <xmr:RtPGZntScSHrXS1yl-PQlR0IrzpI3Opx0cBH9d8_IUlUIFi0XOIzQLJuG8fbnt931AIcCN4c1NO9CCyKsn7xaB6EcrRV4jLCDhxrmelNne1rLJ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduledguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedvfeejie
    dtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmuhii
    ihhmuhiihhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RtPGZoYMogVC7RZFUScZLCynoJeHcRGjOWh9vzQVPoRZ940aPn3W2g>
    <xmx:RtPGZmZ9C_kjvlwr9HflaDvIUZ1BbN7y5JRuOPSiN858CKvxSPYrzg>
    <xmx:RtPGZsCkfOu0HcQptsGEUgm9HRpqt7WKlhIHQDX350v-HCowLgeMGA>
    <xmx:RtPGZkY3tBNxqdHyDBTuJSoGMCCRCCBgdFCVIBjMSJbGbzmXwObPUw>
    <xmx:RtPGZmHizLoxUggg-dTazp-9EZU8-gsRacXmEWcqPOgxMijb9sqFEGbj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 01:57:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 104c4965 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 05:56:50 +0000 (UTC)
Date: Thu, 22 Aug 2024 07:57:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Yukai Chou <muzimuzhi@gmail.com>, git@vger.kernel.org
Subject: Re: builtin/config: --name-only doesn't imply --show-names in "git
 config get"
Message-ID: <ZsbTPeFIPcqnEd-n@tanuki>
References: <CAEg0tHTWzgD5bw3oK7-Rtv9oTymqyhvZz3bcJ7yNRhF8wXMLGA@mail.gmail.com>
 <xmqqttfd2734.fsf@gitster.g>
 <CAEg0tHQVK9hgcHTzn-ZPdwoFbbYFB2joeT0jLQgtD6yEH+1GiA@mail.gmail.com>
 <xmqqttfdwq0w.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqttfdwq0w.fsf@gitster.g>

On Wed, Aug 21, 2024 at 01:59:43PM -0700, Junio C Hamano wrote:
> Yukai Chou <muzimuzhi@gmail.com> writes:
> 
> > Junio C Hamano <gitster@pobox.com> 于2024年8月22日周四 00:07写道：
> >>
> >> Yukai Chou <muzimuzhi@gmail.com> writes:
> >>
> >> > # get empty line(s)
> >> > git config get --all --name-only remote.origin.fetch
> >> > # get lines of name(s)
> >> > git config get --all --show-names --name-only remote.origin.fetch
> >> >
> >> > Either the doc or the behavior of --name-only needs some adjustment.
> >>
> >> This argues for making "all" imply we need to show the name of the
> >> configuration variable,
> >
> > Sorry can you elaborate on what that "all" meant? A new option "--show-all"?
> 
> Sorry, but "--all" is probably a red herring.
> 
> What I wanted to say was that we can 
> 
>  (1) get rid of "--show-name",
> 
>  (2) have the combination of options that can emit values for more
>     than one key to automatically show both name and value, and
> 
>  (3) add "--hide-name" so that such command can still show only the
>      value.
> 
> where I mixed up (2) and "all".  In fact, "--all" is not something
> that gives values for more than one key (it is things like regexp
> and urlmatch).

I wouldn't get rid of `--show-name`, as it also implicitly brings along
`--no-show-name`, basically checking the box for (3).

In any case, I agree that it probably makes sense to do (2). Unless I'm
mistaken, the only case we need to care about is `--regexp`, because
without all the emitted names would be the same anyway.

Patrick
