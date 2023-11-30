Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1TDHbNL"
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFB41B3
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 10:16:24 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-67a0d865738so6978876d6.1
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 10:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701368183; x=1701972983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZGatRIkuULyg1CRUoyqZ6bZeRhjEG5ofhYp8qBz/wU=;
        b=c1TDHbNLNjn4qMrSN4zrUU79DJSibZ2QiIoEpWSuqEHLuiqHxHR7VQT9e9HcyTkVoK
         YKTvMavoQyv3CjoN5vr0g5XFba2l1tUh2l8QkBN67j2dJKEmxZ6EEccpJCACfLX21TGA
         z71q7ci2oOh+FxfPyHgpieFOCh1++14QZu4yWc8Bn8haJ4glMApm0rlTvpmhVyRjzGmC
         sxQc3psfM4FX0tiYOR3QJi7IpOZLrKQVr+fAGRcGDrn3wEK0vwXggcKvyAsslnULtnWR
         RCP6jBd8HspnGm1oDP5HuH0Bv53EFqbayCj/P7YvjI9jkdZnWDI9HSoTowKa/q4yjc4u
         P16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701368183; x=1701972983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZGatRIkuULyg1CRUoyqZ6bZeRhjEG5ofhYp8qBz/wU=;
        b=WTZwNy5SfrERsrGhHHED2+h9ae/2JQKbU+Rk5Q8k3MJ2WMTrEwHOe49qyTjEj05Ug4
         1yPcajJlzby88wX2t9NXs/h+pf/tSNpti6nvMPieZebFnHeRNdV27uXl6ykckyPgFK1A
         bzTsAgfnKl76X3HCXq0dzNeHYZtC/CL5ne9nfsoRuPVHSocvb5MsnSpNMoXw6HK0cR7/
         TyPa+0t/d0k+01pP8ke2zSxcXZFcAchEprqU6lsdLQMdGUmcO71oq6v3YEMg7BC9+Jg/
         SS/DDo8H+xxT12RCKoYIZKAPPIqSG/EY5Nw39mU9w4Mx8Q0NgA/BmCJiDX6PyrxIl6qV
         0igA==
X-Gm-Message-State: AOJu0YxrqucqgwK//pFjyqAHnfstEpywaQKmx8EMLOcb0sLZOntYyqzC
	rbOqEwjKHYzIOXyvvIbCmUC7B5QrBgt7/5bggj/LmtfBvzg=
X-Google-Smtp-Source: AGHT+IE+wRfdDvekoL7Q1tGh4I8omVto2vIeXZqHJ/NHrfxEBR/rR6VYJEbq5iubh/p5Yoa2c3/GbhBjNu2mQjeDOCE=
X-Received: by 2002:ad4:50c4:0:b0:67a:900c:3a3d with SMTP id
 e4-20020ad450c4000000b0067a900c3a3dmr986802qvq.26.1701368183457; Thu, 30 Nov
 2023 10:16:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003174853.1732-1-ach.lumap@gmail.com> <20231130165429.2595-1-ach.lumap@gmail.com>
 <20231130165429.2595-2-ach.lumap@gmail.com>
In-Reply-To: <20231130165429.2595-2-ach.lumap@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 30 Nov 2023 19:16:09 +0100
Message-ID: <CAP8UFD0KDdwoJw6AzLUpqos=bLumcmDax59_MfQ9TUFqmmpcoA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] t2400: avoid using pipes
To: Achu Luma <ach.lumap@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luma,

On Thu, Nov 30, 2023 at 6:37=E2=80=AFPM Achu Luma <ach.lumap@gmail.com> wro=
te:
>
> The exit code of the preceding command in a pipe is disregarded,
> so it's advisable to refrain from relying on it. Instead, by
> saving the output of a Git command to a file, we gain the
> ability to examine the exit codes of both commands separately.
>
> Signed-off-by: achluma <ach.lumap@gmail.com>

I think the issue with merging your patch (in
https://lore.kernel.org/git/xmqqedibzgi1.fsf@gitster.g/) was that this
"Signed-off-by: ..." line didn't show your full real name and didn't
match your name in your email address.

Assuming that "Achu Luma" is your full real name, you should replace
"achluma" with "Achu Luma" in the "Signed-off-by: ..." line.

Also it's better not to send a cover letter patch like
https://lore.kernel.org/git/20231130165429.2595-1-ach.lumap@gmail.com/
with no content for small patches like this.

When you resend, please also make sure to use [Outreachy] in the patch
subject and to increment the version number of the patch, using for
example "[PATCH v3]".

It would be nice too if after the line starting with --- below, you
could describe in a few lines the changes in the new version of the
patch compared to the previous version.

> ---

Here (after the line starting with --- above) is the place where you
can tell what changed in the patch compared to the previous version.

Note that when there is a cover letter patch, it's better to talk
about changes in the new version in the cover letter, but I dont think
it's worth sending a cover letter patch.

Thanks,
Christian.

>  t/t2400-worktree-add.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index df4aff7825..7ead05bb98 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -468,7 +468,8 @@ test_expect_success 'put a worktree under rebase' '
>                 cd under-rebase &&
>                 set_fake_editor &&
>                 FAKE_LINES=3D"edit 1" git rebase -i HEAD^ &&
> -               git worktree list | grep "under-rebase.*detached HEAD"
> +               git worktree list >actual &&
> +               grep "under-rebase.*detached HEAD" actual
>         )
>  '
>
> @@ -509,7 +510,8 @@ test_expect_success 'checkout a branch under bisect' =
'
>                 git bisect start &&
>                 git bisect bad &&
>                 git bisect good HEAD~2 &&
> -               git worktree list | grep "under-bisect.*detached HEAD" &&
> +               git worktree list >actual &&
> +               grep "under-bisect.*detached HEAD" actual &&
>                 test_must_fail git worktree add new-bisect under-bisect &=
&
>                 ! test -d new-bisect
>         )
> --
> 2.41.0.windows.1
>
>
