Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415331A0BDB
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738912562; cv=none; b=j86JY5OxLBwHAWBY71DLhP1AKSOFIuZM2YaDWuHvkcKnDQXJ1/h8XJVRna462sjNO0qn//EYENccjiSy3M9OMdcDCq3fiIbbe0A/myPtGEaC2KRrGhV5rmTEopZ7ryu8GokPcNbZpL6AeiQV0x8/VFFu5Gr7100wRkCKW0Rqhvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738912562; c=relaxed/simple;
	bh=kagFcMPTFWn/LGCU1pIKMjmGME29fvb9vlGtdzwOMOs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=K++Ja4m4uCzmydWfX1EUyEco2FWi1m4QxgK/U3iv4qP1UdEpAD09I5ea8K++g0O7kbAtKxZeYEQ18ocHg45GBEThj7kJuYlVlT1kyLNh3VV5UXknCIub3HH+Sd/wb6yV/Y1oLyua4+lu6fWPM3iPKq3En4Ee24uHqwntc/zSyqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqeUcxdR; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqeUcxdR"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5189105c5f5so1029265e0c.0
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 23:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738912560; x=1739517360; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xFH9clvxZATVa9ZycNwdM2wFC8fnc4Tn1T+mXa5irrc=;
        b=AqeUcxdRgZ0o/AJ0q30M7dia4OhvoYT0AJWdOOTCkL/7hVuEhAxhQ2bD6fEg1L5p3P
         iPKUpZvxhgmotDmzfvH9Qq/BvhvrMyKqp78TYu/dSvm8gemPqNjQnVhgDTI2XCpg0oap
         FRFCSm2pxuzDt9fQaL1lmG0N3mIS4qAdoIZmpF0qdFxINAVYrVFfPj31ubEQmJw9ZGxN
         uXnuRR/qkwvhN5jcAi3Zm3rCAx60aDWTafEfZamgMJkSxiFN9LRAu7SP8/EqMFEUaPa6
         R1KHAaY6n/VMp1CvKq/HdbdIaZc7RjnZQWCpVLt5X04hGaNYnEhtXKdtFD7QapnJHPUF
         0EwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738912560; x=1739517360;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFH9clvxZATVa9ZycNwdM2wFC8fnc4Tn1T+mXa5irrc=;
        b=MPCMQCHU5MlLnNQ/b/y+J4w1J4VhBe8288/pllsHdEO4VD0LBIFUnwuXinMHTrS32M
         sJiMVpfeM1XaSn2Kj3Og4I4O/npEWCOXMjLKqMDvXdnogiP0XeIC/c+XvBLrTYImK9zy
         r88y0M8hXobeH7LdmpEX5rdmwUT4dI7OrqPK0bgjv8iJQ2UApdgM98mPVwTts+58JpBh
         n4BRU60slFcn12JO2X2y9xHsmCR7fqx0bAMCe6jHZTnA2Hj1KJ/PwdhzlyPaAUXatGWM
         sAnHDLy9jlqweSRyXPcpkDc8MGH1Z2imC2+qiJ/KxN9oc8ZFgLdJDV3nviaZcFeJZKcl
         pOmw==
X-Forwarded-Encrypted: i=1; AJvYcCV4+WQRtA3J4To/AI1aFl1mlYQ0g4n9TAvsw50i3aQgf9GtlAkkkcP3oXM8Bf90cfDOVG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtzhPlaykhUqXQf7Q0tEY14W+Va8RPi59DE1nm207RWu90Aw4c
	gdllV+IHEz/UmLkc8XGyu/n2603M4BGOBlJe5tSC2tOYCgXWm211XuQ985FAU2MjRXynEtwzmzl
	z3XOw8ymbaIG4Ai9A1wqvYG8r/YOX9Ntc
X-Gm-Gg: ASbGnctIWXbA1K6FhAju7dAVprsJKoHBOy3ZETl3U7Sh3cvZPF+a5UX1IUmC86FxxBH
	fUQtPqPXtgrnS22IPQMReI+lPh9dIYtg9B+DqaEx3Q4kOFzSqU1Gx7fz6smsilJRllLdTJA1LaG
	GorIIW1p2JtCP6UiBiZW9A9FUbxGgul+4=
X-Google-Smtp-Source: AGHT+IFPHnOGWxJd3vcG4J7PPV/09KtikL/LHrn5Re45ebY9zZo672RFy7BCKAxS+84nF3lSlNts3qxu1PmKQE/SJFw=
X-Received: by 2002:a05:6122:3126:b0:51e:f800:f7cf with SMTP id
 71dfb90a1353d-51f2e286ae5mr1190253e0c.10.1738912559926; Thu, 06 Feb 2025
 23:15:59 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Feb 2025 23:15:58 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250206-b4-pks-path-drop-the-repository-v1-9-4e77f0313206@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
 <20250206-b4-pks-path-drop-the-repository-v1-9-4e77f0313206@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Feb 2025 23:15:58 -0800
X-Gm-Features: AWEUYZmL2DRndTvnpELCgEkzLN2xkVcQlqtnRxa05zDLQlKRu949zyjnybB8dnk
Message-ID: <CAOLa=ZSXFqvwFEfJ+cktqzSUf0XMoFC8Z0S0DJHcg4jYN4+DcA@mail.gmail.com>
Subject: Re: [PATCH 09/16] worktree: return allocated string from `get_worktree_git_dir()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000006e32c1062d88217c"

--0000000000006e32c1062d88217c
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The `get_worktree_git_dir()` function returns a string constant that
> does not need to be free'd by the caller. For `repo_get_git_dir()` and
> `repo_get_common_dir()` this is because we return strings owned by
> `the_repository`.
>

Not sure what the second sentence is signifying here. What relation does
`get_worktree_git_dir()` have with `repo_get_git_dir()` and
`repo_get_common_dir()`?

> But for `git_common_path()` it's a bit less obvious though, because that
> function does end up allocating memory. This doesn't result in a memory
> leak either because we write into a buffer returned by `get_pathname()`,
> which returns one out of four static buffers.
>

Now `git_common_path()`, what is binding all these functions together?
Sneaking down to the code, it looks like `get_worktree_git_dir()` calls
one of the other three functions. Maybe we should start with that?

>
> We're about to drop `git_common_path()` in favor of `repo_common_path()`,
> which doesn't use the same mechanism but instead returns an allocated
> string owned by the caller. While we could adapt `get_worktree_git_dir()`
> to also use `get_pathname()` and print the derived common path into that
> buffer, the whole schema feels a lot like premature optimization in this
> context. There are some callsites where we call `get_worktree_git_dir()`
> in a loop that iterates through all worktrees. But none of these loops
> seem to be even remotely in the hot path, so saving a single allocation
> there does not feel worth it.
>
> Refactor the function to instead consistently return an allocated path
> so that we can start using `repo_common_path()` in a subsequent commit.
>

This makes sense.

[snip]


> diff --git a/revision.c b/revision.c
> index 474fa1e767..be72f226f3 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1874,15 +1874,20 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
>  	for (p = worktrees; *p; p++) {
>  		struct worktree *wt = *p;
>  		struct index_state istate = INDEX_STATE_INIT(revs->repo);
> +		char *gitdir;
>

Nit: should this be named `wt_gitdir` to stay consistent?

>  		if (wt->is_current)
>  			continue; /* current index already taken care of */
>
> +		gitdir = get_worktree_git_dir(wt);
> +
>  		if (read_index_from(&istate,
>  				    worktree_git_path(the_repository, wt, "index"),
> -				    get_worktree_git_dir(wt)) > 0)
> +				    gitdir) > 0)
>  			do_add_index_objects_to_pending(revs, &istate, flags);
> +
>  		discard_index(&istate);
> +		free(gitdir);
>  	}
>  	free_worktrees(worktrees);
>  }

[snip]

> diff --git a/worktree.c b/worktree.c
> index 8f4fc10c44..3b94535963 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -59,8 +59,9 @@ static void add_head_info(struct worktree *wt)
>  static int is_current_worktree(struct worktree *wt)
>  {
>  	char *git_dir = absolute_pathdup(repo_get_git_dir(the_repository));
> -	const char *wt_git_dir = get_worktree_git_dir(wt);
> +	char *wt_git_dir = get_worktree_git_dir(wt);

Nit: here too, even though it is a pre-existing name. Perhaps it is just
me. So feel free to ignore :)

>  	int is_current = !fspathcmp(git_dir, absolute_path(wt_git_dir));
> +	free(wt_git_dir);
>  	free(git_dir);
>  	return is_current;
>  }
> @@ -175,14 +176,14 @@ struct worktree **get_worktrees(void)
>  	return get_worktrees_internal(0);
>  }
>
> -const char *get_worktree_git_dir(const struct worktree *wt)
> +char *get_worktree_git_dir(const struct worktree *wt)
>  {
>  	if (!wt)
> -		return repo_get_git_dir(the_repository);
> +		return xstrdup(repo_get_git_dir(the_repository));
>  	else if (!wt->id)
> -		return repo_get_common_dir(the_repository);
> +		return xstrdup(repo_get_common_dir(the_repository));
>  	else
> -		return git_common_path("worktrees/%s", wt->id);
> +		return xstrdup(git_common_path("worktrees/%s", wt->id));
>  }
>

So this is the crux of the patch, we allocate the string for the first
two function's return value to ensure that `get_worktree_git_dir()`
returns a string which needs to be free'd. Alright!

--0000000000006e32c1062d88217c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 31b598b4f91dfc1b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lbHN5c1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNkt5Qy80MDhHQTRTdXptZFVNd1dWTDJ5YlZsTWJrcApFU0VFUEo1TUVn
M1BxaVVHSFNFYmxWbHVwblh0dXl3STBwT0puRUd3dE1BdTRlT3FhbjZTcCtsTmsrOTFzU3Z0CmJN
dnZuSmdZTmdyWkE2Rk44YzlkeFV4a0pOa2tnQVRuQVpNZjV2YkFiRDlBTXlGRzVSYi9kaWpvUTVD
RkJ2cTUKcCtmQUk2MWR6M0NsblhnSWM0RTNScW9DNk5PR2lrL0x4ZU1xTGVtQnZybCtXMlZUOHdI
S0ZHM3hPM0xzcTRQQQpHblkvbUJvVjVtSlRqWFp5ZTVxMVROdlVUL0t1Z09tS3NnSHdLOHU1ZzVz
YVpkSjM0aTFadjdEc2RrblArQUZRCnBnbStOaFRmVFd1aHRGUmZmTkJQYXhLUVBIam42M0F5Z0ha
SSswTld1eE5MUGpyUlhSeUQrTjdzYTMwOENVTGkKRFZRNkEyTElHNjRuNVNRc3RmSDl4N0Nuc0lG
Y0hHdlJWRjdhY2xzdk9DWi8wQndiT2p4aFVncWZkRFpKcGMvagpRMTZFZWM2YzhCV0U1a3pzU3oy
cU00bG5sWUdkdHdzMjJmUVZxeVZ1NWcxa1RGeEJVL0x4V01kdDBKR0hNR1VRCnNEblRJaXF1b3Q3
TFlDYmdZcmZ0NGpqV1ZTR3J2L21MalJzbE1rTT0KPWN3WkMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006e32c1062d88217c--
