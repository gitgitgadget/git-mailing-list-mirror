Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726A62571B0
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760449136; cv=none; b=XTM0agm/5yKvDMO6jKV9IuwHVzmHhWQ/uBxa0fcPC5U0pg+rnczMCzUdrajdzuuYOiOqKS0piobQ0oKgpnhvxjfp128FMBXgP6yGlTn+MU2tX6CgxgNKkYN0/PnYYwTAKColkxj4ZJkmQijxd2DLjabAMXs1PR4E/BQ84AP8tSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760449136; c=relaxed/simple;
	bh=TDRJK5jQS1IqxgTMgfH1Ee+dSW/MQErSKO/IUx+9peg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIQ8hetDwz0j3e4tUKZGMw4I5a97YqHSvN4AGXKE5H6PtCPNTCCZa7PtstztUNhPM+EVmJwtDZehzfDxkh60LqPfpbp9zAaR90Ynu3dknQI6AF3RoboaP20FFdL7JUzklnakE07rWZZzKzSx4B4nHSB2IVFZ/w4I6HYkTEhwy9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFpRT+RK; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFpRT+RK"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-8e3eaa30c71so3739708241.0
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 06:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760449133; x=1761053933; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IPjnoyEjckr6joysb0yMvePNXYp4WNi9D9YoPx5uMnM=;
        b=fFpRT+RKrxkB71dSIPTbkUTK02YBGnteXs7RVCxFuYZVOIpIhgQnYMiq+3Tb9OEgCx
         YGA2MjLWNkWTay+SzULNwD1Y8CoeQ1SaoEnT5j3aQOTwGu85lWxHPNg6OafPul2Fi9BY
         TcghaWGd3/avvU2qIeUAwMGqsrGzwx2ENMourpuzNdbAOkh4w0cpXEouZiPxdQPIiSyK
         CUbbCtaDSfUHXUMg96YzJEI3B9jeLwKShnk698OEMlpooq0OlJaHimoGtB77DFEkUAhM
         yaDKUzsNDcOf8gaM/PdTDfqojig9IyJj5wPYpAfLuotJjCIzDtgwxOvHkX+HGfN9X4w2
         0YdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760449133; x=1761053933;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPjnoyEjckr6joysb0yMvePNXYp4WNi9D9YoPx5uMnM=;
        b=ExA6LdMW+wKpkhiHwNMrThp6b0PPatRQygkzju2/PsLOxsDmnpoPJqHfBNnTJ8TA8u
         yqmcGBwbdyOUtjmHs46so1AdOCotFdSdNVk6AuSjYwMLtHOO8B48rL5Qt+Wxd9mIjkl9
         TCsKC8jXRIrARKym6RTu4sqq1uUamIEWWfI8zCLiKyg0N0Z37+DUHQAXAdD5IIvMIN4P
         8aIXOhDxizneGuBxJCZKGAoWUrCf6XJAVlUgjPcaIkTCOLbm4GxKgl+EhRF5gVqGuU8V
         b5Koej38SXrJXd3GpxrPWG5mxG79vHRQwpvYcHeVclHVo0PqJoZSs72w+7m1P+gKO5jI
         10Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWEwwoWEs/L6vaLbfp+SBw47js+IUPcnThZWi77PX9ktZgjcSQsMUFCo6kB620obNon/40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRKvrSFahyBPv7lXhFC3R3hrn6pNT1EFdYIs+7CPX+3zzZ8EuQ
	RjvRnqNS6jUepfeanwM8QKmrxWczT4W16D6xznq7goW4ssrDRwreZ8JXBbL5/T8nPUqsKQMLGLn
	3mROkNpaWKGgkR8ZetAOQspINnKoDc5g=
X-Gm-Gg: ASbGncuHcrg32J3Tf/KgILE/aORJcOxKjvLAnyVNceFvFISm1z0PukJ2dYmRjd5zxpU
	AsbgcNsJvjWBvWAtkBfQbuafQkhgLxwY0pChfkpVLpHKOju3tzi1U/bCzEm/VJ51ry8C7AOM58L
	wBCluni2iCV1zJ+yhDOoQrJ3ImKVL/SkrC/6mUFeYijDOxVUh/yRgSwWUnsku+Bt13L1p8p6stp
	tGDzTxz5TRqAw5YIAWZM8pJkCO0cA4NADxvSH+G0//g05AnkKpEeyIY0RCaNBlRNnySCpNW0gzY
	2ooFoA==
X-Google-Smtp-Source: AGHT+IEa+jt26aFXYBvP+A+fZxlBVjx0M2nDLjBa19IbIj63GFNC/7OBtok9vLtDgm4rx4j0HURdoIMDKd5p2jS/E/s=
X-Received: by 2002:a05:6102:b03:b0:5d6:101a:9f31 with SMTP id
 ada2fe7eead31-5d6101a9f6emr3399726137.31.1760449133247; Tue, 14 Oct 2025
 06:38:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Oct 2025 09:38:51 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Oct 2025 09:38:51 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251001-b4-pks-history-builtin-v4-12-8e61ddb86317@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im> <20251001-b4-pks-history-builtin-v4-12-8e61ddb86317@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Oct 2025 09:38:51 -0400
X-Gm-Features: AS18NWBWvQX3lcma-5DE5YegUOXZAZbfkM6fCuyjqW6Y4Ram3R9PpETR6hVUNi8
Message-ID: <CAOLa=ZTnsHxK2+rRsAErY_zc1Rg5WNrmcDBiPgDk38zb9TNfkQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/12] builtin/history: implement "split" subcommand
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000003ba14606411e8172"

--0000000000003ba14606411e8172
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> It is quite a common use case that one wants to split up one commit into
> multiple commits by moving parts of the changes of the original commit
> out into a separate commit. This is quite an involved operation though:
>
>   1. Identify the commit in question that is to be dropped.
>
>   2. Perform an interactive rebase on top of that commit's parent.
>
>   3. Modify the instruction sheet to "edit" the commit that is to be
>      split up.
>
>   4. Drop the commit via "git reset HEAD~".
>
>   5. Stage changes that should go into the first commit and commit it.
>
>   6. Stage changes that should go into the second commit and commit it.
>
>   7. Finalize the rebase.
>
> This is quite complex, and overall I would claim that most people who
> are not experts in Git would struggle with this flow.
>
> Introduce a new "split" subcommand for git-history(1) to make this way
> easier. All the user needs to do is to say `git history split $COMMIT`.
> From hereon, Git asks the user which parts of the commit shall be moved
> out into a separate commit and, once done, asks the user for the commit
> message. Git then creates that split-out commit and applies the original
> commit on top of it.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-history.adoc |  62 ++++++
>  builtin/history.c              | 225 +++++++++++++++++++++
>  t/meson.build                  |   1 +
>  t/t3452-history-split.sh       | 432 +++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 720 insertions(+)
>
> diff --git a/Documentation/git-history.adoc b/Documentation/git-history.a=
doc
> index b55babe206..83d675afea 100644
> --- a/Documentation/git-history.adoc
> +++ b/Documentation/git-history.adoc
> @@ -10,6 +10,7 @@ SYNOPSIS
>  [synopsis]
>  git history [<options>]
>  git history reword [<options>] <commit>
> +git history split [<options>] <commit> [--] [<pathspec>...]
>
>  DESCRIPTION
>  -----------
> @@ -40,6 +41,26 @@ rewrite history in different ways:
>  	provided, then this command will spawn an editor with the current
>  	message of that commit.
>
> +`split [--message=3D<message>] <commit> [--] [<pathspec>...]`::
> +	Interactively split up <commit> into two commits by choosing
> +	hunks introduced by it that will be moved into the new split-out
> +	commit. These hunks will then be written into a new commit that
> +	becomes the parent of the previous commit. The original commit
> +	stays intact, except that its parent will be the newly split-out
> +	commit.
>

So in essence we do this:

  Before split:
  P1 =E2=94=80=E2=94=80 C0 =E2=94=80=E2=94=80 C1 =E2=94=80=E2=94=80 ... =E2=
=94=80=E2=94=80 CN
        =E2=94=94=E2=94=80(target)         =E2=94=94=E2=94=80(HEAD)

  After split:
  P1 =E2=94=80=E2=94=80 S0 =E2=94=80=E2=94=80 C0' =E2=94=80=E2=94=80 C1 =E2=
=94=80=E2=94=80 ...... =E2=94=80=E2=94=80 CN
        =E2=94=82     =E2=94=94=E2=94=80(modified original)  =E2=94=94=E2=
=94=80(HEAD)
        =E2=94=94=E2=94=80(split-out hunks)

I do wonder if S0 should contain the existing message and the new
message should go to C0'. So perhaps more like

  After split:
  P1 =E2=94=80=E2=94=80 C0' =E2=94=80=E2=94=80 S0 =E2=94=80=E2=94=80 C1 =E2=
=94=80=E2=94=80 ..... =E2=94=80=E2=94=80 CN
        =E2=94=82      =E2=94=94=E2=94=80(split-out hunks)  =E2=94=94=E2=94=
=80(HEAD)
        =E2=94=94=E2=94=80(modified original)

Mostly because when you say split, I would assume we keep the original
as is and add on top of it. I don't really have a strong argument though
:)

[snip]

> +EXAMPLES
> +--------
> +
> +Split a commit
> +~~~~~~~~~~~~~~
> +
> +----------
> +$ git log --stat --oneline
> +3f81232 (HEAD -> main) original
> + bar | 1 +
> + foo | 1 +
> + 2 files changed, 2 insertions(+)
> +
> +$ git history split HEAD --message=3D"split-out commit"
> +diff --git a/bar b/bar
> +new file mode 100644
> +index 0000000..5716ca5
> +--- /dev/null
> ++++ b/bar
> +@@ -0,0 +1 @@
> ++bar
> +(1/1) Stage addition [y,n,q,a,d,e,p,?]? y
> +
> +diff --git a/foo b/foo
> +new file mode 100644
> +index 0000000..257cc56
> +--- /dev/null
> ++++ b/foo
> +@@ -0,0 +1 @@
> ++foo
> +(1/1) Stage addition [y,n,q,a,d,e,p,?]? n
> +
> +$ git log --stat --oneline
> +7cebe64 (HEAD -> main) original
> + foo | 1 +
> + 1 file changed, 1 insertion(+)
> +d1582f3 split-out commit
> + bar | 1 +
> + 1 file changed, 1 insertion(+)
> +----------
> +

It's really nice to have examples.

[snip]

> +
> +static int cmd_history_split(int argc,
> +			     const char **argv,
> +			     const char *prefix,
> +			     struct repository *repo)
> +{
> +	const char * const usage[] =3D {
> +		N_("git history split [<options>] <commit>"),
> +		NULL,
> +	};

should be '*const' here.

> +	const char *commit_message =3D NULL;
> +	struct option options[] =3D {
> +		OPT_STRING('m', "message", &commit_message, N_("message"), N_("commit =
message")),
> +		OPT_END(),
> +	};
> +	struct oidmap rewritten_commits =3D OIDMAP_INIT;
> +	struct commit *original_commit, *parent, *head;
> +	struct strvec commits =3D STRVEC_INIT;
> +	struct commit_list *list =3D NULL;
> +	struct object_id split_commits[2];
> +	struct pathspec pathspec =3D { 0 };
> +	int ret;
> +
> +	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
> +	if (argc < 1) {
> +		ret =3D error(_("command expects a revision"));
> +		goto out;
> +	}
> +	repo_config(repo, git_default_config, NULL);
> +
> +	original_commit =3D lookup_commit_reference_by_name(argv[0]);
> +	if (!original_commit) {
> +		ret =3D error(_("commit to be split cannot be found: %s"), argv[0]);
> +		goto out;
> +	}
> +
> +	if (original_commit->parents && original_commit->parents->next) {
> +		ret =3D error(_("commit to be split must not be a merge commit"));
> +		goto out;
> +	}

Do we need this? Since we also check for merges in `collect_commits()` belo=
w.

> +	parent =3D original_commit->parents ? original_commit->parents->item : =
NULL;
> +	if (parent && repo_parse_commit(repo, parent)) {
> +		ret =3D error(_("unable to parse commit %s"),
> +			    oid_to_hex(&parent->object.oid));
> +		goto out;
> +	}
> +
> +	head =3D lookup_commit_reference_by_name("HEAD");
> +	if (!head) {
> +		ret =3D error(_("could not resolve HEAD to a commit"));
> +		goto out;
> +	}
> +
> +	commit_list_append(original_commit, &list);
> +	if (!repo_is_descendant_of(repo, original_commit, list)) {
> +		ret =3D error (_("split commit must be reachable from current HEAD com=
mit"));

s/error /error/

> +		goto out;
> +	}
> +

This is also checked within collect_commits(), no?

> +	parse_pathspec(&pathspec, 0,
> +		PATHSPEC_PREFER_FULL | PATHSPEC_SYMLINK_LEADING_PATH | PATHSPEC_PREFIX=
_ORIGIN,
> +		prefix, argv + 1);
> +
> +	/*
> +	* Collect the list of commits that we'll have to reapply now already.
> +	* This ensures that we'll abort early on in case the range of commits
> +	* contains merges, which we do not yet handle.
> +	*/

Comment spacing is off here.

> +	ret =3D collect_commits(repo, parent, head, &commits);
> +	if (ret < 0)
> +		goto out;
> +
> +	/*
> +	 * Then we split up the commit and replace the original commit with the
> +	 * new new ones.
> +	 */

s/new/new

> +	ret =3D split_commit(repo, original_commit, &pathspec,
> +			   commit_message, split_commits);
> +	if (ret < 0)
> +		goto out;
> +

This one was straight forward, it handles adding the hunks to the index
creating the two commits and linking them.

> +	replace_commits(&commits, &original_commit->object.oid,
> +			split_commits, ARRAY_SIZE(split_commits));
> +

Nice. We use the function introduced earlier to replace the replace the
commits with the new two commits.

> +	ret =3D apply_commits(repo, &commits, parent, head, "split");
> +	if (ret < 0)
> +		goto out;
> +
> +	ret =3D 0;
> +
> +out:
> +	oidmap_clear(&rewritten_commits, 0);
> +	clear_pathspec(&pathspec);
> +	strvec_clear(&commits);
> +	free_commit_list(list);
> +	return ret;
> +}

[snip]

The tests look good. Nothing to add there.

--0000000000003ba14606411e8172
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 46e1366f040e30da_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qdVVtb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMzlYQy80NVJINGkwYjZOT1F6alIrblM4NUpuQ3RFdQpGRm5hNER3ZTNO
NjAxQlJRcUJoOFlvSXoxZE92SEtjZkRSQk9rZ0JWaEprdWJZOWVwQXVFNEVGRklpWmdxcVlICnZT
Y2NSbDY3SFprVEhUYUdYU2U2VEtUTHNSc0N1K0M3amVqQzhWZ2h0TWxzWmpWVUJzRTZxc0UxNE8y
UWNYWHQKSkNPV3VUQk8xZTYxUnd6WU96OFhObEEvRUV4QUI1MzlUZkpibzZsK1l1bkdZUGwzUHFo
OHkyaVhwSURGVnNQQgpZUzk5YVNKZTY4OGlIZXN0MG5BL3JoUHV6K2RwR0p0b0JrMlQwM0ZPY0kv
WXc2Nzd4K3V5U2trWUx0K2V1YUJVCnFXYi91cVhxNitIOE9zbk9MUkQzdWhCYWRmZVlOM3pOaGUx
STlSU2t3MU1xRFByNnU1bFh2SytqNXlBR1NIZEsKM1RYblJ0WUI5b3lPMVV4U1pHNVFwWFdhYzN6
K1J5d3Vua0hQR0FTT2dIblNmZE5LenV5YkI1MUVnamJVMHRaZApTamxjRS9BYlVxeFhycE00VnBU
dmFRQ0xxTFgwc29YaEZUWStJWGxlTW1BWUtTZzhvN2M5eHZVQ1pXT3dhM21uCnpUckJFanE5Zm1p
Z2N5UVNxUkcvT3NqZHgrazJYc2dqVnJzYTBwZz0KPUlrSVEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003ba14606411e8172--
