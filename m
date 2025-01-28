Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76D71990C4
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 18:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738089045; cv=none; b=T3JI89chjI52pVbbUpjBIcpfU6bP8orGn4pE6bO/zZ5U6Exh/6hlMmiLLpnNc+WDUFaNQOkKcTapreALKSvyIHs1x6X7vmcsipvviKIsEtmeKBP+alfQwaivqNf2mviMjA+IFlEB8Cibjyw2vXsayRIfLC16kiXZJU8joi+8RcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738089045; c=relaxed/simple;
	bh=YDsRYTiVBHkPe8Z7UdNvrrfYG/Vb1Xx+15rTG1Ot2ZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3TQGhsw3Kqd3f/WOmbpIURNpYmNMoc2L5HE07xa0nFmBs6RBHTBXyg2Xb77b/Z44ao+cS68uzDChwJGrahmpIfJ5os9/CBPWq4rosgiwNeqaf8hPV8SPLGY6/qZdWJwS8kZPUBBcQws3/b5HFo+ciEONBb1bjjMm9A17Uuiv7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipHNJv+l; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipHNJv+l"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-844ce213af6so165116539f.1
        for <git@vger.kernel.org>; Tue, 28 Jan 2025 10:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738089043; x=1738693843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWF8ZX3Y2XNWSsnGPwm6xSy3qMgxM0OkN7XyoI8f8Jg=;
        b=ipHNJv+l/Mb8nE3MAB76ZWnnMo3XopPD1HbEspZ++tyl+GcFdipMwVTj1ORR6dQD4K
         o+acB3tZgRhqKLusBkLQyYy96+c+5eCN2Q4GX4r8twzbMkFnF9jIyYq6G1i7evfBbR4A
         8LmCsGLCRm/ocQfeh+bSlw0ISr/zY/vZAt2WMB/0ayJHqWcGAti8TKF80KWHPzI2V8aw
         M/i6bqbPi38pWz49GvUXchUp5gUI3arTenXIvcHZ5Yy2DGI7TviaQk28jrZARTxuEzRJ
         Q2sy4aokwQSgeaADb/dw39sHP4b44OnEzpIgiVBNSTl1aAhF9K3RZF8OIv6IM+N+Qj4p
         EwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738089043; x=1738693843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HWF8ZX3Y2XNWSsnGPwm6xSy3qMgxM0OkN7XyoI8f8Jg=;
        b=PEvy3vHZhtOYa/cMdm2EYvbH+3Zus0pT688GbDTDal5E4FWHNRQS6ErfsnqNQZUU0e
         oGeujBUMJg+b+9s9VIHjTcHaDa6BpncETgajE8oDons5lJlGFR8LPplEMPPlpWh3wHj1
         8SqCCxOA6Ep5YTptlyKlJJEnLzcdbqligPIiG6b9s25ELOwfMJR0LwI7taw4S4bumTvh
         rYgtRV/pRtE84N74YJ5Sta4UFtq2r3Ckm7u2FH+a+WSpkmJWAfIKIQOI6rb2f9D3OfPx
         YTEVTpZ+ZHUK+sby09ZJyTh86AgzI7h8NixxXkp/K7s02W3QIj69jKqrDCQtgK8Zw4rw
         PQDQ==
X-Gm-Message-State: AOJu0YynTPOWL5wMwy/O2WCVqryj6zMFa4UUybolEWjVehRxW8tgQiis
	O8A2THapNqZtFIua84wzcow1DZqf3CspI0hCUO20fTGHUgdXYAH9jDEyhThU8uKnHIgxHlnHkVT
	qSHkRbDhOIb1AxiyvsfNIqf5JDv3L9A==
X-Gm-Gg: ASbGncvJJPPGsCfhLqhhePf/dsjsZ8HFsiG63wWpb39tlfX3XXBv2bIxVP4KRhwxDrs
	9O8HrGD5WI1cG5kRCLgRn4sc0aGSTf4H4wCH92fOmspjaVEsCPuxoM5BDVe0mtNumdY5XjPDSrw
	vWA7UtxTXBOKBodlZD1D4wjv7p/n6jWg==
X-Google-Smtp-Source: AGHT+IE9rpZ6XHYcZW6/S1Zy3ZQdvuK3lrSA5UiF9uspi9kaGlNLFqS+ZV0OLhyOKuKZP8j0lm3VY10wSMyw0RbGt8Y=
X-Received: by 2002:a05:6e02:1ca1:b0:3cf:cbfb:b509 with SMTP id
 e9e14a558f8ab-3cffe3d1b64mr1629725ab.2.1738089042807; Tue, 28 Jan 2025
 10:30:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214181306.296673-1-toke@toke.dk>
In-Reply-To: <20241214181306.296673-1-toke@toke.dk>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 28 Jan 2025 10:30:31 -0800
X-Gm-Features: AWEUYZm9Bjx8R-MFMfhwLSBtT-sDY-oFIjv3BFxLHZ6vCDcged3jOf1-rzqFiWM
Message-ID: <CABPp-BHZ99ovFUfBUpvGRvhoudTbz4vZgCdVr=iUcE171CAYuQ@mail.gmail.com>
Subject: Re: [filter-repo PATCH] Don't crash on multi-line config values
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 10:13=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@toke.dk> wrote:
>
> The parsing of the output of `git config --list` fails if any of the
> config values contain newlines. Fix this by using the --null parameter
> to `git config`, which is designed for this purpose.

Nice; that's a cleaner way to do it than the other proposals.

> Add a simple test that causes the crash pre-patch.

Much appreciated.

> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
> ---
>  git-filter-repo               |  6 +++---
>  t/t9390-filter-repo-basics.sh | 11 +++++++++++
>  2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/git-filter-repo b/git-filter-repo
> index a40bce548d2c..3b75eadd81d7 100755
> --- a/git-filter-repo
> +++ b/git-filter-repo
> @@ -1683,14 +1683,14 @@ class GitUtils(object):
>    def get_config_settings(repo_working_dir):
>      output =3D ''
>      try:
> -      output =3D subproc.check_output('git config --list'.split(),
> +      output =3D subproc.check_output('git config --list --null'.split()=
,
>                                      cwd=3Drepo_working_dir)
>      except subprocess.CalledProcessError as e: # pragma: no cover
>        raise SystemExit('fatal: {}'.format(e))
>
>      # FIXME: Ignores multi-valued keys, just let them overwrite for now
> -    return dict(line.split(b'=3D', maxsplit=3D1)
> -                for line in output.strip().split(b"\n"))
> +    return dict(item.split(b'\n', maxsplit=3D1)
> +                for item in output.strip().split(b"\0") if item)
>
>    @staticmethod
>    def get_blob_sizes(quiet =3D False):
> diff --git a/t/t9390-filter-repo-basics.sh b/t/t9390-filter-repo-basics.s=
h
> index c129799fb6a5..1dc2dca789ab 100755
> --- a/t/t9390-filter-repo-basics.sh
> +++ b/t/t9390-filter-repo-basics.sh
> @@ -895,4 +895,15 @@ test_expect_success 'origin refs without origin remo=
te does not die' '
>         )
>  '
>
> +test_expect_success 'multi-line config value' '
> +       test_create_repo multiline_config &&
> +       (
> +               cd multiline_config &&
> +
> +               git config set test.test "test
> +test" &&
> +               git filter-repo --force
> +       )
> +'
> +
>  test_done
> --
> 2.47.1

Looks good to me; applied.
