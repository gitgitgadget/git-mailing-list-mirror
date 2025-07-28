Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74840272803
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716866; cv=none; b=p6n+yu6OXTGBrsGLBvGtHjOWOlKF6/gYaa9vsrjmzxlDETXWdNJ+3BPACfXoYwV1UuYb3QKQkUggPBgPISKKC3Db5F/a6PdFl5fANe47UTWUUOi/AbUM71b410Hnjen8PcDTUkhHV4S+bM1NtWyZe5OV+03IHZWv36Ni7N3qow8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716866; c=relaxed/simple;
	bh=LW6gbTbyLPGWg+/tDNCZoygvsmzJPi/ag42KNyVWnqw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nWWTggVWMIJiL0peNWBCpkqs4vhDyHTw5YbyTFmxjmERsGKeMda+YRWMVkycn4bEukaN1iVqyNA6hRcWG/GXv6skhtp+Q0PV99G1Fp1nEecgqgiEdw6e1nd67ZAoy0plD3sqSPtPJyqiKlQqYUaX2HGwD39FPXnF4TDcZQa5AbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=c1nbGfx6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kyS9Mb+X; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="c1nbGfx6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kyS9Mb+X"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5E7C87A087A;
	Mon, 28 Jul 2025 11:34:23 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-09.internal (MEProxy); Mon, 28 Jul 2025 11:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753716863;
	 x=1753803263; bh=EEZLDzrXesJJvocJO3YEBT3Cs9ehb+9w0xFdr63cQFQ=; b=
	c1nbGfx6xSOwYbnqbaBQXf5TvE2MF5Ro82Swne/4YLF28vSZtfS6IhpTNX5gmpEm
	YNOhryvxrpzgI4qAvHhFW2ZFEhIxa0Wp8HTX/oPTKMF+mfjoojyZvrU8tMF+KZ9y
	kKH+WCSa7B5KPnnUgk8gpCHdFQYD0+H2QTW9tJ6+J5QqYHZIJC8jL4HJWLZy6Nnx
	hIXNNcEjAWNSZ619fS0huw80cGtz7O77DwnYrpJfSO0FT2gU7+08xM784wk7IhVd
	FIO6Q5KNjn/QlvL6ZpajTQQstCLld5VbEbxLFF0dRonXSt6kQxbEn/tbLuJaV+4A
	UvZSRgOzyMUylGh6NQudWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753716863; x=
	1753803263; bh=EEZLDzrXesJJvocJO3YEBT3Cs9ehb+9w0xFdr63cQFQ=; b=k
	yS9Mb+XxXGQanuUeUf2niGx7n6CLiSPociM+bAQaSoSBx5bQKAXCyi+1npRB+xXH
	l6xkz+xZd9zSufD+NrbH1A8C/M7tKgdEwIntNgCrERMAGvi6lFjlJlpdwxtZHFv7
	Yczvc6/aHd63kpBFhtDdPvEL8/14r64GN8/WB335ZEM8yMF/ZnP1QN3aNcKN6BKV
	r+GrDOcnUiCut36C7B7n3M4fopW0E7wb+vElIbkW+8MmLyH9lhXlG1TiyD7Me4hL
	/r8niV2FGO0aQthKVYicXiw9yBsPHkw6vGz+uXszekkMYJN2EaHjoHUV3WQ4aVvM
	uO6nr1djsIyG8UsABUqEg==
X-ME-Sender: <xms:fpiHaAvnYfzM0o-0B1ODn5Rq25oJ61EE0iOinKVcrjjF5OFK6oF_IF8>
    <xme:fpiHaNddXTtxAlWp3Btt0q46P-VZA58ywS4LGn0jEiLbNwt62MRR6jo0wdRMnk_hX
    2Akr6AgIbOTGp5SKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepjedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtth
    hopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhes
    ihhothgtlhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fpiHaO__wgXeZF5Rur5YJ5lbo40o0rbJtx03ejGyjjdbFP414M65Qw>
    <xmx:fpiHaCiHACCL0DJYO2DX_zuW1dqpx9igGW3NakscHpTu33C33S2a0Q>
    <xmx:fpiHaNHb1LT_Oq0DLSPWpTBVa2WmiaUhtqsrCN8DsnBxyEy9Xjj7YQ>
    <xmx:fpiHaJ-5pZJwPMaF486PQH7ik4lBWjiBQT-7M8LRw5pdGIJ6IRXP4Q>
    <xmx:f5iHaFEWCNdQQP_6o5VEY4UWPFKmUufFJA7MjhCPO0F8jpZhGgMchGep>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C8CC3186006E; Mon, 28 Jul 2025 11:34:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T8ba4ad04096afbd9
Date: Mon, 28 Jul 2025 17:33:32 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Karthik Nayak" <karthik.188@gmail.com>,
 "Justin Tobler" <jltobler@gmail.com>, "Junio C Hamano" <gitster@pobox.com>,
 =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 "Toon Claes" <toon@iotcl.com>
Message-Id: <6414dbfd-6f34-48d1-aa3f-3fe7998f80af@app.fastmail.com>
In-Reply-To: <20250725-pks-reflog-append-v2-4-e4e7cbe3f578@pks.im>
References: <20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im>
 <20250725-pks-reflog-append-v2-4-e4e7cbe3f578@pks.im>
Subject: Re: [PATCH v2 4/8] builtin/reflog: implement subcommand to write new entries
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025, at 08:58, Patrick Steinhardt wrote:
> While we provide a couple of subcommands in git-reflog(1) to remove
> reflog entries, we don't provide any to write new entries. Obviously
> this is not an operation that really would be needed for many use cases
> out there, or otherwise people would have complained that such a comma=
nd
> does not exist yet.

This command will allow you to write a simpler unique marker (without
having to make a marker-ref for a ref) that can be used to find back to
a specific point.

I=E2=80=99ve had some use for that.  I used git-update-ref(1) for that b=
ecause
of `-m` (as well as plumbing-for-scripting).

> diff --git a/Documentation/git-reflog.adoc
> b/Documentation/git-reflog.adoc
> index c3801b82fb6..c8389810273 100644
> --- a/Documentation/git-reflog.adoc
> +++ b/Documentation/git-reflog.adoc
> @@ -12,6 +12,7 @@ SYNOPSIS
>  git reflog [show] [<log-options>] [<ref>]
>  git reflog list
>  git reflog exists <ref>
> +git reflog write <ref> <old-oid> <new-oid> <message>
>  git reflog delete [--rewrite] [--updateref]
>  	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
>  git reflog drop [--all [--single-worktree] | <refs>...]
> @@ -47,6 +48,12 @@ The "exists" subcommand checks whether a ref has a
> reflog.  It exits
>  with zero status if the reflog exists, and non-zero status if it does
>  not.
>
> +The "write" subcommand writes a single entry to the reflog of a given
> +reference. This new entry is appended to the reflog and will thus bec=
ome
> +the most recent entry. Both the old and new object IDs must not be
> +abbreviated and must point to existing objects. The reflog message ge=
ts
> +normalized.
> +

You have to give the full refname to this subcommand.  `git reflog write
... branch <msg>` will update the reflog for the one-level ref `branch`.
But I=E2=80=99m used to using git-reflog(1) with a name like `branch` an=
d it
using `refs/heads/branch` if it exists.  At least that=E2=80=99s how the=
 default
`git reflog show` behaves.

Which means that

    git reflog write ... refs/heads/branch <msg>
    git reflog branch

Will show that written reflog.

Whereas this

    git reflog write ... branch <msg>
    git reflog branch

Will show one entry since `branch` is the one-level ref `branch`, not
`refs/heads/branch`.  Now it looks like `write` truncated the reflog and
wrote a new reflog message (if you mistakenly think that `branch` is a
branch).

It isn=E2=80=99t clear to me how the current doc guides me in the correct
direction here.

I tried `git reflog drop`[1] and it can deal with a branch like
`branch`.  It doesn=E2=80=99t need to be told `refs/heads/branch`.

>  The "delete" subcommand deletes single entries from the reflog, but
>  not the reflog itself. Its argument must be an _exact_ entry (e.g. "`=
git
>  reflog delete master@{2}`"). This subcommand is also typically not us=
ed
