Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55FF5491E
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711222012; cv=none; b=KLBdOKTl22znvFYEm0NP8K5Eyo0+mvfugYEl07DCpNu4MhWMZ7AlIIKXeXRs3YAhc50meegwssyVGWgpUx2xLvMMvXqRePjfY5EvJPOYGqD0QWlyVM25NnyEfs0e89AC+BJ6pR363T4lO/PsfrjVPIJ+6olpXV1YG5yXfbtMKrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711222012; c=relaxed/simple;
	bh=sAqmTTpnc++a9TBjPRgBXYm/UyN77jj/QaKqAyRyRtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1iazQPmEFG5i/JyT5dR8Wqo5BeCy0xsCq4PybPqN2kjjIxCRqbA4mOte9iIWcmymWs8WRhiRWCEJ9HiniQlIudAbZC8rbDxpuZil/HGrfX6OQuh5rziQLzLI3qux+8rgUurC3ldqCp1l2XoIETLH+6SJIMUAkHeaaDma8Sz+Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=OTskkAAm; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="OTskkAAm"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:3559:5be6:8fac:2a78])
	(Authenticated sender: jn.avila@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 99B8219F5AF;
	Sat, 23 Mar 2024 20:26:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1711222001;
	bh=sAqmTTpnc++a9TBjPRgBXYm/UyN77jj/QaKqAyRyRtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OTskkAAmic41Enb7BpkhXVtNLfMvU2ETKLBWpox8sBZVfr3rd4rF4Oz5W4rQBYQms
	 RG1dPVO22u/QKjJUv4zmHenWbccK/NlK+SRdEY24OR7kDE8P0naQPl06pgmjttsh9Z
	 wuHwe4kcIn2POX5cJkkQQIt7K3lRfYBs2S6Wh3vVZQ+2B5p6NlsDnoCnR45efQ1tRN
	 PhlVg1OEOp3Cs5upfucZ9pCeknkSpnGUKS8PkSc7H9pDi7DMjYkGfiShYdYpK4f93E
	 qNv7T0yvjKhLRr9gBdw5dSshTSmP8Ga7fuKL6Bv6LT6/5nCS1/2z9PxmlHXHwQ2yxx
	 TiMoo9ImU5wzw==
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Dragan Simic <dsimic@manjaro.org>
Cc: gitster@pobox.com, sunshine@sunshineco.com
Subject:
 Re: [PATCH 3/3] grep docs: describe --no-index further and improve formatting
 a bit
Date: Sat, 23 Mar 2024 20:26:38 +0100
Message-ID: <6056709.lOV4Wx5bFT@cayenne>
In-Reply-To:
 <264643a638fd1ee9970f96e7aa4914c37e30b3d2.1710968761.git.dsimic@manjaro.org>
References:
 <cover.1710968761.git.dsimic@manjaro.org>
 <264643a638fd1ee9970f96e7aa4914c37e30b3d2.1710968761.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 20 March 2024 22:08:46 CET Dragan Simic wrote:
> Improve the description of --no-index, to make a bit more clear what this
> option actually does under the hood, and how it is meant to be used.  
Describe
> the dependency between --no-index and either of the --cached and --untracked
> options, which cannot be used together.
> 
> As part of that, shuffle a couple of the options, to make the documentation
> flow a bit better;  it makes more sense to describe first the options that
> have something in common, and to after that describe an option that has some
> dependency on the already described options.
> 
> While there, improve the descriptions of grep worker threads a bit, to give
> them better context.  Adjust the language a bit, to avoid addressing the
> reader, and perform some minor formatting improvements, to make it clear
> it's the git commands, command parameters, and configuration option names.
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
> 
> Notes:
>     This patch is salvaged from my earlier series, [1] for which it has been
>     concluded to be not acceptable for merging, because of possible issues
>     with various git scripts. [2]
>     
>     Compared to the previous version, this version continues the effort to
>     improve the description of --no-index, by also incorporating the 
possible
>     improvements pointed out by Junio. [3]  This version also improves the
>     wording of some related descriptions, mainly related to grep.threads,
>     and performs some additional small formatting improvements.
>     
>     [1] https://lore.kernel.org/git/cover.1710781235.git.dsimic@manjaro.org/
T/#u
>     [2] https://lore.kernel.org/git/
d8475579f014a90b27efaf6207bc6fb0@manjaro.org/
>     [3] https://lore.kernel.org/git/xmqqwmpzrqfv.fsf@gitster.g/
> 
>  Documentation/git-grep.txt | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index f64f40e9775a..b144401b3698 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -28,7 +28,7 @@ SYNOPSIS
>  	   [-f <file>] [-e] <pattern>
>  	   [--and|--or|--not|(|)|-e <pattern>...]
>  	   [--recurse-submodules] [--parent-basename <basename>]
> -	   [ [--[no-]exclude-standard] [--cached | --no-index | --
untracked] | <tree>...]
> +	   [ [--[no-]exclude-standard] [--cached | --untracked | --no-
index] | <tree>...]

This change gives precedence to some option in alternatives, which seems 
weird.

>  	   [--] [<pathspec>...]
>  
>  DESCRIPTION
> @@ -45,13 +45,20 @@ OPTIONS
>  	Instead of searching tracked files in the working tree, search
>  	blobs registered in the index file.
>  
> ---no-index::
> -	Search files in the current directory that is not managed by Git.
> -
>  --untracked::
>  	In addition to searching in the tracked files in the working
>  	tree, search also in untracked files.
>  
> +--no-index::
> +	Search files in the current directory that is not managed by Git,
> +	or by ignoring that the current directory is managed by Git.  This
> +	allows `git-grep(1)` to be used as the regular `grep(1)` utility,

Auto-referencing the git-grep manpage in itself is useless.

> +	with the additional benefits, such as using multiple worker threads
> +	to speed up searches.
> ++
> +This option cannot be used together with `--cached` or `--untracked`.
> +See also `grep.fallbackToNoIndex` in 'CONFIGURATION' below.
> +
>  --no-exclude-standard::
>  	Also search in ignored files by not honoring the `.gitignore`
>  	mechanism. Only useful with `--untracked`.
> @@ -248,8 +255,9 @@ providing this option will cause it to die.
>  	a non-zero status.
>  
>  --threads <num>::
> -	Number of grep worker threads to use.
> -	See `grep.threads` in 'CONFIGURATION' for more information.
> +	Number of `grep` worker threads to use, to speed up searches.
> +	See 'NOTES ON THREADS' and `grep.threads` in 'CONFIGURATION'
> +	for more information.
>  
>  -f <file>::
>  	Read patterns from <file>, one per line.
> @@ -336,9 +344,9 @@ The `--threads` option (and the `grep.threads` 
configuration) will be ignored wh
>  `--open-files-in-pager` is used, forcing a single-threaded execution.
>  
>  When grepping the object store (with `--cached` or giving tree objects), 
running
> -with multiple threads might perform slower than single threaded if `--
textconv`
> -is given and there are too many text conversions. So if you experience low
> -performance in this case, it might be desirable to use `--threads=1`.
> +with multiple threads might perform slower than single-threaded if `--
textconv`
> +is given and there are too many text conversions.  Thus, if low performance 
is
> +experienced in this case, it might be desirable to use `--threads=1`.

I'm not native speaker, but I'm not sure the switch to passive form is 
helpful. In Simplified English, passive form is considered harmful and difficult 
to translate because the subject is elided.

>  
>  CONFIGURATION
>  -------------
> 
> 

Otherwise, thank you for helping converge to a more standardized format of 
manpages.


