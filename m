Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C56937A486
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 22:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787349767; cv=none; b=o0nJ27Ch+YI+PtdPRe53BKBo3iObDhuAllgRxxexXqEoVJ5sgnAoqROZa2vw0297CmaNfTEh8F+nJm2/TJuBOJT+al+rFZt/59x8pXFX2H+N+vfg3kFe2DaP/S1n5QcgZMrQ8XjWXT9xvOcExmS/8gFB8Yu3tUHt2Erfn4ewysk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787349767; c=relaxed/simple;
	bh=d987Od6/+gv9LVmEeC2n665Yjfd3jZgTEBQE4mfIf00=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iv2l1W96dHe3M1i7O6qm8osrYA8qzzXXejBhMJbCzD9mUiPT8p03CWJ3/XSKcDAZnuJY5zr8DNc/nTa7/6wkVWyNTmPyp901l9+8tdfranZTzq4lpNah4jvll2ktzPXj0sPm/aa5grggyqnfEjDmieJliR+kPTjQ14cnPwXX9a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uKNTD/F+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cNv/0Kji; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uKNTD/F+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cNv/0Kji"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BB7767A009F;
	Fri, 21 Aug 2026 18:02:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 21 Aug 2026 18:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787349764; x=1787436164; bh=gkbv12SYZ7
	m6vl3HX6H4oz8nSOQJ+GzWn6FR/QSXric=; b=uKNTD/F+f/IUYhKXzwM7QKSU6I
	S3raLtYOAntYVR+hGTEJwBtygT4cHb6lQs6rXUGkhJSTTH8MfaaOxUC4A0vexOmD
	BaC3mechV30CNpqvISqNhBY23Fiw3NoT2b1rCBt1fMulBt+hdIQDk5M/x2wCPm2W
	QqX/HF2cGV6/n5Yt/DslnRMwwXKVb2UbZWdDJQmIdORSe+0xWkW0epiAvFrS4qc0
	mJrBpo1vPODXRKQIwS856PRLPSmbcjcQIHJL2NAck36s0s6tUGegTcCupGnvQhac
	72EiEx6wPHbstB+h7JV4Czo3lAisaL6m2KielkY3QAbhNi6kRNuiB1gXqT3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787349764; x=1787436164; bh=gkbv12SYZ7m6vl3HX6H4oz8nSOQJ+GzWn6F
	R/QSXric=; b=cNv/0KjiGN+sKI3aFPkUBzisobK1/guoB2grN7oPyHemPR/Lrsm
	4xheDqMY5m8b+a43qqNQn6uk0JKV84LYY89ejZUCP5DGt7ag8ZRuZ5IZBvPSkK+O
	uMmK1/7BeQuOqPQXX5iaZPs5l2DDhmk0FaBlq9vgwNxke8C1iPDxIUWsBtVaCVG8
	44+WA1iqwv2dwZvHgyeG0D3GuUmCSWi9oYoHiDpHha2/4za1LhlZB0jBSrtBrJDU
	J9jsUPXaYtiySnpSP183VfcK/v09+jh6jbRU3sB3HP2OpMFrSllRVMRe6fnxUCBf
	hSmZ+cNv1EHMI8/hqOpNB4nSEeSIMSQQvGg==
X-ME-Sender: <xms:BMuIajtHlddxEUm97PpP25mYVf1Iwl4ZgMnVMzxkvMrfqwcmYnkmxQ>
    <xme:BMuIarcWISDDXY9-SoUeRJnIMgpg94xIk_czCwCvlk3OuvWCqvd9-45L6nadX9t9a
    0VsSHBH-7-JNL5QBCrAu1aWuvsHJCxxPa9YcqzAIOBelooeiTBIdw>
X-ME-Received: <xmr:BMuIarwjHXlEwNrAWcFoIZgCULYvJWt4Tj2caDyg0U_7dxxUt8Ych6yf-CRcWrALafP7nzdq3s7zZKlFH42496sYhU3rNDdnMA>
X-ME-Proxy-Cause: dmFkZTFdXSmd8csodX163f5QIuKPxipNuoq3yiQUbLbMwhVjl3LMZpsJfiDA4puYplOGK9
    blNMR/7luu/yEDebe5eHJisILCqO29Jnf6bmizW/rxpPaLTQXxVvj5S99HVGQCP75Gs38v
    zGVI+myqyc42dlolN+IVN4aG/O9giDXAU3cneGnyc6jYta17qDRjIkqUYXRHns6eNglH+1
    s7yy0ZXebs2sDAaGg0fAmWnv4TS1J5ge5u+XO8giNss6EaWR56gU7tF/2Ns9Pqi/KtpIGy
    qjOuEvhi7cGVS1EqQ8ZFumKItO90dSr6UfJXrUjA9ftipGEW1YQzLj4ucC4kblgz1H10VT
    QFpRCtCx8DI6s45yLrBqc+FptqnyoLrgJhnZnciz9Abl2bNdCu4Ed3F6lzfmiTYuOR4fk9
    tFd4jHi+jwY+Rs7gipGekhod6uWHwCxjqOYH1Ato/o4QzkFx6b5MJd1XZJ4GOweUZgnSH9
    nYPY6kUvUZ0yPhLnV+ZHcXPvMn8ZzLG9/t7Mw7hUsBY0TyL+QmWvG0BEKZ2AyGkigWn0wl
    DPLzKFNbzu5bQ5jZ6CiVdwFMJr0d9UomzSoLtpwEtgys6VMgQ5QJ9T8j+JJMMxEaosJHmS
    a0Jfzlt8Umlp2KVLngPd7jKvQ4gElTmWI9lHGz4FqW/Z2sW6O24UYIU5gscA
X-ME-Proxy: <xmx:BMuIahEt85FIZO9zdtiB3SEsDDIYxM1LBGMSE3yL8ly6J4tZk7Aq9A>
    <xmx:BMuIavyr9JXt7IKgbs8JVi2UFyzfvjpzkxVHEqr_XjpMk-EKEXZVDg>
    <xmx:BMuIaivwlw7Mz1DRHb0rgt4gzTxQ4E-p7jzXe-ksHjnyfxlP58aZ9A>
    <xmx:BMuIas33BvKdRRiJiqVT1Fzzpczm1BNdWQll0WwKagxY52EfjijtEA>
    <xmx:BMuIavTM7_x9n8ytHliSsoohPBIFYXbWT-W4OgzikviHE0hgS1CtZ472>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 18:02:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Yoichi Nakayama <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH v3] worktree repair: detect relative path in .git file
 correctly
In-Reply-To: <pull.2205.v3.git.1787344586470.gitgitgadget@gmail.com> (Yoichi
	NAKAYAMA via GitGitGadget's message of "Fri, 21 Aug 2026 20:36:26
	+0000")
References: <pull.2205.git.1786799480344.gitgitgadget@gmail.com>
	<pull.2205.v3.git.1787344586470.gitgitgadget@gmail.com>
Date: Fri, 21 Aug 2026 15:02:42 -0700
Message-ID: <xmqq8q5zyvwd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
>
> Given a state in which the cross-references between the worktree and
> the repository (specifically worktree/id/gitdir in the main repository
> and the .git file in the worktree) are recorded using absolute paths,
> setting 'worktree.useRelativePaths=true' and running 'git worktree
> repair' within the main worktree converts them to relative paths.
>
> Conversely, given a state in which the cross-references are recorded
> using relative paths, one would expect that setting
> 'worktree.useRelativePaths=false' and running 'git worktree repair'
> would convert them to absolute paths. However, they remain as relative
> paths.
>
> This is because we incorrectly use read_gitfile_gently(), which always
> returns an absolute path. To fix this, introduce read_gitfile_raw(),
> which is almost identical to read_gitfile_gently(), but skips checking
> the existence of the referenced repository and returns the path as-is
> from the .git file.

Excellent observation of the problem addressed by the patch.  I wish
everybody wrote his or her proposed log message this clearly.

> diff --git a/setup.c b/setup.c
> index 95909e9603..9041827336 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -962,16 +962,48 @@ void read_gitfile_error_die(int error_code, const char *path)
>   * cases).
>   */
>  const char *read_gitfile_gently(const char *path, int *return_error_code)
> +{
> +	int error_code = 0;
> +	const char *slash;
> +	struct strbuf contents = STRBUF_INIT;
> +	static struct strbuf realpath = STRBUF_INIT;
> +
> +	error_code = read_gitfile_raw(&contents, path);
> +	if (error_code)
> +		goto cleanup_return;
> +
> +	if (!is_absolute_path(contents.buf) && (slash = strrchr(path, '/'))) {
> +		size_t pathlen = slash+1 - path;
> +		char *dir = xstrfmt("%.*s%s", (int)pathlen, path, contents.buf);
> +		strbuf_reset(&contents);
> +		strbuf_addstr(&contents, dir);
> +		free(dir);
> +	}

This massages path = "worktrees/foo/.git" into "worktrees/foo". And
the non-absolute contents.buf "../main/.git/worktrees/foo" that is
relative to gitfile is turned into relative to cwd of our process by
prepending "worktrees/foo" to it.

> +	if (!is_git_directory(contents.buf)) {
> +		error_code = READ_GITFILE_ERR_NOT_A_REPO;
> +		goto cleanup_return;
> +	}

This ensures that the thing referenced by .git file (i.e., what
comes after "gitdir:") is a sanely formatted git directory.

> +	strbuf_realpath(&realpath, contents.buf, 1);

This turns the thing into an absolute path.

Among these three, the last one obviously belongs here.  Leaving the
relative path relative was the reason why we wanted to add
read_gitfile_raw() in the first place.

But moving the other two to here is a bit iffy.  The worktree repair
job used to call read_gitfile_gently(), which means it used to
depend on what the first two did for it, namely, to make the
relative path after "gitdir:" from the .git file relative to the
current process to make it usable, and to ensure that the directory
pointed at by .git is indeed a git directory.  Is it correct to drop
these from the caller, which now calls read_gitfile_raw() instead?

IOW, I am not sure if the two functions are split correctly.  I
expected that the only two things read_gitfile_gently() would do
after read_gitfile_raw() are (1) upon error, jump to cleanup_return,
and (2) otherwise call strbuf_realpath().

Thanks.
