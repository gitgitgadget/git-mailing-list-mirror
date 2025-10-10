Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FEC221277
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760086248; cv=none; b=lGvvZgqc9AgPwjHh2jg30IZ3kqWZyiwMiSXcLEMsxyEYE3iz3V0r60+fDHOdNtWZ/BkQFQlKM7qHn5doyFFac6xt9FLgpIhpIs/w40U0vqPbq5u+HBcg8zmJTcwZmt3di2FD1Be7z7KKYG2GOLLvTMH7FoKSrZSvt3oj/PFJ/LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760086248; c=relaxed/simple;
	bh=VmhVg88PlLyrYBz76qRT06Vr+tqaaCW7YdOQgkcL1fA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FGca6xQgyH4pe00vj0NnSZNfuOaTLs4h60anrZ4H8Heu2cAiv2KhXwHi+uSsw0JeQhraHFT9OlcMBacgzc2RhzMsYI0jm5RP/tiB5R3x2MtSJXwqRgTnOyYi/+ygDFI6Ajjlut0c3VM0CCLHhYD5uO8nzSiQLqiwVU85PkuG6Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YzO17aC6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ClczqsWx; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YzO17aC6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ClczqsWx"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 697841D000B5;
	Fri, 10 Oct 2025 04:50:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 10 Oct 2025 04:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760086245;
	 x=1760172645; bh=otEXDH7008DmEiMFR7qwMqjjkajPHQuzZKchMJq4PQo=; b=
	YzO17aC6saMk1MUSpE2vH/HYMWIlpXgGImYB4sClnfFzv8shKtS5X1eLkF8Hc0bw
	dpHRBuIpCjw+5WMsBh1SSTzAtNBbWuYKGSAkHcFus0JkWKBbIUyShN4GrbnQA7H4
	/RVuIwBFIqCDOu8b5kB6ljAGZ3HeihYPhjWD4SXKWpPq71HNqIIIG1W6SfjkzeDt
	A1FKubs3Z3IkLVwrD4zwHZ5M/f4He+mufJsOnRgEUNPntHC1FF9cdTOfFP8qHHkX
	ku/zbkkthpVNiH72Tljl2A8mQ57+5+nUuCk7Y1FjeWYR122B187huKPc5DjJQaYO
	1woYJUZUNSj5H26Nq5sLVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760086245; x=
	1760172645; bh=otEXDH7008DmEiMFR7qwMqjjkajPHQuzZKchMJq4PQo=; b=C
	lczqsWx329kkbb0mPa23TVoIWmiejwgEcpyiYTmEFmT8Dbtdnt82QiFMNzyz66XX
	bbzLf3yONUQAcaWCK93yF+y2pYxjJlTMB7UanKJx0BmfuGJFjShCt7vuJivIrZVb
	Sou4klbhZUw90yfCW2dH+3hakI6QVbo3IezQssSD56i3VHLlYxYLXPdmQ3hwJ5qz
	lYgjsG9uwoOmQMMB0rYYJXdgkJXSinGmzhZ8Mn9mYNCmkiqtk3V1woxKcoToik5+
	oIph5lIQ/QeFFH2Zj9+L0QxsRDGF1UaN/Cl0Y8/QF8NOAnX+pwonKeroy+/bF15v
	GwcwtKMgOrcxXPr7cL2dQ==
X-ME-Sender: <xms:5MjoaM3FqfzAKcwbVQfUjK-JjGfkVS5KlHZQ-HkQlnrh9dV2xOUMeQ>
    <xme:5MjoaN9MKFbi-qnH8Au_pBCIN-iHUHahwpjKJBWGNOnAcmFHYnzzegB02926JHJp8
    o6gHa483uZdplp7bRoA7iBBc0DaNvuqA_J_BITMiP6PhFkNo_Zh4g>
X-ME-Received: <xmr:5MjoaNOn38Yv-CRBLFzVi3_pIOv5-AmCeGs5mwEgZiJOXwV1uJzRXaVew529m15-VBlXm85ECkEtELeWo-3GXYdkPi50UOaPmm7G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtg
    hpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5cjoaBcxJ9SQupsviSut56l6mi76imd1QWbtfEchWiqxvHwfp9rwiw>
    <xmx:5cjoaMVNFPPVaWUbOCVefLSgO1THVQbTe5ZQN_OGTquusUZzWQW0jA>
    <xmx:5cjoaJh0HElIgmO84zXhDkMiWDl7lzqreJiUbE5DMMkugjQalrNTWA>
    <xmx:5cjoaL98N1SHZmeg8hgN9nmWVrTAimO_CqyTqwFxljMOEJe_vh1vdQ>
    <xmx:5cjoaGoTghcTGWs_Yaz7Fbd73PLbqzDW-mItnYhidNmP0omjDpU_JnBM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 04:50:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] doc: patch-id: convert to the modern synopsis style
In-Reply-To: <978261e3be4.1760043036.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Thu, 9 Oct 2025
	22:53:53 +0200")
References: <978261e3be4.1760043036.git.code@khaugsbakk.name>
Date: Fri, 10 Oct 2025 01:50:43 -0700
Message-ID: <xmqqcy6vb0nw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

>     This depends on the topic kh/doc-patch-id-markup-fix (39969438 (doc:
>     patch-id: fix accidental literal blocks, 2025-09-29) merged into
>     v2.50.0 (because that’s what the topic is based on).
>     
>     (is there a “reference” convention for mentioning a topic + commit?)

The above is perfectly understandable.

>     This is part one of a multi-series effort focusing on this
>     documentation page. Technically that intent started with topic
>     kh/doc-patch-id-markup-fix, but I published that before I learned
>     about the idea presented in <cover.1759873165.git.me@ttaylorr.com>.
>     So this gets named “part one” in the cover letter (and maybe on the
>     topic name).
>     
>     The current plan for parts 2–5:
>     
>     2. Various smaller fixups (many small patches/commits)
>     3. Mention the two config variables in git-config(1)
>     4. Make it more clear that you can feed multiple diffs to this command
>     5. An “Examples” section

Quite honestly, this smells like making a mountain out of a
molehill.  5-patch topic that focuses on improving a single
documentation page is nothing unusual, but it is very unusual and
awkward to handle for a topic that focuses on improving a single
documentation page is spread across 5 separate topics, each building
on top of the previous one.

>     Why a multi-part series?  It started with the idea of (1) emphasizing
>     that this command can take multiple patches, and (2) making an
>     Examples. But then I saw other things to fix. And they ought to go
>     first... eventually I ended up with many commits or ideas.

Perhaps then after you built up the final shape, you'd need time to
ruminate over it and possibly reorganize to find the best order and
organization to present it as a N-patch single series?  Typically, a
collection of thoughts presented in the order they came to one's mind
is much harder to judge, relative to an effort to tell a coherent story
that moves to a goal.

But we'll see.
