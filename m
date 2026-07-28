Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F613815CF
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257027; cv=none; b=Eyxg4/AT78aWwuEojlvnNMlVneU5Fm7UHGghk8jLygCV3TH/suvTYsJralNlGz8wYz3+/VafxuarAJKO1pzSYNy3WKEVRhu+CzBSKSUAIOaQjiILvQBNxMaWYaOU1iRwIuq0m6glrGjQxlO6Ow3J0v++vRQ/4XOIYyoPu1MNCu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257027; c=relaxed/simple;
	bh=f71Oy9XdcLJ++nh4tVUu3ZvL/ExrYV6jH8YV88gsq48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6S9wrzuBtkqFoWCH759y5Q9uish015LCLMK4prTmewVo1QcMHonJ8LLUIE9yl5pg3enSmadU0Hn01NPJ4iaEDLRuU92pj9HFYo3lzyShQWjHJ5EQDHJmbzKS6MbVoEzahd9NzPkAlQQZLxAEqdt1YnDyCoNDzCOr7Xta8R1cCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdHlIo8E; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdHlIo8E"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e9d7464b71so55290a34.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2026 09:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785257024; x=1785861824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rD8UtUOE62HHYOqtxJmTE/HCtVJ9/srciepyPBgDCho=;
        b=AdHlIo8EGCrrl+WgmXCaUDCKh4D140Y4e+67ilvOreUY+gBkHhhkYypYUXPpn9weFS
         KsxtYCxZgR5j96S2ddF/o2SvPJJIcjWEVtAdZjcAAts3qc2z9oeDIyN4qBYt+pKzcNzq
         WJF9VTz1qiF7zMFWj0RRw/UYoDdcKR1SBb+rjHY4oRCj6ziDnHDWr6jioZQL8fN4ygRD
         ZI/yNZDDiS4mOFcCOafY5zerEcTPa8p3verOwmWPYfnaQid4kFlB5FWtuGJibNKi5P1o
         RpOn7ohA0TwmN8D/FvUPwFovi0EREBZz2OPYLNrrI0KUUuVYS0sEY+EnPd2hh/5vN5Wx
         +qVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785257024; x=1785861824;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rD8UtUOE62HHYOqtxJmTE/HCtVJ9/srciepyPBgDCho=;
        b=riHraSzXZ6eG7rToTeoyHjaUzpWvvy7/sozX7AiNb+S0q81OaF+wWZih4PyYCjTPt3
         Z7eNUQkus8NYHGlJR0RvM3SO7PoQFTbsgIUls3SNKDgKVf30qYn1QzCbZ6Xl7E7daw0e
         YFQCbmSkrIzi6tJ5egAsvvuFn79Ru/6KR2hpAx0kmvK7iWCRJ7zsxazBCI+xn9hml1tB
         IECMavk8j94PZZzyYMNKLjg2mn8lJ3QNzzH2S+B7ZYSbLRoBkDCktqxWg7uHfHmjIVUk
         KgQI9/9FXQVgg3DuCwHc+7OlSF0aUtWY59iXzmwvITLvaRejY05/VGNCh3/qaxOOYQ0q
         GshQ==
X-Gm-Message-State: AOJu0YxhFjsIMPwJ/m+fMsKoEA/St8U2TVsNcTGrj4DwN3J/4hIoYg/R
	lc+OIwA+OBBe0TEMOcQiF+ujp2pM1A7PpA1VW0WMkwoo3Tbpl2E8ub7q
X-Gm-Gg: AR+sD12MO7YpH35UuRMtOAwaL91K0ZwN/GKp4F1TvasFM83v41qfd4kaQWk7Ws1hb/a
	FY3uTExhvAjdDO1UAxpyBsMMAIy/rono1wB/hn+gMIJ1VOlqrDSnnG1uMyVfwdhLKoGLIX5Ywjn
	2GqH+GdB8vzz6oyXz18PVQS3IIOhVtwBMu2AXAxQh59cvzEN92vaalE2UtnsBZ2EQEw1VCCmUcO
	1nScgKVFaLbMeDt9w6JQ1et1DOcVzRQKh5CH3oJpatsVi9oH66n0gLdV7U8RJxmA4t3aKoSujjA
	T5CWCjOeZlU48g+V6ieVibteCj0w6oPTWAiQwK3/7jQXLHcd0kl66Cgerg9oA9PmtvNviBNXcuT
	jMPtWYZC2nw28RwK9QQTy+QOoMJf7vuBkcNXLiGqdITrjzphm+tKkF9TNmXoAj8u521D/PJYGKY
	IDXMZucQ==
X-Received: by 2002:a05:6820:179b:b0:6a3:c6f8:4c9d with SMTP id 006d021491bc7-6ac96d265b2mr1685343eaf.68.1785257024400;
        Tue, 28 Jul 2026 09:43:44 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458863c7103sm368974fac.2.2026.07.28.09.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 09:43:44 -0700 (PDT)
Date: Tue, 28 Jul 2026 11:43:43 -0500
From: Justin Tobler <jltobler@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, lucasseikioshiro@gmail.com
Subject: Re: [PATCH v3 2/7] repo: add path.superproject-working-tree with
 absolute and relative suffixes
Message-ID: <amjazXbdRXtH7CoJ@denethor>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260726104343.16933-1-jayatheerthkulkarni2005@gmail.com>
 <20260726104343.16933-3-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726104343.16933-3-jayatheerthkulkarni2005@gmail.com>

On 26/07/26 04:13PM, K Jayatheerth wrote:
> Scripts working in multi-repository setups often need to identify the
> top-level working tree of a superproject from within a submodule.
> Currently, this is only exposed via `git rev-parse
> --show-superproject-working-tree`.
> 
> Introduce `path.superproject-working-tree.absolute` and
> `path.superproject-working-tree.relative` keys to `git repo info`.
> This exposes the core submodule context via a scriptable config-like key
> using standard format rules.

Ok, this also seems like a good fit to include as a key in
git-repo-info, but "superproject-working-tree" is a bit of a mouthful
IMO. An alternative could potentially be "superproject-root"? Maybe its
best to just be consistent with the option name in git-rev-parse(1) and
keep it the same though.

> If requested when not inside a submodule, the command returns an empty
> string.
> 
> Mentored-by: Justin Tobler <jltobler@gmail.com>
> Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  Documentation/git-repo.adoc | 10 ++++++++++
>  builtin/repo.c              | 33 +++++++++++++++++++++++++++++++++
>  t/t1900-repo-info.sh        | 34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 77 insertions(+)
> 
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index e34abe5fea..03aa57942f 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -119,6 +119,16 @@ values that they return:
>  `path.gitdir.relative`::
>  	The path to the Git repository directory relative to the current working directory.
>  
> +`path.superproject-working-tree.absolute`::
> +	The canonical absolute path to the working tree root of the superproject
> +	if the current repository is an initialized submodule. Outputs an empty
> +	string if not in a submodule.
> +
> +`path.superproject-working-tree.relative`::
> +	The path to the working tree root of the superproject relative to the
> +	current working directory if the current repository is an initialized
> +	submodule. Outputs an empty string if not in a submodule.
> +
>  `path.toplevel.absolute`::
>  	The canonical absolute path to the top-level directory of the
>  	repository's working tree. Outputs an empty string if the repository
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 194757eb18..82359473e9 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -18,6 +18,7 @@
>  #include "strbuf.h"
>  #include "string-list.h"
>  #include "shallow.h"
> +#include "submodule.h"
>  #include "tree.h"
>  #include "tree-walk.h"
>  #include "utf8.h"
> @@ -121,6 +122,36 @@ static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
>  	return 0;
>  }
>  
> +static int get_path_superproject_absolute(struct repository *repo UNUSED, struct strbuf *buf)
> +{
> +	struct strbuf superproject = STRBUF_INIT;
> +
> +	if (!get_superproject_working_tree(&superproject)) {
> +		strbuf_release(&superproject);
> +		strbuf_addstr(buf, "");

Same comment here as in the previous patch...

> +		return 0;
> +	}
> +
> +	format_path(buf, superproject.buf, startup_info->prefix, PATH_FORMAT_CANONICAL);
> +	strbuf_release(&superproject);
> +	return 0;
> +}
> +
> +static int get_path_superproject_relative(struct repository *repo UNUSED, struct strbuf *buf)
> +{
> +	struct strbuf superproject = STRBUF_INIT;
> +
> +	if (!get_superproject_working_tree(&superproject)) {
> +		strbuf_release(&superproject);
> +		strbuf_addstr(buf, "");

...and here as well...

> +		return 0;
> +	}
> +
> +	format_path(buf, superproject.buf, startup_info->prefix, PATH_FORMAT_RELATIVE);
> +	strbuf_release(&superproject);
> +	return 0;
> +}
> +
>  static int get_path_toplevel_absolute(struct repository *repo, struct strbuf *buf)
>  {
>  	const char *work_tree = repo_get_work_tree(repo);
> @@ -163,6 +194,8 @@ static const struct repo_info_field repo_info_field[] = {
>  	{ "path.commondir.relative", get_path_commondir_relative },
>  	{ "path.gitdir.absolute", get_path_gitdir_absolute },
>  	{ "path.gitdir.relative", get_path_gitdir_relative },
> +	{ "path.superproject-working-tree.absolute", get_path_superproject_absolute },
> +	{ "path.superproject-working-tree.relative", get_path_superproject_relative },
>  	{ "path.toplevel.absolute", get_path_toplevel_absolute },
>  	{ "path.toplevel.relative", get_path_toplevel_relative },
>  	{ "references.format", get_references_format },
> diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
> index fbb9063ee5..220b3d4d3d 100755
> --- a/t/t1900-repo-info.sh
> +++ b/t/t1900-repo-info.sh
> @@ -213,6 +213,40 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
>  	'.git' \
>  	'GIT_DIR="../.git" && export GIT_DIR'
>  
> +test_expect_success 'path.superproject-working-tree absolute and relative' '
> +	test_when_finished "rm -rf sub super" &&
> +	git init sub &&
> +	test_commit -C sub initial &&
> +	git init super &&
> +	(
> +		cd super &&
> +		git -c protocol.file.allow=always submodule add "../sub" sub &&
> +		git commit -m "add submodule" &&
> +
> +		cd sub &&
> +		ROOT="$(test-tool path-utils real_path ..)" &&
> +
> +		echo "path.superproject-working-tree.absolute=$ROOT" >expect.abs &&
> +		git repo info path.superproject-working-tree.absolute >actual.abs &&
> +		test_cmp expect.abs actual.abs &&
> +
> +		echo "path.superproject-working-tree.relative=../" >expect.rel &&
> +		git repo info path.superproject-working-tree.relative >actual.rel &&
> +		test_cmp expect.rel actual.rel
> +	)
> +'
> +
> +test_expect_success 'path.superproject-working-tree returns empty when not in a submodule' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		echo "path.superproject-working-tree.absolute=" >expect &&
> +		git repo info path.superproject-working-tree.absolute >actual &&
> +		test_cmp expect actual

... and here as well. :)

-Justin
