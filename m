Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A9C4AE8C3
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931849; cv=none; b=nfP1NC2MYbpoy7o8xgwLEOJH5VPyfrpAbQk0L3rXhokKjeywp3FRpRijdm5AWr2qGejs1JTgqHQIH7QoMKlSEhcKVI5+4yw8BW6qYjtSAcFPYmzBrhvB/r0U88tGNNrsBzd/3esRgOwvf0kgIK3Afv+FsWibtyP5nrqctbbGCqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931849; c=relaxed/simple;
	bh=S3p9+isquogY40Q87I8mUwT2JARB83e1dFS8XLNSl8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGMWQgh7TUAbp5Fv/AuE+PY9Rapzi4QLm4BS9Sf1+eP1p5/BOr9SiKmovtQ90QoEzI9zu7rQxSShD/1bjtrgCXc6WgyS/0gtrPeQbUWIvRHpVVD7tr9qS6jX1ae3afogrAko00hBxGAlY54mlCERWrGz2KD9WVGLPFF10fCYg9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYErqk8H; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYErqk8H"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6df7f544919so2341848eaf.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 15:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791931846; x=1792536646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N0ObYYPP0VO2LnZ+ruMAwYdlxiE4dR26ASFYGqk4sfY=;
        b=GYErqk8HQ2D+xGCKrUyQF1FyD6Iqap4/k9qvrAADLnDWdJqWgTP+EbxNzniKdrVrQF
         rWrNYX1ANNouXonXTKucaTLvWUrrNK4PeqeHr1E/LW3pTooT7oPDiOwJ59uP7nljU9Rm
         Y7JQTKivQnGFF2naWm/aTzvo8X7f2s4ZYKk1QjbiEAfkxnXlS9EQexPGk2ozAox5gfAD
         jg6FRH7dWyvRtQQNGk/SVafFAdCuy9VrfpQvb3Fqo9ScVkrVhy+qLGaCkDW0sT1gEQsX
         4cBP9ivbGjcmdBW/0pMGp+yLhphfP91RCQWI9vKPRXP85xpZOOV9jiwKSLxBoKoLbQit
         ciSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931846; x=1792536646;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N0ObYYPP0VO2LnZ+ruMAwYdlxiE4dR26ASFYGqk4sfY=;
        b=LR8JssNeiekSDam9kUvmsffp+5gS8YCdUsTYABU7flRbQOrZ6MHqqRcl/LcJ9nTVe8
         uAlvNqucqxtbcZVOhArdfBvsaWjLtYdh3ybPd6/cSXJm3PSb5iy4Q4EF90juR6NF5I12
         AG2jUSX0zs8jHrTKgtcR1avNp1VZahUK01naUh1RSRtMYS3Hrxz2Du6P5FI/xr3CzNMs
         e/BckGPM11QiGultLlitmcZ7+mzMnSJEpnV4Aw46X2TcYQ+ULnFKrPMYAEcruyYXMDYx
         rwCrpD/9rCT8Due8225uzlpeoya2/289mYBze7kDYPSbg7y49dv2dsT6IuMEj/MfjOBb
         nBeQ==
X-Gm-Message-State: AFq9FYJEpzzORenehUc/IP7EAqo3vZpTCEPTs7sCXDsBAYtQKsC6SQds
	mfF41mfCq2LEFk9jgXMsB8SErGjYz/sfBoajIWPVGJG1UjAu+tKTQ21ifQGNjQ==
X-Gm-Gg: AYBFou1zcceeAEYuXkXiN8XvfkrEGPvBP8DYvn6AoCJ0F3w3KJ7TrBnwAmnR0uPm1uS
	Ae7ysbhy6yMoGcUAomgv3jz5VNuq182wV/ETS1w1uOk+2Y0GvOG854emonE+w1WyTYCMro/K5ce
	OhTph0Gogh2tzv1Jf85TvftCtGuaeb+d1/ocJxj6zaBB4t2ik3SAnc+4flAnUvvCx0aA+i9xBXf
	tXKWpG2lL/zpMqlAR1j/qDHjrNxgSJilpKtDRBwYw5YH9l8NKJWON7eG5VY/jhIws79AaIAOptV
	1iDL1K9muv7FHBWzyMsOBUWu+Mr/du9dp14uOAUzlPJc+5BwQU0f33R19AxW8L90+SfwsQeCn9u
	bPkceBIbsgf6sqDpU4zSS3YNTuLW/X191mSpnWMor0a4qf7kwBhguuLEpP7y9b/XdJINLLukTXp
	6oqjg4sxRyUXMnR+tu6jYJg16jrTmt1PebrKS5t5kYA5DQM0H0vf6Dp9+PHEqwbBbZv6itCz0pf
	CbsG6E++hzbfCxzQsyPfIE=
X-Received: by 2002:a05:6820:162b:b0:6f6:a60e:3675 with SMTP id 006d021491bc7-6f6a62cd9e1mr5378862eaf.34.1791931846345;
        Tue, 13 Oct 2026 15:50:46 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ef03e39840sm12658936eaf.15.2026.10.13.15.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 15:50:45 -0700 (PDT)
Date: Tue, 13 Oct 2026 17:50:43 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] builtin/repo: rename "references.format" to
 "references.storageFormat"
Message-ID: <as61Dh7ui54gdzGV@denethor>
References: <20261005-pks-repo-ref-storage-format-v1-1-819a181572a9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005-pks-repo-ref-storage-format-v1-1-819a181572a9@pks.im>

On 26/10/05 12:14PM, Patrick Steinhardt wrote:
> As part of 2f28db44d5 (Merge branch 'ps/ref-storage-format', 2026-10-01)
> we have adapt all sites that used to say "reference format" to instead
> say "reference storage format".
> 
> One missed spot though was in git-repo(1), where we still print the
> "references.format" key. Fix that oversight by renaming the key to
> "references.storageFormat".

Being that git-repo(1) is a recent command and still marked as
experimental, I think making this change to be consistent is completely
reasonable. It makes sense to keep the naming unified.

> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
> 
> this is a follow-up on 2f28db44d5 (Merge branch 'ps/ref-storage-format',
> 2026-10-01), where I missed this one place. I noticed that only today
> while working on the object storage format extension.
> 
> Thanks!
> 
> Patrick
> ---
>  Documentation/git-repo.adoc |  6 +++---
>  builtin/repo.c              |  2 +-
>  t/t1900-repo-info.sh        | 12 ++++++------
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index ed7d80c690..5af454e8ca 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -119,7 +119,7 @@ values that they return:
>  `path.gitdir.relative`::
>  	The path to the Git repository directory relative to the current working directory.
>  
> -`references.format`::
> +`references.storageFormat`::
>  	The reference storage format. The valid values are:
>  +
>  include::ref-storage-format.adoc[]
> @@ -127,10 +127,10 @@ include::ref-storage-format.adoc[]
>  EXAMPLES
>  --------
>  
> -* Retrieves the reference format of the current repository:
> +* Retrieves the reference storage format of the current repository:
>  +
>  ------------
> -git repo info references.format
> +git repo info references.storageFormat
>  ------------
>  +
>  
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 84e012f83f..15267e8d54 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -137,7 +137,7 @@ static const struct repo_info_field repo_info_field[] = {
>  	{ "path.commondir.relative", get_path_commondir_relative },
>  	{ "path.gitdir.absolute", get_path_gitdir_absolute },
>  	{ "path.gitdir.relative", get_path_gitdir_relative },
> -	{ "references.format", get_references_format },
> +	{ "references.storageFormat", get_references_format },

Here we change the key name. The rest of this patch looks trivially
correct.

-Justin
