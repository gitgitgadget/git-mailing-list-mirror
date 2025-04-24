Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461BBA93D
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745537144; cv=none; b=YyytL1zyLXSHcDqER26iqvd1NoMqhbgzKWsShGLPz4SICKBfoXbm0Zw6hFP9YxrglhiGOJd7querwHi6w3Pdw/2E/Bjf7yThfD5A+Bu3nqZKHELlTMz5KzueQYokK5ziEIJpiLBAlVVexXkn0xmEkpDyI4RYSqzL/OUEsdwAS4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745537144; c=relaxed/simple;
	bh=O6LxLzhWBVH4Deg4vWLkF6KjiWnSZeMXaYcSVbzlGzQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nhJV2DQBGbLep5XlZCG81u1inOIQutxockyht+jxuQTgs472/aWllHfiavrs9INGTWobCHOT/w5pE6ppC9VRZT/002OFm4dEzPp7cEiouV+JR9rirZh55J0Qj5h5BGVZ2P/AXLlIXMFz0ra4KTc2PlL0K1ibI2qy/ZZ9V9ymfyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vmn4h8bL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tuBDWIoz; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vmn4h8bL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tuBDWIoz"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 5A3E01380218;
	Thu, 24 Apr 2025 19:25:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 24 Apr 2025 19:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745537141; x=1745623541; bh=JIGcZ1G7Ow
	TgkCWkbkYtyFGq/cg6/oKcwITp9phwfAw=; b=Vmn4h8bLCq1QuuI6pek3m2QVH1
	7Puy1qciukgihvax3+uHYRzbbXOR3L/MO+I20JbcIjEcPe0CTohdrg6NuWApOuWU
	0mM5VNqbDWSrsiiNGl0AnxkleCDUgyHrcN8hXUT6eUVAXTitpVY3+CeEmJix38hf
	LK/CWw4R+mLLGM8iQSW3AgxRlXH9H32R8g5yGRQYN25FEzz9snHIWKw2lPC20UYj
	lnAWVgKULvWHuLsmHYIvgTRzy5G5UiPJ3wwhl/Dc+8M/z+GE+zRjYdr7rvkr5MeM
	ttp+WdFe05z9oyaj5vlYWSdekfXoPKJfneFwxEtBGfQdVt4ji8waH+7LQScQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745537141; x=1745623541; bh=JIGcZ1G7OwTgkCWkbkYtyFGq/cg6/oKcwIT
	p9phwfAw=; b=tuBDWIozOw1b9+pv8Xx0O/GBmI6bMJOYyopBx3peThzRH2buwus
	evYz0Emq22fVxuWtgqyQf9r7SWp4vJP0i5EZyUYhQjqk8STTP6IF8vP4x5esHNyQ
	A4QlDct8wLSWtu1UPRPd2q0K+3kPtfy+6Kfljx8tXL46WKzhKs7hphs8K3x66jra
	+OEDabZ073BE6GlCcB+WN7yE0HRp/8GTfxg3SxH1PJfSqiHL4VnYBccG68s7JeDQ
	oEcVwuyw+QHq0v5V7ffutVM/oezl1CFBNznU9T/gMGd7OD9UnRxGRMpt9afGkq9C
	1NPiVAjMC+Y6dAT0QT0dCRwN1nob/YMKalw==
X-ME-Sender: <xms:dMgKaO2HSeRS4dGoX0IMxL_0Nv36s1lv1mMqnlr6aSAABXGFBV75gg>
    <xme:dMgKaBHq31-iCUkGZNIWboclQr-lV896xzcYlkC6dVZiqulpMmd4T242dytG5Ijqz
    dkJL5fERCaDxKIQPw>
X-ME-Received: <xmr:dMgKaG5HrntM3iqcPj6CfI-AeVK9TXfTqZMLeSuM0njTcfNZM8T6NuyKKvgXZHnUpyYl39vCSb4uwWgMaw1lMGRVZx_khMyYFByt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrd
    guvgdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dMgKaP2prL82ojV1JxRavujXD9W-nWFwZkhBOkpvRza_w8ihPCmtDw>
    <xmx:dMgKaBFzvRRH4K9SWG_PqdBZk52MTHW0SF4R42KVubUevqiS0iPM2w>
    <xmx:dMgKaI_gnVw2bkEcs_yCKLu72wuUGDI41Kt78WN-njuVKCmQk151Tg>
    <xmx:dMgKaGmoar_FUVoamd5N9agTtB6g5fdX7wfLeljAMs7Uv76ScCIt3A>
    <xmx:dcgKaH1EmR4STAMURhcvKk-vkK6nRt38OvTqOFhBVA6LSlGRhwHOslws>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 19:25:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] fast-(import|export): improve on the signature
 algorithm name
In-Reply-To: <20250424203904.909777-1-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 24 Apr 2025 22:39:04 +0200")
References: <20250424203904.909777-1-christian.couder@gmail.com>
Date: Thu, 24 Apr 2025 16:25:38 -0700
Message-ID: <xmqqikmtrvkd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> This is a follow up from cc/signed-fast-export-import that was merged
> by 01d17c0530 (Merge branch 'cc/signed-fast-export-import', 2025-03-29)
> and introduced the support for signed commits.

I've looked at it and tried to test the result of merging it to
'seen' locally, but for now I'll eject it from 'seen' before pushing
today's integration result out, as the local tests seem to be
failing (and even though I haven't had time to positively identify
this patch is the culprit, as nothing else is affecting fast-export,
I'd need to move with an educated guess and then dig deeper later to
keep the other topics moving).

Test Summary Report
-------------------
t9350-fast-export.sh                             (Wstat: 256 (exited 1) Tests: 65 Failed: 11)
  Failed tests:  24-25, 29, 31, 33, 35-37, 56-58
  Non-zero exit status: 1
Files=1021, Tests=31986, 646 wallclock secs (16.20 usr  5.76 sys + 1053.65 cusr 8317.02 csys = 9392.63 CPU)
Result: FAIL
gmake[1]: *** [Makefile:78: prove] Error 1
gmake[1]: Leaving directory '/usr/local/google/home/jch/w/buildfarm/seen/t'
gmake: *** [Makefile:3287: test] Error 2
