Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BC224728B
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754570132; cv=none; b=TQmoD+V5LlhZxxRsqbNVzjVnqB+Hdhkb1i3T+aO/5qvIsfngaL/9o0WMVNGVA7vJmZu2CV1O4/fbW4qn645ocjSjXdAnuYowoBZNTmfL1kCou+U2wa+E6GiFeCTMf4FijcvB3Y7tfYVEcM3ND6CKvrqSJfYFvxbIvKKAmBbXml8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754570132; c=relaxed/simple;
	bh=VGqLQ6IxMJc042N2FQSe1W8SNJsAQw50lPose4tCQY4=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=JsESjRqAV8X3pr5CzJC7YO38znM9uYhD2uR+6qqi7TjV0u04GtiycXXm3PiShf3zSFyHfNWysmu/EUNSLtN0viCCO5R4AUIKeEdkAMow7hejQ7HEcQMcf7S91bXLB0Bq/hPMkWAx+ZXeWw7Y/i+vFD3CsonQ/ctpxGwK1lGeLiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDsEi1qv; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDsEi1qv"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8da9b7386dso1070986276.1
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 05:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754570129; x=1755174929; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=29QjzMzifyHbF51rFSEv8m6cC318xorWuyNeQVAJ04k=;
        b=EDsEi1qvNP9MF1sC7cgTga9LUkfAedrLMQExBDUDpSWeF2iHB1NFgv+lGXfvA27yRp
         oN1S5sMrCW0OINJvwW20+vDSqjCnsfa1qV3n/qlWCBFs56zt2XXVt0aEAMxPXHE02Rl+
         v7/fz/tVM1R/wym1bM0rxDqfRRjT0tmLcv3pcAm6hgBzj9bm0KmM/msa0LxlVhvG8ZQP
         F4NB1Kme2TTEmKRFRKHRWgVh1qnYuhTMFF3llKrXhPE2H6FswmkYpmqq5jinnaDSMrWe
         5c6utpTh3l2cmrvmXNme4AIJzoETFnBrOUU9VMzwowFIuVE5jvtjaW4Z+vaSMGmtYFbo
         Erug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754570129; x=1755174929;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29QjzMzifyHbF51rFSEv8m6cC318xorWuyNeQVAJ04k=;
        b=KTrPC3Xmd/rBiDodExgnHF2IVLewE8SbUCJ9I7WB42GLCqP3EygwPhGAm5yGZtUzFy
         XAQs4kYhVXQl3D8ipYkhTmNGDagd3Btbqs/0XoUSLFL0N5gjtllJWgemHgFHk+XWdgFF
         ukHuyAoJMG61tivKH+vVqMIUzRm7RweszojWuZcnxWfTP0PtuSjLWC2iqzAhGkZ99hqs
         W5noMH2Bvbe0vW+NW0CdPQSAIPVxjuP81rPCa7e9KcSyLg/wZrqbwky+1kpYDBOxpDkJ
         p9durN4QXMEnbX2HVtOrf3M5g/9/vSyvdH1Lsl1DCh5B6X0zMjGTgQ7twb5pydovlYff
         SVVQ==
X-Gm-Message-State: AOJu0YxO2rKJxPVZa/NFCmWwuWMLnYyAGp9aowkEvFT37Jb/H9jEYuW3
	cH6zr6ktVt4II7M6fe6hqoO4SErB+RVYdselCalddxGoTqsEqWEjCFNz
X-Gm-Gg: ASbGncvDseikHUaeHhHCde8jpRftP9RSjn9oGpNbcB6MVsvf68y2CHAiUQwYYDIsO0b
	eeqvbbfc82V6ZwK1QdnEhdy8zNPFBSeQgTTvMVkzLG3A+yHDoT34z7t5bLftvSjSA8odX53DYV0
	wSCeVsoL/g9fx1TICdFZvpXnRtOwIoAN6reurXRjGa3ubPQ62/WAiYRNmtDZ/jl0sPH7aI6+H9u
	fm4ZSYM1YTai+a5wTS/lnl/R4m0YjJi0ZxAeyH7BLA/WJXj4DzFVQiCzjsuXplqV7qi+v/1dhj6
	Xxmnubt1tXPtb5q2qTHHzte3wpsmb3YI7Qf7WXCsIprrHOiVbf8V3O6BI0V93PTVeCFAnvBrSxH
	3L0SHajn2LhXacgyzRnb8It6gKNnC1DVjaS3ZS+5IOpfzEzun0e4=
X-Google-Smtp-Source: AGHT+IFkl8bvg7kKZmowcGd8yyS+be1CkDIa9ozlVe7qjQCfem1VVxKn0hehYvUigzD4LIjM03LrhQ==
X-Received: by 2002:a05:6902:1546:b0:e8d:b7be:b7d7 with SMTP id 3f1490d57ef6-e9038fedd64mr3981770276.23.1754570129255;
        Thu, 07 Aug 2025 05:35:29 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:b410:ea18:8baf:9fae])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9046d8a0c1sm83118276.13.2025.08.07.05.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 05:35:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] remote.c: convert if-else tower to switch
Date: Thu, 7 Aug 2025 08:35:17 -0400
Message-Id: <F3252723-7E5E-4E84-94E4-5FC00298BAB2@gmail.com>
References: <54a16614e2a38117f533ede3321b4d8ee2eabe8c.1754558302.git.liu.denton@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>
In-Reply-To: <54a16614e2a38117f533ede3321b4d8ee2eabe8c.1754558302.git.liu.denton@gmail.com>
To: Denton Liu <liu.denton@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 7 ao=C3=BBt 2025 =C3=A0 05:20, Denton Liu <liu.denton@gmail.com> a =C3=A9=
crit :
>=20
> =EF=BB=BFFor better readability, convert the if-else tower into a switch
> statement.
>=20
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> remote.c | 19 ++++++++++++-------
> 1 file changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/remote.c b/remote.c
> index 465e0ea0eb..029b1fa93b 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1171,7 +1171,6 @@ static void show_push_unqualified_ref_name_error(con=
st char *dst_value,
>                         const char *matched_src_name)
> {
>    struct object_id oid;
> -    enum object_type type;
>=20
>    /*
>     * TRANSLATORS: "matches '%s'%" is the <dst> part of "git push
> @@ -1196,30 +1195,36 @@ static void show_push_unqualified_ref_name_error(c=
onst char *dst_value,
>        BUG("'%s' is not a valid object, "
>            "match_explicit_lhs() should catch this!",
>            matched_src_name);
> -    type =3D odb_read_object_info(the_repository->objects, &oid, NULL);
> -    if (type =3D=3D OBJ_COMMIT) {
> +
> +    switch (odb_read_object_info(the_repository->objects, &oid, NULL)) {
> +    case OBJ_COMMIT:
>        advise(_("The <src> part of the refspec is a commit object.\n"
>             "Did you mean to create a new branch by pushing to\n"
>             "'%s:refs/heads/%s'?"),
>               matched_src_name, dst_value);
> -    } else if (type =3D=3D OBJ_TAG) {
> +        break;
> +    case OBJ_TAG:
>        advise(_("The <src> part of the refspec is a tag object.\n"
>             "Did you mean to create a new tag by pushing to\n"
>             "'%s:refs/tags/%s'?"),
>               matched_src_name, dst_value);
> -    } else if (type =3D=3D OBJ_TREE) {
> +        break;
> +    case OBJ_TREE:
>        advise(_("The <src> part of the refspec is a tree object.\n"
>             "Did you mean to tag a new tree by pushing to\n"
>             "'%s:refs/tags/%s'?"),
>               matched_src_name, dst_value);
> -    } else if (type =3D=3D OBJ_BLOB) {
> +        break;
> +    case OBJ_BLOB:
>        advise(_("The <src> part of the refspec is a blob object.\n"
>             "Did you mean to tag a new blob by pushing to\n"
>             "'%s:refs/tags/%s'?"),
>               matched_src_name, dst_value);
> -    } else {
> +        break;
> +    default:
>        advise(_("The <src> part of the refspec ('%s') is an object ID that=
 doesn't exist.\n"),
>               matched_src_name);
> +        break;
>    }
> }
>=20
>=20
> Range-diff against v1:

Don=E2=80=99t we normally put single-patch notes like a range-diff right aft=
er the triple dash? I have a feeling this format breaks git-am on the receiv=
ing side, though I haven=E2=80=99t actually tried it.=20

> 1:  5866818859 ! 1:  54a16614e2 remote.c: convert if-else tower to switch
>    @@ Commit message
>=20
>      ## remote.c ##
>     @@ remote.c: static void show_push_unqualified_ref_name_error(const ch=
ar *dst_value,
>    +                         const char *matched_src_name)
>    + {
>    +    struct object_id oid;
>    +-    enum object_type type;
>    +
>    +    /*
>    +     * TRANSLATORS: "matches '%s'%" is the <dst> part of "git push
>    +@@ remote.c: static void show_push_unqualified_ref_name_error(const ch=
ar *dst_value,
>    +        BUG("'%s' is not a valid object, "
>                  "match_explicit_lhs() should catch this!",
>                  matched_src_name);
>    -    type =3D odb_read_object_info(the_repository->objects, &oid, NULL)=
;
>    +-    type =3D odb_read_object_info(the_repository->objects, &oid, NULL=
);
>     -    if (type =3D=3D OBJ_COMMIT) {
>    -+    switch (type) {
>    ++
>    ++    switch (odb_read_object_info(the_repository->objects, &oid, NULL)=
) {
>     +    case OBJ_COMMIT:
>              advise(_("The <src> part of the refspec is a commit object.\n=
"
>                   "Did you mean to create a new branch by pushing to\n"
> --
> 2.50.1
>=20
>=20
