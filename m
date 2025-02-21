Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA891FF612
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740124755; cv=none; b=JmiBmBo1/FBRF0TmGS3zLMAGjofQYGOh0JRV/Y3SPiI63/POELl5n7iTnhVlME2w3G47rq5yHTxM5w5YME7CEi1GW+2v28HIMUyQOfsZ/4KE+dtiV4Haz+Pkm63ByJP5uWwvYqfBh+yA13VvvkykVAiChBEhZQq2xOdEm0lKeXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740124755; c=relaxed/simple;
	bh=G330jFFyTRwxbHNMeMdP3iEIdX+PEVAoIHStt2OGJB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngj/fO2Js74MLTzwS89XIMj5p0S2EMCZPB7N5Kp+W+S1Qr/YbtzOwdll82X4YcoG5cgB6MHg2TDV48PfXvQ3/uL3xXB/9h5xgdBBhuQ/+LKbQE1Eygd6lrQgHedOKmTp0EERTdi8IKg322cx/8cM5jD1LX5FP86DD3rmwr3vF1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OPQmjcUz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=60yZ00DC; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OPQmjcUz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="60yZ00DC"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 0733C1140108;
	Fri, 21 Feb 2025 02:59:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 21 Feb 2025 02:59:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740124752; x=1740211152; bh=zrn+zF/EkI
	vaJY6HZwS6q4j+7cmcHhd/x0So56Kxg+Q=; b=OPQmjcUz6OCdWrR8C9HnIvyYCC
	TY44gTn8tVQPrKFbCEzWsR5lgsJG6NiwsD/cavSDMfBC3myKbqK9PEuvRc9lZvoq
	tRcS3TXb1bza0c5EcS/KgBFEGYWZqFy0rArSJzisM2tVlVZV1LWoJ9mdDTuJ7yRM
	ukmrh0ZUEw2f6IVK7FlPi8+cJmXIjMFlTcnQvPTiV5D29/5EXqwmjszgZufFAaim
	qxMOk+gzGBO7xvvzM813F4biGBGVHUqq4WNxXPj/C0u3cNMkGwJ9AgrE1nnMxn5N
	vTAwbky2HOz/SaOFQF4b4qk0drdYrGwbUu7gnCHFHFrZt37R1c01+hogXrZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740124752; x=1740211152; bh=zrn+zF/EkIvaJY6HZwS6q4j+7cmcHhd/x0S
	o56Kxg+Q=; b=60yZ00DC1Ot+Tw4ODjdRAOY/em2hg6SX/rhr4bEX+r7dYF36n4j
	tRKfzELMUfTTOb6Y/Mc52YucKbpigywVI9s+cqT3QAWt7ZPJ2jZSFydKrlRKY5n8
	lZr79Bc0MAjF8F8BGt0MdSYOSYh8UpxJNBe4l+SnjvnVPw0hbAGea5Ox/0SRpHQP
	pdwVAmXJCbzMCGWOEZ54UnqZkHuPOq5cvVJwblQyDal4iogMPzN7P4q/odf2UCxi
	Nz1+Pz3HIkFh+uXD4f+cZiPPW8cNS/81p+fyLAqwEhcPNqNU63yirIZKYvCglcdT
	tizlzv01e0Rx+WBYiICGEVzrkiPGCp2T3NA==
X-ME-Sender: <xms:UDK4Z9y3oJf2N4U7sYDpTF9KP21g3wQgxs0OGY_JL5aOdKsnXalXtA>
    <xme:UDK4Z9QMZIOOWtru3k5ty2oLe-CcUnxjEkthKCO35C8e8xR9QeG5ZC4N3RFKxNEnG
    I8wQT0NT2r9BpRpJg>
X-ME-Received: <xmr:UDK4Z3VG8HfvrX3zicivIp1DnmQIZMQa102Kk2tji8HIeRje0c6ZiYn456hxMPb548JzE4zypt1qzMjk9utCGLglw1NIbmKnDn-snMx5MfecqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkuhhfohhrihhjihelkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:UDK4Z_iJWp_xZCpDuIvN5Tn64nxcTKMYiIG1cBz0S8iTYX3L-WHUmw>
    <xmx:UDK4Z_BSZa4g1ifV01PD19RMPLyAK3j30XngEeODfohJr63KrctqEg>
    <xmx:UDK4Z4KMzl8sNxlPV4m986lrQZ4AJc3FAH5-an4K8Y4D1b-CP6x9vw>
    <xmx:UDK4Z-AwpBOFpOOZjUc2-XLG1WnkZKVmITIyJhZtm7ZrGgsfvHEmmA>
    <xmx:UDK4Z2NAV5XW32mzuJjDOI7qfm_Mc0lcpAebTCD82LKQl_QZD6EDOfdz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 02:59:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7cf18c8c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Feb 2025 07:59:09 +0000 (UTC)
Date: Fri, 21 Feb 2025 08:59:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Seyi Kuforiji <kuforiji98@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/5] t/unit-tests: implement oid helper functions in
 unit-tests.{c,h}
Message-ID: <Z7gySOeGuicIOWZS@pks.im>
References: <20250220082959.10854-1-kuforiji98@gmail.com>
 <20250220082959.10854-2-kuforiji98@gmail.com>
 <c9e8a5f8-fda6-4383-bbb3-0c960a4cf86e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9e8a5f8-fda6-4383-bbb3-0c960a4cf86e@gmail.com>

On Thu, Feb 20, 2025 at 02:38:21PM +0000, Phillip Wood wrote:
> Hi Seyi
> 
> On 20/02/2025 08:29, Seyi Kuforiji wrote:
> > `get_oid_arbitrary_hex()` and `init_hash_algo()` are both required for
> > oid-related tests to run without errors. In the current implementation,
> > both functions are defined and declared in the
> > `t/unit-tests/lib-oid.{c,h}` which is utilized by oid-related tests in
> > the homegrown unit tests structure.
> > 
> > Implement equivalent functions in unit-tests.{c,h}. Both these functions
> > become available for oid-related test files implemented using the clar
> > testing framework, which requires them. This will be used by subsequent
> > commits.
> 
> It is nice to see these tests being moved over to clar but I'm not sure that
> moving these functions into this file is good idea. All the unit tests need
> to link against unit-tests.o but only a subset will want access to these
> functions. Putting them in this file means that all the tests will now
> depend on code from strbuf.o and hex.o. I think we could add the new
> functions to lib-oid.c and then remove the old ones when there are not
> needed any more.

That should probably work, yeah. In that case we'd have to rename
`init_hash_algo()`, e.g. to something like `cl_setup_hash_algo()`, to
clearly show that it is part of the clar testing framework. I think
having a common prefix for such helper functions would be good anyway so
that the symbols never conflict with symbols we have in libgit.

Patrick
