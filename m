Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865771BC4E
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755716668; cv=none; b=fDwMxF1xxe/XQjiHLOQu9h5Wju3xoBh/zqc/dx/euvQ1zLYQwwR3+/dS3O2AdCtUmz2090Qd3r76p9s5KPfFf71uuODJGhh/CmldQaoN3r0bIYBFlURt/w8XZK78uwukdH6GUmmcpZtIvteAutXHLy4Je+06rScVopeUtAlU0Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755716668; c=relaxed/simple;
	bh=UCUBDjB/hVNijuqEYXBx8u6vTtwhg5bGpifubBegYU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJiNjTkDi6NfYOqmBmg7Mk7xDenwJOPy9rk+vzbJU7UXL/ErO8OsoJMvUdP4H8EQcvuCkb2seB8h73vGxW38DLQJ8wWM6Tf6KE2A+IbVfBd4A73kdCf99Xntx0n7yCgT+OemIZRfTqeqNpe6sbZ/9PvTFaG81fHZYZvQUaJsFKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RPzh9/Sy; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RPzh9/Sy"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-242d1e9c6b4so40475ad.0
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 12:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755716666; x=1756321466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1OavN0+s+D58FeN5PXJJ6g5De4qkS1aoJv4ZaIjyr4=;
        b=RPzh9/SyRMR3QAjqSBq5xYMPPfYf8/Tbc1AkHstUQJAGgq51GvMogqcwfiU0wAZOLm
         gTVHfeo3I8bziBGn0bgCNebT4Dj+h61vSf+2Tl/kMjpt0/+ZX1P1NiPyVXx8dy52wJSk
         NtJbaMg1gSmKdqAS6YU5Q8kmqclgJUWxxLRLlm1PCgR0GsfGBFTQRO0EFko02XQ8hCfL
         UfDZ/Kd1diEOHxcvqVGdzO4Y9u42v+ck8nk52NTNVuIydoWC5erTaIKV9rmn7xnztzt3
         xqaQddzrugf2sWtZFLl9NliUy7QFWCCFPeeMvIoD5rz6UqtsNHC0bnX5JitHjMX42OC5
         905w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755716666; x=1756321466;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1OavN0+s+D58FeN5PXJJ6g5De4qkS1aoJv4ZaIjyr4=;
        b=hXK3P6NMhnQLkWAI89CCpWAFY0dgdXSCGWgGlRhJhr8F+U4qG7hGeASf30LBfZ/VuI
         OJXe6geXYLV2RF0h3q1CLbE9FcdETxg9TAF+MqwXVqU8Olqn1qkMHQO9f32PPzfT+Tfr
         5Zw+I602Ns0h26IUc1cFUTNtmVf2P8fB6P5imuGUGABWSQLkZ+xCsKbJ4tFKbexNn9nO
         d/J1P1FmFhgFwBTwZKHc7PBEmAPigtmFNaI+PKdKxJARNSL6Ger7HlAFNNunJyTZX3pt
         qytN/mIKliLOsYJzlNtP/cZ1mCAPT2qMRuS+UUg5GIQ9Zf2Z4CuMlzstHXibMFqcveQ5
         XqXg==
X-Gm-Message-State: AOJu0Yxk6cmuUJ091o+CEJSx119S+bORWIjti+QEVHznt8GLya+eqlDV
	wzBlp23A+JSBQ8XkEIbMa6cwW1KdnvU65q69aEHMTbiNftPHQQ8vMvrORj05Jd6pdw==
X-Gm-Gg: ASbGnctunuG0cHtdhQCYcp6nprXcKlXY5dGXprHknHoU+WgB8kItVTbVBO6hDnuv7HV
	7xFbSHJ2brMK1IyP/ISHPkBvg/knbqhXmKKjV3F2eB3W4sm/lJWbhFG3biEY5S/n9TJeLYt4mam
	butAj7T90jV93VM4uAAsZraimeQ2FEooXJS3xMVSjWgfHb19O3w6ZZLzHHp2I5bIu7dkSFKJFwd
	y3+ruJx3waE9lTZFRWK3CrNu0cG4ONsETNGuWY38KiD6CIpOsJdFqeHv7Lmu9V41gRSBG6Yk+am
	+uFakqxkwXuK6UBEksrYONsCb2QVjjDe5tuKktcmHk7efUzp5IAnZtcssm6sJx1/mEfUR+k6vtd
	3NMQr6wOrq/QKuoxWUT1gdfAHdho=
X-Google-Smtp-Source: AGHT+IGpZY11GF3e2ag9OWYbFZlTdc7FTtRi3QRi252/rOBjlC14QqXgFpVrZXBJWWaSTulFmYfTFg==
X-Received: by 2002:a17:902:f690:b0:240:86b2:aee0 with SMTP id d9443c01a7336-245fda5e06dmr611555ad.1.1755716665386;
        Wed, 20 Aug 2025 12:04:25 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:23b5:65e6:69f5:ee81])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640d5013sm2898834a12.54.2025.08.20.12.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 12:04:23 -0700 (PDT)
Date: Wed, 20 Aug 2025 12:04:16 -0700
From: Josh Steadmon <steadmon@google.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, 
	Rodrigo Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Aaron Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, 
	Stefan Beller <sbeller@google.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/9] submodule--helper: use submodule_name_to_gitdir in
 add_submodule
Message-ID: <qcpwoggznb2hj4kegtnouh3ty2sepuhmqlhhzfbpvm7d2yt33y@6vnui5pnnl7x>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, 
	Rodrigo Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Aaron Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, 
	Stefan Beller <sbeller@google.com>, Patrick Steinhardt <ps@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250816213642.3517822-2-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816213642.3517822-2-adrian.ratiu@collabora.com>

On 2025.08.17 00:36, Adrian Ratiu wrote:
> While testing submodule gitdir path encoding, I noticed submodule--helper
> is still using a hardcoded name-based path leading to test failures, so
> convert it to the common helper function introduced by commit ce125d431a
> ("submodule: extract path to submodule gitdir func") and used in other
> locations accross the source tree.
> 
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  builtin/submodule--helper.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 07a1935cbe..7243429c6f 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -3213,10 +3213,11 @@ static int add_submodule(const struct add_data *add_data)
>  		free(submod_gitdir_path);
>  	} else {
>  		struct child_process cp = CHILD_PROCESS_INIT;
> +		struct strbuf submod_gitdir = STRBUF_INIT;
>  
> -		submod_gitdir_path = xstrfmt(".git/modules/%s", add_data->sm_name);
> +		submodule_name_to_gitdir(&submod_gitdir, the_repository, add_data->sm_name);

I believe submod_gitdir_path is now only used in the `if (...) {...}`
side corresponding to this `else` branch, so perhaps we should make it
local to that block?


> -		if (is_directory(submod_gitdir_path)) {
> +		if (is_directory(submod_gitdir.buf)) {
>  			if (!add_data->force) {
>  				struct strbuf msg = STRBUF_INIT;
>  				char *die_msg;
> @@ -3225,8 +3226,8 @@ static int add_submodule(const struct add_data *add_data)
>  						    "locally with remote(s):\n"),
>  					    add_data->sm_name);
>  
> -				append_fetch_remotes(&msg, submod_gitdir_path);
> -				free(submod_gitdir_path);
> +				append_fetch_remotes(&msg, submod_gitdir.buf);
> +				strbuf_release(&submod_gitdir);
>  
>  				strbuf_addf(&msg, _("If you want to reuse this local git "
>  						    "directory instead of cloning again from\n"
> @@ -3244,7 +3245,7 @@ static int add_submodule(const struct add_data *add_data)
>  					 "submodule '%s'\n"), add_data->sm_name);
>  			}
>  		}
> -		free(submod_gitdir_path);
> +		strbuf_release(&submod_gitdir);
>  
>  		clone_data.prefix = add_data->prefix;
>  		clone_data.path = add_data->sm_path;
> -- 
> 2.50.1.679.gbf363a8fbb.dirty
> 
> 
