Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94915253347
	for <git@vger.kernel.org>; Thu,  1 May 2025 23:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746141165; cv=none; b=NePyVRXg/0sFORwzcyk7UcENrxfLNiDrow5B9zx0+SFVGOn9DQ2FKXeuc46pcIx/n1/IgHxCrgFU+JdwvXr7g0FjN7bOch4puDVKDYqlgFQwWD/wK3sbKsXwYKiYj/5gY6IYk2qxRH5aycmIFGxSgjVm+pHZO3PpiiCN0CRb31Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746141165; c=relaxed/simple;
	bh=cLlFsO6I5UlRjoiIw74PuYRsJ4vxcyV7Ck1yCyZRdjw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pzCVP6UUG50WOSCi66sKauBD1eAnVc9iRXJjCD6owkaZ5Q9dYepcm1D/RxcpjvjN9kSOwGVXx8Sk0p2X2mzMOwTyO90NEJRnaKUJHY6k66Mb17HELaX4qKMCRjdPlH5ajTAvN/6/YDJMDZ6RWTUXjUKEIVd3yslQI0eoncBlC2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e5wKKR9N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uj9cV66Y; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e5wKKR9N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uj9cV66Y"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 7E14313801C6;
	Thu,  1 May 2025 19:12:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 01 May 2025 19:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746141162; x=1746227562; bh=iUnYWiy2ES
	yAeLAclMzyXeHm2bB+BUi3UCq+CEY72Gc=; b=e5wKKR9NB+crqfQm5/oG7pnqnV
	R3aiyI5Axq1tUVvIgr1hZ191rRoQgjaPFUsvrAI2h/IVWoSJDMxsnkmplO/BQzyZ
	TvwQddRz0cWILdCinybf429IresZby1VoGcK5sx4cGad0AvFtY3xwR5WYw7rqgqA
	WhZIbAYvqdwUE6sOo7tnEYdMCqsYsXY1VY0dggbtwVeDBjSxK5j2hJRjLZrOYF2S
	copa0EvsM2Unp9Msj9EWS1/VS4O2AxvVI06Ngi6oiARoBY3unO1vPotmm3WL0GG1
	je4IzOCgbKcYYYtm21UuUb7g4RQ/wJ6e9SAncD5AR9saKGQGICBYD4SgGK/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746141162; x=1746227562; bh=iUnYWiy2ESyAeLAclMzyXeHm2bB+BUi3UCq
	+CEY72Gc=; b=uj9cV66YzMFYcGXOMEmwlgTm7oPi3fpZRUYaW4CmehHVzt0yd03
	bdt9aCzEVRXZTA4EnffjqF3QO/DsuQLCskcG5i+jW8CasITfng02FDemDgv5qPXU
	45EpuilfJtX/ZbBDZ4Q2SG3VIdrkm0JwL+GlxfmQqW6GRKvSwJnU7Wi05WpPUaE+
	9tvCOBQ8Eok9qFFZbD4xOfKD/NhwSd7n1nQ6vv1DFa0+nOjutTx1ZSDz5S2Lt983
	tQBQX9yiBvWDAihEvPk1xtNw4a1Y+TA98DAQEg0abOVODlQtUHFIV9eH4CrrWHIF
	UJYcQ1LIFK7eANLsZ6xhj0AX5p+U/FW9YAQ==
X-ME-Sender: <xms:6v8TaD-Awn4Xqw4fOL3kuehmCdvC5BkWgAzr2hzKk1aSE91xp2L4vw>
    <xme:6v8TaPtQE9xP3jEhIYLJWFmmjSUon8DCTnCRK-ykXTPcf2KuFjiIxClknOEXz-NVe
    znzguAgACdFYJGaNQ>
X-ME-Received: <xmr:6v8TaBBVv1cO0Q5vklhNGhFNuAPqz2Ok4yK9KNygctMGiMqmsSOp8y7yB927T9GdFeavEGQvMMhhpnaageWtaRQHkXxX_LLayeLN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedtkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepvedvffetgedugfeiieefffeghfegudek
    geekfffgieehvedvudefkeejueehueefnecuffhomhgrihhnpegvgigrmhhplhgvrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhi
    thhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:6v8TaPcDh9IMY5svnUIVwwTPOKSz463jR6aA0V3tKcCmvGeLuh109g>
    <xmx:6v8TaINeBAdGV-77xzkQ2o599sAURWc22lOwIuw2SEutJ2kg03SB4Q>
    <xmx:6v8TaBmMcCXriw-EIaue7f_kGT_ObE7RwtKTbIjVK1IsKJlXpMVBHg>
    <xmx:6v8TaCuuc1YMTTfZo6bYHqJzghSMvFoEh22jpRDSJuGPqkVVBVtCtw>
    <xmx:6v8TaBD_HHtDjaWNcGvPwW7cdbBrjcuw62mROIlLCib_yq3Q19ka7AEO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 19:12:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] git-daemon doc: update mark-up of synopsis option
 descriptions
In-Reply-To: <CAPig+cQ1CC2SXN6bViusJXy93jZ6k8UvxRXa6mE0At6FgvS2-Q@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 1 May 2025 18:52:09 -0400")
References: <20250501213414.370514-1-gitster@pobox.com>
	<20250501213414.370514-4-gitster@pobox.com>
	<CAPig+cQ1CC2SXN6bViusJXy93jZ6k8UvxRXa6mE0At6FgvS2-Q@mail.gmail.com>
Date: Thu, 01 May 2025 16:12:40 -0700
Message-ID: <xmqqa57wvsbb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

>> diff --git a/Documentation/git-daemon.adoc b/Documentation/git-daemon.adoc
>> @@ -46,26 +46,26 @@ An `upload-archive` also exists to serve 'git archive'.
>> ---strict-paths::
>> +`--strict-paths`::
>>         Match paths exactly (i.e. don't allow "/foo/repo" when the real path is
>>         "/foo/repo.git" or "/foo/repo/.git") and don't do user-relative paths.
>>         'git daemon' will refuse to start when this option is enabled and no
>>         directory arguments are provided.
>
> Should 'git daemon' be wrapped in backticks instead?

Yup, good eyes.

>> ---base-path=<path>::
>> +`--base-path=<path>`::
>>         Remap all the path requests as relative to the given path.
>>         This is sort of "Git root" - if you run 'git daemon' with
>>         '--base-path=/srv/git' on example.com, then if you later try to pull
>
> Should the '--base-path=/srv/git' example be wrapped in backticks instead?

Probably, so should `git daemon` one line before it.

>>         'git://example.com/hello.git', 'git daemon' will interpret the path
>>         as `/srv/git/hello.git`.
>
> These are inconsistent, as well: the first two use apostrophes, and
> the latter backticks.

I am not sure what the best mark-up for the sample strings.  They
are not what the end-users are expected to type verbatim, so I've
punted and left them out as in the original ;-)

>> @@ -135,8 +135,8 @@ none::
>> +`--user-path`::
>> +`--user-path=<path>`::
>>         Allow {tilde}user notation to be used in requests.  When
>>         specified with no parameter, a request to
>>         git://host/{tilde}alice/foo is taken as a request to access
>
> And this URL has no quoting.

Likewise.

