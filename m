Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236C582C60
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 06:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723789244; cv=none; b=O5Thjn+43ciHK2XJ9O8Bfi6JcmXC+TGKAv9AmoX/96jW6snodOqLaUydtogMFZSBhR1TOokGUe2mt50EJuF/PHF+ThPeIyUB/IAfyeaSHRTeR8syJpM4dkjErcKbt2onO3lu6CRSjKVbPuTHyJZ2Kb54j/hxfjj2jBv6PCc1DPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723789244; c=relaxed/simple;
	bh=As9EWZF6jO2L2ub1v2LzED2XY93G8PevJA98rix3gJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZJmKeuiotXSXjuxJs6QWu0HjaXG8yq/G7SQGI80Vet3zdcCUSKaOlJaOBnz3ifp7EB1/WqCuCjL16tWqIKt+fQRM2gARIm/cmAXSAwIyUzym0FMOBGd+qr5oGpvn478Q2pma29sP8YngkjxKa9j3vEFOkKS9aMnB0LYRxMHzjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipiwqUV2; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipiwqUV2"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e0bfa0b70ceso1658114276.2
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 23:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723789242; x=1724394042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ogp1+Rxv7VM0rQmUx3VGcb78tri0C6mlN5fRIgpwYU=;
        b=ipiwqUV2copCrdzWw1u8Rd2sPA4+OwIh26QUXNHl7Py4VqPmT2N+jPKF63wb/Su5ec
         ryNe8avg08eQf7JEosZaiZajHcg4pKLuKiBO8iiTJljA/VnksEiTA2QWAXtz7os1lhXg
         1xsk8KFfjwOKRT2B7HRYet8zthUo4SvF8anU4HDeBC6z02eMZDyI2OEkxNdBCMCCf3OU
         1N9gArRPbViW9WolazE637IyxAVgkZwyeJtN34S8LnICKJr/EI8tQJF/zxuDlKRZUhiH
         KmRRbr/J//D6uz/7DY9iJ1H+CzL3FfIGRR7ZxYTfvDJ2lvgeZekF0mmEs2T+PpNxyR4p
         9KuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723789242; x=1724394042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ogp1+Rxv7VM0rQmUx3VGcb78tri0C6mlN5fRIgpwYU=;
        b=v4j/u27LmDS81H/a6P4hMAAdS8P2dUddRJ6WxN4xArO3M2n5wA1AZvfmEVWIEQ0fAH
         TnxiWX+08HDd/6YDtfXqAStQaoold933Coznf2P+2HeF0/SKFh/tNs/WPIVzcB253s2A
         +Dt3PoQZR4o/KdCT1Jdmc88pp/Yidi5culRIHU/1P7haO8W4RgZOQc5H6jfES4ur7jr9
         MiZNJLOpDDxncBu+BBTffgub3p3nYUSpmY7iuYf2ggG7KRvbnvPcVJcbZ0IW9yeFVzS7
         v6Uosn7Lx7afyp5Qh9arghzKnt++FyvEf7PvnsGX+sl/O7Pq0KeAd9teE5o00c4R7fgp
         SLZQ==
X-Gm-Message-State: AOJu0YxhKCnQxrj25XP1FeDbahYxM9vl9klkB1WP8/9ss4EU3yuM77nI
	+yDamnY7XUp6PoY9rDfLRpfDc6+U0fNsqhcJ6feYB2qtNQmaTXgoSQQ09++S24iLpuQKmd64TBk
	Y7QogKotWyzJjfCGyFfonHNZiMYg=
X-Google-Smtp-Source: AGHT+IEoP5zArVdbk8F4PnpozNOppBTPelHajalU/nKdcp0fdBIakd27ENzA3t6dQXyWgU/mil5SiVLzwieCVgk1QEo=
X-Received: by 2002:a05:6902:230b:b0:e11:7578:ffbb with SMTP id
 3f1490d57ef6-e1180fd5ae9mr2471987276.36.1723789242125; Thu, 15 Aug 2024
 23:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <767ea219e3365303535c8b5f0d8eadb28b5e872e.1723778779.git.matheus.tavb@gmail.com>
In-Reply-To: <767ea219e3365303535c8b5f0d8eadb28b5e872e.1723778779.git.matheus.tavb@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 15 Aug 2024 23:20:29 -0700
Message-ID: <CABPp-BEd8LvpMMf_sT5zvYrxNVe-Q=oUX7ANQa1f27GmM4=crw@mail.gmail.com>
Subject: Re: [PATCH] rebase -x: don't print "Executing:" msgs with --quiet
To: Matheus Tavares <matheus.tavb@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de, 
	Rodrigo Siqueira <siqueirajordao@riseup.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 8:26=E2=80=AFPM Matheus Tavares <matheus.tavb@gmail=
.com> wrote:
>
> `rebase --exec` doesn't obey --quiet and end up printing a few messages
> about the cmd being executed:
>
>   git rebase HEAD~3 --quiet --exec "printf foo >/dev/null"
>   Executing: printf foo >/dev/null
>   Executing: printf foo >/dev/null
>   Executing: printf foo >/dev/null
>
> Let's fix that.
>
> Suggested-by: Rodrigo Siqueira <siqueirajordao@riseup.net>
> Signed-off-by: Matheus Tavares <matheus.tavb@gmail.com>
> ---
>  sequencer.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 0291920f0b..d5824b41c1 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3793,12 +3793,14 @@ static int error_failed_squash(struct repository =
*r,
>         return error_with_patch(r, commit, subject, subject_len, opts, 1,=
 0);
>  }
>
> -static int do_exec(struct repository *r, const char *command_line)
> +static int do_exec(struct repository *r, const char *command_line, int q=
uiet)
>  {
>         struct child_process cmd =3D CHILD_PROCESS_INIT;
>         int dirty, status;
>
> -       fprintf(stderr, _("Executing: %s\n"), command_line);
> +       if (!quiet) {
> +               fprintf(stderr, _("Executing: %s\n"), command_line);
> +       }
>         cmd.use_shell =3D 1;
>         strvec_push(&cmd.args, command_line);
>         strvec_push(&cmd.env, "GIT_CHERRY_PICK_HELP");
> @@ -5013,7 +5015,7 @@ static int pick_commits(struct repository *r,
>                         if (!opts->verbose)
>                                 term_clear_line();
>                         *end_of_arg =3D '\0';
> -                       res =3D do_exec(r, arg);
> +                       res =3D do_exec(r, arg, opts->quiet);
>                         *end_of_arg =3D saved;
>
>                         if (res) {
> --
> 2.46.0

Makes sense and looks good to me.  It's kind surprising just how many
places we've ignored --quiet over the years...anyway, thanks for
fixing another one of them.
