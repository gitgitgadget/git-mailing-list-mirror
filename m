Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA391DED40
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776280613; cv=none; b=X5TQf48CGfsxqdQ9v7ZWpQiFePztOoHqpOGUQuxTNgykDOmq9TyGiQEKENmE7o9+G9lz/m2MYpBCydKv9QXt1uLq0HBRQORtJMzzerx6jmyH5ml08XDxJG1ckbzQMXJx+ZrQRx8CXxmBCmkkpdrRSDopAe95uXSFyjEuQ/qdCUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776280613; c=relaxed/simple;
	bh=1MHJ+AH2lvkJsCdhKQh63TrRpdc8AAX45G23uEGmdvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G3pue6sAm3ShwG4lvm+AqPplSc98KhyacqP52+6LsMzfUYHplwiefSDGQuShZ2PthvJGCwHirh02uWCkD1+snvTCi66jYDVT5bgqwDdgmWvB40RpybJx5QPp1dGm1JUD3g+QWjAFb3ZHLVIq5ja7zr52T/yE4xBr+h/d97HIIZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tN2ZkzNn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l6AogqDp; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tN2ZkzNn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l6AogqDp"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6D3227A00E7;
	Wed, 15 Apr 2026 15:16:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 15 Apr 2026 15:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776280611; x=1776367011; bh=Sz2I6zohuL
	b6tQ1DorH+lu0pxl9kW0+i8MBy0K1xDhU=; b=tN2ZkzNnsehG8HYfJ/SGwUxE08
	ACCzg8HiRm3pgpgc/lNMpEWO6HRUdzCvCJ3qANK5hNv6uZtrVRzDiShwp/eAmbdO
	GY9+gacrxchlhp/O74ZSArblmL89Xb93YNWvwGl5h+Ju+qk+uPmp8w4nZ677flh6
	jimyWqE8EHQJCt+UAna5mVTZ/hSBE7m5HoPkEbn1xUttJSQLnl1gD0CwLEa0J8l2
	acAR+E6FICPwcoJiuSXzIepANNLzhOw80bz/8BzjEIkK7MeYNTXEOt3tamhqLfWe
	0IRAuCuf5zIzyPFadWa2HQ0TPuh792S8WLukIBq2SXM9njL1v6Jt96AydARg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776280611; x=1776367011; bh=Sz2I6zohuLb6tQ1DorH+lu0pxl9kW0+i8MB
	y0K1xDhU=; b=l6AogqDpg1K3fjAbOsaZYb+lOcGnAf5kWAKHPBGspmn+9UVPziw
	j2Zx6LjHZJ1fkFOijpH0YrFaP89wfaVSV+q7e8Tn51/iURlv3OdjtiBG3NpayX3Y
	dIxpDt6xLCBf87Ra3sX+83BibX02v4WgvObK4GecPSj/JVznK1u/crGLJbZ6hrUd
	3crrOBAMjfr68k0UsH0BXJDCOgivkBJj0HeTHtGaFW6KNwEZjz12R7gw31FrZckv
	Wh+KN7A2RYSPZKos8xADenqNIIIySariL/ni1cg0vjJzccZE9paNJv4ATD66x99+
	2ih7mJ525bokTZj8p5ZCohzFxaoyTbzfhxA==
X-ME-Sender: <xms:I-TfaUxeZ1Zcc3QsG-G85f3bL3tE8dwBUDKWoZsj4XyfTF_Gtw-3TQ>
    <xme:I-TfafJU-JlP1kxT4txgQrSeXk2Tj-ZQO4B-6HhenaisPO5HNFwS-hM34WWyw-lTj
    ucO-buIEK5vFIrW4Jz1D--aSA8M1YVbyxpSfwQ-BgRU0lJh8rAp>
X-ME-Received: <xmr:I-TfaeopOHmHCrEZ8ZtEodsJIU7dt84fB3qndv7jqyfJbSYFzUZFyiI2nGT2SPCOJ029TPrI0O4QCbfZ0k3gTMacsWm3_wNAzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:I-TfaeI-6ydZ01Dj5kU_3SkBCyUU_PSnNQeKm_QMm1w0XcyA6SocJA>
    <xmx:I-TfaTSPFoNhe6fJiQHN70R9NBTevn_L-gXO_GR8x4QVgxuwkkq9aQ>
    <xmx:I-TfadsKMDUC5B42LorvZ6_yutZq1TRSdOhBhhLWojSeXEoIrMRlNg>
    <xmx:I-TfaUapUhGpeSTD0SgLoIp3Aru6w4_5MAKHU_a-8PoXa0C3oIiFsw>
    <xmx:I-TfaZZP1rE-s5d5OttH8Gd18zST185ZF7dveellJt6mZmiPQyBD7GtH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 15:16:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 4/7] remote: add remote.*.negotiationRestrict config
In-Reply-To: <a731f4fc87ebee71d970d4fcaa36e8d991847984.1776266066.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Wed, 15 Apr 2026
	15:14:23 +0000")
References: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
	<pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
	<a731f4fc87ebee71d970d4fcaa36e8d991847984.1776266066.git.gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 12:16:49 -0700
Message-ID: <xmqqtstc590e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> In a previous change, the --negotiation-restrict command-line option of
> 'git fetch' was added as a synonym of --negotiation-tips. Both of these
> options restrict the set of 'haves' the client can send as part of
> negotiation.
>
> This was previously not available via a configuration option. Add a new
> 'remote.<name>.negotiationRestrict' multi-valued config option that
> updates 'git fetch <name>' to use these restrictions by default.
>
> If the user provides even one --negotiation-restrict argument, then the
> config is ignored.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  Documentation/config/remote.adoc | 16 ++++++++++++++++
>  builtin/fetch.c                  | 24 ++++++++++++++++++++++--
>  remote.c                         |  6 ++++++
>  remote.h                         |  1 +
>  t/t5510-fetch.sh                 | 22 ++++++++++++++++++++++
>  5 files changed, 67 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
> index 91e46f66f5..5e8ac6cfdd 100644
> --- a/Documentation/config/remote.adoc
> +++ b/Documentation/config/remote.adoc
> @@ -107,6 +107,22 @@ priority configuration file (e.g. `.git/config` in a repository) to clear
>  the values inherited from a lower priority configuration files (e.g.
>  `$HOME/.gitconfig`).
>  
> +remote.<name>.negotiationRestrict::
> +	When negotiating with this remote during `git fetch` and `git push`,
> +	restrict the commits advertised as "have" lines to only those
> +	reachable from refs matching the given patterns.  This multi-valued
> +	config option behaves like `--negotiation-restrict` on the command
> +	line.
> ++
> +Each value is either an exact ref name (e.g. `refs/heads/release`) or a
> +glob pattern (e.g. `refs/heads/release/*`).  The pattern syntax is the
> +same as for `--negotiation-restrict`.
> ++
> +These config values are used as defaults for the `--negotiation-restrict`
> +command-line option.  If `--negotiation-restrict` (or its synonym
> +`--negotiation-tip`) is specified on the command line, then the config
> +values are not used.

This is a tangent, but I wonder what happens when this is set in
/etc/gitconfig or ~/.gitconfig by mistake.  I personally do not
think of any good reason to set it in either of these two places,
so it might be fine to declare that we read this only from local
configuration file or "git -c var=val" command line, but alternative
that is easier to implement would be to allow for a variable
definition syntax that allows you to say "forget everything you read
so far, clear this multi-valued variable", e.g.

    == in /etc/gitconfig ==
    [remote "origin"]
	negotiationRestrict = refs/pull/*

    == in .git/config ==
    [remote "origin"]
	# clear them
	negotiationRestrict =
	negotiationRestrict = refs/heads/*
	negotiationRestrict = refs/tags/*

or something like that, perhaps?

It is a shame that our configuration framework do not allow
specifying their meanings and semantics to variables like
parse-options do (where OPT_STRING_LIST naturally allows
--no-negotiation-restrict to act as a way to clear the deck).
Because there is no official way to programatically declare that
remote.<name>.negotiationRestrict is a multi-valued variable whose
values are stored in a string-list, the config callback needs to 
be coded to implement the behaviour for each variable X-<.
