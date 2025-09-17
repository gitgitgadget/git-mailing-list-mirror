Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A354333AB9
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120865; cv=none; b=P7Msqk0O2ry1pnGWs08wMB5uiuG0t7S6fNchKMEEpfDOo4weIVM9TSwC+r0ZhVCmuMV3berR4o6QCLYI088N1YfQI2PLmLpQGGbAORiKEZsmbeMybRtUpLhA5xBUPJ03EwiKfShWtwohQFBUjJhE2zXUWR8wX9PZDro2PJuJ4PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120865; c=relaxed/simple;
	bh=xXBMVnQLDsAeeWSAJhtNtYkT7YIeAO6Yr1wf5Got0tI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=poxftGe7yBJCizDpSZ9L9YhNWanpuuWA+F62GLNMyZa/FESy3ygvEMc1Ig4cpu2fzwGWbBj63PQckBAA77gnqQ0nT7ICOnjfiNkpLw896YRo51HxD3DSS706pzm6tjlROW8pVoG6J0YCVT4O1jRuPEa6vCq72RwtUeylp8RYTek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LLei1LyO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IjQ/DDFt; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LLei1LyO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IjQ/DDFt"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F235B140020B;
	Wed, 17 Sep 2025 10:54:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 17 Sep 2025 10:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758120857; x=1758207257; bh=Ew9zrdZLzK
	1+0iFBaaO91sSdWD5ywbJvchZ7i5Y6VZ0=; b=LLei1LyOXvotkJCjZQuJdfbvmc
	UinoYYfdU/soeGbOdsu3Kqb0KNAekZyhKUVwxjqXYpsAtb++dXlLJ+KZRaQ9eEpC
	Wb761j7CpLangEE9ZVC0xPccnJHA0lS6tARUO6EaLPs54xviMwRyIm82TW7Jw/WT
	qGHUnjZya4dfQ71rBMsrqSJSiKppX0bpoAP9/TUNxkzqB0aEtARUyBU2kx2os0H+
	T3XVKJw4W9H3MnqN92HDLyDjCdy9YeGLvkfS05I8SOv7JruHX1LtImNgAJlcqgWj
	ZPChASBQfTASF0SyouQ/Jw1nuTcyjUxxBjr+/A1t87mmR41WRsHS4bWKbpsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758120857; x=1758207257; bh=Ew9zrdZLzK1+0iFBaaO91sSdWD5ywbJvchZ
	7i5Y6VZ0=; b=IjQ/DDFtiNJXqdu2yLM2WxsYhx5cmb/D2DsLsSk6GKm+OQd0cBy
	uVXDdmdXsKXUDMCtqxLz/X4hVeL5zzGJCcNUXinEhlzJQzcLiwODs8wcdgPYSP37
	l3RAZ6ZwIHkrAZswZsV0lWR0QuI3BP0VQ0HN4uH1biyfFPGUWRyOZ9+xoN2XHagl
	/kqkaq+XvgKXqiCBy1as3NJ4kAcFzUv0yV1dtWMrmfEQyRYAQ0D/X211qEKkeyIE
	bqS6saaHmz/1bD0iX2F5tzb595ti9ypAGbNugotRRbGIM8vLUiMZ7jSOkt+FzpUB
	pMjUzTgKtT5BY5nZUaMt7HkDMIeCbmqrUiQ==
X-ME-Sender: <xms:mcvKaCvxxNp3NfXJ6Xi5_5afyc3B1FIBqHDAMW_3X8ti0g7ANUkeJQ>
    <xme:mcvKaC_kPVdvREqh7rQIgHwUAxrPycRlB4GBkcT08D0ZE9DsR_F2EMZCXjqF4IRgN
    1fYQASjwZaSjm4X7Q>
X-ME-Received: <xmr:mcvKaEOMUWOP-QqNFlEOy2JGhF-oQgbLwzxdJYBVkWnriQx-DcizYzeI-DPcySu5lP3-hIES4FohksDVjpqAfNemWPxHC3DluD5uBsM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtoh
    hmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegviigvkh
    hivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:mcvKaIGnlioXXdzNTMM4ygurYsWUgiigh2Jh_VFKu4GF7W-hbMi0og>
    <xmx:mcvKaKSRi8mjKJ3RXZcZWlzKxf4FTtKZqgBxiCR8U13jgCMbMCDClw>
    <xmx:mcvKaNuirwY9jE0tdnLKCrhX3RKC3Vvh0pESD7JTDzbqpjOK2ZtMSQ>
    <xmx:mcvKaKJabqgHJXBD1pppvzHLIXzwguvhFvO20rzxbUH271OReReP6g>
    <xmx:mcvKaEYB_8i6okg8zk7pll_qeNnCrQd92DY00lbkOCgsU1F-mfeT6bkY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 10:54:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 07/18] build: introduce rust
In-Reply-To: <CAPig+cS_=YTBaCjn8-Th3yn3_k+a8_pMOmdv_Dq4S0tfp8BRCg@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 17 Sep 2025 04:26:16 -0400")
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
	<6032a8740c0ba72420f42c3d8d801e1bdeec12d0.1758071798.git.gitgitgadget@gmail.com>
	<CAPig+cS_=YTBaCjn8-Th3yn3_k+a8_pMOmdv_Dq4S0tfp8BRCg@mail.gmail.com>
Date: Wed, 17 Sep 2025 07:54:16 -0700
Message-ID: <xmqqh5x1f7tz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

>> diff --git a/.gitignore b/.gitignore
>> @@ -254,3 +254,6 @@ Release/
>>  /contrib/buildsystems/out
>>  /contrib/libgit-rs/target
>>  /contrib/libgit-sys/target
>> +.idea/
>> +/rust/target/
>> +/rust/Cargo.lock
>
> Is ".idea" directory detritus from your chosen editor? If so, it
> probably ought not be added to this list since we don't otherwise
> ignore detritus from foreign tools such as that.

I knew that the above was our official stance but somehow thought
that we loosened at some point to add common ones like *~ and
*.sw[op] to make life simpler for majority of developers.  But I was
wrong.  We do not even have *~, which means we haven't officially
loosened.

But there are oddballs that violate this policy like ".cache"
introduced by a5c01603 (gitignore: ignore clangd .cache directory,
2023-08-04).  Three are many other that are *not* our droppings,
between /.vscode/ to /contrib/buildsystems/out in .gitignore file.

    /.vscode/
    /tags
    /TAGS
    /cscope*
    /compile_commands.json
    /.cache/
    *.hcc
    *.obj
    *.lib
    *.sln
    *.sp
    *.suo
    *.ncb
    *.vcproj
    *.user
    *.idb
    *.pdb
    *.ilk
    *.iobj
    *.ipdb
    *.dll
    .vs/
    Debug/
    Release/
    /UpgradeLog*.htm
    /git.VC.VC.opendb
    /git.VC.db
    *.dSYM

Some (like TAGS and *.hcc) are our droppings (in other words, what
"make" with some build targets may produce), but most of these are
tool specific and according to our original official stance, they
should never have been added, but there they are.

I actually do not mind having common ones to the project .gitignore
as long as it does not get bloated too much with droppings from
esoteric tools that majority of us have never heard of.  It seems
that we have been punishing needlessly Emacs and vim users while
being sloppy about others' droppings.  A #leftoverbit may be to
have a brief discussion to gain consensus and add a few common ones
and/or remove too esoteric ones?  I dunno. 

>> +$(GIT_BUILD_DIR)/lib%.a:
>> +       ./build_rust.sh $(GIT_BUILD_DIR) $(RUST_BUILD_MODE) $*
>
> I wonder if this should follow the convention of most (but not quite
> all) other local shell script invocations in the Makefile of
> referencing SHELL_PATH; for instance:
>
>     $(QUIET_GEN)$(SHELL_PATH) ./build_rust.sh ...etc...
>
> with or without the $(QUIET_GEN) bit.

Good suggestion.  This reminds me of my favorite gripe, which is
that "make clean" makes no effort to be quiet by default; perhaps
leaving a #leftover bit marker here would help?

Thanks.
