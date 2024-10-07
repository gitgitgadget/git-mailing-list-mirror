Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEA11DC180
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320096; cv=none; b=WpX0uB6xKNThzVxSfiie8qkkiOlUG3G98ipdRoBruoEPo5x6jh1mjQTA21BcCrskQT029c57tAMJilFFWoM2R/8SPtmvuruBd5gbhys8LEnt+x8o9NMXEDyhTd7Ox0i64nAd+OEL5xiOqO+IMXEttFvYzp6sLrQYUHQ87KikM38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320096; c=relaxed/simple;
	bh=eXttdRubbHlz051rKPY3Q1/DXSPvlTmzKjdo+OYzjiI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jSTWlaI70z5tap4AQBqMXsy/13NRONnMqcKp+73rdCMXMYU3K3aCzE/XNyblLlWt+ATMPAHCNJpdPr0tDarHQQIC1w84sgALxbxdl50f9t/CcFTibFjH0SbWC8vK1dQx8ET9iUYD4oR8fu5kGtPSEOa0gnKWQ+C/qHcNzTU7K3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwnagzAq; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwnagzAq"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7e9ff6fb4c6so2607659a12.3
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 09:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728320094; x=1728924894; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hVn70HOZuzKwEnaEtlEWLjlCkhNCiKW0y7QkQxIStAE=;
        b=cwnagzAqe6aDxZ71q4K9rSOdhaNaSPRNXeuH7e3tdN5odmWdn4H+cdPoyzkfGdKVC6
         EB/9+7m6O56/FZpsK+xGkwZfhYnWdxW2rdFE1PlVmb7p7VGwXirScta9eohMD4X1zHhe
         M4tHLSz0L0o2aFehOsrj+DLKiQLNwxSMEmNVSXtELfxNjWRT4YxTr4yBk73p6R91Nw9b
         JJykPp0ucDXe4XU9vBH8HnW3jA0ZdSZ5oBbvSYPVBaDIOLkxRU/vvY2ZVViqqYqNB4BR
         AMyfjqsPOtNaTMVqYpis7LwuAHTLE9gcoiVZxf1i6hZNx05zIZ8F76uL/IqUH37enQhP
         6ZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728320094; x=1728924894;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVn70HOZuzKwEnaEtlEWLjlCkhNCiKW0y7QkQxIStAE=;
        b=aB+s6G8iASPEWPQjCNC1ZDzu7hjEMqqmD98sulApEgxB1V3DAXKOthCGB/L7Uv2cEa
         OQ8gL1BSI3MBpAVLbheqU2v67KaTe1yL8AhJQ/fMcRoKhiBHufFEFZYds9tCiGT3hhMb
         LiQ19mrjQIuzXLRQ82Gjey1rNVU/o4ohRntnOgx2rE+lCMXytSzdwsK0+foojvpQYNbs
         hREAVf2TjTet5T+N1kyJnQxbJZL80RA7d2z+q2ZH0FaIHDRpydMWV2aV1TcRSvoSfSfs
         4umzjN+Gwj6oayYh6tiSduzXrXgAuGY8u85vRUUYkH1fbFw6gU65ZPFr7xeP+CewOMXd
         OkEg==
X-Gm-Message-State: AOJu0Yx/aX7DgihC+nx53dKA+eezo+uqsVEBkGwWkJITBcGCt3yH7IZP
	oBc+bUxrvvXMpHp8+mqjWNQTIFiZUhRdkLpVthqmP7gbOxIrMNNkQY5+oA==
X-Google-Smtp-Source: AGHT+IFGaoKQ1eJS40dOkP24wTiSFx8zcxjdNDluMdBsXRLy15Y1eOEZrNvrOajbhNrlDD4XAzBYPA==
X-Received: by 2002:a05:6a20:c890:b0:1d6:a7f5:2e19 with SMTP id adf61e73a8af0-1d6dfa231f0mr19182984637.2.1728320094248;
        Mon, 07 Oct 2024 09:54:54 -0700 (PDT)
Received: from five231003 ([2405:201:c006:3236:c62f:7f61:3962:d665])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d6243asm4607145b3a.151.2024.10.07.09.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 09:54:53 -0700 (PDT)
Date: Mon, 7 Oct 2024 22:24:49 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [Question] local paths when USE_THE_REPOSITORY_VARIABLE is not
 defined
Message-ID: <ZwQSWcmr6HWTxxGL@five231003>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

I have two questions but a bit of a background first -

102de880d2 (path.c: migrate global git_path_* to take a repository
argument, 2018-05-17) made global git_path_* functions take a repo
argument.  The commit msg mentions that this migration doesn't change
the local path functions in various builtins - which were defined using
GIT_PATH_FUNC.  This was also the commit which introduced the macro
REPO_GIT_PATH_FUNC.

Skip to 7ac16649ec (path: hide functions using `the_repository` by
default, 2024-08-13), GIT_PATH_FUNC is hidden under
USE_THE_REPOSITORY_VARIABLE and the REPO_GIT_PATH_FUNC is made its
arbitrary repo equivalent - which can be inferred from the following
portion of the diff

@@ -165,19 +130,10 @@ void report_linked_checkout_garbage(struct repository *r);
 /*
  * You can define a static memoized git path like:
  *
- *    static GIT_PATH_FUNC(git_path_foo, "FOO")
+ *    static REPO_GIT_PATH_FUNC(git_path_foo, "FOO")
  *
  * or use one of the global ones below.
  */
-#define GIT_PATH_FUNC(func, filename) \
-       const char *func(void) \
-       { \
-               static char *ret; \
-               if (!ret) \
-                       ret = git_pathdup(filename); \
-               return ret; \
-       }
-
 #define REPO_GIT_PATH_FUNC(var, filename) \
        const char *git_path_##var(struct repository *r) \
        { \

(the GIT_PATH_FUNC macro is moved to be under USE_THE_REPOSITORY_VARIABLE)

Looking at the expansion of REPO_GIT_PATH_FUNC ...

#define REPO_GIT_PATH_FUNC(var, filename) \
	const char *git_path_##var(struct repository *r) \
	{ \
		if (!r->cached_paths.var) \
			r->cached_paths.var = repo_git_path(r, filename); \
		return r->cached_paths.var; \
	}

It seems that REPO_GIT_PATH_FUNC isn't an exact equivalent of
GIT_PATH_FUNC.  That is, REPO_GIT_PATH_FUNC expects even a local path to be
a field of the "struct repo_path_cache".  An example of a local path is
EDIT_DESCRIPTION from "git branch --edit-description" (which inturn gets
used by "git format-patch").

So my question is - do we want, in the future in which we are free from
the dependency on "the_repository", for all the local paths to be a part
of "struct repo_path_cache"?  Which in my gut feels wrong - one alternative
then is that  we will have to refactor REPO_GIT_PATH_FUNC - or am I missing
something here?

I got into this when I was trying to refactor builtin/branch.c to be
independent of "the_repository".  It was a very naive approach of just
manual conversion of all the git_* calls to repo_* calls and similar
changes but the compiler started to complain since I overlooked
GIT_PATH_FUNC and some variables in environment.h which are also hidden
under USE_THE_REPOSITORY_VARIABLE.

Which raises another question - why are variables such as
"comment_line_str" and "default_abbrev" hidden under
USE_THE_REPOSITORY_VARIABLE?[1]  They don't seem to be dependent on
"the_repository"?  Again, I might be missing something here but am not
sure what.

By the way I don't expect this "naive approach" to be the right method
of doing this - I was just tinkering to get to know
USE_THE_REPOSITORY_VARIABLE better - since builtin/branch.c also calls
into ref-filter which heavily relies on "the_repository" so changes
there also would be appropriate for the complete picture.

[1] See

- f2d70847bd (environment: reorder header to split out `the_repository`-free
  section, 2024-09-12)

- 673af418d0 (environment: guard state depending on a repository, 2024-09-12)
