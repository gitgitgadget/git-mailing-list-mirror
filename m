Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02032271471
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754398230; cv=none; b=puPcyd3Y/ADk/usEZegyavV4/dKQC1GG//XhmQM6SCPfMBEjHJTwLqVlUgCWfewLekmtE22IhvDHp1o25XvG/IN5Eqb6TWT1rHB2nJAtl+ITI/0VlyljoplsKFBnMDjImkCB9pob2eW6DLrwGk4oY3IVs+V+uiK9q6UguIKtrpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754398230; c=relaxed/simple;
	bh=zR/KO1kEEIsjhKYbs2n/tEY4UZvH0n1ybaI+f7ZiYRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCii0YUuchnglVSyT/4Cs/OrqnlmeY7dx1Y8xFuVpbWogsdW9kUyRgAwKfF7V4jv23KNDMRjf+cM+mMOyBthSSkjbh2ZuSFRCEO2PH8+hZMOk26Oly9szvG4WIJaE+ksFuWxKPv8QETRnvb1r48M8pOxtKWWk+ZB/3b8gLxtaAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Lpbz1vDz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=apgNb86n; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Lpbz1vDz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="apgNb86n"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id CFD81EC01F9;
	Tue,  5 Aug 2025 08:50:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 05 Aug 2025 08:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754398226; x=1754484626; bh=nynxRD9DYE
	UBpJlMnVXv7mc2HkEdaIemu59G04deKgU=; b=Lpbz1vDzg2p2RhRSStn3Mo0oPO
	t/WxlcAZm2fhUZCn1xgJN8v3l/2WDUwzLHBJJKZuC6oaDue3dV6sRxodcyfXdh63
	BFNUD2oiypD3pFHwN3hBUjdmazJ27GfEIjnJT2tYtijgmkcEVwakTGx+gmdeGRuq
	MVwL7nuFk8kO9Hmqd+ty8KGK2krWWrjXMljhXPiXiGoPX2oohLeQO4VFuRASmf8b
	eqpg+QGyxT/88NxP1iZvd+OOhGECHRBn3ju+AnHmt7AcixbaWqIE1mwI+M/ZWd8P
	OUijnzylup2Rmb2TbrruqJRauBObkfonpPtUMFTA+qZ587GKkFwGLYY617VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754398226; x=1754484626; bh=nynxRD9DYEUBpJlMnVXv7mc2HkEdaIemu59
	G04deKgU=; b=apgNb86nn4Yie2dhgkYeLO7XFkD1ijhBCHyghEAIEyckuRd7ZkK
	kKdkeMnwzlCQ3bnnT+Ov7dd7tOHF4FpX92SxbSb8c45YpvJpqSKyYtVuLryoSXlQ
	ounDdyoK2EDLDWOXa3ePLDD016kuYYsuGQYJeHAwlLVh/BKrXif67i58+Fdacizl
	uG4lZxkMLsGjdWu6U0cXshnRhPZnpEe5ntoKgFbkHAOJZoNQrTgI+KGU1k7rO0At
	cCMzU6Ky5GAZQFR5KC/BvimiJBRXQ074tlaA66Tdcewwzslr0fmrzRSPmjo6xr7P
	qu+5VTbYgovaBjh67HhI8rZ9TVnAHm1h1EQ==
X-ME-Sender: <xms:Ef6RaJ5g9V5SJ6VxYJBXep6h5fKMTL5asAwHfoww3ZzsiKGfU4FcBA>
    <xme:Ef6RaETvDVXXoPoj6Sx3V7X0mPXvwH9bhrS7JxzLKX_iaQLiAjT-7r8pQc6IPOBbD
    JitkD98eUbnr2wqGQ>
X-ME-Received: <xmr:Ef6RaHxvmB85opS6xsaqGysEdkqZsEOe533XY2G9LP4On6lijhFlKR7lwSqkvPTuqNkdK_Stee540E2UCz4zkAjb8uptV25ORg2HQGMm-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehoshifrghlug
    drsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohepshhunhhshhhinhgv
    sehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeekse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhr
    tghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:Ef6RaMpIIUo6ONNYy17YW1yroUZtG3jKzy0P8StihWUNRnbK12UE2A>
    <xmx:Ef6RaK2KO4CPSd4DaEvLZTdAQGuxpLTLJscuh5jWWafmLpmzoJjIhw>
    <xmx:Ef6RaMw76H434UekD2Zp_hLJyk93XZBCD1sXGNcE8sp89QV1AoyJ6Q>
    <xmx:Ef6RaOhDIxnm9DVJM5zeZLRLXD5n2W39MP4K15KbT0d0an13QEMPXw>
    <xmx:Ev6RaFLAcOUb7f69g6kDFD1k6KgvhciSD26qxF9oAvDKN_SLryLY5tjo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 08:50:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8e3b0eac (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 5 Aug 2025 12:50:22 +0000 (UTC)
Date: Tue, 5 Aug 2025 14:50:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, oswald.buddenhagen@gmx.de, karthik.188@gmail.com,
	ben.knoble@gmail.com, gitster@pobox.com, phillip.wood@dunelm.org.uk,
	jltobler@gmail.com, jn.avila@free.fr, sunshine@sunshineco.com
Subject: Re: [GSoC PATCH v7 3/5] repo: add the field layout.bare
Message-ID: <aJH-BA0jIgSOJZTk@pks.im>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250801131111.8115-1-lucasseikioshiro@gmail.com>
 <20250801131111.8115-4-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801131111.8115-4-lucasseikioshiro@gmail.com>

On Fri, Aug 01, 2025 at 10:11:08AM -0300, Lucas Seiki Oshiro wrote:
> diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
> index 9796e36087..6c555e90c3 100755
> --- a/t/t1900-repo.sh
> +++ b/t/t1900-repo.sh
> @@ -54,4 +60,12 @@ test_expect_success 'only one value is returned if the same key is requested twi
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'output is returned correctly when two keys are requested' '
> +	cat >expect <<-\EOF &&
> +	layout.bare=false
> +	references.format=files
> +	EOF
> +	git init --ref-format=files two-keys &&
> +	git -C two-keys repo info layout.bare references.format
> +'
>  test_done

Tiny nit: there's a newline missing between the test and `test_done`.

Patrick
