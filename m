Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3311430ACE3
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 20:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783111283; cv=none; b=S9nyPUJGT0NAvPCHDBFPMRmMIC4jkiq1/nFSUKGz1xZfCyzUwQGrIE1k07Mx+tNNTjJSuRE6sKPY/2CGWNgLjCLx1Xot7NVAgBApnOXqYri9NIGU7jiiDJHX+tQddusVCrHfKBJ7iDb5x5ZY87XIrrQYLBFWgY6l/sFeUqbtPT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783111283; c=relaxed/simple;
	bh=KhzdHNTkdzsZ6NJL870Dcw8kdKkkxsmtib1QiMZRQZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KLCyZ3lBbwj+tLrrZ1E6iCNBTKXQTUGp9Opn6eHK5C/rMKCaCM03zp5Lbm+u5GjZm+9SYgCNkXGfuCIvqe7VjFsrUG+Z5ocWlrGFrHjYodSL7r07REmc/pkSMgmBoGFoduU/0n+/b9xrkLypJwZGMTPt8BILbcC6b2kthgTVRDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PBU64uwZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qMPrcCcc; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PBU64uwZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qMPrcCcc"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7D3317A0079;
	Fri,  3 Jul 2026 16:41:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 03 Jul 2026 16:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783111281; x=1783197681; bh=KhzdHNTkdz
	sZ6NJL870Dcw8kdKkkxsmtib1QiMZRQZo=; b=PBU64uwZDA+O718xg0/HFq02xW
	BQK3fRQLoAYme+tVTXf8CQd7awPhxmcTjSRMgP/VCuyRum92xr98JmpfnUFBizE2
	ljUd3l7nAdpfGuH5WIsOEctlFbPNJiuEaawtSwCVezMCNuUV/mTnOHQt580MooNQ
	8AvH6WiY+WB3RvXcnp7ru9rNcFddCUAaZ1AQYLWq7mSLxU0v17UCO98F2OAZzwc6
	OdtkSdLQQT8XMyBGUAM7QzVRaFB9yOaPJj0QCpj9kgOzGCbEk29GwK7GZqo+CzFC
	mu1Z8PqOphlc2mLxzrsyEEXBdWoUJILeTm5xsoX9eaykZ+d5YozB4q4kxB0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783111281; x=1783197681; bh=KhzdHNTkdzsZ6NJL870Dcw8kdKkkxsmtib1
	QiMZRQZo=; b=qMPrcCccp6xf1noDXcUu6ESLCLTNZ5hjHukiuIMlK1sdJB3dQtb
	f/wlbrYXo2Cn9/gk3fJK3waGKnku/3U5GegX8GYMnf/Yxv167SkR9cW7PsVtR76d
	JNLDEcbBu9x1cFwtp/lwO4O02oez6Vy8uOVBH6lOX7b5SwV4UvW9QC9UcU8eH6VW
	V/AR2UK9dIzhEs2otl5lSIzzs6u5F8iXeLl0oXXjMLeK6dIwYC/7HqK5xZw3B4uD
	5Od7WfwaLJ0j1Y5Duh9sqb3dD0dYV59Clm9G12tDiw5WqkpCFzuANyjzHDa1xt3F
	HYC0gx1KZ3s7iTv5e+tJDgr1wm8vqGWdZig==
X-ME-Sender: <xms:cR5IagvopUcKlAmS7w3ryJuDkvRsWMc6nXQ6i8aLj76ixBCcB3Ukvw>
    <xme:cR5IakdvcGcQhB9yO_8uoH7S8MA-fYFHwU_e9YCGl-op3SpAhefCAo8qRUSY2_duS
    8Dya3vULICpd_xtcTEfLAoX-twajOSAUCY3xDpPOM6yA00mOAW1>
X-ME-Received: <xmr:cR5Iagw5N6QFxim6ET2eXxcbSUA9Cx-X6OL1hFh4B7Em2z5ZWDk6y0kLHm_oIAXjD3vHFwK13Vi6YYEOYUpPhUJ3t8JIQQIWYnMXZMM>
X-ME-Proxy-Cause: dmFkZTEjpZ1wJKQ9rh4ie5XrQpEtmPWTuJbrM4nAcKR08KHnDyF3OIzvQ22sW8BH8dhcOC
    468d1RhA8leM91w5qFtiExw7xqmO61L02Rfh9V9MbFh4DC/LBTFPKpqh15cssXQ7sD9C4L
    KXkO0bxU8ngcXyAtdhzkIfDnz+cV0XMOManyC7sUgLIRR8NM/aRhG2m1PD5X7nWc6mVBo7
    voBswzpVtwDBYJaTYPvxrgBxCG8CZXkubWzmwbxEwVWtTmLN893uCvuWecH5krzqM+O+5e
    81ff6qnq0cixQELDU1UkNVW5n1+eO3bQa9rRsuP+kNBQO8VpY1zwOxJVkjo5MIO+nXy6l9
    f1Ixm2jUzrjxo1plLiOvnqWU5ryOjjDH+h33jEFVX90IquqFX5fbs5r4pi9jsPxXV/JSg+
    lLO3vsCq6cqLAmE7sWK0tCM0Ne1snkYeY5cY+6/IYC8YMjwBbGdCwtvWM1xCtc478w8VK+
    yDWvsGVSmFJB8zRzp0P7SFCfK+1LP/hvuKjDCqpwwW8+7T+C8FoDe5u2jzkAbMa5k4zQrt
    mn0dKKlYAvwtAAQTVwLyEV+njB+64gE+j0WrlpKqdJqyu7f4B4UxHue0gibuxvcT+SAzdx
    z7KMeIUd99gbSHlslCuEUnJOPy0qCxNVBegsjmQw5uOhwq1U5MG2Y/V9C3nA
X-ME-Proxy: <xmx:cR5IaiEg9GByYMAWGN9eo96lJ88DYJRIgC7xo4LywqhpwmnV399Hog>
    <xmx:cR5IasyJfIagIfSVJUrnNfjLg6R5mGzQhb2jruA-icOw5kmbAvsVSA>
    <xmx:cR5IartBemX5bkzabaAjL7zktsH5Ylx8UEsJT6HUITkCBKlLswo0JA>
    <xmx:cR5Iah0Sa1ZgCDI6hRiUAm2gdrTcI4BEGZqUpV2TDhNBvCbPI2sW2w>
    <xmx:cR5IakSmKz47UmWZPDjWWJXkviBpbcy_IJ9XEO5ST6Vm5ln1aIf98MQE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 16:41:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mikael Magnusson <mikachu@gmail.com>
Cc: =?utf-8?B?0JXQstCz0LXQvdC40Lkg0J/Qu9C40YHQutC40L0=?=
 <eugene.pliskin@gmail.com>,  git@vger.kernel.org
Subject: Re: Unexpected recursion in 'git rm'
In-Reply-To: <CAHYJk3RXY5-YgcYWY2y8vOcHG5Frf91ehNiZRr66sJJH5F=qLQ@mail.gmail.com>
	(Mikael Magnusson's message of "Fri, 3 Jul 2026 17:25:52 +0200")
References: <323134122.20260702104910@gmail.com>
	<CAHYJk3RXY5-YgcYWY2y8vOcHG5Frf91ehNiZRr66sJJH5F=qLQ@mail.gmail.com>
Date: Fri, 03 Jul 2026 13:41:19 -0700
Message-ID: <xmqqo6gnhkls.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mikael Magnusson <mikachu@gmail.com> writes:

> ..., though you might overall get less surprised if you
> set the failglob option in bash.

Excellent suggestion.
