Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751871ADC9D
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738428482; cv=none; b=W3qz7B9HMwaer/ezlWl/EcKT53wqNTIUFoG7FstlBwRVD4JLfZDiJCy7tQqoZDOZceZed+O4B1VBtBOJG5uaBPVdQDFFIt9w1FTisdWLU2rjLvCzbyD7mbn2phjixdB9bRSKxNhTz19lWAPwOwCn2NplihGKjA83gEPqinFyWcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738428482; c=relaxed/simple;
	bh=vnTZEbQ7B7IdPv01m9aeP6t1+7VH0nUqippiOHIVv2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bC6prbP/UV3pkUoqy2K1qV1Wx8yh3c9NSJpearsRf5KTm/sjSWkxWfGhGqrYnVL5rpVWQ+hdIIOljqsanG0/v/ZnGepCQs2Avwmm8vA1BSDsX6YoV/CVAfnkT6/gqJLOPT07XSP0KBE+mE8v0JBQO0gk/rhY3lJxlaCHf65wCuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=fdfUWwxe; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="fdfUWwxe"
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id A28BB83542F
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 17:47:50 +0100 (CET)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:f89b:5f6f:dbed:efce])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id B8BC713F8B9;
	Sat,  1 Feb 2025 17:47:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1738428463;
	bh=vnTZEbQ7B7IdPv01m9aeP6t1+7VH0nUqippiOHIVv2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fdfUWwxejEYvGlJ0yvNDs6ThTSzlPV+GBDtdNAYrKEE24w7Qs0nAOj3mBWLWoPEgq
	 lQRbL8ePzPeeaT3EAz+avYlfwAoOI22kI44pMIdLoy0VUlD0xu+6UplnbviceaQQ5R
	 1TCY51H5T6Stnym5CU0c/qyO1WSx6dkIbGUXW7siXNDA/D6xu8prz8wX54NRddACis
	 UBKmC1En/yq+ALROGOtgDXD3K+XbWaA7LiMzh2IWmji6JQ/nkNMTGYzfPulZG+6RrO
	 4yasXgv4GrNZwCRl1pVSYoP/Eowsxu33EpzS3XESF5X1a6RsRi7u6iJx2ap2NCqXDy
	 dRiG2i0fGJdiw==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
 Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
 Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v4 2/6] clone: make it possible to specify --tags
Date: Sat, 01 Feb 2025 17:47:36 +0100
Message-ID: <1911002.tdWV9SEqCh@cayenne>
In-Reply-To: <20250131-toon-clone-refs-v4-2-2a4ff851498f@iotcl.com>
References:
 <20250131-toon-clone-refs-v4-0-2a4ff851498f@iotcl.com>
 <20250131-toon-clone-refs-v4-2-2a4ff851498f@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hello,

I'm only reviewing the doc part.

On Friday, 31 January 2025 16:30:30 UTC+1 Toon Claes wrote:
> Option --no-tags was added in 0dab2468ee (clone: add a --no-tags option
> to clone without tags, 2017-04-26). At the time there was no need to
> support --tags as well, although there was some conversation about
> it[1].
> 
> To simplify the code and to prepare for future commits, invert the flag
> internally. Functionally there is no change, because the flag is
> default-enabled passing `--tags` has no effect, so there's no need to
> add tests for this.
> 
> [1]:
> https://lore.kernel.org/git/
CAGZ79kbHuMpiavJ90kQLEL_AR0BEyArcZoEWAjPPhOFacN16
> YQ@mail.gmail.com/
> 
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  Documentation/git-clone.txt |  7 ++++---
>  builtin/clone.c             | 14 +++++++-------
>  2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index
> de8d8f58930ecff305f79480b13ddce10cd96c60..99a9222e63429b3447deb3e7c08962d4ec6
> 0a295 100644 --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -13,7 +13,7 @@ git clone [--template=<template-directory>]
>  	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
>  	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference 
<repository>]
>  	  [--dissociate] [--separate-git-dir <git-dir>]
> -	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
> +	  [--depth <depth>] [--[no-]single-branch] [--[no-]-tags]

There's an extra '-' : it should read '--[no-]tags'

>  	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
>  	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--
[no-]reject-shallow]
> [--filter=<filter-spec>] [--also-filter-submodules]] [--] <repository> @@
> -273,8 +273,9 @@ corresponding `--mirror` and `--no-tags` options instead.
> branch when `--single-branch` clone was made, no remote-tracking
>  	branch is created.
> 
> -`--no-tags`::
> -	Don't clone any tags, and set
> +`--[no-]tags`::
> +	By default tags are cloned, and passing `--tags` doesn't change 
that.
> +	With `--no-tags`, no tags are cloned, and set

Better keep and start the description  with the imperative mood , as in the 
previous version and add the "By default,..." at the end of the description.

>  	`remote.<remote>.tagOpt=--no-tags` in the config, ensuring
>  	that future `git pull` and `git fetch` operations won't follow
>  	any tags. Subsequent explicit tag fetches will still work,
> diff --git a/builtin/clone.c b/builtin/clone.c
> index



