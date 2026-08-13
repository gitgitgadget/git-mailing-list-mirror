Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162151AAE17
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786653094; cv=none; b=OHAMV4LpYHHiAhecZ2AvWiraWeUL+2coAf2Xq8XUpRvvJaBzBUXRRq8x19ypWP14073frOaUVeO9u1Fq3+odEILO4Tv/hHHc1ojXzs3h/zpql8Gt3xp1BKPHMiUORonRSDPtmzAIZZCFMheYHSx9QewoN+zdy7nfr2hAeoutDhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786653094; c=relaxed/simple;
	bh=+gwR+Z2eZYc273EXvvUQN62oj8PdyXFPr/uwb20LrTY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G44qvUaP12Lauo+KE+3XXrM4F0vsSymdkeoHi1BEZ+bbCvIDju1lvNSIl/yWrRWtib6Fy4I1TAxQfROIM9goofxzav3wRrogARA46Se4CK2m93hpFlL/jf0s0YVgO9cvjMY1N/ml0NqDiywod4IYqKc2mrkZrQuPjdnzlDyxeFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EWDlH5J0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iywVS8zr; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EWDlH5J0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iywVS8zr"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 2BCE4EC01C3;
	Thu, 13 Aug 2026 16:31:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 13 Aug 2026 16:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786653092; x=1786739492; bh=pE23AB1aLl
	Kty4WaQUqIM4mf/Igsxxnrvw25LYBFDLI=; b=EWDlH5J0a8gmH0SBdR+FkNoGMu
	PtpkhQ/kJ7waHSlb5BNi2y8DePhr6xP7wQYIt3BDXlOxQ3tfcp/gtRh6PYL8/+QZ
	Y1SuOdP4gpvN3jmsEWw+nm6BbreKkARfi8D+RYdJ0ClcjKtnuhbgEIDOp6xeQV0z
	qy/NSEFzGyzKdYQgekGebhWO/M2dH8Kz7APOOTHBJkBUV7D62Zec0iXGk0UUIXgM
	/lk6dnHH18LFz1C0Q+BhairACT2ecTCP6VLX6xO64TZcYKzXr5ka5sBsyv9BCjgN
	917sbvQ9BsM66GAuoisoei/45E/LNCnF7Hpbs+BG7go1U7SpaaXBLoWeh3XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786653092; x=1786739492; bh=pE23AB1aLlKty4WaQUqIM4mf/Igsxxnrvw2
	5LYBFDLI=; b=iywVS8zrH94nzhvwX/Gf+3BpG/EOih3TuzAJ84+3MrnZRf2+KAn
	7v3Uz6gXHu53svWwlT6XCKh+vLmSAuMxFjavEH5iVd4npyp6OrjWxFN4LxOCCcXv
	6o/cmKWXrqH5wq/cIldD4yf9zhyaTDJHW7E87xkOCWuanJBmeNg6+oStOLPZWff7
	KUTrMNPBh4LskScgVWXrD/4vn5H7BPQaxjJnsT1RM2GnUYmHpp36gVuRNk2wRMFx
	36GvFzWQZrDR7sD0pmpz0oxT+wgJnhr3Y1/B+qnX2XHQYCnhXd3Q1tKwvLFicpvT
	mJEPldoa/lZB4Uo+t9iwbp5sDLC7cAF1I/g==
X-ME-Sender: <xms:oyl-apDMsWxyrD3oXRecs9bVXQv2qsCm1Vm-W1TC8jZLuLt46eOXNQ>
    <xme:oyl-aml0pgi7eScYJeYItmk5isH46JPwOBSmbcqAiSrM09jE5Y7GPvq90XSX9Bxiw
    8_uBEbp1jY0J-pRPEyGxSgYhtq0eUzjOV1-lDi23XLXy-9olrXcYg>
X-ME-Received: <xmr:oyl-aqykzi0QJfo8dmmRtU18BbKVsWj_tl92-q5XWYldJWAUrZhNmsP_2t4WqCoukp3M9iehq-edn5wOl0LgB7xD2vzxb-S8Zg>
X-ME-Proxy-Cause: dmFkZTGLh1NXvo4vl8Oqm5+fuAkxSNV4FBniV5roXQoRwcpCcd8FtYNyGJFT8yFfECG/Wi
    MyT7EtdUrHOHWfquGKntQroM03MJARNzR8ySgx5MUZ+Cwqjx0+YcVMOx4HPLkKlTIG2VrA
    W9G3BlEKTE2sTjsx4stDMuNyVxs1fmzFh9VorsnUjxVlZflPk4h3SVc/aRcOxknSG3sgst
    nd/MZ3ANa9mA7TUbjH+IjpqVKPfV6GLaeFmOwBjP0wyNgvarfLts4/HuPGgfZ/8zFzJ36J
    06O8EAWTV+JfrTm1wPcLbfmIhenucMcptGZplUp3aTWN8FQcutjPeoqQzZapJ3DagLHtSS
    QOoOfAPu9HYg/pOqDt3slPho9d80MbfQqdPEOQcXLEDbwXCBA8YR/pvf4D3v+iw/1qHYfO
    /tYFniCGY/uP2POdh+vf1ipCZops8ryTRJqVzMrVmsMUHWa3wGSSu5iLs6gioytpGv/m2R
    +5Lsf6XKcSBM8SXiaTogqApCvvOZqmmmgulPeDf/TDMyYPVM7mmNpspf8x1idl533bFnK/
    EtrZ+ECgYP85/0qRmprPx25FNSY2esWyeHc6PSZ2N80amXoJe0Eh3Bvck30oTOjrld9jOc
    0AnWa2dAovR3Br1gfmz1fDa6WKfASIDOhIOQVsO9A9Mo9UjLQczMGlh1u1tg
X-ME-Proxy: <xmx:oyl-agTDZ5RXQBcJhw0EIkYVSJIIrZOLQfhhbqWaK8uUaXQxXvNdSg>
    <xmx:oyl-ai8vUtFodTf2-Zg62G5unCypeCITkzJHfZduDeCQeJYh0Csm7Q>
    <xmx:oyl-autObhhYXySrf1tsJHh_zXR434RijKC38YjAVRj1uxBZk5xqMw>
    <xmx:oyl-aqMMRo-2eYTX1jgDtLXdLmHq4a9UQ_cDR-TOq9Tz3V1gFUYtcQ>
    <xmx:pCl-atE0hsDC33eEPHbK1Rm8RmO9Fe_lIqlKd_qyTHUcLiYCeMkPJO1->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 16:31:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Karthik
 Nayak <karthik.188@gmail.com>,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v2 0/5] Introduce 'uploadpack.lazyFetchTrusted'
In-Reply-To: <20260813154748.2378747-1-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 13 Aug 2026 17:47:43 +0200")
References: <20260807135511.1818458-1-christian.couder@gmail.com>
	<20260813154748.2378747-1-christian.couder@gmail.com>
Date: Thu, 13 Aug 2026 13:31:30 -0700
Message-ID: <xmqqy0e9rcd9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Recently the "promisor-remote" capability was added to protocol v2,
> allowing servers and clients to agree on the promisor remotes they can
> safely use.

I do not know what you did, but it seems that an attempt to futz
with the thread structure i.e.,

    This version is also sent as a separate 'v2' iteration in reply to v1,
    instead of being threaded onto the previous "Introduce a
    'fromAccepted' option to GIT_NO_LAZY_FETCH" series, and it now
    contains a 'base-commit' trailer, so that 'b4' and other tools can
    find the right base and the right patches.

made the patches totally unusable.

This [v2 0/5] has

    Message-ID: <20260813154748.2378747-1-christian.couder@gmail.com>
    In-reply-to: <20260807135511.1818458-1-christian.couder@gmail.com>

which is *correct*.  It is a reply to [0/5] of the original thread.
However, [v2 1/5] says:

    Message-ID: <20260813154748.2378747-2-christian.couder@gmail.com>
    In-reply-to: <20260807135511.1818458-1-christian.couder@gmail.com>

which is quite wrong.  [v2 1/5] should be a reply to the cover
letter of the v2 iteration.  [v2 2/5], [v2 3/5], ... should also be
replies to the cover letter of the v2 iteration.

I have never seen either plain vanilla send-email or GitGitGadget
produce misthreaded series like this one.  Do you have some custom
settings to send things out?

Here is _one_ way to create a thread of the right shape:

 1. Develop this 5-patch series.

 2. Run

    $ git format-patch -v2 --cover-letter -5

    to grab 0000-cover-letter.patch to 0005-builtin-upload-...patch
    files.  You may also want to pass --range-diff option.

 3. Edit 0000-cover-letter.patch to your satisfaction.  Do not futz
    with In-Reply-To or References or Message-Id yourself there;
    the tool will do this part better than manual editing.

 4. Run

    $ git send-email --no-chain-reply-to \
      --in-reply-to='<20260807135511.1818458-1-christian.couder@gmail.com>' \
      000[0-5]-*.patch

    This will make the initial message (which is the cover letter of
    this iteration) a reply to the named message (which is the cover
    letter of the v1 iteration), and then the remainder replies to
    the initial message, which is what we want to see.

There surely are other right ways to do so.  As long as the end
result would look like

    * vN (1 < N) cover letter is a reply to v1 cover letter
    * vN patch M (0 < M) is a reply to vN cover letter

things will flow more smoothly.

HTH.
