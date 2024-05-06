Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743972FB6
	for <git@vger.kernel.org>; Mon,  6 May 2024 01:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714959573; cv=none; b=QAEHbLEpxqFjMKMOw4I+gMi1AUSxR0RyrXiu3zUDqMh5CeUXP0Lljdv7S5POgjSlJsWRXZIvxLGVjThgIJXkzrHGofbl8WJo5jV2NHi03in8lJhOJHfEhI8vffwCCNivEXN2IslY+b55wDcqAC3XDU7qC+48AcVUSiIrxqZdEv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714959573; c=relaxed/simple;
	bh=aacOz0pUwATFUStwLMlhB9UWZrlRQrXxA3NzCGy+BXQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=o4/wJCbWnz2jfY7fAhb9ilc/DlohdSmkrl/hYBEANqq8D3TR3dfWdXYeJA3OvRQ/oxqmaPjnDJqwzp4mf3+/GX8MjoqmiIlDEJTXg8lFGcStLAgL6EVw2m1WP34Y++yK5pvK0nK19suK/sepzIj2O6d/x/k42haPkVkA/gYEee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=KSDpGGMP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BIubmKFk; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="KSDpGGMP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BIubmKFk"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id B4DF01C0010E;
	Sun,  5 May 2024 21:39:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 05 May 2024 21:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1714959569;
	 x=1715045969; bh=yBy8MkL+/gvM3VaQxgHK33U+0nN9jCwqWWKQt0t+rrc=; b=
	KSDpGGMPsmEst9y7cuKia6F3Llj2BlXElS/fKuCmEYqmO1BZ46v1T0HbEeniRsqQ
	f5a1MgyW4FuDbBz8YUtjOvBOV1vLI9vsZs0WoFVtnv+ZnNpf9KQh8DhMODyrmfQe
	MMJ83wdDq5IVEs0ecM7Lq5t7KLBZU3UInOmN4vxREq+1atYOrcyMM7pu6cGsZWpp
	p0I0tL4Y4vsUuzhdHc19weGpuR0EVye0LpMeWpmgbHKg9gE9VS9F/NKRmXxiUGwO
	EKQ7JrnRGAuEXh3t/3hEKwsBMwFCwei6PG4UMydby/yrtCM07FXlUmTwoEW8RJkO
	bZihGbdon2IH4nKXhSh2tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714959569; x=
	1715045969; bh=yBy8MkL+/gvM3VaQxgHK33U+0nN9jCwqWWKQt0t+rrc=; b=B
	IubmKFkwWDtJ9VwQ0tXveSzo1/H+0c2NC4hTq8Xh/Q1OgBTiJy8TkrCJ8c+mCwlA
	LNTBzan6obLKt6IwF5Dg1BjDf567Q+2M2MDqajkWmEiBXMW19a85CA+WoDdh0F/N
	GxImsfJbNz3ie4Ee2oREzl+/+w+/IQZ6630VmHppNNLYxnIMEQK3w1RofIsEg04U
	VXTmYX2qa2F5Mg0/sGibld+uMMqOTRQG+MxS+5Zc+/xicSd1Dgww2H5/gN6zzB8E
	psgdFYG8CHGdyJc/iQmGkRClQC/SixgrsewhO2sM7/9rrtFc7cKDyK3Cz7k4iLQ7
	0MEE2UNnhuorTv1CTzlmA==
X-ME-Sender: <xms:0TQ4ZnnXWAMPtVzC2-VkOhvx4hD1zQmI97GnsYwAFPToBhceS3zxzQ>
    <xme:0TQ4Zq2Q7BfyLrEXf2Uf47f_3XT8h2Bn1xvCfAEF0k0sZ7aatGaf8wjGZFCFh4gzg
    oTeAd0YJoc73NumZw>
X-ME-Received: <xmr:0TQ4ZtpfkRbK9ryINsSeH1evxW07Js6twtODm-6AZSythFNQqzWUHgGKGWlJutPNkKYLYdCqnWcVHmNaa8VIar76i96JfLfR29CY1Rgu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpegggfgtfffkvfevuffhofhfjgesth
    hqredtredtjeenucfhrhhomhepfdflrghmvghsucfnihhufdcuoehjrghmvghssehjrghm
    vghslhhiuhdrihhoqeenucggtffrrghtthgvrhhnpefhteetteehteekudeitdduhedtie
    ejheeffeehjeehudeffffhffejffdvgeeludenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:0TQ4ZvkX3-Wat4hWFOC4OLhg2TTAPIxqzh9Q62BTbkT7XzWARWcBvw>
    <xmx:0TQ4Zl2vVpPwLB14n_tiecmAw32_FxiQAiZQHkCrUx_Le-kgPv7Dqg>
    <xmx:0TQ4ZuvUGG6bDMmEs_dPKpt-8Vzl5Zlkel11kD68mXJU4ca9S0SoaQ>
    <xmx:0TQ4ZpVbH7XkEuyt-DR4RAf3JfMJ9GNnLSSOMdYNIXAFumve7adzoA>
    <xmx:0TQ4ZjBrU63PNHKSQXjN4P2rfadJgYLIsnTPikv8II9Zw21nTHN-QpES>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 May 2024 21:39:27 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 May 2024 11:39:25 +1000
Message-Id: <D126FGCB7EYO.37L0VVA4ZH43L@jamesliu.io>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] doc: clean up usage documentation for --no-*
 opts
From: "James Liu" <james@jamesliu.io>
X-Mailer: aerc 0.17.0
References: <20240430014724.83813-1-james@jamesliu.io>
 <20240503071706.78109-1-james@jamesliu.io>
 <20240503071706.78109-2-james@jamesliu.io> <xmqqa5l6950s.fsf@gitster.g>
In-Reply-To: <xmqqa5l6950s.fsf@gitster.g>

On Sat May 4, 2024 at 3:30 AM AEST, Junio C Hamano wrote:
> James Liu <james@jamesliu.io> writes:
>
> > We'll be adding another option to the --no-* class of options soon.
> >
> > Clean up the existing options by grouping them together in the OPTIONS
> > section, and adding missing ones to the SYNOPSIS.
>
> Nice. =20
>
> > diff --git a/Documentation/git.txt b/Documentation/git.txt
> > index 7a1b112a3e..7fa75350b2 100644
> > --- a/Documentation/git.txt
> > +++ b/Documentation/git.txt
> > @@ -11,9 +11,9 @@ SYNOPSIS
> >  [verse]
> >  'git' [-v | --version] [-h | --help] [-C <path>] [-c <name>=3D<value>]
> >      [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-path]
> > -    [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--bare]
> > -    [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=3D<name>]
> > -    [--config-env=3D<name>=3D<envvar>] <command> [<args>]
> > +    [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--no-lazy-fe=
tch]
> > +    [--no-optional-locks] [--bare] [--git-dir=3D<path>] [--work-tree=
=3D<path>]
> > +    [--namespace=3D<name>] [--config-env=3D<name>=3D<envvar>] <command=
> [<args>]
>
> Looks sensible.
>
> There still are a few options (like noglob-pathspecs) missing, but
> cleaning them up from this part of the documentation is totally
> outside the scope of this topic (#leftoverbits -- we either make
> this exhaustive, or make it clear that this is not exhaustive).
>
> Thanks.

I did notice noglob-pathspecs, but I wasn't sure if it came under the
same purview as the `--no-*` options (where a dash exists after "no").

Cheers,
James
