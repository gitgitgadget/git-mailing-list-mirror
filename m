Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0EF241665
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755617759; cv=none; b=oW1Fsl2VtgM2wU6t6Gjg9Ngc9xJY0JwfKJPRp9IbD1ypZyVGbl3+GHQ7Z5nxj0EMhvvC4HJeR4ISXEtmAHC7Txto5sa2px7K0Z2JisNGEQc13sNB7GQMiEiM+Ge+wV7SQ0djcErslLVtGeZYtK4oo4Lc4q8pHgYNaY6DYfUVX9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755617759; c=relaxed/simple;
	bh=1yCmf+Vk7xcuTq022ZyVde08isuasJqoIiHJwSiiT9U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AABKswe/gf1xSjiee/5M4QKZf3bsUc3+S6gCGNJSenrCQQe8GuCa2MciDt9BL2aAlRj9SXoC2vs3F4FYtLGnOTPB0gs7DHi8S/gIZDUmuIVeyE4ZskUnBJvJKBLx8jRLexEigz4MIRV1nX/ziuegNKREo+R4MtZjeWBQSOSaveg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a+jDMvzI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B79KV74q; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a+jDMvzI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B79KV74q"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C3CFE1D001AD;
	Tue, 19 Aug 2025 11:35:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 19 Aug 2025 11:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755617756; x=1755704156; bh=zw5BSM/1yh
	cSOu/Q32dLVDItY9d9lsdDE1jRC/dvUOY=; b=a+jDMvzIxvocN/kXxqFXa5CWp5
	vJVstuVfZpozegKM0KO+gdHPOiygbZapDzE0DfdmYvDkRtGjdcErfqEB8lj9OO52
	9PhMtmBZvYfSxLK2DPV/m9pZRYJterxWffli6U23wHY/93a8RPrvROF6AjjIC+Gv
	di4LFVEvQZM9rBroJLUacd/VRv4zt7JSS+xFH6tFUjk3V7MLqj5N7b4JEnrW9U1I
	ba2XF+2ZURWr3ViQFSifuz44Wz6aoafgXFd3iaJ0ITs1SPCKzX5UydgDQ0t3HmlU
	x1/YuSpCV/CQYhAmyGQqo8iz2FHKS5uN/3ERkSCx9kZnkkz0SYDpX8k8QIZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755617756; x=1755704156; bh=zw5BSM/1yhcSOu/Q32dLVDItY9d9lsdDE1j
	RC/dvUOY=; b=B79KV74qHkBybZS53SGR2WKr5mGijNAUDov5RtmVzMnTSiCAMhm
	yONVDakQGpCtsRU/6qskBiPXoEH76q1zMb/HvQjdH3HCSSFuwiawqRs6HBPdMzlt
	MsTw2UkFQmO3fX3psGCLDK1ImwrrPmG3NYpEWvzCPodoezE/R9GRdTmuKaeh+Yry
	ZrnSUB0WhJdF2bO8PI7nzOu/yu8inCzJTIdAB+pAPE+GkEc+eyz1ar8RZtH/pr6Z
	8ncORPLnPUfTUQDSS/7pvYVBpeVKv/e2u4j3HIo6XkY7CZJ+OSOexSi0h/z8aGln
	40mfGlp/3rgATDd/wFmAAsBeJp9zj40mpaw==
X-ME-Sender: <xms:3JmkaPF7RRgKKJhGaq1_ulFghg8xMi3FSqJXKP5irlusuNqxbyw1yw>
    <xme:3JmkaEym30tS0smCMa8mlDdhSISUCaNG9OSkhemUf2ZUO9xiTrmaR2zb3_UJ3unW_
    zDZD6Nwn3E2Uwqemw>
X-ME-Received: <xmr:3JmkaBmGn1fvhJyAZHUcaEPcCwlvYLBBS4TZTWyP3sYPVnui1jAafWH-pi6OlgxOO_fmYzoavEbHcdwq5z2MMws6YBdgF2kUE1dUI-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurghmseguihhnfihoohguihgvrdhorhhgpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehushhm
    rghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3JmkaNld6FSW3rS8WAGDheurPt8okV7LHfGcOyQzmvOhwRgn0fTDhw>
    <xmx:3JmkaDwKfSzOZQX2Mg6Y8K_SbfJ0bJDY511-nR2jB5D6eIZI0b6AJQ>
    <xmx:3JmkaCq6x80lUQr9ieXOEc54xALROcbX6b-_E0ZZQr_Fws43jIT2yQ>
    <xmx:3JmkaC4E0hhmZJAERNVv465s4UKtZ8TlM2HivwlHGixNjSNuIdxC-w>
    <xmx:3JmkaCcslN1BLm62UVfkM1P9e6OUGCYfWbtggQ-p46FJ21EhfUcViGU7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 11:35:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adam Dinwoodie <adam@dinwoodie.org>
Cc: git@vger.kernel.org,  Usman Akinyemi <usmanakinyemi202@gmail.com>,
  Patrick Steinhardt <ps@pks.im>,  "D . Ben Knoble"
 <ben.knoble+github@gmail.com>
Subject: Re: [PATCH v2] t/t1517: mark tests that fail with GIT_TEST_INSTALLED
In-Reply-To: <20250819074631.3303-1-adam@dinwoodie.org> (Adam Dinwoodie's
	message of "Tue, 19 Aug 2025 08:43:29 +0100")
References: <20250816103656.1693607-1-adam@dinwoodie.org>
	<20250819074631.3303-1-adam@dinwoodie.org>
Date: Tue, 19 Aug 2025 08:35:54 -0700
Message-ID: <xmqqect7fhnp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adam Dinwoodie <adam@dinwoodie.org> writes:

> The changes added by 39fc408562 (t/t1517: automate `git subcmd -h` tests
> outside a repository, 2025-08-08) to automatically loop over all "main"
> Git commands will, when run against an installed build using
> GIT_TEST_INSTALLED rather than the build in the build directory, include
> some extra git-gui commands that are installed by `make install`, or
> credential helpers that might be installed manually from the contrib
> directories.  These fail the test, so record them as such.
>
> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> ---
>
> This re-roll adds a few more commands to those marked as known failures,
> notably credential helpers I see installed in various builds for the
> Nixpkgs packaging of Git.
>
>  t/t1517-outside-repo.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

I'd appreciate these efforts, but I am not sure if this is a losing
battle.  Your ~/libexec/git-core/ directory, when GIT_TEST_INSTALLED
is in effect, likely has old commands that are retired, commands
that are added by third-parties (so that their users can say "git
frotz" and run their "frotz" software), and/or commands from the
future that the running t1517 has not seen yet (while bisecting and
running t1517 from an older commit, say).  For example, I have these
differences...

	archimport.perl
	        citool
	cvsexportcommit.perl
	cvsimport.perl
	cvsserver.perl
	difftool--helper.sh
	filter-branch.sh
	        gui
	        gui--askpass
	instaweb.sh
	last-modified
	merge-octopus.sh
	merge-one-file.sh
	merge-resolve.sh
	mergetool.sh
	p4.py
	quiltimport.sh
	request-pull.sh
	send-email.perl
	submodule.sh
	svn.perl
	web--browse.sh

... in what t1517 $(git --list-cmds=main) sees between 'master' in
normal test mode and with GIT_TEST_INSTALLED set to ~/git/jch/bin
(i.e. the version I run for my everyday use).  "last-modified" is an
example of a new-ish command that the t1517 test being run is not
yet aware of but included in GIT_TEST_INSTALLED.

I am wondering if we are better off skipping this test, or at least
limiting to some known subset (e.g. "git --list-cmds=builtins") to
skip the files on disk when GIT_TEST_INSTALLED is in effect, instead
of "git --list-cmds=main" that is quite broad)?

In any case, this is a strict improvement over the previous one, so
I'll replace and queue this for now, but we may want to rethink the
approach this test uses.  Even without GIT_TEST_INSTALLED, the fake
GIT_EXEC_PATH we use during test has somewhat different from the
real thing, I suspect.  

Thanks.


> diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
> index 1c69d52c76..c824c1a25c 100755
> --- a/t/t1517-outside-repo.sh
> +++ b/t/t1517-outside-repo.sh
> @@ -111,8 +111,11 @@ for cmd in $(git --list-cmds=main)
>  do
>  	cmd=${cmd%.*} # strip .sh, .perl, etc.
>  	case "$cmd" in
> -	archimport | cvsexportcommit | cvsimport | cvsserver | daemon | \
> +	archimport | citool | credential-netrc | credential-libsecret | \
> +	credential-osxkeychain | cvsexportcommit | cvsimport | cvsserver | \
> +	daemon | \
>  	difftool--helper | filter-branch | fsck-objects | get-tar-commit-id | \
> +	gui | gui--askpass | \
>  	http-backend | http-fetch | http-push | init-db | \
>  	merge-octopus | merge-one-file | merge-resolve | mergetool | \
>  	mktag | p4 | p4.py | pickaxe | remote-ftp | remote-ftps | \
