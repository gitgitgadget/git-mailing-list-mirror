Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AB330ACF1
	for <git@vger.kernel.org>; Sat, 22 Aug 2026 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787419331; cv=none; b=fZUack6PPrbSEb2ZcGK37Ve/qBEALDmxZeE1FWcNjlIpmF47YVMMwrthLtHGaqMYmVrmMfa09sJW8wsxeGHF7+N/sZ2g7eotaWxwFg7fgi5cwaIYA3IatnNoviZL6Rw05SlK5nQNUPn5NVnPuztLKjbvnKUdIO/sNX////b4Rqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787419331; c=relaxed/simple;
	bh=IGXqP4ezf1cnKFvvKo8tDcPpJDaW4M9EknM2KmQlbWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CeeBruDUF6Jd1uRlJv6aGMFvDl81VDrvM8t7898mrb/RRPq4/MV+HD/SV4BodcZE9Ih1AvSxbfDY/zUHLVNbfAA2pQXZaIbQnwbLPWqTahS+cQRJwoewp+ymTMx1lomjJkutQ4Cf+3UM1jE4/E8B5MtueJk/Uc0Xtw7rPVcWbTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jCi5KK68; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BMFLsav+; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jCi5KK68";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BMFLsav+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 802E27A008A;
	Sat, 22 Aug 2026 13:22:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 22 Aug 2026 13:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787419328;
	 x=1787505728; bh=sDfwee+OiXl978mdVBDpw7hHtXlutIEViLy2/nMt3IE=; b=
	jCi5KK68aPqwpKYwGPluOIB9pZ5X/bmxTyP2xOdwdacEcChQqvgZP1/jqCXEyr4d
	qXbiFPRGpLOUUAbvawx8KJaJNoxh2nDzh17gKHWhNPEdtngY0/oqnHybBfOJZfXJ
	ytW5LywFj+LtyzQIXYypKNq91m375eQXwlvjgArlX4vcPQTQDfui78B4it4SNid8
	WNkVBoLtMEYpE/FbRCQnMJ9igx/SMC6dmp5aNSK51eQpes+aYLTcVI+gCHgomohR
	AoQ1L8mIWH0+PmqfFeIyiE2++1lMTx9jeC1vuicPqCnNqb4SW2droONU5QQ6rZj1
	znmvGMnTHGmWFlPm8uNT3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787419328; x=
	1787505728; bh=sDfwee+OiXl978mdVBDpw7hHtXlutIEViLy2/nMt3IE=; b=B
	MFLsav+VHZ0PZeSgQHJ28TStz62l+Piw84yymddsgmjgmLiAmPbXVG2nedEC42Cd
	ZAutsG5A+qhq6ZoJmEUqi9mQTNJGRjRFGGVS0ZqF8f/OpV0u4+N7B3mSyEm5epeV
	eCtfJ1KQVAk4D/dCg271gMz0lmvRUSw2nlmjjNgVlP+Lq/Sz4FLbBQnoWrm85S8Q
	wgO/R2bip//8h21gN/gRIV1CTUGKse0f4ILkFcXQLwgn1PvblL6X0cw3zUxGBjoN
	YKYCIKaK8UV/I+E4T5f2X/cJ+dytKY19gEXKwFsxThqsFxE582Lwv9jcWrxaAoyK
	JzGQtmNoJz19qwCaTcAGQ==
X-ME-Sender: <xms:wNqJakjHeDbvov1cnIDS1SluCPvQOSqV163W--a_jT7B6jqUfguc-w>
    <xme:wNqJagvLSNLU1OQOJ_rJAAgdP0-tRQT7mcoAtdAKGKNRePQdTE6O_DsrA5u80CS3c
    -J18Bj7akUGp3kFGsZgvCXXEsPMigB5_1ybjzIZJtfg1HU99bNwSg>
X-ME-Received: <xmr:wNqJal6wUfBVmQH8Q9wvXh-_QBrv-QZOp9tunyx4sdxdyUzT-LeJLdk1QUmGMLDpChtAcAm-EzAuyqVuiRuDXc8FFkDyG-IJqw>
X-ME-Proxy-Cause: dmFkZTE94TqOnlw+zMJEudxgMz2lVHZ5LHQWL8TUGtyM90x7aAt28tZ5HfJUmcJayiG9Mt
    sjVSCee4N+79MHurvlpde303tZIyK44EZPAnEbaSuvroLuCDdgmKroM+vFmrWuyYd+6CL8
    yHzqNjDrT3x5SkpLPuFq0BgnxZv09uuQvoHlQXO5SU4xT2hvdpkGLKtu/5dE4+Wseo5dru
    y8hkYY6LZvp+Af1pQNy+Q36xNyZumMQyOqlTJ6qQJVE4WN8OOCIOpB3aZOLieOtaTQKlm5
    RkCzKKwrGCtq4j2yEA9JchXHMFa1WMKDH6OJZGRJYKmkhrqmzNqCQT+q2PifucnVnm8ary
    C+VbiV4D5f2x1H6Ph2+QSxESI6JpG976nnxkBLSunoC+S2T4bGILeQs9ZFMVqBoYtyAmq6
    DJugEUFmE58p1RSEZSzOsWXiPOBDRaDJaQpfMk9j8D0/m4jAhGPRWKP3v/BuPWbR4q6qg1
    WU/2hDzM9GZlWtFgjUyIg2kUg83virkUVx3IrTq7ANin0148J5NS2QopUF4foe3Gxa78Y/
    R6R4h/pu4JhUMbjIhzanD3XrLfEaUyyGMu+k02lHFRaq+66Vm3jVIHQsO+JI8W543y1B9d
    EkJ+4W4wW7Lhxz3ennF6is6r0XauWK2qOLmPCpiVLH0lP1lIdNaCd1QGpH1Q
X-ME-Proxy: <xmx:wNqJasP70bWz2N9ItQ8zQNRsJ9tyIaMh9LOivla3KO7rtMJEfTVBtQ>
    <xmx:wNqJajsz06p1c5lMPY5LpEhBzXNJJAKLDKApgEWhTl5nSSuwVLHhoQ>
    <xmx:wNqJavbwh2-lyhstGbq8LDNkxzZM1-YJsKmQJ9Y6kVo6AuUmBeS7KA>
    <xmx:wNqJalwTLyTxulU1fXS8aZMKzc59K-HwL9P89VjXKf0dcicg5DrShw>
    <xmx:wNqJaiEPTCZjYAF_a-7OC8wFI8Hiti7UhLtoDnWIIvE1z1p37m-NIJx8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Aug 2026 13:22:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Yoichi Nakayama <yoichi.nakayama@gmail.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>,  "D.
 Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v6 3/3] worktree add: improve message for ambiguous
 remote branch name
In-Reply-To: <CAF5D8-trxeMd8HYzy6kD4myf+bynkxOvxKDQrMdmqnvcdpdkEA@mail.gmail.com>
	(Yoichi Nakayama's message of "Sat, 22 Aug 2026 09:50:48 +0900")
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v6.git.1787259838.gitgitgadget@gmail.com>
	<dcb84a69a6a65085d468a0a212cea0281605c5d0.1787259838.git.gitgitgadget@gmail.com>
	<xmqqa4qgruvj.fsf@gitster.g>
	<CAF5D8-vDzp9xhu96Tu0ScmWRHvVyi74MD0NhPMnQ9ayoy6h+wQ@mail.gmail.com>
	<xmqqzeyfxcdu.fsf@gitster.g>
	<CAF5D8-trxeMd8HYzy6kD4myf+bynkxOvxKDQrMdmqnvcdpdkEA@mail.gmail.com>
Date: Sat, 22 Aug 2026 10:22:06 -0700
Message-ID: <xmqqld9yvznl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Yoichi Nakayama <yoichi.nakayama@gmail.com> writes:

> No. The exit codes of the command 'git worktree add ../topic-branch'
> are the same (== 0). but the results are different.
>
> If there is a unique match found in dwim_branch(), it creates a local
> branch named topic-branch which tracks <remote>/topic-branch.
> In case of no match or multiple matches, it creates a local branch
> named topic-branch from HEAD.
>
> Since Git treats both cases as successful, either can be considered
> the intended behavior.
> (Although, if there are multiple matches, there is a fair chance the
> result might not be what was intended.)
>
> I am confident that it is appropriate to provide a hint when a command
> fails, but it is difficult to decide what to do when a command succeeds.

I actually think it falls into the same class of bug you are fixing
in this topic, which was caused by not considering the possibility
that there can be any case other than 0-match and 1-match, and not
thinking through the ramifications of treating 2-match and 0-match
the same way.

It is of course OK to fix one bug and leave the other one
unaddressed, to be fixed in a later follow-up effort.

The rest of this message is only for those who will tackle the
"later follow-up effort" part after the dust settles once the
current topic lands (aka #leftoverbits).

In the beginning, before Thomas Gummerer started his topic in
November 2017 [*1*], 'git worktree add <path> [<branch>]' created a
new branch from the checked-out HEAD, without looking at any
remote.

 - 'git worktree add <path> <branch>' before Thomas's effort errored
   out if <branch> did not exist.  It was safe to add DWIM from
   remote-tracking branches without requiring any option.

 - 'git worktree add <path>' used to create a new branch whose name
   is derived from basename(path) that points at the current HEAD,
   without erroring out.  Enabling DWIM from remote-tracking
   branches unconditionally would have meant a silent behavior
   change.  So DWIM was added to this case to require the
   '--guess-remote' option to enable [*2*].

Back then, unique_tracking_name() did not let the callers
distinguish between 0-match and multiple-match cases, so when you
had multiple matches, 'git worktree add <path> [<branch>]' triggered
the same code path as 0-matches.  When the DWIM feature was
designed, handling the multiple-match case correctly was on nobody's
radar.

Even when Ævar Arnfjörð Bjarmason updated unique_tracking_name() in
3c87aa946a (checkout: pass the "num_matches" up to callers,
2018-06-05), in a topic that ends at 8d7b558bae (checkout &
worktree: introduce checkout.defaultRemote, 2018-06-05), to allow
callers to distinguish between 0-match and ambiguous multi-match
cases, this work unfortunately concentrated on improving "git
checkout", and callers of unique_tracking_name() in "git worktree"
were updated to pass NULL, i.e., teaching them to count how many
matches they got was postponed.

We know that the update to unique_tracking_name() in this work back
then was not complete on the "git worktree" side.  After all, that
is how this topic arose to fix one of the two code paths that call
the function so that we react differently between 0-match and
multiple-match cases.

Now that we are aware of the issue, I think the code should error
out, instead of creating the new branch out of HEAD, when there are
multiple remotes with the name of the branch.  In other words, the
existing code that behaves the same way in 0-match and 2-match cases
is buggy, and we should eventually fix it.


[Footnotes]

 *1* https://lore.kernel.org/git/20171112134305.3949-1-t.gummerer@gmail.com/
 *2* https://lore.kernel.org/git/20171126194356.16187-1-t.gummerer@gmail.com/
