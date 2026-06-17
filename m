Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF68F39022E
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781698772; cv=none; b=aFB+T8B6RAnruXR2QuS5AGI8hz6Yy1hFiCwjRUN9PaBwJ5EeljfcK7gkKYgeOH3znhawSOaUtjhyXyVU9a/QnGzaG006B6jZgZQqzK3KErVtOXJosTDXJJjVYNYQfla4W/W+TWnAWQozPiJ+2ZOkcpimXvEQZTjhZ7LRgVIQ8tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781698772; c=relaxed/simple;
	bh=sArVovb+5myWqh/OxpOwGjuMEPfbq5zmct5hi0nmFq0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UvBZrFCiJVJHAsK5FREN408NDzY2daH0+iVYb7pnEKra4JPj6Tbz3sHjYU40+eXESUKUc5x73s3o2gIWAZM64XYtOU10QS9dXoI8HQr+J8KYD3KpI1Xu3EOy8EfCYKdvU37y+otD8EpmeP7J4pgTEVJoPbFKZ0tYj+wTixLVPEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a2oIaYRo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e+12JHpD; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a2oIaYRo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e+12JHpD"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D6ED31D000E0;
	Wed, 17 Jun 2026 08:19:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 17 Jun 2026 08:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781698770; x=1781785170; bh=KRfepN6sAQ
	vAxzuHEHOGdsD1lWFWIuUTxysxkAUY464=; b=a2oIaYRoM1RbN/5pdsh5bUGRid
	Zp0aG3Fs3s/H2NDIapG9nbgE/Oh1VyzhnAyxkt7L0AmiLpeklyJZDqLkzqgwNXke
	hwvd1sxbtTiqqqKS2gpRNU1+wmPoNf+b3vfEchGQIy/cB0dp9ge98kR22vGVNWOd
	p7FsdTAmPmUfBEWTyQ9//yXqgWesi52vTMlDZms8XWq0ac8bK5+8PpbgJH9tsvKR
	oGpvp+e+/jmdaAJ7MtHWKNhk3iFVW09quSjoF/kwgMfMJ+PoVOhE0/P397BYhbKN
	lPM10CBwqMa42wSJVd6JlPDWDeLc1sJZwe4e2Ztn/W4Tj941pbgeosxoLpiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781698770; x=1781785170; bh=KRfepN6sAQvAxzuHEHOGdsD1lWFWIuUTxys
	xkAUY464=; b=e+12JHpDJd+eGAylb6/FpN8Iy42KmtbJF8926zkwtW3dJGZ+cZj
	fcUE0y4XIsHznJVW0RHnH7w49TYeTpmQbaQjH1P7LrADOQMjLZUd0IL2g9H+a8bV
	A3C4lgTcv9d8V4kudiZgaHIg3lfJjIRr0vbxV7QXUEQCxYBV1TfQhM5H8o2hGUW/
	Wmi/uLJaXSnfLpgUfpMGGkWmRMQMte3D7u619hCbboKgmDSUhGJVeetimYTgSufE
	OTw0KpOQORB5Vdq1XuXyeyvWgOaOkV4UdqlV05yZRlO1pyz11IYk0zuyaW9azgYF
	EvShIFcQlGIS8YcvmR5wRX/kNRTOd0llEkQ==
X-ME-Sender: <xms:0pAyav_I7FdP-HZ5_sC_JUMTywUI2CAfY5RaHfL0mTd05mU-5Be_ow>
    <xme:0pAyaimVp7SDVJE3W0mAtbhJj0EjB7xoHE0-Nh998hoRHdpGVXFmOiyTRWB2f7Nd0
    Zeb79aa0S50bSamJTPm0hcIDyTInAigZoRTEaJHqGseNHy5rJfx_g>
X-ME-Received: <xmr:0pAyalXrOy4XqmdVud-RW57yGIDW_eSQVc_5QiRGtZaJ3ohRapwUYdGbEuBV-qBMlGfqcasdNHV58IP05b_xJwq4i3IKZH9KlEKU>
X-ME-Proxy-Cause: dmFkZTGYiD7t0KLtwhQvG/30dJx/QSnZiYaOmjbplm3XEpV0Ivb+YoBI5InryVGltJHyvJ
    31MRWdIJcmR8FlVrBUwT0BRKzkyORDBL2RiKXurXUwM3vp7rY1ppxu5cVfTYPwgIb3HztT
    lLc/pI+uN7xxgNQ5QFY3l+QJECzVc+hrbJ0jdxcVM2duWTKxkwpmeuQ5uiEHM6/5T0mIZG
    GwMfjjTNT3+r+jezM6WZhqxaC5Wx0Lwc+1getsyMJ9DMFV+CnBAi8Sbwq5hZ0OX1OZDNue
    Mzw9YQbX3utdLgTtqmJM30obJuVwAbk9w8spn7mHfYiEugwSnK8S//W2amjfm2PssS3zqv
    MZZ8R53eGDXGl/nqkmwgrPdTeYwLHfELs0TsVcYPTTQAIZEjyPNts1xwk8+rmrLK/Y9Raq
    IO3mWBGbMEUcG4oHXWhv3r6oHg2qJWVZsgE1RXdGbXK0ytEFSkXo46se5oHp8CXsimZwae
    lG3O8+WUKqOEozq5Cl87RzZ/inV+Qzwa+kpDKhKCuTCwijifqDk/2P2f0f0eI758P6zpAO
    KUVAvDifFwNuXPk2s6QOQDfQgp/9Yss1FXH5W7a5K/YnmlbtEK1Jg/5lfEdQlXGbPHRM7L
    C4VwTcVxLh5GR9lWz1vzAWT6fOzIY3m8LJEqR6FmEfxFiUIeJFq8zWtDyfLQ
X-ME-Proxy: <xmx:0pAyanG77rL8TdqYyN3heUT2yG_KWQJ00ZVD57_dejJY_fHAfPRnZA>
    <xmx:0pAyahcST6ukK2T86LpKfZk6e8N2xfIOb5MbFow98hMHTeelB35byg>
    <xmx:0pAyaoK3G54UGnqYCedsJmj9YFnDAu2tybcRxZ3XIC9cHj16PpXHrA>
    <xmx:0pAyamE2vXYuLcM8To4QPC2V2CD2kQbhw3KZ3mkqoQM2sTgDnoYrwg>
    <xmx:0pAyak026f5weN7E0yHXc_Ywwi34NUW1hcPepoCw7Zk60k889EMDxvCg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 08:19:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] rebase: mention --abort alongside --continue
In-Reply-To: <bd7dc183-6597-4fd0-ae64-682d46480cd4@gmail.com> (Phillip Wood's
	message of "Wed, 17 Jun 2026 10:52:28 +0100")
References: <pull.2330.git.git.1781551170529.gitgitgadget@gmail.com>
	<89d72342-5aa1-4dcf-951b-d0c791f91738@gmail.com>
	<xmqqpl1q2xw5.fsf@gitster.g>
	<bd7dc183-6597-4fd0-ae64-682d46480cd4@gmail.com>
Date: Wed, 17 Jun 2026 05:19:29 -0700
Message-ID: <xmqqo6h9z7e6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> It is very true that users who know what they are doing and got into
>> such conflicts are opted to go into such a situation tnat it is
>> unlikely that they would appreciate a choice to abort.
>
> That's not quite what I was trying to say which was that aborting in the 
> case of conflicts is more likely than in the case of a failed exec.

Ah, I misread the intention.  And I agree with you that "failed
test" case is very likely to lead to "further changes/amends" and
not "aborted rebase".

> So if I've understood we'd print a message explaining what's happened 
> and how to continue followed by a hint about aborting. The message would 
> depend on what problem caused the rebase to stop, but the hint would be 
> the same in each case. That sounds fine to me.

Yeah, and "failed test" would not be one of the problem that would
invite the hint to "abort".  I am OK with that, too.  FWIW, I am OK
if the "you can abort" hint cannot be configured away, either ;-)

