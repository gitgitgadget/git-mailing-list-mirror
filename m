Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D2440D57C
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 00:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782003187; cv=none; b=YCIeGMZ/Kq1fR8pUyaMnni4RBYceiH9PUhCzAy7u2iC3HiwbBfAmOG/dkLY3xWkoDQMOm4td2dryBOQr+jKCqsiSE7zdy5xN/yuCfoNq96ar6LRu/AYGlOI5Hpb32Lf2/gy+K6pZSPQsL91SMqEhvFFjzEY75JlESG3RiyTmVWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782003187; c=relaxed/simple;
	bh=xiUWEUznJXmDu3b5tyqt7r300q3r4u3gZdnxCj09t7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gSg6rfBUlGYC4gaN3FX3HEtLFE6X1sswchLoMpIq5lRDe0bb2lm37dunL9GVsDWUyKIcJReYtSLWBZkdBc+anW52sMllL4x8eHRGr36htu/Z9CO1zmGUg9H/3u/NPTpgg3MEFG6Q6pOhxsBDEcUh0rrWrdjuqWuCylJoFkEOWWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ch9TLkN9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fJKYK9NE; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ch9TLkN9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fJKYK9NE"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id CEC8AEC0166;
	Sat, 20 Jun 2026 20:53:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 20 Jun 2026 20:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782003184;
	 x=1782089584; bh=OlXwmdtP89yJqmj5yF0tu3R7XcQoq5VZlss4xSpA7Mk=; b=
	ch9TLkN9EMpsKH1lEZr9iH4i0FAaep2TlgWOxG/NZX6qWOLuyeRuYfYjXYMkkxrJ
	7YjhCr6gYm1JTPUxdffgx2kK1M37muicNKbsYUK5vjCX38QFYTlQQ8EG0I4rD3vP
	bJ2CwlSSh8hvmIxJwsjTr1ty/eEOXx7kSvpIBW5k8sqURK80i5rPp5QpP1OQgg3P
	isiWPTSavHm0RruEkf2PIqnLInVckn2u1ZVG/qyC13hKDX7WqmGDg2mgmqTSBS7a
	sqXe8Rg5GreON6BNh4Kby59eEHdZjvAjMppE0eV490D1NHiU6iHSXfMR4McCl4Qj
	kmnJcHg8aZpp60dgoN8zGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782003184; x=
	1782089584; bh=OlXwmdtP89yJqmj5yF0tu3R7XcQoq5VZlss4xSpA7Mk=; b=f
	JKYK9NEBgmuS4CUZo0IEwOW8uEJxmm00SlMsTyJ0h97J94rpNZ1Gho1k5BiD0z/J
	gFENsKqJX0c4oIUdP0sHee2nEEPFX6uuGU2Q4wXAVBXUVcj6BNgotgrvocYOQYcZ
	R0IloFLD7oLs6Q71Q4EPvooQXSaYhdW+06UFVJ0E9Be9ZQd7/rBOV9lpSjrka0fb
	LjhU0JshT0zd4xsmi6itLTwR8gbTbFNHTM04aqSiiaTGgpcvnwRAUQRnsCSP1qYo
	uQV0k+OoTdy4/BV4edcICtqpLlA3mcrJe2FQEfME1Kcxg85P2yRxJxoBVwRddwaZ
	BOt3DYXtoB5L/Q/dcmBaA==
X-ME-Sender: <xms:8DU3ahWPx1N0O5y0cNyDKUNpCuBYJBRo3WY5ARNQbyz8L_-DCdDOxQ>
    <xme:8DU3aomKD3d8-Jlp7aUnTT8al_o-hi9dAZ6JApMYL8NUyQgqdWl1wLVAHFEcyE1bT
    BOc8j5dbAqRUkcnl-eCriRDeU9C3E_aXQjvyAtDvAA9iV1eG7wfMho>
X-ME-Received: <xmr:8DU3aiYgS5ortCK5nPQAHKAP1xZlL79wR1UKVCpkoFvCveYna4jH6rcB78urzJE4cAr_ZQ5rmejCcOgzxs2-4CckhX1hudnJb2NPe-A>
X-ME-Proxy-Cause: dmFkZTFg5NBtfq5aHD3/OMEn5enxAl0a3ePdmkhpw5tEgJmomXkkMy68ckoBvrRXlhokUl
    JSeFbiycWXZKO6d7EVd2oI+QSwaPJDxCip6ZP1tevcfyVY0mRsHs6DItdzPnetumoMSF7V
    QrmNkWDGM1JgqmEndVUbzwIYT1/EzYSsBngR6RVpAUGUxBRUv/dMvRLnSQS5zl1luvtI0r
    cOGboI2dlg8d+RgjAo9smfJ4sVb8ivqngcDkwphEsd3dMYDFvOUS7qbORVne1NzLiAZwhk
    r+jUjwWGqU/ydYygmMMFI7vrh45E1TCxWt/8lTHiLJy6JH2k2zQMk9vewxWlFeLLoWpgRX
    mlHMEAW9F/p3z7pAUxLrpnOKxzppn7lR4nLez71ZIhMzEgzdIXKpVndKTCC+ewZz4uiZ/X
    Si90jxpA/r13/gQ0nr8n2un68HBEFvxiaZJvMEr1Gz0lXU5+kvhRoUO8xu/PRYitt3Bb1+
    lEVuQ1WQT+BkSduJrBfq9QNyn74yudyfxOouH92K4AqcnTDcTlQGzvBL12JHedOpQ8MOyo
    QBsLVp5bzsf8a7nHDF8RtbFIECNevnGPc2gW6N+crfYOk7Z/WNcq5CrRzKY1Q0DSt4axDP
    rYlkmNhqHnpFMdIUYtQa3PUF8s5xiz9u9t2zQlcC829J034jldRUM40a3gyQ
X-ME-Proxy: <xmx:8DU3ajPiBqEFGw5CzgJdAgQxrp2-cBGYuaD3A20ZUYiRyRmkP0PNkw>
    <xmx:8DU3anZXbS1iWDXTtdHJByuH2akay5P5YmDyKJ_ruOE7oEofT9Nkrw>
    <xmx:8DU3ah2PgNfbl2c7BTICUC7eDX-qnTTRALX_fxaZeGKiDpGb7v3m3Q>
    <xmx:8DU3atcQ-N5Y4QWcfmGNZgX4iTVMc2NKeV9m6tp9IZqRQcFtad2Zvw>
    <xmx:8DU3aqVBh56huPR1iTxPoL9jbHU6zqX-bSGQ5JA-TUoHqE5nbf5sbEjn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Jun 2026 20:53:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Jeff King <peff@peff.net>,  Git <git@vger.kernel.org>
Subject: Re: git-diff in a worktree is an order of magnitude slower?
In-Reply-To: <CALnO6CAx91kbJ84d6Ef655UNG0y0rhyknBRh6Y+0o7Xn-uVytQ@mail.gmail.com>
	(D. Ben Knoble's message of "Sat, 20 Jun 2026 11:57:29 -0400")
References: <CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEuPUh-yoeK9TseQ@mail.gmail.com>
	<20260609001134.GD358144@coredump.intra.peff.net>
	<CALnO6CD+3sE1xQUnRsCFfWrZTsq2Edw7BWseLzasgT3dgtaq_Q@mail.gmail.com>
	<20260611085526.GL2191159@coredump.intra.peff.net>
	<CALnO6CAx91kbJ84d6Ef655UNG0y0rhyknBRh6Y+0o7Xn-uVytQ@mail.gmail.com>
Date: Sat, 20 Jun 2026 17:53:02 -0700
Message-ID: <xmqqa4sog1e9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> But the refresh_index_quietly call is guarded by (effectively; the
> actual code uses rev.diffopt.skip_stat_unmatch)
>
>     1 < !!diff_auto_refresh_index

It is not quite that, is it?  In aecbf914 (git-diff: resurrect the
traditional empty "diff --git" behaviour, 2007-08-31), it read more
like

	if (1 < rev.diffopt.skip_stat_unmatch)
		refresh_index_quietly();

where rev.diffopt.skip_stat_unmatch was initialized to 1 if
diff_auto_refresh_index (boolean) is set to true.

Now, cmd_diff() dispatches to various diff backends to compare two
sets (like "a tree object vs the index", "the index vs the working
tree files"), each of which ends with a call to diffcore_std() and
diffcore_flush() to conclude.   In diffcore_std() there is a call
to diffcore_skip_stat_unmatch() ONLY when skip_stat_unmatch member
is set (we initialize it to 1 when auto-refrresh-index is enabled,
as you saw above).  The function is used to squelch the paths that
remain in diff_queued_diff only because they were stat-dirty without
having an actual content change, and _counts_ how many such ghost
changes existed by incrementing the .skip_stat_unmatch counter.

> which dates to aecbf914c4 (git-diff: resurrect the traditional empty
> "diff --git" behaviour, 2007-08-31). On my system that comparison is
> false because the double-negation produces 1
> (diff_auto_refresh_index=1 or the result of git_config_bool). 

Not quite.  It was false because double-negation initializes the
member to 1, which causes a call to diffcore_skip_stat_unmatch()
be made, *and* the diffcore_skip_stat_unmatch() function did not
find any ghost changes, i.e., paths that were only stat-dirty hence
needed a call to refresh_index_quietly().

> So… has that conditional been quietly dead all this time? I can't
> imagine that's right, but…

I initially thought it was an embarrassing thinko, but after seeing
how .skip_stat_unmatch is used as a 1-based counter (i.e., if the
member says 42, it means it saw 41 paths that were stat-dirty but
without actual content change), I do not think so.

Now, it is a different matter if such a "dual" purpose "more than a
simple boolean" counter is a good idea.  Apparently it confused both
of us in this case ;-).

Thanks.
