Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB50C1F463E
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 05:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754544064; cv=none; b=sx02zXZKhDBMVndVWojajiakUDTWYaERPP7K/5tPNtYHzRCd2aZULCjiyCLYboYc4LjK9YnDkGNxeMwyNTSG7qX67oAFrDwzg2D6MgC3K1FL3nTYc9DbvmCZd692RyxReSHQEobqWtKYd92P2ryuALOrQ2jMS6A//SRnuqm/d7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754544064; c=relaxed/simple;
	bh=CyRPA8LmpUWfKYYxKAD+QfBfqRwojDTqWIpjrbKzdPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKFRO/tQuEKz5Twx564q2yccWOFSWELQROc+738DnUsUnsMnU0cfacNpJppsQIlcvzU5aXltUm2HhkhV7Am4XtLAFzGCxSqn5GkodwWmnrQH+YnymFRqeE2eGNkavpE1Ma0BRJTkHfiN/wwCXj9DoR8X0RxjkxNYN3C19+jRIvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DtduSDB3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XBPCJiJu; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DtduSDB3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XBPCJiJu"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 089D1EC00C0;
	Thu,  7 Aug 2025 01:21:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 07 Aug 2025 01:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754544062; x=1754630462; bh=4jed6a1Jh7
	LuK9IGNuv6SVYnsxz9iQ7M5Z50C3zz0ag=; b=DtduSDB3rhvkTP4rHPjuMhElx+
	Fi8+rbANRZ4akotDjThBC3naDi9RFvdgn6BFvEyyCXoAxToF+dF4/KbAH4yEL/IT
	vqCDr/VgX3DIRomqrJW18YOOQwOuO+xcJJ+Xw6UnMhL1LByLFtxxiineHtP4YIGS
	c0tNFDCXJO32bIaNKsGrGXkm7ytFuHjyEIEo3kMml0fWYj6tBLTKOz1aWiSQHuQf
	5hoZqPI+HCbi0NIxCCxtCO/dCGD6/SoZpca8lFDm5uneLQSSc7HaDqahqHIwelDs
	bRBXFUPZCU5jEUjZlMaN1gvypJ8slaP1a6JPO/YmJNMviV6hkIMYB3w9WgdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754544062; x=1754630462; bh=4jed6a1Jh7LuK9IGNuv6SVYnsxz9iQ7M5Z5
	0C3zz0ag=; b=XBPCJiJuwNCtrJQXNUWHr80oFd7O4lVbJye3dr0zldgRcyqQyw8
	FLRCHZMqmcxgeGs4UvO8hUOPfQEYc8y6kU8C/ZtaTdWuKRXuBKNl2nVrOQh5YCio
	fDeZBYO56onHQCg0Awt/58RMyfbTQZEYSdwsjoNmmjyTM3F4Q7ILXNCyuoU4vQJr
	iHAzhq6bqtLLN7B2BWf5rF9DvG7dtQVl/9bjTTjIDepWjW/fiDHI5sD0zA/BujbL
	VvnshIyDNO+ZhBf/qtcjYDvofZMXdmBekiCmbEDYH9kaJkpJTiBsTe5JRFSB28oa
	myeYL8neDHhxXxgtLwCbo5aaGvBIAda8yIw==
X-ME-Sender: <xms:vTeUaDc3mOZKj_nstqKAxHjdtCNsD9R2knp4dAY5hpd8EdpSfRW0LA>
    <xme:vTeUaGnEPOUIayujzbDfSbQqurZn0fUm2DrhBsZki4KAiojdMPIUrV1yZb9Z661qi
    VLjKuAFvNLWIma6DQ>
X-ME-Received: <xmr:vTeUaD1uJCuebk1FwAsaFoZJLuddntVGvy8ZT262nE89xhgA19sUT5yI3L2E_2qWzrt3MCGsTwe84ePSmJJomBzVG2-8kSsWD8DqnVRtQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddttdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunh
    hshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvg
    hnsehgmhigrdguvgdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgt
    phhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehluhgtrg
    hsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:vTeUaPcmijM1KcvHP6t4qehA2k6oYet0af1KB9OkukaA3JTLC0DrAw>
    <xmx:vTeUaNaR-vB0zSHGwtlcBHVwHBBbo2TInUz9VuSbS5YtBiP32V162Q>
    <xmx:vTeUaEEeeUjlIAf2-a6Dx1STqdZ7lCeV3ZX1db1upgM5zbHYI0e9YQ>
    <xmx:vTeUaLnNJFEzADjYv3uSiuzsdBR8OXsUDHwMLmquGlNwrbyKXLL2OQ>
    <xmx:vTeUaLsF9eFEKa2wd0rAx5tYVzmx1lMQ-3JampOsNsYaRv4b3ZK3Xf3a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 01:20:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1f7f7daf (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 05:20:58 +0000 (UTC)
Date: Thu, 7 Aug 2025 07:20:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, oswald.buddenhagen@gmx.de, karthik.188@gmail.com,
	ben.knoble@gmail.com, gitster@pobox.com, phillip.wood@dunelm.org.uk,
	jltobler@gmail.com, jn.avila@free.fr, sunshine@sunshineco.com
Subject: Re: [GSoC PATCH v8 5/5] repo: add the --format flag
Message-ID: <aJQ3tyC0e53iWtVE@pks.im>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250806195537.93302-1-lucasseikioshiro@gmail.com>
 <20250806195537.93302-6-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806195537.93302-6-lucasseikioshiro@gmail.com>

On Wed, Aug 06, 2025 at 04:55:37PM -0300, Lucas Seiki Oshiro wrote:
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index 1ae9c09fac..2b63954098 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 312fd08c34..37b5726816 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -101,8 +108,18 @@ static int print_fields(int argc, const char **argv, struct repository *repo)
>  		}
>  
>  		get_value(repo, &valbuf);
> -		quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
> -		printf("%s=%s\n", key, quotbuf.buf);
> +
> +		switch (format) {
> +		case FORMAT_KEYVALUE:
> +			quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
> +			printf("%s=%s\n", key, quotbuf.buf);
> +			break;
> +		case FORMAT_NUL_TERMINATED:
> +			printf("%s\n%s%c", key, valbuf.buf, '\0');
> +			break;
> +		default:
> +			BUG("%d: not a valid output format", format);

Nit: we typically say it the other way round.

	BUG("not a valid output format: %d", format);

Doesn't matter too much though as ideally this message shouldn't ever be
seen by any user out there.

Other than my two nits the series looks good to me, thanks! I don't
terribly mind whether or not those nits are addressed.

Patrick
