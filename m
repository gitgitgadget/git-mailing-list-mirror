Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A23211711
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742319863; cv=none; b=BAB0+NaF6uMZzGvwd4rmk0TRGAnpzTZknnCA4LOeYAyC5xhI4+Z4fr6cl8X9EuT8rTx6jkq1bJVVCW8nE9tqpHI7Ienz8VnFTEk7dj8C3TO08CkZebuUvMGkzKPHg4iom2Pu9W6i6CTjsBPsmOiVQe9Pkf1u2EoVnhObgQ+JGzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742319863; c=relaxed/simple;
	bh=ixCQpi7Q6XnqQJlXX9xrzMDpYwBod2KlEbP9t/y+N+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fZ3x/6XpuTAqvHu0LG10uJMmmY/PpYuFzVOip9Exzq5zNkkiRhqA6+XBSpbFEqrUfilTea2TCfYoDfuH8szjRmuBOcqTdw/q5nS7EXCpErsnNWSD0hScRdg/KWyQLHfVjcRjPPEmPdCs1vrVts3h15H8/8CzqxCvpj3G6lay8iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FOsEjBYL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NBZNiC2o; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FOsEjBYL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NBZNiC2o"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9240925401A5;
	Tue, 18 Mar 2025 13:44:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 18 Mar 2025 13:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742319860; x=1742406260; bh=SISfdyWwlt
	GiH8yv6cl8md132NO+J67b4GhXzGEoPY8=; b=FOsEjBYLzJoepQq7RAAI+4nNRS
	7QHuFSCvgJQdS4C6gfrQTQDOIWrjOdNVgSkHCaXVGxy7Nr2ogig1JaqdTvKfqucd
	Yuqrv3T6O+tNBDc8XyaDoIq28ofF0KDNm4I6qpLySUN5Hfma+OwumAgzE7hUQLE0
	+E06BOYWFWweOtoH0FSV/bIQ4XTOw2VMZuWfoIjRpO4r5mvKO2j3l2bRqlrrmDJW
	tFT91+euej0j1so7NJnPISXKpc2CBTZ5lik6fNi3SJzioOZji3I+AIGLTMNLYwkN
	Km9TOPfBpL7F3RTQleLiWpmZh56KwFv4zkeQwMxFq2CUw7BI+4u5yL4qmOug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742319860; x=1742406260; bh=SISfdyWwltGiH8yv6cl8md132NO+J67b4Gh
	XzGEoPY8=; b=NBZNiC2ouF00XR47UsZ25SG+aelv86xPVdpsM/Rq4nWCEI2yAd6
	i2gnoAAclorHE05UJYLNLzN1YjsXgOvn/gWGl07DLIkcl443PethVMOrxCbb4bUf
	dTTdHz8XDoc1T5pCJIE6qgKTQSSvsiZiLlvOB59s1D6zTGmMO6KNpXmwgpQirVWz
	109SfR6m5UXTbJD5SI2cimTMypyP2ZC8yVG+fWFQqfYZBa1Fs78opQ1207Ia2uUL
	Ew0jyuf+ZFRmiDFj0BSuc4i0plSgAM2EIlNFqQWm7SrgPD1AITJdiiUpHShgElKi
	IKP6p8n6QEbD/43zt8JwxUcv62HETHICYQw==
X-ME-Sender: <xms:9LDZZ9EMFXTk_-NITSggnKDQeuztjLYUmjAsMcLmn9tyA8lgWbWd1g>
    <xme:9LDZZyVXHK0vfV1ljPjnyFza_79fXdZ3p-NbTIJUDbGl_cvIjbN5UjPjjHsMNG_WY
    gpXTpT37bfXsznRDg>
X-ME-Received: <xmr:9LDZZ_Kw2I6qQ08Y-B_ZOXuuJ58wZarTIWbWz_Pw7GAp2o-0MELRkzU-Ny41swjFb3AsjLuEb_8JLn6yXVrfi-P32agKNW5tG70cnbM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeeftdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdr
    udekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9LDZZzEvOMEdDoldHV2YvzPfUDpwmd6qVNJ5NOxkDkNAADQaWdvdRw>
    <xmx:9LDZZzXiwfpwiy0zfEDCHNIRTE9HxLeoHtWTWuSCPw_EglU14_TTWQ>
    <xmx:9LDZZ-OKi_XzaiHojbeE0FKNvlMMWFyKkOPyV0gtlWh529eE6i32Kg>
    <xmx:9LDZZy2mE0GqfQ9jtRY9QdLP9YoiiVcRtpIdSfk-UWi9n5RkRLVt6w>
    <xmx:9LDZZ1JIk30msOy9wFpNOlh_AR4fT3fIuSQjgHx4jWy19nbdAkUmK80R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 13:44:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  kristofferhaugsbakk@fastmail.com
Subject: Re: [PATCH v3 2/2] reflog: implement subcommand to drop reflogs
In-Reply-To: <CAP8UFD2+xQQbUevHTQangg__dq2M615pHLhYYUf7b9shpShD9Q@mail.gmail.com>
	(Christian Couder's message of "Tue, 18 Mar 2025 15:01:16 +0100")
References: <20250314-493-add-command-to-purge-reflog-entries-v3-0-c24e23a6146d@gmail.com>
	<20250314-493-add-command-to-purge-reflog-entries-v3-2-c24e23a6146d@gmail.com>
	<CAP8UFD2+xQQbUevHTQangg__dq2M615pHLhYYUf7b9shpShD9Q@mail.gmail.com>
Date: Tue, 18 Mar 2025 10:44:18 -0700
Message-ID: <xmqqsena2pzh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> It looks like 'single_worktree' is only used here. This means that if
> a user forgets to add --all and only uses --single-worktree, nothing
> will happen and it seems to me that the command will exit with code 0.
> Even if `git reflog expire` already works like that, I think this is a
> bit unfortunate.
>
> Otherwise this patch series looks very well done to me.

In the thread Toon too seems to have noticed the same "what if there
is no --all and --single-worktree is given?" gotcha.  Together with
the "current would be better name than single", we can consider that
these funnies are to be "consistent" with the "expire" thing, and I
am OK to see us move on.  An alternative is to "fix" the behaviour
and naming of the "expire" first, and then use the same improved
behaviour and naming when adding "drop" as a new thing.

Thanks.

