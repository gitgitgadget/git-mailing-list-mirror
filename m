Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A936D23A9AE
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 22:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741042538; cv=none; b=OoGCzZy59IlbdX7VZLs/6oYkKe1OjkEAQ/Xqji2oBym+GBijnFBM4f9xkm6m2df3gvsCXZaVTlqowx7wRtsX+iUcZHF3zC+oSGfFAesFtbwMSAHYjONGEM0y8B2tS2ZOuB5czcZohmvlU5T81CXUEQcnCws7LX4BYli74eoK6EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741042538; c=relaxed/simple;
	bh=aWIZgweHQWKQxpkP4ncyPtfR81T60x+pHFz2RDsSvnc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lRjbgWKF6fn9Nrs44OLS6xyABupBlNmhxlY+K7M1d/42Pjx0ob4wgJqrTE/x52YRh6m6e6JgHA3HQ6K2w+04fQktdAN1O2HO6tr2n7jGgz5JsfQ62jDVbuz6jRVO7giUx13fqWuv4HXwR5nYM2FIWoCbge4cs7gx0cpyT87l0QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U/ymeD7A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KAvSKsi7; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U/ymeD7A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KAvSKsi7"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id AE1FA1140149;
	Mon,  3 Mar 2025 17:55:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 03 Mar 2025 17:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741042534; x=1741128934; bh=7VEYg8KIxa
	daUb5a4280YMJC5oG1swxy+vMALyy1tqs=; b=U/ymeD7AamoiKHT2Enepw/0aIW
	pUsaaUpNJ9ifbko2Wm7UfTcTkXIpI9D9rOrCk1vEqae+9NXPXsHCUpaMo3cdO+7a
	bOG0V+e0Zz8Bg7RfePxHPkcQnioKezKJnjOvBCXohraxf7rmC5+cbCsjJ4YuC4ai
	PXBMSSCmPt2qIsZ4EtaAUqALj3jIS6TcPyXvph/HtT1oC08fRiIoEHrPNjkaBxy7
	N/N1sDavQQfMIpNOYAvFY3yPnkG7MHqiUPMODr4o2ckSBsAubXHzSlWZ1DeoS6mk
	hG+QWzWoHXDpTZ9fvoAqPc7HZdwv9xFrYUUHkgDqkjPeLwLBzb/hJCkKfbOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741042534; x=1741128934; bh=7VEYg8KIxadaUb5a4280YMJC5oG1swxy+vM
	ALyy1tqs=; b=KAvSKsi74V8ra3u7bDcYX6+Khk55C9Mw/kgACT96cgm5QjY0Pjj
	c7c2Ug2Kht+BDZi1N+SWo/9fkt6Ef1/6tugMrBf+ywZyx5Jy0h1Dhyza7Vjvd8Yc
	lJSZnW2fHIy3qQmqDva5yeFBRODFibrh/8JeSLCYEHyVhYtzKrykXLO0yVC8tr0C
	UVyrSD+b+aF3cVuz/Mx7x4lQYcARoGV8m2BX2SsI1x2XZDvlQqHZowdQsL8LnEk4
	Ge4Su+w/8+NUXs5ykKgwhWE5Lp6/NxNsIinSVJ9Bklrn2YnAJFovHyy3x2Zre0Ro
	0n6w2UimzsYXG+CdBGHHK85hN9faFd82P2g==
X-ME-Sender: <xms:ZjPGZ95wjFJio-tH4s2TNOi65vEVvMDdzCcPNtjNc8iARe3vQUUUbg>
    <xme:ZjPGZ66e0SvU0sX35jq1IXoKjsNuUeObEYwI7q7c-PqarUntXzHDqSfydtN7AaxGU
    HdZznLcIgXiy0_qyw>
X-ME-Received: <xmr:ZjPGZ0c8mSAWvcymoN436sZxyS_dNGtR6ARvG0FOiD0iHjzG9njyTRfVxYS5xeLrz4hyqBuh48S-5itc1ZclVidQqOgsBpHUiVnZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhmiiesphhosg
    hogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ZjPGZ2LgvfX_r_iXGMJPbB9TIBebKzniMUR2MnYK_wR-xReYrF-J7g>
    <xmx:ZjPGZxJaDEwtjFdIGeZftPAECoy838v0WFM2CKKqPTUZ5G_knbx2vw>
    <xmx:ZjPGZ_whrZ9E_gXQTdTklFY77wFY873Uxzce4sroSu4nvDQcmluT9Q>
    <xmx:ZjPGZ9JxLdjjAZF5bId45ivbqj09OiawjkvE6JcrDoUA7esTXDEAVA>
    <xmx:ZjPGZ_gDr86LwCqoMIFCen2pbGISXfU40hGNhP3rWSGhAci7lSxpcmjz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 17:55:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
    Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 01/34] t0450: *.txt -> *.adoc fixes
In-Reply-To: <Z8YtJd078J44snOE@teonanacatl.net> (Todd Zullinger's message of
	"Mon, 3 Mar 2025 17:28:53 -0500")
References: <20250303204443.360595-1-tmz@pobox.com>
	<20250303204443.360595-2-tmz@pobox.com> <xmqqo6yhvl2o.fsf@gitster.g>
	<Z8YtJd078J44snOE@teonanacatl.net>
Date: Mon, 03 Mar 2025 14:55:32 -0800
Message-ID: <xmqqbjuhvi57.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

> Indeed.  I haven't looked closely at the CI bits to see how
> we might be able to improve this.  When we skip tests
> unintentionally we just don't see that currently.

In any case, while the t0450 was inadvertently disabled this way, a
topic seems to have escaped to 'master' already with an inconsistent
synopsis section and help text.

Here is a fix.

--- >8 ---
Subject: [PATCH] refs: show --no-reflog in the help text

We forgot that we must keep the documentation and help text in sync.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/refs.c b/builtin/refs.c
index c459507d51..44d592a94c 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -8,7 +8,7 @@
 #include "worktree.h"
 
 #define REFS_MIGRATE_USAGE \
-	N_("git refs migrate --ref-format=<format> [--dry-run]")
+	N_("git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]")
 
 #define REFS_VERIFY_USAGE \
 	N_("git refs verify [--strict] [--verbose]")
-- 
2.49.0-rc0-191-g335411b56b
