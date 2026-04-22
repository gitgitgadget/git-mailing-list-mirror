Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467742773F0
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853843; cv=none; b=qzuXs7klxhaQyBqunPqniOzcyR7WDOJ48orMjJAz5vIXwDxGHeTTY0bnaJFH4LvjqecMBFfAYHI1bD18xqQfSGdmAjO38CZ+9It7KRR2WlBw1VMen+iU7iW/pftx1X6WL8AoxHrcOrpcq/Ze4g9drYRQATBdvMVuZKAhzMh7XGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853843; c=relaxed/simple;
	bh=XzRBM1eRdCnUlBUC7TL7aHePbzTVmFBw1bnuMcZBL88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3Ex+T2fX6xbRV095wQ0Uij6QLS1vOb0fQ4c11EqPw5TSNyZzYcikzQETHD0q4OMJbvDLYKZfkYZbxfaSV08zEgVlPOO9kz3t3gEomNzEqmovbsgwYwgrs8ANhCr1KPR9SpEcdNwkl0P6tNjh0xaCaybklrpye7vPsCHkk+/P90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q7Xf9Rgk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o53xEe3Q; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q7Xf9Rgk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o53xEe3Q"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 814557A0208;
	Wed, 22 Apr 2026 06:30:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 22 Apr 2026 06:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776853841; x=1776940241; bh=XzRBM1eRdC
	nUlBUC7TL7aHePbzTVmFBw1bnuMcZBL88=; b=q7Xf9RgkVe+6kzl13oVmdqIjBf
	sdpiayf2hScwLmH94h8I2TKR2Cii4Z4hvPbBFRiAaRykPCSBLx816QnruT0ehoo3
	2XjeGPtcZ6Q+wYOOnLV1I2bMMhJqjnigYAFR+6L159hWDSQ1ZPL65G+9AUzvjexW
	K9M1BXqEtDCFz+HEjy8tgBauiOqLeQY2qL/yS4dnF2eXzdDg2/UIgUO5fI5BvOzj
	A49WWUErofET8tz056oVP3Kc66QBpnQA0nYNzyqnU6lffS10M9ecUKQkgnMc+cgj
	GGDjABdBZSsjlpPrcmZ/SFdjqcjnBhEiFxoKfoOgo/n5C9dRFrNb+tLqZ+oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776853841; x=1776940241; bh=XzRBM1eRdCnUlBUC7TL7aHePbzTVmFBw1bn
	uMcZBL88=; b=o53xEe3QC4n7uWfz0NLa8f9e/RPHV9V/diganRqCdVaT32g8PaG
	+diJ2BxrYjVq+ds0TjVFmlbgQGStojoiPHHiSPPtOT7uhVb7qAFERDVSaO1wRaKz
	0+UatHsczkAgMNSl1VIYIyGF6NMT/Msv2hvlEsrLacARQQMZNK2XH6LNdz2puNL1
	mmmb+QwT0yothlfFl2Bn2U0Bb5mWCbVx2a7lfjNjaWM3an29pNuLySTrEUihBRVT
	fLe9k8Bxzc0LaJ21t1MwmtuuOJGHVJLZQs8wxVpc1cn+wWUm+dVaWsP05UUkASxZ
	cBFA7svb8MO8rdLNLA8v4ZSsVaSQZTCXIXA==
X-ME-Sender: <xms:UaPoacAvACSor6I-ef9I5idykB88apcgFXjv1S2K4eHI2QuHtnQeGA>
    <xme:UaPoaV_MzLU8aBd_-Dct7PKFW8V9ZyoPWwzHsaZKUO5ML0Q6BDOkdpJZCSmj2ia5n
    ra1U_n-DXTcm4eKZs6baMi8zpWzAa1G_HyTKn3XtxbwMTBrPE3oriE>
X-ME-Received: <xmr:UaPoac9m4mVh8lirPhc1ASLaKWiKpb-_Cfz2Z1jTiZUpZrHQGdfA7MskfgHk_7EeqS8e4O15cPImE9u9VCODAZJ7_qbFpwl9QIPr8a_8TGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeigedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejvefgudduheeihfefkeekgfetjeektdfhjefhteelffelheegudeijeetvdetheenucff
    ohhmrghinhepmhhsghhiugdrlhhinhhknecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpd
    hrtghpthhtohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UaPoacdDYvvVCmAyeQBZBEbqqQS5nn9t6HocOL1VvbKy33aBEzh1rQ>
    <xmx:UaPoaVEhkcmg0BBm2GY801DQls18jIemGM1WoBtKifVE8d-Xxt2lLg>
    <xmx:UaPoaad29zXPMzD0yylkO_3rnxGVspZGl1GbXVeTMyzj1G0vb-PO_g>
    <xmx:UaPoafGYvvAY27CbqM566hdCC641EPY-ILz2wy60ssFr0GohZ5BQcw>
    <xmx:UaPoaV8DkxX5ePT5gKd2jbk983rKozKsWxXAK37phcsy1jyGd8gOTM-J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 06:30:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 376baf09 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Apr 2026 10:30:38 +0000 (UTC)
Date: Wed, 22 Apr 2026 12:30:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: Re: [PATCH v2] generate-configlist: collapse depfile for older Ninja
Message-ID: <aeijSwIcqzkqstFG@pks.im>
References: <20260421-toon-fix-almalinux8-v1-1-aec1d54addde@iotcl.com>
 <20260422-toon-fix-almalinux8-v2-1-45d8471ed0e9@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422-toon-fix-almalinux8-v2-1-45d8471ed0e9@iotcl.com>

On Wed, Apr 22, 2026 at 09:21:20AM +0200, Toon Claes wrote:
> Changes in v2:
> - Simplify the changes *a lot* by doing the collapsing unconditionally.
> - Link to v1: https://patch.msgid.link/20260421-toon-fix-almalinux8-v1-1-aec1d54addde@iotcl.com

Thanks. I've tested those changes with Ninja 1.8.2 and can confirm that
it does fix the issue.

Patrick
