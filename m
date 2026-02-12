Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECC23EBF3D
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 22:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770934821; cv=pass; b=kCPvUUMgr/+JDaw0nSJmFhggxKlkulcgnnbqrjzNPH0sAYpmXllX4b0vzJ2pBEVv5kpau0+7a29KGE91lLbODPlF2OXnSMbEPQcVqRuDCSP+cD5YKXnEfrDUMYxMwoZwRNzkEMQxpHj6iOUzInApcBBk46vusEiDUO8/mVhuxkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770934821; c=relaxed/simple;
	bh=x6X3rRH5WzVO3tZA+xWGEuld7xpSFoxfuuJVZAsQ5eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bk4sNgTM1VjBkb7NPp9KPY/HmO7CZGKNXDnDtsmT7z5bSW3qoW7h2SpH/FFO9kCRI10JZXkTYbSMh25UlaB6TVR9pbpLbJVsGA03Rm5YvhvaUjuON7wtIn0w/qtuZQuDBsbGUp++ogw7MKE4AbRFezmoBMDQpzzofyCGvsPsAtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ty9treY4; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ty9treY4"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-824a9348603so127629b3a.2
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 14:20:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770934819; cv=none;
        d=google.com; s=arc-20240605;
        b=Fv8tX4KAaHFPv033oWyYxv4wBoPKbam+mEKszElNwjRGpNiHTt9pqnRgcO91e5tkkM
         JYuKYz81Ll095aWzM3jLwMo3C1VZnLhrwDuWa5uXtDTqipQs7B5phCVOA3OgfQRCp97S
         ieREh0HJhbh4eT6/nL0PdprL06v9DpsM1cs7pulZeN219rRaCwLYK9AB5ChV3fnFLpHM
         lS4zcaBv/BiCq2XgjRa9MHSsIJUaw2kap7IQhlh2dB/dH5mjECeKM1s4SJVnNIhNru2g
         gFl62zaHwBjjhTjJ0VTEyhx8abmuH2OCxQzC8c9r5PpLE+BtFbb58vsCW5BhdXHhivmw
         leHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tv+2MV19wO/vVw1hG8xGz0Z6kXtITfZLzr1s5SsTIms=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=Q0iy/faoF9TK/oEF9O4lMwP53/FlRKoFcnmbtjMJUieI29rh4QBSp47VFpkl0E7WZD
         VLEJXMWX03YxfckvcPj02mlrjCASJVRJ/NEtDxkwFst5m5bOKEpQSBQAodVMB/kHYMw2
         V1f9B3ocv5W7SZcy0edJ0PtQeRosVYrj/nb/rWw9Wo4Rlg7DfvRjlVNjBjFseNQd6iPD
         R8rYSTRqLSIb+h0FXlWyfgpHCipYfi1MWVT2Ya9ytevguJUqEZVwHnfHVNJSjk66ywEF
         3eln3PdiMVML2PfgbBtt5mcU9iog/Z8nwyNA0OYENMqgGEm9AfUs3iBy8e3M8K0MA/Ny
         XYFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770934819; x=1771539619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tv+2MV19wO/vVw1hG8xGz0Z6kXtITfZLzr1s5SsTIms=;
        b=Ty9treY4K8Tl7t2cK8CsOCXavwuG5fRlqpfG8vvgRPFLU1KBQ1AHrv0Yg8JR+q/zjA
         307G0QZl9XOHuZBxn6lK/HGq73XVBXC2WWcxBerOKWbAFoagsq7u20UpZ6WSkbM0DJnJ
         NRg2S1IFZnUdKG2AJ+98Wl5uCU1k0PmfleJLsJPcEM+QQ3HRDKgdDQaudyvW3aD4CHhp
         ZaXeoFX5l9Z8WHMz3wQQ16Rgp/Uyo86NcDuCqLY4dIiksyvxzpwWF2xFUeQXF2RPqvVp
         bqS0Zt2HlT5VM1a02vItmfladnne8WcSogsfgpjazUIeKUq5ObKY06onsANY0kDFkHOq
         mUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770934819; x=1771539619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tv+2MV19wO/vVw1hG8xGz0Z6kXtITfZLzr1s5SsTIms=;
        b=L5eBQlzRpD2gX74M972fhjPA30TpY5Fjn1PRIBTSZssL0cMlkH0huxVU0X09vtMQFc
         /l4+k8RhlsJXcrSlDpqyVeuj4oMJ+gpYWBKn8IGOsmIK3myQimhLhXWKjJkdbuXSTGoE
         aN00l0aTq08zRO0t6Z4iru4V0ekNStplVqNN2YF/83BG0GCUAG8R+QgpURjTnb87PFHw
         Cz703GEl+u6TmfEKXf4elx8FtcAM1LdOnjDSshGoY+qB+YaT44nYRUmddgqFeFTWbhQ8
         CxmK2bXE026P+nf3OxRbTiYeSooQj/xYXHmws+naQHyYElFvk30t4IXmO4XYhdVOTrm3
         Oivw==
X-Gm-Message-State: AOJu0YztXkWPp14VlbZyTDTiorBwMUbuLpCxTBf0MTZPQZ11LeGdQWga
	MnF+PgsjNCC/BP5vUY++t6v/Si2hoBUt+eoVVlmW5WkcH4+56s+wD+uen2K1+2juaGXxzPSIk+1
	l46erq6q2YTJeqbu0/dJl4BK6xZJz3mnRbA==
X-Gm-Gg: AZuq6aKT5fW+6z/QcJmtkYAPRZenwPmOwpkw25Nar1KhZQmvErLrcwHDkwtuH2r7yNR
	evU/AIJbHecvkuaZkM0enGPiyi5URatz9tL25hdB9+6bB/+rCCU0PyT8ji2UrkHJsYj7Vgkus83
	ryY6z8QsgDgIgKk+n8OCGtI9KhczsjB1MJvIAiwrE2Jlh8RbXgjL69u+KCLVq4cLDUBzydJNQOP
	Fqo/Ub/A+H3OtM8SZgI5HaYhJH8W/JF7dRXDvXcQIObXcgXIutbIKhWahO97csWcjqDQ+/XQ3g6
	DLG2gdwq91JzFwdIaRgynzzK3/ZOAThdxodJIRc5LcEN1UwCx/tNoi/UX4Ksg7NrrJa/2c/QtM4
	UvXWN
X-Received: by 2002:a05:6a21:68e:b0:387:5ded:994a with SMTP id
 adf61e73a8af0-394672eb5d6mr257948637.60.1770934819444; Thu, 12 Feb 2026
 14:20:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im> <20260212-b4-pks-history-dry-run-v1-2-1ce03d631c1b@pks.im>
In-Reply-To: <20260212-b4-pks-history-dry-run-v1-2-1ce03d631c1b@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 12 Feb 2026 17:20:08 -0500
X-Gm-Features: AZwV_QijId4M4h2Hmp_JeDnqu2pNjCd89mbC-Tr66i38We6grEDrCDussew6VZA
Message-ID: <CALnO6CCciWF_GOd3WqOVwUDLoPRABNgDWbSu7FTgP8KLWQKvgQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] builtin/history: check for merges before asking for
 user input
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 7:45=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> The replay infrastructure is not yet capable of replaying merge commits.
> Unfortunately, we only notice that we're about to replay merges after we
> have already asked the user for input, so any commit message that the
> user may have written will be discarded in that case.
>
> Fix this by checking whether the revwalk contains merge commits before
> we ask for user input.

Indeed, that would be irritating :)

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/history.c         | 40 ++++++++++++++++++++++++++++++++++++++++
>  t/t3451-history-reword.sh |  2 +-
>  2 files changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/history.c b/builtin/history.c
> index 1de51372ea..ca0cdb6a58 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -177,6 +177,42 @@ static int parse_ref_action(const struct option *opt=
, const char *value, int uns
>         return 0;
>  }
>
> +static int revwalk_contains_merges(struct repository *repo,
> +                                  const struct strvec *revwalk_args)
> +{
> +       struct strvec args =3D STRVEC_INIT;
> +       struct rev_info revs;
> +       int ret;
> +
> +       for (size_t i =3D 0; i < revwalk_args->nr; i++)
> +               strvec_push(&args, revwalk_args->v[i]);

I'm surprised we don't have anything like Rust's Vec::append or
Vec::extend_from_slice

> +       strvec_push(&args, "--min-parents=3D2");

And this is the key for detecting merges=E2=80=A6

> +
> +       repo_init_revisions(repo, &revs, NULL);
> +
> +       setup_revisions_from_strvec(&args, &revs, NULL);
> +       if (args.nr !=3D 1)
> +               BUG("revisions were set up with invalid argument");
> +
> +       if (prepare_revision_walk(&revs) < 0) {
> +               ret =3D error(_("error preparing revisions"));
> +               goto out;
> +       }
> +
> +       if (get_revision(&revs)) {
> +               ret =3D error(_("replaying merge commits is not supported=
 yet!"));
> +               goto out;
> +       }

=E2=80=A6which nearly confused me here, since I didn't see how get_revision
was supposed to tell if there was a merge! But it makes sense all
together.

> +
> +       reset_revision_walk();
> +       ret =3D 0;
> +
> +out:
> +       release_revisions(&revs);
> +       strvec_clear(&args);
> +       return ret;
> +}
> +
>  static int setup_revwalk(struct repository *repo,
>                          enum ref_action action,
>                          struct commit *original,
> @@ -236,6 +272,10 @@ static int setup_revwalk(struct repository *repo,
>                 strvec_push(&args, "HEAD");
>         }
>
> +       ret =3D revwalk_contains_merges(repo, &args);
> +       if (ret < 0)
> +               goto out;
> +
>         setup_revisions_from_strvec(&args, revs, NULL);
>         if (args.nr !=3D 1)
>                 BUG("revisions were set up with invalid argument");
> diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
> index 6775ed62f9..12a9a7d051 100755
> --- a/t/t3451-history-reword.sh
> +++ b/t/t3451-history-reword.sh
> @@ -203,7 +203,7 @@ test_expect_success 'can reword a merge commit' '
>
>                 # It is not possible to replay merge commits embedded in =
the
>                 # history (yet).
> -               test_must_fail git history reword HEAD~ 2>err &&
> +               test_must_fail git -c core.editor=3Dfalse history reword =
HEAD~ 2>err &&
>                 test_grep "replaying merge commits is not supported yet" =
err &&
>
>                 # But it is possible to reword a merge commit directly.

Hm, I don't quite see how "false" tests that we don't invoke the
editor at all, though I'm not sure if that behavior should be encoded
in the test or not. (Looks like Junio noticed the same in 1/4; I'm
getting better at reading my mail before sending, sometimes=E2=80=A6 :)

Otherwise looks good!


--
D. Ben Knoble
