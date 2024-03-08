Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5F82C1BA
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709939435; cv=none; b=aRGcJP/lX4v5AwBFerOQ8E5FFJMeybdK3h1aWcIl+m6SH101QPlqGKVSGln4BmS83BtML0mJS3xsLKoRNN1MKl8vDdEw9MmEun2zjkHdqS60nNLaZdsZvUK2CSQT1aEPu7iZ2DSY4YX8LqjECsVO+ayv9Xo75Sk6SEPHJAEz1ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709939435; c=relaxed/simple;
	bh=a65VO8DKDRnDZQukB/0ZUx0LD2LeAFvQn7/c0Q6t9z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FwyzJGA1Y1vEtx/b1ujd4xm4yDv1C/kZoBc6UIc9f6dK1P84F4Q3m+d7i5BmT2SsUr5bRvBZNLtSja6dl2qCNPT3PlfLPI9pmaxhzzIHGpsGNuqeQuqBNmNBsqyIiPu85oYDSZX3eYP9ibT20LlBifz7gsS0ZKdiaLoW3SlQwJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sNoPJKGq; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sNoPJKGq"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a45ecef71deso146984366b.2
        for <git@vger.kernel.org>; Fri, 08 Mar 2024 15:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709939432; x=1710544232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbkZDRxegnsMShW+soKgJOK5NH6Va28OudvagmATcRs=;
        b=sNoPJKGq8lKHfviM83qjy/DZCFC5/tHL2Jy5p/aOjXgXRrtNY2Ag8Xbv+qC9qsDuMC
         7SiP9msSD5fa9hSn6MR+UumcCqM3R74Kta6TLNKp7uC17F+dTXM09RKR7EA99G04MXHT
         R+hX/uvZs0UFNPCY+/VWMQyWd7b/XSgBj0kfl0//EL+aMhAoIz8GJ3tjWKLSZA4QmcDQ
         EpKCgEdqQ5mqtgroJ0zVXFd0qCZbcjztsF8w763onzv1CEunpqS1udjzz0zNV5Xtik61
         1B4aa5mzcKPpu3CDjYN9eyHEm6REIxlFLzatNHWR3Kp+ANOb8+7zETHOGwVICPT7L1mK
         V9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709939432; x=1710544232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbkZDRxegnsMShW+soKgJOK5NH6Va28OudvagmATcRs=;
        b=sZRclIT4vbRrPALjT7/Ocoz7fTKOcpuRz3S8WdjjBc71EgbjrdaEigmjjXo/WUwjXF
         eNr6xJO6I9vz31rH2Un6sbC/hhrXasIhJCU1gA67Y7G84Y2gXu8MTEVSSVrKoO8PS7kp
         8zLkQIM8VtiXP05ORWbcvZLrqhwrmoBbAaEK1GzIOzgNcRdJ/IKhJ5Ui0VaGc7WMvw11
         fCNVeIdPgIWTYl+4DMMlFsjLzTFK6Cmzflnm0R+AbQC2xU8AQ8AJX5jigHe6B13j1xBy
         +zrM8430NVAdLxYHplt6+fY1ZE5imWFu+bOwtiLzU8vBkvqUKGS5ruJfZ5VtD2Y3qmLI
         tZGg==
X-Gm-Message-State: AOJu0YyzEzrHuX75v4P4cRKFtrEH7Phc4ERRkPXYHbCVOwXJoGKM5Rsd
	sWKUb7w+1e8NoN+O7msz2+VA1AHhwQwfBvWNMOnzd47Y686QyhW844KQXqYQZHNl9XisYkzJiB3
	sFjo57SsbqZ6A2B7M2HNiIaGW2LrHnQ9D3rPQSfR0aL1OdQsGW4eF
X-Google-Smtp-Source: AGHT+IE/2p5o9fSmO5tUxTfB2EIqsQLYIqwPUmRP4p1yCQ4zuz3i3pE2E+9P2kHmm46JN+796ucXrQZOpqeAJnwdoSo=
X-Received: by 2002:a17:906:eb11:b0:a44:46a:e904 with SMTP id
 mb17-20020a170906eb1100b00a44046ae904mr55823ejb.50.1709939431730; Fri, 08 Mar
 2024 15:10:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqv85zqniu.fsf@gitster.g> <20240308211957.3758770-1-gitster@pobox.com>
 <20240308211957.3758770-3-gitster@pobox.com>
In-Reply-To: <20240308211957.3758770-3-gitster@pobox.com>
From: Kyle Lippincott <spectral@google.com>
Date: Fri, 8 Mar 2024 15:10:16 -0800
Message-ID: <CAO_smVjrKJeKr7QgQWryZRErStFk=Y+1T=dwrR_boXQD_X9_Mg@mail.gmail.com>
Subject: Re: [PATCH 2/2] setup: make bareRepository=explicit work in GIT_DIR
 of a secondary worktree
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 1:20=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> If you have /var/tmp/primary/ as a repository, and if you create a
> secondary worktree of it at /var/tmp/secondary/, the layout would
> look like this:
>
>     $ cd /var/tmp/
>     $ git init primary
>     $ cd primary
>     $ pwd
>     /var/tmp/primary
>     $ git worktree add ../secondary
>     $ cat ../seconary/.git

Nit: typo, should be `secondary` (missing the `d`)


>     gitdir: /var/tmp/primary/.git/worktrees/secondary
>     $ ls /var/tmp/primary/.git/worktrees/secondary
>     commondir  gitdir  HEAD  index  refs
>     $ cat /var/tmp/primary/.git/worktrees/secondary/gitdir
>     /var/tmp/secondary/.git
>
> When the configuration variable 'safe.bareRepository=3Dexplicit' is
> set to explicit, the change made by 45bb9162 (setup: allow cwd=3D.git
> w/ bareRepository=3Dexplicit, 2024-01-20) allows you to work in the
> /var/tmp/primary/.git directory (i.e., $GIT_DIR of the primary
> worktree).  The idea is that if it is safe to work in the repository
> in its working tree, it should be equally safe to work in the
> ".git/" directory of that working tree, too.
>
> Now, for the same reason, let's allow command execution from within
> the $GIT_DIR directory of a secondary worktree.  This is useful for
> tools working with secondary worktrees when the 'bareRepository'
> setting is set to 'explicit'.
>
> In the previous commit, we created a helper function to house the
> logic that checks if a directory that looks like a bare repository
> is actually a part of a non-bare repository.  Extend the helper
> function to also check if the apparent bare-repository is a $GIT_DIR
> of a secondary worktree, by checking three things:
>
>  * The path to the $GIT_DIR must be a subdirectory of
>    ".git/worktrees/", which is the primary worktree [*].
>
>  * Such $GIT_DIR must have file "gitdir", that records the path of
>    the ".git" file that is at the root level of the secondary
>    worktree.
>
>  * That ".git" file in turn points back at the $GIT_DIR we are
>    inspecting.
>
> The latter two points are merely for checking sanity.  The security
> lies in the first requirement.
>
> Remember that a tree object with an entry whose pathname component
> is ".git" is forbidden at various levels (fsck, object transfer and
> checkout), so malicious projects cannot cause users to clone and
> checkout a crafted ".git" directory in a shell directory that
> pretends to be a working tree with that ".git" thing at its root
> level.  That is where 45bb9162 (setup: allow cwd=3D.git w/
> bareRepository=3Dexplicit, 2024-01-20) draws its security guarantee
> from.  And the solution for secondary worktrees in this commit draws
> its security guarantee from the same place.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  setup.c                         | 52 ++++++++++++++++++++++++++++++++-
>  t/t0035-safe-bare-repository.sh |  8 ++++-
>  2 files changed, 58 insertions(+), 2 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 3081be4970..68860dcd18 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1231,9 +1231,59 @@ static const char *allowed_bare_repo_to_string(
>         return NULL;
>  }
>
> +static int is_git_dir_of_secondary_worktree(const char *path)
> +{
> +       int result =3D 0; /* assume not */
> +       struct strbuf gitfile_here =3D STRBUF_INIT;
> +       struct strbuf gitfile_there =3D STRBUF_INIT;
> +       const char *gitfile_contents;
> +       int error_code =3D 0;
> +
> +       /*
> +        * We should be a subdirectory of /.git/worktrees inside
> +        * the $GIT_DIR of the primary worktree.
> +        *
> +        * NEEDSWORK: some folks create secondary worktrees out of a
> +        * bare repository; they don't count ;-), at least not yet.
> +        */
> +       if (!strstr(path, "/.git/worktrees/"))

Do we need to be concerned about path separators being different on
Windows? Or have they already been normalized here?

> +               goto out;
> +
> +       /*
> +        * Does gitdir that points at the ".git" file at the root of
> +        * the secondary worktree roundtrip here?
> +        */

What loss of security do we have if we don't have as stringent of a
check? i.e. if we just did `return !!strstr(path, "/.git/worktrees/)`?
Or maybe we even combine the existing ends_with(.git) check with this
and do something like:

static int is_under_dotgit_dir(const char *path) {
        char *dotgit =3D strstr(path, "/.git");
        return dotgit && (dotgit[5] =3D=3D '\0' || dotgit[5] =3D=3D '/');
}



> +       strbuf_addf(&gitfile_here, "%s/gitdir", path);
> +       if (!file_exists(gitfile_here.buf))
> +               goto out;
> +       if (strbuf_read_file(&gitfile_there, gitfile_here.buf, 0) < 0)
> +               goto out;
> +       strbuf_trim_trailing_newline(&gitfile_there);
> +
> +       gitfile_contents =3D read_gitfile_gently(gitfile_there.buf, &erro=
r_code);
> +       if ((!gitfile_contents) || strcmp(gitfile_contents, path))
> +               goto out;
> +
> +       /* OK, we are happy */
> +       result =3D 1;
> +
> +out:
> +       strbuf_release(&gitfile_here);
> +       strbuf_release(&gitfile_there);
> +       return result;
> +}
> +
>  static int is_repo_with_working_tree(const char *path)
>  {
> -       return ends_with_path_components(path, ".git");
> +       /* $GIT_DIR immediately below the primary working tree */
> +       if (ends_with_path_components(path, ".git"))
> +               return 1;
> +
> +       /* Are we in $GIT_DIR of a secondary worktree? */
> +       if (is_git_dir_of_secondary_worktree(path))
> +               return 1;
> +
> +       return 0;
>  }
>
>  /*
> diff --git a/t/t0035-safe-bare-repository.sh b/t/t0035-safe-bare-reposito=
ry.sh
> index 8048856379..62cdfcefc1 100755
> --- a/t/t0035-safe-bare-repository.sh
> +++ b/t/t0035-safe-bare-repository.sh
> @@ -31,7 +31,9 @@ expect_rejected () {
>
>  test_expect_success 'setup bare repo in worktree' '
>         git init outer-repo &&
> -       git init --bare outer-repo/bare-repo
> +       git init --bare outer-repo/bare-repo &&
> +       git -C outer-repo worktree add ../outer-secondary &&
> +       test_path_is_dir outer-secondary
>  '
>
>  test_expect_success 'safe.bareRepository unset' '
> @@ -86,4 +88,8 @@ test_expect_success 'no trace when "bare repository" is=
 a subdir of .git' '
>         expect_accepted_implicit -C outer-repo/.git/objects
>  '
>
> +test_expect_success 'no trace in $GIT_DIR of secondary worktree' '
> +       expect_accepted_implicit -C outer-repo/.git/worktrees/outer-secon=
dary
> +'
> +
>  test_done
> --
> 2.44.0-165-ge09f1254c5
>
