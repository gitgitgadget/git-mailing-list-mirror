Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E4921D5BE
	for <git@vger.kernel.org>; Fri, 30 May 2025 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597954; cv=none; b=kwQqDNlch+xDYou5/978EnDMm3JxxQBmZ7X5H94r+PDSJcIyWr+tkUF69us6p6xrlKG3f+5cjKTt30V4L0wN9ttjG4B3iEHcGFWNoMs2dxQ6K6ynbT911wJgINanLsaLfTYVNu4H0ZI0FQTHG+RWvPDMBWZlU1li69jahxlc8hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597954; c=relaxed/simple;
	bh=1+8FuY1EJmsoJNwrmmVyuxtEsYsck7EQquqswEfQjLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XT6Yw5db11coH48cpcGs7dCcOL/9PLeOlHVHcSuIgBtz1DAn+JW9ysZkazMCER4+pEpDJu9OD1MQfCK7iD/XjWP+BfAJwtByamFwUfncJ/9QoBZlVXGA/3aoXCdrFMdxZ+3W15GuELfPEqetk1dMelf3wOE3ABNwuws+0jAbP+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kEgr+e1H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D62Qf5jL; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kEgr+e1H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D62Qf5jL"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 95127114019A;
	Fri, 30 May 2025 05:39:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 30 May 2025 05:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748597949; x=1748684349; bh=VuPSLN5g3/
	n9JOVlXMxhHP4mZ4806HuKfP6nyGpnack=; b=kEgr+e1H9b7gH2Lrz14CLvC0rJ
	NOptLVsZ8ltuopeVeHRNEjEPpV5Yrg9sP/JKA1TLIPYQJ3OJ2j4A7a1+wLnmNLKn
	wROglWeuiVWE7gD4D/uFZ28bdta5rSNKH4KoZTOnumm60EGOqoYdqWqJ7WrlQ7b7
	rZICR3fAr1xBlFagnCceWcCKtGNF5I4nLOO2blzP6wlnCzC0DaslPmJ13x1UP4B6
	ru6e3VrKGalDqrsUxJPTlqKZMh6OsAzaGlqNH3GbDY5EtqUY1BaNT/wHTUqwkJbg
	Vyb5EMVN/GRO8gc0qD7JYay0Uo7HSUMN3vKZvXSgB4Cd6d1S/AaPar+bY5Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748597949; x=1748684349; bh=VuPSLN5g3/n9JOVlXMxhHP4mZ4806HuKfP6
	nyGpnack=; b=D62Qf5jLUUWx09gOkNi9I4+7pzbREuBGgkQV7ZuFj+ooElfTYl0
	xQej2bfYebSyvsmoKtGbG52DvmV1UC93VeCdupaqjp5hMkuv4Ke44Y3rblNPPptT
	z7+3jP/P2VaHSij6cNzxIiJg0anHTQ3HtyH/fXS2rwYyBiVf1FHY9fLGJ5FS93eU
	txei1dkyZqth5dtJVuv6zfucXGztpOyVamF+D/h7W7NHxAO0ZneNF7BwOsJsWdWb
	pj/gIOQpzt+FHg55G/TVExaohjOiqyfCBYcRKZ3VhnNRawMm4uKnynFYJgzfkYaI
	RDljz2IhCydguuecCacCqmu4gKO/c1jsNjQ==
X-ME-Sender: <xms:vXw5aG_x53dnv6R71RqaPGPC9rrlLZtMbyEZ7D1gBQIHbEw5fpIILw>
    <xme:vXw5aGui9Yxh_Wo9WUXvXtHXiGL5XKhCjXN92MPmd8-kJzAlS3KaEsGSL1JlYhJjH
    HnxVN6MuFPZ_8-XOQ>
X-ME-Received: <xmr:vXw5aMChhjCevIn6KisU_68vCgECXQgCuy4W3b-G-7bqlZ_8Q1n7RTIhr0g_PyDPVhPOepA1KwuxffGvc7R2ROVuEwfHm-jaKYU4wnJX0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvkeeikeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtledu
    iefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtoh
    hlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:vXw5aOfKiICYGfaCw9EqzulNIGVIiGhVHowVG1u2Xl1K4ITvZv_tew>
    <xmx:vXw5aLOywTtOk0pGZcL2B3HnLKlamIkoj7FzA67y1YMcBcPsXNMSDg>
    <xmx:vXw5aImE8O8O4Yw9k-JgHLbtDcyTx7ppVI2AhNuYbxRt5UNSav5X3Q>
    <xmx:vXw5aNsVZa-iXBU0laQexh3_fytl8quUpIR7Xs-eS18dgbSsjHIEaA>
    <xmx:vXw5aIFRE31oXnHF6F5o7W7-ZbMxfADeUZrG_k7NwfyOucq6h4N_RwZa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 05:39:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 57ec9bdf (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 09:39:06 +0000 (UTC)
Date: Fri, 30 May 2025 11:39:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v3 02/17] object-store: rename `object_directory` to
 `odb_alternate`
Message-ID: <aDl8tnjQsqXEy8l-@pks.im>
References: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
 <20250514-pks-object-store-wo-the-repository-v3-2-47df1d4ead22@pks.im>
 <tjsbotrnrffykmi3letktpb3bly4nqw4wxzyrszgbln7pznem4@3kwiq4zvaebw>
 <aDP_-VX_Rz-MqiAS@pks.im>
 <euflgbipchqi7jvmz4yzwzx6ao5guen6xmupkdaubjbc5ksgkp@aheynye35bby>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <euflgbipchqi7jvmz4yzwzx6ao5guen6xmupkdaubjbc5ksgkp@aheynye35bby>

On Tue, May 27, 2025 at 11:45:14AM -0500, Justin Tobler wrote:
> On 25/05/26 07:45AM, Patrick Steinhardt wrote:
> > Furthermore, we already do have the distinction between
> > "local" and "non-local" objects, which translates quite well into this
> > new naming schema.
> 
> Just to clarify, are you referring to how we differentiate between local
> and alternate odbs? I'm not quite sure I fully understand.

Yeah. Non-local objects come from an alternate object directory, whereas
local objects come from the primary object directory.

Patrick
