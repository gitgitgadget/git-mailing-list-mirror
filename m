Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFAF343887
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718433; cv=none; b=aL9k/KroKM4M5T6EJLXm84Ck4leuEDgb6MSxrs2ainCUOmqG8TbS4nNyeLdYPtguG4BBdG6khpJWQHRBFJvvWfXIN94QrOR/RoArfvg4ORAGqN/I+jwJBuop+3Ho7lTym1LS0D+OXmzeIC8jPsPIsWHQbc40FcxFkpa6dcYgT6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718433; c=relaxed/simple;
	bh=UBBo4n3i6MIN0wi9zgPLuCG/pZokXSvuMQ+iq55EZqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKqcFMa1H9eiiHlwxNvSNLk1a85rH+WUXWorsO+tGF+a9e1OhZLzqXDeWgKZPm1Km+7aGO8cqNnl69TRXLgqkQ9/HPSp/0sDoDSlwp5qKKcNe4R2ndJENoJ6cI1eQKUJx0nolEfJpTszAidahMuv1sSCy8AcAwgt3FHoeRA16sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KZ9KFfc6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XMoBKDBy; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KZ9KFfc6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XMoBKDBy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D46B77A007C;
	Mon, 29 Jun 2026 03:33:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 29 Jun 2026 03:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782718425;
	 x=1782804825; bh=ovJVYLW+SahIYApDBGbowO1TW0+p44Hy8uL+UO1PDeg=; b=
	KZ9KFfc6WA3vp2trSSepKevaBzwPeH6Ox3DfVA/dLrwjZvlJJ0JgWtiUtzFxpcyP
	byGr53dOPqrYV58DgXWO3xSO3y4YTjVvV2RNJOpEAekFZAglgdCCssnjtmHbwBnu
	l9LhF7s8B5txXdlN7R3xoYoC2yC/vAFJe+lSGZEXOfm/xF+WfZCYiOK8EftN4XeE
	JZQakrY7YeglRXBe1LWNNdhA6oV41h6DWwNdB72PolaB8TEOVmz1UynZxnT1PDlJ
	6twZIpZ4AzQ0Wm4dQvl7Ze3HXo4LB+4cld7qGCpmMQsesdPCOum1iO4z23/pMVfy
	2A1/GxVtbqovct1h6+NmYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782718425; x=
	1782804825; bh=ovJVYLW+SahIYApDBGbowO1TW0+p44Hy8uL+UO1PDeg=; b=X
	MoBKDBy7201UA1x7zqh6V9CJGBkA/sj0LP1bEuAA6GhBXLyUoC/Jz4FYiV2ViEE1
	lwagkgHXz2iZzyMCbmrivkF56YUrhmQodYr1pZRZLuOFRDQ4Rp7z5DH2jKAslzQP
	u3A0G5g2FIF7qH6JiQkMhvcevjum/AxoXUvuLIjoKD8cYrgXhP3VRahP2htbJ35E
	GPaSxgaoxrm3eFcsNBNDCRXDgF4fRI7VRmm6FSobcyU63HR21AFSmayNrsah+6my
	htFC6pOBsgxZfEsk+nqqOnQzYJOWetYO0EicczhCyVZrZrUHDDjZtTbMSdIdAkcr
	I56vnX+vRk73cOyLyBGPw==
X-ME-Sender: <xms:2R9CaljmRHIXTeF7-xKwtPXF0AllhNJbcOeLm3SpUNk7T1n_5cMHew>
    <xme:2R9CajWTVhuCVTNqV20pem1NkOsGB0PXtP0W8OEcWXEQ3fdxRNhvahS_7dpw4elzF
    0u8cuh97JUKHfFeMmO6MF0Vc5_17HrMph0pjg99M8Pf0nbvhvglHQ>
X-ME-Received: <xmr:2R9CasUacH2g5pdaNJpsZ2f02yu_aVXzREzmmINqVrTGEC6gzi-vlkqJMNorrbCsUP0j8JTj6v3qhaTZYf4p7AA7hPftYp9S23I0a6GTQ6lJ>
X-ME-Proxy-Cause: dmFkZTGaPlWZMFIA7rRC/JfmkvdhUfeFPwPOTZvq9+oUysa/cei2slQ8LHUH89qK6f8Et/
    8V7vRU7mSXi6zExUFk0tjq6O4DgMYT8YooNEcNQYg1Zv9toHqP33kZqDZ/QXEHu+TAHwEU
    3JZtX1dXALriWTypfLStmhzTLMOFQCEZNJbkzy2ev5HFfd3kgHmz0D5ouB6ZTg6q7DtZnR
    fGTvdYZU48YnCS4S+owkggdGyTzXzhc4GNmJyojnU23MQwG9oWezKtg+vPRX8oGH5iUINo
    nHJvLJ4okWwv+350rePu50qJlDJj18ijPPHVedF1m2kiGk0gx383lOfaoWGjdFIkqtYOaq
    i7+aeTWvUTLxvgnl1hMbc3ZZbKmKW7LgEUX5L60sLlZkAz9U1lcr+cw+BK6+GjewGJQtKN
    Iy83m8JQlISRZVoro6P9evv4FPx+xvPwQVftVtV84oDLk5zCToiPToWj5hKBKMNO4hOJ7W
    Bg4okrWpuoi48pAi5SArQBv4aiZ/wzOAdpLT6igueyDmwl+WlLBrrwj81MY3QW+XNadD5l
    SrnHK7qMa4A1scOnWMbGHMAIbbJrEOvvVKvJ1IRMP84FWusMLZESF6F3utEgpjBIMhgnhP
    gz6LNFQzhblAMOe2zRg7zJUnGkHVkG4I0mnkpDZxM93IA4Opo7BFRGnqPvUA
X-ME-Proxy: <xmx:2R9CariClDNe_dusHL_6vEGta9yj5UrJBdfKJv-52lRaxEz4axcmMw>
    <xmx:2R9CavZuVYNtQR6WUQc05NX1007Ac0jfK6jc5yJYzeieYo3vMKyW-A>
    <xmx:2R9CagpHp0ojZolWJG0uBCGxkPTyievoOYm8HwLF23uwcWa5A-VnTg>
    <xmx:2R9CakMXiCeWyjQJFusJcGzHexO4NsqtWUUKD8hVeKLnSUdjBeKsfQ>
    <xmx:2R9CaoqjdDXJWf4piCzAzFcTwX4se0zPPYSnTjercgyw8UBBSpeElrGv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 03:33:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 73efdfdf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 07:33:42 +0000 (UTC)
Date: Mon, 29 Jun 2026 09:33:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Pablo Sabater <pabloosabaterr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v6 09/10] builtin/history: split handling of ref updates
 into two phases
Message-ID: <akIf1N2HuAGJEAnx@pks.im>
References: <20260615-b4-pks-history-drop-v6-0-2e329e536d78@pks.im>
 <20260615-b4-pks-history-drop-v6-9-2e329e536d78@pks.im>
 <CAP8UFD1evTZqj1ymW9g5g2RmMkYMaE0rPa0Hzt+irH94M6LD6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1evTZqj1ymW9g5g2RmMkYMaE0rPa0Hzt+irH94M6LD6A@mail.gmail.com>

On Thu, Jun 25, 2026 at 03:37:42PM +0200, Christian Couder wrote:
> On Mon, Jun 15, 2026 at 3:56 PM Patrick Steinhardt <ps@pks.im> wrote:
> 
> > @@ -414,14 +389,43 @@ static int handle_reference_updates(struct rev_info *revs,
> >                     !detached_head)
> >                         continue;
> >
> > +               ALLOC_GROW(result->updates, result->updates_nr + 1, result->updates_alloc);
> > +               result->updates[result->updates_nr].refname = xstrdup(decoration->name);
> > +               result->updates[result->updates_nr].old_oid = original->object.oid;
> > +               result->updates[result->updates_nr].new_oid = rewritten->object.oid;
> > +               result->updates_nr++;
> 
> It looks like this duplicates what replay_result_queue_update() from
> replay.c does.

It indeed is. That function is internal to "replay.c" though. We could
expose it, but I wonder whether that's worth it. Goes looking... you
know, let me just do it.

Thanks!

Patrick
