Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17739399363
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 18:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510725; cv=none; b=DO57SDfuSXXkLsaBLL5gz6ldwEXnHdTQAVdSbIoE7j6HCK9r/E4GCzJs9awSzAgUrfhFIshst9EGoLAgLkOa0ANiA4pimho01TJ6/D816CnPJDfjhsxiVesMygiKp/7puIseZgNifYGsrhAPHBLnUrk80oXTo64o+UEi82tL/5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510725; c=relaxed/simple;
	bh=sCS+Pn2rq7xcVqgjszKdfeI84Wp+UOuOWIFYfX2rpjk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Q+ycK2mWugucW5k9r4UmQfDy0yWHinU7DyvKVZp7J3V7sJX6c3vSjEyOizOc3k96y1WBRvNHqvxvPpIDppcHNBPBKYoqi6TqPVJUGnvBIE98BzxGxfacdUpnLdyK5LNyqXu0aYTpDwTZzQv6W5B1aqqNPZUcJCfl+uXn5dAypaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=qxzwfGly; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DajTeI07; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="qxzwfGly";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DajTeI07"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E3E431D00160;
	Wed,  3 Jun 2026 14:18:42 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 03 Jun 2026 14:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780510722;
	 x=1780597122; bh=sCS+Pn2rq7xcVqgjszKdfeI84Wp+UOuOWIFYfX2rpjk=; b=
	qxzwfGly2qjqHqlPamsknL5GR0iaKdLyx5sLTMkBGjP6SwPYz5pw2morrHmUuWF+
	K8Az4Vx4JUs++bfiaJomVbiYSKmk43beZdplC/16uqKTLuK/Rq++uRx6ladg/leY
	4crS72uHwM6LWu9u23PUOuZ8zyWA1JUQu9bW2sWDetLvXiRTgyvCxeopSOM2p1Dd
	Bdy9ojsmTK59kF8NTXuaokOpGwE37ove8LK3sC4m5JNirqQ2mChTSIjIqqKgsTeK
	7S1n6sKKd6TYnb67b/b6p7HlWkWeRnvl+M3Nmq05LHMDjY5SpYpkqN+zOL1g0rTO
	JGK4qJOh+TvYlOScH3DD9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780510722; x=
	1780597122; bh=sCS+Pn2rq7xcVqgjszKdfeI84Wp+UOuOWIFYfX2rpjk=; b=D
	ajTeI07l2IEFmcDx4HSDEyd5LhI0t1cVuENVGt66PgXuMlUVn18EP84RIr5Hk+PB
	yM1tmFzPrR2Kb07DCS/eF7XYTwFtFwlsqWtjhESwHb6CrTXvn1X2kMj2S8qBthZO
	EiVuqQ60kL83yKC4r3mj00QSMsq2UFosRvXxMHL2bHT45YAr5++j2Y83Xex2Y2Xf
	3F0Lb2/L0xlQ/LHREJgt6aY20IPWciH/AG7Oak4Onx84YpzhJzYS8Yd1KHaBk47A
	STO9j9qAOt4MpjJeLsyk0fOYt7U/cdImvjPJqGOlUUjFmWqsTfBvuONmA67A02sj
	YT0MBo4JFrMZ+UZclqCvg==
X-ME-Sender: <xms:AnAgahHb_f70VeVxRi-nJpdf9KugpNovHjvwv2pmHHZKNsz5UHfVEBs>
    <xme:AnAgahJgIjKO9R1KyJD6zmZM8jCgnhrUtZAl7RRoYg9SF7le8wi13OoUxsZbhgUOl
    GAUJrjLWVK45NmYWrKuEoJvGhrtihhGCoNsaRrBmyzLaTt8IviMIQ>
X-ME-Proxy-Cause: dmFkZTGSKbwXOTVSrf0Xfs7icm+4sMPa9U+K8nPdj9tQpoIi3657rEDSMEIxkr65SxN71n
    HB4l1mq0H2m9eEtwJoPKcP1TJfUWu+5mzIaLdMNToKI40Ll/80KIGRCM/Th96Ss+UKbJAe
    lsxMMLKxZbzs4E4yD33gB68zSdvR6nJoXDzNLtXL2NJ4hUSeLdgHRZoQld2eLSc7Ku/Ggd
    DozmCITGCcVLVWDZvfyAFEaXzeyaINfo6KYXldCgvxLd8V2KwgO/JQpGFm0ne9tvqKY9Wt
    5iqAhD2uhWuZBiKVstIOywU6NAbDh5es8b0rI1txVlJo969HV+4QRRk2XzrCTAIDUhWwdb
    ZR/k4GrTZT9BC2JRbtxkhU62L99JXYGOANeYyyRCSpJnvuu1Rd/7b/Uk5dxkI8szwK0ASa
    rco13Viw0FvOVj7V+GeOdyTrowG1yrbIwe4BRlB2Xosnc8R5EOi9LSWkwWjG/TYk38mY8q
    8jMHDTUc6WO29A116WwH2X84WPccrl2cHgPnUBVo1hPQUSMJrMnqxfF63h4KDeQs0spQ9H
    NasBNi0/cOc0vOQycPRqkJKSvQ4saRnGc2o+Qz6B1t3DgF6uHAoLlEOB7uOskUcni6s3+7
    3RFnelylSEppJB4aQ6axuj3rHMHdBU170YLTCQvbst7cDYCJOShwN1HbW9IQ
X-ME-Proxy: <xmx:AnAgaiumcOuHfeyAFweho8ClRk20xCmDzjp6Nyvn5Oz7wB4B9buRJg>
    <xmx:AnAgalRwBccuc7wSwPlyNMGzW4YyTWlFtkSvYdLZdpPcm65L7T4pNQ>
    <xmx:AnAgaoOB7bJf7NRHtkD99_nA-t96_R5aNnzJn_NAsDi1pFFRmcLCjQ>
    <xmx:AnAgaqYk1t7zxakXk6hxQ_soOpXhoVRorhyWIZQiFZmT5RhOugUArg>
    <xmx:AnAgamhOZB-y90sOuIVSxNPb3Z4OvSY78Un20cosU0rDCQX1xzwxhCbR>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 93A5B3020094; Wed,  3 Jun 2026 14:18:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATCc6asvzbec
Date: Wed, 03 Jun 2026 20:18:22 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Pablo Sabater" <pabloosabaterr@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Message-Id: <d5af942c-1b94-4c22-97e7-b83ee0b530b6@app.fastmail.com>
In-Reply-To: <20260603-b4-pks-history-drop-v2-4-742cb5b5176d@pks.im>
References: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
 <20260603-b4-pks-history-drop-v2-4-742cb5b5176d@pks.im>
Subject: Re: [PATCH v2 4/9] reset: introduce dry-run mode
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jun 3, 2026, at 18:14, Patrick Steinhardt wrote:
> In a subsequent commit we'll add add another caller to `reset_head()`

s/add add/add/

> that wants to perform a dry-run check of whether it would be possible to
> udpate the index and working tree when moving to a new commit. Introduce

s/udpate/update/

> a new flag that lets the caller perform this operation.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>[snip]
