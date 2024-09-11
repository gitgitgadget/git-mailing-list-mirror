Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6609B2C1A2
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726068528; cv=none; b=DOJ5cUFfcwERWP10f9BwqRmYpDvCe/CCrSvobuZLprlMK4PX9sshO6Mup/wnlMP6aWN+8dcawRTV9gwYnp4OJdZH5n5bT9VEl5BaB173QdxDTaEhNlC+GFYbzojJd5buuSFmJB/ZJLXFzvMZvb99oQY7CC459TBVxN9gyxJhkuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726068528; c=relaxed/simple;
	bh=gXVyFk4p7rIWMwkRcp22HJrL38eMNtXxQT11dHgQNoo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mv7fU0bvqK/m6ThMLupWZhtPZE91epEPfmZk+sT6W/o67ggryOtif+Lzw8eEAMqXnth21Fwtq1CbAWrU4y0IMmvn3l/IZu+rPufLFuQ2M73uXbZpk/IhgBkbaeQUEhE8QGzQt6ed86bfgnFrLwSIF6N3rsY95sbRe+cDNMkxuGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZLRKAK9x; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZLRKAK9x"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A69C20554;
	Wed, 11 Sep 2024 11:28:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gXVyFk4p7rIWMwkRcp22HJrL38eMNtXxQT11dH
	gQNoo=; b=ZLRKAK9xMQVcCJ6fDbC17OsioU00uXiK5wFBEJC9t+7tncGrNEH7DO
	sXgtnMCgxbJa1C4K8WvItrTKPmYxGkkxoPFDfEjrBPN8SSHldo4TbNxI3doGtBSI
	zNXpYwoeAXvf4hpR8qCIUQpl2vWvJVV5j+ubdPMuk3dX86D9NXPoo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3142A20553;
	Wed, 11 Sep 2024 11:28:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 993E020552;
	Wed, 11 Sep 2024 11:28:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Elijah Newren <newren@gmail.com>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 5/9] i5500-git-daemon.sh: use compile-able version of
 Git without OpenSSL
In-Reply-To: <20240911061009.GA1538383@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 11 Sep 2024 02:10:09 -0400")
References: <cover.1725206584.git.me@ttaylorr.com>
	<cover.1725651952.git.me@ttaylorr.com>
	<bfe992765cd562b036cb235dfdddb78f5e662812.1725651952.git.me@ttaylorr.com>
	<20240911061009.GA1538383@coredump.intra.peff.net>
Date: Wed, 11 Sep 2024 08:28:37 -0700
Message-ID: <xmqqr09qb462.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 849F9AA6-7052-11EF-81AA-9B0F950A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> How about this instead?
>
> -- >8 --
> Subject: [PATCH] t/interop: allow per-version make options
> ...
>      imap-send.c to barf, because it declares a fallback typdef for SSL.

"typedef".

> diff --git a/t/interop/i5500-git-daemon.sh b/t/interop/i5500-git-daemon.sh
> index 4d22e42f84..88712d1b5d 100755
> --- a/t/interop/i5500-git-daemon.sh
> +++ b/t/interop/i5500-git-daemon.sh
> @@ -2,6 +2,7 @@
>  
>  VERSION_A=.
>  VERSION_B=v1.0.0
> +MAKE_OPTS_B="NO_OPENSSL=TooOld"
>  
>  : ${LIB_GIT_DAEMON_PORT:=5500}
>  LIB_GIT_DAEMON_COMMAND='git.a daemon'
> diff --git a/t/interop/interop-lib.sh b/t/interop/interop-lib.sh
> index 62f4481b6e..1b5864d2a7 100644
> --- a/t/interop/interop-lib.sh
> +++ b/t/interop/interop-lib.sh
> @@ -45,7 +45,7 @@ build_version () {
>  
>  	(
>  		cd "$dir" &&
> -		make $GIT_INTEROP_MAKE_OPTS >&2 &&
> +		make $2 $GIT_INTEROP_MAKE_OPTS >&2 &&

The build options should be simple enough and this should do for now
(and when it becomes needed, it is easy to add an eval around it).

The use of $GIT_INTEROP_MAKE_OPTS here looks a bit curious.  It
overrides what the inidividual script gave in MAKE_OPTS_{A,B} and
what is globally given in GIT_INTEROP_MAKE_OPTS_{A,B}.

With this design, the following is not what we should write:

    # by default we use the frotz feature
    GIT_INTEROP_MAKE_OPTS=USE_FROTZ=YesPlease
    # but version A is too old for it
    MAKE_OPTS_A=USE_FROTZ=NoThanks
    # we do not need any cutomization for version B
    MAKE_OPTS_B=

Rather we would want to say:

    # the default should say nothing conflicting with A or B
    GIT_INTEROP_MAKE_OPTS=
    # version A is too old to use the frotz feature
    MAKE_OPTS_A=USE_FROTZ=NoThanks
    # version B is OK
    MAKE_OPTS_B=USE_FROTZ=YesPlease

As long as it is understood that GIT_INTEROP_MAKE_OPTS and *_{A,B}
are *not* meant to be used in a way for one to give default and the
other to override the defautl, but they are to give orthogonal
settings, this is fine.

>  		touch .built
>  	) || return 1
>  
> @@ -76,9 +76,11 @@ generate_wrappers () {
>  
>  VERSION_A=${GIT_TEST_VERSION_A:-$VERSION_A}
>  VERSION_B=${GIT_TEST_VERSION_B:-$VERSION_B}
> +MAKE_OPTS_A=${GIT_INTEROP_MAKE_OPTS_A:-$MAKE_OPTS_A}
> +MAKE_OPTS_B=${GIT_INTEROP_MAKE_OPTS_B:-$MAKE_OPTS_B}

Among the variables we see around here, GIT_INEROP_MAKE_OPTS
is the only one that is recorded in the GIT-BUILD-OPTIONS file,
which is included in t/interop/interop-lib.sh file.  Shouldn't
we record GIT_INEROP_MAKE_OPTS_{A,B} as well?

> -if ! DIR_A=$(build_version "$VERSION_A") ||
> -   ! DIR_B=$(build_version "$VERSION_B")
> +if ! DIR_A=$(build_version "$VERSION_A" "$MAKE_OPTS_A") ||
> +   ! DIR_B=$(build_version "$VERSION_B" "$MAKE_OPTS_B")
>  then
>  	echo >&2 "fatal: unable to build git versions"
>  	exit 1

Thanks.
