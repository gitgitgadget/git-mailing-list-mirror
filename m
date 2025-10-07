Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC44E2475CE
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 22:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759877616; cv=none; b=PZofj83PlKVzN2BAL02hw3wBO3CLW36lBARMEDKLiBMIb/0vvJgIWda/K1rUNe2lnSPpBTrKM8KehDTceOztEwIq4WKiIuse4bc+SeKtc6LZo7LCQ/VQ/0oyF5840j5O+2UCBmoGxyeAlWeUdQ/T4sD3WH0nwfCe70MF4Wwggtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759877616; c=relaxed/simple;
	bh=i9NmB2nzZCZv7dWgjC+gfydl2M4AnbzjobFPWO6S06Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fF82Vvjbg1kej25Q9dS8c5TH6GKCpnSGSb2tHHHA0MTJU9M0rOMWakOBqK70/IElHrhtoX9JRWq0ZMe5PD+nUP36hn1rviURf8bb9XVvOEDNuWU93HJBcPfHQvE2wUycb6jmkWVZbDHBCkfVvJaFo3+NOxrsTVBE48j+wB8X9fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTL7i2uJ; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTL7i2uJ"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-91f6ccdbfc8so378387439f.1
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 15:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759877614; x=1760482414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiTGdaYZ+MQhGWYmfqk77u5muL+jItQ+pZjC83DeGdA=;
        b=cTL7i2uJuGq2sqG5TIpflG4G7IKx9DU8lx6i+F274KzYBmHQbTc+HHIuQFjnHCsqxI
         xCWqbhCZl3kMrQU/wwgHoHJs3+SjCBESBedDFZN+3Z3WBbBWfaPUspYr+Zn9l43LTa5p
         mvL0G141k7Yp/65e3ugCvx9PekGp+RkDQg874+M+zbGL/U+7DngdGUy/q1cqmXn0MrDh
         0OK++S3siQYvim9JSu0uLEOVgX2z6ZXwHF6VzmvqKPSnNPYB0wk9PhQ/kHtaZSVEoA9Z
         DsPFtpuQ0g2umeLdvAxSCu4Itk1l166NIBKseaSgQgxek9uAHvTMeSbTeLTcjv2teUfm
         UeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759877614; x=1760482414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiTGdaYZ+MQhGWYmfqk77u5muL+jItQ+pZjC83DeGdA=;
        b=mHwc6sgtjgeobwbd6M9k3wzSn5ioJ+9tRlXgDXWMPoj3GNJTDAxFWtLSLhPNCrdKGf
         4QS2+m6CRc4HbJnm6HZqfMo5GvQBd3pOJztXD+aisszLAAy/s4nHHUVLWKKpp/H2Z94e
         9lZPgIExh5zY2JMIOfigavh2EnEMrkPxzRCNRyohHIbuA1qHtfSxXgjEU7i2hUEX5JoX
         owUj8sO7x0sA3umzmMdygqm8n+Nb3wwd/DQB3H/KMQTOYMIBdQksrmCC4aeeD1spLa9t
         AsxaG5A8drj2JgHmDdTcQu4NunsGLIKkNMEMqRnTbgZwz7lj9Tm5fec0Rj9xDhxGbYJg
         jLcg==
X-Gm-Message-State: AOJu0YyxooIV2cKO4a7UOGKcVqb/KnYpBB/uaS4ftMg+PMqgbLqjYHma
	kAJ4u4Cb9/FYxs5KV2bYYHM7dMZvGTKSMKfOpQWZ+tNeWwu6k1KKZwcQAr7WFDzECek6M2pgkp0
	+tqP7ARtaaM678pYn4Jv3dCNpBQlWlIM=
X-Gm-Gg: ASbGnctTNuMfbOG453Bq6GRTU2SbBepUrexAV6XNYYTLlTfdCjytNk3tFlueReSZvkG
	xt/wxEiuXtUAHpo0GFC3Z9m+obk7ay9CiLe5hnPzAYtHcVgetbiYl/YsKwhNQ2zsfAO7zAjOS5h
	cFPW9DhE6JdkdHRmYl4TSOXHrgDCEAsO5eX2nZm5rLiI0PYjlQvKXGRVmO55ugdapfLmppsPwo6
	YnS59/O53kmSwmUOlOl17y1YoZJUeTa/s9AWJ7Z+miDFb0d261sbME1qn2pgKTi
X-Google-Smtp-Source: AGHT+IHGwxZteo5Kc6r8OCQMGL8zSYjexfQpKUTWtHxLLJ0xpr2f84fjoBOSC9mdtRbHsYbiZsTfIWHBGd7T+Zi7s2E=
X-Received: by 2002:a05:6e02:2503:b0:427:72f3:f537 with SMTP id
 e9e14a558f8ab-42f8736ba25mr10907405ab.11.1759877613761; Tue, 07 Oct 2025
 15:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
 <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com> <460e5e8157fc87a4246c49f53e34495bc33d4432.1757673011.git.gitgitgadget@gmail.com>
In-Reply-To: <460e5e8157fc87a4246c49f53e34495bc33d4432.1757673011.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 7 Oct 2025 15:53:22 -0700
X-Gm-Features: AS18NWCCjSJB6GKpV_HtAEdqER_kn82nXvYR1-g4I2_DXcP96NUnI-42Gh0_MdI
Message-ID: <CABPp-BG_TwQRcCp4iCpcDngb3W7rprnX4FHLs4A884BXQVk_eQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] sparse-index: point users to new 'clean' action
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Patrick Steinhardt <ps@pks.im>, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 3:30=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <stolee@gmail.com>
>
> In my experience, the most-common reason that the sparse index must
> expand to a full one is because there is some leftover file in a tracked
> directory that is now outside of the sparse-checkout. The new 'git
> sparse-checkout clean' command will find and delete these directories,
> so point users to it when they hit the sparse index expansion advice.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  sparse-index.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/sparse-index.c b/sparse-index.c
> index 5634abafaa..5d14795063 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -32,7 +32,8 @@ int give_advice_on_expansion =3D 1;
>         "Your working directory likely has contents that are outside of\n=
"     \
>         "your sparse-checkout patterns. Use 'git sparse-checkout list' to=
\n"   \
>         "see your sparse-checkout definition and compare it to your worki=
ng\n" \
> -       "directory contents. Running 'git clean' may assist in this clean=
up."
> +       "directory contents. Running 'git sparse-checkout clean' may assi=
st\n" \
> +       "in this cleanup."

Given that you dropped patch 8 and explicitly call out in the
documentation of `git sparse-checkout clean` that it alone is not
sufficient to do the cleanup, should this advice be calling out a
combination of `git sparse-checkout clean` and `git sparse-checkout
reapply` ?  (Should it also suggest an order for running those two; I
seem to recall that the order mattered, but can't recall which one
needs to run first or if it is situation dependent.)
