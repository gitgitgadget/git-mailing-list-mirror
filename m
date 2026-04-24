Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8026D288AD
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052331; cv=none; b=gDyvOJ448AMyhpA6f6Ry5sJnSNUukCU06y284XyGTK62F4qwaxge0DIpyAIImdm6UqRkz7E/B09mnkH8uAiQVOE7sgVZQRfqym1KTGmy6B0WLZNiSn2msP6gWkVuE1UbFFfLTDCB0V5sJ/EyyaCryk6ClwPnZv+jn53DBqmqZ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052331; c=relaxed/simple;
	bh=X11VAVs9KRv1XDUz9ark2/X/c+stbnBFFI9xWxS7aGQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XjPSBq1XjcNvpMTQUWk+zOXXO4bJDq+cf3/BwC8Mm+aUQc8P+To2Ki3UKjtYKvShrIlIrYOXLcYwR3Ltj+vBN4R+cbSj3+iNA5Rhf4pEf4ophWDtSJESIStYVUKFouWHkPmKTQMmefROLtpcbFsLej8PJ8XMBKGE4OpLqmHi5nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LALptvXq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZjaxDrKJ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LALptvXq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZjaxDrKJ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B5558140013E;
	Fri, 24 Apr 2026 13:38:48 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 24 Apr 2026 13:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777052328;
	 x=1777138728; bh=Wesn1Fqt02Fc88gwlUb+WEGbMOH7EMcYxdy/eY82EUs=; b=
	LALptvXqlocKF4luw5yGB8uA4/dYJ4pZTvOeR0D3yh/OhPngpd78MQDGBzgOBvty
	Xh3E0vyEd56iFAY6ZUMu9Gxlr0EQ/Djw6DkSvSBtXdCfKVzAPYqMnnLyUBcfc2wT
	3kYyF9CvaFV5QvdZXFLK35uLeqzoe7OcfAfQd9hJWrRsqtEU7wgRKFYBugokMoT1
	GG5y0c1RtbwOxOtJ3TOjM+a5Z5JurnGSmMGsoyymtBvvowhYSY4JxeKBO/4MDuuh
	8yJ7J0yA/HuMri/2/4rnkFp4Y3vidNwyR1UWWP0hiJ0YzzB//W0olqoiFVG9YBdt
	hyju3DoklbIMtDBU8yXhbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777052328; x=
	1777138728; bh=Wesn1Fqt02Fc88gwlUb+WEGbMOH7EMcYxdy/eY82EUs=; b=Z
	jaxDrKJEQpp0Q6yfHnLRY1olovneGkrYCdQbx+ItvF/B0+C6j2zhnrKOMUm6QdYW
	Q/BhoT3/p+lWqJ3eeulwLKWRvkRrzTSBBQ2Y+xtOef7Gc06l+gpo0p8DSN0PQTge
	z/DamUuh0gBzLb7CIf8WPvyzHu2riFSPWHgGrfFWPGzTdGymwyGE3qcM5sYLqRNm
	TInTe0h27Gn5WqYgrdYhMp6HHbsDs/akyWqv6BQfqzg4uMbXRCVeqOk5uTACgQks
	NmriiP/XSUnSYyGjanCJHbIptINiSTdy98S118V8D7Ljl6Ql9OQuTI+wiy4vWSSg
	Y6CUfOSqgAhTu2YDi15rA==
X-ME-Sender: <xms:qKrrads2_3-rjxjgBlu5d004TbOo4a6gCzT_4dPyciwbHxUAwP1BMPU>
    <xme:qKrraRTxZSJS59ukwX7jOTkmQSvx8s02W7tIh2uAuiFev0vFMntgqZrx3G26Q3-Nu
    T-1zZLrhONA_fkpmc7Q8XDburPQlxfIZYMNmE8BmrBByt0h0Zo83g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejtdeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeelfeejudejfffg
    leduheegheeufeeffedtgfeffeevudeuleffgeektdelueekieenucffohhmrghinhepgh
    hithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehhrghrrg
    hlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qKrraRqstoaiQTUWN5Wim6wVUkQjXYpJE816_bTjKzA8Kw7SkVz3-A>
    <xmx:qKrrabYmKZcpLZnicv7wXFCweaR8GQWmPIdnEuUwgYCVSTXGch-EBg>
    <xmx:qKrraRR7dkMHEwwZxqQaVPZGjDVN6t1BHiNRP6_9OdvJUJQCqvVFWw>
    <xmx:qKrraa7gBwWjOGpNxjk3T0PcQq8gPcoz8vYBNi0xaOvZynGJwahe6g>
    <xmx:qKrraWp3QQWthSQxmMTNeGp123o7vTXtRLTUmgclLm3iPZZxgARPZ5Oj>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8049D1EA006B; Fri, 24 Apr 2026 13:38:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9iHKXlPzkr3
Date: Fri, 24 Apr 2026 19:38:28 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org, gitgitgadget@gmail.com
Cc: "Harald Nordgren" <haraldnordgren@gmail.com>
Message-Id: <89f923bf-e5fc-4557-a2f0-d240db07eaf9@app.fastmail.com>
In-Reply-To: <pull.2281.git.git.1777024991531.gitgitgadget@gmail.com>
References: <pull.2281.git.git.1777024991531.gitgitgadget@gmail.com>
Subject: Re: [PATCH] checkout: add --fetch to fetch remote before resolving start-point
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026, at 12:03, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Add a --fetch option to git checkout and git switch, plus a
> checkout.autoFetch config to enable it by default. When set and the

Why is the config not `checkout.config`? So it=E2=80=99s named the same =
as the
option (modulo snake case/camel case which is not relevant here).

> start-point argument names a configured remote (either bare, like
> "origin", or prefixed, like "origin/foo"),

It=E2=80=99s great that it only fetches when you have a remote-tracking =
branch
or alias for `<remote>/HEAD`. Doing a fetch on every <start-point> would
have been bad.

> fetch that remote before
> resolving the ref. Aborts the checkout if the fetch fails.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>     checkout: add --fetch to fetch remote before resolving start-point
>
>     A workflow I run several times a day looks like:
>
>     git fetch origin
>     git checkout -b new_branch origin/some-branch
>
>
>     The first command exists purely to make the second one see an up-t=
o-date
>     view of the remote. If I forget it, origin/some-branch points at a=
 stale
>     commit, and I end up creating a local branch from the wrong starti=
ng
>     point.
>
>     This series teaches git checkout (and git switch) a new --fetch fl=
ag
>     that folds the two steps into one:
>
>     git checkout --fetch -b new_branch origin/some-branch

The motivation for why this is being proposed maybe might as well go in
the commit message. Maybe that=E2=80=99s just me.

The commit message just says that =E2=80=9Cthis thing is added=E2=80=9D.=
 Not why.

>
>
>     When the start-point argument names a configured remote =E2=80=94 =
either bare
>     (origin, which resolves to the remote's default branch) or in / fo=
rm =E2=80=94
>     git fetch is run before the start-point is resolved. If the fetch =
fails,
>     the checkout aborts and no local branch is created.
>
>     A new checkout.autoFetch config option enables the same behavior by
>     default, for users who always want it.
>
> Published-As:
> https://github.com/gitgitgadget/git/releases/tag/pr-git-2281%2FHaraldN=
ordgren%2Fcheckout-fetch-start-point-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git
> pr-git-2281/HaraldNordgren/checkout-fetch-start-point-v1
> Pull-Request: https://github.com/git/git/pull/2281
>
>  builtin/checkout.c    | 48 ++++++++++++++++++++++++++++++++++++++--
>  t/t7201-co.sh         | 51 +++++++++++++++++++++++++++++++++++++++++++
>  t/t9902-completion.sh |  1 +
>  3 files changed, 98 insertions(+), 2 deletions(-)

I guess a later version will have the changes to the documentation.

>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
>[snip]
>  		argv +=3D n;
>  		argc -=3D n;
>  	} else if (!opts->accept_ref && opts->from_treeish) {
> @@ -2052,6 +2092,8 @@ int cmd_checkout(int argc,
>  		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode
> (default)")),
>  		OPT_BOOL(0, "auto-advance", &opts.auto_advance,
>  			 N_("auto advance to the next file when selecting hunks
> interactively")),
> +		OPT_BOOL(0, "fetch", &opts.auto_fetch,
> +			 N_("fetch from the remote first if <start-point> is a remote-trac=
king ref")),

s/remote-tracking ref/remote-tracking branch/ ?

git(1) doesn=E2=80=99t have a namespace for tracking refs in general.

>  		OPT_END()
>  	};
>
> @@ -2102,6 +2144,8 @@ int cmd_switch(int argc,
>  			 N_("second guess 'git switch <no-such-branch>'")),
>  		OPT_BOOL(0, "discard-changes", &opts.discard_changes,
>  			 N_("throw away local modifications")),
> +		OPT_BOOL(0, "fetch", &opts.auto_fetch,
> +			 N_("fetch from the remote first if <start-point> is a remote-trac=
king ref")),

Ditto.

>  		OPT_END()
>  	};
>[snip]
