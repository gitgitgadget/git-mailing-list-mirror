Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7534C1C01
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 05:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783832491; cv=none; b=u1RsP7MSThvc3JWIepCx9h91w81DyIHCzpZ+FRvhjg9+Tpe+A6eWhuUsRJ2McyW/YcRKLfeTIYBO3z+D+Nyatn7abgtOfN5sKwG6u5qTv9rcxx1qtfVQiOMhlxDxxfLGo4DDPGQ0ye1rjXNToS/f8LUZs8lphF7xBNQOHl5Rnvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783832491; c=relaxed/simple;
	bh=0BkfqGAJvHYqH4K1v9oQ6A7e4HHYTaHjzBqvqZHDdC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hr2Nyw/0X+IC6b8E6fyL352KuL4XMeGOIPVqSKdmTdLaPipPOAvLTR8lH0If1gQKG9qBGnTDxWmvjiitkRa+rQS3ZAYb1NJ5SX1H5HFMTy+f22VDF7TFErjmJf15lAL7itJM0Z85Jb1odYbhNFJu60h/ACNfvHWKo38VISqQDiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y4pJTz+X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N9XP2LIt; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y4pJTz+X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N9XP2LIt"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9F667EC00AA;
	Sun, 12 Jul 2026 01:01:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sun, 12 Jul 2026 01:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783832488; x=1783918888; bh=5OhpSIrADs
	1kMmVWxCDy1kZeNIYzoxXz+zQBGEHpSos=; b=Y4pJTz+Xx0612W5vfr7SGxo1Co
	1GwsvrEmAMx+95AezuP9ZBAwzMvN5UahI4UGI0Wjp1UX5YKEqxbAdrD64ENVQCdG
	PpGgO0h05CjWA5C474zJSkRHAbSRJUaRB34fBXZZn12szzfjz2mr3bM1vMrT4sVC
	jZNy1uGBic0GA1ZVespOVcumkQd9kFJN/DxYj43yigWEZfbUA12/HlL+6ZYk5q/h
	AAJZWLi43s4dJjrdElZf6GF0VOOIY7t6KJgRJckDwydY8A94zaT8ZrqZJCQW75B3
	08Oidsd+wLZWKjYcPjKiIiVILevkCER5dppyi9V+9Bmo86A6Z/fnn8LBiPJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783832488; x=1783918888; bh=5OhpSIrADs1kMmVWxCDy1kZeNIYzoxXz+zQ
	BGEHpSos=; b=N9XP2LItMYO+UXp9C4x5HoQiPgvi8HxR/pDpouMicNlrpTqnj3M
	DeeKr0Z5QC/n2LkDFreOXT9mVSkH/w/DsNNYuixv5XPacJpSMY4r7C7S+oNjzmk5
	OdcA8b9YKxlsd6z+rw3ss1VvDxMNSia2uLSV63kzTxBDsYJude5p/Onemthyv95j
	HHQfzFfqQCvSzHVEks1Jdb18rPtGoKIQQz/BG/ZcNEN9R9dG//8jek3Vns1MskLx
	SCORF18y2/jD/WkOTHHGliVZRop2/WSWyaojPTmBPVHaUT4fkYr+RIvMw6xOwx/C
	3UjxIHX3dfyWB6KWn5nEJVYQg+F0Nayrkpw==
X-ME-Sender: <xms:qB9TaimhzS8_mu_oBKBT4l9ePzSldPPxiUzRrW5xHEkmHZYOrAQ9Xw>
    <xme:qB9TajLkER2GkR08cNk-9kkHxsl5iU8eQvJTOZzh85VaJCillJRIhZ-owy3s74TGt
    Se5Fj4y0hgCnCgAdFjLaE_zjiwL7LrHGlSb32QmpoEPm11xQI7B6g>
X-ME-Received: <xmr:qB9Tan7kMJTRCrSFBfH3P_vEn_XBm4Wp8CHhWm0q8BV7I_zy25GY3OfQjhDWmoi5_Ho1lV0CHLI4WImP2noiPs8557pUo9sCJU-VkDQ>
X-ME-Proxy-Cause: dmFkZTFSQkB3rmF0s72vy8fKnndQLOFSMJCgrp6AzwuGMCT0ZMANU+n/Pdr6kSsviU9oqN
    KynTOqCT9Z+KNwId7u+zv0ERfSmyr1jkxoN6n3Rj5gpP29orYLG2wsQT+4wy5jhvNOrqT1
    0r+Dc/He03wpawR4U+4CLTBG3lTfrGZvGFf3WhZ/DGdnyWafoH8W+S6y03xiAFtnVncyQF
    ioK8GAz5yAAifA+A0fsdcxXi14xPj0TABTBaWwGJOm8AeVZqTM/rBj0m97gmQloyF9et2I
    dWtUikB+yNT3oxd0Pu0xneDz5h/5Xd2AA/mv8jFNsjptSwTYCK3wIVQbabXid0+bqFK+MW
    +ykW73ZmJX0K7f3WajLr89IUt1Bt929jygi5iFOvA48jC1saXDkq1dw9edjJNvl89UA3SX
    SqhwUUE960tP5gu3LNwc2w6t+j2kBuE6NO/JUUwO5puEJpZmbDx2dR3POW1pStre8RI5rk
    I5g5dnm0/IbWGrN0g9yzYarnlakyahiKSmCKDDokKgpUWtDmXW1N6Ekz/Vk3TrAKTakin9
    00UlBzaZif8lJTvvX2iwdcOPuYcHf2As60oQicBTUJuMc5PkLiuVwPNIjM6Yab4wfKZosF
    o6+sj1hTLwZ1qEgq56YxV/ZriklTCqjEWP4QtKTUv7dysPgk2vAA0f8eb2/Q
X-ME-Proxy: <xmx:qB9Tan2ccn2IJHxbDmM0Re7yjTtZ72bqqjaNUJNisWy5hHum80WPnw>
    <xmx:qB9TatdlqRl0NEXO5DeGGcfIgeUb0CU_118enDNa2Mjt8fRQCUZgcg>
    <xmx:qB9TateKoXF4rV_q_B5b5MZSrip75bNRTYWXBwsdjqMv0D0xN6gM0g>
    <xmx:qB9Taowj_d8ntekBgEReW-meXmUZkY2ABzIvbmJ8xET5ljUyDKtnFA>
    <xmx:qB9Tavusq3W4uMWqPs4OYSxl_qj3sqt6SKLZd1tQtTY0J4yEcuff5xBH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jul 2026 01:01:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Elijah
 Newren <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3] sequencer: honor --empty when a fixup!/squash!
 empties its target
In-Reply-To: <20260711-fz-autosquash-empty-v3-1-d227b63eb511@gmail.com> (Farid
	Zakaria's message of "Sat, 11 Jul 2026 17:38:26 -0700")
References: <20260711-fz-autosquash-empty-v3-1-d227b63eb511@gmail.com>
Date: Sat, 11 Jul 2026 22:01:26 -0700
Message-ID: <xmqqh5m494yh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Farid Zakaria <farid.m.zakaria@gmail.com> writes:

> When "git rebase --autosquash" melds a "fixup!" or "squash!" commit into
> its target, the result can be a commit that no longer changes anything
> relative to its parent, for example when the melded change reverts the
> target.  Rather than dropping or keeping this empty commit, the rebase
> stops with
>
> 	You asked to amend the most recent commit, but doing so would
> 	make it empty. ...
>
> and the "--empty" option has no effect on it.  This makes backing a
> change out of a series awkward: reverting a commit as a "fixup!" and
> running "git rebase --autosquash --empty=drop" ought to remove both the
> commit and its revert, but it halts instead.
> ...
> Changes in v3:
>  * Switch the new tests' assertions from grep to test_grep for better
>    diagnostics (per review).
>  * Link to v2: https://lore.kernel.org/r/20260710-fz-autosquash-empty-v2-1-fa1e277e05f8@gmail.com

I see you are already working well with Phillip, which is great.

This topic, when merged to 'seen', seems to have quite a lot of
overlaps with his pw/rebase-drop-notes-with-commit topic.  We are
expecting the topic to be rerolled, and I was under the impression
that the remaining issues in that topic were all minor (Phillip,
correct me if I am wrong) and hopefully we will see it in 'next'
not in so distant future.

So it might make sense for you to coordinate with Phillip, and wait
for his topic to be merged to 'next'.  After that happens, you would
prepare a merge commit of the other branch into f85a7e6620 (Start
Git 2.56 cycle, 2026-07-06) or some other stable point, and rebuild
this patch on top of it.  That way, it will be much less likely that
I'd make stupid and unnecessary mismerges when attempting to
integrate this topic into my tree.

Thanks.
