Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431DA340DAB
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768046708; cv=none; b=Q814/hG7p3AObdahrcsLYIgKrj+zxqVHXs1mYrSzV2m3HwMmwuEuDvOQc+fZL76DQwAIFN6xcCB5zqRu39HyAJRd3Ay4XiCslcY4DDn2B5qunI+yhB7dt0kcSzzanz3Sw8VcZydlWGdIOESKjGocK7mAOCVj4uFjDmJYytsrbRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768046708; c=relaxed/simple;
	bh=ZGvtxvUIGPHq9zGDTJkZUNZrLc9TFXaECryJqjsJnOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FN6va1R1MOTxL3EpEHmDESvOyQn9/pp2VpEZ0Qp7lBJ7zsgiHSSasirQaoGC+xlIkPVj70Tc9qzHtbm3ik5O+ulIltXo1UAJ5kk4KWNaWaexjwgUCuNKMzgVQhP3orKxp9xx6PuNNw4tdoZrYAgDOMwx73U0cKfNPdtbGix7lAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id CB27FDF86D6
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 13:04:54 +0100 (CET)
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:d1:f360:3d51:7a10:3981:3744])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 24478B00565;
	Sat, 10 Jan 2026 13:04:41 +0100 (CET)
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <avila.jn@gmail.com>
To: git@vger.kernel.org, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com,
 Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: Re: [PATCH v3 2/2] repo: add new flag --keys to git-repo-info
Date: Sat, 10 Jan 2026 13:04:40 +0100
Message-ID: <12814829.O9o76ZdvQC@piment-oiseau>
In-Reply-To: <20260109211554.90828-4-lucasseikioshiro@gmail.com>
References:
 <20251207190532.67107-1-lucasseikioshiro@gmail.com>
 <20260109211554.90828-4-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 9 January 2026 21:31:53 CET Lucas Seiki Oshiro wrote:
> If the user wants to find what are the available keys, they need to
> either check the documentation or to ask for all the key-value pairs
> by using --all.
> 
> Add a new flag --keys for listing only the available keys without
> listing the values.
> 
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
>  Documentation/git-repo.adoc | 11 +++++++++++
>  builtin/repo.c              | 32 ++++++++++++++++++++++++++++++++
>  t/t1900-repo.sh             | 34 +++++++++++++++++++++++-----------
>  3 files changed, 66 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index fa0e6600af..4471816cc8 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -9,6 +9,7 @@ SYNOPSIS
>  --------
>  [synopsis]
>  git repo info [--format=(default|keyvalue|nul) | -z] [--all | <key>...]
> +git repo info --keys [--format=(default|nul) | -z]
>  git repo structure [--format=(default|table|keyvalue|nul) | -z]
> 
>  DESCRIPTION
> @@ -47,6 +48,16 @@ supported:
>  +
>  `-z` is an alias for `--format=nul`.
> 
> +`info --keys [--format=(default|nul) | -z]`::
> +	List all the available keys, one per line. The output format can be 
chosen
> +	through the flag `--format`. The following formats are supported:
> ++
> +`default`:::
> +	output the keys one per line.
> +
> +`nul`:::
> +	similar to `default`, but using a NUL character after each value.

We use the placeholder format for character names: _NUL_




