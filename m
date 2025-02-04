Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D49770E2
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738653394; cv=none; b=bKNLivxcbCSzwWZyCSAYEhVZvcABKKa+Re301hJGJ+aCqrfXCcGFr34yc6yka4xDeEaFnS+8umvyCVxbb0e9brClX2b+ZpSfqhIGBKfVeCNZXTD8p0xmSNH1q7Dv97BG8tNbKrJCU1HuUqN5VnqVi+XBf1B1czz9ZBR0U88wvuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738653394; c=relaxed/simple;
	bh=Z7nsSDjhZGtxYxt1SxCVVnInilW6exzfBshyxtDltBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNp1TnV13UcBae3kXXk/MGqxfMyuKdM/7SpdOcpOSwyzIugxydd+pFwYWJmTIvhfhcwAqJN6vw9zz3QBmkf3tlDMIo6ZRtmvSstaRbbR4DeIzRIvjFT3fYs/23UmpGtGs6pCsNEGxq8Ik8mr09JGxgs4J4pU4eSytRHjw7Gkkes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sNkOw6g0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j/Fk2Bs5; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sNkOw6g0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j/Fk2Bs5"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 0459F1380263;
	Tue,  4 Feb 2025 02:16:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 04 Feb 2025 02:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738653392; x=1738739792; bh=jOCk6xr+Ix
	mjH+tXL1Xs584A5vtWPWWRnPNasAprPFs=; b=sNkOw6g0PIcrGof18Czydfd/eS
	+V5gnHX2jCs2YNepO0xQHGEMnDMmJprJtQn+KPCnafqXgohvzAILCNZHgTpVjsNP
	Z74X/DIFNZzMmjipUdoiZyl2eRK8+EeYrQAS6lB2OMKk0s0nPiohHECtXjFRcWh3
	PymnEtHb9k98CQTILtIYvkN4bxaD0AdRmsdURHqZ3Ww86kt5Ci1Q/5doW5wGx+iu
	DJQsVVKRHI147Wesp8H1pB3v6WhxWsttHNUZ/puf+RQAZ1BPdAEi0Tv58M7hEdR7
	S5CexeF9223coVQWG43LRGJsKGdreEMhvnS997qHZiOyIsHyqajsEA+hgOIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738653392; x=1738739792; bh=jOCk6xr+IxmjH+tXL1Xs584A5vtWPWWRnPN
	asAprPFs=; b=j/Fk2Bs5BtqE4k8366yrzRh6Va9VnZ3rC3LIxsboBNL8XR3xdn4
	/lUNENBzQ07hMopwpnqBDxPvs/ovbOzukUqAcWpw39lzCNE9n3kUMqhrGOZ7nrl7
	RqjVEVurTAUh8yD/xek6yfzrr253KH/sue/fmdVh8iY5Hde1RISlAtFP2R1qtZjy
	CM9adVTCHpZYgCy02IVzpOS9p0wqdnPytBwhEPCOEcIxjgNLm1DlfGJN5G/nV2tJ
	pwNRXbpWPBUQFqGd4WZpQRaag0T7yMSj4Bp5pz2Lz5rJw8smrETa/1+W+muV9RmS
	n6rtCj0CUb8HvGFd54aWunP6UfzdL3AUU9A==
X-ME-Sender: <xms:z76hZ6UF2lUqsGTLSYJjBLQmfNtMuQEcusFd6vM1a8H0K80KSuussw>
    <xme:z76hZ2nB-AD_TGlQDmdEFI8VJHaDFdEuKKsgzsyKoIAOxucVlk74s8HcMqqGdzQ5N
    kaptyVNMLr6eIiCZQ>
X-ME-Received: <xmr:z76hZ-YH2zkLbKO4KinfJdQJkkWeW2JaCvfhGZq_-5ytuz-PWZGGYAo36tQmCBODRk82KShowwsQ-OXCrDLHpau9PvcnoTSbNh5z0o8lNdvSXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvggvthhsohhniheftddujeesghhmrghilhdrtg
    homhdprhgtphhtthhopehshhhusghhrghmrdhkrghnohguihgruddtsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:z76hZxVtRmw7nAqbhIS7lQh91wk-_--ROZ8z5Ms6qqu1csLZS6uiuw>
    <xmx:z76hZ0kUnWE6RTKsXybq50qzVNiF57NpYzLh-H6wtTSdAO62cyGHYQ>
    <xmx:z76hZ2fVTTJ-pqCvtUa_sTpW4-TBHd5sz6kRHBvp9JaK72n7GbxpJA>
    <xmx:z76hZ2H4b9hltx9GU1LW9duqrURece_jpR4CYFup4Q5GrVMDCK1Jsw>
    <xmx:z76hZ-jgHopWT9IpzI2K9uwqpn8dANTFYe4HLr81SxbX3XECIP7uCTMg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 02:16:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6944e13f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Feb 2025 07:16:28 +0000 (UTC)
Date: Tue, 4 Feb 2025 08:16:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, shubham.kanodia10@gmail.com
Subject: Re: [GSoC][PATCH v4 0/5] refspec: centralize refspec-related logic
Message-ID: <Z6G-toOJjMmK8iJG@pks.im>
References: <20250201064202.76116-1-meetsoni3017@gmail.com>
 <20250204040558.34766-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204040558.34766-1-meetsoni3017@gmail.com>

On Tue, Feb 04, 2025 at 09:35:53AM +0530, Meet Soni wrote:
> Changes since v3:
>     - updated commit message.
>     - renamed functions as per review.
>     - added GSoC mark , since the announcement has been made by google and
>       we've started the discussion regarding the same.

Thanks, this version looks good to me!

Patrick
