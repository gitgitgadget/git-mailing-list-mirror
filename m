Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C863515F8
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735395; cv=none; b=Iwyk7jbypze4+i1NYx/Cm/NMYOS/z5Y3FgIWj3SUqr2sC5/7kFCRgdW8DGm7vj8AelrzyYwbQ4o082YcqUM3e/q96uhr7LA4oO30y2OezLmn92txcD4yQ4O1tjsfvEDqK7gz6EiD18JogWeDTtHucB6ojqhi8cHFn3WUSNbHchg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735395; c=relaxed/simple;
	bh=eqYDfrGn0u8c22PIzLLWFdsFbeJLVwQ3VVtFDD9b+x4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ouHNQg62cSuM2Y3X2m6ePkwiZopMdYRZQ2zCHXHqscnIgGEfQo6JsNXF4pY2BLQ9ffgo3iL+fXZqrNrR4AAWgLPEteGD3orXXOH6ERvW2M23Qx/eLN3f32eF6OnjPpmrN5rzPesUyxGiJ2mAOuj82CX5rEVOxZp/pOw143bLEpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U4WUt4IT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QuOV/Y5a; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U4WUt4IT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QuOV/Y5a"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 465301400141;
	Wed, 22 Jul 2026 11:49:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 22 Jul 2026 11:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784735393; x=1784821793; bh=NsC2QNlfAf
	nK7QKSXiGxHm2bs0DGJ41DRqSJ1lbfwqk=; b=U4WUt4ITjjC65FMLSCyTPBSwb4
	y3ZdEHF3xVh0654flIUk11dLqqeZNoms6CsFmm1JQcM0ai273ugmBmgNw8tBGKvI
	LDlZUiFG4TmpwED1M6P4sXRnoreic1O4XvWTE3zds+Gnfky9aIrehO4gBZN+q7QI
	5g6SzUptAtt2CLIszv2TRMmeQqK8WVuCKd9tGw1IkKc066x4BR7lkXyUKQ3+G6e5
	cIZLVevDpkQt6B6qmcLa9Hj3KkZ5ez8PmrHNtP/48+zEoAKP5LmV9z9e+yG4mDZW
	Ydhy8yHw4+hP7EVJNSgTcSjGb6G1ibGBHls+DjhHqfLgtFZq3D8mG6pdua4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784735393; x=1784821793; bh=NsC2QNlfAfnK7QKSXiGxHm2bs0DGJ41DRqS
	J1lbfwqk=; b=QuOV/Y5a32zZVRZeEw9ErJTqTuuI7JxXTUVZx2MiduDMAEtTlPM
	UoPlXeIXM6oEPxjJLe4UbS1CQBWeBR1NJnXPPKv2LYHHDfpYc1h5kX6is+Wnlfof
	7j0V3/2s9rfQk+Cn+SQDB/merIP/ZLchKQz07RKY8W5yP0jOzuH0ymCIj3BN/vnx
	dSUvMS76NydLLO3hioc3v3G/SxbTB9aCysh4IjFwEBTLrj1YqEDGT7pwfyCbZ3n/
	6+E8XVULmsCLJjxnnmfnIULxFbi+u+hvfF54T/3/6GRC/b0HJxXpOmdYD9DFhlaM
	c0kkugTs2un2hobXYSy/WjyedDj/VwQKxmg==
X-ME-Sender: <xms:oOZgaicI1bFMvAXjhjtLW9ylsMov8XUidlRYfB9Y-CIZMQih66JFUw>
    <xme:oOZgav7DbGonhFBWR-qwHjmiHjUsqmALfJ9sLtF52kXjd5ETsDXS-4bpyJYO6uZBs
    A54F315X6FP8p4rXKPzTfgSUHHfpdc-2nC8oEEajfwh5WS1dX_RXkE>
X-ME-Received: <xmr:oOZgatUBUUNAvboe_FCUdDYRFijhw8AKErYXhPmGvrIs5ChGyTpKHMy7pmG1kAYXCr-h2LszuyM6Xib4I36UR2-VgWoGoi6b4g>
X-ME-Proxy-Cause: dmFkZTGdH08ZXhQO0PY1zZfNhx4Ft5T1JoXGwkaBOSVQJ9bu+KmOjZM0jgaFFyU2vItmii
    /1gyAVzuEZ2yHArwS3U7TfbJQMomV/6Gkj5jm877y+2GbtcAmDelQi63SXbsv73RwSwEXm
    tIjkGChcqVDzuJT6vOyqa/OpLK2xfCgRLNO6gRHEYKzGGGSD4/q1fvAigLjdl1qXpDB4e8
    +RJGYeCEC3+JO1BLAsuNPb879nVdf7euDZdSyoD0m0JyeMOUTSrvsxEnM2KX1sDmUdaIDD
    VH4cNFTSUUyoiXIBjyVM/0w6Bxh4+mAbnmd9Dj/hV7wKiARjMrtb6YoncC+bdk+UgBRPlB
    knnnnyYcmzvsc5WWCWnoCtPJaCYqo811Qe9hgXEy4ax/7h2aAYdzSbY0Cqbm3AkXrcMKNi
    xpppyEAQ38kfahqqlRx8Qx67SHbSxSMITfLyN+ivRq3fNpC65oIk2P+yzT9ZzFqfof/mQp
    3CuBa1qjCzbn9GfEFgqxdZbZgI/WNMspzKFEPSjh7RrwASIP/KpP9Ua25rESwLlUHwkaa/
    gQEfKVVpO1c9Adth2r96Nwew4Q85cP11p33tm7ciwqjXRlGfmUMBWb53Oe1J+8KQpbGhVy
    FyxJU7VfLz1NvcORyW0ZaZYmX+QWqTtE+TIxxmM2hiMBwTKSErXH3CCHVMiw
X-ME-Proxy: <xmx:oOZgam6VbLsrb0S8lsHMa7Uuf1_UIasZ8fsT9p0mu_AxXhpe-xseZw>
    <xmx:oOZgagpDWuefmXcdB_bMk79EqpJVbv21S_aC1ycrH7prz54DHBnDrQ>
    <xmx:oOZgahmmEaJnHCuBS4l-PgdA9S0kffg0LL7LhmB55YPtJZpcMuO3Jg>
    <xmx:oOZgakOl0rdSLGo9ZJDIoDBtUGC62yafWVsepsNzjBoVE2oZvUpsrg>
    <xmx:oeZgankP47WgMNSvYf5m0pMlxxKAld2OTNowUe_gPewYZu7pMW9WEgnu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 11:49:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  Wolfgang Kritzinger
 <wkritzinger@atlassian.com>,  git@vger.kernel.org,  jltobler@gmail.com
Subject: Re: Performance regression in connectivity check during
 receive-pack (git 2.54)
In-Reply-To: <amCuLpT6vYzo1GF8@pks.im> (Patrick Steinhardt's message of "Wed,
	22 Jul 2026 13:49:02 +0200")
References: <CAFXJcxvpKHoVDwE5mBOd=w-A5vPdUmehqr8SHLUD7qv1qB00rA@mail.gmail.com>
	<20260721035733.GA581473@coredump.intra.peff.net>
	<xmqqtsps76f1.fsf@gitster.g> <amCuLpT6vYzo1GF8@pks.im>
Importance: high
Date: Wed, 22 Jul 2026 08:49:50 -0700
Message-ID: <xmqqh5lrrplt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The alternative to this would be to instead have logic in functions like
> `odb_write()` that checks whether we have an active transaction or not.
> If so, the write would go into the transaction directly instead of going
> into the primary source, and consequently we wouldn't even have to
> modify the list of sources at all.
>
> This shouldn't create too much of a problem, as we typically don't
> intend to even read objects that we've written into the transaction
> immediately. It would avoid that we try to read objects from the
> temporary object directory. And it would also allow us to eventually
> move all the logic to write objects into the transactions exclusively.

I suspect several of those 'transactions' are actually misspelt
'temporary directories', but I catch your drift.  That said, a
redesign like that feels more or less independent of the fix for our
immediate performance regression.

After all, didn't Peff show us a case where no odb sources were
being flipped in the middle?  Simply setting up one object store to
borrow from another via the alternates mechanism demonstrated that
checking packs across all object stores before hunting for loose
objects in any of them makes a world of difference.

> I'm currently out of office though, and will be on vacation next week.
> I'll explore this area a bit more though once I'm back in office in two
> weeks.

Understood.  Bon voyage and have fun!

