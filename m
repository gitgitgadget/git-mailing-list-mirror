Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55D12F657F
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214403; cv=none; b=ASss65gIXb2mJ7q8Lmqf933LFVzc/Jq4r8ZFTc04eAcZ+25OuEPyl9UKX/3jXQsi1QaskTsHEkhMG3bmHWdO3Fv0xMp5DPqgM9kIrLZXLPWteLMqGPM04ra7XgdeHbAQTEfuN/yDXaGQu+o+eEwsmoo3NH/Y5e9CS4BeGaSFfJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214403; c=relaxed/simple;
	bh=C43XaNczamjVxmmXj1syWcn25PM1wAV57wihVRsfNNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pu9dWtfXBsWebeFGGIKb1g3SbrEel9MpwJUlsZoTMuzwgfXFnAIIN8sSMhOMCrDaqLval4stjKg2mf6BDE5CDrDScKiYBYMWCLJyophsStQmFliISIdG82QDpWxRnibNr4MuPpz29An4yAyjtArjARSUnbQnD6/hFzU9jEG4ouA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nrd9PYEe; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nrd9PYEe"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afe9f6caf9eso163788366b.3
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 06:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756214400; x=1756819200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTw6xWRWuWuM0I2CoXeilLM1LJ+Ja7+iPBT92Y1xSPM=;
        b=Nrd9PYEeC/YGjBpW+gTfrGrlDdn+NnkVLzikZXPJOkYrjZPQzN+I8uj3+jVoYmdNQa
         elhu5C3ji/FzOs8XEFRy53yhvmVOaK5HsWNYXOwDUXCoZ750LXkRUY7qgMcnxxlK/GjZ
         Gby9O725g6CTpezpncP2tzvvEEAhIhtphuO8on+2voVu4YrKX/sKMl2droEZVdLVAxuF
         K8uLBQ1QacLGwQ41HDCvoj3Uf2bAigeDhe+7XgD+r8q7cp0JMCtpKgcij1C0VjnST5Jh
         8A16D2V1WL6QEo7raNaHi9pJxUwtGxOybjft8t5sHEXZvfU9U49kBQcHUspu13Lh/niM
         GbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756214400; x=1756819200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTw6xWRWuWuM0I2CoXeilLM1LJ+Ja7+iPBT92Y1xSPM=;
        b=d+3IT4dDzApCBud5x3TmNIMS5CBZt6QCxwadibD3Hrw4nGMvqc2dQnGjqFo1VYwN6q
         4/osQWwbUA66QkiWp5Hfhn5a4eedQvnd76IcvR1z4S5Ga0OJ1qCPeBS1P2+jRkgeS2oa
         EkAJzDC6qPYlYpTlGhP7VZkljsaNl4rjpZqMPP3JbWUke1cZ2gu0ez0OMCaWXf9OhdUg
         OByveZQRHRV02PJC5tpznmyIOnHKskpysye6YHpuDqwT8KGZAikgT4NGGPo1Nx8i7I20
         QlqsLUHIi/K12Wf9ujhJLHG7lKR6WSIM8K7KP2pkz4h7v5Y7Ja9niLmL2GR3hnooaYgI
         R2lg==
X-Gm-Message-State: AOJu0Yyi10wMLjulaq41j8KcmaMNe5yUxKB1Xlb5IZnT3CWgLiUfyU5F
	LCrKar/RHntamzwpdOHB5IVBCjt83wcYPHc5mSmXUKfRozrf7GtP7Yly+IUslysK8OY5W49LeP+
	tQ92pH4JXd+NVCD53iHQMLBDbDM0+Qq4=
X-Gm-Gg: ASbGncs2QdqjDcbi3+6Mzrq7B7zuppVXjkdxUTeK3lOaDU9NqjH8n8cx4BN6n2bWuYJ
	M7v6isa/Ho+pEr+G8mnvVXJn1X3mdZWJc6sV54F+V6pepYYpIwbyGGu8Qxj+H0nCWWBdZpOQCVo
	TJr3RsQol8DuoEefU0OXkgGn2h1uQratnJL/39ASTAHGCYrU7xTt1nWJ+6DTD4B/Zw/+pwScoPQ
	WDy4qrqJYqRMl+YbsI3/inEe1H9lzDSHpLNpi/eiA==
X-Google-Smtp-Source: AGHT+IEo6ZbK97OIYCmX2wqYpBAQwDgeKdSNLhx+4bPaxz7De7bQ+jVetyXM0w16GyRImjH+KIbV+NoAO+i3wwqw/l4=
X-Received: by 2002:a17:906:f591:b0:af9:29c1:1103 with SMTP id
 a640c23a62f3a-afe296e5004mr1433004566b.55.1756214399644; Tue, 26 Aug 2025
 06:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2037.git.git.1756147789443.gitgitgadget@gmail.com>
In-Reply-To: <pull.2037.git.git.1756147789443.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 26 Aug 2025 09:19:46 -0400
X-Gm-Features: Ac12FXxqmv3-UblBKfA18hxvrel-BVsBsjw9y2GKRzlFy5ZMsBmpf7NO5rP68Ww
Message-ID: <CALnO6CC7+JC-EwEDZE1+rbr4ZMPs+dc_9iepb17_9Uda7GSRgw@mail.gmail.com>
Subject: Re: [PATCH] Add `-u` short option for `git pull`
To: Julien Jerphanion via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julien Jerphanion <git@jjerphan.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 2:50=E2=80=AFPM Julien Jerphanion via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Julien Jerphanion <git@jjerphan.xyz>
>
> Add the short form `-u` as an alias for `--set-upstream`
> in `git pull`, similarly to `git push` which supports both forms.
>
> This allows users to use `git pull -u <remote> <branch>` as a
> shorter alternative to `git pull --set-upstream <remote> <branch>`.
>
> One test is included to verify that the short form works
> correctly and set the upstream configuration as expected.
>
> Signed-off-by: Julien Jerphanion <git@jjerphan.xyz>
> ---
>     Add -u short option for git pull
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-203=
7%2Fjjerphan%2Fpull%2Fset-upstream-short-option-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2037/j=
jerphan/pull/set-upstream-short-option-v1
> Pull-Request: https://github.com/git/git/pull/2037
>
>  builtin/pull.c          | 2 +-
>  t/t5553-set-upstream.sh | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 5ebd5296207..e09f2963f78 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -254,7 +254,7 @@ static struct option pull_options[] =3D {
>                 0),
>         OPT_BOOL(0, "show-forced-updates", &opt_show_forced_updates,
>                  N_("check for forced-updates on all updated branches")),
> -       OPT_PASSTHRU(0, "set-upstream", &set_upstream, NULL,
> +       OPT_PASSTHRU('u', "set-upstream", &set_upstream, NULL,

Don't forget to update the docs ;)

>                 N_("set upstream for git pull/fetch"),
>                 PARSE_OPT_NOARG),
>
> diff --git a/t/t5553-set-upstream.sh b/t/t5553-set-upstream.sh
> index 70e3376d31b..b4dd7c62ce9 100755
> --- a/t/t5553-set-upstream.sh
> +++ b/t/t5553-set-upstream.sh
> @@ -124,6 +124,13 @@ test_expect_success 'pull --set-upstream upstream ma=
in sets branch main but not
>         check_config_missing other
>  '
>
> +test_expect_success 'pull -u upstream main sets branch main but not othe=
r' '
> +       clear_config main other &&
> +       git pull --no-rebase -u upstream main &&
> +       check_config main upstream refs/heads/main &&
> +       check_config_missing other
> +'
> +
>  test_expect_success 'pull --set-upstream main:other2 does not set the br=
anch other2' '
>         clear_config other2 &&
>         git pull --no-rebase --set-upstream upstream main:other2 &&
>
> base-commit: 1fa68948c3d76328236cac73d2adf33c905bd8e3
> --
> gitgitgadget
>


--=20
D. Ben Knoble
