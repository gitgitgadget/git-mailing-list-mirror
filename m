Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7349241103
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753540492; cv=none; b=GOqbp8o8xD55Pg+neHy1UDV5CcjW/jyvBr9h6/s9NJOdS8ZYlt6rNLQn5u+1yMaOhov4GOr2YeVaDr//M2V0XjF31TuOIefz6bz833ZChJfVSG4k8RCsRVrFf5JC7P7XLF9OD6if+tgm/IR9iRGvLYEgNvCKrArUAmRJ0kTyXfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753540492; c=relaxed/simple;
	bh=QDOGlPzuWJDVuopbf27qpiRnDIcOhFGzzqkdkFF99dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VLwX0HoklJsIe/7sjTbZdPnTJ+/0oMo6FqbpZude4YiMm52g9rkrg2HiBGP6voN+MFvaNduoxEeXu5diggm4PP6FVLKRyc9t7L/dnXHXuSQR2pJF1RNvH/LXTH0mcTAG5V6cM6CrfxXdH6h3TrJ2WLxMhU64qPctJaQ5+9/r8zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7LDkBRt; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7LDkBRt"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso5730020a12.1
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 07:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753540489; x=1754145289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54cUlqJUZWE6OowFmMwnD5/bO0XpzOJZnUgHPdKoTFM=;
        b=Q7LDkBRt2Pb4CvUI0zIBvNTqYSs26kOeJSZCOIybgqXsMpwljPTNBBY+y81lnR0Vs/
         Pr2jjXeRq6PvYydINfSV4Is3pFiMnTgAFXaeqr9oBHgZafJzU5TVK09cLRgjHuTmai8c
         SG8j+J7i0mgSPdNiL7Sv9DrLQTPyJXiHd/w6mVnT2GpS8GIwnqYprtUHtH+jnQrKyHeK
         ovw4jlul+45UpsEYGzHVOMxc8GJWOCfJUajQRCvcKLR0N4GOAil447Pj5hS2HSqaVZwo
         o77HIvYXAr5ITU+oVBzB0ceSQG9zD7/rwHXD/EPTV2xNDY+vUpPcRrnfmTHtK7PBCVIb
         1ztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753540489; x=1754145289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54cUlqJUZWE6OowFmMwnD5/bO0XpzOJZnUgHPdKoTFM=;
        b=AZ3XUcQ+3/kXH+rXzMXX5X9V2kcQhzEJqbUN7DZZgc6hK+vH2SRE0WX2DbWrGTYlSJ
         CFkYA+47Jm61g+ktUZzbCEZJxUJVVQRmUxr1lw5bMCFp01QeRYgSTMw+KNKpeTSDfrYR
         cD+9OvpntAy4lLKFTIeL/jmUyXFu0feoHT249snvcCGwE18VWixz+NK5Jju0lOox/T7k
         jD70VvaIKI/G6laEAn27nd+w3mvdUtdJ46wScM5nUHzNMQSk2VOmmMQu6qqno0xLiVFh
         FwOauFJtBFabU9d4dRZsZWhAbqnET9tJCByRmK/BVWe0CVoEq1wz7PTxoy71tPH2RC2O
         1SAw==
X-Gm-Message-State: AOJu0YzLW5O8P70SjJEZcI22TDi8Y49AwVVKZar8CdO9mFVL4FY88vAR
	QPvuzM1kC4rbbOkDLhfKe0wHPALfGhRZ93QLc0VbNtOXXFNQ0iWtnih9nX8X6My/jYYU3waz+Bj
	QKc9VlmffCJmp1mZa3HmUzm3NP+9ssZra7wJM
X-Gm-Gg: ASbGnctQWWa6KwibzYOIf7KpTP6D5gBtzAkSOi4vUiNVpTyr4mfu+i7qug+UCrsCb7b
	kUUVhX6YldRvwXXAWD8/aRNiYQLrgn7F3kHwUvKr3cipiBpaXB5q380PWvdqEfUrUuQqhEUhiSK
	7EbrbbywdgGo1y1y0og52uQXGE/6rCSDbyDnQXRGDKqr4Et7qCvJlyCTQ8DGauXc4dzqwULFmpN
	VkyTVk9VRWx0meXG18CIdXC2+MBBI9wYIUFgThM8g==
X-Google-Smtp-Source: AGHT+IFhTNh1xLqe3EoYGytJ8vvPLzdNbpYUqzN+0mZqJHrQcA2zThUTr/GtU+6O0Gf1y1KOJwssxJmcA0SyCzQjFPE=
X-Received: by 2002:a17:907:7ea5:b0:ae0:da2d:1a53 with SMTP id
 a640c23a62f3a-af619415d4cmr707859266b.42.1753540488978; Sat, 26 Jul 2025
 07:34:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcya63cqx.fsf@gitster.g> <20250721115519.140361-1-usmanakinyemi202@gmail.com>
 <20250721115519.140361-2-usmanakinyemi202@gmail.com>
In-Reply-To: <20250721115519.140361-2-usmanakinyemi202@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 26 Jul 2025 10:34:37 -0400
X-Gm-Features: Ac12FXyRVQ3_ypFCDP9TSEJTRRNNXIgAuZsUBsyTxQbHf5kAy79qgoPSs-riK3A
Message-ID: <CALnO6CCN0HUXJVYmvAJO3EoQQZzHVjE0P=g+AUc9c5Ti0Rcm2w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] t/t1517: automate `git subcmd -h` tests outside a repository
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, chriscool@tuxfamily.org, 
	christian.couder@gmail.com, me@ttaylorr.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 7:55=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> Replace manual `-h` tests with a loop over all subcommands using
> `git --list-cmds=3Dmain`. This ensures consistent coverage of `-h`
> behavior outside a repo and future-proofs the test by covering
> new commands automatically.
>
> Known exceptions are skipped or marked as expected failures.
>
> Suggested-by: Patrick Steinhardt <ps@pks.im>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
>  t/t1517-outside-repo.sh | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
> index 6824581317..9fcebb7d94 100755
> --- a/t/t1517-outside-repo.sh
> +++ b/t/t1517-outside-repo.sh
> @@ -110,8 +110,29 @@ test_expect_success LIBCURL 'remote-http outside rep=
ository' '
>  test_expect_success 'update-server-info does not crash with -h' '
>         test_expect_code 129 git update-server-info -h >usage &&
>         test_grep "[Uu]sage: git update-server-info " usage &&
> -       test_expect_code 129 nongit git update-server-info -h >usage &&
> -       test_grep "[Uu]sage: git update-server-info " usage
>  '
>
> +for cmd in $(git --list-cmds=3Dmain)
> +do
> +       cmd=3D${cmd%.*} # strip .sh, .perl, etc.
> +       case "$cmd" in
> +       archimport | cvsexportcommit | cvsimport | cvsserver | daemon | \
> +       difftool--helper | filter-branch | fsck-objects | get-tar-commit-=
id | \
> +       http-backend | http-fetch | http-push | init-db | instaweb.sh | \
> +       merge-octopus | merge-one-file | merge-resolve | mergetool | \
> +       mktag | p4 | p4.py | pickaxe | quiltimport | remote-ftp | remote-=
ftps | \

Hm=E2=80=94if we strip the suffix with ${cmd%.*}, do we need a p4.py patter=
n
too? Actually, at first I wondered why we need to strip the suffix at
all. My local Git produces only unsuffixed commands. But
bin-wrappers/git produces both p4 and p4.py; request-pull and
request-pull.sh; and several others. So I think stripping is probably
right, just drop the .py pattern.

> +       remote-http | remote-https | replay | request-pull | send-email |=
 \
> +       sh-i18n--envsubst | shell | show | stage | submodule | svn | \
> +       upload-archive--writer | upload-pack | web--browse | whatchanged)
> +               expect_outcome=3Dexpect_failure ;;
> +       *)
> +               expect_outcome=3Dexpect_success ;;
> +       esac
> +       test_$expect_outcome "'git $cmd -h' outside a repository" '
> +               test_expect_code 129 nongit git $cmd -h >usage &&
> +               echo "Hello" &&

Woops! While basing some work on this branch, I spotted this "echo"=E2=80=
=94I
assume it's leftover and didn't mean to be included here? Will drop
locally for my own work.

> +               test_grep "[Uu]sage: git $cmd " usage
> +       '
> +done
> +
>  test_done
> --
> 2.50.0
>
>

Last thing: outside the patch context, there's a test for prune that
should probably get tweaked like the update-server-info test.


--=20
D. Ben Knoble
