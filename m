Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208C62F39AF
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763148185; cv=none; b=K/Aqee9TjR4fczVKpvLU/foZips3b/mwfWpK1fOUCeEUbLdbfqzArvqP7FB6IKeoq1zhpOEwivKMNllW7zCLU1SXXmIXjxo493jY96ezXQ8VZ4T2SASe11Xfq5pV5c9I3K2+axXKev+w15W04RVtSm+V5Ut4kANW4r7ak2AG7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763148185; c=relaxed/simple;
	bh=gQ16gUNYjZerxec5754WH4orT4iQgU6pONVpUcr+E2U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d/3JUzE69dMDIYxNF8E3dD/aPmfSo4VJOqy2tg9xge03K/Yb8Leuv1/kXewfjPIp29T0wdGVJ/fsFdt/oGtpBbdWEvzGAPfOYEY0TSWLUhwc7tZcXf2gRnlixYz1IDeYQeyF4+GEa99oQQqJo0QCWhV+nA0k2lZjhiIFeSQ2GMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RLcWXgz9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b2NYDn2+; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RLcWXgz9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b2NYDn2+"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 394261400085;
	Fri, 14 Nov 2025 14:22:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 14 Nov 2025 14:22:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763148178;
	 x=1763234578; bh=JferhuNREwt7Stc1JX9hSy+67l62dc05u8MytTnQtho=; b=
	RLcWXgz9OQPQ+SeeJp5lnZTiYc+gMrIiEJAOxLqGmYgmDuqRUEyqG24LyjtENHlP
	BAT6DV3q3eAWnZRLhAUHn6MzQikZua5TEeejBnKgvGxUB46s1j4QI9KFZBt55LBy
	EPZcqSV9rN2F9tIso8dtG1o/CyUtmCOVpuHSdq84JicTBLHe5CJHu7M1gB1Pr+YE
	GmLXEFE+joIUB8f2ObJ8Q2ygFqJXfryQPennkyOYoiRpGPYM4kungQtXOumjLJLr
	/1PNmimP3pMHpE2i67u8LbxHr9P85kmzceOoDxXg/+4Ds1RaafIgY4jeJ5f8sQgX
	5zqjsirQbUOERYaodPcvhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763148178; x=
	1763234578; bh=JferhuNREwt7Stc1JX9hSy+67l62dc05u8MytTnQtho=; b=b
	2NYDn2+ruZzqNu0Ln5yAVxpLv+BqGwb50pTorOCTfW7SsgQZLXSUFucmJP4q8H2D
	DlEdbDU2omeRBT2MhNsTsF3xJ0jPDATSSuFD/OwfgjZemFCdix54dZ7eWsAaNbYo
	7vT2ggwqgG8kCeP3IyB85pzyUt/j/wKjkG4Q62zypZF0gfL1aCoxgYjb9/ZPruDh
	CXhUxlyb/5HPE6wdTSZJckR8HLb6gB5t9kdFG50NA6zrzpmncBhc98Bs6pWQW+gT
	uMevOXAZBxm7PD3k485bIeeYM6OUvJ8Bxrz9G7+VSWvxWYiCCwvYwwXHyv1cHGcn
	+bYvpoD4/pcJmPdlaGHLQ==
X-ME-Sender: <xms:kIEXaVyHthZx0DBDznyALZnijwsuODUWd7sPdRp2PemDSjsLpKwhXQ>
    <xme:kIEXaeqVigtu3hRWyU7OclGPLKszyI7k9EgA_udHTbRJCYJ9heSUsxfEdjhGTMmoR
    vt603VGyGpN7SPrgpx9o1E_54ZeWLiK66iqv6M17VBVXUqptViipw>
X-ME-Received: <xmr:kIEXaX1OaVzFKr5ZkyYqBzR53U8ZkRnjybg53NPS6iFD_txKhrWKEsc8m4eHyXlbZbfnXHQTvrZ1YGpT8sPXPJBogsVkgu3cBdhi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddtieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedujedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepfihorhhlughhvghllhhordhnvghtsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pegrshhhsehkrghmsggrnhgrrhhirgdrohhrghdprhgtphhtthhopehmihhkvghlrdhfoh
    hrtggruggrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrlhhfrdhthhhivghlohif
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpd
    hrtghpthhtohepsggrghgrshguohhtmhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:kIEXaXA3z_KWv-CfIhnQscJWB5Fjs7RWqvi-BC7xGaBdf5lvJkOTMw>
    <xmx:kIEXaYNA9qcTI2z7X37Iy_WvIWCBjhV90a_enDL6q2QLpr-YX2eQZg>
    <xmx:kIEXabTzFILd4JIURx2d_fEjoaF5KwtFQAu78HQ1Zzxcvriv1_dxCg>
    <xmx:kIEXaQ4exbH_ytzJLE2AiyRBPwuFxDRB98ZroGIiXDTFraeaKOuQ9A>
    <xmx:koEXadhy447IXAIIE8ku4-oDvlmTa8FeL9cGPo9p7il6S0oGUCx3fXc4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Nov 2025 14:22:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Git List
 <git@vger.kernel.org>,  Justin Tobler <jltobler@gmail.com>,  Alexander
 Shopov <ash@kambanaria.org>,  Mikel Forcada <mikel.forcada@gmail.com>,
  Ralf Thielow <ralf.thielow@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,  Bagas Sanjaya <bagasdotme@gmail.com>,  Dimitriy
 Ryazantcev <DJm00n@mail.ru>,  Peter Krefting <peter@softwolves.pp.se>,
  Emir SARI <bitigchi@me.com>,  Arkadii Yakovets <ark@cho.red>,
  =?utf-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>,  Teng
 Long <dyroneteng@gmail.com>,
  Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [PATCH 0/2] Fix misaligned output of git repo structure
In-Reply-To: <CANYiYbGyGKy=S6a3NJFyrv-bOZos+BXdR=nPXDT3W_dGxeiNPA@mail.gmail.com>
	(Jiang Xin's message of "Fri, 14 Nov 2025 17:52:34 +0800")
References: <cover.1763098804.git.worldhello.net@gmail.com>
	<8cb5d668-783f-4400-89b4-35054a6cbea0@app.fastmail.com>
	<CANYiYbGyGKy=S6a3NJFyrv-bOZos+BXdR=nPXDT3W_dGxeiNPA@mail.gmail.com>
Date: Fri, 14 Nov 2025 11:22:54 -0800
Message-ID: <xmqqecq0ifld.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jiang Xin <worldhello.net@gmail.com> writes:

>> Is `Co-developed-by` supposed to have a different meaning than the more
>> common `Co-authored-by`?
>
> This is a very good question.
>
> **Background**
>
> At Alibaba Cloud, our development team uses a variety of AI coding tools,
> including Cursor, Claude Code, Gemini-CLI, Lingma, and Qoder, etc. To
> measure adoption—specifically, how many developers are using AI coding
> tools and how much code is AI-generated—we needed a unified tracking
> mechanism compatible with all these tools. I chose to implement a git
> commit-msg hook that automatically detects the AI coding tool responsible
> for a commit based on environment variables at commit time.

In other words, addition of this is solely to help corporations like
Alibaba to measure which AI tools are used (and what correlation
there are between success rate of the patches and the tools that
generated them, etc..

What is in it for us?  What benefit are we getting in exchange for
tolerating these additional trailer lines in our log messages?

A few random thoughts about generated contents:

 * Disclosing the tools that were used during the development of a
   patch is a good practice in principle, but this is not limited to
   use of AI tools.  We have fixes for issues found with existing
   Coccinelle checks, sanitizers, static checkers, and it is the
   usual practice for the patches that fix them to disclose how the
   author discovered the issue.  When making mechanical replacement
   changes en masse, it is the usual practice for the patches to
   describe what scripts were used to make the changes in them.  But
   we do not dedicate a trailer line for such a disclosure, and
   there is no reason why AI tools has to be treated specially here.
   Instead of "Co-developed-by" that only tells what tool was used,
   why not disclose what prompts (again, somehow AI tools are
   treated specially here, too---we call the input to these tools
   "scripts" when the changes were made with sed or perl or
   coccinelle) were used?

 * Whether some or all contents in a submitted patch were generated
   by tools, it does not change the obligation of the person who
   submits the patch.  They need to make sure that the changes are
   reviewable, its goal and implementation are described in the
   proposed log message appropriately, the updated code does what
   the proposed log message claims to do.  They need to make sure
   that they have the right to contribute the patch under DCO, and
   sign off their patch accordingly.

 * What is made more difficult for a submitter with AI tools is that
   it is often not obvious to the human developer how much of the
   tools' generated output is parroting what the tools saw during
   their training session, and what the licensing terms of these
   training materials are.  Even if a hypothetical AI tool were
   trained only with BSD licensed material, the output from such a
   tool is likely to hold you under certain obligations like
   including the original copyright notice, but without the tool
   disclosing to you the human developer, you do not even know whose
   copyright notice to include.

 * Worse yet, the above difficulty is only for the submitter of such
   a patch, not the project that, trusting what the sign-off of the
   submitter certifies, reviews and accepts such a patch.  It does
   not make any difference if the original submitter copied and
   pasted proprietary code of their employer in the patch, or
   included code that AI tools "borrowed" from elsewhere without
   following proper procedure to honor the licensing terms.  In
   either case, the project may have accepted what was stolen
   without knowing, and it is very likely that the submitter but not
   the project is primarily held liable.  In a sense, the project
   would be better off if the patch does not say it was generated
   with AI tools---if the project does not know, it cannot possibly
   held liable for it, even though the project will have to waste
   engineering resources to rewrite or remove the remnant from such
   a faulty contribution.
