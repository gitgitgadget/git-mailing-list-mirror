Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B8B4A8A1B
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215612; cv=none; b=Ub6NsbgRHLrnDoYvqOpmXEutk5i6RDkP4qT2LVprl0JyA/TPQvptK0qaluFlS1Swoa51cOPcyveyArqyTKHPnJKHrlqrrxsYIH2BnqAHlnXtiu6v6FsLy9goAHCwruxAcaTUDjhBoTfizCsmzgslh1O89LyMr5Vhn9nNG5/bh5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215612; c=relaxed/simple;
	bh=djhTr1mD6TQdIwfxc+IFY9aZ4imk1I+zYl+/0n7KDrU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NI0kXovJaisrElxs+JR/Ko+X4qCgevwT/9ELeHbp5LQwt0Mf+eiqzbd1NbIA8Y+il6COyDCSljlrQQoz4Jb6yo1bPfIP7yZqoOD6amglKRSMhPNvJpHLafOgshEw/1nW9Uc600rJvttcF6br5+cXjZEhMOSbP7y9ARItIbKvya4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P5v5Zpai; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZXzCW2do; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P5v5Zpai";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZXzCW2do"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 24766EC08CD
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 11:53:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 05 Oct 2026 11:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791215609; x=1791302009; bh=cBK7+04SBH
	f/e85TflW8gGDs0eVXFtgj1B5Xc0Y673g=; b=P5v5ZpaiVz9XmIYqtz0dodfZL+
	8giyaaBgsqpnZnlu7HhclvvDb+c1IRGb0TcaELC/0cGT72cSeDR3EX80eLm1wYGX
	ShIcLIkEFjhrQSGYUrfhce4MdSzEqTuCP1D8PkayM4ZQorgmeWRbjS8qXOICA8aT
	p68FoViQfnb7sRrZuCpFBSc1krZl/Wkg1L/6oID8rLYJF0iiTw7wgViZfEWoWjz3
	rz7dVDasxzivXEchJxCM67lcwOxWle6tDh6PodrZvYKZhQUiLgQ+HwoJr5XlIm43
	MEM2rubP+AiLb6rcsDY5swYb/UcwhI1Rch4m5MMuhBYJPzxtfovsxyybZctQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791215609; x=1791302009; bh=cBK7+04SBHf/e85TflW8gGDs0eVXFtgj1B5
	Xc0Y673g=; b=ZXzCW2dobMcDnsczp3jYJJid/6ElFm/xJTe4fRcc8W7QrVJUXop
	JsIa9HDTPD2BRIdjJuWtW1FgLQqAseaMlunEDCy4YA3zq7C9CxJlBlMEBjo9z/RY
	LduXPr7NjmN4oNMKn5tE7CNwoVmZ2b7wuN0T4GxIDEDAwS5bRToPzcf5khFB4fku
	0GUEcYUCgMXAEbrLphcPolTpRaUCbrt6dAgo3r3ANE/VvjiLGfiaPRSQ8APQ95on
	jDg3tJZUnpRx8KOg691ZS6mQ3wPT+KuTtX9YMWs6mWpkKvORsua8/BkCzMeigLN2
	KBiiwBW5p66Eln6Uqm72OGP3a6VR6Ggjf1w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791215609; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:nxJO/uVK3grZ6Psy2yHEu5+WjGPOL0PbuvyoyasZSqKdq3V
	H4+uJfjUe1maHf+eWJ/jKSgGL5YlHgM0z4B75M7nwPJtuK0ELhMzvX/JSa+oQClA
	OZC+pheEPwXaYCU9LSEJNWRkHB/pP+gssZvJgbfm6FiliZZdky4lE4MWyYX/mwnH
	6+M4sz6+iYfO3PwQPt/F+0aVCrRf7HoLv7H6gsgjCzxtAs0CDUp1N1c8UyXEYyi3
	MfT9WoypRzTdO9VXM1doertnKghJn0OSNfbnCQBG/Y3w+z7jyBlktxVuwgkbsmwv
	nNKN3X16RS0sTPdie0iNIrcYxsezdZ2SArbf8Vw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:zpU6fO1Tz2212rL1PyNPHeecUBZoDU5f6gBcdD8SECc=:djhTr1mD6TQdIwfxc+IFY9aZ4imk1I+zYl+/0n7KDrU=;
X-ME-Sender: <xms:-cfDaulQ2yFMvhHYXWcbmT-_hYMOBNbLlm2UN2A_clVu1aXBgi2t3g>
    <xme:-cfDasuvCzXfDRfDPkf3H2E4zoAOtaIbCvEnnla34CJ0h-2-fQ9wfWOCJbtZhAphJ
    t0YB5rOphXFYlnz4MEiraVMxLmTLvUGzZ0JOd751_-nHOuIhV3LiW8>
X-ME-Received: <xmr:-cfDak_OINJdStwBiUfLuijnuXLZiH9GtHslGvrVpqeRpUjItN53JFbuSBumMxG5Q0U_14byVGo6AoyUXK_QhgN5B3CsXatEZ-Ma>
X-ME-Proxy-Cause: dmFkZTGbqh4HYRIGPJjyG3eZPGL2/hQsgXE/woDx0pp90ESatArB+gD85FR1VqPO+Gm3L1
    T4wkgeukw3e9snU9Ejez8gRNUSUaMeKJ1InOWlg+x26eBGeU1IZfv+kRt+aJBAXM2EF6zB
    B7KwmTYAIl84N695gPPrkJNSUIZ94/bw8m4Y+KyFYRkEJFi/uxcB6ZVkM694kf7jDHj7lr
    7RCCVqFjw5o8X9PM2rl0xSXnEjL9Qqryi8nuTUbVtg89PTtGewJauVTcjm07uNEEMSkCGx
    Ocv6xJUg7NxiHDVBVUj4+o9H/c4gLHWjCj3x10IFgI3nojlWPIKnRQrDUqHGUM0sxQ6/s7
    fer8OuSh2EeGJd7vBL3kLx1uGu61CifK7mNwoTa+wCxZlwtaocIPJsdm61XEKgHjVXXxDp
    Gfkmfs+lZbWGcHE872yEITtHpMedylPHyNszaohjtwCFPx5zwCFhqWnnyO2HHrq2RmBtzt
    bDUcsY35kJWnxHTief68Z2Wq1pspUrAyhUhj4Ox8zRntGxvrOHAss9Pk7GvjCLo5gfNTed
    BWgJyxQW09arbiEx2ADa3u7jHTpfkAiNn9xNk63J/x/hGvKTd0M380dpQmxqdiQRbx6rEc
    2qdL1rAYClQN2q5zbsXxilswuhBIMFXdBbtZgjytheT08c9pZpaMCWCWJkRQ
X-ME-Proxy: <xmx:-cfDauP7xynAuDgHB7XNUpcEoUrBTv7I9W4S6UhEf-SNP7hY9-BEPA>
    <xmx:-cfDaqHuzbq79tfayDW5RAipujegJYd8mwDJYUDnKWnlQ__GCwHM_A>
    <xmx:-cfDakSaeywopD8O038N-Gc-FKuH-DFFoCuU7WOyoDRXhfy1z3odGw>
    <xmx:-cfDavsOI4LGUdOabTO7dhc85UQs9DsPRW8ieRlOtw0DuNKNBvEo4w>
    <xmx:-cfDah-IcRouW4G_mDq_oD7YHOwAQyjcr34V_ZvT6iGh8NPvek-FLksC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 11:53:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Johannes Sixt
 <j6t@kdbg.org>
Subject: Re: [PATCH v2 0/2] checkout -m: recreate conflict labels
In-Reply-To: <cover.1791206658.git.phillip.wood@dunelm.org.uk> (Phillip Wood's
	message of "Mon, 5 Oct 2026 14:24:47 +0100")
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
	<cover.1791206658.git.phillip.wood@dunelm.org.uk>
Date: Mon, 05 Oct 2026 08:53:27 -0700
Message-ID: <xmqqcxtom9e0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> When "git checkout -m <path>" recreates a merge conflict, it uses
> the labels "base", "ours", "theirs", rather than the labels used by
> the original merge. This short series teaches the ort machinery to
> write the labels to ".git/MERGE_LABELS" when it switches to a merge
> result containing conflicts, so that "git checkout -m" can then read
> that file and use the same labels.
>
> As "git checkout -m" is recreating the original conflict I wonder
> if we should remember the conflict style as well so that
>
>     git -c merge.conflictStyle=diff3 git merge topic
>     git checkout -m <unmerged-path>
>
> would recreate diff3 style conflicts, instead of using the default
> config. I cannot decide if that would be convenient or confusing and
> am interested to hear what others think.

It has been quite a while since I invented and last looked at the
code paths for "checkout -m", but we should use the usual mechanism
to decide what conflict style to use, so the only scenario that it
makes difference between recording and not recording is the case you
showed, i.e., the original merge was made with one-shot custom
conflict style that is different from usual.

As "git checkout -m" can be used twice, after the above sequence,
you can

    $ git -c merge.conflictStyle=diff3 checkout -m <path>

to recover without losing any work.  If your regular style is
"merge", then the following sequence might be more commonly useful:

    $ git merge topic
    $ git diff
    ... stare at the diff output, feeling lost trying to
    ... figure out what the correct resolution would be.
    $ git -c merge.conflictStyle=diff3 checkout -m \*
    $ git diff
    ... now with the common ancestor version, you understand
    ... what both sides wanted to do better.
