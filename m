Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0777F2C80
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726226470; cv=none; b=s3G+Nc5naid9ybTsB1aGbplcOqnlEcq1PLhomdLB06a4qnQ8nLLbNsQ3b6AODKqGYj74GRavAbiR74VR4S6Uqk+6Zvo+OmEkzr/yldZIz1qsMSe9mx6l+L5nAel8umBWLVvcG+vSMa+v/zCEagoxU/LKAh3LnVEghWXB5r01QaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726226470; c=relaxed/simple;
	bh=93lHXu7wH/rlcrEReyN0qxiKoCWaF5j+aUqqWX8/VCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMciE1tUcywuyTsttrnv8C7w5WHPBTi2n2aoBDuCOVXXO0WuMUTcBVuPFxzrPCxy2Kzcx/RXGQHwjonLaAOijy+/BtzFY0iOUxBD4TVMgcRih8+ESskzIFnYDMQp7LTKxKiB3BwH5Pzt++FvKrTcofkwq9kPoLUQWhyC+FZbNxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=reTF9Jcb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HX0mwVYj; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="reTF9Jcb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HX0mwVYj"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E17E5114027A;
	Fri, 13 Sep 2024 07:21:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 13 Sep 2024 07:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726226463; x=1726312863; bh=aWNVVk2ram
	L3oiB/ufMTq5u3iMkGHU+1nOL1uQcmtDY=; b=reTF9JcbkrA+Nry1QELGfiJqdQ
	wtivzGA7jsS8z7XSMdAgfHVrBm6oC48djQbcdCbM2/C+5LU0Bu7rLOq3+ceCyS5e
	dgedhDAQiZ8WenyI4wAty19sekO8Fyi8B6xZXfanFlMh5c3y8TZEqyLrDKBw96fx
	hguYe1X06WMb7FgnSlLqaIbQw/zCFCnsZvcaPJVLwQ2iAFt2RCjD/cGyMYDU6Ovb
	V2v/H0GzDVAikcwQ4nQccD+9MNi5MpcOJ1R8ABIzyy3GL0gW+xkeNk20ms0ki7yJ
	rGhjMTTl6MKbDmijLuvxM/sgFo0vk6hdgD9+T7SPbh4s8PrtN5BZz1+a9+pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726226463; x=1726312863; bh=aWNVVk2ramL3oiB/ufMTq5u3iMkG
	HU+1nOL1uQcmtDY=; b=HX0mwVYjhtA7M2zPUaR62V+vhsjz6ljI7BHW5g/n8k+h
	q8DCwUfSwawuNvPEJZ4Az9eRUcPWFRlzP0R3oz0CjOyFOKBaPWo95QSiSixyQoWN
	a9KLBLtBmRaboDpRwqNzF1cqftVz024d01WeTLQNn/beR/kzqLR8Z53xUbEWAxKm
	VxPxSTPitPhX3yEGNZHtwU62yom2vHA9UWojRtfJGsfv96/oN0mj60W90QirlpZ2
	MDUrW7mA8UAQLmD2hXYXBcMFSCOWYG1PkM+rCajeV7DOGJrK4buJbN6fJmOqb27/
	sbsuJdNpfsuLqtCcvqPKnDsOYP42Vzajfa1h1olHTw==
X-ME-Sender: <xms:HyDkZtPVkGPOeEH-l9kaRFTQXsJGFjEPAYpeREcB6BOK7PzxgqbIeg>
    <xme:HyDkZv-4QOXBjwn1vsGyexw6JPwugsOqNIBG3W47YJrETTcqeODmgDgP6YFSwTnZa
    jW9JljDJMRMEXlj8g>
X-ME-Received: <xmr:HyDkZsQ2OGedcREZHQ4awpAWJGbXs587CdtewInslOSVwZg1QOMJ8nF-fm1dp2uW7rW0wMPCHn-1eaCEyP9_VOy2r6pnWWuk20jXSsDNghnx8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejjedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfeh
    tefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehhrgig
    gidrshgv
X-ME-Proxy: <xmx:HyDkZpvVti1RQwOSHm9DMyk0TyJUHD2QgdOUUnpVn2qmZdyBWUfq4w>
    <xmx:HyDkZlf56UsbzFNTycZTb-ys5k9Rl6xYyhX4In_-YGSUBojRzibNIA>
    <xmx:HyDkZl3wvVcq8ShQcH01ijK605htfoh627KFwMMx41LFb2_0QqHl1A>
    <xmx:HyDkZh93LLB5Qy35Hd9UhHifc2yKz8cgP0mSujm2kSBy5RsHz1lk4g>
    <xmx:HyDkZmo6ZOoojSAN_wBcuwuZS2DFyhjQqfXBqeqZV_-rcHYDb4W3vDea>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Sep 2024 07:21:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 70d23c1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Sep 2024 11:20:49 +0000 (UTC)
Date: Fri, 13 Sep 2024 13:21:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Daniel Stenberg <daniel@haxx.se>
Cc: git@vger.kernel.org
Subject: Re: curl 8.10.0 regression breaks uploads with HTTP/2 and
 http.postbuffer
Message-ID: <ZuQgFVuokIQs2ZeF@pks.im>
References: <ZuPKvYP9ZZ2mhb4m@pks.im>
 <q7soppq5-nsor-4qq9-801n-oq3461n3r889@unkk.fr>
 <ZuPdfsbHwjQPDPXc@pks.im>
 <565691o1-3451-o06o-2594-2750r90nqq6p@unkk.fr>
 <ZuP168QTTMiv_DxH@pks.im>
 <o8o7sn01-p918-34s5-387p-pprqo7499p8s@unkk.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o8o7sn01-p918-34s5-387p-pprqo7499p8s@unkk.fr>

On Fri, Sep 13, 2024 at 01:04:57PM +0200, Daniel Stenberg wrote:
> On Fri, 13 Sep 2024, Patrick Steinhardt wrote:
> 
> >  - In there we hit the `large_request` code path. We set up
> >    CURLOPT_READFUNCTION and CURLOPT_SEEKFUNCTION. The callback that
> >    uses our buffer is the one set up via CURLOPT_READFUNCTION, which is
> >    `rpc_out()`.
> 
> Thanks, I ended up able to write a stand-alone reproducer. Stefan Eissing
> wrote up a fix that seems to fix the case for us at least and it would be
> great if you could test this in your end:
> 
>   https://github.com/curl/curl/pull/14895
> 
> The actual code patch is tiny. The PR is mostly about adding test cases to
> reproduce and verify.

I can confirm that this pull request fixes the regression. Thanks a
bunch for the quick turnaround, highly appreciated!

Patrick
