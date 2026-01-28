Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9413D7A13A
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769591251; cv=none; b=S+h4fnqKerf5p23o4Yu+nH/bQacs1SFcrMnq8P3cgoXUoNBkJRmRaA1bFRhW+p5FnTCuhmiJh/4Npt7kGxukh4IBW+psKQKGsEIn1m3vVSccWd65GSC+Xj/rGbtCzWlevm56Qoc/KoTzNAzKGmR9SMdxj4Zx8hsDeqbPwm83Gf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769591251; c=relaxed/simple;
	bh=2nsmqUPn4gAOcrpoHMVVBvOeNiGtrt3R+czNuYuKjos=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bj94XH45LXGCtP7uuAAelpaRUvN1sc/ZIqqPUjn2uafXBPGtE5fdKLeqYOuoPnL9RVa2rTM75kzrG+bkVni65RjouYPuui5JDB/+uAwjnO8eJ1bqnwuTqc2chVUZUH3kihdP93lSgfPDUeevtMQv9SPVDDDwYRVkbO6Umti5uIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nyMrQapq; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nyMrQapq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1769591237; x=1769850437;
	bh=1AlPbSZe4Bpo4jTSBIpsjou3w30/qmQIOvBRrza65Ew=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nyMrQapqwrFGj6t2pFPvuN5xJOt/Gs9kBDiF5HuqBekFb10JY9PZC97BdWJX3e6to
	 UhwQU1MWJzqLhlYeFhCutTvy5uY5uQ5Hs35FzVpJ10Xt/dkATShS+8uqH1VkQPzkxI
	 k63I2kUNdpo3SnPrpKgC5pEYbHK1lXS3G0j8M6wpUunhMDnpD0/SsAsIIWi15OJvWG
	 ptLaxmKzLS+4fO43+MFh2XEu+4VwGz5o2b6eAKPBQDcWoS46ElF54wWaZVnrvxoLNm
	 T9wOEDN+lOOo7Uw5xp3iO985ILHfd4FQMO59NKEJMSGkCwc/ZR3p12EDbjttiY5RQi
	 rNTEhdi/u0hAw==
Date: Wed, 28 Jan 2026 09:07:11 +0000
To: Junio C Hamano <gitster@pobox.com>
From: GitHub Chris Idema <github_chris_idema@proton.me>
Cc: Chris Idema via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Michael Lutz <michi@icosahedron.de>, Pat Thoyts <patthoyts@users.sourceforge.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH/RFC v2 2/2] diff.tcl: call "apply_tab_size 1" to fix alignment instead of spaces.
Message-ID: <IY45fwv_UnBCPcj48xZ_Z6wduiXBWyIY71uw9lUY_DjFy7plkb1c980ZdCCMzx1S76QW9NgaXzbpejuVZ1tI4CicRalwL0v3VIiwx20g9Q8=@proton.me>
In-Reply-To: <xmqqfr7qeixq.fsf@gitster.g>
References: <pull.2179.git.git.1769424301394.gitgitgadget@gmail.com> <pull.2179.v2.git.git.1769545996.gitgitgadget@gmail.com> <e11aa6d811dcf868fd0f91b74cdceb8bc3f4229e.1769545996.git.gitgitgadget@gmail.com> <xmqqsebqem1n.fsf@gitster.g> <xmqqfr7qeixq.fsf@gitster.g>
Feedback-ID: 177675452:user:proton
X-Pm-Message-ID: 2890092ffd3f03eb561b148486c79850b52de017
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Why does this series first add proc expand_tabs, only to remove its
use in this second step?  Shouldn't these two patches be squashed
into one, and explain why we want to use "apply_tab_size 1" here?

Because I received feedback on the first commit and realized the=20
second solution is better. I didn't know you could squash the patches
ones the first one was reviewed.=20
I generally don't like rewriting history, but I will be squashing the=20
commits.
For some reason Johannes Sixt disappeared from the mailing list.=20
I've never used such a clunky interface before.=20
I guess linux users like self-flagellation.

> It is clear that "apply_tab_size 0" is designed for a single-parent
diff, while "apply_tab_size 1" is designed for two parents diff. If
this new series to make sense, I think it should argue why that
setting that users are already familiar with for the past 14 years
is wrong, and "apply_tab_size 1" is more appropriate for a single
parent diff (and presumably "apply_tab_size 2" is better for two
aprent diff), I think.

The bug has been there for 14 years I guess. In gitk it works as=20
expected.In git diff it works as expected when setting up the pager.
In git-gui it doesn't. The alignment is inconsistent with gitk.
For code review it's horrible.
Here is a link to 2 images that show the before and after:
https://github.com/git/git/pull/2179#issuecomment-3799576864

-- Chris
