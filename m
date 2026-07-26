Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DBC266B72
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785079706; cv=none; b=nvElxegxM9e89Jtxk6Dmuj2TYiGX1Ib0/xYZG7AYWZn4s0y36tReXcX7dcPq2iLXQI6N8702AsxKHRNthOlWXuhMxU7I+fBma1oEaSwkJ3sQFQGCKLc3zQ8uJygES4SxouFbbyPSsxPPdTbrSEWncLP5gyL8mbVDK2VjvqjJg7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785079706; c=relaxed/simple;
	bh=QWEYl56Z7TuZRuCZWeHMXWzlkC2zE4MH0IQAVGeKwbU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qIkMYU8oPk5FvgS9ynMnkWoDLiCYhhV5qxT6i1C6iF3b2wLPOhNiQYggftW9KDqW5d6GMbZwUOh41hK8J2itbqwkJ41trfVOJnRMbagabaeJbSJ6bNCYLwy2Pg7Tp6FfW5H4JEU0SEC5BDksRUdokduCjkD1bLVGHerLubcQamg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHTSzZFM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHTSzZFM"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-472326ca506so1257456f8f.2
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 08:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785079703; x=1785684503; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wWc4QdK/RhFLMkIueH3orj4Hl7h+INosB9TQIEXjfrk=;
        b=gHTSzZFM5PSztVO6GDUMrUx4ObkD3TDpir8vAdzcaYztE9D/vZ2Ih5/C5a3d1MluXZ
         W6wO98BKURccJeP4vAQBlE6eqcleeooShLWEayUutMhTXR92S3VH+DUYbt4px+DdRBxp
         4ycl0EBOoOR6oy3LGj+CvK0dqm9a36qvqbb0fa6yAaDIgdK1yNGkViPe/uayEXEYpTeq
         02KNz5mDgcRNiWE7ik4+OgBW7+iFNQxClyS6gzoyyPjFQZE7jyh4uyH3dRJ6w1lWwNxO
         Nv1A5z2xc+NyTRITBy0LDgZ7iePuGN6+F5ORrDtKFucA+ZMfgrEXgnArD7IdMxPKzsaH
         QSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785079703; x=1785684503;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wWc4QdK/RhFLMkIueH3orj4Hl7h+INosB9TQIEXjfrk=;
        b=qul4L14VQduHEEgb8cfzLBZ5YIiQx3E31r2oxJSktVnDc6xP8ro00ODvpghfAjHHQr
         v/P0rJXLpQ0FQYjKB8h3nUbCa7Q9vbEslUNReu0hO4KmbxcCYnwqQSpb3C/LFbT98hzE
         2sb0NI8U4VrBuO53fpohgeBBPNqGYXEmqYuAmo9kS6PLq938JbqERB6WEKrhMkiLmht3
         HxFHiaZ4ASoo6BXmAX9/q5N64F0e09Auuon0pmWrqpYM54n9UC50yrtRQ/H2GKIhuDEL
         Nj+z3nXbNgJUkDChM25SLKYvjdwB8SSkl+6ocW9vdO30rcuvnhH1vRpzQ2RGEIvAkvYZ
         iBrw==
X-Forwarded-Encrypted: i=1; AHgh+Ro73wY12gguIaZVX0+bQNME3KSNygM13BSbsS9BImjuO8HUL85hfvBqVNKF/H+FvGQ+zKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2bMB5Yfphbo2lgGgi3L29CLOAAgvDidVE7JwULYtt7kMkcjUT
	VBcn7NQX0LqBEdnik1Let8VrIgUtK0Yy4TiLYjNizvR3xGDNKCUAtpgQ
X-Gm-Gg: AR+sD1232TbX0mZp9sPF2H6WRhNf/xZAIcLwR0wielfgXDgyTAR4yeDjROSm8vFPlpu
	pcmlMFzjaZRpPgekUNhig8kMVdB7u+AZu9lkKGZWZpcbDqe6e9ysYu+DB2C0roPPI6AifHnZ8XB
	vZYjUUgg37NlPRfBItUbrSdeaELRAc86GDNAdeEJN9EA4UYG7yHla6xJUwYjE6h9K1tIsTJF62q
	0viuLhASaBZKc2FhnGu1VCeQ0LgaoyVqko5e3Wp2gRceWnTcsinioR6i2SMWtcG0FYGt0O+aVoR
	o74pQO7PNTU3s6knEpNaXQoE9kfcGPeLw1fLXMrR6vIwu1WDNhN6dTBPqKzhf2EcATtkKe8Geqj
	1F2YvlTtGtgKCYNZ8lxJ47uwR2A2sL29w0Q4VpjYSaVI+FHB5SSnPosn6fOmhu6NY8R2dcWFGsw
	dODPTKWnWkrX97dFIqf+85j7NrYElu6S4DQ0xC8C7cxpeiup98uQ6zUGIcWGuggyH6HrS7wAMdK
	PP8mp/qvc+DZEyY7Yz9EnXl6gVRxdfkQYv/BMIT44+DBrj0rlPXC1bK1I8HetSc9vIpdtH4OdRX
	KdIgnxmWp9PaIRTbxuzbkvU8uzeLIaSYalk6tsP8nDDAvEHczsNLw3yhXdTH9Ena0A==
X-Received: by 2002:a05:6000:41eb:b0:47f:4650:e45c with SMTP id ffacd0b85a97d-47f9fc867c2mr7195330f8f.12.1785079702467;
        Sun, 26 Jul 2026 08:28:22 -0700 (PDT)
Received: from localhost (81.red-176-87-232.dynamicip.rima-tde.net. [176.87.232.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c66cebsm41067195f8f.30.2026.07.26.08.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2026 08:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 26 Jul 2026 17:28:20 +0200
Message-Id: <DK8LXXC1AXDS.MFS49865S0NF@gmail.com>
Cc: "Ben Knoble" <ben.knoble@gmail.com>, "Lucas Zamboni Orioli"
 <lucaszam0@gmail.com>
Subject: Re: [PATCH v3 2/2] mv: check for missing destination directory
 before renaming
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>,
 <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <pull.2356.v2.git.git.1784812390.gitgitgadget@gmail.com>
 <pull.2356.v3.git.git.1784842831.gitgitgadget@gmail.com>
 <5ac15873623a3f519b01aa7419c579a310be164b.1784842831.git.gitgitgadget@gmail.com>
In-Reply-To: <5ac15873623a3f519b01aa7419c579a310be164b.1784842831.git.gitgitgadget@gmail.com>

On Thu Jul 23, 2026 at 11:40 PM CEST, Lucas Zamboni Orioli via GitGitGadget=
 wrote:
> From: Lucas Zamboni Orioli <lucaszam0@gmail.com>
>
> Moving a file into a directory that does not exist fails at rename(2)
> with ENOENT. The checking phase already rejects a missing destination
> directory when the destination ends in a slash, but a destination that
> names a file inside a non-existent directory is not caught and only
> fails later at the syscall. The same is true when a leading path
> component exists but is not a directory: rename(2) fails with ENOTDIR,
> again only at the syscall. As a consequence "git mv -n" does not detect
> either problem: the dry run never reaches rename(2) and reports a move
> that would not actually succeed.
>
> Detect this during the checking phase. For entries that will be renamed
> on disk, stat the destination's leading directory and fail with a
> suitable message if it is missing or is not a directory. stat() is used
> rather than lstat() so that the check follows symlinks the same way
> rename(2) does: a symlink to a directory is accepted, while a symlink to
> a file is rejected. A missing directory or a non-directory path
> component (ENOENT or ENOTDIR) reuses the existing "destination directory
> does not exist" message; a leading component that resolves to a
> non-directory reports "destination is not a directory". Other stat()
> errors fall through to rename(2), which reports them as before.
>
> Add tests covering the missing directory, a path component that is a
> file, a symlink to a file, a symlink to a directory (which must still
> succeed), and dry-run detection.
>
> Signed-off-by: Lucas Zamboni Orioli <lucaszam0@gmail.com>
> ---
>  builtin/mv.c  | 24 ++++++++++++++++++++++++
>  t/t7001-mv.sh | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 35e504484a..08e27484f2 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -444,6 +444,30 @@ dir_check:
>  			goto act_on_entry;
>  		}
>
> +		/*
> +		 * If we are going to move SRC to DST on disk, DST's leading
> +		 * directories must already exist.
> +		 */
> +		if (!(modes[i] & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
> +				!(dst_mode & (SKIP_WORKTREE_DIR | SPARSE))) {

nit: indentation.

> +			char *dst_dir =3D xstrdup(dst);
> +			char *slash =3D strrchr(dst_dir, '/');
> +
> +			if (slash) {
> +				struct stat dir_st;
> +				*slash =3D '\0';
> +				if (stat(dst_dir, &dir_st) < 0) {
> +					/* other errors fall through to rename(), which reports them */
> +					if (errno =3D=3D ENOENT || errno =3D=3D ENOTDIR)
> +						bad =3D _("destination directory does not exist");
> +				} else if (!S_ISDIR(dir_st.st_mode))

nit: the if above has braces, this else if should too.

> +					bad =3D _("destination is not a directory");
> +			}
> +			free(dst_dir);
> +			if (bad)
> +				goto act_on_entry;
> +		}
> +
>  		if (ignore_sparse &&
>  		    (dst_mode & (SKIP_WORKTREE_DIR | SPARSE)) &&
>  		    index_entry_exists(the_repository->index, dst, strlen(dst))) {
> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> index 7cf4aa5ba1..c878fb92a8 100755
> --- a/t/t7001-mv.sh
> +++ b/t/t7001-mv.sh
> @@ -114,6 +114,55 @@ test_expect_success 'clean up' '
>  	git reset --hard
>  '
>
> +test_expect_success 'moving to a non-existent path component in the dest=
ination' '
> +	git reset --hard &&
> +	mkdir -p from &&
> +	echo content >from/file &&
> +	git add from/file &&
> +	test_must_fail git mv from/file no-such-dir/file 2>actual &&
> +	test_grep "destination directory does not exist" actual
> +'
> +
> +test_expect_success 'moving to a destination with a file as a path compo=
nent' '
> +	git reset --hard &&
> +	mkdir -p from &&
> +	echo contents >from/file &&
> +	echo blocker >not-dir &&
> +	git add from/file &&
> +	test_must_fail git mv from/file not-dir/file 2>actual &&
> +	test_grep "destination is not a directory" actual
> +'
> +
> +test_expect_success SYMLINKS 'moving to a destination with a symlink to =
a file as a path component' '
> +	git reset --hard &&
> +	mkdir -p from &&
> +	echo contents >from/file &&
> +	echo target >regular &&
> +	ln -s regular link-to-file &&
> +	git add from/file &&
> +	test_must_fail git mv from/file link-to-file/file 2>actual &&
> +	test_grep "not a directory" actual
> +'
> +
> +test_expect_success SYMLINKS 'moving to a destination with a symlink to =
a directory' '
> +	git reset --hard &&
> +	mkdir -p from realdir &&
> +	echo contents >from/file &&
> +	ln -s realdir link-to-dir &&
> +	git add from/file &&
> +	git mv from/file link-to-dir/file &&
> +	test_path_is_file realdir/file
> +'
> +
> +test_expect_success 'mv --dry-run detects non-existent destination paren=
t directory' '
> +	git reset --hard &&
> +	mkdir -p from &&
> +	echo content >from/file &&
> +	git add from/file &&
> +	test_must_fail git mv -n from/file no-such-dir/file 2>actual &&
> +	test_grep "destination directory does not exist" actual
> +'
> +
>  test_expect_success 'moving to existing untracked target with trailing s=
lash' '
>  	mkdir path1 &&
>  	git mv path0/ path1/ &&


The rest looks good.

Regards,
Pablo

