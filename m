Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DEE52379B
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 17:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790874211; cv=none; b=EKkUB7gjSYpFR/U9AM4MVWazI/G6iLrPIdFwqqqSTpGSWsm+YiA8OcbyMQ+Y5KCClWoB+H2n2SQZR4tG8xEay6WGqRT9zH1nEDqeaGCpAItTe6Lj85SLICSjzazWOOFq63pIBLhH8p/5umOFmQPg0pevUEjPzS7GeiZIG6ZtEbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790874211; c=relaxed/simple;
	bh=ERPeRmpaQivSyxwhc2TM2xl2BTzf9s2GAAfEQwmGfag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AHUSZAVgf7upe3SBxttJEtSv9bpOPvBQQr34tdUwmxzuc6aGe9JDURBYHVVIN85GR67bkcmgdCwkh3yB9DFh6NKb4huzabjKXwPJxCmydAoigY1KOsi45N9RKi77AoO0rsWpcfaNgGwuWaACW7e502pQ2v6oInHtJu+PgJ8LGTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aPpcp3aD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ImwoHkUA; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aPpcp3aD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ImwoHkUA"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9CFE81400112
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 13:03:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 01 Oct 2026 13:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790874195; x=1790960595; bh=2wybp8uyOH
	C6TXAkWiZ2UTkeZRlwthBjRfA0MI2htbo=; b=aPpcp3aDIJxH74Yp6KKyuXePe6
	SiG7YI3sDTTU7UgK94aLqlaxulzij2Ij1UmAlrUgaM84ul/DDqBZJyO3L67Dr3H8
	4UNwhJXZYejiZbG95usafl+JblfZGetSVGwS4Ysc4TYKqEn0HfQLUfn9+dNvIEBc
	OIW5BQgv2uNLByV2Dhr/kSB/1tpmh4YzL5/8rZaFjs+TqHyyN9LxUpUFFgC3Ro0I
	7WyiYKYHCyZ3DQge2l5jt9vc25xm4iHPTiKMoWdVpkUnSe8nJcJdcX8DUTkH5uUH
	3hkyGBE8io2m3OOwhD1tnOASxw9dlb6iGoGf97/vmvOVs5IOI1vt7p8lD4UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790874195; x=1790960595; bh=2wybp8uyOHC6TXAkWiZ2UTkeZRlwthBjRfA
	0MI2htbo=; b=ImwoHkUA4T4l4J1hYgCjcB/1EK1pvcNT7PxE+q1qqrN+O6y71nw
	8GQTLZNR7Oci5H6heWAtjiWeH/M7BfE4/jeyB4Vz6dklrmN9iM3UltcMLO7cRfeD
	cJn7Mi9jwqs0gObAhGmWQ/hSO0j7pgte8Cp8S+l6cpE7IQEi1MdbPUfRLaz0m+VB
	MyvQnATyKjQqUq9Hj71bwasMj89FvkR1rrXvvZavPhORtypEUIKBy7EWOQxNzrYT
	NaA7WqIE0T4FOG9ZhL+StSFRDgoaBBEESjj0yV14e7lFdnRzM7sO0rmJ377bZZ9w
	6n7K6LtzojHWrb0GL2PTJgU1fV/hrUjr8BA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790874195; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:HGDmA1ofQwRYORYncrSzNzAzwCkYWQfNBXi7t+3gt5TIXZb
	eUklkgdekDxQA8WnASvHuinu3OgWqR4A+J/3WA43nOsIL1Pm7VlloaaVzEc0PjJz
	eWtBLBwz44IVPWhnUSVOdBbz11HVdcdQmVRkbXGUzujKn7YC27v4YBiJmjzodSq0
	GAacoeNjPD4S9fq6lgXm7JybR3FhtaVNur6WufQLo4RIAJkgXgqPMBZTQpQKoQou
	JYcoNm7KxEpnJQT3MoeMOG+6Og2/v9scSx6ndn6IUbzlqK6geLpWS5pG797+JS6b
	EOIGiCWPJFGNVmeWlHfRIBbLs8vHm3tRJ0ce+pA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Uq1nK/VgCijg2ck4gaM+jjPk6mkm5GD6d5XmDAX/a0g=:ERPeRmpaQivSyxwhc2TM2xl2BTzf9s2GAAfEQwmGfag=;
X-ME-Sender: <xms:U5K-amaGmzVQRhESD_16YlXONhmPnkAIiHr8iGO0ThWz9A0tEk8RDg>
    <xme:U5K-aq4HoW3__G7JTF2-3mntEclyz6M34E7QsdtkdgXYcx4nha9nOgkT9XWP6QNVf
    Cq2bnw3pWYcH1KDCNlHXvvi3Vwg-Fzj3yJhByAaib_74zUXYpY0Jw>
X-ME-Received: <xmr:U5K-ahBW9IenBcrHr-eRcD1a1BiHrUR8vL_-OjjAF5ZSbwtfGAQx8J0aZaSeRwra6LSFeMS0nJr-IbHsZ0OkSS9aCgWY_nvYcYwW>
X-ME-Proxy-Cause: dmFkZTFejQ7M6+xyoW2+or7dfbRDRgXzD6pBhGBpJrCtN2PsiZHkyAG5nv3dVrkx7i3oCO
    XFxZBzBvHB94Sek0mPfCRv4Uzg+bYaE2F6pWAT5QY1HS2XGBydqLjLLkalWv9rkZr6g4e6
    wHiPOki3OfJDwEiH32/22eW70W2U61B3wHe5CMOeWY840Tk4nP1vyZuV3NhDWiPVOvqcli
    y0u2KGgSFD5GQ8ZulBtjAQbY8+EPNecnp9U4Bs+e0wisKYRsW2NOv7eOlb+q9fLrgJBtAP
    DQ/FYPH8jmgFg0FR+qF5xg71Bmf2P8pdc0jwTumMyGY3XUwHnQyUSoIugMv84Xi0CkCOIQ
    WMf3yHQuY0vQryM2tDbpNq3ulIzszTfiXJS4WUHv8NNFrck5DDa3KackCvqWr5A6OnRDyz
    ijhC9pejd3W10/sjDsbbK8Ir+FWO5z3PRvF/hDZ91YNv82a+DRlNutKEoucrmKnEVKaypR
    9Agu3GjcUWyJXAE+jV3La2DHH2KfCeyz5wc/0LnzG9Z3W+YbqJucTTnzcWMTqktEO+Q5fe
    sw9HWGtU12wmosOcnJ4Dfskwck/H1ZzNg6cX1Nsvwq2yGctkywWkSHu8m+mAjl4Q8/2Fbo
    hUxbsNDGEAvzic2yrc6aUvgmC20u0LlDYFs9u50OOxUFETVjXVjtSFSm8+ag
X-ME-Proxy: <xmx:U5K-aodeF6Ms-3sgXH8cPGXN1X5yvm-SlDdTolXmSltySvFXrKMJVg>
    <xmx:U5K-aoLRjfyKHvXtZ8G55hvuurFz4CddzneKTJR7F-dQIStoHOyGZA>
    <xmx:U5K-ar1B5skVriiAiL-RKSpZEPm-Yi8TM4X7n_Iyr3p_69aUI_Yqpg>
    <xmx:U5K-aigmGZ-KM2s90XDdAkfkVOJVgIDu3EAfT8u8lHaJX-S93ku17A>
    <xmx:U5K-anXniw2a6o8qfjQVcTEuM3hgNX7aUCCJkENnZA7WSqoOo-Wen9H3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 13:03:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kazumasa Shigeta <kazumasa.shigeta@kanamei.com>
Cc: git@vger.kernel.org,  Shabbir Bhojani <shabbir.r.bhojani@gmail.com>,
  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] stash: expose untracked modes in create
In-Reply-To: <20261001042155.33303-1-kazumasa.shigeta@kanamei.com> (Kazumasa
	Shigeta's message of "Thu, 1 Oct 2026 13:21:55 +0900")
References: <20260929074222.11942-1-kazumasa.shigeta@kanamei.com>
	<20261001042155.33303-1-kazumasa.shigeta@kanamei.com>
Date: Thu, 01 Oct 2026 10:03:13 -0700
Message-ID: <xmqq7bk173qm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kazumasa Shigeta <kazumasa.shigeta@kanamei.com> writes:

> `git stash create` always passes zero for the include_untracked parameter
> of do_create_stash(), even though that helper already supports untracked
> and ignored files and stash push/save expose those modes as
> -u/--include-untracked and -a/--all.

There may be no lies in what the above says, but we would prefer to
hear what the user visible implication of "passing 0" is more than
what mechanically is happening inside a program.  For example:

    "git stash create", "git stash push", and "git stash save" are
    commands that create a new stash entry.  The latter two are also
    responsible for storing the resulting stash entry to the reflog
    of the "refs/stash" ref, but have options to control what is
    included in the stash entry.  Among these options, "create" only
    supports the equivalent of "-m <message." to record in the stash
    entry.  Most notably, "-u" and "-a" options are missing.

> Teach create to accept the same options and pass the existing mode
> through. Unlike push/save, create continues to only create objects: it
> does not update refs/stash, reset the index, or clean the working tree.

Sure.  It is a very concise and good description of what we want to
do.

> Use parse_options() for the new options and stop parsing at the first
> non-option message word. This keeps option-like tokens after the message
> as message text, while leading option-like arguments now follow Git's
> normal option parsing. In particular, unknown or malformed leading
> options are rejected instead of silently becoming a message, short
> options may be combined, and `--` can be used when a message itself
> begins with a dash.

Why do we need to go into such a detail in the log message?  What is
the above paragraph designed to convey to the reader?  Again, it may
not be telling any lies, but it misses the point by being inconsiderate
to your readers.  What you need to tell them is _WHY_ you chose to
use parse_options() in such a way.  What were you trying to achieve?

I am guessing that something along this line ...

    "git stash create" traditionally treated the rest of the command
    line as a message.  For example, 

	$ git stash create adding -u option

    has always been a request to create a stash entry with the
    string "adding -u option" as its message.  We should not make it
    trigger the "-u" (include untracked) behavior for backward
    compatibility, by using parse_options() with stop-at-the-non-option
    mode to forbid it from reordering the command line arguments.

... was what you wanted to say, but I am not sure.

How much of all these verbiage was written by AI by the way?  You'd
need to spend effort to make it readable to humans.

> Keep create's existing no-change behavior: detect the usual no-change
> case before do_create_stash() refreshes and writes the index, and return
> success without printing an object name. If do_create_stash() still
> reports its internal "nothing to create" result, map that to create's
> public success status.

You already said that with "does not update, reset, or clean".

> This follows the stash subcommand exit-status convention established by
> 786fc390465f (stash: reserve exit status 1 for conflicts, 2026-09-03):
> subcommands return 0 on success, negative values on failure, and status 1
> when applying a stash results in conflicts. cmd_stash() maps negative
> subcommand failures to 128.

Again, there may not be lies in here, but if you did not make a
breaking change to the established convention, is it worth saying?

> 9ca6326dff29 (stash: refactor stash_create, 2017-02-19) added the
> internal include-untracked path while intentionally leaving the user
> interface for "git stash create" unchanged. Reuse that machinery and
> the existing INCLUDE_ALL_FILES mode rather than adding a separate stash
> creation path.
>
> Add coverage for short and long aliases, combined short options, the
> untracked/ignored boundary including an ignored-only worktree, option
> parsing and dash-leading messages, no-change behavior, and preservation
> of refs/stash, the index state, and the working tree.

Again, adding tests for comprehensive coverage is not something to
boast about.  Is it worth saying?

Aren't -p/-S/-k/-q and pathspec support all about the creating half
of "git stash push" that are not available to "git stash create",
not just "-u" and "-a"?  Why are we singling out only these two?  It
may be more worthwhile to explain the rationale behind such a design
decision.
