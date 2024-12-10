Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A60D23DE9A
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 12:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733833189; cv=none; b=WEaMcubY9IiaSeAjgZ1K/OFC+J+3KCsgE2LNlX20xN2p18ENX95Jily7PVkMKTP7D49weydaHqMgPVOcsDKKS+0AY85FU7AZymManiK7CusUVSFLLWuoG4vwzGVkD/iOBGd+ogYvaORNGEDQckfzsQUlBeBQdmv73pw8Vi8eADQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733833189; c=relaxed/simple;
	bh=cZXW9hsxIt+ORaLLJIZtNK4jNPH+i6cJ+aoQ510sKgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvdW4kErXbXVaymO6N2UvkCU2Fh0bZ0GCLZAGajhyPsKL9VCt5OQwuA0fdVAZDAg/rz8fLgSo0aERbhh9x9CxGAVLoJjYPtIAihLUWqZ18LDwZLKs9+uUAnnvJ1HoL+N33E41gDXsi9u0o1L5WbVJf7Q3VjgfWWs1px3HRVwJwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hh3K4JeT; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hh3K4JeT"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ef66fd2183so49841697b3.1
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 04:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733833186; x=1734437986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6lJn08WGX3/7SHPF4Fb3P4y/bW7xFejcjAcMANwGik=;
        b=hh3K4JeTBgpQqM7RMSR5+wn1k2QeNC2vRtFy+MwMw+r6fNpgD7BJLpKx3LJrkG6Z32
         XgK+XXUmOzxaDlKD1stskq2e9uy/dKkWbVtlJlUvIS+uWwOaPBYj7hpcnVY81YSnl0T8
         Rg+YRRzZErk7quUjwpXlZQOPbPHQr2pym+TfFxxEf+GYN6nRWQLh4Dlh++NBaxP3uepF
         i+5PYwzRNzMRBJFFwfwWNiVlJy5tgwUllljBirNxQai1Sn0BZfVuELtXWgiHAp0IjgY9
         nOMDDlXkigQJfC3Y9QUjBb00aDZwozP4UyJ9qUi9cOLiiFW3F7hSVkQIyHKEL3vQpMYK
         gzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733833186; x=1734437986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6lJn08WGX3/7SHPF4Fb3P4y/bW7xFejcjAcMANwGik=;
        b=jmPEYry9r8h3XQSn/H7cOZGhBLyT4mr1W+i7hfENSKbdqmvw/yn58nyGDaaUL5TIZJ
         OJpID2lu5dEG4vK4D2/puIeKKFLxoUF5s3xwbtaTqa7gBc2gvcu2WW9Qiz6nV2zPc7Xf
         Wpo7o0SoT9jB8cAv4A/hLuqE28kgaHDFc9xufvz8D6Plr105GiHZN/IQAwdoeranrXyW
         RxNqR+U+g0vtiFOiuP0/IoRlopf2FvMIhPGBx4V24JPJvG3Dr/qqcETXOFRIlP1Pb/CR
         LcQXbQFdCF4AIHi8mo+Ah8TOjgJepD9/G112x165i2D4JpgYpchTAyOJukV+lqjuZ57L
         L3RQ==
X-Gm-Message-State: AOJu0YzWnz35taoKOxAq+Z91exzNlMz56XlwZRqH8GVd1hjIij8qwmpR
	TCoQvZhuTwr184DMmB2qCNVzlra2/6lG7N2UxiLBTiAlXXIMVO5TrKre5MR0rzeAoPJzuGJj+ye
	6QzcWSEsXDLIslzyzQkJEEwXTi4ARf2dq
X-Gm-Gg: ASbGnctHMpg/nsxw+5HY/kGE1TyJaNL8ZtA10yresoAtY3t0UaNJAXjZIyM62m8ashT
	aP6NFIhYbgiACvi/uidLJ+zl7txR3PTJr2V/B
X-Google-Smtp-Source: AGHT+IF//4qXXiD1bslo6v8CdU59/jrR4L2eFu8e1zWcfv56EkUyTZrOiPLJ61eIPIC/7qcCixTozH5BpXLm+sFsL7s=
X-Received: by 2002:a05:690c:46c7:b0:6ef:57f9:ec4 with SMTP id
 00721157ae682-6efe3bcf570mr142705257b3.5.1733833186228; Tue, 10 Dec 2024
 04:19:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>
 <cover.1733830410.git.zhiyou.jx@alibaba-inc.com> <93123988ae00d865d0251ca0667c4f4584772021.1733830410.git.zhiyou.jx@alibaba-inc.com>
In-Reply-To: <93123988ae00d865d0251ca0667c4f4584772021.1733830410.git.zhiyou.jx@alibaba-inc.com>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Tue, 10 Dec 2024 20:19:35 +0800
Message-ID: <CANYiYbHQVsm=Q-DXfmYu-Ar+NYpbv4vcSeWO413iD7qYzu0zNg@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] t5548: add porcelain push test cases for dry-run mode
To: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 7:36=E2=80=AFPM Jiang Xin <worldhello.net@gmail.com=
> wrote:
>
> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> New dry-run test cases:
>
>  - git push --porcelain --dry-run
>  - git push --porcelain --dry-run --force
>  - git push --porcelain --dry-run --atomic
>  - git push --porcelain --dry-run --atomic --force
>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  t/t5548-push-porcelain.sh | 153 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 153 insertions(+)
>
> diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
> index 799f6066a3..ba68808459 100755
> --- a/t/t5548-push-porcelain.sh
> +++ b/t/t5548-push-porcelain.sh
> @@ -310,10 +310,159 @@ run_git_push_porcelain_output_test() {
>         '
>  }
>
> +run_git_push_dry_run_porcelain_output_test() {
> +       case $1 in
> +       http)
> +               PROTOCOL=3D"HTTP protocol"
> +               URL_PREFIX=3D"http://.*"
> +               ;;
> +       file)
> +               PROTOCOL=3D"builtin protocol"
> +               URL_PREFIX=3D"/.*"

This line breaks CI on Windows, see:
https://github.com/jiangxin/git/actions/runs/12255233680/job/34188220514
 Should remove the leading "/". as follows:

1:  93123988ae ! 1:  9e764b6faf t5548: add porcelain push test cases
for dry-run mode
    @@ t/t5548-push-porcelain.sh: run_git_push_porcelain_output_test() {
     +          ;;
     +  file)
     +          PROTOCOL=3D"builtin protocol"
    -+          URL_PREFIX=3D"/.*"
    ++          URL_PREFIX=3D".*"
     +          ;;
     +  esac
     +
