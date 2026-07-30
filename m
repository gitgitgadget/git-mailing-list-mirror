Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC2B39936E
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785397401; cv=none; b=nbwiJYn39THOeXeTZy8jKsT86gUAnIZvVtiXU/RSrSqjvdiKyiCh2EpT0ANfqYix1r3bJBjIn72nalf2vNA3ODiNT0uEx9xY/g+c8ONz9/wKRtRygtwZG2SuIS/b6cwr76BpB3ZXSIk/Hb0t0r2SA6HsBOAwmREZYH+hsPuyrvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785397401; c=relaxed/simple;
	bh=SmdczSEkat4opm5k6Yd4Dk22S2bK9zmF3qcefobueU0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=FhbmkOJjzNTLajI23YQCBfppPsseWmqQjg727AmEXuELk83YTPYkvZm7kyuEGfGKlt2evDN2FGP2ry401PWZbqVRtJ3OX35yIIfLEONlQmtRknRkKjx56bOOyTbSRz97SB/CM3ls4NXL9HwQWR9KtFbIfjce8b0z4tParIBynB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtwwBl6F; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtwwBl6F"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-848743155bcso731914b3a.0
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 00:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785397399; x=1786002199; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YtJauyuwTZrshJ2BBb4JU5brHnoBQL+R+BhgmlqznTI=;
        b=QtwwBl6FflmkKVAnSSEVXy/uXJj6i4ZNjGGcnam3lWe1Fz/SQLE88GA7keG2XdJsVU
         T6XVUrrhoKll90Y/iz2JsiWF8jLv6TKNs/53+063LrhdcMFWpMFL3nZ8GMII58wxsSSn
         XdNmUYbr4LOHGvtY8P++ruAEMIw5jjkS/ZpSIxyuj9vsiaN5J3AnTyzX6OF1M7hAdpsA
         Rbuu9inAVjw04U5CobPv6RDC4UDoC9ZgFcGMb6wXPpNwqOyFSArdcVVmWEbxZF9901X4
         RGx+LsYAli88nC6TReGNnos4zBJYiA5GBLh8zyArVy8WVqF5/7W93PN9ET2UV+Qunzcf
         ENNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785397399; x=1786002199;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YtJauyuwTZrshJ2BBb4JU5brHnoBQL+R+BhgmlqznTI=;
        b=Qjoa97hayjvEwNbFeFnSFQFFxqNa2EM7sw3b3g+r9FgOgQ8GlLEhaKfFCG0tNUFElv
         MvVmk0U5xdvUSZaLXi1ACvhjzvimbeXF7OzE+uB8m4CYUP1d0WtGZfR+/d/cqzl6pURF
         o3pUTQpsbEtvKcshlouOmx62p+OvIKTCdkVcGC5n0DT4gEUxNx7/6TiH4IfRFyuvTMln
         WgTgm5bxY+mNyCMap58Pfem94OX294/zsnxUSW9tIAQeYSj0gf4o647WfRceqGX9QDwE
         MNuarO41q/vMBtHWCKIgeWqq83lgc21U0DxsawOyWdhM7R23DDm43t/HZkMbaEIfFR50
         f21g==
X-Gm-Message-State: AOJu0YzpjFf1CZtNFMdNttPc7AViF2l8lCFFjk1dkPS4Oh+ZUf2PUxxf
	Q9Ot7kAY+PresyhVLXsGwxCCdy0bn/9TtDnVSNqbTi1NnIWHpXCJhyHJZS02XT7V
X-Gm-Gg: AR+sD10zaZKne6m+MEXQOTolcjyNsXhrG7mDofU/nQju0BQyzqgx9DpFZlLEMIPFgn8
	rJjAYNFdRipRUCOZVK7mzty3UwZ/YedaQlnDLX+8yh/ZAytNZHT4nwMtf50WguHYz11vWhxcTIx
	cmoo+u47BEG3gT83IKWuYudnuuFcQI6v1sCfX+tgcab0WDFT74fq/wJeMBdIIeWbIrvtgnucM32
	HX4IY88tESJnfQG8lpv4Bpdgcr07FPbUSgIxjn07mdQerDlCh6BZ7Hv+JFAnenB5XhfSO264e98
	41TtzteeG48587v4QRwvT7e9XBpMMzYSParQDy+xCogfQllmRX5z+c3+USxhwsBQw02Z7IX9BMc
	qKOyE0H7t0wp3Thn17elvKDQS3zqqi473MYn96XXE5eKz5SCu4RyOBLYw1PSk70kSaIzXtTlbKw
	AFC/LRzbiNWGQ3INbXVKQoJm1LFePpMvDAq04zRD6RBONsbZJG8OJl5goFezRgWC5OZ+ZteMcdU
	oXdvABny9sUiMzvyj7zL2fhHWjZZzsO5yUXE91SbkswADFk8YKjUZyWYNuOuSicEbazbUlk/AF+
	8LFgLPMe26Ig2itwi83Mm51EwIfSSg==
X-Received: by 2002:a05:6a00:a24e:b0:84e:24df:3873 with SMTP id d2e1a72fcca58-84ebc253eb6mr1461360b3a.32.1785397399129;
        Thu, 30 Jul 2026 00:43:19 -0700 (PDT)
Received: from smtpclient.apple ([114.202.151.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea00c367csm2570422b3a.23.2026.07.30.00.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 00:43:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2] stash: record positional index in 'struct stash_info'
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <20260730034108.765430-2-gitster@pobox.com>
Cc: git@vger.kernel.org
Date: Thu, 30 Jul 2026 16:43:07 +0900
Message-Id: <AA402B97-B3DC-4085-AF53-C6D80792C3DF@gmail.com>
References: <20260730034108.765430-2-gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)

[on mobile, so only looking at patch context]

> Le 30 juil. 2026 =C3=A0 12:41, Junio C Hamano <gitster@pobox.com> a =C3=A9=
crit :
>=20
> =EF=BB=BFget_stash_info() resolves revision arguments (such as 'stash@{0}'=

> or '2') and checks whether they refer to 'refs/stash', but it
> does not allow callers to determine the 0-based positional
> reflog index.
>=20
> Record '.stash_idx' in 'struct stash_info'.  Populate it in
> get_stash_info(), setting it to 0 when omitted (defaulting
> to the latest stash), to 'n' when a valid positional index
> '@{n}' is specified, or to -1 when the index specification
> is invalid or non-positional (such as a time-based reference).
>=20
> Subcommands that manipulate reflog entries by index can use
> '.stash_idx' directly, instead of parsing the revision arguments
> themselves.

I notice even after 2/2 we don=E2=80=99t have any users of this index yet (e=
xcept rejecting invalid entries as the series goal).

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> builtin/stash.c | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>=20
> diff --git a/builtin/stash.c b/builtin/stash.c
> index c4809f299a..5041a9ba81 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -175,6 +175,7 @@ struct stash_info {
>   struct strbuf revision;
>   int is_stash_ref;
>   int has_u;
> +    int stash_idx;
> };
>=20
> #define STASH_INFO_INIT { \
> @@ -248,6 +249,7 @@ static int get_stash_info(struct stash_info *info, int=
 argc, const char **argv)
>   char *expanded_ref;
>   const char *revision;
>   const char *commit =3D NULL;
> +    const char *at;
>   struct object_id dummy;
>   struct strbuf symbolic =3D STRBUF_INIT;
>=20
> @@ -300,6 +302,19 @@ static int get_stash_info(struct stash_info *info, in=
t argc, const char **argv)
>   }
>=20
>   free(expanded_ref);
> +
> +    at =3D strstr(revision, "@{");
> +    if (at) {
> +        char *ep;
> +        unsigned long u =3D strtoul(at + 2, &ep, 10);
> +        if (ep > at + 2 && *ep =3D=3D '}' && u < 100000000)
> +            info->stash_idx =3D (int)u;

What=E2=80=99s the purpose of the 1e8 constant/comparison? I see we truncate=
 the unsigned long to an int, but even on 32-bit platforms 1e8 is a small po=
rtion of the integer range, right? So my read is that we are limiting the va=
lid =C2=AB n =C2=BB in @{n}. I=E2=80=99m not totally sure why, though, or if=
 that matches with the rest of the stash manipulation code. =20

> +        else
> +            info->stash_idx =3D -1;
> +    } else {
> +        info->stash_idx =3D 0;
> +    }
> +
>   return !(ret =3D=3D 0 || ret =3D=3D 1);
> }
>=20
> --
> 2.55.0-597-ge6126a35d6
