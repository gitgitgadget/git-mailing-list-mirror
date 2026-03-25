Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E565840243E
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774460121; cv=none; b=usr1sK7fQZeFA1b2/txSdOaaqRLgiGm2dfYWsV1X1qKH0KDVOqffoeFvQtZu8nH7e4GkUABfnokGhki+T1HEgkknz16uqwvteLWYQsQHccD2RQkefWWgiDGQS5ZXbImYf5nHM1zFOMv5AZpXO6OhbjGazdynXDAFFkx26hOLWaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774460121; c=relaxed/simple;
	bh=IT+4v/tbCIUvCSH2MjRl2bFb4bDm4zq0uZ8p1WZ50L0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gjDmnXkATcm0FBEoiiSEtdKd5yyOhpr3idSPMbI9QzWXYKft9YY5WCHMLqabaLKv4qZIJAYmGA/3CPCXUEowBRJSqWIpDu0iMV6cbd5K/g8jZ0/qHDJQi1ZuW1+PQIqoYn0GRmKRL5Orb/nwF2abJOKvcdM2/oP0y7wQ5rysIT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AMoz0ok7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3uvmkunw; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AMoz0ok7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3uvmkunw"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 309ABEC0189;
	Wed, 25 Mar 2026 13:35:19 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 25 Mar 2026 13:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774460119; x=1774546519; bh=Le538OSvlk
	SPuyjWmtt1l71If6RhmokSqZSez2+vyEo=; b=AMoz0ok7VJmxatrepCtsB1ZpKv
	grWLjbycqSkvz3J/V1jurr2jQWbnc4LiRlrqYy65Wgtx5+Lq9Ct2FHewbQlnBdhy
	+S8Zi/nq50ytOhhJi2kyKL6YBCzBTIkcRLy1RzrIKm+GgXNCtgDgNEPeRyqzZUrr
	7cqUSLn7t7W6pnLygFxeMv5yuXfnB41Ctsq2VHC08uLf9NViCaXK2pCMoejIzqnP
	T/+DaPsZcZ7Xt+QvMVZiy0gWF36h28rw/qqoecwln1AjZbuUfmtOZjnIoD741C3Y
	pvdtcUJStQyrvlSU5B/LlJ7f+JTWT3MPvznyGyLZBjxARBPuX3o4ePKY0s1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774460119; x=1774546519; bh=Le538OSvlkSPuyjWmtt1l71If6RhmokSqZS
	ez2+vyEo=; b=3uvmkunwGoV0Nr82xf5aJ09hbuffUe6JRHqYJERNTsJCgrnQm7N
	eyfqMZkhykA/R8/xcwbi54gWWBeIZWLE+gSgpA6Q907F87EiDlkZ2/xeHOGe5T+o
	XTOfUfSXFgA5ZW43f65n2O1IP5zXID8cl+tgsD2Rc5D7L9Kb9sQUxm5pXv4oBIxq
	x8CW5zN/J4AUqwewsRBDcwOb7Lr3Aoq3Bt6GAFv7VZdGs1+wAmKhZNQAv3tQPvXf
	BgBEMGHeXDvSwm289E+iXHMFOhoWT30ok31tmmTEotknVQM+8mns4dW0fuisq6Nz
	PoWXo3SD+TbKm4Ird9r5fbWOfE7GPKr4acg==
X-ME-Sender: <xms:1xzEaXQOnKIaVzOp0_juaxXCDd4WzjxLqNiUQbs1d1dzhF6T0eI1MQ>
    <xme:1xzEacegz1M-UuDfkE4mTo0FgUm69mJA6x0ZjVdGKKTot1S7HzAf-i8pCy-a_Hkr-
    rNGHtBocvcXz_yEC_SN_PLc4VFjoQBA9vB3P5tCk8G-0E-lV9VTTw>
X-ME-Received: <xmr:1xzEaWqZEUwRpS3gtAQ0IEb90yJbrc3WLqOITeMuGAqJsgVJlHNcHMBEuDQqtEXT_wfaJdDuKVgxd_GJZUzl2DDnDw96R_1yFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgrhhhlvghtrdhtrghkrghsshgrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtth
    hopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvges
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1xzEad_9-HBUc_WG2qsFjHsaP2PQ1nJS6W4Wc2odJkA9JBE3BONJOQ>
    <xmx:1xzEaSdBJKASg_Lb-hyF6SDe4FLzcAya-G8E9Rqsz6Poxg3haRLAlQ>
    <xmx:1xzEaXLmHDPSzYoWzUf9oAwqc5hsvvRj52iGHWtoxvMr6sGc2Lmsfw>
    <xmx:1xzEaSgBeRV5puZuY04UuYTSLr1lk9btaPafm2-CkaOiSEgI3QPW6g>
    <xmx:1xzEaQ081WxQKx8SeR3uGInwDqfO-9wHklahkHO268JNx7uFncaC39G3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 13:35:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mahi Kassa <mahlet.takassa@gmail.com>
Cc: git@vger.kernel.org,  lucasseikioshiro@gmail.com,  jltobler@gmail.com,
  stolee@gmail.com
Subject: Re: [PATCH v4 1/2] repo: factor repo usage strings into shared macros
In-Reply-To: <20260325115148.101867-1-mahlet.takassa@gmail.com> (Mahi Kassa's
	message of "Wed, 25 Mar 2026 12:51:47 +0100")
References: <20260325115148.101867-1-mahlet.takassa@gmail.com>
Date: Wed, 25 Mar 2026 10:35:17 -0700
Message-ID: <xmqqqzp7vmlm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mahi Kassa <mahlet.takassa@gmail.com> writes:

> Factor the "git repo info" and "git repo structure" usage
> strings into shared macros so they can be reused in multiple
> usage arrays.
>
> This is a preparatory refactoring for subsequent changes to
> subcommand-specific help output.
>
> Signed-off-by: Mahi Kassa <mahlet.takassa@gmail.com>
>
> ---
> v4:
> - split the preparatory macro refactoring into its own patch
>  builtin/repo.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Looking good.  The distribution of commas are sensible, too.

> diff --git a/builtin/repo.c b/builtin/repo.c
> index 55f9b9095c..b5146499d0 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -20,11 +20,17 @@
>  #include "tree-walk.h"
>  #include "utf8.h"
>  
> +#define REPO_INFO_USAGE \
> +	"git repo info [--format=(lines|nul) | -z] [--all | <key>...]", \
> +	"git repo info --keys [--format=(lines|nul) | -z]"
> +
> +#define REPO_STRUCTURE_USAGE \
> +	"git repo structure [--format=(table|lines|nul) | -z]"
> +
>  static const char *const repo_usage[] = {
> -	"git repo info [--format=(lines|nul) | -z] [--all | <key>...]",
> -	"git repo info --keys [--format=(lines|nul) | -z]",
> -	"git repo structure [--format=(table|lines|nul) | -z]",
> -	NULL
> +	REPO_INFO_USAGE,
> +	REPO_STRUCTURE_USAGE,
> +	NULL,
>  };
>  
>  typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
