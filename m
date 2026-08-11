Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC8D3911DF
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466015; cv=none; b=quDEMMBlHS0GYb5FL0FUb9VKsT1qPkVLS/J6KbwzvU1jWQ4pMbPauREK7Gu/+hrESozOh/8mIUY6Po2OkQGUqt6lcQzkv52XdecpXzep4yBr3bqMp6lBWnD8zlpP7HCIZcUh+rPQ/3nzrPIvTm9O8PlPI5f3p6q6f8EzX996WV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466015; c=relaxed/simple;
	bh=Bp08/a0pEKsODSnBRB+BkWvJ7fUM40FrHHg56OW3tK0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uOuoyG3GIvaEv86LK6rifnAipmBKGMd7uwK8Bf+2QR36KwQTEieUj710v9exf0ZSb7TwFcLTqBMb3fvCSQmqqWpv/bPog4heT9VDfHZrYe4UXUu7Doi4AbfCsIZdo3t3GloSr8EMtmtRozxZs5S4CehsI8nGV1azVe3bL3BggtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KL4sIMET; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QFl3sCFg; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KL4sIMET";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QFl3sCFg"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EC3911400157;
	Tue, 11 Aug 2026 12:33:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 11 Aug 2026 12:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786466012; x=1786552412; bh=RAgeanq8RQ
	HHY9SSpim3sqc7QpmFrrg0QUL4/3IaUYE=; b=KL4sIMETk92aKzrMvtI0MzUb9T
	NTPleVf9309mVikMxKjw5YfrkpHPS8E1SSP7b9nAOy135vZgZW8tZN/3LK81jEKL
	YcBsdzWjKTJ0tGnW6REZ62dL0BbmoyXeFiq4PN71pYYFa7L8mDaq8+qIPa+YMN47
	8qnkNIGPYYZYaxOj+aO8KFexwTmh6B6z8Xu6CNdVZ8fTMedrl5grhVj/boIomKSM
	HrO2TCBsijiGuo4HEznRqQza3uHbNrXz3qUUeRgfhmh52UKh8bCpnJhRh0fDXwEr
	tmvzu096TFHyBLBwkkgs0lM+WqaCpQN+ydG6oy78RRppF5w74Ezdv65Ls0aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786466012; x=1786552412; bh=RAgeanq8RQHHY9SSpim3sqc7QpmFrrg0QUL
	4/3IaUYE=; b=QFl3sCFgDQ2n+tqQPB4Kw27UfV5VerHnYL9YyrJcFYcb6l2qhZy
	Z3stRNSPC7QtlGa1ZMF4HUEdAlGuMgrrS21Sw07bzbDkePCjFAGlGWf07xHErCUC
	acRH7ssLn4oESp09CIFfKGpauNxwxRIINUpOdv4yr8F7vPY+5erVG6dzJPPMDH2T
	XjK8F6xgpnF+MFvrpQFBgZmWh++PTD40+oGijIEv6mmLOV+VOUh1C8Fxjlwnf6jS
	S+fjH+hZ9vyFzNB6vHQmhqetyenJ9XOuPk5vlsaHSY0onUYUNOa91LTmzsTH+zAC
	gockyiRXc/UI1CcGAfELWoZYTz9hafPrtqQ==
X-ME-Sender: <xms:3E57aptnEW5GEuggiZzNt_dDmz9MR3EAzhS6T-xRPMIyCIMiZoOqAQ>
    <xme:3E57anYU73pY2MjsW4alh0FQ065rfQysF0gIl1pNDbVkHyqub07vAPiD7we1UE-dS
    FivkIpAuzwwRGrNoiIYNtgarI4Dx2QkL7qz6HWvpfjrQOZ7sClo-Q>
X-ME-Received: <xmr:3E57ahDqddZTWKHizNt14SY6KaUMCmas_1Am_jV6DlIHyDutG2HezCgMhCToI6mMTK7BIWdMnsrv_j2jKOwmEiv8X2FX4-LAhw>
X-ME-Proxy-Cause: dmFkZTFHJZjEogZd4XtNuOM3dULxj3Hoj1YbS9urCz63AjKoEw5RrnbeTeHpqe3TzJlIQM
    9zEBjtX7S3ZHVzj+EfOuJRRFUfl+IAugr3TmEdRR2IiRb/GlpiRy+M2EF5cusWC29kAzZs
    CX+qFbH1dn+0p+g+vQ+whcKU735YeYxYhXUI8ggwUD1zJ3tSbIK5NWqookj16n8w1vlQVd
    r78nz+qz3XI/E3kMRXwwPlaJQiwTbENJ4sKMz2uO5Bk2idn81dcq+gJBzi9Kc942l6rGxz
    5BOlvJc9CRZPx1p0FeTLGUf2Af2lsjVp9HtSSEyS2KexOWp5pg3x7MPW0Ta/t9m6i5BPlu
    HASzB0tHFuBXvGQwB+d4lG1B+9GhlF/GeIxgf4VbpiM2eGBFd6/1I2+SygZWkwl6aSvXAB
    Ds3stexz+u8Nk+qUC3ZUyb7dXBhmoH8C6bgpMAivD6b8dDIKYJU7eNSuitsdr1S6D1psfF
    +uNRMFyKH1cceAqgpavGAgBF1Wkfn4HbHrr+e5nV2SBE0lNhr8/KmZGgj8MsyvzFjvOfp+
    EOELvoHQyCOzcZvr/G2d/G5i4/6VpehfsGM/VPDzd+Pr6XS+n9Qp2X2fBu5ZTFQZ0wJ1Q/
    7tYDaSu19W7TS/TgWAH+NwD+CgNesbun6PClrH60OujfQNA3tf8kBQXZmllA
X-ME-Proxy: <xmx:3E57av--4PiK04wIks7Eu7F1UZzs28rqTFsyzGPmiewRyDSe1umkvg>
    <xmx:3E57atRoZeHNfgbMoW54J6OHGDDbMww_gQ_SvuOVG0-vNTZ1Cwd8Ow>
    <xmx:3E57ajUBmAf0bx8CtE091tUwSQU0aWnLIS3_jEgS5zx8apqIfhp3pw>
    <xmx:3E57anRaUFMA4lMxACo9YrNPjdbWtrF2hW9t6SAyaMgl3hrwr_9_4g>
    <xmx:3E57ao5_ZDFgVIt2HFIZRZEs-gJ8MsaW3BnqQ_xJZzfvz2U5hOc5FEGy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 12:33:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor?=
 <szeder.dev@gmail.com>,  git@vger.kernel.org,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Elijah Newren <newren@gmail.com>,
  Derrick Stolee <stolee@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH RFC v3 2/2] Move libgit.a sources into separate "lib/"
 directory
In-Reply-To: <ansSg4qsPwh5FcR9@pks.im> (Patrick Steinhardt's message of "Tue,
	11 Aug 2026 14:16:03 +0200")
References: <20260701-pks-libgit-in-subdir-v3-0-5e4860056094@pks.im>
	<20260701-pks-libgit-in-subdir-v3-2-5e4860056094@pks.im>
	<alR9GDNTbdjWB4dq@szeder.dev>
	<2d455ecf-972e-e3ce-54bc-683050c04282@gmx.de>
	<xmqqjyqpb96n.fsf@gitster.g> <ansSg4qsPwh5FcR9@pks.im>
Date: Tue, 11 Aug 2026 09:33:29 -0700
Message-ID: <xmqqpkzo39d2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> ... built-in commands in 'builtin', with subsystems like 'refs' and
>> 'odb' in their own directories, and everything else at the root
>> level, I would prefer to keep that organization until a substantial
>> subsystem update wants to carve out a new location for itself, just
>> as past updates to create 'builtin', 'refs', and 'odb' did.
>> 
>> Compared to those past moves, the proposed change looks more like
>> churn for the sake of moving things around, without achieving any
>> real organizational improvement.
>> 
>> I must say that I, too, remain skeptical.
>
> My main motivation isn't prettiness though, it's newcomers to the
> project. Git is not an easy project to get started in, and the root
> cause of that of course isn't our file layout but probably rather that
> Git has been growing organically for 20 years. But the file layout
> definitely doesn't help newcomers to find their way around in the
> product.

What I gave as good examples were not motivated by prettiness,
either.  Moving things around to lib/ as a whole ball of wax without
further classification would mean readers, whether new or old, would
not benefit from neatly classified set of files that gives readers a
concise and easy to understand rules like "you can visit builtin to
learn about individual command implementations".  To achieve a layout
that makes it easier to find our way around, you'd need to move
things again after moving everything into lib/.  Moving to lib/ by
itself does not add much value, if any.  It certainly does not add
any discoverability.

