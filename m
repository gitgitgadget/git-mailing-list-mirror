Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E9742B32B
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984698; cv=pass; b=DFsU6SnU+juevxEbAdo3uzmBCWKXdgeLR8ysvUsdBv4X2SEDdzHw/tFH1F0VK3ot3dMOooUmqUGeluMGyf2yzFNEmMgtS5Py6zdTvIeMHwXOHm3bOYG/DVB2bovhtvv9vHmp8Sz1/0JH8YiUKgDEzrvJ9M8L6DbZq77MsR/hNzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984698; c=relaxed/simple;
	bh=uhpC9KYVfW3ozryJQT4Gy1Z8rDPzp4ljPmkOS5Ptpd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzY2YvMjI0A1bsDgfas3jF2bPreQNFfQLzxQsq7dP39V+Ysk8oSLeGd+K9SO1kOMug/dPRa/4hVPjWR2cCs7QaVakkBSE3smrwaytpz4m6SqpMdQJWv7kSUCbZn4UVOA5LRNCn65No1UXSAsqa3FblJd4eOnUXGHyV1RNUAHzL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDpIqrKh; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDpIqrKh"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-845eb7b96feso1134455b3a.0
        for <git@vger.kernel.org>; Thu, 02 Jul 2026 02:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782984697; cv=none;
        d=google.com; s=arc-20260327;
        b=R2FXMhoUZ2bqdgFcjt8MgtHHFNsAAMrtZxjMmDAUloXxWAg0hSYazI7B+gsGb68RsA
         n+8e9ZbfesTkbVqMYA7tLpcQMkChNg5pbfN/lBca7RxjoWI8L7idh0wvxWEe9CEYk5PG
         NXiBsg+LdEZTuGfMGbFcGfMuAsYhQ4ShNeQj2smwTh5knsrJrtmJqGG5jcJWtXOt0e3K
         RrVAOqtvFBeGJGeihU3jH6puPM86dUrQiywAO9k3ooF1QOGmlcHPGEKJddZCWN1wXipd
         6ZAtleaOM+o2Mu0CI50vqew4EvlILuVLlr+4py35iAqV79cEp1VDUVsNHRck96cwuGwd
         owlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MSh2mtGuA5LA32qSfBFqEoKOUQJqmbqiJL2dnB5YSe8=;
        fh=utCjFkDRtONGx8y/PigI61/uITE4QNKJlp47hHScMqA=;
        b=Mt29sWIaCF91yii0rs72wAz0w2HGnUbzl+j3BzBUtPsrDvZd5vLGChKN1oP1oznnEn
         /FCAOEGbz4cqeqWOyJLjs3vq+6ZIZR+dl2TfY7dWUu4R+yBo120e2N/FJZaFAmJePntq
         xYRm97IEisEYl0YQ6RMhmwfvTkqZkcC4729GDZ+/BzMfv3xJxc9ciJBiBR9L6KWrm5sb
         3sYjnOrlPlA0wNF1JemXEpVwh3CgxMQ8nHBhio8Eo3zR4RA/GgRqH9yCP54aKt5zHAXj
         8EsNh1anv6VOMbnXFR8yZIMSoWmpVI0Lvqz9OLzF0J8Ys6eLcpy210tYP1QETf5ZunyE
         3k6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782984697; x=1783589497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSh2mtGuA5LA32qSfBFqEoKOUQJqmbqiJL2dnB5YSe8=;
        b=YDpIqrKhIB0ZhzrPgoYlJsZzXCoK7EJgFW3mChrR02MW6VvO0/8go93QzTSAxdpt6j
         C1m18dTqt8UKFfXck3+Hl6++OlZA50xna5utUkA9gE4gZgFanvWibhFGaH3FsuS2GxMF
         z5DUvRq06gS04n3PPCHYZjQVANkZ7XYbfCbGsBpX5zDOBR2RgT9dZDlsPyWuMjrCvuOi
         LMBsE3BP1f6Aqq6eUTq8PKbx5m1ofK9Chu4PXIVvMdny4wjfpgkDqiboKtyC4vOvZM6P
         5itk0wD0SmWjSKYvM1ME5lgwWCdVUQxnXu33dgWWbZ9k507x3waHZiyhy1PldyTJAHpG
         3bGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782984697; x=1783589497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MSh2mtGuA5LA32qSfBFqEoKOUQJqmbqiJL2dnB5YSe8=;
        b=BqD2e/6jU+rLyy6cGcO04su0VX9upUIskjgCcAFF2siKn+yRBqDvTj/cmKmYpLsrHW
         KO/EfYtJt7DrW/OtN+GiJFhmTnyoyOoJi3S/A4+5MOWbZ/eeBbPBYKwfyWSNnabLQ4AL
         KZxiCp5ht6runylr+kUK5BLFmaB80hj3UhnI0EAOO7zl09YDlCrJnVK1qIOZdx8gZajd
         RcqjTlkgRp9/0kdGxCMB9Jv1AFm7dXDbeAbewFKWrb6uFgT5UVlKZNbchx1fnk+SCZGU
         TNh2sz81K8nKXitgP3Kc2vBj8IQCAqvG7SyFwBX5f0cqQO5/xkCYvk5g+b1c4zzUWE9L
         F0Tg==
X-Gm-Message-State: AOJu0YyXEA5S6juIsNDfRI4xEkMHYl7n1nzaPblYRFwhQpxGQ2ntb/VX
	V/qX79HjSMyKpidsTGR0VwfWWSXtWux76XiA9Sz4D7BGyjIfd9IU+dFteTIzZmr599UdWu1/V0a
	7vMLmyMD+AxjbNwRwU3i78VzxrVbHUzZ53w410Tk=
X-Gm-Gg: AfdE7ck+XES4lwz893s6iaTni/gwM3RSCCx8ixHg/cBQIEBuPNiswfM2gVa1IQH2dqo
	bFrnAfb1KRWpRQIKfW6DofonLCIFei9X8aaDcrBUYQVQnWLrR18994gLoRAZrs2sO4TF7thYZPp
	aBV3uqZiQEwLSiUpobeemVgbOgIU69L6AFfyCE9oGCmgW88Z1jv9eolTuqDP9ETKNwJoE37th/e
	cOTdP+QFr/j0HHsXdf3ltNbLElU7QpI7pHy2hOveB2GXMAgUmmxVTct+yluRpzQ9v4/2RcaUSWz
	Zueu6YSWL1H3Wzbv66owILwHAgkEErjyP+pU2BsdkoEGb6r4LYYlct0FoA==
X-Received: by 2002:a05:6a21:48b:b0:3ba:cd5b:3dc8 with SMTP id
 adf61e73a8af0-3bfed356d36mr5892192637.31.1782984696723; Thu, 02 Jul 2026
 02:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im> <20260629-pks-reftable-hardening-v2-5-b0228e7d908d@pks.im>
In-Reply-To: <20260629-pks-reftable-hardening-v2-5-b0228e7d908d@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 2 Jul 2026 11:31:25 +0200
X-Gm-Features: AVVi8CcpVa2fpRKTyUZ-ec6zSZluedGdmfgUj1GmEvpKHql0c1xtSCoIoNhiAIs
Message-ID: <CAP8UFD3d4e_OOQrNUXU5iVavwhuCZfiNUuE-hH=hwV84xN+pEg@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] t/unit-tests: introduce test helper to write
 reftable blocks
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, oxsignal <awo@kakao.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 11:02=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> Introduce a new test helper that allows us to write reftable blocks.
> This helper will be used by subsequent commits.
>
> Suggested-by: Christian Couder <christian.couder@gmail.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/unit-tests/u-reftable-block.c | 47 ++++++++++++++++++++++++-----------=
------
>  1 file changed, 28 insertions(+), 19 deletions(-)
>
> diff --git a/t/unit-tests/u-reftable-block.c b/t/unit-tests/u-reftable-bl=
ock.c
> index f4bded7d26..f4e926ce3a 100644
> --- a/t/unit-tests/u-reftable-block.c
> +++ b/t/unit-tests/u-reftable-block.c
> @@ -14,6 +14,31 @@ license that can be found in the LICENSE file or at
>  #include "reftable/reftable-error.h"
>  #include "strbuf.h"
>
> +static int cl_reftable_write_block(struct reftable_buf *buf,
> +                                  uint8_t block_type,
> +                                  struct reftable_record *recs,
> +                                  size_t nrecs)

Yeah, I suggested:

int cl_reftable_write_block(struct reftable_buf *buf, uint8_t block_type,
                           size_t block_size, uint32_t header_off,
                           struct reftable_record *recs, size_t nrecs)

which accepts `size_t block_size` and `uint32_t header_off` as
arguments, so that more existing tests could be refactored using
cl_reftable_write_block().

Your choice to not have these extra arguments is reasonable though, as
they are not needed for the code that your series adds, and they make
the implementation of cl_reftable_write_block() a bit more complex.

Also they can still be added in the future if we really want to clean
up more existing tests.

This version of your series looks good to me now.

Thanks.
