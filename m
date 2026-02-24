Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2650136B05A
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 10:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771930540; cv=none; b=T77MWAF7QIcFxBhmwVN5aEPdsmxs4kn/vamKjMowHCHFTKydOIqkRp5ixwY35mnLJHY79Z3o0ZDAM/zmBy/Lc7wG2O0FqY9LHRh88Ig7F7PfgUraNWwUR4Hb28BpMXI9p6hyDGdSyTwKsQBdpg2SQk8+lZH2GEutCMfpX+1KmRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771930540; c=relaxed/simple;
	bh=2+sUWIIsMUADTPPQiVha9HJD+R9qrmwxWpcq4ocfzUI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VB/Ka54BB3fCQytvfyRdOVloNtsEUBOaHri+0d2dx4wxuja5qLgz73M6Y87U0Tp54fYq7O9pTgZLMW296887UC6a8AtmTe2RJt5B7LuhKuxmENjhSzh7T7Ec6mu+JnxhsT52awP5bTTe1HrlkX13P9UcEm0Y/Uv8pLQ/PHqtOPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=IdLB2H73; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mUFcWQdO; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="IdLB2H73";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mUFcWQdO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6B9BAEC05F1;
	Tue, 24 Feb 2026 05:55:37 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 24 Feb 2026 05:55:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771930537;
	 x=1772016937; bh=teytu0ZSrGxOeVD4i2ZPXUk2bCGZXvQdHFLN3sVq8UI=; b=
	IdLB2H73U5UPVB7fgn7Asxrs5bfllHcVQCN3AW+nVnscibpoZJRpsVBJ7t9CV0l8
	zsCxpJFxwuhn8ctcycwwtX3jqP/VFb6kLMQYVcb7+8ZkBo2HX4i+y+xIJQMomWO9
	4Ug4jXIBs4APgLBku8ZMKIZZIXQwDoMr4NtR/+fT1mXnHaR50U72m6wd6shjD3jA
	srqG/dzTzEz3w+3e4ejWCvrqPBGpKiUK/4T4V9o4CS3h69NNpVqUHekD9jmockDz
	+xmcMn0xG4KugOlf+vM66Xlev9YhvmsYuaQLAVTKQoWaFHBUQs7wLdIFwDVPLPgt
	2nBjRiC4UpgagLqQKHDp6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771930537; x=
	1772016937; bh=teytu0ZSrGxOeVD4i2ZPXUk2bCGZXvQdHFLN3sVq8UI=; b=m
	UFcWQdOnH2r8iOxVke5Ki8dY0TOqW8b9aOC5the7bsAH33NiDhhWddHIDktzYgSD
	HmwE94N+D3Qbx/Qw80Wt/peAqf1/vlUzroemhuSDONLTSCESz35GQjkdlcf1RNxA
	B17wf50xwHNDjdpaF/jenkw0uj3vo2t42i2NPWODW31h6kl3m/iSgLa02kB3I3aY
	lakGn0Ol+1tGNZB/3a4bWXez6WnkbXt9JBMPHSuh4bPLLKBC3Z76TqfxF/Xv5XAn
	86QoIjCduO6G6tt7oZc+wmrFoktsl52m+o/fCADvQqoaG+tQHJbTKCOBzb1UcYZr
	hTdMQWfZ8F1D0n+rEUjQQ==
X-ME-Sender: <xms:qYOdafXnLjsTimG4wU_UbN5J6dv69Vb6jhFibv-qv7evU6l-YogF_aY>
    <xme:qYOdaSa1yX4IBMXU-xMWc6DSTQHJWu9sWAaafLnYs8-3yghiqa7s4aJ69KA6ewpye
    cFvmSJY4lu9LbIeqFUyzFZcxur6hpuaIVd0fYbBom7guZIi68zCiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeelleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvthdprhgtphhtthhopegsvghnkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhonhgrthgrnhesjhhonhhtvghsrdhprghgvgdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qYOdadAk-zl_G4ozVEjG-j789p98jajDBBfMwq-VJT8XKHPFcBvJ9A>
    <xmx:qYOdaU38roZdAmAmmzGtGsLE9bCjRRSRKpla4HWsFH2f67f0JNDKGw>
    <xmx:qYOdaf1poFLBaM7G1Wv_OxgZ_9E_MuB0suw-XFdLqp9xVL-jjicOYw>
    <xmx:qYOdaZCN8vcSMXsLsn7z__63zdTMTMcc1XSAopvpNTfsq5ZJLlR3XA>
    <xmx:qYOdaXy_zJR_ZkB4oAhcyAi3kUUXbeLC2RMjXR8DEAL5NSYcyMSG0E8m>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1D0681EA006B; Tue, 24 Feb 2026 05:55:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdFosU1OfSzV
Date: Tue, 24 Feb 2026 11:55:16 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jonatan Holmgren" <jonatan@jontes.page>, git@vger.kernel.org
Cc: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
 "D . Ben Knoble" <benknoble@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Message-Id: <f1f37010-2e93-4e11-8298-420cd8931d62@app.fastmail.com>
In-Reply-To: <20260218215737.1181147-4-jonatan@jontes.page>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260218215737.1181147-1-jonatan@jontes.page>
 <20260218215737.1181147-4-jonatan@jontes.page>
Subject: Re: [PATCH v7 3/4] alias: support non-alphanumeric names via subsection syntax
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026, at 22:57, Jonatan Holmgren wrote:
> Git alias names are limited to ASCII alphanumeric characters and
> dashes because aliases are implemented as config variable names.
> This prevents aliases being created in languages using characters
> outside that range.
>
> Add support for arbitrary alias names by using config subsections:
>
>     [alias "f=C3=B6rgrena"]
>         command =3D branch
>
> The subsection name is matched as-is (case-sensitive byte comparison),
> while the existing definition without a subsection (e.g.,
> "[alias] co =3D checkout") remains case-insensitive for backward
> compatibility. This uses existing config infrastructure since
> subsections already support arbitrary bytes, and avoids introducing
> Unicode normalization.
>
> Also teach the help subsystem about the new syntax so that "git help
> -a" properly lists subsection aliases and the autocorrect feature can
> suggest them. Use utf8_strwidth() instead of strlen() for column
> alignment so that non-ASCII alias names display correctly.
>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Jonatan Holmgren <jonatan@jontes.page>
> ---
>  Documentation/config/alias.adoc | 50 ++++++++++++++++++++++-----
>  alias.c                         | 38 ++++++++++++++++----
>  help.c                          | 14 ++++++--
>  t/t0014-alias.sh                | 61 +++++++++++++++++++++++++++++++++
>  4 files changed, 145 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/config/alias.adoc b/Documentation/config/al=
ias.adoc
> index 80ce17d2de..09a6499249 100644
> --- a/Documentation/config/alias.adoc
> +++ b/Documentation/config/alias.adoc
>[snip]
> +# With subsection (allows any characters, including UTF-8)
> +[alias "h=C3=A4mta"]
> +    command =3D fetch
> +[alias "r=C3=A4tta till"]
> +    command =3D commit --amend

This is in `next` now so this is a question or note for later.

Is this `r=C3=A4tta till` supposed to have a space in it? Or is there
supposed to be a hyphen? I couldn=E2=80=99t get it to work.

Is the intent to use quotes for the command (in e.g. Bash)?

    ./bin-wrappers/git "r=C3=A4tta till"

> +----
> ++
> +With a Git alias defined, e.g.,
> +
> +    $ git config --global alias.last "cat-file commit HEAD"
> +    # Which is equivalent to
> +    $ git config --global alias.last.command "cat-file commit HEAD"
> +
> +`git last` is equivalent to `git cat-file commit HEAD`. To avoid

This is also a note for later. I think this =E2=80=9CTo avoid=E2=80=9D s=
hould now be
moved to a separate paragraph since it=E2=80=99s a different topic.

Sorry that all my feedback is this late! These are just notes for the
list in any case.

> +confusion and troubles with script usage, aliases that
> +hide existing Git commands are ignored except for deprecated
> +commands.  Arguments are split by
> +spaces, the usual shell quoting and escaping are supported.
> +A quote pair or a backslash can be used to quote them.
>[snip]
