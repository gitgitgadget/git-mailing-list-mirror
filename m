Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFC73C1D79
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 20:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787000312; cv=none; b=XF+GnRSu/8FqQwAX/nGtQGzlc95QYvJ11Gp/n/IQg3UK/SUj3MBXIkq+uh4HIePfI/TQ+Y2yhN5sSDM+OEbgtv3BqMWo8RKmvJiEAAJOToJUW0JXhiCtVTswzGMoIKpK6AKvx1JJuZGzOVI7fViLb1fi19b9ryVLMSyWTMwxfkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787000312; c=relaxed/simple;
	bh=b4sR1xi/pbT1IfVYIgwMkVDfffPTAlccIiDkHc72jN4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kAwyRLVsTsJwrGN7KNVLARjYtKD0MK06bw9Fv12GhugpG4rDRJnh2a+leuOCTlZDwbAe7BOKf1iCMckI6uof1nqwh80c92BXa7CGG9xvQCavdV+1rjASBY4bLaYHytSF68KrVwghnTUS9ToxVKKBCPTIbK78Uf/W54JxoQwm410=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vrIYgrFZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fdwzGmTl; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vrIYgrFZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fdwzGmTl"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A7C3D7A007B;
	Mon, 17 Aug 2026 16:58:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 17 Aug 2026 16:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787000309; x=1787086709; bh=nfQfJaGyg7
	+de3DVFDOutgz/EBMGROUufvWxkHuuPqU=; b=vrIYgrFZUYD0JnH281P4hxHDAs
	+GZcl3PqLw7DG7sBBqj6eX0HaF3DjlKmpxTv1vclqEnKUDs8BW6p5UqVIQ7vuCJH
	8FQhTq6Nq5E3z3dG88nUBKF8/MV4zRuLWifB0I25uX2FX71Tbky2cSYeCCqqpciA
	SC9cXSbMzptEgpJxYdoxE8sP44HZwdd1qW1jkbZBoGZ2UYV6OHcOHB7UJ68nhtAG
	K8ik+so6KpHRGQ4BZU69LcFVpa9FFgcxumuz8FKuZ50/2Kg0AVrqSyRS2SzkKkGU
	rLr++CiS4vSHKxwtZLE5g4FOvUQr6csCXsc2LkBzkM2m2XV/k35MD6OhFC1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787000309; x=1787086709; bh=nfQfJaGyg7+de3DVFDOutgz/EBMGROUufvW
	xkHuuPqU=; b=fdwzGmTls/L9q5LySxw76O/eF0UHEddmnYEEIMh8SCegm1Z+iUI
	UgTq59Vs1qB13RBP5ZhhCICeYNrHcW0BmveVpMm4m/K3XRvWKa5fFhnoNZrmCGEz
	BJILgnTgz6dG8YANDuqIh2p1ODCbX+3FU3/0JubNhHOFn7HE93uN9jyRXz1BZ4nr
	ambOb1mm/cTXUu7+8DWdYbCpNnkevuHS6XjMg0Xv+KmEKzPxbFXOQWeXUQwFuRwH
	vtYPUVNQk/cY+dpEdCEe9t22ssHIXQ7wgsSAEfb5JJ9Zu3ZBAV9khbASgNGVFKGT
	YGNg7uIVqNGq7weo2MkU5+U0A3q+LMXR6XA==
X-ME-Sender: <xms:9HWDatzgGW7wd5W-PvgOWgmlbv7J1GXvvevZrRz0NN2BAWqRdRSg3g>
    <xme:9HWDagVnT2QbvEfwtwaH2BheeGMdjgZRrmEjgofVL1elitYuLrAFm1YiSpmuCM1Ql
    v4E9hlYoL1IOBnBoeZXyECmNKv9qVc_fjcTSIoMvv6N1ONBwyzHG88>
X-ME-Received: <xmr:9HWDah8zF7f7ZbpIh0e4pal_OVc_qcHMDsNysvHUSZvActxivy128VnNfzxfBYfY3JGyhISnWZl-g-6bwrczHudbCR8bPKh6aw>
X-ME-Proxy-Cause: dmFkZTGsubJBatbvRgdPCKIgt/vpgJuxPnU9DCC/d+XYLmQeYObmrLmwo8GLp4eFbpveuh
    CYm8uRjAHgJ9jNpVLKK1uKRZLLvPAt1IHBG77TySVElPquhi9fQA7Qbj/9sq1/KI5FAxLT
    fUM6xFIGb6TEsg6llDWrle13QDoUAwai7W5EnC+wHj9J3GAYAvPd6VQhEftiwQjiyAkRyv
    7qMM0c4M115lElrAnfcAMQct9U7J4rcngL82x9uv/i4imK9fLvB2PTGiOosQkHPK7tYn/L
    CR5/pZ6gDL9soQ5GlpiIICdhQLQad2O6w449c3TxZWNWEUhDquv0/tN7xwYyc3+3iAzTEe
    qao8sIi7VwvL18fiPYYmrGzoP2gl0Oec95CdJ0q8lPXA8DpCbMzAYAdxbdFOkLe8XgOPSn
    K5YoYyhfGGCGe3i933AGUJtR/AfSN9XOtrK9EpedBL/PTnF9EYbBjFBGj53FgAvfWJYk76
    nBo+7ZBfRUWpKB7GiZPwj8d7J0CO6agneG5NB9vwUAkyFKcIQhDFaEj/HBh2FpvrXtkD5B
    w8YGzA/WtrRydA6WJgEllFX89KOwtM6beocsDEk1sSfOlwP6uO8FdjwBpmF3p0z4Z/I/rd
    4ELrTvuMGkcYcrx26OONNP6i4H/RPYFfSXQx/wmCnwNdpJitC/1svkg3Bmdg
X-ME-Proxy: <xmx:9HWDarsVZaj3sEMrCgzskQwdAu7vdILVF-oH3CaPzwrgTmdU8stZBw>
    <xmx:9HWDap2rtEokhYL2rn1LvL0X_v_YYFLIkHTz007Gr0WoPRh-DM13zA>
    <xmx:9HWDaoQwSj4GkmeAv0cCRYLZEwz3jEFF67tB4L08QRfkVGggLZ1gXA>
    <xmx:9HWDalcCWOiZqnUPEKETg7Ykjx4kPX4VhalbrjQnpDUYSBbSB2XbBw>
    <xmx:9XWDaia-E7da9t9lWpXKj0jk-08oLpdmyMaLmnE24uSAyWtGr20IvZ2d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 16:58:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Patrick Steinhardt
 <ps@pks.im>,  SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
  git@vger.kernel.org,
  "brian m. carlson" <sandals@crustytoothpaste.net>,  Elijah Newren
 <newren@gmail.com>,  Derrick Stolee <stolee@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH RFC v3 2/2] Move libgit.a sources into separate "lib/"
 directory
In-Reply-To: <CAC2QwmKs-TV2f=2BhBNQGtVA4vzciN-Vkh95RkGcVKe=6zwwRQ@mail.gmail.com>
	(Michael Montalbo's message of "Thu, 13 Aug 2026 12:04:52 -0700")
References: <20260701-pks-libgit-in-subdir-v3-0-5e4860056094@pks.im>
	<20260701-pks-libgit-in-subdir-v3-2-5e4860056094@pks.im>
	<alR9GDNTbdjWB4dq@szeder.dev>
	<2d455ecf-972e-e3ce-54bc-683050c04282@gmx.de>
	<xmqqjyqpb96n.fsf@gitster.g> <ansSg4qsPwh5FcR9@pks.im>
	<xmqqpkzo39d2.fsf@gitster.g> <antWRHPHHES4a1KT@pks.im>
	<693a61b6-e762-d864-d25b-348485ec039e@gmx.de>
	<xmqqqzk2t7sm.fsf@gitster.g>
	<CAC2QwmKs-TV2f=2BhBNQGtVA4vzciN-Vkh95RkGcVKe=6zwwRQ@mail.gmail.com>
Date: Mon, 17 Aug 2026 13:58:27 -0700
Message-ID: <xmqq7blo4g7g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Montalbo <mmontalbo@gmail.com> writes:

> Pointing forward, merging today's root .c files by that measure until
> cohesion drops below the carved band proposes these groups, with no
> hand-picked list [1]:
>
>   6.9  connect.c fetch-pack.c remote-curl.c send-pack.c transport.c
>        upload-pack.c
>   6.8  diff-lib.c entry.c read-cache.c unpack-trees.c
>   6.6  commit.c log-tree.c ref-filter.c revision.c sequencer.c
>   6.3  diff.c diffcore-rename.c merge-ort.c
>   6.0  delta-islands.c pack-bitmap-write.c pack-bitmap.c

We need to be careful about situations where a source file has to
include a header file only because a definition of one thing it uses
happens to be included in an otherwise out-of-place header file, and
moving such an out-of-place definition to a different header file
may affect mechanical groupings.  But with that caveat out of the
way, it is good when mechanical groupings match intuition.

And the earliest one in the list above actually does.  They form the
"transport" group.

The other groups in the list may not be so clear-cut, but this is an
interesting thought experiment that yielded a good, concrete result.
And as I said, we do not need to wait until we fully classify the
remainder.  When a conceptually clean group is identified, just as
when we created 'builtin/', 'refs/', or 'odb/', we can carve out a
new directory for it, and we will have moved one step closer to a
better place.

One tangential question is whether we can separate bisect and
revision machinery in such a way that bisect stands on its own,
without stronger ties to the revision machinery than other users,
such as 'rev-list' and 'log'.  "git rev-list --bisect" was a
historical accident that happened only because, back when "git
bisect" was a shell script, there was no good place to put the
logic, not because it was the best place for it.

Thanks.
