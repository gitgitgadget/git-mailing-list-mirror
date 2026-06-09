Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEC3263F44
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011278; cv=none; b=UUWTUZB8uDr9eHfrx+N57+dHH+VwJZ9c6Eq64IyBvg92qGyX6ekr5B06SLjL0zE+vquOXREoXPaq4Sg21uYvF1uPr22CqnVgs500wvJdtfwLDb5Jmwhxt1OeMYrumfJLhDaZVSK+8hoN8iw4nQaRj+VFQH/gvQX2A4ucK98+Nck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011278; c=relaxed/simple;
	bh=SC2YJRqqFeyF0W412s81gH+IWo0cpeUu70HV5/yiKbA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VH3cMNwDxQjmjEGE2NERHTD3cV6ztBefxEY4hX2Vf2xh4wI/Tmbc4w+91mKs/Tpc5b63peN0fe6Fdydo2nkUX8mx6gEA3uyR/HEI+GZla+CKYY7XFwNtQOpnA9pwpYq3As63DgMzH8ENyFW2TraBrP5PAdjfbusOoPeOpPMHrBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IBC69ebk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZQKGKvqe; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IBC69ebk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZQKGKvqe"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 1F4D51D000C3;
	Tue,  9 Jun 2026 09:21:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 09 Jun 2026 09:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781011275; x=1781097675; bh=1WZ/s0u9VS
	d0cPwFfRsfysa/7Of8kBxCjxYt1RoRAs8=; b=IBC69ebkqEseUjPIARoFQXNcyz
	iKBlBnApLUg7gLWOStpDnv3q3gupL97tiRmVQUYZPnwtSE7jeM25yZknvSipFA5g
	6+9yT5FpLFT5dMbwp+ZopHSz843tk1CG0yL3FjqLw/r2S9YT52v9t3xTeKBivp4b
	/+HGd8da9ONqXjkW0X6jmev2O/mB4ylt+tPa9/Ho22KjLLDe9c1QFOAXTeKsryG7
	q+yxe1Xfy2yiP2kxGvp7A6j5da85TiK8ocEsYWWtmhiahMlz+f1x+zvy3RPvenkB
	MgKW5982SEx8WzltszGd0hjUX11/kp/plBgwXUf/6NYLiQYycVUlTWcrBTRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781011275; x=1781097675; bh=1WZ/s0u9VSd0cPwFfRsfysa/7Of8kBxCjxY
	t1RoRAs8=; b=ZQKGKvqeakk5COQ9649f4lLB5vp9hxiYPcaDm3/bPkDXs1428p8
	+sYFESKKydCw94WGhj4jEZwBSGQRHemqJuH2M5G9s3NExiqHJdB5+MeXmFAySmyL
	bMPYFbEJjRgRlL/Y4Qu+S9RRGSqfYylmyfQcgA6esDj1+Yj1s3JY9Y+RyUBltVfq
	NB2NGYiVexwUqqScXMih7FLK2PX3DpsedG309ePgf0tjYHW1ODG1QCP8bCAIaV90
	9fQ5uI8fgd+nFuvj5Tth95gy5STYj46u6kFDJ2ct8sO+S7Hmb+jc6zVZrZ3m0my4
	1Dd5dv+FQHAUiEMNnuT0FPMxeEtS0XPuH3Q==
X-ME-Sender: <xms:SxMoashJwbXEWk2UYgmcwTBMVxJ6efO5-nGg28fRTGPJMAfML00MtA>
    <xme:SxMoar4AI5tcduLxZbrCDw5kGsAWE7-VWFCNt5zpCWCIZTI6mEE5VMwfLVfBRl0AQ
    D5MWAsNkrZJ7bP3r_dGoH8gf8KuLvFVsP_P0jI0VQ6qpgENgr-DPA>
X-ME-Received: <xmr:SxMoasaXzJYSjB56ItTWKFi_qm_ryNrjW9_fxiI_lV7fNOKpE-LrCV-7bEHd0wH8O8EcP-jwAsBtZMAw99U-RCfdy3VNWYQs9zYd>
X-ME-Proxy-Cause: dmFkZTFF2lK9bP2EuU7T/KbdHpZhEweg1OoWN+QT9StaRG3DRzfXpzcOrojhBzfZ2bxvkc
    /C5+a3toiuAlhYTvlSwXHcBNcaTiKrXi4c8uRj/3iWvXAfNBEVkZsKwZXp4DjQxB038WYf
    WX5nPKjS79P8utxU4hxJEQEYyaIVBUmpkLJvdDfquwmT3R20lvKPeh3oc8uLgwg/4932hH
    pR6tvGuGz2T8hty10gV6mDZPhtL8T3g62v96N8qq+NLB+65sN2FMTWMUyat0kekemEgbaB
    4mSeC0Z1c+FVDyz0+DKApuw82lSvt79MC7FmWvKSfISGsRaaEHJbe3v4wHv04EYZDns3Ss
    QGGZc0v0rC+fu9v8vg5LKfcYvpeOEcHZtN5ac73qiqvPXFynCK0UBosMpRvgYS6Ga4vx0d
    3c+kgBzbxGnsS+haLv7ktPB/CMmGDhCjSOZQYtsgvGZQEbjOijAeY4KJh51ueu/CJ4hoIa
    d+c7sviZzhu525zaaVkw9zepxwsxZcmB/KrCueBfmxDZy+G9l3yUsnZOB6ah6fm6t6B3ux
    HHG+7BWMwhqAIG+YZZZM/Lt5+1t+O+w4AsMdfMGHJLAYAERSIFoMcK1Phb0QbOa2v5qv6h
    K5cgekZF7d8ZqLH5fRV8rZYDXCMmR4jwvxDH/8ZAcD5PXG0B02W7yx+8t4aA
X-ME-Proxy: <xmx:SxMoao6toSlDkshlFopTeUi2g7ODXtFgy5sKaUXMHWGUqfMKmPNKZw>
    <xmx:SxMoanA2wlMyqU9hbljLvoKsu21EYklxBLAWkOrOL_Tzd_sAStzM7g>
    <xmx:SxMoamcn1nkzjn-XNv1Im792OFrd10s4JbF3_ZK_wwuQEKxccvWjSQ>
    <xmx:SxMoauKYwkKZpOadmbxiD_TpJF6r4GqMi3RXcISQmC-DjelUJRXcVw>
    <xmx:SxMoakJNPRw0RFL53VFg0vxRm5wg53vR4MNd-erTNEyOY-IT4oApM_lu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 09:21:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH RFC 1/2] builtin/history: abort reword on unchanged message
In-Reply-To: <CAN5EUNRW3gyLKGC7x5BBMTNKtunoQks9AaXJse4PHvCziRF87A@mail.gmail.com>
	(Pablo Sabater's message of "Tue, 9 Jun 2026 12:14:05 +0200")
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
	<20260607-ps-history-reword-v1-1-ba43a3cbb81b@gmail.com>
	<xmqqmrx5z0po.fsf@gitster.g>
	<CAN5EUNRW3gyLKGC7x5BBMTNKtunoQks9AaXJse4PHvCziRF87A@mail.gmail.com>
Date: Tue, 09 Jun 2026 06:21:13 -0700
Message-ID: <xmqqtsrbsvcm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> True, after reading it, history being more costly or the in memory are
> not good args.

And no argument, including that history is new, is a good excuse to
make these three things inconsistent, period.

One of the patches in your updated iteration claims

    When using `git history reword <commit>` if the new message is the same
    as the original, it continues and rewrites the history when nothing
    changed.

    `git commit --amend` and `git rebase -i` with reword share this behavior
    and it is wrong as well, but changing them breaks what people are used
    to. Take the opportunity of `git history` being a new command and handle
    it correctly from the start.

and I think this is a totally wrong attitude to go about this.

I may have said that it may have been a better default to try hard
to avoid making a change that is a no-op, other than that it changes
committer timestamp, while making the current "always create a new
commit object" behaviour optionally available, for these three
commands, and cited that the behaviour of 'pick' in 'rebase -i' that
avoids unnecessary rewrite as an example of a good practice.

But I do not think the existing behaviour to always rewrite is
*wrong* at all.  It may be wrong not to offer the other choice of
pretending no content change means no commit object change, but that
is a different story.

I also do not think *aborting* only when the message happens to be
the same is a valid mode of operation at all.

The most sensible first step, I think, is to add a new command line
option to "git history" (which will gain more history editing
subcommands) that tells the command to leave the original history
as-is when the only change rewriting commits would make would be to
the committer ident or timestamp information.  If in a future a new
replace-tree subcommand is added, e.g. if

    $ git history replace-tree HEAD~20 HEAD~27^{tree}

were a command to rewrite the history in such a way that 20th direct
ancestor of the current HEAD had a tree object HEAD~27^{tree}, by
derfault the command _should_ rewrite HEAD~10 and everything that
has it as an ancestor.  With the "--avoid-unnecsssary-rewrite"
optimization feature on, however, it may silently become a no-op
when HEAD~27^{tree} happened to be the same tree as HEAD~20^{tree}
so the only difference between rewritten and original HEAD~20 would
be when that commit object was created and by whom.

And give the same option to "rebase -i" or "commit --amend".  We can
discuss, educate the users, and flip the default at a major version
boundary, if the "avoid unnecessary rewrite" truly turns out to be a
better default (right now it is merely our speculation, and we do
not even know if the current behaviour is a worse default).
