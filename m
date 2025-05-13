Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8F22BCF4B
	for <git@vger.kernel.org>; Tue, 13 May 2025 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747167243; cv=none; b=h2q5zd/HUR+I8PqKRBdCzelThWh5w+v3rGWsBLI3lfBm3JYiXdwcoFeey+hUz9PMf1MWWd1wsRFLFi+Qu5baw07AtkNaOuBXEt4BuM0oqHcLEbYXB49MDlZKQYi527/3mTltmRbrKmUOdxfv+/Ehe5CP7ytQnqmufzMjkJWJthE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747167243; c=relaxed/simple;
	bh=BkuuqjzvKwNjsWb4vP2PIWlQokcWblxknQybkWNsZoI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LMwgP7a57R7haxMRJq/kpbAvn6gSb6n/aq4aX3yG1yBw4MJ7ffR4lexxkP1exAas2sHzlRBvwA8QsnASsX+xUm6kSQ1Q6OrOJ7B3CGabNGB/wWxTT9XhbON9ksBdr9jsPckif4RsjSpzDiAOMjLGB8AMUpNzS48s0b2CNF4oQFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hsfzMdFm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=coY40K8w; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hsfzMdFm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="coY40K8w"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C817313801AA;
	Tue, 13 May 2025 16:13:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 13 May 2025 16:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747167239; x=1747253639; bh=d3qIDXLVgd
	iEG2NwR9f3oM+RlaTXZHL33Y7NC125lmQ=; b=hsfzMdFm4oGcuWQQM7gZtVeRUw
	yCTI1LO7g6S30wyBf37+eXz8OcXycyS1RYY+nX+toF/4ZFr6xYA0ZiM95Jz9aHyX
	Cais/3x0HAFmtjcalcmQz41FmRRPZGhIA9f9GGUY7WlgYeh9r5uwdbeeMT2AMwYv
	fwgVsiG4QeH/Vdrie/vRG9dPut9KfuiQN7TFKLEVBZkNv3Vgfx36VNhX8ZVnGSSv
	HPxVhT6XJup7mzTZCmqzaLu4KZW6Ic9yZY9tExsYqXip4oDgY6336yrxniLWTYRV
	0UpVk2QKn9DREi8HNoXM10X16gR5//No4NgstKTWdT65OnIS11Wy5lfi3Ukw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747167239; x=1747253639; bh=d3qIDXLVgdiEG2NwR9f3oM+RlaTXZHL33Y7
	NC125lmQ=; b=coY40K8wS9oBTCNANlb43OscoIb2jlSYHlicHAKk8M3qzdlSzor
	xozqWFP7W7P4s9fCaqWCpuR6kVauZqqWOefv2wHGD4AE1yFYaGFAxtjdWAgtjqyh
	rJetEPDO9Nf8PJ0tts6ld8H2QdOEutEtFsClLtHW1RAGPTqSsl3bbqOG4RFrCeeU
	3R/TJaoFuVLa27UsSyv60fmD1HkJ0OpJerJcNDCGY7YOTRIoj3zSx8/haseOQ5JO
	MhYO4cyJ+PwHzWcSBwKLxzEVNn19l0xX4/tLrVFQWB1lYikBeBlzQtYvVydXnbfJ
	wq8o/+zoNq1sh5rYSIpsVDNGLuX1fwgWVdg==
X-ME-Sender: <xms:B6gjaPYCab2a_02UXIlv1KwTw2gCsvvDALk8Ihgaw6dRN_kRKZhSAw>
    <xme:B6gjaOZiHVXzFChTSh3C4aFRcK4aBq0liKx2BfvObd_TA5J45cywa-teuu8wjM-Qa
    RZB3S2iEzlVoCDNBw>
X-ME-Received: <xmr:B6gjaB8Yxjt3MEPnPvegQuXy2vkxOqA7rSN9ZBCIAuiZQ5DG4Tb6h1ykvJuhXEFM-P2ZInxlWaqjJDAcCZiDVMezTzoHOFe8ljuWiJs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdehtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihse
    hrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopegtohhnghgu
    rghnhhhqgiesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:B6gjaFqLe9AAxZa5F2j70IUj8YeGR8_gl7gaGEEe5_PBouovKF2GXw>
    <xmx:B6gjaKr1CIPJ74cvASXkWddooQjBkbs2tT3OQ643iGFnoShfs7PoTg>
    <xmx:B6gjaLTxJT3t3YrzhbnWAX7Rfs27X6q5VUIytxZwI7Co9alpH1HVVQ>
    <xmx:B6gjaCoz3Xys1Z81yLRs4xAFKI07s3IJFDwek5rGWqc0B1wXzJNLoA>
    <xmx:B6gjaMU7dj3ZfP_dN-38T4h1Rr5DoTY9KRhYCJrmAbRnW4oHor-Z8UQa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 16:13:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: 'GIT Mailing-list ' <git@vger.kernel.org>,  Patrick Steinhardt
 <ps@pks.im>,  Eli Schwartz <eschwartz@gentoo.org>,  =?utf-8?B?xJBvw6Bu?=
 =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh
 <congdanhqx@gmail.com>
Subject: Re: [PATCH v2 0/5] miscellaneous build mods (part 2)
In-Reply-To: <20250513191739.1513460-1-ramsay@ramsayjones.plus.com> (Ramsay
	Jones's message of "Tue, 13 May 2025 20:17:21 +0100")
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
	<20250513191739.1513460-1-ramsay@ramsayjones.plus.com>
Date: Tue, 13 May 2025 13:13:57 -0700
Message-ID: <xmqqr00sfeuy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Changes in v2:
>
> Patch #3 is the only one changed (as a result of Patrick's review [0]):
>
>  - add some blank lines to make the option handling blocks
>    easier to see.
>  - add a comment to 'gitconfig' and 'gitattributes' options
>    to indicate the default values.
>
> Note: The indicated defaults for the 'gitconfig' and 'gitattributes'
> are only valid when the 'prefix' option is defaulted (or not /usr).
> Indicating the 'correct' value when -Dprefix=/usr in the comment
> would consume too much space. Is this acceptable, or is it too
> confusing/misleading?
>
> Also, thanks to Eli for testing patch #5 on Solaris and confirming
> that it fixes the regression [1].

Yeah, thanks, all.

> A range-diff against v1 is given below.
> ...
> 3:  fece809f11 ! 3:  a385bbed83 meson: correct path to system config/attribute files
>     @@ meson.build: libgit_c_args = [
> ...
>         description: 'Environment used when spawning the pager')
> 4:  d49afaedf3 = 4:  0d00951475 meson.build: correct setting of GIT_EXEC_PATH
> 5:  69848e557f = 5:  150e4110d2 configure.ac: upgrade to a compilation check for sysinfo

Hmph, For #5 I am seeing this difference:

    @@ Commit message
         Commit 50dec7c566 ("config.mak.uname: add sysinfo() configuration for
         cygwin", 2025-04-17) added a similar 'sysinfo()' check to the autoconf
         build. This check looked for the 'sysinfo()' function itself, rather
    -    than just the header, but it will fail (incorrectly set HAVE_SYSINFO)
    +    that just the header, but it will fail (incorrectly set HAVE_SYSINFO)
         for the same reason.
     
         In order to correctly identify the 'sysinfo()' function we require as

The original comes from what was posted in the first iteration, and
somehow the change is not showing in your range-diff, which is a bit
disturbing.

I think for now I'll just amend the log message of #5 back to what
was in the previous round locally.

Thanks.

