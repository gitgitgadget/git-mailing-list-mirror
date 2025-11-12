Received: from sender3-op-o12.zoho.com (sender3-op-o12.zoho.com [136.143.184.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514DD291C13
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961326; cv=pass; b=HXUm68IxykRIpNcHvn8H8HuNFET7YoA5Cl5cHkWBOICyhLh0pRQ01CAFzijVA5/swdHgrL1U2sGdB1k8lk5vgV6b7MzqpK+anmF3+RImf32A1WKgyz/CCUATrHSwf8fAqXN+h2NIgHkkfVuhh9NT5gFj/BJLLx4E0WtvNpVJM6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961326; c=relaxed/simple;
	bh=yAvxsZ+x2vM4YoXlGxtyr1TCrqGneoI2dqbxGTlMYvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iohTumtBQ3JAZy/7bpuu+rdPF+sQjokAd7zGT5cy6n9ymbE1cAcekrbUUXQp25krmW1mEyKwLUZPIe1o0zdPhad1dHu+fHy1VuedKoNhgR4FhxUT+kGXsvlj0EAZx6lLLoY6KK7rzPV57d11I7u8A9mrQV2rhjg462CwyA4vITg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=VZRlcGWX; arc=pass smtp.client-ip=136.143.184.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="VZRlcGWX"
ARC-Seal: i=1; a=rsa-sha256; t=1762961298; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Iscsn9mtnXPjkQ21oBa+/JhSS71c7YQcNU4lGEjjATGHXLvOY0o5wWYd/ynaOOcL/LByPHoO5uk4wKASPIPxrgVf4c0z7DGoWqzR9S428fDVbe+lXa6XjBMyQ/URd22rh1h8Wb1lWjmAsoI/hFiL56btSufyHm9TBDgvjrj9TfU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762961298; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oXTS56syH4qEa6vwCd8FRx2H64Tt8I9E3EWGsIaIRxo=; 
	b=AjPUJc6A8JPglCZloCTyTsi5lTiqgyDty06zQA3M8+ZrYxbedw7z2JXvoLXgPBTEcqDO0pr/9IOB0Tdwbs5ryxK+Ga5rlsW3rUfYs4ESeGHRAttU75JD+c/Ek4tl+DZckgOU8CEdMeUvYZJ5vGj8J4tYh/4KDi0jHBgDygtrdDc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762961298;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=oXTS56syH4qEa6vwCd8FRx2H64Tt8I9E3EWGsIaIRxo=;
	b=VZRlcGWXaDB1JFOh6MW3zlk3gAtdX61aizfKdpjpF3LiKHCUG/Taibe5CTMYL0U4
	y4klcI8mSq8gWauRTjI7xK2AsPGsYlV3G3kyJH0S/dMZgx6FP/ANWg86m+EjOsn2vyq
	Aiw8b+wZxguO4InEsHht8V3a4pdUHQ4DUuTK8EPs=
Received: by mx.zohomail.com with SMTPS id 1762961295815692.3477158274599;
	Wed, 12 Nov 2025 07:28:15 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>,
 Jonathan Nieder <jrnieder@gmail.com>, Patrick Steinhardt <ps@pks.im>, Josh
 Steadmon <steadmon@google.com>, Ben Knoble <ben.knoble@gmail.com>, Phillip
 Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 4/4] submodule: fix case-folding gitdir filesystem
 colisions
In-Reply-To: <20251107150547.3272180-5-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251107150547.3272180-1-adrian.ratiu@collabora.com>
 <20251107150547.3272180-5-adrian.ratiu@collabora.com>
Date: Wed, 12 Nov 2025 17:28:10 +0200
Message-ID: <871pm3jmnp.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Fri, 07 Nov 2025, Adrian Ratiu <adrian.ratiu@collabora.com> 
wrote:
> diff --git a/submodule.c b/submodule.c index 
> ceaff0c1aa..ecbffac2c6 100644 --- a/submodule.c +++ 
> b/submodule.c @@ -2280,7 +2280,7 @@ int 
> validate_submodule_git_dir(char *git_dir, const char 
> *submodule_name) 
>  	size_t len = strlen(git_dir), suffix_len = 
>  strlen(submodule_name); char *p = git_dir + len - suffix_len; 
>  bool suffixes_match = !strcmp(p, submodule_name); 
> -	int ret = 0; +	int ret = 0, config_ignorecase = 0; 
>   /* * We prevent the contents of sibling submodules' git 
>  directories to 
> @@ -2318,6 +2318,42 @@ int validate_submodule_git_dir(char 
> *git_dir, const char *submodule_name) 
>  	if (p && strchr(p, '/') != NULL) return error("submodule 
>  gitdir name '%s' contains unexpected '/'", p);  
> +	/* Prevent conflicts on case-folding filesystems */ + 
> repo_config_get_bool(the_repository, "core.ignorecase", 
> &config_ignorecase); +	if (ignore_case || 
> config_ignorecase) { +		char *lower_gitdir = 
> xstrdup(git_dir); +		char *module_name = 
> find_last_submodule_name(lower_gitdir); + +		if 
> (module_name) { +			for (p = module_name; *p; 
> p++) +				*p = tolower(*p); + + 
> /* +			 * If lower path is different and already 
> exists, check for collision.  +			 * 
> Intentionally double-check to eliminate false-positives.  + 
> */ +			if (strcmp(lower_gitdir, git_dir) && 
> is_git_directory(lower_gitdir)) { + 
> char *canonical = real_pathdup(git_dir, 0); + 
> if (canonical) { +					struct 
> strbuf norm_git_dir = STRBUF_INIT; + 
> strbuf_addstr(&norm_git_dir, git_dir); + 
> strbuf_normalize_path(&norm_git_dir); + + 
> if (strcmp(canonical, norm_git_dir.buf)) + 
> ret = error(_("submodule git dir '%s' " + 
> "collides with '%s'"), + 
> canonical, norm_git_dir.buf); + + 
> strbuf_release(&norm_git_dir); + 
> FREE_AND_NULL(canonical); +				} + 
> } +		} + +		FREE_AND_NULL(lower_gitdir); + 
> return ret; +	} + 
>  	return 0; } 

I think I came up with a better case-folding conflict detection 
implementation.

In a nutshell, for the next iteration (v5), I intend to do:

DIR *dir = opendir(modules_dir);
...
/* Check for another directory under .git/modules that differs 
only in case. */ while ((de = readdir(dir)) != NULL) { if 
(!strcmp(de->d_name, ".") || !strcmp(de->d_name, ".."))  continue; 
if (!strcasecmp(de->d_name, submodule_name) && strcmp(de->d_name, 
submodule_name)) { closedir(dir); return error(_("submodule name 
'%s' collides with '%s' " "on case-insensitive filesystem"), 
submodule_name, de->d_name); } }

We look at existing submodules and we have a conflict if both are 
true:
1. Names are equal ignoring the case (case insensitive equality).
2. Names are NOT equal considering the case (case sensitive 
inequality).

This is simpler, more robest and passes all my test cases.

Will leave v4 on the ML until next week in case there is more feedback,
then I'll send v5 using this check (I'll also add more tests).
