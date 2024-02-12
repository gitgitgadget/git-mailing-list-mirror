Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE1A5024A
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 23:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781146; cv=none; b=DAHRc5HtOSXcMfkFE+uVzZONWPxZpIhmmP0a0AkAFWTXkC3ck+AWejPjG4gFzFAdvjqL+10M8e3fsq5DwwWhCRYbKwihWJNQsytiMFtmNA5e+1YzAjk5QZFxMt9dPBaLdkg3ym+UQtjaYZJK1zbhbYtM9+bJM8QkOs6dvKD1Xu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781146; c=relaxed/simple;
	bh=bde6a+QV3HqsOO1NEYPQ4G2DPn26M1Ig9TUS0x0itcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GjoOoCndg4yhOGTRdkjtdZBX3hla7i6pcCc82gK3zW42b9JXE6MRt0Ve2CgZxW4AZrRt8f4yO3CxuJ71NKbx7/DcneWSGHaDfz/fZmXO/sFACIgz0m4PtCRydDE56ayK1No3nVxCMhlxC7L+OhE4bI569k6FAQ5DIPEkyE3P2po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MD9ShpsO; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MD9ShpsO"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3cf64f33b3so24005966b.3
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 15:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707781143; x=1708385943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyIppdjWVnn8dKhWmPhU258TSAAy0kFwXLEMLMogD4E=;
        b=MD9ShpsOuCyebv5mhRLSuBTVLrt5TIFVznbp7yCjcXM64KGh1h1SBbRDGfXKyaDVWe
         5vCgdOnOJ66gpi1TBNeUaWuaAkOQO2r+uAKcZf98Fxd/YWBbJbFzzAfCLutAEGTAMmSa
         Ikro+0k0AP5gm5VXP+6UvsqDUdd/Ij9etxbetMk87wH3hM4r4WgaPmqtLiB3CK8vJJpo
         lqsT+zbG0I+2unRtG2MTWmkH/go00tbVgWx5B1Q8aH1Uy92OSvxjvgLfUS7Xb/q5PEAw
         5mBrsUHNmc4IkdCyOeBgf9qcLEpA9vo5pxtGF9drpFnwU47oeV8dAlglbks7RUUGQgje
         LfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707781143; x=1708385943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyIppdjWVnn8dKhWmPhU258TSAAy0kFwXLEMLMogD4E=;
        b=UIk5+Cd6LvIPdIUr7ozvVoUuvGRqFMDR3aB3TevkF7T0lIl29h2buoxyWHiWHIjl7+
         HEcF0nd1aiFbc7amVneUHHVOdk9+afvTYCQM993MGud30e+yMaK7MlQW+CjYu3iZCxVQ
         KtEKFXioBYZL4aWwSWtz8AgmjKvUB+8+IEBLCFJ4KLt+Df/JT9pwX51cNCrmbg3DN2Fu
         /EmBlY5ybWIsrBWVlh5e/vblJI+7Ls6BOK4WE/+PJn2SpX/KuxO/WL2+3ppX7I7PwxIa
         hRQdU3Xs5lfYAbf4ecTt7isYWWxUnN6Y4lwa/v5NQnbJeKbGVapZbJWTo3BKsdkskjUQ
         23KA==
X-Gm-Message-State: AOJu0Yzyf9e73I6Yxs62/sGkvCL+bD5ZVTJBSJRQxa0ZkAU2uvOvFrfW
	ncTOy3n23Y/b9EfVH7a40p27Xv6jRTfX1EJsR9PWMFLf8drn9rEZXyB2btkowv6a0T1KtHAzO5R
	hVawVpreMjQMz9fkM059ID70VA2M=
X-Google-Smtp-Source: AGHT+IHtHwaeQmnxkEnNwf63BGLz3BCHJvbiVofqoAgdgqSevOFBkU7fDiJoeAjMz2ub3f+IQ5+HagigzwEeJRznJmE=
X-Received: by 2002:a17:906:81c5:b0:a3c:edc4:4abd with SMTP id
 e5-20020a17090681c500b00a3cedc44abdmr563589ejx.33.1707781143441; Mon, 12 Feb
 2024 15:39:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <f5f0d06613f2701af9bd3a1a9274aae232e03d8f.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <f5f0d06613f2701af9bd3a1a9274aae232e03d8f.1707196348.git.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 13 Feb 2024 00:38:51 +0100
Message-ID: <CAP8UFD1twELGKvvesxgCrZrypKZpgSt04ira3mvurG1UbpDfxQ@mail.gmail.com>
Subject: Re: [PATCH v4 19/28] trailer: make trailer_info struct private
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 6:12=E2=80=AFAM Linus Arver via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> index 11f4ce9e4a2..6bf8cec005a 100644
> --- a/builtin/interpret-trailers.c
> +++ b/builtin/interpret-trailers.c
> @@ -141,7 +141,7 @@ static void interpret_trailers(const struct process_t=
railer_options *opts,
>         LIST_HEAD(head);
>         struct strbuf sb =3D STRBUF_INIT;
>         struct strbuf trailer_block =3D STRBUF_INIT;
> -       struct trailer_info info;
> +       struct trailer_info *info;
>         FILE *outfile =3D stdout;
>
>         trailer_config_init();
> @@ -151,13 +151,13 @@ static void interpret_trailers(const struct process=
_trailer_options *opts,
>         if (opts->in_place)
>                 outfile =3D create_in_place_tempfile(file);
>
> -       parse_trailers(opts, &info, sb.buf, &head);
> +       info =3D parse_trailers(opts, sb.buf, &head);

I think this patch might be doing too much at once and could have been
split into 3 or more patches to make reviews easier.

For example the first patch could introduce trailer_info_new() and
make interpret_trailers() use it. Then the second patch could modify
parse_trailers() so that it returns a 'struct trailer_info *'. Then
the third patch could make the trailer_info struct private.
