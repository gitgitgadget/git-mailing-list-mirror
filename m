Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823AA48424E
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 23:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790378807; cv=none; b=DeY64UC0rSMeOvn+Fd5yrGLE6ltEvugAI+OjFlDa5jUi9QRnixWNdSCYZzDXBh5tG8C8sBm0WusbukOxKkNgHbWXh23YNqywe/0CRtfMdD5/nbXL7MvG2KH0PgjmCKfTryC5oCEgJlFGgj6iPNBBHKp1JqxH0AbLOkqZDlMtck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790378807; c=relaxed/simple;
	bh=6P1PPNjSuAQhliJlV2rpF2cE8Wvb3xYU67b6zbqMbt8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BL3RD1hKM80DHvloaOpKe1C40pgMLJW/U5+AeUp2StRzQNt7A9RRDzPbuD6+/HjFvY0NnLXIC988VYPNiQCi/r8+7Fe9iqnF6V0s+BIH5S8QOeAIlcvPe7w8raFR1uZYFjx2JuBsF5VXnYvlf6ym6nTxUIHPCO8+CPhau4thMzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YXgkXqRw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xw6y7/E6; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YXgkXqRw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xw6y7/E6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 34872EC01EA;
	Fri, 25 Sep 2026 19:26:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 25 Sep 2026 19:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790378804; x=1790465204; bh=K6/uxR4dJC
	Xueby13dF1onBh8krfUfocs/rPNK8Jyrs=; b=YXgkXqRw7SP2+JlJR0Y0k01Ojw
	Hn+z/rC88iLh1b6eK4mA/o+sSHH+FE6sxYmSnithjV4BxxpXahHDRrNdq4CW3h/K
	1drpPwaf+5G/CAyJZxocm2FziX97VTU2ZVAPV5WokXv/INPzffKApB6jfbIIAOHr
	CbK/i0x2yHOGd6NkDoWjwSCV0S660pSbyfTXijcOjM8rhxTdduy3lZujdWzZSUsQ
	3NTPuHGagxFGvLGdxw027hVvqLG2XEc/ZWkUvK6YfhzleW+5I1DntqKJwySWlYM5
	fk48khqMyc5/tf8Z3MSeB5//oMOFntQh20AIx0UoLg+2I3wmooRCPsWU+Rfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790378804; x=1790465204; bh=K6/uxR4dJCXueby13dF1onBh8krfUfocs/r
	PNK8Jyrs=; b=Xw6y7/E6qNj2dEYkK079JyYhmZDPCOqAgQwpSMDCDQwI66HLBnp
	l19UxAEynFcTgYfgIjC/Wm2nps+wvq84e9uYKc864VSh7T6wsrCsMVulcb/U63Yu
	C5ktYpxeey35U3qZ/MnmAxkEyzv1jXY6/8telMbg1+5+NqJSOT4VSISRm5fv1gB1
	/0Q0uB4nRvT5NGi/ZGZBKFk4dRfOrOpufOtycvsLmZ3ZumEafRfg4CGUh2RN3zDQ
	Hl+PVt+ZC8A9S0WrkWQuXwPR7kVFyo9Em6VARugJyi7Kca0GgcyK8AKYffkefSze
	T4ksMCTUurN0PIzRf/hTwsvhU5Ze67+CZKg==
X-ME-Sender: <xms:NAO3arHNbLggYgOrdEhMwIzEuY6xazwWQfNxnQdSFbHEOI2NCVS-Rw>
    <xme:NAO3asDbvVuMWJEKT-Uz-sBucUA1VNo5doHH4UZnZRhgLk_T-YjTKbnD5d71lnn9A
    f6MBYyeL8k52TdpUri8bJpiMfPndWsKENkTcyrbu6XceL9orZgaghw>
X-ME-Received: <xmr:NAO3am9rCAH9TQPHLN3nt9KJPglnKOZfMeCK2Fv23PoCcwucd6uQLDdysNQCpXNRl1CNkLzINK5kVNuZ5KW2lnoyN18s24pcxVy7>
X-ME-Proxy-Cause: dmFkZTGSwBtxai2r80X+YIJ5EkeCAhMWJAjk5EFdd9CHOL4QMWNWuk+SUp9PyyA9U7g//8
    XbGa69Qiiq5ld3ItRVX243TP3O5ZvqYRK4CamLReT+RmE9lnLhKHd2l8ODyzDAVTACck8R
    olpEcaDiZpa0Dt0vBCVDorftoukEAki3BNYB4yTWLzoWNC/XaO2lFBj/f1n17aY80o/kvi
    y9ymEFs40hzxtYAkoPyi032FBsoWqeTXIWuM8MZ8wrjIOdd3wiqxSr0E/xFehh0UjX0nAs
    FgMR6Xcm/4Najs1MyTU90KeDeIgV0LFUFsHQ8yA6y9XB1l8sCuDqKm6mnmrHHo7KpmuZkW
    /1DBKbOI8EiIm+chjcv0Y/V6K6F1dgdqPi/FCgyNnGuvhuDgPWuxba2yetnd7a8vrgOuZK
    je1NGHZ11OT/TL48z29Scz7Ld4rwFdusZEp2CLvrD+zYJrA8mPxjFPF2TZbBJlWPciNv3y
    1waHR4vJsXocYTb8RyCu/1rXQyFwPh/str6yPPz+1IZ/pqFY6vSVrbQjHAmWXUgBNVYQrQ
    xvoDOKywfOtPvMorIGl3ZtzzBiPTBmBugVrgVVo0tjEb3ys/8G1ximo6lYpqXwu/l3+j9s
    UoLvOU6s4hiRyT6SZhyj9gVOug6y+cXxDehHoB3F+s4/4sQtLKQY1mkJHmjg
X-ME-Proxy: <xmx:NAO3agDoXDGy2juhpy70IlqwPnYmo3ENuqewh5-ZmOwNmQiALIRb3g>
    <xmx:NAO3ajSXdMMbRrsqcJlhO1DNx2aowHqUvf0qhHHpV-ocMuwGtz4xIA>
    <xmx:NAO3avs3nQP_e4lM1ch1cbFQ2r2PDCcPSLclqe-KOpC-wgUxoWQttg>
    <xmx:NAO3an3OqB2SYuroCSDFbDSh5u7ioAjxGM36vJzR3tQrUtt8-sQe-w>
    <xmx:NAO3alrEe59dms4rjseDC8u5m85LfU7j1zmBENp20WpR5O1x6R555vd2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 19:26:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3 2/4] fetch: infer branches to fetch from a
 refmap-only remote
In-Reply-To: <4ec508a223a19c3aac8cf368e3dc0314ff6de479.1790333402.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Fri, 25 Sep 2026
	10:50:00 +0000")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v3.git.git.1790333402.gitgitgadget@gmail.com>
	<4ec508a223a19c3aac8cf368e3dc0314ff6de479.1790333402.git.gitgitgadget@gmail.com>
Date: Fri, 25 Sep 2026 16:26:41 -0700
Message-ID: <xmqqo6dksyj2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Configuring remote.<name>.refmap without remote.<name>.fetch used to
> make a refspec-less "git fetch <name>" fail with "--refmap option is
> only meaningful with command-line refspec(s)", since a refmap only
> says where to put fetched refs, not what to fetch.
>
> Make that case infer what to fetch: the local branches whose
> @{upstream} is already on that remote, plus the remote's default
> branch, which is always included so it is available even before
> anything is set up to track it. This lets a remote be configured to
> fetch only the branches actually in use, without listing them by
> hand in remote.<name>.fetch, and without needing to touch the
> command line every time.

You may not necessarily be interested in what the remote's HEAD is
pointing at.

 - You may only be working on top of their 'maint' and their 'next'
   without ever touching their 'master'.  It would be rude for Git
   to decide for you to fetch their 'master', which you have no use
   for, without being asked at all.

 - Or you may be very much interested in their 'master' that is
   pointed at by their HEAD.  In such a case, you would have your
   local branch that is forked from their 'master' *anyway*, and
   you'll get one, without special casing their HEAD.

Especially since we are about to add the knob to trigger this
mechanism to "git remote add", presumably this is to be used for
second and later remotes.  The primary remote may already be
supplying "refs/heads/master -> refs/remotes/origin/master" when the
repository was made with "git clone --shallow --single-branch" or
something like that.  That makes it doubly dubious to assume that
the branch the HEAD of this secondary remote points at is so special
and everybody that does "git remote add" wants to interact with it.

> diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
> index 538914bc6e..c973a07caf 100644
> --- a/Documentation/fetch-options.adoc
> +++ b/Documentation/fetch-options.adoc
> @@ -245,8 +245,12 @@ endif::git-pull[]
>  	command-line arguments. See section on "Configured Remote-tracking
>  	Branches" for details.
>  +
> -`remote.<name>.refmap` provides the default value for this option, the
> -same way `remote.<name>.fetch` provides the default refspecs to fetch.
> +When a refmap is active (from `--refmap` or `remote.<name>.refmap`) but
> +there is nothing to fetch, neither on the command line nor from
> +`remote.<name>.fetch`, Git infers what to fetch from the local branches
> +whose `@{upstream}` is on that remote, plus the remote's default branch,
> +which is always included so that it is available even before anything
> +is set up to track it.

So, I would "plus the remote's default branch, which is always
included".

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 7651b41139..c8ce89cf30 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> ...
> +		if (default_branch_dst) {
> +			struct refspec_item head_item = { .force = 1 };
> +
> +			head_item.src = xstrdup("HEAD");
> +			head_item.dst = default_branch_dst;
> +			get_fetch_map(remote_refs, &head_item, &tail, 1);
> +			free(head_item.src);

This adds a fetch map entry with rm->name = "HEAD" and
rm->peer_ref->name = "refs/remotes/second/main".  Because "HEAD"
does not begin with "refs/heads/", the report after fetch says

	* [new ref]    HEAD  -> second/main

instead the usual

	* [new branch] main  -> second/main

doesn't it?  If we do not force-include HEAD, the code would be
simplar and we won't have to worry about this.

Thanks.
