Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D1C2DF13A
	for <git@vger.kernel.org>; Sat, 30 May 2026 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780180149; cv=none; b=YoneOA47W7LmMg3dqV8SB3J4KMa4CRpf2yGgz8b4VlADQIyFAC4OHv7Ac+jCrkzvI34HaHdV0+OQ9ljLXsLPDG5tjP455uG1LOyV1yR40mTd2vzKU/P1/nPbvSjZJgdbee4op9Y87+DRLczWU5NA/Uhsr8RZZPImn1iWqLda4JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780180149; c=relaxed/simple;
	bh=S9WObS+xxY5UyYA7/SkHDEQ/aoJHROfI6NoF82e4L+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gIYm5bLe5P1loXRboiP40jR7CdvkrBeHO2Q5WFoy3IuIkhd+syGD42BSECihaaePA+gpLO1AXX5ZvY6rBil2sYT7an4v4n14pO+s/3NFu1gBi8K9PhyZZUlJ93mak+CANJT37O/b8WIPZHLltx2H+25rIEVclXU959GkRNFjlWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Izkwd+fy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I/x5MYEn; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Izkwd+fy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I/x5MYEn"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 66A221D00045;
	Sat, 30 May 2026 18:29:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 30 May 2026 18:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1780180146; x=1780266546; bh=nm9Wxg6LK8
	WqGWw7h7sTA9Y8zpCxiWadSsyOppK5wNI=; b=Izkwd+fyYyQ1/cIBYnxg9hv3Ef
	FiwyekcAQStXnjxCgluPV+hFrC9A3zspbWbHyqp0ebKGVW9OGkHJf19fzJQxi+Xl
	4uO+H173ELIuI5pVBodwzN8i3f82TwZg3nPzk6qLUgfRn3x/UHjv1yiBFQyeo/HC
	0cE+py6/arXNRpW45HFcZgPVeMGDkO33dE3r1OMzwIv9sFNX1w18MpUfe6okwR5w
	brmv2THPtPVe98jQIIUn09GEO4dCURQklttyL9HK8DUCrj9na2Rme0on+GP1XXsk
	cuL4av+3XJDNs88+pK5TPWPgln3cBR5krZhANi5d9mgdG0uhmgGTWPuf/FcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1780180146; x=1780266546; bh=nm9Wxg6LK8WqGWw7h7sTA9Y8zpCxiWadSsy
	OppK5wNI=; b=I/x5MYEnDeUdrRAfxRtWUj2E226j2tpqXyQwvMpE6jCtuWC8Q/Y
	4LZx0LovFeoKSD6i8moEu/RpNas9qCw90+zIUny5iFuP/1LZfRlks8ZHrk89Y5EQ
	+fq4pdXUVT2NNz6UiniGWA7U3blV8f043hEqlxHqgWgLSkjTltVcWk/tWFW7Tjbf
	9sZ4Xdb1EaxmCzstaJhD3HQlBTn4mJm0UyyuGsi77le+Idev5ybqxtq+kyOX0bBL
	6YnRD8SI5tR8ctlevK9q5Mzq2R8IE+n+FGrVHpPNOlIOG0hnZ954ibEH68TmYn8R
	dxeKVvabnim54GKHwdnzs6uJp2wLmePKbMw==
X-ME-Sender: <xms:smQbahrQkcmCYCAV3BXco9vnqhTZCdw-pbU-GB2f4oAMO3cvMJNAXA>
    <xme:smQbaqjdMVNw5nM-jl2M3h69MFMBcysiagfJDVSkz5NFuLv9OY8pAu1vnPbsd_Soe
    Ag7gGqMpvvw3iutEyrK054fXdN7L4Lgnx5vnZ7fHp6lsWOo5Sz5TSQ>
X-ME-Received: <xmr:smQbamjjUuOo6IqI6Iyduc19miqqI5kPan8-hoCDJBm89c1dkH9b8sckU7FprqQjyeopWcaobV4JmhE2mOo_HyEAOPg_Ux3Ejjnr>
X-ME-Proxy-Cause: dmFkZTGqKJZRoc2fxol8u51lHt/uUl+pYoQ/FyyTsisrJS3UQjztHQ8hfEHhnZjQVi87mr
    B8zdABFteNQZzw3jypmvGdOyXGn5VZe4xN4F5ZhBGA/KNZV3GeqA2LhECtuf6ey1XFqOtc
    zRZRtuVYL6DQhpQ85e2qKPbg9JiU52+V1CnE8MYCjMx9VCqCAtdShSKzXSZ5G5kI7y3cPu
    CXDqU/90c8KdaOFQZoAaBwYS1FclQ3fmCDwjMHing+tmLTYw/+Eoxm1TZeornBaDN1fxH2
    P/kP24SDoNYVzOQwyuwf/IkYvYNl82rDUl+X+xJn0cwXolbc2B6VEZ8t/kbmdLQ/ls2BMO
    ESaR1Kja05ZkOFqVlEUj/s8q1M1rMKaxfyRVXHF7XQ0S0CFdAl2dPIFMQxXSKziJfVlqb1
    kwfWMRg1DQW16TOOBea9P++H51iTVqIc2wTyLqB+ygExS/N+g5GslyHaRlw/ckzi4NKOIq
    r+jFGcRV9FTJxdDx28zsuIIUu/1YPhzaZ/bve4ypkyfH3rb65XL7czghACffDaJL1Q3Sd8
    DdbHsBnUnZQjdRtkXVBfJ4ENWoPDzlpRvK5tOA22KRbpwC5sOj99N19woT0tydm1eXNSGb
    f9QIZN1bYDzggDEa3dNLTWOu/iNUJYTD+zvaVKvpPKt64ijgYAoETiJTVUPw
X-ME-Proxy: <xmx:smQbaohtG5yQ_dKQOC_X3nErZUautak7E8FGSIoPFn1QowUCzuDShQ>
    <xmx:smQbauKPizpYVAGx1YbNXsjQGtQ2BWcJ3HFimPL89XdkMpdMxYABYw>
    <xmx:smQbavGoBfVPXOUy2y_Ss9sB8bb5oCQMTUIyPCoZXKbL58qEK0cEmg>
    <xmx:smQbaqS8lnsovGgMfSz1sj9oUSto7oh1sqXQV9mvjYTOflnIXxfluw>
    <xmx:smQbarwJL1Do8aNSRrEA9wOcwPnUZeqrD2mqaC0ZTk8YJqAobQo9ZXQ4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 May 2026 18:29:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: Re: [PATCH 2/4] doc: replay: simplify replay.refAction description
In-Reply-To: <simplify_replay.refAction.70b@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Thu, 21 May 2026
	20:01:59 +0200")
References: <CV_doc_replay_config.709@msgid.xyz>
	<simplify_replay.refAction.70b@msgid.xyz>
Date: Sun, 31 May 2026 07:29:04 +0900
Message-ID: <xmqq33z8fs5r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

>  replay.refAction::
> -	Specifies the default mode for handling reference updates in
> -	`git replay`. The value can be:
> -+
> ---
> -	* `update`: Update refs directly using an atomic transaction (default behavior).
> -	* `print`: Output update-ref commands for pipeline use.
> ---
> -+
> -This setting can be overridden with the `--ref-action` command-line option.
> -When not configured, `git replay` defaults to `update` mode.
> +	Specifies the default mode for handling reference updates. Either `update` or `print`.
> +ifdef::git-replay[]
> +See `--ref-action`.
> +endif::git-replay[]
> +ifndef::git-replay[]
> +See `--ref-action` for linkgit:git-replay[1] for details.
> +endif::git-replay[]

This makes it a bit roundabout for "git config --help" readers who
wanted to figure out what value to set to the configuration
variable, because the valid choices are no longer listed here.

Finding `--ref-action=<mode>` and its description in the other page
is straight-forward, so it may not be too bad, though.

> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
> index f9ca2db2833..4de85088d6c 100644
> --- a/Documentation/git-replay.adoc
> +++ b/Documentation/git-replay.adoc
> @@ -211,6 +211,7 @@ to use bare commit IDs instead of branch names.
>  
>  CONFIGURATION
>  -------------
> +:git-replay: 1
>  include::config/replay.adoc[]

The use of conditional attributes (`ifdef::git-replay[]`) is a neat
and standard way to tailor the description depending on whether it
is read as part of `git-config(1)` or `git-replay(1)`. It correctly
points the reader to `--ref-action` in the latter case, and provides
a full `linkgit` reference in the former. Clean and correct.
