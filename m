Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D89E228C99
	for <git@vger.kernel.org>; Fri,  9 May 2025 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746789926; cv=none; b=gFVTc708mGNrMFCkLla9Yp1wQ+m15S9YEUC/62dX9ul0WyVUKAM5/X89Aq6r8CETOs0OusNldpSTVprXKM6r9XIXRzcbS1Z12kvaNcEQc60dJt5gDIpIXjfUBwSqN7CUqWjDseHuIPkUQPMDf2n2uydzrNP7nBsUpj0IX1LjbIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746789926; c=relaxed/simple;
	bh=YQJisEbLmEokXdYCH3Mq19qsewhcNtzivekSDQ0Ii54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuv4/1/SUkY7+cclOUHFGxyyCnkgIK60UOzKcaPX1ARleXB25a/Lbf0CfDrTOu3gGx564glfeCAgdr08hQc0fvHfnE680yIag8721PUq6AC0EQNyVHTow8soJl68J5ko8OnF6kZLa60Rc2Td2LXM4/DhHHLf+iQm/XXiw79Tjxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XctR23yO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FtC2rvYl; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XctR23yO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FtC2rvYl"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3F93F1140147;
	Fri,  9 May 2025 07:25:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 09 May 2025 07:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746789923; x=1746876323; bh=ePQaNdr91O
	sdIiYT2R7QxpJiXQjpS1/gRH92C6eFTtA=; b=XctR23yOwQcYWsxI6835g4T02z
	Y5voPDUM57KVF033TS/5kDtxWE5l+j30R5ORQWTu9i0rNsyQto2m24+Oq1F0yTC9
	AKUB7QKHMxbbQEoXXfksaZALAbvKuLZqGSitUN3OVaf3EXbdRU9XrIVDXgUwdgDo
	pyRXu0tdcZoXTevnmEicslm06//6FbeGS76yhREeKY9dd7w3ezsSeZ8Tpm6lJFVw
	Nbx5D9HAGOnauCnd71CugsCL8fTL/qZ+qcn4ZNB9jrs0xc5vct/ErX8jz5p41gzt
	IBYIm6cWPRlJIq5E40ZpqSMOGs6eTWnov31fr2cO/Hx2U6H/Ba5BJhrN6o3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746789923; x=1746876323; bh=ePQaNdr91OsdIiYT2R7QxpJiXQjpS1/gRH9
	2C6eFTtA=; b=FtC2rvYlXDKXLZ5UpWAkhnjSMIQW2dpxz+oTieCq2muIswIF+VN
	qDCQhGuuaWgMXJJnZ+F5UdMMEZNemJVodaeXRoZfe0Pb0sRhrgY27flFTpNDbKFL
	AaFdFzcWIWSbHbKI0xovFxgyAB+DU/G/510vQHu6aF7FqoIWq7VMgix4KRShKHoc
	HBdWE8uhWPH2Nw8PXFWNfStTWRJEdQrIlaYEgK5mxTFQyfg70KTwXZb65A+EJExK
	4fx88oEdjsjx2/8IELDQ9g3CE8m8b6LNkin1eRoZg2hADG3KzZWE2uiwgTDEwKS5
	bkEzrKt9QBtPPwIRHdskoeiv88k6TzSHDug==
X-ME-Sender: <xms:I-YdaKI5hcgc5xcqrfU9igCCo7FwfnK4qmeuhKNOT7msfUOV7Jb3Og>
    <xme:I-YdaCIyz_dVYXd2X_eXNwiAnH62EgHFI3MMsxs5zugYk0e633flB07jJhs1Bl8KW
    X1diZTT6NfVb_hZZA>
X-ME-Received: <xmr:I-YdaKs8-1Qq_7g-j13LlCheTulvYTt67oVIVEsHCa7qXFYLJeLGwW8poMjKAJTu-NeE1z3tC7aeVt0-JXzN2yu_ToNWIXBtCgC63CmPZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:I-YdaPbiAWSgAeHYdXUn8AdPxT-8i6K79j_MAgnhzUtX9X6-AVS7pQ>
    <xmx:I-YdaBZrwhF-X1_7VqNF4Z7TcL0G_YdhqzpHOEvTVklMt7PEP4xusg>
    <xmx:I-YdaLD4K4nQgG6SihtTKlYyjgRUCfv1i7NMluK2JL85XR9OOjS3Kg>
    <xmx:I-YdaHaUBD53h_MbxKTnrHpbXmYOXckGCC1WxJV0zyUUT9h3Fcqf6Q>
    <xmx:I-YdaI1Z2vlmrcTZxmv8Exgm_OA723URsDokrwbitQ6qbkxiqLJzF7jR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 07:25:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 410aa551 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 11:25:22 +0000 (UTC)
Date: Fri, 9 May 2025 13:25:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/17] odb: get rid of `the_repository` in
 `assert_oid_type()`
Message-ID: <aB3mIZaniXI6zkH6@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
 <20250506-pks-object-store-wo-the-repository-v1-7-c05b82e7b126@pks.im>
 <9cd68129-1166-4f80-9b89-8f12c9d118c7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cd68129-1166-4f80-9b89-8f12c9d118c7@gmail.com>

On Tue, May 06, 2025 at 09:12:34PM -0400, Derrick Stolee wrote:
> On 5/6/25 7:09 AM, Patrick Steinhardt wrote:
> > Get rid of our dependency on `the_repository` in `assert_oid_type()` by
> > passing in the object database as a parameter and adjusting all callers.
> 
> Oops! This patch has the same message as patch 6 but is actually a
> different change, removing the_repository from odb_mkstemp():

Good catch. Repetetive changes invite copy & paste invite errors.

Patrick
