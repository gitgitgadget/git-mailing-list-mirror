Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D20C21CFE0
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 22:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787957530; cv=none; b=NW14irjV64IYnf9REKUxIdZot1usrpRhpsEviPJE7OOauoVXPsNijnGTe+0TYdJyyPVdMTcy0dd4fCbdGkb7iolkdgWnHlQ/32Yditf1r9bJFlR23WVd4xexlWsh+q15jKFpdnUopr1F/41hZkY4x8n60GmIHcGO+kJeVX5OJ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787957530; c=relaxed/simple;
	bh=FYeK9rPl7AJMEmMM7xAhxiOYH5UQGPPuPja5QWh0n38=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jmKf9KYq0L+SOhkvIG8E5PaSqq0KlFfQTXHZZZ1qzWMLpjUGzQ9e8sWc79aFXMCYE51y/yIKhD0RUnoP1h+xd4aq2uWbSrdQKiOYWUVGkDTI9oQn475m32l2IKylD0EcxjRFnVMeX+IjBGpxh3qZ+ooFV/2tVF81HoiFhSD8vYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=o4IbqDr/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bX/lhNR6; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="o4IbqDr/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bX/lhNR6"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B5D167A0096;
	Fri, 28 Aug 2026 18:52:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 28 Aug 2026 18:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787957527; x=
	1788043927; bh=2W99ttNrrQXNdgiZEl4MUQJafjDBUIfix3gJvZ7iiIk=; b=o
	4IbqDr/IwgfWUanVP5STLHfMNP9V4YeF2OaoBujZvR2bdJzWlgwLJeTImeyw2FhU
	jHg6dBItewKHkurG2LhUYcyXgVCkkzPhhCvWvO+eboH8eprgqiPYD3JJwdyr6iWE
	54ruJMO5/CWTr8EAurxG4imxQwcq8uILMqW+QcYuZRoPN9THCEJBlp+CrOmX6OoN
	RGs1rGhXODJ/fbJjxwiL34vGcLcxovw00PHwaFOgncXeRpfyGWx1Eh4cQtGD0X1q
	vD/6qs9OhXBosk5tkq60gU4VNctmLpyfQor82Z+GYiihF4DX+ly/+NPY/D1gYwp4
	t6kTr5t6Qf0kHXmjo8SsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1787957527; x=1788043927; bh=2W99ttNrrQXNdgiZEl4MUQJafjDB
	UIfix3gJvZ7iiIk=; b=bX/lhNR6ok0hvr73ZWQcMPqeAuCdVLfykFPaj38w3Srq
	un8O5WaLfItABCmSSvIVTEY8GEI1BiFRRhzNTmez6apzzq95g6Po/rwacvh/aqUq
	8SM+KA94NEtGL51wjIlvN+fAtAcdww5XDlyfarZwcQ3lMx6oBQGs1f4ew1Y0ky+x
	p1lYpoPyA2nAh7nWhQJAACA/QWxGhT6n9nympdDncAEZzo4z/PwlvidHPtJvcMb+
	kN12n3Vs3OCahIEq8xFESajB3Xrbm2+RqUObYTurRn1jbM1mXP6f9c0wZxRla1PF
	PYhNcz3bzahphA/zdv1ciSzLs/zpKfqGZBdnVZR1yQ==
X-ME-Sender: <xms:FxGSal0R71ZtUXZ8gWHLeEg6SjovZ_38IGPYJg2IprMNEU_WPFdhVA>
    <xme:FxGSaiGSs02BHjudjuRZIBANHtLyhs0IPVJD7_cV7GGUNb2-D-CvyCjpjJz50Tk6e
    dPLdNl_fvj3uWl1QVHWlB4sjmzHIZxhD-rB9nwn0xY1bOsk-nAKn18>
X-ME-Received: <xmr:FxGSajjUc_NyhQpoiReG0_WkgM9MTz8v3TWGIsSbmfc7ckbXQ9XScj3bXAKhOba7_2Pr88jn2C6O8qJYh5_KjjruUsV3Oc_seQ>
X-ME-Proxy-Cause: dmFkZTGrgqI15Dzdt/9WDs7rkGJZREHEdRsRTmM3msHElDxLzeMIk1hasL8GGqN2Z/XEbx
    BxjOQ8kfk9hI5YHWZYD7byIQ/sOl/XPTcxaopp2OX9/hcA9ZJgjhGornr73idi4kOin0gZ
    DUUFCb3GFoZvQHgabs10XoYJW5JzNFMKfEOBfOGQ6K+mH0nyTexgCVuodp4hBRigcrDRBD
    vRuqk5hCX5TzfizWLLw5JXEkVwu+Q9fGfBX2v0yIUwbnZh1tyAOP/N2SH9cJpWNmvZ5Pfa
    Jq8JBeRYmi9Fy/dCSDTUax3CTuwY3FLQVhw+35Xk3EiJauTQ4vB3kgNhPio+NPzauTJkG9
    +OmFTuhvJY9cs1IFdZ8j//Sq2QcXryoNUUT6qZKCSXDCNWijYP8Hst5SLBzlYOar+zcVwd
    1MeUQIkPFd8FEnK53JhQ75ZzCWWeITNz/LuVsBm+b6wKT/DqfiIuM0SMJCLwcS5s3dV9zf
    r4w8zxn95baoTHzr4lThilthmeKHhHLYiErnm1SOczm3ttUyajhu7Nc8FO/7EmtYo0lNnS
    1PXaNEv4R9MVs+aYfwwlo++Ro+1usTvnGGKyTNj7FlkgCq7VEddoBwbUxPxBP5JhpBJZ03
    wJZJ+JQhOBbtM5e2ZDpfuJ71erBNPAYzEi6vrGQ8L5/8P00loQiXBvmMglAg
X-ME-Proxy: <xmx:FxGSat_0dRSlz8PFH2X1LohI4JGSLevWi_okiGSli9Nhza_1GIIRUw>
    <xmx:FxGSaqoalLmhYJEzyCshWShCDtwrfp49jArDHKfYAaWO8yoXBF88KA>
    <xmx:FxGSas8BVLJWgag21B6ZZN_wn-CbJt7hPttfykGFDvapidhG1Iwzmg>
    <xmx:FxGSauVxzW8d-yzBPunFgOXglHnrq0EIUxtaMu2MhuH7XCLY1gqv-A>
    <xmx:FxGSahMSQZc8v11QHX-ng8Bpq9XWuE5TrFVJN13yzbDYKK6jjUX1Zbrk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 18:52:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/8] More sensible checkout/switch/restore code refactoring
Date: Fri, 28 Aug 2026 15:51:58 -0700
Message-ID: <20260828225206.310500-1-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-884-g76cf8659c2
In-Reply-To: <xmqqh5kd3lm3.fsf@gitster.g>
References: <xmqqh5kd3lm3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the beginning, there was only 'git checkout'.  We then introduced
'git switch' and 'git restore', borrowing as much original code as
possible from the implementation of 'git checkout'.

Unfortunately, this has left the code in a strange shape.  Had we
started from separate implementations for 'switch' and 'restore'
then later merged them into 'checkout', we would not have arrived at
a design where three front-end routines, cmd_checkout(),
cmd_switch(), and cmd_restore(), funnel into a single monolithic
choke point in checkout_main(), which then determines whether we are
checking out a branch or paths, and dispatches to checkout_branch()
or checkout_paths().

This series is an attempt to repartition the code into a better
shape.  Because checkout_branch() and checkout_paths() already exist
as two reusable helper functions, with sufficient refactoring of
checkout_main(), the two newer entry points, cmd_switch() and
cmd_restore(), can parse command-line arguments and configuration
settings and jump straight into checkout_branch() or
checkout_paths() respectively, without worrying about the other path.

Of course, cmd_checkout() still needs to decide whether to check out
a branch or a set of paths and dispatch between these two backends.

The series begins with three fairly isolated cleanups that are worth
making on their own, even if we do not follow through with the rest
of the series.  Patches 4 and 5 then refactor various utility
functions out of existing code paths, and patch 6 uses them to
rewrite the three top-level command entry points to call these
functions without going through checkout_main().  Patch 7 is a
style-only fix done after the dust settles, which was deliberately
kept separate to simplify review.

The final step moves one helper utility out of builtin/checkout.c to
top-level checkout.c as an illustration of the libification discussed
in our recent threads.

Note that I consider this a fairly early and rough draft for
illustration only.  There may be a few topics that touch 'git
checkout', and a refactoring of this scale might adversely impact
them, so I will not even merge these patches to 'seen'.

 1/8: checkout: pass cb_option explicitly to branch name parsers
 2/8: checkout: validate new branch name in checkout_branch()
 3/8: checkout: validate stage and merge option compatibility in
        checkout_paths()
 4/8: checkout: extract option validation and pathspec helpers
 5/8: checkout: extract branch setup and tracking helpers
 6/8: checkout: restructure switch, restore, and checkout
        entrypoints
 7/8: checkout: wrap overly long lines
 8/8: checkout: move post_checkout_hook() to checkout.c

 builtin/checkout.c | 545 +++++++++++++++++++++++----------------------
 checkout.c         |  22 ++
 checkout.h         |   8 +
 3 files changed, 311 insertions(+), 264 deletions(-)

-- 
2.55.0-884-g76cf8659c2

