Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48E24AE10B
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788624640; cv=none; b=ZUt0vmAtznh7l3oGUTnREgi706ZzY+Qh/XsrRPzo90Gd20WTYmu2H9QNIbYDK6zO6XzcNo/v5FdIAQK3lilPRG7pgq0ICBFn22qFY8i3jIyOl8ADuhlnWIiLiveb67ZNQ2/H1nWzgMY+L/hxmRIN7CK3kLJ3a/7PgfenEanL6A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788624640; c=relaxed/simple;
	bh=y2YJZ4tGUgB6qNBsbl173Nnxp65g+DyJtTiWZhTthTE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gw+xOYODDYU1ggmw3goRuD7qPdZtiRBZt+umm87IzCAg+6AF4Oh+XMsQhqUHTomEvUcog4FCElcEEwhxyw+LiHlf9v7Cqc3axQbVR3dtORjkE7QVBVo/Cl2oQ0wWCW82msYUKzmoI/hoaqu6n5d8sGCl/xueKXpy48CJ/pMF09U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BWPBZyrJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dq2DiSsS; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BWPBZyrJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dq2DiSsS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id EC17C1D000E6;
	Sat,  5 Sep 2026 12:10:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 05 Sep 2026 12:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788624635; x=1788711035; bh=o0ReaHipTA
	IPkPKZ/hveHEmpC/T5+9OML+0ncM7jTnI=; b=BWPBZyrJ1wjpwRtcxSbgDMgJ48
	7m6OeClP0LBq1I2lcQuKzRNwqa4EdonuTSqMttHOgmMnWydFo3N+R3XJUJ7Wq6Ge
	UddQp1RVZSHWFNYur7YoIzncsYIV2bSy9UgwzBgx817el4Zls+bUddbRcHxXYOtW
	yJ/A18Wll06UlB0aaHW1JIOA+UUcv2QaQUo8x+26Uij0BJNnX9l/aTSiSzzoXZt1
	+RgMwE3valBXuq98JDjPbXZacLVzheRsyy0UXdLnJ20QRKZhzmSBFC1apvFu9eFF
	+WIMFPhVQFvS7aWoOBTsP6+pXCXkQ9Q4UOg+RKwYNHuEvamrsXxiszxZJPQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788624635; x=1788711035; bh=o0ReaHipTAIPkPKZ/hveHEmpC/T5+9OML+0
	ncM7jTnI=; b=Dq2DiSsSO1iB9K2ihajsIgd/Sqnm67A6fDK47Mivk56Mequ5bUu
	w9iBMIolVtq0TqYHgY0+UQC7iyZZUkx2MwevKopc1BgXcDeF9cUCHOadaTBO3tCm
	UXjbXkrGJJMqfAVOWjnnpI6dUKL9JCg8+RVvuSUkxT2Zr+nIzHLATs9WR74W5jar
	dUf0PsQuQ+tQe096udokeiIQGQLmuAqQs/gbahOFHpc6mtW8ESmbBGlCKbfgwQd4
	T/zsbvWBhYP076B+1e/bP+eE7Xt8EBr5njxNPp/CLeneddqev73/G0HUc15HXXiH
	nuk5x6SoNVID72t3LZZ5FayemiiQfD0W+ow==
X-ME-Sender: <xms:-z6car4_Jx3NgwV0xqzW_9Hc7JrkG-C0cwz5gsQZPc2qBo3BtMvyWQ>
    <xme:-z6caiYCxLk_Lj6NGNKmSvl_603MNh-_PVvYf8L-WMRnif_Fxb5PgPWgaXbTQ9Q5a
    t2YRWabW24YIqMeSrbb1BofNzyRwJ3LH5cOVSjgDcgG_MVsZBdO>
X-ME-Received: <xmr:-z6caijLgFbB6S1RQ2M5ZoC1LEmj89oYcux0T_EzOX0s0Kbhq06wChPWPVQbymPXka_wTlpfdw8tx6l18jVT5up9kLENdL8Kfe38>
X-ME-Proxy-Cause: dmFkZTG4nCVSJXRDqhmZPjnayisjOOphmOMSMBOeOY+Wjwp3zS23/KGS1/sGEUeeMFqR8p
    9NcA7PFT+tDCztsR93wd9es/5i91xRIUkqruPBByVizQraVl8KuOPqOgPLDxvyJer7v1Ip
    RBHmrvsM1ppqZnQdwIoPzmWSyGRZp8Lmxkztm1ilopR3/BCv6qCmVS17Nij15z/lCT3Vb6
    WFIXCeqhanIccoT/lylGHWM4GI+Ivqv8Txd9l6SwErC2ykYEfwCXoEUTFpkjYFgouYxsqL
    zan1NJIkRVpnl6DGeUDtXZnOmtG4w3tIJ3dQv2kKKYswVRmouOn0SOFqS58iWbwbfay9Fw
    eSqJThVq7ZZxKaCVm6bO99va/42jSljBD1//bDX2PG60jKdgH2NEQ6ZXZ4d1hm0NNaPyow
    Jk008APPF7kvyUj+nP8ZaksZW+/xUdGNV4ik/Gpib2hEb7TwK4EOmpGLWx6ZKwQJXKJXHU
    W/oQBeNs+JDKC4JAp/WHN33mD20biHSy3PTbIGK5jpjr1WqpDynNPI1/C7cU5VfFDCrrc6
    DRRWf5CLHl+rclZaYv2L8lCfgRDjwa3LnArvyN2gybVctp0B44dR4Ty7Lr021xsAchGlj9
    vkpupA8EzHw4VJLcVhtdlOcehkCnxtlgVyfb9My5MLHvewui0ktFY0McIbkw
X-ME-Proxy: <xmx:-z6car_JOIgbEDeNGoQ8TifXiNrFKxEAnCrh4fv96YiUwDdhMH-2kw>
    <xmx:-z6calrIvPmDVCm3SqpLfw0QVRWvdWbGfhRdGJhtBfIO8nWHxOiQlA>
    <xmx:-z6carVry6fX0ywTY7IdLAtH6BKhGEWDSJJzTEH-tAKK8oIHm8qhNA>
    <xmx:-z6casDUAL7totclI4Tsp7t_fahpTTHL1TlZ1nZGcsWxuFeGlW1X5g>
    <xmx:-z6catvVG9ql4El4D-Is7OsmI1IWgaojs2nsMwLUOEsoOB9cQkD3i7RM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Sep 2026 12:10:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Thomas Bachem <mail@thomasbachem.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] rerere: keep a background gc from killing a rebase
In-Reply-To: <CAA0xjtqF_60kKC_B=-=AkBSG0ZiFd_uSjzCZ4Bup8Pvg1_uALQ@mail.gmail.com>
	(Thomas Bachem's message of "Sat, 5 Sep 2026 07:41:38 +0200")
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
	<pull.2214.v3.git.1788537081930.gitgitgadget@gmail.com>
	<xmqq4ig44ywy.fsf@gitster.g>
	<CAA0xjtqF_60kKC_B=-=AkBSG0ZiFd_uSjzCZ4Bup8Pvg1_uALQ@mail.gmail.com>
Date: Sat, 05 Sep 2026 09:10:33 -0700
Message-ID: <xmqqwlsz65mu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Bachem <mail@thomasbachem.com> writes:

>> Perhaps it is just the way the above three lines is stated and what
>> the code actually does may not be problematic, but I am not sure if
>> that is what the latter half of the above sentence is trying to say.
>
> No, it's what the code does. Once the timeout is up, the conflicted
> step goes on without recording the preimage, and the resolution the
> user makes after that is lost, as you say.

It is a hard-to-accept regression without a good justification,
though, especially with the other efforts to tame "rerere gc" from
hogging the lock too often going on.

If you have a 100-commit "rebase" that is interrupted in the middle,
say at commit #70, at worst you should be able to hard reset and
abort it, and then restart it starting on top of the result of
applying up to commit #69 (with "rebase --onto") to finish the rest,
so failing in the middle is not like throwing the effort you made so
far away.

> A gc that outlasts the timeout still stops the rebase where it does
> today. With the gc giving way whenever it comes second and the
> sequencer series keeping a rebase's own commits from starting one,
> that should be rare. Whoever would rather wait it out can set
> rerere.lockTimeout to -1, but I'd keep the default finite so a lock
> left behind by a crash fails like every other lock instead of
> hanging. Writing the stop state before rerere runs would let such a
> rebase continue, which I can look at separately.

Stepping back a bit, what does a "conflicted step goes on without
recording the preimage" exactly look like?  "git rebase" goes on
chugging, and hits a commit that does not cleanly apply.  It leaves
a conflict and in a normal case immediately before returning the
control back to the user, its "git rerere" invocation creates a
preimage.  Even if we make "git rerere" fail to do so, it would not
be unrecoverable.  The end user has control at that point, and it is
not like the rest of rebase goes on without giving a chance to the
user to intervene and recover.

Would it make sense to LOUDLY tell the user when "git rerere" fails
to do what the user expects to do?  The output at the point of time
on the terminal would end with something like

    CONFLICT (content): Merge conflict in t/t0123-frotz.sh
    Auto-merging nitfol.c
    error: could not apply 8c7b68a8bf... nitfol: remove frotz
    Recorded preimage for 't/t0123-frotz.sh'
    Could not apply 8c7b68a8bf... # nitfol: remove frotz

if "git rerere" kicked in correctly, so if we said

    CONFLICT (content): Merge conflict in t/t0123-frotz.sh
    Auto-merging nitfol.c
    error: could not apply 8c7b68a8bf... nitfol: remove frotz
    FAILED TO RECORD PREIMAGE FOR 't/t0123-frotz.sh'
    Could not apply 8c7b68a8bf... # nitfol: remove frotz

    *** RUN "git rerere" MANUALLY BEFORE DOING ANYTHING ELSE ***
    *** IF YOU DO NOT WANT TO MAKE YOUR EFFORT IN RESOLVING ***
    *** THIS CONFLICT WASTED ***

or something similar, would that help the user?

I do not expect the "silent failure" to run "rerere" would not be
followed by automated applications of many subsequent commits that
makes it too late when the user notices what happened.  An attempt
to invoke "rerere" will always be followed by a stopped automation
and the user will have the control at that point.  So in that sense,
as long as the user is told clearly that some step that usually
happens and the user has learned to rely on did *not* happen, and
also told how to recover from the failure, it is not too bad.

Thanks.
