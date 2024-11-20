Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418C522318
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732098129; cv=none; b=raNw2bljD27qcFSKV/4X3cYCKh6et1NW4KY6I+MST09XfC8QtK3tjpBpfX0bF8mQV1Ml5IeeAvdOqLHHYVGr7W4Ly7Z9aYlADD8RVkqRH2B81sCLhR2lxHOXQY3InSNgOfNr4ThUsSg1QuB3mWtRdYYczwJV+DhqMrmeEsw7/O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732098129; c=relaxed/simple;
	bh=dg/CT6wWUaedqcrKyMg9PxqS6UXtQT7EzH6nCExi61c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6HU/SDfwRAU313my5TUIUvhvnEFaU7SdTEYl6LOppvSHgQZA6Q9fPqM0BG5BjVoBWA/CmA1R388Glj5rnwuZHeZt1jRyB1u4i2g7A7kXBCcYqhJo3WPpoZCYUVLfwrn1Wn4Ufi8EbbE/kPvU0UoKvttG1dMFn5cSl3d6GSMpcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHyZcACa; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHyZcACa"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so58453171fa.0
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 02:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732098126; x=1732702926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=By67g/gOK2Cgg57mTdKq61lYMMWsaR6jc7eCuQExBgg=;
        b=jHyZcACa/xageMI0dRYaxtmW3/mIBwv3Qt3+cbkFTcUDlJm35qf05CYX+QdFlfKGtR
         zzHgo6Gvo1PI2RsCGuGmhA2yytx4+dL8dXQpShi16iVEZij/q1AR1X0rwQec4+3ClxFQ
         k/F9J2tZCwJkQcFAMatwInpsMY7mwhmManmqmSzYDZXYTvySZRTY87anECh6cbe6YP1D
         e+Kll7OxsV51/6e9+oZZoajvAn2aVav4n5zKoysjitUldrtq/yBFPKgz48v78ARbiRXD
         feh0dzvgq0ll3d0R+d/22oSzHbo9xeRhRhgl+CBtMvJy4yAnte5IE5OUtblQClf/0g6t
         2wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732098126; x=1732702926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=By67g/gOK2Cgg57mTdKq61lYMMWsaR6jc7eCuQExBgg=;
        b=LOXD6qH3buAG4mTB5R0dqGz5tsr0auS6JzeuutQ4MyyD9H4wk4+Vum+5g+Rx3GsrZi
         RqZHG2xNVk/9H28O4lLzf46LGxPgISCNhp1rI68vpWv1kaz8jBeJ1bwjJemGT89ru/qN
         i9JpLIO49TxTqpCssTeiBVxNxqyLyG3K3qk2FCaNsPCp/LigwWIm95hb2ER498qpVj18
         xgwKjUjuMYuCfRQa5vkSWvvHgYrywuaZ/fOcRJd7H0UI3qIPOCFrCH9C73NVQcgHosI0
         Dw29q0gVK/lLI2eqNsUqUWiYJMcrTDxlsCApRiHToDVxEjDgizaN4UBfyxdh3dL33M7K
         ihpg==
X-Gm-Message-State: AOJu0YxpjGeY3NqtkerZCEhXjXkxtY4okB95utC/VwxV6PVr42TH8pi+
	+hKDmSUmkx35z0EcQouK7ZZIdfww1nBJCwUQ5kjvv3pkxo9GEA14ml/CwJdGboDTbq4DCW8Qfg3
	MVDETQIBe1CxPsMCYkwlqBjckoIQ=
X-Google-Smtp-Source: AGHT+IFIc/OxSIT9WaKnYUjTAF9DJD/Bs/z9xpEa8GQtm6eRElHx2A7UGJXFnJ6/nhZm65n/2QgxH7m7dN7lu8rjxVA=
X-Received: by 2002:a05:651c:989:b0:2fb:3960:9671 with SMTP id
 38308e7fff4ca-2ff8db4cd38mr16443441fa.15.1732098126268; Wed, 20 Nov 2024
 02:22:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im> <20241120-pks-refs-optimize-migrations-v2-8-a233374b7452@pks.im>
In-Reply-To: <20241120-pks-refs-optimize-migrations-v2-8-a233374b7452@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 20 Nov 2024 11:21:54 +0100
Message-ID: <CAP8UFD35YvWgQUcXT4z6k1foH4wN31KX1Xg_09GR16POs51NGg@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] reftable/writer: optimize allocations by using a
 scratch buffer
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 9:07=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:

> diff --git a/reftable/writer.h b/reftable/writer.h
> index e8a6fbb78543e6e56920a2999601db0db9fe4d97..421a897dccd85ad0532860ff1=
b4f38b2813d438d 100644
> --- a/reftable/writer.h
> +++ b/reftable/writer.h
> @@ -20,6 +20,7 @@ struct reftable_writer {
>         void *write_arg;
>         int pending_padding;
>         struct reftable_buf last_key;
> +       struct reftable_buf buf;

Nit: It would be nice to add a comment, so that readers don't have to
look at .c files, or the commit message, to find what this field is
used for.


>         /* offset of next block to write. */
>         uint64_t next;
