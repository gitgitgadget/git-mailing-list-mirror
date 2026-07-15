Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5857A42588A
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784141350; cv=none; b=PhO8h1i9i+WtBW3mE6P9kAjp0GC7kqQyf4+TK8g5GLwwbBVnz7If5j5vuQMakCSP4o7BbS+xogAJEp22OJV5zAYc7MMXIYveFZiet3nimqlGwLG7YrjJvwP+3uIOhOaisZ+Ok9pw3E6975vnugbCIXD/Wr02lJieaZx0WwCG6Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784141350; c=relaxed/simple;
	bh=GW4W1sJp/NEog4l/I1NdEfGDoXzDoekxP/YpWP+8AYM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jVJwIS9Owiscetm2fwgL3tI07bIdKf/mDYwNpfmD0j+NLyrKD/RUkcCKoyTR+qMPAw8mbqYdDvftRvb2yDu//MITom4Y7cWObff2XzR5vxQtW9JN/Ql9LSR+jIbXcRbr1f6EE9OYpl3wltzXTDKaPHa4FnnxCExUNgVT8pVnNJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dWngrOtE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nm0g+AaX; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dWngrOtE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nm0g+AaX"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D1E471D0007D;
	Wed, 15 Jul 2026 14:49:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 15 Jul 2026 14:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784141345;
	 x=1784227745; bh=Lck3qnBS40BTK6ygMfL3sZLCJX1krZBsCSqDZf3hgcw=; b=
	dWngrOtEfGkHT8upGLYYY1u/xQ3aAa+fAiHzME7MAebjmnv8Q+iEUMXghLSqV1fX
	E0zy1LDuiIyzlBIoq3lVwc9rRErGR3dhBsmP6ughDiOMWWY9wfIPMl7dMNrImepa
	G/yOgO/T2Ic70JgbbY5mD9LXTd3YfgQnpFVK76/rwDBFk91fIUzqqPhBBAVi9F4x
	NJrrEGSLk6Dj275WH6wYep+ixjc7tHlTgwASmJElECHcN7iA+Mmb21j50TwVyhTa
	CgXt+T16OhTsWocdDvRNrhMhYcOc4ojSKtQ0QvcZjGZ6fULgruy2Nx9fIKSiOaX6
	24YaREpryJl2b2cu1urBFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784141345; x=
	1784227745; bh=Lck3qnBS40BTK6ygMfL3sZLCJX1krZBsCSqDZf3hgcw=; b=n
	m0g+AaXC7MNcDYovmtSYy+QQZl7N3g+TF/dkpNgNphw9uEov3U2mHAptY0Lsc+UW
	vayOvrdmpM5Q35aydWHVNE2ovZdjvQ4HL/NYJVuWG7gNNxcQ70LwMVznktMG6GJ9
	1gPJjDrHrj27zoexoKCbWw6JkRCJqzaLaloX0CJCFXoG+epTADND8fCzZXy9Cpak
	aATkVJ0VltGyGPt8J0fDWMWazPHPxiJVdckwDTcnn+5aEi7bDGT3z6tVBPGVI4O7
	GthoUUOSovlKlhjpFs8wiFoyjZk/nQMrmLv4ks3e8auW2KPSu6TK60M9CyOlUoSc
	kcx52qlZpZvf/5g0lXnXQ==
X-ME-Sender: <xms:IdZXaoGk1HICr7Pibq-4cLFIeJdQRhe1tSYuzQiDVFTNBEuZ78CQDQ>
    <xme:IdZXaoPXbpD_buEZgpBHQd5TjdI_ig4ln7kFtoOftk2zH6cYUyDiK0JTKfAtwVVB2
    g2BKBf2rbmwy-TJvr6prSzl-_i7Fsr4LTs6H27V43IbfNxjcAxmSA>
X-ME-Received: <xmr:IdZXaqcHqP7G-Vxi6_3rDE8mlsjxKbEqjjHeepJAyDxmWFTHcu_VAn0CGjo_44kfrnL2L5BSfIXYaKatVutsHSdZ-b5ISyDxeKV0Doc>
X-ME-Proxy-Cause: dmFkZTEeR6HSWnxBPoNIzkST4R0qe+ep1YUIpdhmeQTaYM6T07dDqMFRpbDSjECqd8OTt8
    M6cuo7TRj+eHzoiX6cMEy+CMqBCffzzJgCth2DiGgDzl47RwiIlUK8EonCuS4xYvLUSMf+
    c+fqNhag4rU8JhEVpdbSpZROoRDOIwo1KnZ8808zbkBfxvGWMK9zyxBnGNmaO2c3vWq/qv
    P/K5m0v72wb/C4lHGIC0F6WWu1OnZEK+rX0Wf+3yr6zskyqVzf+PspWKJT0qQ/iu0nrh4w
    SIdjUewXYZrXK0uNWm7+1fbaX5sryX8FQUJ6nlwfa6+y+c9VdYVvVuAd7EPr3MNZSfhRIt
    17J9RhuQPGdAgo+jpNdy4ie14hDVQpxbXe8rruVK2TZkamxejBuI0QRscOyRdbpKKV5G0v
    hV6V1o3Y9WXnn2msoXeu+ESYEIMU/ckqgw5bhYiG1bGVNnEQ/z7a9ZTuUUagyk+Ty8pp0L
    CodTbgBdAwdCVVY2ZF4Hp5PLahY2IEnTuMSOBsdy/Yry/zz3rBEhktI7qDybWnRkTJH6Vz
    Jl68p45x1I4llCaHvVycwCDyLyUOfy3XZM5spG4tXTc3WhdviVUv/eZc52rSFFldWgjiws
    l8ODCD2SQhJlIiHqZ1BJHt3o+uC/5Si5G3rL166gLQdMHMMdHhIigmuVhqPA
X-ME-Proxy: <xmx:IdZXalt2AMqZg16E7vzUwpOS1x05joG8Lqt5tJicziROcL8MYumNrA>
    <xmx:IdZXarnjgacBMGZgvmAm_33CCWe9ZW44Ai-KVH_ShaZE_i1AKiVWDA>
    <xmx:IdZXanyFbmX9Uyk17nnW8MxhGg0XYuMc4ObbeJQ3_41lWP-40weEsg>
    <xmx:IdZXatOFhWjLXM0CIrjg6QNHdNZmqoXI1pLwwWULUL1dN2N61oSwMA>
    <xmx:IdZXajWjPDJ6j0XTrxdB7WMp6u7awNePRpSWbwM7W4t0i6G3pXUaJQwb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 14:49:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 3/3] replay: offer an option to linearize the commit
 topology
In-Reply-To: <CABPp-BGxO0bd3UzDYNnhNUgDSKYwcFVCFsJ9rCzmNX7Q0xBrow@mail.gmail.com>
	(Elijah Newren's message of "Wed, 15 Jul 2026 00:34:02 -0700")
References: <20260707-toon-git-replay-drop-merges-v7-0-808ab9b4afa6@iotcl.com>
	<20260707-toon-git-replay-drop-merges-v7-3-808ab9b4afa6@iotcl.com>
	<CABPp-BGzU9KHGF1nipi2HZaa1AiikMKGGaapQzHVH06wO4V1ww@mail.gmail.com>
	<xmqqbjcawnhp.fsf@gitster.g>
	<CABPp-BGxO0bd3UzDYNnhNUgDSKYwcFVCFsJ9rCzmNX7Q0xBrow@mail.gmail.com>
Date: Wed, 15 Jul 2026 11:49:03 -0700
Message-ID: <xmqqse5km6lc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> You're right that when flattening merges within a single branch, the
> machinery must pick an order, and that's fine — unavoidable, even.  My
> objection isn't that; it's primarily the concatenation of distinct
> branches named on the command line into one chain, and, as a secondary
> point, the ignoring of the order of branches explicitly specified by
> the user on the command line.

That is true, but a user who wishes to avoid flattening in
an unspecified order can always choose to supply only one
branch at a time on the command line.

> Concretely: I have three branches to rebase onto master; one of them
> happens to contain a merge I'd like flattened. I add  --linearize  for
> that one merge — and now all three branches are silently concatenated
> into a single chain.  That makes no sense to me, and I think won't to
> most users.

But if that is not the outcome they wanted, I fail to see why they
would feed all three branches to a single invocation of --linearize
in the first place.  After all, the command is only doing what it
was asked to do.

> Consider the following history
>
> M1  M2  M3  M4  M5
> *---*---*---*---* <- master
>     \   \
>      \   \  A1  A2  A3  A4
>       \   \-*---*---*---* <- branchA
>        \        \
>         \        -*---* <- branchC
>          \        C1  C2
>           \
>            \-*---*---* <- branchB
>             B1  B2  B3
>
> git replay was designed to allow you to update all your branches at once.
> For example, with this above history, running
>     git replay --onto master branchA branchB branchC
> will rebase all three branches onto master (and handles the shared portion
> of history between branchA and branchC in the obvious way):
> ...
> M1  M2  M3  M4  M5  B1  B2  B3  A1  A2  C1  C2  A3  A4
> *---*---*---*---*---*---*---*---*---*---*---*---*---*
>                 ^           ^               ^       ^
>                 |           |               |       |
>               master     branchB         branchC  branchA

If that is not what you want, why did you give all three to the
single invocation?  If you want A's and B's all consecutive, linearlize
branchA on top of 'master', and brnachB on top of it, and branch C
on top, perhaps?

If that breaks because by the time you feed branchC to the machinery
nobody remembers that A1 and A2 were already handled, _that_ is the
problem the command needs to solve, no?  I am confused.

Or do you want to be able to tell "linearlize B, A, and C in this
turn on top of 'master'" and M1..M5..B1'..B3'..A1'..A4'..C1'..C2' as
the result?  That would mean the command line syntax cannot be an
arbitrary rev list range, but limited to a single negative plus one
or more positive revision, which may be very limited but is much
less error prone for casual users.
