Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDB11FAA
	for <git@vger.kernel.org>; Fri, 16 May 2025 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747412422; cv=none; b=RFs1i62E/wkoqAmG9wufGt0+mzisYS4WEcFvQQnl2b8ZcTI+AJhlKChPO6IVadrxqqbDVWCnJceY6mYArM+n75pz/G9isRRqv5DTw+5PaAM2xf8JchsiWp7kuRat3hnqpSzSYxlmtrNB7pOzoRI/WsnuAYvP8KTDCkzmqVR/TBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747412422; c=relaxed/simple;
	bh=uks8kU2jauYAGTMV+0V6qD6V1Nx5Z3BUkwP0QbY1CtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dgnX1VhM1yehzj0O60r3udCgOWY44g0g8cwXuwKPAuA4BJKcZSAMXxIAvrTFDcEtwxlGb2GPoLl0psE2AZ3VD7bxuhuWwHn1x7W96KJJ3EJGC2nrLcqYHauJ18NxC2euLbrh7I6JkwXh93JgbWXgrVm5P2NbjqhPocyHAmI3oy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfM4TLoI; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfM4TLoI"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-404da7584adso564864b6e.3
        for <git@vger.kernel.org>; Fri, 16 May 2025 09:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747412420; x=1748017220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBkIeMzTObhPJFdnNRUkHnyOYwMxon+QrLfNQ8L5ewE=;
        b=UfM4TLoIOIGo5HI2uxLUcFZ9lqzPyW2/+Yu05GPVunrDSSn8SDkFROoyg7W7Gc9LQ3
         TJpA3A4hKX6KkdTL13gVebwOoN4ZzYyvmtPiI0vv9BgeOJ3mXa+CwAZ5RnpsNjDUBlZ/
         1N2JAEYo5TW/tYbaCg077jJD4NJR8TGkkiV05zPceSnUk/zh/hIIFCVhwHTcfUcw+8RR
         tlcSoG3+xAr3WqKdGXqXXQsOrBZ3FrIktffGImiIoYcacVL505KxigIyvDbxqDBePZdf
         TwFGo8o46X20+4FRQpInpJqMtH5gxV5s8KL484W0CY8RCEfGkp0DmGIEp5EIHRhr+qo8
         mLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747412420; x=1748017220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBkIeMzTObhPJFdnNRUkHnyOYwMxon+QrLfNQ8L5ewE=;
        b=FxLK+JDmbNTI92YA7AttKYhczie3w8+EJFEr/M6zkoVo8/PpxROzk/Or4qcYcAMfXk
         PdXkiWGYtIHYCILJ3sm4XHcRHvhQ1XftwaDAw9Nsm8O29iZ13uWw72BU/JEnXBcJZs4T
         8F/TxRqyLE+Y5+/4ToOyCbwAnwFoEspstzQMvL61Hh2lqk2NKdzzu0cYF0JP1EwkYVCR
         VfqmcwXDYaqEALW3KByh75Nbl8AjuXy09lCCFP3Drlnf6ekvYGCNgsFKq5eiSWF93fTF
         f81NsFMFGCpkmlBLh2ISiv4zS0eLUA9Z4XDNNDc74W20KYpd467Elirhmyd6794ViHuy
         hUEw==
X-Gm-Message-State: AOJu0YxZAKqqgMFr46kYTYPValIhM/cEFaZb9QJ3divksu1wvZdBnPob
	R2MU9WoZ7eAZaIA4GnzzkG5IuL+h9a9HVen4GcQJD4Tf9tKAmSQDVG7Jf9MnMf3m9oHiIDukztU
	yuUvcvMmbY1V2dUuoo+5k5puX35NnUYo=
X-Gm-Gg: ASbGncts/S2cR1omdByG+0ea0y6gfSxLqHOv0wFfrahmOe7cvMeDs5ctDdpePv+dqzu
	aC0orl0RTGrWIzTKfsxHDF7Hkmxx0TkDsx5Ty7sqqd6EWZ4Ot0WdTPM25WwF6lzfvqxULb/8rT4
	58e7cLJRZ70T961rPHzw6k4PBMT+yw6OAJIGF8MK2+33gl+KoRhbp7U8GuPLPpBN7lLA==
X-Google-Smtp-Source: AGHT+IHAPuYUkvNxLGT5fq2wBAQHcJZgrvHmtG4n1zPQnJTS5Mr0eE1tXQjN9F2oZnGB57+oGyjWKviDC6b4QAMyDGY=
X-Received: by 2002:a05:6808:6a89:b0:402:862:93ae with SMTP id
 5614622812f47-404d86e321bmr2685367b6e.16.1747412419804; Fri, 16 May 2025
 09:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1914.git.1746579320.gitgitgadget@gmail.com>
 <pull.1914.v2.git.1747407330.gitgitgadget@gmail.com> <d1482a29d8f23699c713238ba37266fe9efa9aea.1747407330.git.gitgitgadget@gmail.com>
In-Reply-To: <d1482a29d8f23699c713238ba37266fe9efa9aea.1747407330.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 16 May 2025 09:20:08 -0700
X-Gm-Features: AX0GCFt2Hk-V3RZN-SIMKUNOw4STlNiuxJ8auWKbx9WpmDZNoRVEGGk-GGzb_6A
Message-ID: <CABPp-BGdf5emqfnCvmBGxj2WT+d2jvR66tOfkeKiuJ8Np8sh-Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] reset: integrate sparse index with --patch
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, 
	Phillip Wood <phillip.wood123@gmail.com>, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 7:55=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <stolee@gmail.com>
>
> Similar to the previous change for 'git add -p', the reset builtin
> checked for integration with the sparse index after possibly redirecting
> its logic toward the interactive logic. This means that the builtin
> would expand the sparse index to a full one upon read.
>
> Move this check earlier within cmd_reset() to improve performance here.
>
> Add tests to guarantee that we are not universally expanding the index.
> Add behavior tests to check that we are doing the same operations as a
> full index.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  builtin/reset.c                          |  6 ++--
>  t/t1092-sparse-checkout-compatibility.sh | 42 ++++++++++++++++++++++--
>  2 files changed, 43 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 73b4537a9a56..dc50ffc1ac59 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -420,6 +420,9 @@ int cmd_reset(int argc,
>                 oidcpy(&oid, &tree->object.oid);
>         }
>
> +       prepare_repo_settings(the_repository);
> +       the_repository->settings.command_requires_full_index =3D 0;
> +
>         if (patch_mode) {
>                 if (reset_type !=3D NONE)
>                         die(_("options '%s' and '%s' cannot be used toget=
her"), "--patch", "--{hard,mixed,soft}");
> @@ -457,9 +460,6 @@ int cmd_reset(int argc,
>         if (intent_to_add && reset_type !=3D MIXED)
>                 die(_("the option '%s' requires '%s'"), "-N", "--mixed");
>
> -       prepare_repo_settings(the_repository);
> -       the_repository->settings.command_requires_full_index =3D 0;
> -
>         if (repo_read_index(the_repository) < 0)
>                 die(_("index file corrupt"));
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-ch=
eckout-compatibility.sh
> index c419d8b57e84..d8101139b40a 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -384,7 +384,7 @@ test_expect_success 'add, commit, checkout' '
>         test_all_match git checkout -
>  '
>
> -test_expect_success 'git add -p' '
> +test_expect_success 'git add, checkout, and reset with -p' '
>         init_repos &&
>
>         write_script edit-contents <<-\EOF &&
> @@ -398,7 +398,7 @@ test_expect_success 'git add -p' '
>         test_write_lines y n >in &&
>         run_on_all git add -p <in &&
>         test_all_match git status --porcelain=3Dv2 &&
> -       test_all_match git reset &&
> +       test_all_match git reset -p <in &&
>
>         test_write_lines u 1 "" q >in &&
>         run_on_all git add -i <in &&
> @@ -413,6 +413,12 @@ test_expect_success 'git add -p' '
>         test_sparse_match git reset &&
>         test_write_lines u 2 3 "" q >in &&
>         run_on_all git add -i <in &&
> +       test_sparse_match git status --porcelain=3Dv2 &&
> +
> +       run_on_all git add --sparse folder1 &&
> +       run_on_all git commit -m "take changes" &&
> +       test_write_lines y n y >in &&
> +       test_sparse_match git checkout HEAD~1 --patch <in &&
>         test_sparse_match git status --porcelain=3Dv2
>  '
>
> @@ -2458,6 +2464,38 @@ test_expect_success 'sparse-index is not expanded:=
 git add -p' '
>         ensure_expanded add -i <in
>  '
>
> +test_expect_success 'sparse-index is not expanded: checkout -p, reset -p=
' '
> +       init_repos &&
> +
> +       # Does not expand when edits are within sparse checkout.
> +       echo "new content" >sparse-index/deep/a &&
> +       echo "new content" >sparse-index/deep/deeper1/a &&
> +       git -C sparse-index commit -a -m "inside-changes" &&
> +
> +       test_write_lines y y >in &&
> +       ensure_not_expanded checkout HEAD~1 --patch <in &&
> +
> +       echo "new content" >sparse-index/deep/a &&
> +       echo "new content" >sparse-index/deep/deeper1/a &&
> +       git -C sparse-index add . &&
> +       ensure_not_expanded reset --patch <in &&
> +
> +       # -p does expand when edits are outside sparse checkout.
> +       mkdir -p sparse-index/folder1 &&
> +       echo "new content" >sparse-index/folder1/a &&
> +       git -C sparse-index add --sparse folder1 &&
> +       git -C sparse-index sparse-checkout reapply &&
> +       ensure_expanded reset --patch <in &&
> +
> +       # Fully reset the index.
> +       mkdir -p sparse-index/folder1 &&
> +       echo "new content" >sparse-index/folder1/a &&
> +       git -C sparse-index add --sparse folder1 &&
> +       git -C sparse-index commit -m "folder1 change" &&
> +       git -C sparse-index sparse-checkout reapply &&
> +       ensure_expanded checkout HEAD~1 --patch <in
> +'
> +
>  test_expect_success 'advice.sparseIndexExpanded' '
>         init_repos &&
>
> --
> gitgitgadget

Patch looks good to me.
