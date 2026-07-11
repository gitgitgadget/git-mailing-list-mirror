Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39121DFDE
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783796712; cv=none; b=H4HbRDMJ9OqVFPf1O0wG6uPSF3YuK3Xqb8xl/2LHAnY+H1b/qcEFCwOwnK5gSLlUR/T9Z6ub6iEy2O1zyHWj/Dh8VtcW7k8FmKoZKcnAwMnzbrcZb6M2OdpcCqmnrLUf6NgA4NK3lxBS8Jfv1wog6BkLhUxJ04TY2XXFaj6aJT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783796712; c=relaxed/simple;
	bh=IlBixf1IFo5MLLyfgJdpBcaM1npoHQ3BpQnsbFe5m1U=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=QpGG0qXvR1GOxs6blrL9lBl3WmjO6y7v5Ch+VJTicyDcv24iS5oXEr+MAESGNIqNF3fgYlu8ZOEuECf+OrlAxMvOFalbqpY9pls0q6NXaizMU68w12t7szLVSxN5HH7KPaLqNEC4z7iNxOOZvbf0vs7TjuFNlcbP2OiYn/bqLvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSL6eUTN; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSL6eUTN"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4703bc0a99aso1063749f8f.3
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 12:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783796709; x=1784401509; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Qjs4uzXDAUSp2e2QFqcWJ1+kNzUVF68DbJF451gRy/M=;
        b=BSL6eUTNjrTrh2SYvK9JdU08RW/SgH/q5wFgcBskbz9Y8H55F0PGUS9OxP2biTU3Sb
         8xS6C/hU3ZNgvh/krouPIU6L8DnKgcrjptpGa13/qu9/ap/N4eocB5QK6oH/7GGqPaQ3
         dyhdbRCK8WDwx57PLfeSGUT3Uaodtqm/L+5pob1PDejgC0rWRRf3wYBXhWpfPBF9Mw0L
         27Xhtd5mmD65n8b+8ra6bUkRFBM+86+rrrE7/jDNiokizM4R5cI9DnjdaiBj64dPVt+e
         SVjHVCgRnPYUoDOn8R+BEBy44xcIe1GL+Cofn0fvAnkmJF8JvE7zPFtqAPHZJ8vKsnpJ
         KwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783796709; x=1784401509;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qjs4uzXDAUSp2e2QFqcWJ1+kNzUVF68DbJF451gRy/M=;
        b=iLB2hHUljmC55N26kQqz3/7GB5J8oXXhuFYb/9LUQt9u1TVm1vk2/KycE1A+IIqPPw
         4M+2hKySYveDMXEuDxXS5Upv2e+KDAglCe/bCdVvoUT6o/hP3q6zfemAAsFNzC0QdYwW
         3Y2OOQBCy+jBQjoYrwm6enJn4eU3HL0B2mJWUrba543yI+65LL2CKt222lDLas53PQTI
         6FFyfGfhLbHQyVKEqJ/LQtBYqP2g9RFVgb/cwibxdqcuT9ugF0xeA/XDQ7M57wpAcI+D
         zhdA7zZ/lWJMHM6DHiYxV5glgY5gSIrxmei9h/eck6mfAI87VHNxjm9LlG+X34AUoZS2
         TTmA==
X-Forwarded-Encrypted: i=1; AHgh+RoLYcAvVemIXQwSmdjvd7Q0RLodI5ZYQicSSGyTFYbVfsFDVKt6k5RIJwGymYYrXtdhQKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQy6mcqfSDTE11/T/YIZOrWZgC9PWKCZTs1AqG8m0oFAl3XLMX
	LCuq40B2SJehoOYpzYIFs0lrhuqQgymGqpvWVXaa/j+xsBBaOcYUr5m0
X-Gm-Gg: AfdE7ckGF8XaZkYv9XVTE/74hzEP77qI6CRjUFtL5jKZrUGD5mF2lwJyXPoDzhRioJg
	VUzmWEiw06pJQWQrCIvuntsDJS4YgzyP6buX4/pX9Mkij1FsxtZWSq2avAP5YAEcwMtNuldL6RX
	siEZaBEdJ3wiDkvhaCM08rqPH3OUFovRFlGhzqsoos2+cs9bR+H6ztiRdR61mUPtzjbeBJQ/bxa
	zmCbBXp5YI66Uad19oqjnPguG6X9vVaih8WNr6wxEIEw3muxWOww7VpQUmLUeq4cBqCDwBxdu6R
	bKxNlVjdn44LXVmKonlXmIPUSLWsV4B8d2NLXSoungm+bYgB7eemBspFc4FZmTlxGauwtd15zlz
	cSV8PDWJ0kz+6P579YmaFLhEAM+GQDXzH1qUZw8xZi4nPXKrx7OjCdzc4tUkrmZliGPvkNWzC8M
	VboHhbyPAQlDEKAn4SD4JDobq6GVTOsJGyBv+j5dk32stjQumBBhkMJrZBFIMP6e93SjeJUf93I
	YyJWS/895aoLKEpVFI59rlgJ59cBgeuZWG9N6RRkn+Q4uSRyiiP3Z2bqSPo8SUO9aE1HYU9QNXj
	NxlYVhKHBefA0gBpSAgPxqO1vSg+uGyTXc2u4rIOfMgv0pXaMZP3xQWYrnXXNOFlYTknvQ==
X-Received: by 2002:a05:6000:2f81:b0:476:6559:2a72 with SMTP id ffacd0b85a97d-47f2dcac496mr3836226f8f.2.1783796709172;
        Sat, 11 Jul 2026 12:05:09 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d91bsm75894024f8f.4.2026.07.11.12.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 12:05:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Jul 2026 21:05:07 +0200
Message-Id: <DJVZ5QPXBFY8.VBJN0TB3WROC@gmail.com>
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Tian Yuchen" <cat@malon.dev>, <git@vger.kernel.org>
Cc: <cirnovskyv@gmail.com>, <szeder.dev@gmail.com>, "Christian Couder"
 <christian.couder@gmail.com>, "Ayush Chandekar" <ayu.chandekar@gmail.com>,
 "Olamide Caleb Bello" <belkid98@gmail.com>
Subject: Re: [PATCH v7 3/9] environment: move editor_program into
 repo_config_values
X-Mailer: aerc 0.21.0
References: <20260701180813.776173-1-cat@malon.dev>
 <20260706142530.3681520-1-cat@malon.dev>
 <20260706142530.3681520-4-cat@malon.dev>
In-Reply-To: <20260706142530.3681520-4-cat@malon.dev>

On Mon Jul 6, 2026 at 4:25 PM CEST, Tian Yuchen wrote:
> The global variable 'editor_program' holds the path to the user's
> preferred editor. Move 'editor_program' into
> 'struct repo_config_values' to continue the libification effort.
>
> There have been discussions on whether external programs like
> editors truly need to be configured on a per-repository basis within
> the same process. While a single process might rarely invoke
> different editors, this migration is necessary for two reasons:
>
> 1. Developers frequently use different toolchains for different
>    projects. Per-repo configuration respects this.
>
> 2. Moving this string into 'repo_config_values' eliminates mutable
>    global state. As the codebase moves toward becoming a long-running
>    processes managing multiple repositories concurrently must
>    not overwrite each other's program configurations.

Nit:

"As the codebase moves toward becoming long-running processes, managing
multiple repositories concurrently must not overwrite each other's
program configurations"

>
> No standalone getter function is introduced. Callers directly access
> the field via 'repo_config_values()'. Heap memory is safely reclaimed
> in 'repo_config_values_clear()'.

Why no getter function here? in patch 2/9 repo_excludes_file() is
introduced and also access the field via repo_config_values().

Super nit: on a previous commit you used backquotes for
repo_config_values_clear() but now you're using single quotes.

>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
> Signed-off-by: Tian Yuchen <cat@malon.dev>
> ---
>  editor.c      | 4 ++--
>  environment.c | 7 ++++---
>  environment.h | 2 +-
>  3 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/editor.c b/editor.c
> index fd174e6a03..07d264cba0 100644
> --- a/editor.c
> +++ b/editor.c
> @@ -29,8 +29,8 @@ const char *git_editor(void)
>  	const char *editor =3D getenv("GIT_EDITOR");
>  	int terminal_is_dumb =3D is_terminal_dumb();
>
> -	if (!editor && editor_program)
> -		editor =3D editor_program;
> +	if (!editor && repo_config_values(the_repository)->editor_program)
> +		editor =3D repo_config_values(the_repository)->editor_program;

Same as the previous patch, we can store repo_config_values() and avoid
re-calling the function.
Also, do we need the right-side condition?

>  	if (!editor && !terminal_is_dumb)
>  		editor =3D getenv("VISUAL");
>  	if (!editor)
> diff --git a/environment.c b/environment.c
> index 5950592d63..0a01f4761a 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -55,7 +55,6 @@ int fsync_object_files =3D -1;
>  int use_fsync =3D -1;
>  enum fsync_method fsync_method =3D FSYNC_METHOD_DEFAULT;
>  enum fsync_component fsync_components =3D FSYNC_COMPONENTS_DEFAULT;
> -char *editor_program;
>  char *askpass_program;
>  enum auto_crlf auto_crlf =3D AUTO_CRLF_FALSE;
>  enum eol core_eol =3D EOL_UNSET;
> @@ -435,8 +434,8 @@ int git_default_core_config(const char *var, const ch=
ar *value,
>  	}
>
>  	if (!strcmp(var, "core.editor")) {
> -		FREE_AND_NULL(editor_program);
> -		return git_config_string(&editor_program, var, value);
> +		FREE_AND_NULL(cfg->editor_program);
> +		return git_config_string(&cfg->editor_program, var, value);
>  	}
>
>  	if (!strcmp(var, "core.commentchar") ||
> @@ -723,6 +722,7 @@ void repo_config_values_init(struct repo_config_value=
s *cfg)
>  {
>  	cfg->attributes_file =3D NULL;
>  	cfg->excludes_file =3D NULL;
> +	cfg->editor_program =3D NULL;
>  	cfg->apply_sparse_checkout =3D 0;
>  	cfg->branch_track =3D BRANCH_TRACK_REMOTE;
>  	cfg->trust_ctime =3D 1;
> @@ -753,4 +753,5 @@ void repo_config_values_clear(struct repository *repo=
)
>
>  	FREE_AND_NULL(cfg->attributes_file);
>  	FREE_AND_NULL(cfg->excludes_file);
> +	FREE_AND_NULL(cfg->editor_program);
>  }
> diff --git a/environment.h b/environment.h
> index 2e8352de7f..1ec19149cb 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -91,6 +91,7 @@ struct repo_config_values {
>  	/* section "core" config values */
>  	char *attributes_file;
>  	char *excludes_file;
> +	char *editor_program;
>  	int apply_sparse_checkout;
>  	int trust_ctime;
>  	int check_stat;
> @@ -218,7 +219,6 @@ const char *get_commit_output_encoding(void);
>  extern char *git_commit_encoding;
>  extern char *git_log_output_encoding;
>
> -extern char *editor_program;
>  extern char *askpass_program;
>
>  /*

Regards,
Pablo
