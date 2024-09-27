Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825781C172A
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727450524; cv=none; b=d/Q6gDxjXR1vU1zGI8c+7vyEY+HV+VKDuLt2woEQOIhlClxhXNjf3m4+bZ570wDQLAgxJzVgtTQv6rvJvDh7Ci4T0FRFMi5WA7k4q0JpyRszTmDbfWfHlG/VywnNpapeVfW4m2Fnx/FULjLVJ2KXfT0pG07hULSz07C20Ytaro0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727450524; c=relaxed/simple;
	bh=R7Ui/CnQUyRZtvaNS5dVFzcw2hA7kFvwS3mu38k5/dc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CKD7f89vGzE4nMpfzIoIs+pi8eyxAZXt/Cns1TQXc7OYtWLwF8y6BiwHKRxdFaxK3JvwXigmuCRvkiTrO1X29GKxJajkPs3eRbxy+BE0SCww6t6pR8+RbIMSrVVt0dpwIu3Y+vwXgbbG8mzUIDNCpkSVbPlZ37aYTOK/ahmx+1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lSWubqDJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hqItufPK; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lSWubqDJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hqItufPK"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9303C114012C;
	Fri, 27 Sep 2024 11:22:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 27 Sep 2024 11:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727450521; x=1727536921; bh=A+oGYarzpy
	EW+vMitGROVXakkV4mDxI1HGroVdnVAL8=; b=lSWubqDJ4Kop98qxZK86H4JWKl
	GJUln0EJoB0NsLrHPCiAuRHxU1GTrYwnrUNM3UXZbBaaJ6qil1ONawZL2FOi17X+
	MvX58NwV5pxupSoCOztt+j6b8s7dxvYUeh7IZaC1Ob2wRZNLQEG4lwSznQruWQVR
	Q3E1TwVPO23NXyWgXmcwsUvfZu06oAKHQs+G/K+rUFjJcw2lD8UHSVDxawnkrzPu
	snFBYfmWe7a/9iRvPYAmw07FILWRj3M35B8anlNWTZ1Ve7dNJd8len+xRjPkJvTi
	yKSyFLVJDC5waemEwJarO1vKJxIzPIiLI7uPEU2OCOaLlkIQyP3yJ0Xq9g9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727450521; x=1727536921; bh=A+oGYarzpyEW+vMitGROVXakkV4m
	DxI1HGroVdnVAL8=; b=hqItufPKSIZXIK8LWP0P7Rj0yXGyoJFc2uuJF+5Hxrar
	lxPPuRRd2qfEUS077KeEACQ86Vog0lKS/J6Q9VkO3l9NaEgNMqTsAQ9yj4m/Z7xl
	PRBzAf13p/8h0gQUJBOEqLKJ+4J4Z5l3bYLa6NNUnUEcsKeNMzhrCUBvKaTQoBYW
	thRUTJizQnC6rEIRJYr8B2Zzc6VSXltdNghTx2n1LbcPydiR8poqVwLIreiEhsCh
	eYGlrSvqCancs/tjKyuBEoEkP8Aez8BHDwpPtwJssruT08XRe0tlJ1lO2MZ0yinp
	Q8ySAvBi9C9Ky+9eJI1t9mGPbuSb3NRo5riDpLJaVg==
X-ME-Sender: <xms:mc32ZuVDFN86jPh3PAK6LBXyOBlWBjUewPW1uhwQf5VGHEZvPyJALg>
    <xme:mc32ZqnCsqWLDTD-3MEefCbL1lv2nfsjS2tfjuUDvmQx0W2hC1W5lf4EZ2nHlbk17
    0bwe76ccYiV0UQSxw>
X-ME-Received: <xmr:mc32ZiYQLSGh99l1JEQxnQx5iUPsqSkmrv_khAg5Uvt1r1hnCCNerjg5bHZE5pWRSN1DjQh6ZbtVlqgi4hhFB3Pr_0aPEnxZxF0xeTY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtledgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgrnhifvghnnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvthhhohhmshhonhesvg
    gufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehsthgvrggumhhonhesghho
    ohhglhgvrdgtohhmpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mc32ZlVwnbhR_wEcgHjP-Zyb-O15mXyh9skj1GEuKYo4F0D-J6LtwA>
    <xmx:mc32Zon2lI76RjXnNEkHCjXYcgPrJXtCzeqhstz2FcI6HAFDuP9ZYQ>
    <xmx:mc32ZqeqHiCNESEpYdsn1JGMf0Sjh0GaVX0FHy8ePS4G5P2gBnB_pA>
    <xmx:mc32ZqFE8tAD7NuwIfpI7Q6nFSZYQ5OI9QHlWFIT6U25TFGzJPDL5w>
    <xmx:mc32Zi5OeI_tiDUywIfuUhBwtENoznlSns3lUIN8ttlebH52aMrStLC8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Sep 2024 11:22:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Edward Thomson
 <ethomson@edwardthomson.com>,  Josh Steadmon <steadmon@google.com>,
  Calvin Wan <calvinwan@google.com>,  Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH v2 04/22] reftable/basics: handle allocation failures in
 `reftable_calloc()`
In-Reply-To: <CAOw_e7YZNUa_Fu58C73kyc85f+_1Z1ew3p9=AekQGiqmXeQK5w@mail.gmail.com>
	(Han-Wen Nienhuys's message of "Fri, 27 Sep 2024 14:21:27 +0200")
References: <cover.1726489647.git.ps@pks.im> <cover.1727158127.git.ps@pks.im>
	<f6ad92ffd01c442dacd3ac6aa448891028636636.1727158127.git.ps@pks.im>
	<xmqqikulugwj.fsf@gitster.g> <ZvVPiIzzLTTb75b8@pks.im>
	<xmqqzfnul7fg.fsf@gitster.g> <ZvZCdcpifMpmKajx@pks.im>
	<CAOw_e7YZNUa_Fu58C73kyc85f+_1Z1ew3p9=AekQGiqmXeQK5w@mail.gmail.com>
Date: Fri, 27 Sep 2024 08:21:59 -0700
Message-ID: <xmqqplopgm08.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Han-Wen Nienhuys <hanwenn@gmail.com> writes:

> I think Patrick's plan is sound. The amount of code to make reftable
> work both standalone and in Git is small. It just needs some
> discipline on both the Git and libgit2 side to not add additional
> dependencies.

Thanks for a sanity check.  Very much appreciated.
