Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7391EE7B9
	for <git@vger.kernel.org>; Tue, 20 May 2025 20:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747773194; cv=none; b=GDKNX/+whau4DqZrK3S1QTIbTfKT8JqNrUZR9CJBVSJ9eoyGZXfmxZl6nrABmYW6apMwRUw8mShaYnL9UOWnWvO2t4NAE7mFpCYHCnNQTfUSPvOPGDYU3TOcNWsg9qpxV0xoM1V4pH2QBOf2cTE4oPJIctLNyVG+qhgtBlK8DJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747773194; c=relaxed/simple;
	bh=IFuQBY1ryuo8fFAI5RwXqSoA1AgSeOFZMDGsWojSaZk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dHHuPTvXfSLWb33gS5D9RIg/twxeaWEqRG9c3knA/BIdSsMa5FAkQES7bgaxaJ6lj0pd5gq88Yq7tGC3/qk+HM8wOotRb43ZDYHegz/GV8MkN2loHe6eQlo1PPbfFFBYI1rD/O583/3acssW95WhetIcjJ5wSIqnqSyYdHBKN5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oPPn9WAb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HH32Lp44; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oPPn9WAb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HH32Lp44"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CA7ED25400B7;
	Tue, 20 May 2025 16:33:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 20 May 2025 16:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747773190; x=1747859590; bh=gFUEdYIast
	/9c3F7sX4rNA1fMv+FTwrJwaIBpJpp+Z0=; b=oPPn9WAbgUcPdBTkEaueaNgtYH
	oQEYS5XHBHNQCbrWJdLfceHaMarmFk71B5QAayvjyqRn1p4ieaNXgFlTflX+dqnf
	tI/Mb0X5ySMNWhUrgkWWYR3bj3k1MOHRARc/X7crGG1naX2zISW7GX2IC7BV5cnq
	M42iQ3FzShfLDAlouHj+RSuYrmlp7JfR3ZnOjPbyAP7w3ixrFjzp1fEuxvOCDi1q
	GmZUrr8ZeyrRWbIJXcNt2mjSQMan06uhwoHaHE09iPxEuG2FMoZvNhEhuzqiBLda
	W65lXECnbPCvflIEj8yrm0hjGbgqY0gi3jPrQmt7e5fEhuzVaBS88Ig1OV5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747773190; x=1747859590; bh=gFUEdYIast/9c3F7sX4rNA1fMv+FTwrJwaI
	BpJpp+Z0=; b=HH32Lp44eFk/1PesbZMafkVDcGf8T+4+RvXvjlCNew+V3PRA9Ln
	HIA677EN2/Zoao9Nj0DEjc0MbWbc0m2r4bTKaLWAmzo9Cghx3Kd782QxE1Vn7wsD
	5M5T0E5H2+Pjce8RgcrXpj/wk1SVQRz6+X7TpFg2gK1C+z015LVV3LLhRgqtLWAL
	V10RShpaPQBEBzRoW7laB4kmdkyPNbSZWnVW1exCntbpzYN6Buuj4yy6ixMVomV1
	83/AgH6DtZ8YmLJM7z+kedIiLQcbdg0F4I+cDVvlbVoLiMpyqdmu7ZSfHMV8WK/k
	YdNY3/cJ0X6oNNT9YI5IbLTn4+XyavaXzBQ==
X-ME-Sender: <xms:BucsaAlc7qUatJN4uFEXMjH7jBs2UIqU9low9lCvqoEGxWbfk_drNA>
    <xme:BucsaP1hb7tPoQlNkNi7RT5VfSAlZgaxgpD0K1U3Xsmwi7dSAvmGKE80YuTmgTD-u
    sQGJKWnd-n7Iu3C9Q>
X-ME-Received: <xmr:BucsaOpeEpPFvYPCS0yT8mFqd-HDAOUs7UtQMpDURxcOyQUtdX6SHLlmcCz24WYXC7KQhuE_ooJ7M_ENml2c1KD08Vkg-hCsOdy2VPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduudejucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnh
    hnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheprghvrghrrggs
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BucsaMkRtNDqxPKALRY0GUyeHS7lHeWllGufAlQhGKfGR74XTdCKGA>
    <xmx:BucsaO3sNZRfhLnfMaf6ruaS-XVtoIi8VrRp_oh4bu-EGqXe_b7O3g>
    <xmx:BucsaDtrNf9RoACXmXn1pNDOInA9Dcu_Lldl5y2ksBGgr3JeixO3_g>
    <xmx:BucsaKU7Fx9yCt1-pXiaUmz0Iv5kc9-UGYhYZdwVWti787aEACMMtw>
    <xmx:BucsaHuGQB_sRTX9TOK1Q7KiYEkOoqitdLqZuonXMADoL6c-Eh0kL7m0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 16:33:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 4/4] drop git_exec_path() from non-Git commands' PATH
In-Reply-To: <20250520193506.95199-5-ben.knoble+github@gmail.com> (D. Ben
	Knoble's message of "Tue, 20 May 2025 15:34:58 -0400")
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
	<20250520193506.95199-5-ben.knoble+github@gmail.com>
Date: Tue, 20 May 2025 13:33:08 -0700
Message-ID: <xmqqy0urggzf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

> We setup_path() with git_exec_path() unconditionally (8e3462837b (Modify
> setup_path() to only add git_exec_path() to PATH, 2009-01-18)) when Git
> starts; as a result, all child processes see Git's exec-path when run,
> including editors and other programs that don't need it [1]. This can
> cause confusion for such programs or shells, especially when they rely
> on finding "git" in PATH to locate other nearby directories, in a
> similar vein as a0b4507ef7 (stop putting argv[0] dirname at front of
> PATH, 2015-04-22) solved.

I can understand why we want to do this for things like editors, but
doing this in start_command() would affect running of things like
hook scripts (which may in turn invoke "git" commands) and command
running on the other side of the pipe that does a local transport
(e.g., "git fetch --upload-pack cmd"), and other commands specified
via the configuration (e.g., "trailer.<key>.cmd") that may in turn
invoke "git" commands, wouldn't it?

> @@ -746,7 +789,7 @@ int start_command(struct child_process *cmd)
>  	if (cmd->close_object_store)
>  		close_object_store(the_repository->objects);
>  
> -	childenv = prep_childenv(cmd->env.v);
> +	childenv = prep_childenv(cmd->env.v, cmd->git_cmd);

Regardless of the answer to the above question, I wonder if the API
change for this helper function should go the other direction, by
passing the entire "child_process" structure to the function.  That
would give prep_childenv() more information to work with to decide
when futzing with PATH is appropriate.  

Yes, I am assuming that the answer to the above question is "true,
unconditionally futzing with PATH is a bad idea" and we need this
fix to be more focused, e.g., limit to "launch_specified_editor()".
If that is the case, we can

 - add a member "drop_git_exec_path" bit to "struct child_process";

 - update selected callers, e.g., launch_specified_editor(), that
   prepare child_process to set that bit;

 - update prep_childenv() to accept the entire "struct child_process",
   instead of cmd->env.v, and base the decision in your logic to
   look at the cmd->drop_git_exec_path bit;

perhaps.  It would give us a more surgical and focused update,
hopefully?



