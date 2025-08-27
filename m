Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A95285CB9
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756312210; cv=none; b=hQgVmt41kAucZ0knRExEcE2KwDl+JAceDfMA1FeW6XcTujpibu/j2E53sDqqDGRtymKV6dFgKGZIKJvym/wov+cjd5xN2HTmzXaO9eXtxLLkz3dVSstqseuY7KI1JQlT6wHmSEEbjZeoVCYuUVKMfPh46kl+1k6W0XWeqzdLJK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756312210; c=relaxed/simple;
	bh=oZYi5y36Wk8/UT3LLbNwmTZNTrUOsTJ7PjSAQLruzFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pjWmtVRSPMqwC7pxtdQ2f0ThKInvlnWYLRDQ5LLa2ZpWT03zNULfn/ynyJcUEwmRm67Syp30Q//8k1Lp/ErEfQE8CT2v585H+nDWeBF15itIVXu97E4WeFT08jbZbui/EHYU30kC4NJLCzcMJ4aMe7vk77YZHV2l8Qik/032B7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=SyItpOBJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kcr6ow39; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="SyItpOBJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kcr6ow39"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BAEE2140017A;
	Wed, 27 Aug 2025 12:30:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 27 Aug 2025 12:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1756312206; x=1756398606; bh=B/
	zQeLBBBuP2HftBpvTOHk61rRZyB1yS2o1TVhblWds=; b=SyItpOBJXrTzEvFif8
	g9qv5sFaX+tZlMzq6MPRrOpriWXfafcgeHfMQFfvBXRI6cQ2OHw/dXazVw9bk2ua
	2HK7i1cfHzpm/r7bPXay9DHgNnOp3JXOxoRn7jmXsoM8Blc+gNVklzbxzw9Gk2+q
	03DAJkKjDd4XEH+hWiyHfQQtNWS562F2kiIHnq5kNzd+Cp00zZfYsc6gmnGZSgg6
	8Lm/dz75vDQA5acmIGjm9xY+XibR9FSDRQvnEIxv1en3L4V0/HyCW6Nwo1h1ZyTu
	Ot2bmfISJyd3AuqsmVk6GLUgyF3qG+Ea7wtQn28E0O8vLT6oA1yfrAgvl4VSC/oV
	zcWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1756312206; x=1756398606; bh=B/zQeLBBBuP2HftBpvTOHk61rRZy
	B1yS2o1TVhblWds=; b=Kcr6ow392kGMGwxrEptOF/WScxR26iVtQZINkwwWJ5rd
	mgCdjGwIknjPl1inVtucobTKLusEgqU6fmAkp8v9pPKaDfLgINyv9WdErYKB2Jxc
	+i691bA9THxJe7eNQ37H85xBZeh99c53Gk7R34NnjoZ89S2OuXVAGusIpjs0jF4/
	xFBKrHx2y0km/TOaxM2YONYLoQoMQA4rICd3rCJ7W3qoq/JCFR8rWUt6kG9PmJm6
	AZQLIYscI8ZzCAFBCj9id7/ftZPGa8wVedygmY+jP3QbsVO2u60fwmvFUEoGPn3d
	fVjiD/hH3aek3pc7VAd3DAv5hWsvhqggQ/zZpZ3+kw==
X-ME-Sender: <xms:jjKvaE0waOKtVQ3qb9l8rTSstHfAExzsG3PoQHNKdZ3NOdGzFLtjkEQ>
    <xme:jjKvaPS0BoOP1ComQDroZhDq0GX4P0eXmeqjxeNN1V29Or1B5tO_gUxksBuKtqMY0
    Wj5qjlpTU7YsNoB9Q>
X-ME-Received: <xmr:jjKvaOuMOGGaZfSOuVpzLNk1EqVMFyvMT64z-HAXmUeucBDMFWwKCaawhN9CsoOiWjOFHIkQAwJyuKZdB5L-X3D05GvGuu-0cDP0dO4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekredtre
    dtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmnecuggftrfgrthhtvghrnheptefgkeejffdufeefffegkeevgfevvdegff
    eujeejleegudfhtdffieekleefhffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptg
    houggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:jjKvaMafGdAiqJ3rHu73nNiUjCP3sW9QrvoX96OABNWa6NclqAkbug>
    <xmx:jjKvaLvWlDxSYyZ6G6HQtpc2_nNarIylMHyoxqEXD_swo9cGzaxXNw>
    <xmx:jjKvaGEiRH6V3z5MnTlng3IhTvLvDPzx2SxvaolpeFwbJB2e--zGMg>
    <xmx:jjKvaOzAI3vb_LmTFrbCxNbFowb1dFBMY2iEbo5mK3VKjJJffpD5Kw>
    <xmx:jjKvaHZWQMEaPrM2uIDsYC2l3f_Ztr1oQiIuOLbwa9odXM4v0eLlYyrv>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 12:30:05 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 0/4] you-still-use-that??: improve breaking changes troubleshooting
Date: Wed, 27 Aug 2025 18:29:45 +0200
Message-ID: <cover.1756311355.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.11.g23cedd8a747
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Based on the recent i-still-use-that reports about whatchanged, improve
the error reporting with this command in mind:

1. Give more possible actions instead of just (only) asking them to send
   an email
2. Hint how to replace their git-whatchanged(1) use with git-log(1)
3. Minor documentation changes

I don’t know how much does matters now that 2.51.0 is out.  I guess it
depends on when the next maintenance release is and how many platforms
will upgrade it?  I don’t know anything about that.  (But maybe they
will do it straight away since they are releasing for the latest
version?)

Kristoffer Haugsbakk (4):
  usage: help the user help themselves
  whatchanged: tell users the git-log(1) equivalent
  whatchanged: remove not-even-shorter clause
  BreakingChanges: remove claim about whatchanged reports

 Documentation/BreakingChanges.adoc |  2 +-
 Documentation/git-whatchanged.adoc |  8 ++++++--
 builtin/log.c                      |  8 ++++++--
 builtin/pack-redundant.c           |  2 +-
 git-compat-util.h                  |  2 +-
 usage.c                            | 31 +++++++++++++++++++++++-------
 6 files changed, 39 insertions(+), 14 deletions(-)


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
2.51.0.11.g23cedd8a747

