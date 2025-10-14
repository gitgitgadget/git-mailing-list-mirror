Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C251EDA02
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474637; cv=none; b=X1WIEfOzzzLu49y4H/7ClqvkCCigID4jgTW8QKkFz8F8ag3qjxEiPOvxI3zJm4Q0DNh9Z9PoaYyoFBmncNRvV5GL0Laj1dqL2zM8rtoILq15/SOPE5dv+0llQt/nhjw28pwyITEi1Y/lMZfiPw8c6V4wyHsxIFOW5KsDpo5AfWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474637; c=relaxed/simple;
	bh=XvD/HT+Zr3oiHvQqHRPJWjLjfzDB50ZpNtXb8i0YDWQ=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UCRvylOuUco+JYZWa/laQJ/DiHWKsqSBVYiCpCA0ywwjNlkKGs1lfgeZT6rTmb4nQjp1/pel93K8CGr1jg/IYECrqi4l9zj6wC/9CjbLbWhmdBZnwWABvgA8f8S9cVFoRrolt0xnRdjSjT5Ohs+TeCvIpFFvOZ/c5BnA8FhGokU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Yd18mCqZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X///BwkI; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Yd18mCqZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X///BwkI"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 209D1EC09D1;
	Tue, 14 Oct 2025 16:43:54 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 14 Oct 2025 16:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760474634;
	 x=1760561034; bh=5LyAsK60KgjguQcOras6p8lrVe8KzYIcV/mW6aEl6Ug=; b=
	Yd18mCqZPx2CgFN3JtB8NXSoI+iDOPHsLxnX0FeG4gOX4u6xd/3ijuY5z3+Vgyb9
	l8xM/+O/LGesdwc58iGwpYMs9p+FSfs3HJ9lMPvJKrfC+WnXmMbpO0XdJEPTjVGY
	ZtU8/7Q6myWSKqVgm5qoFwEN0BjXvBapTfXEM/WVMOpKwPZi2R0dc9Puym9fjVk5
	etL0L5URreJ+arjtft8qh7dY4wKeFUuhHwA3NguQMmeby2yyBL4pyMYhlGkmlpRy
	kAWbWOfkOL2OW8A7mymbQrNCS1aydZP6tEOVZFp4Q3OnwCsJ5lMXRoIR/YQcBbzp
	TpA5grwIBUK1GNMPEwL9eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760474634; x=1760561034; bh=5
	LyAsK60KgjguQcOras6p8lrVe8KzYIcV/mW6aEl6Ug=; b=X///BwkIaFET7vcLR
	FjJKTRQTp8Iqknei6XX13dKYjoV4EFZzMIOI+6muOLLcFYGrVU44m/dSSqRftRHV
	g54Gicz8EGmOGV0aTihyUu9U97qlfqMN+DYb2OBS0Je3HqsGjHsfgxykee+weWoR
	2cXI4Lp7kuxCWN7FJ4ebFAeDbJn1BClgfoKxI0HrDk50ZDsecyQBZg9rY6xbU/pr
	00liWV6PvVGj2NMws1Cnb6QznyuX2VW9Twkd2oPpcGvLUyteTSaP1kpoCF1Xeiob
	XmzsJdqSHEUGZz6R1oQZ1hEv6A0JLfTqZoKQGjcQcZtMAeEV5n0tDS+YWRn8J4qi
	D4cuA==
X-ME-Sender: <xms:CbbuaBnmiQsExcvkLuLh8iENBeYXg2sur-a3dPRfV7kIJSvfShnQC6w>
    <xme:CbbuaHpCDHf3OPFafQ37TcSf_69LzwIwLj_ST-ocfKaTSreo2bn1hOlYQQ2BWEHa0
    ByJaEEY1lahJPZaK0cbTxz6PAf5Sv6coljsy40YvG2zW1rDqXRf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdduheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudel
    hfefkeehtefggeefjeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghruf
    hiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghl
    mhdrohhrghdruhhkpdhrtghpthhtohepmhgvsehlihhnuhigrdgsvggruhhthidprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CbbuaEuHd8UgtnNonW_za02CHLgkFEu6F2PKujORrfsMpK2sZp2S3A>
    <xmx:CbbuaM5KLIkjBaEaMIRJeutksO3LLVtt1LqYaup8sK5Ja24BcWpG9A>
    <xmx:CbbuaDQB5FSdX2XK1M3oUkTP-6Bn717tWzbizYmcDhueY5MTcHD62A>
    <xmx:CbbuaLohRk0lyWCinlSMR8SmR-GQSObSR6xg6aAbNaSybL-4zRJTpw>
    <xmx:CrbuaOmWsZjFGyfVYBXDGvy4oeSc4U0IvP0Lx1wL0ebOyWDSMfw55C1f>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D99471EA0062; Tue, 14 Oct 2025 16:43:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aba4Cs_AGo33
Date: Tue, 14 Oct 2025 22:43:33 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Li Chen" <me@linux.beauty>, "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 git <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
Message-Id: <cbe93380-e145-4ebd-a213-928b8c3ba085@app.fastmail.com>
In-Reply-To: <20251014122452.1851103-10-me@linux.beauty>
References: <20251014122452.1851103-1-me@linux.beauty>
 <20251014122452.1851103-10-me@linux.beauty>
Subject: Re: [PATCH v4 09/29] rebase: support --trailer
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025, at 14:24, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
>
> Implement a new `--trailer <text>` option for `git rebase`
> (support merge backend only now), which appends arbitrary
> trailer lines to each rebased commit message.
>
> Reject it if the user passes an option that requires the
> apply backend (git am) since it lacks message=E2=80=91filter/trailer
> hook. otherwise we can just use the merge backend.
>
> Automatically set REBASE_FORCE when any trailer is supplied.
>
> And reject invalid input before user edit the interactive file.

s/edit/edits/

>
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> ---
>  Documentation/git-rebase.adoc |  7 +++
>  builtin/rebase.c              | 89 +++++++++++++++++++++++++++++++++
>  sequencer.c                   | 13 +++++
>  sequencer.h                   |  4 +-
>  t/meson.build                 |  1 +
>  t/t3440-rebase-trailer.sh     | 94 +++++++++++++++++++++++++++++++++++
>  6 files changed, 207 insertions(+), 1 deletion(-)
>  create mode 100755 t/t3440-rebase-trailer.sh
>
> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.=
adoc
> index 005caf6164..b2003b70d7 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -488,6 +488,13 @@ See also INCOMPATIBLE OPTIONS below.
>  	that if `--interactive` is given then only commits marked to be
>  	picked, edited or reworded will have the trailer added.
>  +
> +--trailer <trailer>::
> +       Append the given trailer line(s) to every rebased commit
> +       message, processed via linkgit:git-interpret-trailers[1].
> +       When this option is present *rebase automatically implies*
> +       `--force-rebase` so that fast=E2=80=91forwarded commits are al=
so
> +       rewritten.
> +

You=E2=80=99ve cut off the second paragraph of `--signoff`.  This should=
 be
added after `See also` below.

Probably also with an `=3D`:

    --trailer=3D<trailer>::

>  See also INCOMPATIBLE OPTIONS below.
>
>[snip]
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-rebase.sh # test_commit_message, helpers
> +
> +create_expect() {
> +	cat >"$1" <<-EOF
> +		$2
> +
> +		Reviewed-by: Dev <dev@example.com>

One level of indentation seems enough?

> +	EOF
> +}
>[snip]

Long line.

> +	git cat-file commit HEAD | grep "^Bug: 456" &&
> +	git cat-file commit HEAD | grep -v "^Bug: 123"
> +'
>[snip]
