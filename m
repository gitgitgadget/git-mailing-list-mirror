Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3C722258C
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748879786; cv=none; b=E3vYY3zB3HF0EvD0AWoZJvue8XkKmV5LttqUwoRIfkPbx3G2Bye6GVI/XqexCYOJfTcsg5OLg1ZVxRxY630qbL4oUhAU8BYx1COqdJj4AOzVdbE/a1ATl7mFMOiB+2oZxztgdxDkV5BbBbtDdRmFa3LpzsqW1q18zwt6kFkhkL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748879786; c=relaxed/simple;
	bh=9/lGApchKkUJr9rNOj0es5xGtnTyXAluAAJE81nluQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j9mTedu0Tsy/VUEbSLxXP5PqnzxUJvNrTnx7hcFW6FgPzq8tCzGw7o6iJQe18BWq7c0aMvW4uoKp8fyj0vkkwb50v7e9xVtC2OxDczdPz1onFPzihihbIGyqP/TOJ78NfS/lZzd3bB1hqxIhpddyKnfSz/+xt/Oqm6f1jKKdinI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evq7l4QC; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evq7l4QC"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad1d1f57a01so23143566b.2
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 08:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748879782; x=1749484582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSEMliLx4gvyAJuSRRIGvxoc3Kex60iuPSTffBIJ4DU=;
        b=evq7l4QCymbJu4sASlMtQ7uPYFppjSuUTKMZvvh00zTxBk07+kQnfFDm3ItIhrXAHO
         5kNrG2gGn4WFGS1u6W5mu1a0yXvD6rotwLmrpNSDC1ASMFWiUCbkTmq40MjXdYnTIvvB
         D0IhpuXUiOeUmGXTMkYfuwSdu1iHBW2WrQEHN+w8yBuDMhPVPji2uHbbbLxBwQ+fm1bW
         hBeq+ue+C7SexwqFJRU/gxtkxhMdBGieDe7KAS89aDGZWVx6jxaHZMrtcMErykoMTPbg
         QsXJl9EoIl4ozdEdwedBA60F9i9YCaxKZoMlKXNRrlX46sfYP92J33m8fwCUtqsT3lZm
         JVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748879782; x=1749484582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSEMliLx4gvyAJuSRRIGvxoc3Kex60iuPSTffBIJ4DU=;
        b=kiLLSGDrt7JVr+tWVMIVm/+SPansd6UykJ3vDfC58fU4u53Bj8UZlzzLwxauvcqxAn
         rg3lMR7/GNqv5HEaOAERRmKvEYKeT/F6SdB+Soro0eDGMCmjamAFDPUJSt8LYiXl3/UA
         ZM4Eyruy4lGZiMOEcQwzFpDOr6E5uHeV+FJhyDs1tgyKLdK6Ejnm/f6JG6jemhD2mScZ
         SJE9evrJvp8kZZdAVi9FY3QWyJYkxeNQaFSbEcA1tht0uDam+sfotskKMniuZj+z+ps7
         1gORAyU8u3F4rLqt5DpinNQFggpiyWrNhkDqjUXWQum3gAxYQ8l0tkA4uaJTYIGV5F58
         kq1w==
X-Forwarded-Encrypted: i=1; AJvYcCW8g1z9CUuYKhJes9/Xmzos4oGHjBQmpNDs7T9UqbH4jwidfyKZmcX2ITQlHbPHmVsxkHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXLuZAW4pM1nNZVIaRUWkNUIn6/7HbT29CLdMHgTmHXDgvUQlP
	W+GPJg2Um4iWL0lRaoqmlaBB12b96YY3zubsfeN3ZHvYic62k9YCIxfo7OnJUSWLNoqRsmmf9FY
	Enp9FjyLgbEZkLDSVTYFE9Yu/pNuG3o4=
X-Gm-Gg: ASbGnctcsYVWuU6UNkOx63RRv97cq+bj9zgSd4j0sLmxugVH/zV5jGIXKQSKitvJo+v
	R/aexyI/fukd+Dl3c24r2sMowVudyqnzXtXS+P3CGcx5FO+8lj6ZqI8gv/wrOuKFp3P3CmdGqAm
	lZD/5GBeXMVvyWcXxSH4Dc5yVsr2g/lMhTZQk=
X-Google-Smtp-Source: AGHT+IHJCzJGChldwfyFcqmch6WjugXxCah2Ii9ANUd1L/ZVZr9mPTQ5Mj1fL77QT5Mzx+OZHOMsA0A4ioPPZ3y17Qs=
X-Received: by 2002:a17:907:6ea6:b0:ad5:7732:675b with SMTP id
 a640c23a62f3a-adb3243181bmr1217991266b.40.1748879782094; Mon, 02 Jun 2025
 08:56:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424203904.909777-1-christian.couder@gmail.com>
 <xmqqselxtfyf.fsf@gitster.g> <CABPp-BHudzADoYdBvoBZ1yDRj7Ra_V-or6ddAOV6nmXeMMpMaw@mail.gmail.com>
 <xmqq1pthtbdg.fsf@gitster.g> <CAP8UFD0OdqnoFeYY+7y-No_x_DknapoLzvqvsy-+x_602sYQbg@mail.gmail.com>
 <xmqqzfeyqdye.fsf@gitster.g> <xmqq8qmgsky8.fsf@gitster.g>
In-Reply-To: <xmqq8qmgsky8.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 2 Jun 2025 17:56:10 +0200
X-Gm-Features: AX0GCFsq9A2Em4r9d7Mumy4-Cuq6xM-_sq92xu1W1aAKz7DfoDO3ZAxQGU6ySoM
Message-ID: <CAP8UFD2i-ayL7vs=Y46DpYkv64ROBj0YHNHEbbaG76mLTncyEQ@mail.gmail.com>
Subject: Re: [PATCH] fast-(import|export): improve on the signature algorithm name
To: Junio C Hamano <gitster@pobox.com>
Cc: Luke Shumaker <lukeshu@datawire.io>, Elijah Newren <newren@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Sorry for the late answer to this.)

On Wed, May 28, 2025 at 7:29=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Christian Couder <christian.couder@gmail.com> writes:
> >
> >> I agree that we should have at least said in big letters that the
> >> improved support for signed commits in fast-export/import is very
> >> experimental and very likely to change in the future.
> >>
> >> We could still do so. This could give us a bit of time and flexibility
> >> until we agree on and implement something better and backward
> >> compatible. (Hopefully the v2 will help us move forward.)
> >
> > OK, as the next release is approaching, perhaps we do a bit of
> > documentation update to address that "we are experimenting" and
> > nothing else, and leave the v2 updates for the next cycle?

Thanks for this. I agree that it's the best approach.

> ---- >8 ----
> Subject: [PATCH] fast-export: --signed-commits is experimental
>
> As the design of signature handling is still being discussed, it is
> likely that the data stream produced by the code in Git 2.50 would
> have to be changed in such a way that is not backward compatible.
>
> Mark the feature as experimental and discourge its use for now.

Yeah, right.

> Also flip the default on the generation side to "strip"; users of
> existing versions would not have passed --signed-commits=3Dstrip and
> will be broken by this change if the default is made to abort, and
> will be encouraged by the error message to produce data stream with
> future breakage guarantees by passing --signed-commits option.
>
> As we tone down the default behaviour, we no longer need the
> FAST_EXPORT_SIGNED_COMMITS_NOABORT environment variable, which was
> not discoverable enough.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/RelNotes/2.50.0.adoc |  4 +++-
>  Documentation/git-fast-export.adoc | 12 +++++-------
>  Documentation/git-fast-import.adoc |  3 +++
>  builtin/fast-export.c              |  7 +------
>  t/t9350-fast-export.sh             | 20 ++++----------------
>  5 files changed, 16 insertions(+), 30 deletions(-)
>
> diff --git a/Documentation/RelNotes/2.50.0.adoc b/Documentation/RelNotes/=
2.50.0.adoc
> index c6c34d1a1d..9a1cdf0dc0 100644
> --- a/Documentation/RelNotes/2.50.0.adoc
> +++ b/Documentation/RelNotes/2.50.0.adoc
> @@ -100,7 +100,9 @@ Performance, Internal Implementation, Development Sup=
port etc.
>   * "git fsck" becomes more careful when checking the refs.
>
>   * "git fast-export | git fast-import" learns to deal with commit and
> -   tag objects with embedded signatures a bit better.
> +   tag objects with embedded signatures a bit better.  This is highly
> +   experimental and the format of the data stream may change in the
> +   future without compatibility guarantees.
>
>   * The code paths to check whether a refname X is available (by seeing
>     if another ref X/Y exists, etc.) have been optimized.
> diff --git a/Documentation/git-fast-export.adoc b/Documentation/git-fast-=
export.adoc
> index 413a527496..43bbb4f63c 100644
> --- a/Documentation/git-fast-export.adoc
> +++ b/Documentation/git-fast-export.adoc
> @@ -46,14 +46,12 @@ resulting tag will have an invalid signature.
>
>  --signed-commits=3D(verbatim|warn-verbatim|warn-strip|strip|abort)::
>         Specify how to handle signed commits.  Behaves exactly as
> -       '--signed-tags', but for commits.  Default is 'abort'.
> +       '--signed-tags', but for commits.  Default is 'strip', which
> +       is the same as how earlier versions of this command without
> +       this option behaved.
>  +
> -Earlier versions this command that did not have '--signed-commits'
> -behaved as if '--signed-commits=3Dstrip'.  As an escape hatch for users
> -of tools that call 'git fast-export' but do not yet support
> -'--signed-commits', you may set the environment variable
> -'FAST_EXPORT_SIGNED_COMMITS_NOABORT=3D1' in order to change the default
> -from 'abort' to 'warn-strip'.
> +NOTE: This is highly experimental and the format of the data stream may
> +change in the future without compatibility guarantees.

I wonder if it should say that the default is likely to change too?

>  --tag-of-filtered-object=3D(abort|drop|rewrite)::
>         Specify how to handle tags whose tagged object is filtered out.
> diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-=
import.adoc
> index 7b107f5e8e..250d866652 100644
> --- a/Documentation/git-fast-import.adoc
> +++ b/Documentation/git-fast-import.adoc
> @@ -523,6 +523,9 @@ that signs the commit data.
>  Here <alg> specifies which hashing algorithm is used for this
>  signature, either `sha1` or `sha256`.
>
> +NOTE: This is highly experimental and the format of the data stream may
> +change in the future without compatibility guarantees.
> +
>  `encoding`
>  ^^^^^^^^^^
>  The optional `encoding` command indicates the encoding of the commit
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 37c01d6c6f..fcf6b00d5f 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -39,7 +39,7 @@ enum sign_mode { SIGN_ABORT, SIGN_VERBATIM, SIGN_STRIP,=
 SIGN_WARN_VERBATIM, SIGN
>
>  static int progress;
>  static enum sign_mode signed_tag_mode =3D SIGN_ABORT;
> -static enum sign_mode signed_commit_mode =3D SIGN_ABORT;
> +static enum sign_mode signed_commit_mode =3D SIGN_STRIP;
>  static enum tag_of_filtered_mode { TAG_FILTERING_ABORT, DROP, REWRITE } =
tag_of_filtered_mode =3D TAG_FILTERING_ABORT;
>  static enum reencode_mode { REENCODE_ABORT, REENCODE_YES, REENCODE_NO } =
reencode_mode =3D REENCODE_ABORT;
>  static int fake_missing_tagger;
> @@ -1269,7 +1269,6 @@ int cmd_fast_export(int argc,
>                     const char *prefix,
>                     struct repository *repo UNUSED)
>  {
> -       const char *env_signed_commits_noabort;
>         struct rev_info revs;
>         struct commit *commit;
>         char *export_filename =3D NULL,
> @@ -1327,10 +1326,6 @@ int cmd_fast_export(int argc,
>         if (argc =3D=3D 1)
>                 usage_with_options (fast_export_usage, options);
>
> -       env_signed_commits_noabort =3D getenv("FAST_EXPORT_SIGNED_COMMITS=
_NOABORT");
> -       if (env_signed_commits_noabort && *env_signed_commits_noabort)
> -               signed_commit_mode =3D SIGN_WARN_STRIP;
> -
>         /* we handle encodings */
>         git_config(git_default_config, NULL);
>
> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index dda9e7c3e7..76619765fc 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -299,22 +299,10 @@ test_expect_success GPG 'set up signed commit' '
>
>  '
>
> -test_expect_success GPG 'signed-commits default' '
> -
> -       sane_unset FAST_EXPORT_SIGNED_COMMITS_NOABORT &&
> -       test_must_fail git fast-export --reencode=3Dno commit-signing &&
> -
> -       FAST_EXPORT_SIGNED_COMMITS_NOABORT=3D1 git fast-export --reencode=
=3Dno commit-signing >output 2>err &&
> -       ! grep ^gpgsig output &&
> -       grep "^encoding ISO-8859-1" output &&
> -       test -s err &&
> -       sed "s/commit-signing/commit-strip-signing/" output | (
> -               cd new &&
> -               git fast-import &&
> -               STRIPPED=3D$(git rev-parse --verify refs/heads/commit-str=
ip-signing) &&
> -               test $COMMIT_SIGNING !=3D $STRIPPED
> -       )
> -
> +test_expect_success GPG 'signed-commits default is same as strip' '

Here also maybe we should say that the default could change in case
advanced users look at test cases to get hints at what is cast in
stone?

> +       git fast-export --reencode=3Dno commit-signing >out1 2>err &&
> +       git fast-export --reencode=3Dno --signed-commits=3Dstrip commit-s=
igning >out2 &&
> +       test_cmp out1 out2
>  '

Otherwise the patch looks good to me.
