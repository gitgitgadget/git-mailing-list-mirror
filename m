Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D3E363C63
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 18:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788719901; cv=none; b=HDMi9PdlflpW1T1FVMwTO2Uu2eDCvojHjt00SeoueROFKOyVhNWmZTeDSu7a+s4V5oCh8jSvG3NVPWYRLA9O10Fqx2MR/4pv9F+TYt/szdTm+wyBrboeEdEFzNG9uD+y2z3Qzg+ifrLd9VdFowd5nbO0P5UImSEhcvU/gGj2hUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788719901; c=relaxed/simple;
	bh=TNvjfFIHxhTPWA6ikP0zvOHXmmYiC4klCVe5Gtali0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUzp7kugATAcuBer2tPNCcRfF++2FY490aI515EKPO+f/dGKirOUzOpeZxaSnmXCmk8xVzY6NxEsdeZzqaHkv8exdUx3vZTKju1sh+InaKBXdlOFPWz5uTw6+L6TcHPEU9zAwu67+t8l1gOGwNT3SynNqkjCor2W4M2rKxC/pmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfX+SqvC; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfX+SqvC"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7f4dedd67b8so2520411a34.1
        for <git@vger.kernel.org>; Sun, 06 Sep 2026 11:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788719899; x=1789324699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ulEGXEZka4XbrH+627FWynOBI0EkNiOUZIc6n7T6U6o=;
        b=bfX+SqvCanMHEfXDQl4p8UAFiYJl7xuwnHETwIB/mUKpNbJarolnW0zpwWvFvfKe4P
         iO//BVctjRyPoQRwxHkH2JvMbSkvwjhkC49M7COPjI6n/n8qaIyfRnNqz1OtnVqjojIw
         kp5j9LyrMDkT3yehPHyUb8aEEBnoCZjMGnSv3k06e5aX4QLE16f3ve4qhNbba4kAKLas
         BAtaMKjIjlblmE8ZmqcsnJQMLF7i+U1YiA1ot88nwUtEYzSgqHBlA905QHguLzRuRoeY
         qpJMLuna92SAUimW74DIKXm3DENb8GF1pDBZWXoAig9quBsU2Sw7ibieAaNd2G9FmDfa
         WJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788719899; x=1789324699;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ulEGXEZka4XbrH+627FWynOBI0EkNiOUZIc6n7T6U6o=;
        b=B6ls7+GTXziUFFibYEX9ZQuNFUcw8uSZonhRRZ/xJUubYBlNecyLdEazuMXz6MyGuE
         zz4xzSngDqmSF1DFFw7H1dUKd1zwZ32ORn82CRGgqEnR+DSuyi1K5tFoVsp+lyOykMdJ
         wvGO5QiNz8sAo8ReBnTh6IhImiBatPU82hs5mLLpGJudNPYT8547SA4AjDQgNvOJrz95
         WzOHJzgecVdJZ1NsSyfuoCj3QRtNXWNXXsNkgN8QGSyJmpRunZzYgzk5Js//69hmHEWh
         ETenl2hEac5Z+SUBhhVKrXwD4Oo/lcTZfU7DdR1dv6iAvofGLr/2gTrrhCVcsfESeeJP
         EFNg==
X-Gm-Message-State: AFuF++lsg4hd5DqWVdaw/Ot1VjQpkBd8N0J7IH9ilpqxW9nmfkB3I1Sa
	CQ/EBn+2ctdP++FgEQKr8x9F3kFwZAgt2dU/J/u2oT38GKHW+YKicv6vNI/jLg==
X-Gm-Gg: AYBFou1ZcZYVpN0h4wfwQugFPfwUPKA1Yu6/uaCgHLWAPCAkq0ck7eMYMo4Ps++FJzF
	eisbViz8bhmYUDFoZU1VA/SVMccIRRpgKcobb++epmvbaFSy7DuGGa94XVtBgwCZhjP/o/12NyE
	90pBNhEOFmk44PmQBu7M8/0dveJaGvMuowfrOmH06wIgUyQRKDoKurZJdaDhWgwmfL9owcGLK5b
	fDJ8HgjkiILGYiwjYYmo+gcp/hL24vg16q2m0YmxqdNeCu+qfOrh6wGIb0NpcyeJ6K7zzJuc1Pf
	BXqhP47AAnC6e4/ia3ouMwhq/QCoNt74ao4jzaY3kss+jSdyGVkT2Uzi7x0B2uM5ZM3cwcQEGdH
	BmyxIXh16DTmWJXHWfKQjLJ1626E4Ng6olO0XnmlqmrCk1fAqgZcSxQU5w2Prupz5Cz4Z4IvrUB
	DZzs1aTpcEhQ4V6NaIQ5RhZfHRpRnDMoiP/US0z6JlD+BDvfADajO9gbrd5i6XXWRRZ18dF2qT5
	8g3/K5Z7rinGg==
X-Received: by 2002:a05:6820:821:b0:6b6:f16d:d668 with SMTP id 006d021491bc7-6b6fabe04c7mr19157426eaf.4.1788719899112;
        Sun, 06 Sep 2026 11:38:19 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47554c863d3sm7253058fac.15.2026.09.06.11.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 11:38:18 -0700 (PDT)
Date: Sun, 6 Sep 2026 13:38:15 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 05/13] submodule-config: stop registering submodule
 sources
Message-ID: <ap2wj0vK0-VUvaW5@denethor>
References: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
 <20260902-pks-odb-registering-in-memory-sources-v2-5-c6ca12fdea4d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902-pks-odb-registering-in-memory-sources-v2-5-c6ca12fdea4d@pks.im>

On 26/09/02 03:34PM, Patrick Steinhardt wrote:
> When reading the ".gitmodules" file from a blob in a repository other
> than `the_repository`, we register the repository's object database as
> an in-memory source of `the_repository`'s object database. This call has
> its origins in d9b8b8f896 (submodule-config.c: use repo_get_oid for
> reading .gitmodules, 2019-04-16): back then, `config_with_options()` was
> not able to read a blob from an arbitrary repository, but would always
> read it via `the_repository`. So even though the blob could be resolved
> in the submodule repository via `repo_get_oid()`, the submodule's object
> database had to be registered as an in-memory source of `the_repository`
> so that the subsequent object read was able to find the blob at all.

Ok, so IIUC the problem was that a gitmodule blob from a repository that
is not "the_repository" would fail to be read by `config_with_options()`
because it would only read objects from "the_repository". The workaround
was to add the other repositories as another source to ensure the
gitmodule blob could be read. I had to reread the commit message a
couple of times to follow, but I think it makes sense now.

> That need went away with e3e8bf046e (submodule-config: pass repo
> upon blob config read, 2021-08-16), which taught the config machinery
> to read the blob from the repository we pass to it. The same series
> converted the eager submodule source registration into a lazy mechanism
> that only registers submodule sources with the object database when an
> object lookup failed. The intent though was that we don't ever have to
> fall back to this mechanism in the first place, and to verify that this
> is the case we introduced GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB. If set,
> then any such lazy registration would cause us to BUG.
> 
> At the beginning of this series, we still triggered this bug in t1092.
> But now that we have converted the "cache-tree" subsystem to not depend
> on `the_repository` anymore it also knows to properly access objects via
> the submodule. With that change, GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
> does not cause any failures anymore.

Ok, now we can properly read objects from their respective repository
source and no longer neeed the workaround.

> Remove the call to `odb_add_submodule_source_by_path()`. This removes
> the last user of `the_repository`, so at the same time we can also get
> rid of `USE_THE_REPOSITORY_VARIABLE`.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  submodule-config.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/submodule-config.c b/submodule-config.c
> index 7c73fa108b..37c3be377b 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -1,4 +1,3 @@
> -#define USE_THE_REPOSITORY_VARIABLE
>  #define DISABLE_SIGN_COMPARE_WARNINGS
>  
>  #include "git-compat-util.h"
> @@ -803,9 +802,6 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
>  		} else if (repo_get_oid(repo, GITMODULES_INDEX, &oid) >= 0 ||
>  			   repo_get_oid(repo, GITMODULES_HEAD, &oid) >= 0) {
>  			config_source.blob = oidstr = xstrdup(oid_to_hex(&oid));
> -			if (repo != the_repository)
> -				odb_add_submodule_source_by_path(the_repository->objects,
> -								 repo->objects->sources->path);

Nice to have one less workaround. :)

-Justin
