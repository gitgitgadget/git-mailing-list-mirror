Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7993EFD24
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424371; cv=none; b=jRCyZmcDos/d6gMFi0/Uxh2vIGkP39dn8jSCIdn6qDBAZgbSH25H5Dpminj7QWxbnycEmwH8GUDyM6e+1JvDmviDa8oES+Yo7hlw4dUgGJ7yG9ldcKc9rfQ4JYEGjBqTljrG3yCKiVZ0uf4q6lEBTFOl679GxwzwZDQjnCMsLDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424371; c=relaxed/simple;
	bh=G5hMgRnKiJbDA2/vpxrFJAOhJ2GnPfLHB67IEGS4r9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIAt/u9Am7FlV6259qrN7p1SbjH+f4lPM0JRgv68q4BWYvOPVlODlH6DJw0BiF0GfcRTscZfNDLG3dhHdVzVIpZgEsuMaTr6phAa1HcVv5oFDdzQbEK3lTNyPhcaMdx6n4KiUmySM5MWuqKTQ6xrWiF0D59TQp2qoF/YlnzheQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZZbkuzwW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IDIPPg3M; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZZbkuzwW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IDIPPg3M"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B674F1D000AF;
	Thu,  3 Sep 2026 04:32:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 03 Sep 2026 04:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788424368; x=1788510768; bh=V6wQMAJRxS
	5W30tpnYNmSMlTkZS6SYc12c9IkHx1/cc=; b=ZZbkuzwWR+o20ht/ZaequG9Api
	aqXbu3WIYph19ngnatsqUgjLLHnV43mZLQkFl8YZoYtgNQQXr16X6ZODk0oji54j
	4E1oTQFtRhbsJMprc+mhaJkI/8tIUpcUUGVFwgc0uUIi0DcyrHwL2ipANVAffm0K
	z0R0PtrjDoENSG4/KBFnRPzgbHeeYgwXdxZCTCaDDuWexEyuVAJJMoxOQiXhZO9Z
	2LLLOBq0QiLwW63I0qsUTPCRMB/rQAs7qP9P8nqDaJEBnDWQr0w/9bkvpItzCxkK
	gERuUkwCheYpJvuJoLLoMzJd8o+tLE8sUGq5010lpLkNE3xKqOjVnlHVzK0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788424368; x=1788510768; bh=V6wQMAJRxS5W30tpnYNmSMlTkZS6SYc12c9
	IkHx1/cc=; b=IDIPPg3MrR301qkE48RA61IkpSlZ4dhacn+d5vj47gTvt0O/4GQ
	jTzRD3TwspcAOvcwz1ugQrWRQGVi5QgXUFy4oAdSkG3Uht4uabCpggHDmKCs3t2B
	paarQLuwJ/8PF56grFOx+Zufncd7ixcbS1p2iKiohCbJWFy90Uq9yGd2XhqqQ6VZ
	KIHED4RmIXbaW3IA4oAohSdIQsCJfa/WPvpdzqKzJQGw3GnzE2V+F8ZVvfwCIh0j
	ta4sInApcivV037jTanIjpsbx+JHnYV2CdJSo2fn3t1QmnxvqfYQT14Tl1EA6byR
	c+ShiSheJIIGSG155QTaoRFon0yuiFFVfEg==
X-ME-Sender: <xms:rzCZag9NvVRhYR1zl7ySVFD5Sa545Eae6MaHmlsPEulp48XhHmPr8w>
    <xme:rzCZaqNzSrlBOxnEMjQ9CsYuVd0IQLOL9ANfgjeHQ14kb5Jb27TADPLubKqacgNJG
    9rtcoSvNm-Sy4SY5S6_-9o6d6Oz_hze5uwyovz_srPQFmOwsoF-IVk>
X-ME-Received: <xmr:rzCZamFr8fFrGhfwbhX_oOSvVhdJIax9C3D25SjoUCmlUFeaDuWqfQ>
X-ME-Proxy-Cause: dmFkZTF5OgDb6pBelEjiMg8/lhs2rPqHr7s6uoP6PE/WqoF7W0pXJ4CFrxirxm5bbiL5N8
    sZMD7bVulx06qvG0TI521aCuEBfEONTBQ3DFLf1zg3GQVY8/HfruN6gTxcokT3Z3E5/Cr+
    7NbyFjIfgmeY6QvUoM2p9goWWsv8oNvS4Sz6iBjeRqio5cakkqQ2QpzUFg6vMlWhaCl5mV
    b2HsMDC6V5vKq5U5JFDx+ji6ZBeJjcFdkF9CvEt6i/6k/b3qYxx4gtD5oAV4cIgOohpJ8l
    Bsl7iJU6VSwATsPvAXLr8Dodj4Ro6+YMb+pZaW9scdG/hy75wvUTT13dWpx2eA0b4ZfHO8
    vmmWtdgpQNEFZrvOPDi4ZLliOqvXQLa6oDUiaTb+1X+fJaR/8h6YKl6V/WSrwfxyTu9lqU
    AvXgR9/Mq1iqYzeKyxdb/kQzCNI+2ety91rhgczSidZqjL0eg7iVje6QjFhWf0Z/Y1rd43
    fuFy30tVqK7PluT7s+67Kc70FcDDW/fE4yeacrACKCQdN2vzoBt6vCcvJlbJ3uZjtLey3R
    jSw/cmpYAYpkdSn3hHLcjDLe96vxzElbzrHV/x7t93JqF8XnGG1zAEs/KeMllpC89V1m1y
    N5qYcXEW4xaKD2eWnoQCKa7FhK0RAjkYPx+EqNjZmc4PrMByQLOWqHh9j4Nw
X-ME-Proxy: <xmx:rzCZagQ4rAkvT5FTAOQrJPfST_jGxg_ownZO4lfWke3P2fD2ZuNqgg>
    <xmx:rzCZaru5kEqbiLm_JGKG2Had2qB-wUQBTPsdjG5Ma4Q0bzffajdM5A>
    <xmx:rzCZagJYUiBAn0W3WRYqLc7vcOnJ7mHTlfTTAuVE7570KxXGiMx5BQ>
    <xmx:rzCZaomfvOQN8ZTwULTIshD96D-hYEtk2QTYK_bGfSRHzulCf5Ikqw>
    <xmx:sDCZav2pnciQGnyl67Yxa8B_WdXEkUMWL4LLauWbAq-mdGALQMFrGGUw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 04:32:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e6f3076a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Sep 2026 08:32:48 +0000 (UTC)
Date: Thu, 3 Sep 2026 10:32:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Thomas Bachem <mail@thomasbachem.com>
Cc: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rerere: keep a background gc from killing a rebase
Message-ID: <apkwpKTGaMwTf0Hz@pks.im>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
 <apkkVAYOqjfAsp9-@pks.im>
 <CAA0xjtp+Og_k7BYZfwX-LRW_8TAiCyp846+Mhk+hERM_GmRYkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA0xjtp+Og_k7BYZfwX-LRW_8TAiCyp846+Mhk+hERM_GmRYkA@mail.gmail.com>

On Thu, Sep 03, 2026 at 10:11:05AM +0200, Thomas Bachem wrote:
> Hi Patrick,
> 
> On Thu, Sep 03, 2026 at 09:40:04AM +0200, Patrick Steinhardt wrote:
> > I think this hints that we should tweak the default value of
> > "maintenance.rerere-gc.auto". The way it's currently written we indeed
> > are quite aggressive with spawning `git rerere gc`, and I agree that we
> > should tweak it. And in the best case we'd not only respect whether we
> > have a specific number of entries, but we should also respect whether
> > those would be garbage collected in the first place.
> >
> > I'll send a patch series later today to do this.
> 
> Thanks. Checking whether anything would actually be pruned sounds
> right to me. It takes the frequency away, not the race, so I'd still
> do the sequencer part Phillip asked for.

Yes. Ideally, I'd think that we should both introduce the grace period
for locking the file and adapting the heuristic used by the maintenance
strategy. Whether we should completely disable auto-maintenance when in
the sequencer... I dunno. In any case, that feels like another separate
topic that should probably be discussed in its own series.

> > Having a locking timeout is sensible anyway, I think. It does not only
> > solve races with a concurrent maintenance run, but also with concurrent
> > writers.
> 
> Phillip found the wait unfortunate and I offered to drop it. You would
> keep it. I think the two fit together: wait up to rerere.lockTimeout,
> then warn and return -1 instead of dying, so the caller goes on
> without rerere this once. The gc passes 0 and does not wait. That
> takes the die out, which is what broke the rebase. The wait stays,
> bounded to a second, but skipping rerere is not free either: it can
> mean resolving a conflict again that rerere had already recorded, and
> a second is cheap next to that. With the sequencer no longer spawning
> the gc and your heuristic change, it should rarely come to either.
> Phillip, would that work for you?

I think that having the wait is a sensible thing to do, as the race was
a preexisting one that was only uncovered by the change to the default
maintenance strategy. It can also happen with two concurrent processes
that both happen to write rerere entries. You wouldn't normally see the
wait anyway, so in the happy path nobody will really care. And in the
cases where you would see it the user is probably more happy to wait a
bit than having Git die (or just not write a rerere entry at all).

Patrick
