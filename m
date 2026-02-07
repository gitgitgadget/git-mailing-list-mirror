Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FBB82866
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 05:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770441557; cv=none; b=LtV1R12xEA/IhuXo6pQn8u56Vvkwds/88riIK6Fxm8frBVdRi/rPr2vHTcq+H2RHdPnLPvJVXVOd/Zfj/O+vEJbebkzUMnF4Wbe2K/BzoaaTmjZE+WhvDLklKSwTuPmYP9qTmat0Zw9CWrM5Ukv7MjEtJ3oONr8tvvr64qzocG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770441557; c=relaxed/simple;
	bh=TkOvLbd4r7nhuoH5JR38TTkbcFDXZV/4c5pR++ZNMQU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cPi9RiWgplFTED5iupJGK6bbk1ooidJytrOzTuY7YW0SJWC5hrWN8oMbmuLYPJM80VVNJq+q8UYA8tCdlwu2DPK6eaj7i9DdCrJgROvNHNAg1QxIaHV1NdVv8uUaEaAMW8xfc3Cd6B8HsfjfeVk2vgZW/8tsSWt+n4yHheAwX4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e5vkieC6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XWkwQRYY; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e5vkieC6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XWkwQRYY"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 81B0D1D000BC;
	Sat,  7 Feb 2026 00:19:15 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 07 Feb 2026 00:19:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770441555;
	 x=1770527955; bh=E2XYMleImJbsopOyIcGwK9KgSX7m5OX7M2ond0bWGqg=; b=
	e5vkieC6/fg61md7BUfqk0EfU9vPh0O7iKCr8ZThzchUu7F56r1TP8jE3K4jRMwO
	OxjKxW9sNrb1NjXFiwZROgGmDOfjFreTetqx03BqePX75Rr5K21uELwAQGRI7vmV
	PGbA7hDIpGDIefORiPRA+FmzNOkIC+Smwrll85hr/3ztwILMINRaHuelntb3hVCC
	FhdYyX+nzj1aGdc/etPH2Nu6tTq3g7H2IsIyUA+WZ2gstNwPXeE8mLKxVBrolPqg
	MoxhCf0H//5jdzyAjoaABtdc5kKSdazM9NqgW2TimWHlDuZ9p5llHp7s/DYUI1E6
	E14rDoSRkfDBtI+NgA/bTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770441555; x=
	1770527955; bh=E2XYMleImJbsopOyIcGwK9KgSX7m5OX7M2ond0bWGqg=; b=X
	WkwQRYYvZvEtbo+YOiWfNSVrVhXr1n6RQ6aeVVp3hpTaeaAASOpHblyHb+lxNrJl
	9x30jyBm6QnDyzYGporjKf8bZ8Jepd/dCkB724Go5ToRQIUPlQOX1TlDY5lpGftq
	UFz6namEwOVrCPPp2gN8Y47SSUDKaBE2KQwSNT6X3AB/Nxf+pgYMzgIJenPPV+yT
	kFrK1z44jg0zMbFA0TQg/7hc1+VjzcRK42qQ+9KM89gWZTJ+6AIiB6aSfq29SHyK
	qimRKFRbyd8YC12Nb2xN2GLOXgoRwlAu5MgqHM9lTX381UNiqaiEFRwtQxulj7g3
	1kV35mUR3EV9vzQof0NNQ==
X-ME-Sender: <xms:U8uGaR3m5VBWojc5CQdzASAMvlbHDEI3uQ-GmQ-OSas0PsqbRBMdFw>
    <xme:U8uGabxJzj6QtJLCenEQfsGeh1AFtVe2pOnjHyr9ARySEjixnTmAlYti4EgGevnu5
    c5CvHQ_FF2UuLlP13eqvamnF0v2KNnNBCQhac-1nGaA4s8aXvKrb7A>
X-ME-Received: <xmr:U8uGabunJ14T3YX-HCsA35C4PysVkpvKHPzkzwhzgFZh5T2LSD6ZEGw9PV-VPfyKZuCQ3BtttUCkVROBs6daLno7Z8DfePj3Qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledtudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvjeehudehgeelheefieevtdegleefvdfftdevtdduffeikeeiieej
    vdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsh
    grmhhopghpohhgrggtnhhikhesthdqvddrnhgvthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhs
    tghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:U8uGaVzc5WW2jWB23KCk3pcrqpxL2fGBsQ93PHugrDlHoTEkQgIRfw>
    <xmx:U8uGaWBKHzoYwRUO6zAkVRbqEgdGqnuwvPZARVfFYFvArxy94yfKEw>
    <xmx:U8uGabcJ1TuVtMJOkl94FzKY9dFvewAtkgjj8zhAF-8Smdgyu79d3g>
    <xmx:U8uGaYkDLJUxrMrrbKJQC5xsDh08EtIxWn1pi8xkneJcY4XYH3iikQ>
    <xmx:U8uGaWznnR0PjZuhTiG2o_nN5w4rvTxHX2NGT4jtk48NHbKQF6qTKMw2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Feb 2026 00:19:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Samo =?utf-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
Cc: git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>,
  Taylor Blau <me@ttaylorr.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] shallow: set borders which are all reachable after
 clone shallow since
In-Reply-To: <a60fc6aed8ab7345219118f933ac0eb61140334f.camel@t-2.net> ("Samo
	=?utf-8?Q?Poga=C4=8Dnik=22's?= message of "Sat, 07 Feb 2026 06:06:01
 +0100")
References: <pull.2107.git.git.1763807914242.gitgitgadget@gmail.com>
	<pull.2107.v2.git.git.1763926552033.gitgitgadget@gmail.com>
	<xmqqh5ujuekq.fsf@gitster.g> <xmqqfr80xanx.fsf@gitster.g>
	<3253600a3c96144744d3371a7ec2a66cb87d4b60.camel@t-2.net>
	<a60fc6aed8ab7345219118f933ac0eb61140334f.camel@t-2.net>
Date: Fri, 06 Feb 2026 21:19:13 -0800
Message-ID: <xmqqy0l5b06m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Samo Pogačnik <samo_pogacnik@t-2.net> writes:

> On Wed, 2026-01-28 at 05:23 +0100, Samo Pogačnik wrote:
>> On Tue, 2026-01-20 at 12:59 -0800, Junio C Hamano wrote:
>> ...
>> > After this exchange, the topic has been dormant for almost full two
>> > months.  As I do not deal with shallow clones myself, even though I
>> > understand that some folks rely on it working, I'd really prefer to
>> > see somebody who are familiar with the underlying logic to review
>> > this patch if we were to move forward with it.
>> > 
>> 
>> I’m currently rewriting the patch and the commit message trying to
>> address the boundary/border dilemma. I hope to be able to send a new
>> version by the end of this week.
>
> I posted a new version of patch '[PATCH v3] shallow: ensure all boundary commits
> are reachable with --shallow-since' on 31st of January. I hope you've seen it.
>
> thanks, Samo

For those of you on the original CC: list taken from v2 review
thread, who may be more qualified to review this topic than I am,
the v3 is found at:

  https://lore.kernel.org/git/pull.2107.v3.git.git.1769876930544.gitgitgadget@gmail.com/

Thanks.
