Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DB820B20
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411653; cv=none; b=V/bhgzHEtHRw5Jk9/GjAAUpYWzy7m+vkoGYcHe4BmcTcPGfgpMpQOqquW4H4gICEdmRaUfVmuElQDe45UPxE4cDWiMXksJb9FtWpa96xKANo6Dy3e7h8rVH7pQywtqLs/s7OQr0uTYoQEfx5oH3DaRdsTCk0gDQVpn+zC9Pzwhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411653; c=relaxed/simple;
	bh=+NduoJ7cYHnfgydMCvSxpnKfFEJ+wKEtxZqnQe+LpgI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HetVXt8v+HAM4iiilyXOBZfV32aAdMEP1F6d4Hg1xxYKQAo+ewC8R0tRMuErJC4pm8txs4m8iM2kGUYTq7YejTw3TtHB6+TbvMzxBRY77p36EhDCPochxae6GADPTbTXSKb1LyjwqC1pu0HaPuQ4S7NIX6U9uuQ7YUa79jBo714=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aH7OMWiK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n9xLV/7Q; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aH7OMWiK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n9xLV/7Q"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 691B213804FD;
	Tue,  8 Oct 2024 14:20:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 08 Oct 2024 14:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728411650; x=1728498050; bh=5O4iXoNyPf
	YvcnKA0mlxIViQpKzKq0Vg7iwVZFdIfwA=; b=aH7OMWiKnvhODI66wKGMhKcjCt
	kC5tStGvdB+JCaZDZv/O4WiZqxvgL5xE+XzZZwfvqYJk22gLiIpCQZa387DzOdF5
	k9sQoB0q8TeXKX9RuyWgfBa2jbcNtemZ4+MXOz6Lr+lc7EafQvvSxK4irF4bDPkH
	whKLA+IT96OeXoWyjn51VhGE+K4JVNkGrWiIvFEfRbgdfLBlwmNv9aOLcio86ukB
	wqOVkp6O9hngxHxTa7AnRx1CwuVOtXeQuF/DYqiGE7bXUB2Tcf4JFmrNJL26Z5dw
	WpOjvAbXaneFEsjDy08fMBUM1ZVQkL2UclqEhPxClNNuo0gVxQihqXpV0Ncw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728411650; x=1728498050; bh=5O4iXoNyPfYvcnKA0mlxIViQpKzK
	q0Vg7iwVZFdIfwA=; b=n9xLV/7QUaNilK3fp1mY0ak5hyahlaZ+Hsba6bmidF8Z
	bUqZKgAoTE46ILDOkmCYJAVv0n2S1CAlsZawT79XOP51wtAYnqhJSjtUmahVhvJK
	/EB2QYwKRiEAFQDi4L0rLKcC5ZgrKsYl3/UzJmn8YrdfHH5yN/AdQFL/KsvR9XIf
	eBQQmtnnQxUbAT9+96sAQRqyQsNaQ1tZt9Wq4lhhzO9PnMyzttq+Ccc3M5GK01mN
	hZkhSOqz9QNmITYPXGG9Id71WhLDhwY1yh68F5EqqbBOQ9Uh5yjOJg4LbQJ96FlP
	hGBksTRQRbZAiEdjmmCnbjWcVS7RbzuuY++Yhq1uqA==
X-ME-Sender: <xms:AngFZ33h7PFuyeeZbwMLYnH3JnZum3pC0iQ9VBzusioEovuPVNiliA>
    <xme:AngFZ2FspGHNSN3r2vVSFQTbN3kduNG8YQBXnmv66obEKAD6CYW8cxiVcrUgyVCSZ
    C6f-u3LrJdGCnMuyQ>
X-ME-Received: <xmr:AngFZ36jLUtpJQFn9LCdVxJNkjf3eZouFGXmJWhDqcOBjgC4f5RPK_ZVgvZ7p1C8i1zWQ9czrYiKBIIP_-ky-MIFAyntMm3BTZ6B1-k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhshhhihhgvih
    hnrhhitghhshesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AngFZ808XUQ6uzG0uVWQWR-hWQX_lwg4Yk7i_CIiH1nPymnZbpp86Q>
    <xmx:AngFZ6HVku__hAYorzjj06Q_foHYCIT3xGB1qNZ2SozszMX5wJXsRg>
    <xmx:AngFZ983xvyO3Vm4NkS2Praf6cJBpz5RVj34Ixr91rfH5MhIxuUejw>
    <xmx:AngFZ3m1yQyVqD4dnqU-EOHrOu69dMRd3Nn-VvgXF_jj38IKOpJ-cg>
    <xmx:AngFZ2gaJaS3_O2KbFDtRLitc6q3C9uTg7V8KbcCNyldzlj11mAldPb6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 14:20:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Heinrichs <joshiheinrichs@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 1/1] git-config.1: remove value from positional args
 in unset usage
In-Reply-To: <20241008142920.570244-2-joshiheinrichs@gmail.com> (Josh
	Heinrichs's message of "Tue, 8 Oct 2024 08:29:20 -0600")
References: <20241008040749.69801-1-joshiheinrichs@gmail.com>
	<20241008142920.570244-1-joshiheinrichs@gmail.com>
	<20241008142920.570244-2-joshiheinrichs@gmail.com>
Date: Tue, 08 Oct 2024 11:20:48 -0700
Message-ID: <xmqqfrp61mnz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Heinrichs <joshiheinrichs@gmail.com> writes:

> The synopsis for `git config unset` mentions two positional arguments:
> `<name>` and `<value>`. While the first argument is correct, the second
> is not. Users are expected to provide the value via `--value=<value>`.
>
> Remove the positional argument. The `--value=<value>` option is already
> documented correctly, so this is all we need to do to fix the
> documentation.
>
> Signed-off-by: Josh Heinrichs <joshiheinrichs@gmail.com>
> ---
>  Documentation/git-config.txt | 2 +-
>  builtin/config.c             | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Patrick, do you mind to forge your Reviewed-by for this one?

Will queue.  Thanks, both.

> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 7f81fbbea8..3e420177c1 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>  'git config list' [<file-option>] [<display-option>] [--includes]
>  'git config get' [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<value>] [--fixed-value] [--default=<default>] <name>
>  'git config set' [<file-option>] [--type=<type>] [--all] [--value=<value>] [--fixed-value] <name> <value>
> -'git config unset' [<file-option>] [--all] [--value=<value>] [--fixed-value] <name> <value>
> +'git config unset' [<file-option>] [--all] [--value=<value>] [--fixed-value] <name>
>  'git config rename-section' [<file-option>] <old-name> <new-name>
>  'git config remove-section' [<file-option>] <name>
>  'git config edit' [<file-option>]
> diff --git a/builtin/config.c b/builtin/config.c
> index 97e4d5f57c..d60e106bd6 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -19,7 +19,7 @@ static const char *const builtin_config_usage[] = {
>  	N_("git config list [<file-option>] [<display-option>] [--includes]"),
>  	N_("git config get [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<value>] [--fixed-value] [--default=<default>] <name>"),
>  	N_("git config set [<file-option>] [--type=<type>] [--all] [--value=<value>] [--fixed-value] <name> <value>"),
> -	N_("git config unset [<file-option>] [--all] [--value=<value>] [--fixed-value] <name> <value>"),
> +	N_("git config unset [<file-option>] [--all] [--value=<value>] [--fixed-value] <name>"),
>  	N_("git config rename-section [<file-option>] <old-name> <new-name>"),
>  	N_("git config remove-section [<file-option>] <name>"),
>  	N_("git config edit [<file-option>]"),
> @@ -43,7 +43,7 @@ static const char *const builtin_config_set_usage[] = {
>  };
>  
>  static const char *const builtin_config_unset_usage[] = {
> -	N_("git config unset [<file-option>] [--all] [--value=<value>] [--fixed-value] <name> <value>"),
> +	N_("git config unset [<file-option>] [--all] [--value=<value>] [--fixed-value] <name>"),
>  	NULL
>  };
