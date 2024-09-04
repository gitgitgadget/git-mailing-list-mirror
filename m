Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC0829A2
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 01:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725414420; cv=none; b=nG7Mub/w2Hu7iO6WMvpMqzFfq3Fj5UytcZYrOGvOYsE+CaqcEyfgZ72qAYtdygU5hQJYTSXO0PdyJM+bZVO53sNkqaokyBuJZ5VYxXI1czXkb5teoG4e1OXjhLaUYTqv7ZNKh4Jh8FE5y6TgQzhrlJkM19krcseqT75g1/tjYDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725414420; c=relaxed/simple;
	bh=AVE/OeFPs0m8Hz3i3XO/Vvz+/vxRBEXHjQPf3LG5keU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Jymm9F5DHFjmyxefWGxQ2HG9zCCW97tyOinLd6acZz946frFWgD/Qe5EfnHDStyEYdaOO0zHFR8RXkEIBf7mE6bVIBwzCQA8UHM8hhvynHTsVBm/tbZn79YJB2kXHyZNBSzRA5LBimInrq5DDbvgcyuV+DG3y/5oa38DxgjYo1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=gnY13MDq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l0uKDfEl; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="gnY13MDq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l0uKDfEl"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 117481380287;
	Tue,  3 Sep 2024 21:46:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 03 Sep 2024 21:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725414417;
	 x=1725500817; bh=Duf25Tt82rtylQIBpqV/VmQ6pRPVwMaoW9Y7uCmu+eg=; b=
	gnY13MDqQgtE0l6B9Ba345RaW4mmm764QMKKELUL0z7NaUIbg7y1vkU8ElT9cDQj
	OcRFMfTakNS4ga3mDFFtiTTqX9COETlpddImifJWYv1yhm8H1u7l+3RKkUzWQIam
	OI4zWunhxm3/Jd1z9CCYufMtugnE05pXcTZHmI9Ulli+fIvp4iFSuaV4tx2sbVPE
	s8dXumOrjoRZnZYVKMGFrcp4xQd5XoXOWlabYY+0gzMFzTkOKRREUQ4kpTCOVcTh
	s1lx3T4tPvDY1AAZmuACGbsNfKpItSUEFnAYxOAgnqDMKpfrNyyWTRftngmhnmYL
	vJvNetHB503rMeE7d1q7zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725414417; x=
	1725500817; bh=Duf25Tt82rtylQIBpqV/VmQ6pRPVwMaoW9Y7uCmu+eg=; b=l
	0uKDfElnh4Nmjbd0+AaBwZUrNbezZtgRJYllNPp1osyJlQnGQXIv54O3YiLPzzZT
	F8GHMK3teO+pNUs33nTqYruj1xaL7FvQMwWls7wAaW35o3Voi+1s23TJo+8WcOBU
	aeuXMZQzBmA1h+BbiMw1njhtQL3+KG1cvjlrT/9tthJQJ4tty8pMX1YQvKAyxV1q
	TbmoJrrCkKURSIhd24QNqVEPvqLBVjO6cOFhw/+mSIjq4fQLiBausTvN5/w55ccS
	WDEUHiOCbaXW/kDhRNJHXmvZWgBPEK0C59i/Eedxe/X7s5lllVwjxW4jyMzs2QYp
	GBppjf/8r0/flUm/sbQOw==
X-ME-Sender: <xms:ELzXZmEzn-GJj2PjUeM1h0fS8BxiGpvDv6d57raK4gnY5DCfOyL1Zw>
    <xme:ELzXZnUiVNwfPVq2kwnjEhjoqoXzd_XyWTUYS_ZORSzX21JtvKMeDvVLJL3h4u_zH
    mwQJyMDGghfAaAOtQ>
X-ME-Received: <xmr:ELzXZgIiBJhKSxWvIU8rND7n5sSHliR-tCCN1OUE6y2yZHi8JKa3lebmTXUl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehiedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepggfgtgffkffvvefuhffofhgjsehtqhertdertdej
    necuhfhrohhmpedflfgrmhgvshcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurd
    hioheqnecuggftrfgrthhtvghrnhephfetteetheetkeduiedtudehtdeijeehfeefheej
    hedufeffhfffjeffvdegledunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdpnhgspghrtghpthht
    ohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggr
    lhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ELzXZgGzC8s1W0E0yvqNZ7puu90UXgYyDBFX74I24FxeyeLu4WJw3A>
    <xmx:ELzXZsXh_RUAo2Jdz5NTsz5r8nNDtnVJlKu9WIR9i-mRPlW53Xilmw>
    <xmx:ELzXZjO7cu6evtKHkdRLgkKOJvuqiMmMJZpHGHwD_UHW4xjX9tzbtw>
    <xmx:ELzXZj0Yq9q1cQG7R4nWlRd4-bRU-kzIp3Tw4HuVWk5pr4wuq6Mplw>
    <xmx:EbzXZmeEfbgg2Q5wWA-mL6EEGeTNG8CrP72eUlTKRJQzED7rYQIq9QWf>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 21:46:51 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Sep 2024 11:46:47 +1000
Message-Id: <D3X4D0DUL3TS.1FAOC0KJ08D9L@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
Cc: "Calvin Wan" <calvinwan@google.com>, "Justin Tobler"
 <jltobler@gmail.com>, "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [PATCH v2 08/21] config: make dependency on repo in
 `read_early_config()` explicit
From: "James Liu" <james@jamesliu.io>
X-Mailer: aerc 0.18.0
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
 <b8aa5dcc0b67e3957dc65f38b7dc02a97cc096a7.1725008898.git.ps@pks.im>
In-Reply-To: <b8aa5dcc0b67e3957dc65f38b7dc02a97cc096a7.1725008898.git.ps@pks.im>

On Fri Aug 30, 2024 at 7:09 PM AEST, Patrick Steinhardt wrote:
> diff --git a/config.c b/config.c
> index a8357ea9544..043e1c8a078 100644
> --- a/config.c
> +++ b/config.c
> @@ -6,8 +6,6 @@
>   *
>   */
> =20
> -#define USE_THE_REPOSITORY_VARIABLE
> -
>  #include "git-compat-util.h"
>  #include "abspath.h"
>  #include "advice.h"
> @@ -2204,7 +2202,7 @@ static void configset_iter(struct config_set *set, =
config_fn_t fn, void *data)
>  	}
>  }
> =20
> -void read_early_config(config_fn_t cb, void *data)
> +void read_early_config(struct repository *repo, config_fn_t cb, void *da=
ta)
>  {
>  	struct config_options opts =3D {0};
>  	struct strbuf commondir =3D STRBUF_INIT;
> @@ -2212,9 +2210,9 @@ void read_early_config(config_fn_t cb, void *data)
> =20
>  	opts.respect_includes =3D 1;
> =20
> -	if (have_git_dir()) {
> -		opts.commondir =3D repo_get_common_dir(the_repository);
> -		opts.git_dir =3D repo_get_git_dir(the_repository);
> +	if (repo && repo->gitdir) {
> +		opts.commondir =3D repo_get_common_dir(repo);
> +		opts.git_dir =3D repo_get_git_dir(repo);
>  	/*
>  	 * When setup_git_directory() was not yet asked to discover the
>  	 * GIT_DIR, we ask discover_git_directory() to figure out whether there

It doesn't really matter either way since we perform the same checks, but s=
hould we do

        if (repo && repo_get_git_dir(repo))

instead of accessing the field directly?

