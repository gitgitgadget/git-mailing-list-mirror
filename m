Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B92A423A93
	for <git@vger.kernel.org>; Wed, 27 May 2026 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890414; cv=none; b=EETiQaFSuwNiiRdH/sKCaN6OI0KPwvBb3AbhmyWxR4UnGnE8KjLKANIr0vlUvnspnEIFZIOkkocDjpdAZeXM+8PxudA+sfZpp5yI12lKycL9exB5pg/jVNjcgtUrBOy1V8LnErDpGBPB23w/jxy0SLfsQhMQY98xWmqWbuXxuiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890414; c=relaxed/simple;
	bh=auWq4/zP3Avl0E6U3YuT7Aq12Yy49ZySEcczR84FWpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WNLfZp7rwmhxTPewc57Q6MTOAZfQUkKtxfshLKS3r6W0aKmS2NOsabKsesqBwl2ykyUdVfhHFMK5gQSQV/HOt8InjUi6xw1VWjarhsqaXxi8ZFYo+2deujQ+zYPx9B5/9sCfdTzpzXfLlrpN4X+ZvMxh9P+fYqrveCxp3dbmfgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Ve+MjhiO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nYzbNodm; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Ve+MjhiO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nYzbNodm"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E347140017C;
	Wed, 27 May 2026 10:00:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 27 May 2026 10:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1779890411; x=1779976811; bh=Wi
	k8WEt8AT3mcCRLXoHj+89X+lqMTauL9V0aP7Kl+Pw=; b=Ve+MjhiOBDBZ4L3c2W
	bOODOtl3NmeZteBYCW3vBWIPSpFSgfI0mDvRrJ9fWTHMG/kFybqzL/MoSVRkh3I+
	N4pZfu4v+n091PD7swvzOcqsOb/UgDRxowwaBR/UXXfFsPKPMTggoDhI4ckS/Bs3
	/L42e/MTDHe5fi8MjAlGxCwJENlxr8IEKJySKc4dhljpaW1uuJieIurM2z+QfWWq
	O7lM7w+hVFIJiKd27PICcG/7YhjapqnxTqp4EW+xBFcymt1LIlZ/uHbrdcbSz6k9
	gL7ifuQ7hDAawAXdV2ZU2XXGqlccGg7wKeTKls6GElNUujffa2t7Tgcbr3jeEg87
	oolQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1779890411; x=1779976811; bh=Wik8WEt8AT3mcCRLXoHj+89X+lqM
	TauL9V0aP7Kl+Pw=; b=nYzbNodmAvYKt1c3LgcNbqIChkMRyBi4/e7kXLoZTmKb
	A2svOVHjdUP6wqFO8D0VzuNycGDE6moblwVHjWfHJHvvZIOdgNqkAOiq5YewVF0Q
	7SQM8pbyx6nOewgkELa0a3B2rwKNeGSp+L5BL43I7+C3TxQQavpKQ0Nj4JpQFcTs
	V9OXsdB218l6DbWesbD2JBIyfu8cWY9FXMKZMWamKqy8vzdmAb52AAZaK5HHU4pG
	DC+5ajffgAJXGhRYT4Giu+jQDgWLlF4wjYxHWopO+21O9rWekVyN7Tz2K7BitDHa
	1ON4Kvbt5mY+uoOPsr0SgKCpomMpD5GYjnYWij/b3Q==
X-ME-Sender: <xms:6vgWaiPhOR0drGLXbgQvO9dXI-ZWtm3ymHG1QcTnREiKSbqoiR9HacY>
    <xme:6vgWaoZFAAog9B9cdOZvi-wIEsv2DvpLPeip6l_O6mGafsyV0zC8QpHQXc7552l5I
    -h6shYeQdgbiDPqOAsiCmdUlLHt75fAmJ1uOvjqLMlpE0TBekcuNg>
X-ME-Received: <xmr:6vgWamoGmgCCzxBubFkFkh0zrYUb8eEb7VlwPJdWwFZcolbaL-5H8NiomkBXuvbNPsdLFBupUUNlFWzy9KBUAk8Jd6vqwHu55uYPxCQ>
X-ME-Proxy-Cause: dmFkZTErAvCPI8FgXqle1tyO6ttJvEpirasZ1jbI3jH6fL5vgZwpiIPhfoKnDb/SWvbcDO
    wl97wAZ5P1OVrSYYB+DO8yFyY14lAecRBQqrMk77AanxEMhhiBO+weWzk4ukbbEyywOOnB
    cig1HkkA8JWM+T6KptW5uI9Bn3Jt1/Ik/e7HZjChasIjGabrbdaVTL82yuBlL6RKfy48qF
    amBQgvC3LoBFmYkqgxlNrhZEu0Yur7zlkBdCz4MEfjaotEFzkvLsgENtxZ8mlkvK3QqOaE
    LqNj5mXHX1A3Zgh15h65d9LYdtsmU870emr60n27056i4NK2tWJERjwC7SUSELEBlu0Mib
    vX2QEvEKtmpS0TGIadEcc4IV/Y6TmBRRC0V5EiYGudpnjBM8uEONJPmPC9wJC/rQg+gBG7
    WbE41wYbMSCIiaNw08v3TY2/pJlCo9mwXiOwRzSqdAJQDeoxC+QZFPT94eMqPCG/HN89A1
    HB+yvf7ujJoe4nGoKmzIH9LngMyfewhifonXxl9wkflm1q8LwFNuPzyIWZzmKZduhRk/bW
    gUOSuJ3cqGd3QV5HlXeI+WoWX4gCUB4mCds3fJdtPoDnXZX4l4qI8nCTB6WhIbdgeDcFS7
    a6BrR2fjJCK7y/EQllkEAZ1+m5bcjv1KQ6Fw/99O0pyAFhXpseDpgaP2bNiA
X-ME-Proxy: <xmx:6vgWasZ62mE7oXq9_yFW5DM-GhlxZ1Yd3OIkwH9_vQna-JmupIwgxQ>
    <xmx:6_gWauSlPUHlaC9oFgRx55Igsr4e8JpTurDKqoVG-SWtxunge7_epQ>
    <xmx:6_gWaj77C9vlEXx-grvBSgXa3ijfsC9M8-mY7a1yh8TkCC6rqamTYA>
    <xmx:6_gWajy3ztbNabndNimrrXVoOCcarFz9y-9ipwvjNJPdnirC7ORtwg>
    <xmx:6_gWaoju2sy2mRD_VVfqlpK3qEjru9uFd12GBpz3gRcXTlutkL-bOUf_>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 10:00:07 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] commit: remove deprecated functions
Date: Wed, 27 May 2026 15:59:24 +0200
Message-ID: <CV_commit.h_remove_deprecated.714@msgid.xyz>
X-Mailer: git-send-email 2.54.0.6.gf6fa7dd4140
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name: kh/commit-deprecated

Topic summary: Remove deprecated comments that were slated for removal
after Git 2.53.0.

See the comment:

    /*
     * Deprecated compatibility functions for `struct commit_list`, to be removed
     * once Git 2.53 is released.
     */

I merged in `seen` and `next` yesterday and found no new in-flight usages
of these functions.

I commented on this patch but apparently it hasn’t hit any of these
integration branches yet:

Patch: replay: support replaying 2-parent merges
Link: https://lore.kernel.org/git/920cc022-8b63-4dbb-a41d-957ee01a5efd@app.fastmail.com/

[1/2] *: replace deprecated free_commit_list
[2/2] commit: remove deprecated functions

 builtin/history.c |  4 ++--
 commit.h          | 19 -------------------
 replay.c          |  2 +-
 upload-pack.c     |  4 ++--
 4 files changed, 5 insertions(+), 24 deletions(-)


base-commit: 56a4f3c3a221adf1df9b39da69b8a6890f803157
-- 
2.54.0.6.gf6fa7dd4140

