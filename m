Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED9219CD1D
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756140225; cv=none; b=m4ab7okGcmoeCRtYifpXVBUDbbwdxCEVlRZ5o8XRHWZVDrzJniHLIbD2K+qS3AkKHTtM2Nu1oF0nmdX/+SbHzbJ0vzVP+ofzUeR1fBaO6dN+r5LXKUgT9vzaYBk9lvmm33QD4j5fTLbJpmJxg5AWQ/r5HwRXE7mFxY5f6bhZxcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756140225; c=relaxed/simple;
	bh=X1AOwUxgx1aWayOhmJ2XVUrRFeDcMJgJm0erRuYi/QM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kJY9qPgx5Nd0AVu0i071b9/RKu34XEfyF0fqQPY0yX4nHFNJhzDKOG1PziJyMVX9FCjtjUi3Mi7JZed9ytZl0a07KVqoCngrNgWmb7E7eg1/j1mVKUfm1riww6qRrBNWnhNy2c1+jTG5XZCaVUZ3rNSKQrk5a8vYitNZPeNF1BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eoA/qax/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=foDEKDwd; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eoA/qax/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="foDEKDwd"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D50081D000B9;
	Mon, 25 Aug 2025 12:43:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 25 Aug 2025 12:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1756140222; x=1756226622; bh=Cmn6GKHghd
	sFzZTSbjoT/9+bk6YhtrYpGcn8aJHGJUo=; b=eoA/qax/b21RT1FJbtgBoSVNBn
	EuAWhXupDNqFJPt8Z/rO9axq05J/87MYSmg5xbiD78ACZrYk1H3epf2OHWnGdp4h
	A6XkGmzWZUAslyqui0kBDzD+isu6OxubiO75fCgJbbb5wMZvDA42NC8soz7npXM2
	GMNWYd6sBHDsgbc9HjKe/9WJ4Zo2DQuarlZIOmK2lrD+14SniqWek9N39piyA0Cr
	OVnpPlie3gs0IX86AGU/e/3ysKZGu0JIFvWzyIf/JVeLNBFwGYKspGEZSE6eQtds
	sXRDX8mwRJ+wGLTRQD3h0+9k5niu0PVk+BBVWi5s9hqM7iyFIaPpEB639zIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756140222; x=1756226622; bh=Cmn6GKHghdsFzZTSbjoT/9+bk6YhtrYpGcn
	8aJHGJUo=; b=foDEKDwdQuwyUcX9OBptYm27xyYAkvBIwqnbhO+lAHamEk5O0mx
	mjzboTTHoo5s5BCiUIXRtPnhpyyOTSG2lEyTrntScvf8Vg/cKycmL13hospUJjCf
	/315RWWt/X/x6QQ+bV9lIHpy3tZGjLyAP4Ejnh0xVAyeNDujkPlYKj3mw5RhkKn9
	3Y9K1ILBC7++W+zO5MJ+E2+5gSgQWP6CtcbIj3yo2q4GlJ/4P44iaNXrm8tapcJA
	Jfu+Qt59bD5zbq/YyhsOGHLZsr7qJk5C8+zd1SURPWrBAFJ39Aiu2fh+z5wJzHwP
	G6qvaT37jWzWku1tIMVTac4HOl+4oqKKNSQ==
X-ME-Sender: <xms:vpKsaAJypcn5rt5wjruMFGBWiThSKBUWI2GHKXcfdggYD1N-kjoH7g>
    <xme:vpKsaNEUROlrV7jjU2zJnk3PL2r6Se-ngSO2MyS_sP1isdA_t-NWJ51HKUUz_QPzD
    z_FslH91UnonwFvMw>
X-ME-Received: <xmr:vpKsaMXARWDtCndLvmouHyZs09JtcxeV8jGbwCqrCx9sLdImptlNsFmSDIq0LH8hww9TuadR3G275vJGzIpIHzDpqUIYD3T0KS_xMAI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepmhgrrhht
    ihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhh
    gruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vpKsaFygvlxvs15Zj-2ZZFaT335tzSRl-TmnL6j6Xs1YML_ukDpddw>
    <xmx:vpKsaBTtxD6dV7tD5YjAE9Qs0Z6nLgjCjSH8TytoP6BWAWfAtnXCZg>
    <xmx:vpKsaBg6DBBTzdKQ04VYcO_cd7SHPTR2C6lSs4W0lq_U1jnCKUlTew>
    <xmx:vpKsaIksOmJpvVWH1pxyncerkf7Az7kf5bI0Bfsmz5oykitbTGuUOA>
    <xmx:vpKsaBKVkoRAXJqIQG2er2nOUlKy-5qWoy076-nAybeUHJjV1jHjh51c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 12:43:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Sergey
 Organov <sorganov@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,  Martin
 von Zweigbergk <martinvonz@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH RFC v2 12/16] add-patch: remove dependency on
 "add-interactive" subsystem
In-Reply-To: <20250824-b4-pks-history-builtin-v2-12-964ac12f65bd@pks.im>
	(Patrick Steinhardt's message of "Sun, 24 Aug 2025 19:42:25 +0200")
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
	<20250824-b4-pks-history-builtin-v2-12-964ac12f65bd@pks.im>
Date: Mon, 25 Aug 2025 09:43:41 -0700
Message-ID: <xmqqa53ns66a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> With the preceding commit we have split out interactive configuration
> that is used by both "git add -p" and "git add -i". But we still
> initialize that configuration in the "add -p" subsystem by calling
> `init_add_i_state()`, even though we only do so to initialize the
> interactive configuration as well as a repository pointer.
>
> Stop doing so and instead store and initialize the interactive
> configuration in `struct add_p_state` directly.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  add-patch.c | 68 ++++++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 36 insertions(+), 32 deletions(-)

Ahh, with the two steps, this and the previous one, my question is
answered.  I like the shape of the code base at this step very much.
