Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC323D7D70
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 21:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991438; cv=none; b=VW5Fm0g9riUCywZKI13Gcl/UTbwxiLhXpOiqyhPA7H7TgTd8JvBz1ZggJhoUIWOcGNKv482oIcjpU2m3FDSNm65olN2SdT2BzkEw1OMVGz7NJlUPMiorJ9NQQ56WInuDaO6SVOKTN5N1jJT7/FrmYp2y8SlOogEKnfxjhkC7wvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991438; c=relaxed/simple;
	bh=ZgtETx1i1z72JpwWPe7wLK2WIMJejzebYA2aYtoQ9qU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eEa6JlfR2dYJCQ4eyn2y60gTXoQ7pTIbtfIxZMQvjPae4F8TPpVkCH5FUqOYfFaIKs6xWNfiAycFBD3knitaqT79SnJl0ObLQaF1mHYjpneCK1qZgfrUN6oKLtcVv8CIsmbuk7nZ1RSzQsBlqAw0wskbIOWVSqPM2H8sbs5oPHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uvdycI4+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NgXZLAWS; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uvdycI4+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NgXZLAWS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 757E71D00197;
	Tue, 31 Mar 2026 17:10:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 31 Mar 2026 17:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774991436; x=1775077836; bh=EfdiCUp70P
	MK8oxZfkNmIAh62OnVQ9NpoZfmzWblwmk=; b=uvdycI4+JFzqVN5hIwu0uvVdfh
	xJVqNO/vWJks8Z0IInJEyZZdQUK5/BstJwxiJ+Yal8JxjSqD1WW5GqvrQoL3i/wL
	MC5vFnDVwNBeTzKeoRupvNDQYtqKJk0jm/3aUCjSIYqZEfod8NyZyjHYelmZfAOd
	3xmdjtv5CAogzXJkpMHxRy/C+p9rhiWwJbBNEIjjzh+AEjyh3iX6ZTFsXEFZBLa/
	BCEk6c9MJarPKk424mRzOtL7KF3gcD/9C/VS/fXdiiR4urD4YBLBS1hZ5xGFxSNR
	PgxW101St4DChxEqCF5AnOhen1l5vkx37w+Ne/TWx5bxy+OZQhQ4IOQrbdhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774991436; x=1775077836; bh=EfdiCUp70PMK8oxZfkNmIAh62OnVQ9NpoZf
	mzWblwmk=; b=NgXZLAWSfNj8QuEqSXlvMhJ3lzsRfENfJ/bQE9ZzRM8A8oi6QE6
	sgiK1dyPM/YjjaDZUZwBeQOELkqk5taID7YEof1duoudNPTc9WaxvwvSnEHqcGmd
	TP3ZLPXX3rviOfTKqHDpWGgNaxUkoaiZSQPP1DiO1RqxaW+Y6OibY4LRWvvQSiUB
	Av9euhiwGhIex3huto6vqI2oXS/w4+QfR9zB7uBsqjpTM9ugokjRLni2/bMB2ZK0
	SvxbtewMBDKbs8vD0muRJdKP5t6/psp1hR3CASijKDMxo/eqAoCzbaBrrvCNkgwB
	GQiDpFBX+gNXRbSTNYLm1VRMTW5tbPKBylA==
X-ME-Sender: <xms:TDjMac2yjWJT-hBrk6NUtOpG9rVfAf5BKfyNKjRbWC8zV2AGtWyZDA>
    <xme:TDjMad81Ivs60L7cO0Xa2A8UEEe_hZ_Sby6FnE03csJE5nSm3p5CoogJ5RrOBC9z1
    7FO64WmnxIWB8-oJDeN9G3zaE7kHz4BMyrPGT463l2G9RKFZUHyJ4s>
X-ME-Received: <xmr:TDjMadPcnVg-mW5fiaVnZIHfXVEpuBgDcfF_E6aER6ytMwurt3rKA95NojfyTTM6MmVOL9ig4CsHQUFp-MZS1qtHiGqvsx-D3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffue
    efjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhg
    shgsrghkkhdrnhgrmhgvpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:TDjMaRfCwaGLbWGi16G6REHN6SdWw3_UOjv9qOFkqM5m9d9OR3oDOQ>
    <xmx:TDjMacUKKghI1eGcgcNl5MJmzj9dIj3jJL_Da8VIRf3SLTrmoJ6CsQ>
    <xmx:TDjMaZjtKweI1PuL1snK6YzcajT4szVOH86gNkVcxW3etFsxkASC1w>
    <xmx:TDjMab8BhLNaVcRA9WqbszzOJcs5qwohAXQyCU_SajCPnnEFyykXoQ>
    <xmx:TDjMaaFjToEBTaiGoTO-QwSyw7NazeRKpb262uoms_8_xIr6ZG1S2u75>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 17:10:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  ps@pks.im
Subject: Re: [PATCH 3/3] doc: replace the rest of git config --list with `list`
In-Reply-To: <doc_config_-l_the_rest.54d@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Tue, 31 Mar 2026
	22:48:10 +0200")
References: <CV_doc_deprecation_config_--list.54a@msgid.xyz>
	<doc_config_-l_the_rest.54d@msgid.xyz>
Date: Tue, 31 Mar 2026 14:10:35 -0700
Message-ID: <xmqq1pgzzovo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
> index c7db103299a..ec2562fb0a1 100644
> --- a/Documentation/gitprotocol-v2.adoc
> +++ b/Documentation/gitprotocol-v2.adoc
> @@ -659,7 +659,7 @@ use by the client, MUST indicate prerequisites (in any) with standard
>  applicable.
>  +
>  The advertised URI may alternatively contain a plaintext file that `git
> -config --list` would accept (with the `--file` option). The key-value
> +config list` would accept (with the `--file` option). The key-value
>  pairs in this list are in the `bundle.*` namespace (see
>  linkgit:git-config[1]).

OK.

> diff --git a/Documentation/gittutorial.adoc b/Documentation/gittutorial.adoc
> index f89ad30cf65..519b8d8be2c 100644
> --- a/Documentation/gittutorial.adoc
> +++ b/Documentation/gittutorial.adoc
> @@ -432,7 +432,7 @@ bob$ git config --get remote.origin.url
>  -------------------------------------
>  
>  (The complete configuration created by `git clone` is visible using
> -`git config -l`, and the linkgit:git-config[1] man page
> +`git config list`, and the linkgit:git-config[1] man page
>  explains the meaning of each option.)
>  
>  Git also keeps a pristine copy of Alice's `master` branch under the
> diff --git a/Documentation/technical/api-trace2.adoc b/Documentation/technical/api-trace2.adoc
> index cf493dae03f..918e517c2e6 100644
> --- a/Documentation/technical/api-trace2.adoc
> +++ b/Documentation/technical/api-trace2.adoc
> @@ -1253,7 +1253,7 @@ it.
>  $ git config --system color.ui never
>  $ git config --global color.ui always
>  $ git config --local color.ui auto
> -$ git config --list --show-scope | grep 'color.ui'
> +$ git config list --show-scope | grep 'color.ui'
>  system  color.ui=never
>  global  color.ui=always
>  local   color.ui=auto
> diff --git a/Documentation/user-manual.adoc b/Documentation/user-manual.adoc
> index 76969871176..3cd94c7afa1 100644
> --- a/Documentation/user-manual.adoc
> +++ b/Documentation/user-manual.adoc
> @@ -2865,7 +2865,7 @@ stored in Git configuration variables, which you can see using
>  linkgit:git-config[1]:
>  
>  -------------------------------------------------
> -$ git config -l
> +$ git config list
>  core.repositoryformatversion=0
>  core.filemode=true
>  core.logallrefupdates=true

Looking good.

Thanks.
