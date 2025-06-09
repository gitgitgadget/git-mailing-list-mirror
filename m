Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A42281341
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749452611; cv=none; b=hawrE+c7EdUWUTjjPXBuANOImefMnXOtNbUqvcfUUF/c++Wm+7POa/0bcZ9u1fBPxvWahhspkBhEvf2xNL0wK+CYeF+VzTKWVn7Yd2mJzLIQdTNX+hmCga2nWgfTKZkrDIuioML3Nv2taqp/gN6KXFOJqxI81St65xr3IsND+MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749452611; c=relaxed/simple;
	bh=PcvgI3orO0UfpjHtsr5NleJJD3h4ur8mMTD2fpmVQqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YxPToRHzvFjJ0/qq0Ooe6btzSATZ86Z+72+nqqA0vs/sh2k54X9bWBFEIMhVay/FaKaUounZOSbcfqaWla+ypOEpD8k9x0sjT3cj30cKgHxjxUfdQp1qjJVknz7L6oaRxJXDc/MHYiYWdhf9AL69qYx7fphBlcEl3NKi+8N2tEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=s6EwV9zj; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="s6EwV9zj"
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 6F17DDF8204
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 09:03:19 +0200 (CEST)
Received: from [192.168.3.191] (unknown [141.255.129.53])
	(Authenticated sender: jn.avila@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id A8F837803A2;
	Mon,  9 Jun 2025 09:03:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1749452591;
	bh=PcvgI3orO0UfpjHtsr5NleJJD3h4ur8mMTD2fpmVQqk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=s6EwV9zj0CHfu9Ma+E52WBUSKqG3hnOpHin1fACdizr3ZsyyD6yvbGJ4YAqnR5EIg
	 jMW7a5lBvk7SDvBqy+tjGt2orGEX64HnCtLyTXaffUOF2sinzzQJv0ya9g3br6TwOg
	 Z3m6TpVszVbcwwwO04WNyEidyrIl7dcBdUb18NmK1hGgmFwkGEBIVHhHYcafH03IxI
	 1RII14QTlw4mijCtrdsPZ7CpewfANb1n85FQEY96xojBM6sr8h3PpGMQV1zHJxkfhh
	 XrC8XoAz6nTqOPsI+KO59DaHQNTuEyeseq548liE6g5UwAFBfuc4w50zfpa3lVzZIy
	 ySBwQKeKTczpg==
Message-ID: <172c7392-71ee-44f1-9d14-f92b1272766a@free.fr>
Date: Mon, 9 Jun 2025 09:02:15 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] diff-generate-patch.adoc: drop spurious backticks
To: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
 git@vger.kernel.org
References: <20250606123138.566178-1-martin.agren@gmail.com>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <20250606123138.566178-1-martin.agren@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 06/06/2025 à 14:31, Martin Ågren a écrit :
> Commit 0b080a70ab (doc: git-diff: apply format changes to
> diff-generate-patch, 2024-11-18) wrapped the ".." in
> 
>   mode <mode>,<mode>..<mode>
> 
> in backticks. Note how the line before is quite similar,
> 
>   index <hash>,<hash>..<hash>
> 
> but did not get any backticks. Remove the backticks, since they confuse
> Asciidoctor.
> 
> The exact failure mode changed with c87b2b3a6f (doc: fix asciidoctor
> synopsis processing of triple-dots, 2025-04-12), and arguably to the
> better. But Asciidoctor (2.0.18) still ends up confused by these
> backticks and leaves the manpage rendering as
> 
>   index <hash>,<hash>..<hash>
>   mode <mode>,<mode>`..__<mode>__
>   {empty}`new file mode <mode>
> 
> Drop the backticks. This is a no-op with asciidoc (10.2.0).
> 
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  The error mode changes between 2.49.0 and 2.50.0-rc0, causing this to
>  stand out in "doc-diff". But this is strictly speaking not a regression
>  fix for 2.50.
> 
>  Documentation/diff-generate-patch.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/diff-generate-patch.adoc b/Documentation/diff-generate-patch.adoc
> index e5c813c96f..7b6cdd1980 100644
> --- a/Documentation/diff-generate-patch.adoc
> +++ b/Documentation/diff-generate-patch.adoc
> @@ -138,7 +138,7 @@ or like this (when the `--cc` option is used):
>  +
>  [synopsis]
>  index <hash>,<hash>..<hash>
> -mode <mode>,<mode>`..`<mode>
> +mode <mode>,<mode>..<mode>
>  new file mode <mode>
>  deleted file mode <mode>,<mode>
>  +


Obviously good. Thanks for catching it!


More generally, this is typically the type of missed changes in
documentation, which cannot be caught by just reviewing a patch proposal.

Thanks.
