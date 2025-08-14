Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F851552FD
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755133211; cv=none; b=t2O+PZimG5CB0nK7+Cmp2jDFCbOy+C/kbid+5thqCWMm4PxY/Weg3Yv4V4pJKlxgPAnfQoQPPtdloP8MiBN+l3R+0fz1iOcMkfkXufCz9KqQI2mzuJC/jyDgcqznvm8nanuB4Etn33kADS756PZKAon5fIh8U3YFta9sIxkEDZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755133211; c=relaxed/simple;
	bh=Hefc3c890X1UoYnsrwv9Qv2e0Zs0y9WMlnYFmml8790=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbhO0w09U5B659Ee6KxGdoHUteglTphchFvgu85x2kfgXt4yccBMaUqDGhgQcutpNepSVpreUTfTqBENmJxhEYsFcWDT0zYmUA5tRboaPxkAEnhLw5yHDTh0UTEH062t2aXU4cjGfX+mWaQzd5lS8TBxD77jteWXMUIxzbPXcII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3m69Rnh; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3m69Rnh"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad4f0so600974a12.0
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 18:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755133207; x=1755738007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuLgARRzGB0bRMu7KClyMxKaHj5rupoq+pjQchEB1sw=;
        b=L3m69Rnh8/RaIxsMwkcCwlqGccOWuPNpRl6TAD5urcnnVRF5iT8P8462lGD1x9ediH
         X2IuRApiYTMDauo85aArOinsVz47zyFNB/ffHY/FB1AfsQZVsUC/KYcmWrFT1+c1iibn
         epOECbyFZl5ByrpvmkV3S2v0ZkKHMCIHHKIDanrV/DpBd40YBRhYv74R+JDW/6nGPPuC
         mdH4ETeugTQHQ3M4vpzyN1jY2gSD0qayFaIBPgkr+6/9DYKf+AZarxEZq5ViNo5VbTZc
         EPlBqxFiPluri9pmjNoThTfxOhTX4yEuNT3FtCIhHIj0BH2bmRrhAlMe+IS//HPDENoB
         0H6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755133207; x=1755738007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuLgARRzGB0bRMu7KClyMxKaHj5rupoq+pjQchEB1sw=;
        b=nXsHNKL5Fqsi2OtH/kjFiqJmKRpiwowoGc7H4otjTTh3zr9gID+sH2u27rekdKhuZL
         uqwVz9Wips1Lg09Kv9kkP0RIiuZyZqsw1oYGrMNROo6oH7FdgWK7OglsgNDa/0l8iTLZ
         d9QNVP5ouNCAaBowdF+xXaRvahahHOYeDcpWoM+Z3j5S3Q20Iat/mVj/jc7zLoWkUnF1
         Q2dn+a4/+fNFXSp7NOijlttBFNh5ZK89JBU7eZOr0gik9ZwHTqbzOxw4EqyMqW5cimWg
         F7/pJ+195pcnl88AGi+WUj1IOWLda/E3vf6N3gcD+anGeaLN0/xVCZtZZRuCgQvkyxdS
         b0Bw==
X-Gm-Message-State: AOJu0YxqGz2jbaom/iyNciZU5ls6hnoruuHjjsyrdMtxYcPBjp+/Wq2G
	ZUnA0l7vTUOW26KK3hKGkTMOEI2uGysHnepiqSHkHRZqEzcTLrvfKFqX1sQ2kCOcmyGmXq15Q/6
	9gCP93JCIDpDXsKQJ9PoL5v8HdzH3kE/XGlm2
X-Gm-Gg: ASbGncvCbVk22VUqVDuLjVY34qKdnPH3A6sy08QAp/1kF+hzeFteNZijrhJ2LQNCKGg
	mnxU7PPex/gSBnqpSLcLEsKxRj/bWqzwDO2c+aqNi3QfoZHnfRut/6x3CdWl+gTd3NrVIdUY91X
	wvhRx4/W6tBnz2OfZJ0C/ez//GHthckFJMPRSLUicPbXIn8Ws248R7YkhyJIQlRmHH4MahGOIsF
	0RE9xI2NqFXv6jy4C7FjaKF5MyGycv+5SwnbeYeNw==
X-Google-Smtp-Source: AGHT+IExOQHHxlxMYwVWd/gcPwvd1cvZF2sNZ4IU8/3tTYsbcVq5GbjmtxjExWD1rOiCQw/+BmicsOWUfWXHk6b8sbc=
X-Received: by 2002:a17:907:7213:b0:ae3:b22c:2ee8 with SMTP id
 a640c23a62f3a-afcb98e198bmr94708266b.37.1755133207275; Wed, 13 Aug 2025
 18:00:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
 <pull.1952.v2.git.1755127218.gitgitgadget@gmail.com> <63c9e0361dc02c15afeea3cad1656e1631637f60.1755127218.git.gitgitgadget@gmail.com>
In-Reply-To: <63c9e0361dc02c15afeea3cad1656e1631637f60.1755127218.git.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 13 Aug 2025 20:59:54 -0400
X-Gm-Features: Ac12FXx6hIUVd8emkBd9Yn-dg11UQc2-TK_bc-LDH1mJ2lOmsyLn6cJAyTXT3zI
Message-ID: <CALnO6CA2bv0CHcEW-n=VU0xZXHgSrpXV_Dc3Q+HAGV7=Mr-_8Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] doc: git-add: simplify discussion of ignored files
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 7:20=E2=80=AFPM Julia Evans via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Julia Evans <julia@jvns.ca>
>
> - Mention the --force option earlier
> - Remove the explanation of shell globbing vs git's internal glob
>   system, it's a common gotcha but I don't think this is an appropriate
>   place to explain that concept. There's some discussion of the gotchas
>   around globbing and `git add` in the EXAMPLES section which I think
>   is clearer.
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  Documentation/git-add.adoc | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
> index 949b016e6fa2..75e223f6b1ea 100644
> --- a/Documentation/git-add.adoc
> +++ b/Documentation/git-add.adoc
> @@ -39,12 +39,11 @@ you must run `git add` again to add the new content t=
o the index.
>  The `git status` command can be used to obtain a summary of which
>  files have changes that are staged for the next commit.
>
> -The `git add` command will not add ignored files by default.  If any
> -ignored files were explicitly specified on the command line, `git add`
> -will fail with a list of ignored files.  Ignored files reached by
> -directory recursion or filename globbing performed by Git (quote your
> -globs before the shell) will be silently ignored.  The `git add` command=
 can
> -be used to add ignored files with the `-f` (force) option.
> +`git add` will not add ignored files by default. You can use the

Not worth a re-roll on its own, but this is another instance where
starting a sentence with `git add` seems odd to me.

The range-diff in v2 looked good to me overall.

--=20
D. Ben Knoble
