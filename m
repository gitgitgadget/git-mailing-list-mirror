Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754471BD01D
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740766481; cv=none; b=qTJACE6ROkG1KZY8ByyQsr8vQsIs7qdYKv250XFuRzoBRYlwVLZS3xLloCBrH2Q4xSHqq1uJtYuRexDOXiZ6SzfipWiI4Ms32bgYtHLVAHw3fuhSPIMxvNqu1PIES2r94AduDcfoPa2LtHvS48+KEye6Sw53hJoxcZKNXTXZnQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740766481; c=relaxed/simple;
	bh=/ruscLTOX0vpcBgKn5xhbqhyihxKA2McawiFhhmkZ6U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e4+9qIm+TTY7p5uB1kIDMcjSugDYIIKAEYx5p62lsTRcx9Mcyhnm6RL3GaZNcrwG5wKgz3Tcj/DlIZOhQR6E3FleHzER+/M6w791oSmlt1bWNX/jectCITtITXU46siADkz5ked6EG20o1juw/bh+5cekfW+sIFxhbKSiA0UHu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R/sCe7Fu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nESrv/jD; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R/sCe7Fu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nESrv/jD"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 40C241140140;
	Fri, 28 Feb 2025 13:14:38 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 28 Feb 2025 13:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740766478; x=1740852878; bh=2MDuyDiZws
	UZEasFYBZQRmAqpCkqgYnqmi98nDB/7Ew=; b=R/sCe7FuOkPJlgJJygSfPI+R/s
	WRlMQAGzGLx2BRZMoDPB10hIBaMnrl3XMMeje/kymXc+V41v7DwRN8NJS2IHHDh7
	UlFASoOOV5aQyaptk1wN4VxglVhRzERMXGjNvHSu8KbNwqgqzhP87cPdayR5nENi
	8zx88dqKRhPuwpotL2qg5SQUH0nHGUer8T2TRqRBgUAHVkj5H9vqyAW+16PqcVg3
	4f6LEWd8AaLqJs3yu0St3ihK9174pf4vh2itwWOu6xP8rXAf4kmEFaAUbIz5NEMu
	CF4GTU3yQhF/TuR+BuCZPYKbWSm39dswbMX3z+a3obhRYealOnNYSdIGMI+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740766478; x=1740852878; bh=2MDuyDiZwsUZEasFYBZQRmAqpCkqgYnqmi9
	8nDB/7Ew=; b=nESrv/jDpustzOnv/Y5aqDtsT2eYC/cQF3SW67MxQtho2kkdMED
	aTEoAafVJFEWjdgJc/b9kOoqhLNpH3aJF4cAQR6q64/jw9BLBeD4y5pt7sDDz3+9
	A5ImcEmgrtmXJft1b+vaklsO9pQJpnMQbJuIdZpWEJ+TFm7AT4Hh9+fvIgE4hE0J
	+THfliK1KToEOihJceDcLTM1aCajDaLcHJxxmbtyiN2TUl2sVz0MuGnU8vlX9KW3
	YTeIspjKtvAWjV0haAgiUIL7WyUGSJCerF2dVOuzU6Pll9zmrOk1zGnfGvt0mn6y
	3FaYN5I+5UTj98eJ77yAK9c0CVyhl5fADyQ==
X-ME-Sender: <xms:Df3BZzNVcz39lPXOxPY25odfYRr2xYBPGW5QwyrUjqfrWm18ZYru1A>
    <xme:Df3BZ980odVk2Ejo3j_BJbgqrt9ncLFFrhYkKacjrCQuNBe6ns-iRwPzqm4EgO62g
    dXmoAqGOtGk6c1d1Q>
X-ME-Received: <xmr:Df3BZyQ1GOLwPcNwa4z-Zza7ivKHtS-ZpkdK20MxP-7YYNaeeCn-5Do9up6xU6QnM2tymqUMx83YYfKtw891qmghOzPyiYcfYPNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeluddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhsmhgrnhgrkhhinhih
    vghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhm
    rghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhhvg
    hjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhnhgtrghikeeisehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhi
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Df3BZ3tkIH5uvHAw8VGf__IcGjDUvz4HqW3OzHzYTVMqqGewLXMFMw>
    <xmx:Df3BZ7cOuVUrlOV1EaWrmDWfxK_xRHNYFN58cZRvFM9f7QXJoXGzjA>
    <xmx:Df3BZz1KnoZcXx8itTyVd_WeTsmDgoQnLWH5xvwbZ9VhDbeZAT3wnQ>
    <xmx:Df3BZ3_78VDamxJvu8CzjNMrYRrwvxWTiXrmZhQRL_NWvwoR6TZRFA>
    <xmx:Dv3BZ_6Z0wtkCUkP_qK9-37-IFZu8UeLsl8B_cvNJrKJa5WF2NN1Uibh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 13:14:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  ps@pks.im,  shejialuo@gmail.com,
  johncai86@gmail.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH] config: teach `repo_config()` to allow `repo` to be
 NULL
In-Reply-To: <4e21312d-0d9a-404a-a2e0-0e2fcc681ad6@gmail.com> (Phillip Wood's
	message of "Fri, 28 Feb 2025 10:56:23 +0000")
References: <20250227175456.1129840-1-usmanakinyemi202@gmail.com>
	<4e21312d-0d9a-404a-a2e0-0e2fcc681ad6@gmail.com>
Date: Fri, 28 Feb 2025 10:14:35 -0800
Message-ID: <xmqqbjum2ayc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks for working on this, I like the idea but looking at
> read_very_early_config() it sets "opts.ignore_cmdline = 1" which means
> that this will ignore any config options passed with "git -c
> key=value". I think it would be better to call config_with_options()
> with the appropriate options directly.

hmph.

> For this to work all the commands that run outside a repository would
> have to read the config via repo_config(), and take care not to call
> any of the repo_config_get_*() functions. They mostly seem to do that
> but "git for-each-repo" calls repo_config_get_string_multi() - it
> should be easy enough to convert that to a callback when that command
> is updated to stop using "the_repository"

Well the only reason why we want to allow NULL in repo_config()
calls is to accomodate this pattern, if I am reading the discussion
correctly.

 * A command that wants to run in a repository (i.e. marked with
   RUN_SETUP, not RUN_SETUP_GENTLY) is invoked with "-h" and outside
   the repository.

 * cmd_foo() is called with "-h" option in argv[]; repo is set to
   NULL.

 * The typical start-up sequence for any builtin cmd_foo() is to
   read the configuration and then call parseopt, and the latter is
   how "git foo -h" is handled.

 * Historically, the "call the configuration" was done by making a
   call to git_config(), which used the_repository [*].  But recent
   trend is to use the repo passed down to cmd_foo() instead, and
   replacing git_config() with repo_config() blindly would break
   unless repo_config() is prepared to take NULL.

So, any command that requires to be in a repository would not go
beyond its call to parse_options() when called with repo==NULL.
Either it would have already died inside getup_git_directory() when
"-h" is not given, or parse_options() would have gave the usage
string and exited.

For commands like "for-each-repo" that itself wants to be able to
run outside a repository by marking itself as RUN_SETUP_GENTLY,
they do have to update the code after the parse_options()
themselves, of course, but I view it as a separate issue from this
"we make git_config() as the first thing in everything---we want
to replace it with repo_config()" patch.

Thanks.


[Footnote]

 * I personally think that it is an unhealthy fundamentalism to try
   eradicating the use of the_repository even from the top-level
   calls of cmd_foo() functions, which are like traditional main().

   They are never meant to be reused as a subroutine that can work
   on an arbitrary repository from any arbitrary codepaths.  The
   special repository instance, the_repository, is set up to be
   suitable to work in the current repository, if exists, and gives
   a reasonable fallback behaviour when we are not inside a
   repository, which behaves exactly how we want it to behave there.

   The more library-ish helper functions (I am talking about
   distinction between what is in say builtin/diff.c and diff-lib.c
   here and referring to the latter) are totally different matter,
   of course.  They are meant to be reused and they should be made
   to work on an arbitrary repository from arbitrary codepaths,
   hence reducing the reliance on the_repository is a good goal for
   them to aim at.
