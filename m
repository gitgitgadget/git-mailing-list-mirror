Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1244D34EF0A
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774468030; cv=none; b=gw+t4t4R3IZWeA3XlyGaKq3RApORlDwjYy0aVxQu7tSRaIxidLGk0r0baq6tPkIjFoWkt4CkV2XUWq7xU9lYCsNNbF9Aet3dZQaEqIpLEqbonRZotEUoard+NtYSFdlc89rA4quttT3BiV5jUcqawkLToW2de+rSh5mw5cv9PgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774468030; c=relaxed/simple;
	bh=xRyEGN9Q5LOc7HYzYyHrLcY3ut8QqRHGv1D/KMF4lgg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MULAeBWwvsB+nNwy7TSwbI8Do1DtUdOclCc0WzDYfpyyOM4O4fjvs64mb97U6cR4pordCeuF7ruQYhRqOYkJ5ZxzjyhoNZOyk3mCK3DB0fwGPmhlwnj2cVEIfk2+kQok9drAZz99BJpgZg17o0u5UshKEhWtsTznT7MS1hQbi7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZZHNQMb2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lzdnmo1T; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZZHNQMb2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lzdnmo1T"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5D9ED14002A6;
	Wed, 25 Mar 2026 15:47:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 15:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774468028;
	 x=1774554428; bh=tHnpZhGrlt5Pf9Pn+ZhvBp2G26YtdL3Bdrcoox+d4Ak=; b=
	ZZHNQMb2IbwiJ30Q1knkOWOuMGSaMmGJGer6EEWXihiZszgvZCuW7Jnu9G/Wdsa8
	pO+2mIWtHrQj48dPSc2Cg5gU7jCVXjot95IBASpQ75b5kvZOEYNEuufiQaFGL/AG
	W4xcIr01jaSc8ZR10Ya38pg9db8ebYlWndFPGM+AzbVSmH2D+YgRMHt8dwiMbKN7
	Fi/Vz0XmKdE+LCgI97zcIGaPgH5aA+fIPnJYxGG6mNDTtw10dI3lISuSPnNgw5+b
	FdjLe31UBBLuOMaR/ExA3bZSDuthCgp15zGu21jDYtsRjI7LrDrRpD1DYuUp2BYy
	UiZNax9I4VhUPIJyoRqaEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774468028; x=
	1774554428; bh=tHnpZhGrlt5Pf9Pn+ZhvBp2G26YtdL3Bdrcoox+d4Ak=; b=L
	zdnmo1T8XBzUnLmFBhk9hQU7zfbPSg1rZ/x41t/bh4JX1xCufJOZoLH5Ng4uA3uV
	bhfNsuSWMZi/QMEP3jeEQ90ZWXlagvVzJ24Szlt8H4ddl6IcS2Tt2sAPjcd/ZaLD
	3jG+d/gQPtfMG310WP4r2jLZbNAcAUtiJzVixM/vd7lJSvSkrrroPDt+SrV1tKq7
	UqFNN4ORD70OaTp/ojk/cQ/WtIrtpD0LwSMxGTaj1//Q+4u5bBRj31dJC+7ED9W3
	f9hrbos/DRbZOwKhDNCBRXFRHmzHfHtajsRg+rzwURsIhPcOq5RlbLwdGnlkrq5b
	VErqfRP7AZ6k3/mprsy1A==
X-ME-Sender: <xms:vDvEaeX9pUH9ahIamYRqoMVSYi-B-gQX6URarWbvCdt0SjyVODbodg>
    <xme:vDvEac3csrnpaCsvGtjcvNCRybsoNPYtUwP7h11IH0QKB49dKZTQdsD4SMS8Tk4sN
    KC8bYb1lv-poy16D6Tzxt-R30wFSPqRO1cyGRDkB0pWVHPVJpVTRA>
X-ME-Received: <xmr:vDvEaUoNyAFJsPpgMMWraePF2pdvKD1cLVN868UMPHzBAHTYbC7kpTz0cTBENz-NO8CYSlUwecaAt9EQrPjlTGbWGe6DGyrdhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrg
    hilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:vDvEabWSBXlb5dUY7pdHkkJNg3SsES3M2eyH6wBc2xaiTSIBNqwdFA>
    <xmx:vDvEaXbpvgXjlYH3jsgS-wXfCrzS63CRBk9E3moeoXbouG0DXjAO4g>
    <xmx:vDvEaQfLHtefdRHPJOzgHTbprnMqaOxzAHhZOgTLEKNyv_-GCBfKJw>
    <xmx:vDvEaZ0X0_Jx0aHNFFfDBMYQ5Mebp1_qDRNID0FAfuPAc0DVK0_Ruw>
    <xmx:vDvEaSfizKIdmgw6o3V45hcMWbXFSTP4i6Th6pzHrTrl01S8A6PLYteP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 15:47:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,  me@ttaylorr.com,
  phillip.wood123@gmail.com,  ps@pks.im
Subject: Re: [RFC PATCH v3 2/2] push: support pushing to a remote group
In-Reply-To: <20260325190906.1153080-3-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Thu, 26 Mar 2026 00:39:06 +0530")
References: <20260318204028.1010487-1-usmanakinyemi202@gmail.com>
	<20260325190906.1153080-1-usmanakinyemi202@gmail.com>
	<20260325190906.1153080-3-usmanakinyemi202@gmail.com>
Date: Wed, 25 Mar 2026 12:47:06 -0700
Message-ID: <xmqq7bqzu1xh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> `git fetch` accepts a remote group name (configured via `remotes.<name>`
> in config) and fetches from each member remote. `git push` has no
> equivalent — it only accepts a single remote name.
>
> Teach `git push` to resolve its repository argument through
> `add_remote_or_group()`, which was made public in the previous patch,
> so that a user can push to all remotes in a group with:
>
>     git push <group>
>
> When the argument resolves to a single remote, the behaviour is
> identical to before. When it resolves to a group, each member remote
> is pushed in sequence.
>
> The group push path rebuilds the refspec list (`rs`) from scratch for
> each member remote so that per-remote push mappings configured via
> `remote.<name>.push` are resolved correctly against each specific
> remote. Without this, refspec entries would accumulate across iterations
> and each subsequent remote would receive a growing list of duplicated
> entries.
>
> Mirror detection (`remote->mirror`) is also evaluated per remote using
> a copy of the flags, so that a mirror remote in the group cannot set
> TRANSPORT_PUSH_FORCE on subsequent non-mirror remotes in the same group.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
>  Documentation/git-push.adoc |  73 ++++++++++++++++--
>  builtin/push.c              | 123 +++++++++++++++++++++--------
>  t/meson.build               |   1 +
>  t/t5566-push-group.sh       | 150 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 306 insertions(+), 41 deletions(-)
>  create mode 100755 t/t5566-push-group.sh

> diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
> index e5ba3a6742..b7f617a290 100644
> --- a/Documentation/git-push.adoc
> +++ b/Documentation/git-push.adoc
> @@ -18,17 +18,28 @@ git push [--all | --branches | --mirror | --tags] [--follow-tags] [--atomic] [-n

All the differences since the previous iteration in the patch to
this file makes sense to me, except one thing.

> +The behaviour upon failure depends on the kind of error encountered:
> +
> +If a member remote rejects the push, for example due to a
> +non-fast-forward update, force needed but not given, an existing tag,
> +or a server-side hook refusing a ref, Git reports the error and continues
> +pushing to the remaining remotes in the group. The overall exit code is
> +non-zero if any member push fails.
> +
> +If a member remote cannot be contacted at all, for example because the
> +repository does not exist, authentication fails, or the network is
> +unreachable, the push stops at that point and the remaining remotes
> +are not attempted.

I am not convinced that having these two "failure modes" is a good
thing; I am not convinced that a single failure mode is better,
either, though X-<.

I would personally have designed to mimic exactly like "git push r1;
git push r2; ..." would do (not concatenated with "&&" but with
";"), which would mean that there is only one single failure mode
that would not affect interactions with any other remotes, but I
have no strong arguments to choose that design, other than that it
would be easy to explain when we later start supporting pushes to
multiple remotes in parallel, where a failure to talk to one remote
cannot easily affect interaction with other remotes without getting
affected by timing issues.

> +This means the user is responsible for ensuring that the sequence of
> +individual pushes makes sense. If `git push r1`` would fail for a given
> +set of options and arguments, then `git push all-remotes` will fail in
> +the same way when it reaches r1. The group push does not do anything
> +special to make a failing individual push succeed.

"when it reaches r1" makes it sound as if the group push then stops
after that failure, but that is not what we just read in the two
paragraphs about two failure modes.

