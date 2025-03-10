Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E6C1E519
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621251; cv=none; b=ItubWYMt29RAzt192c6EejUxWkoAZ8p0KfQ6ggiOSwd3XGUnOhGow3EgYRQ5qdeNXvD+U6np4VKfgYlzE7r9oEIOM6YqJ7vdTOzUyhyUAuYBSL4qh+0hX84XZ8bzMvxFbrapYbbqQqKD6P2J4Gl2yfZIst0cK8dHdW5hYjToafQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621251; c=relaxed/simple;
	bh=42Z4Z+s/DHVe1lqc7BWxFL5uZD4hemfdXA/DbR0hZy0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WwnKvZvxPHNO9pSLzd/ReifVhlxQ2NboQa3RF+USplljLRsMYWcxzCm1BJswVV2QZ8DsIF4/BCc+Tjn8crPWdPVUNPZ9PHeGTfhThOGBu64uzkRyHRNPuYPyo5GxmidtEnTqjbELK7CfpCL9ZdmkpTYg4mwsfZOSjUe7C0gobjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eXayTApW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=17Pjh3JC; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eXayTApW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="17Pjh3JC"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 829C01140107;
	Mon, 10 Mar 2025 11:40:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 10 Mar 2025 11:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741621248; x=1741707648; bh=PMZIMWps2c
	M8k+wkRZaP8QrdSINDJ+VnuxcI3AI+avs=; b=eXayTApWTY/mlwm3ZobjoBVWcn
	4a4EG4v3Ud0OSQECTlNFondFGrJaxvEqKPYAhYvsvW1VUOM0YXPnBlBe+kox4miX
	UIXHGjiUi+XR9s4letJtEjdIY3dVh7QEZJPmvKIUs+0ZTuAYt3/3F2RCcqs/gSBn
	TfELNOV1Ngfv6GqRoHgghOZAfDtOzHdvyDbuvAgteaY+kbr6ZzYHc9wsYGoruzHk
	nNsuvyQd04FkjnILaK522hQUsa3UWssuDmZfSgHy4iyJtV94IXQzEbO7jcXDaJZY
	Xp1jBhED6mYlK2SZzTxWf0GGfIMBF5X6eokou83ERRqj0QdbkU3IHznYdlSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741621248; x=1741707648; bh=PMZIMWps2cM8k+wkRZaP8QrdSINDJ+Vnuxc
	I3AI+avs=; b=17Pjh3JCPiIb775raSFUqyyP1C8WoLVmY14i4Qld3YShOSgMRRn
	2yK30cJxjj2EiIL+qNt5MzhC4BrX1XLGXpkdZ8bNoOXCfwoSt6Jgqga/FK3frlsL
	XFielRv8saQqeiRYGBTTSP6tBiyk5yFawQYMEHW64p6CctVBpSQzUL983bs9bo16
	uI6YkLhnv8elZMRa24hNqlD7nSQz6ETO6C6HCf0wczFYzVEDAjNlOhzlwW/G6E6o
	GhOLBuoaZfbuuKx0ST+36s9evYq//3X0ON5My0/9/gH0fU2qv/wkXrnb1TnPCo8X
	luKc1w2oSYPMl/jySReD9zF++c5CmCNSoHQ==
X-ME-Sender: <xms:AAjPZ2Lbyft4nAGSuC1knsQFPS0wR_PNWOnlONaXahTtJr8H1S3_sg>
    <xme:AAjPZ-KQWhI-sWCzdINJ2lxi8LdeMSSyfuinoA0s0nyrWsst8UEu-6eoChhuSjzcp
    5W7zTJva0s1ZZw2Qw>
X-ME-Received: <xmr:AAjPZ2sUc7IUyrbMGsrKj7v2a1-xVKA6TlVTOyednMrj2glayovU6-c0CDTbDlxc8xh9hzsogiT69lAMiVFCz3wMAolFzrvqASoz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudeljeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfefgvdefudetudekteetveehiefgvddt
    jefftdekfeejffeghffggfeggeeffeetnecuffhomhgrihhnpehmrghkrdguvghvnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrghrthhh
    ihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhl
    thhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:AAjPZ7Y_30AnndhIAIefTF-O1bqlrNBa6diqRwdXVmb0SX2HDg_vOQ>
    <xmx:AAjPZ9ZoV_4QCVeQHw-ctyYiRWwlUoJcvXG2tD2m_CMIY1wDKeamEg>
    <xmx:AAjPZ3CDlo2ilSfmK9okOLKc8E4fcvJekLh9Ye5VEDrY8oFZ04VfLA>
    <xmx:AAjPZzYoCkE6JWvjxsWrfqiv4Ev4H7IVYjYxalR_egatsMqx3-O4Bg>
    <xmx:AAjPZ54X8rbV5VBn27s-B3ePQ2PojUT4S6i689_MpM8PHL7li9ejudWd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 11:40:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  jltobler@gmail.com,  phillip.wood123@gmail.com
Subject: Re: [PATCH] config.mak.dev: enable -Wunreachable-code
In-Reply-To: <20250308032309.GA584028@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 7 Mar 2025 22:23:09 -0500")
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
	<20250305-245-partially-atomic-ref-updates-v3-6-0c64e3052354@gmail.com>
	<20250307195057.GA3675279@coredump.intra.peff.net>
	<xmqq34foefh8.fsf@gitster.g>
	<20250307225444.GA42758@coredump.intra.peff.net>
	<20250308032309.GA584028@coredump.intra.peff.net>
Date: Mon, 10 Mar 2025 08:40:46 -0700
Message-ID: <xmqqfrjkao75.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Fri, Mar 07, 2025 at 05:54:45PM -0500, Jeff King wrote:
>
>> However, clang does implement this option, and it finds the case
>> mentioned above (and no other cases within the code base). And since we
>> run clang in several of our CI jobs, that's enough to get an early
>> warning of breakage.
>
> Hmph, this might be more trouble than it is worth.
>
> After correcting the problem in the refs code, the osx CI builds (and
> only those) now fail with:
>
>   run-command.c:519:3: error: code will never be executed [-Werror,-Wunreachable-code]
>                   die_errno("sigfillset");
>                   ^~~~~~~~~
> ...
> I guess a knob-less version is:
>
>   errno = 0;
>   sigfillset(&all); /* don't check return value! only errno */
>   if (errno)
> 	die_errno("sigfillset");
>
> which is subtle, to say the least.

Bah.  This is just as horrible as some other warnings that are not
enabled by default.  I guess we should just be more vigilant X-<.

Thanks.
