Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE91715B0EF
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741888979; cv=none; b=NN6eO58kkbOWo6lrl8IaoFSNBM+0g1aEojlE/kNGG7Lu/X2bI+lV9+C5G2e2vGyBxV58RKauojJb+Fk19cFi4Jko7Gz6cZXR9f71ohUEYc/mRLn2dpZrjPV7040ZSdgIWG0Ypys7FlpuM50AKp3qB4upBg8RxotOb+tAdxWaqnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741888979; c=relaxed/simple;
	bh=NnJuQT0+YjPDEtc8Fx5g/d0GgySfNWFUT+UZuVtmdIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rnIXQa6sQYQJJqNRw918atKuH0MJN7qWScrquSaEMXOvIwgFmlgBa2wnfOuFhUboATfCpTwQ3/IaZtWW9CkaeY8DM2t5YKXKDdBwjN8d2CoHS5BDLAWabwaDMA2RcTo2tM+WRG6JqkEirRdKO4N2RpWq/dn5saIKbloqjUltAAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jO8Uf0gq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=08+4Ms45; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jO8Uf0gq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="08+4Ms45"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id DC7EC1383175;
	Thu, 13 Mar 2025 14:02:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 13 Mar 2025 14:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741888976; x=1741975376; bh=hc2TPUcsTu
	OQCRXYDi1dckL+gThtfwnUVVKktIMRr08=; b=jO8Uf0gq/bibfQPQa9If9f2OP9
	M6/TI07x/KOTIWjfoapI5cOpK5GUotzv2hivJ2vCIBmd1M5VdL/I7PfQmT0/bWTc
	RCZ1nS5H1mapE56sEUCGMx6fdcK8OLFVhbmtuCbsNQKROPZdT16WrOCKc1woXeTG
	HSEx5shPke2V8rQ0IHfxP8bwDMYnZzXL/zjT3E2uE7syT0YLecqX+8a5e8a1Ir5A
	keiH+wFmvnWVJXNkPC43cQPxuq+z3vi+dOtE+Z10R1tJgVHma1tyWqQdOfByFath
	CPjnN+hV9XYG3pcw+lyL/xXnBP5hfc9KZoc15+A7dv9pleTCOv2cT6Jn3jNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741888976; x=1741975376; bh=hc2TPUcsTuOQCRXYDi1dckL+gThtfwnUVVK
	ktIMRr08=; b=08+4Ms45tQc2yVX3gcYLTG1ayExvK1xmokDGC4o4HSDMlXoWFZb
	eS41m4IuAcG5yQQto94IySglvrb1EP9yiQvWmozQ7rO6PiPREm3LR4e1EklO/fmd
	oe+wtBHc6mfqeFLSGoKwMFQHyIa9ynQuVuP2C3uAQ08w9RYwUuSA/37JyZSYXFbr
	ok61J8syvXLmjtydRQSokrsi0RbL/FtRxjZqL9gxDjp9JzOhuGIAM5BiVMcDHYcm
	w8iNGDw3rrb4VekP9IofVsV1gtEHUyuQkjE4ajCKfpqdchh9ochbWTZPVMcv33LQ
	NJraz6UH0SlaLDyllndIJU7Pz4mcV2BZQOA==
X-ME-Sender: <xms:0B3TZxdqG1OMjnRFeI66tqOK4s0ON6hPbUJh99Wbd1Wf0pANqfUUsw>
    <xme:0B3TZ_PxJgtjpCsbvCCu4br4WJGyesDviWoPHLDhD1QGpadNF4Ygy_5aiDVrSPXst
    ZfMV0Hr87mugF-BGQ>
X-ME-Received: <xmr:0B3TZ6iuWXryKN5s2j2cQLAds69Y_gPIl59Gip4hgRvaBZt7n9v2XUffSstRj1aM7yZY_BqJ-fxqXIfsvT0-YdqyDPkyXJOhNfmZ5kU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhih
    hnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:0B3TZ6-53aLHdPY5dy5eTQ3ne5ZYBhyk-OeL8JWhfH-f1du2NpFBDQ>
    <xmx:0B3TZ9sN07gBTiohSGBCY9qV4iu_r1rcsdChIJDKHGArZF8km8yh6w>
    <xmx:0B3TZ5FEGoGmR5Np81m6Qg9JOvDqFMGe8zQSp9SNS8Rw0ctbiBQ6hg>
    <xmx:0B3TZ0MJE_gVUZA4Q-ufEhlfYUoDj7RtLBVWBqUTJrV3AM9oTHWaiw>
    <xmx:0B3TZ7UrLjMy-p-d3fUp3AOj8WuwuQngH4iUps3aSSDR1O_gIuVO9bLa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 14:02:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] compat/mingw: fix EACCESS when opening files with
 `O_CREAT | O_EXCL`
In-Reply-To: <20250313-b4-pks-mingw-lockfile-flake-v1-2-bc5d3e70f516@pks.im>
	(Patrick Steinhardt's message of "Thu, 13 Mar 2025 15:17:44 +0100")
References: <20250313-b4-pks-mingw-lockfile-flake-v1-0-bc5d3e70f516@pks.im>
	<20250313-b4-pks-mingw-lockfile-flake-v1-2-bc5d3e70f516@pks.im>
Date: Thu, 13 Mar 2025 11:02:55 -0700
Message-ID: <xmqqjz8solkg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +	/*
> +	 * Internally, `_wopen()` uses the `CreateFile()` API with CREATE_NEW,
> +	 * which may error out with ERROR_ACCESS_DENIED when the file is
> +	 * scheduled for deletion via `DeleteFileW()`. The file essentially
> +	 * exists, so we map this error to ERROR_ALREADY_EXISTS so that callers
> +	 * don't have to special-case this.
> +	 *
> +	 * This fixes issues for example with the lockfile interface when one
> +	 * process has a lock that it is about to commit or release while
> +	 * another process wants to acquire it.
> +	 */

The above may explain how the code gets ERROR_ACCESS_DENIED when
there is a pending DeleteFileW() on the file.  I however cannot
judge if the opposite is also always true, i.e. ERROR_ACCESS_DENIED
always mean the file did exist and hasn't gone away and no other
reason the code would ever get that error status.  Somebody with
better understanding on Windows API behaviour hopefully can review
it.

Thanks.

> +	if (fd < 0 && create && GetLastError() == ERROR_ACCESS_DENIED)
> +		errno = EEXIST;
>  	if (fd < 0 && (oflags & O_ACCMODE) != O_RDONLY && errno == EACCES) {
>  		DWORD attrs = GetFileAttributesW(wfilename);
>  		if (attrs != INVALID_FILE_ATTRIBUTES && (attrs & FILE_ATTRIBUTE_DIRECTORY))
