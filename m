Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D28339B1
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 21:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712005554; cv=none; b=jaaByhOlBXB3gND0Mu31vvoCGsmst09JCgYi2GoRqFmK0j8W4oQnATVtTzQZoDi9HDLwGDkV9s0VVxUuQcn8Bc19+2XHaUG5A5UC/qqvyHUuFA4Udh3EuYeokw81bXzEcvpB73jpRlDIgPvOyOBNjAtuxQXcYsgk4LXVh1Ues1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712005554; c=relaxed/simple;
	bh=kaDkdfR08W2QHdoT5/LeabAe1w1Z7K/Mcvzm77qqA6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfJ1vxPaBglT0G7dYkW5Uy0bb4GkPdzFCBc9MSuUTfGz0SQ7IkXfRFpiMZJVLnSfkUcrRu/AfwA9at7o3cJq0y6e20Qw3ipilj1aznZWPin5/njyHAY7RAln8yy+i1rXOKcloBfgLbwvqJyHS7UvUdz5IEKO0G5rsN9aPpPAwUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYD7vdPl; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYD7vdPl"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3689ae5137bso21806705ab.3
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 14:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712005551; x=1712610351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jwg82S7U6bqkRrZtL3p9EUtJuEe92LgMKcOq/L5MMkc=;
        b=UYD7vdPlkRVDrIqI5NKxLfgKEhdA+JP9uUt9B1rSunm8euFXEQ0QsZUV6fHUmsmUNB
         ldJCmGB+QdqkSX37iRDDpdlDJ9hudi1dtFtdAPkJj1bS2wpN3o9H5aSr9NUlYXR4+qtS
         vwMu1aO6Xm/3Z3SBkRqG/3j2UxRuZGxCA5TWJ/ZeFzD9AaAIoCGRoVJP7TnoeuIcgRJf
         HzojoOvYLbgoEFdLA5dIy8uZCBNAtLgTBFGNa214yxjuPX/sRvo1BDjq5ptQ6jWPF7CI
         7hxbvObls/4yAi3eK1vPy2gf3mVPL+6rbETlb2Qn7EO/3MUNZpQIzQgwBjM0cm17JpRP
         rJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712005551; x=1712610351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jwg82S7U6bqkRrZtL3p9EUtJuEe92LgMKcOq/L5MMkc=;
        b=wgUBOpfufJW3i2Z7il4UlyY9kdoMDP6a5g7LmdI5RcLHIkK0lTj3/kBZpwEWPN2Lw9
         4z8DsONtwbleAFn7TYadSPJVolU7muxeu33jnLzW5BBgCXHOW6U+ROusulZ8fklBDAju
         d0kWPSkqpStChwVPaooVG4Sseaawp7/NzGV5/wmii+jEzfOWGzlEdTsoEh+GcN6BUeRR
         BrslqSTq8TA/NBKszYJNDqoLF1X3MdCilaIVCsJJyiD1EVyZmky45fYiP7amYbS3FdqZ
         YS9wyRN7Nk2UWs+zBBp+fC41E3Q+6EPMjY+lEFlLCp/nu0SDpPlx+h+cyWo8wpLpE+HO
         o1jA==
X-Gm-Message-State: AOJu0YzE/KjhMZYEoy6arcjzGNH3Y0m8a3nvZeMkTT9O9czT0O/iXb5a
	83UF/9/PeQkUp8FKSJ6f4hZPHqqY6K0kgQKAWKx+Q8oE4FaiKqn0veYXQZUliNJZvFXRRrZ5EmN
	sIVXyKkRE6n2VTC7ltXVRkPrnKYw=
X-Google-Smtp-Source: AGHT+IGU7MH/SWUI3EgWakBuRpxAHtRzw84NnTkrJuUPnQa6g4dKwJIUn1xs3q43RXuxeJcC49FRLLwGLQdCiPTyF0w=
X-Received: by 2002:a05:6e02:1c8d:b0:369:9492:c24b with SMTP id
 w13-20020a056e021c8d00b003699492c24bmr9223205ill.10.1712005551509; Mon, 01
 Apr 2024 14:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net> <20240324011301.1553072-9-sandals@crustytoothpaste.net>
In-Reply-To: <20240324011301.1553072-9-sandals@crustytoothpaste.net>
From: mirth hickford <mirth.hickford@gmail.com>
Date: Mon, 1 Apr 2024 22:05:28 +0100
Message-ID: <CAKcCxfBi55OoR=Li23o6p+kkCNaZHr_8NDmVXhmfvYzR_G2Qfg@mail.gmail.com>
Subject: Re: [PATCH 08/13] credential: add an argument to keep state
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Matthew John Cheetham <mjcheetham@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 1:13=E2=80=AFAM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Until now, our credential code has mostly deal with usernames and
> passwords and we've let libcurl deal with the variant of authentication
> to be used.  However, now that we have the credential value, the
> credential helper can take control of the authentication, so the value
> provided might be something that's generated, such as a Digest hash
> value.
>
> In such a case, it would be helpful for a credential helper that gets an
> erase or store command to be able to keep track of an identifier for the
> original secret that went into the computation.  Furthermore, some types
> of authentication, such as NTLM and Kerberos, actually need two round
> trips to authenticate, which will require that the credential helper
> keep some state.
>
> In order to allow for these use cases and others, allow storing state in
> a field called "state[]".  This value is passed back to the credential
> helper that created it, which avoids confusion caused by parsing values
> from different helpers.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/git-credential.txt | 29 ++++++++++++++++++-----------
>  credential.c                     | 20 +++++++++++++++++---
>  credential.h                     |  7 +++++++
>  t/t0300-credentials.sh           | 29 +++++++++++++++++++++++++++++
>  4 files changed, 71 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/git-credential.txt b/Documentation/git-credent=
ial.txt
> index f3ed3a82fa..ef30c89c00 100644
> --- a/Documentation/git-credential.txt
> +++ b/Documentation/git-credential.txt
> @@ -196,6 +196,15 @@ provided on input.
>  This value should not be sent unless the appropriate capability (see bel=
ow) is
>  provided on input.
>
> +`state[]`::
> +       This value provides an opaque state that will be passed back to t=
his helper
> +       if it is called again.  Each different credential helper may spec=
ify this
> +       once.  The value should include a prefix unique to the credential=
 helper and
> +       should ignore values that don't match its prefix.

Does Git ever populate state[] in 'store' or 'erase' requests,  or
only 'get' requests? It might be worthwhile to spell this out.

This seems somewhat different to other multi-valued attributes,
particularly the "set at most one value" constraint. As an
alternative, how about a single-valued attribute stored independently
for each helper (vector length equal to the number of configured
helpers)? Then in repeat requests send the "nth state to the nth
helper". This would avoid the complexity of the prefix mechanism.

> ++
> +This value should not be sent unless the appropriate capability (see bel=
ow) is
> +provided on input.
> +
>  `wwwauth[]`::
>
>         When an HTTP response is received by Git that includes one or mor=
e
> @@ -208,18 +217,16 @@ they appear in the HTTP response. This attribute is=
 'one-way' from Git
>  to pass additional information to credential helpers.
>
>  `capability[]`::
> -       This signals that the caller supports the capability in question.
> -       This can be used to provide better, more specific data as part of=
 the
> -       protocol.
> +  This signals that Git, or the helper, as appropriate, supports the
> +       capability in question.  This can be used to provide better, more=
 specific
> +       data as part of the protocol.
>  +
> -The only capability currently supported is `authtype`, which indicates t=
hat the
> -`authtype` and `credential` values are understood.  It is not obligatory=
 to use
> -these values in such a case, but they should not be provided without thi=
s
> -capability.
> -+
> -Callers of `git credential` and credential helpers should emit the
> -capabilities they support unconditionally, and Git will gracefully
> -handle passing them on.
> +There are two currently supported capabilities.  The first is `authtype`=
, which
> +indicates that the `authtype` and `credential` values are understood.  T=
he
> +second is `state`, which indicates that the `state[]` value is understoo=
d.
>
> +
> +It is not obligatory to use the additional features just because the cap=
ability
> +is supported, but they should not be provided without this capability.
>
>  Unrecognised attributes and capabilities are silently discarded.
>
> diff --git a/credential.c b/credential.c
> index f2a26b8672..0cd7dd2a00 100644
> --- a/credential.c
> +++ b/credential.c
> @@ -30,6 +30,7 @@ void credential_clear(struct credential *c)
>         free(c->authtype);
>         string_list_clear(&c->helpers, 0);
>         strvec_clear(&c->wwwauth_headers);
> +       strvec_clear(&c->state_headers);
>
>         credential_init(c);
>  }
> @@ -286,8 +287,13 @@ int credential_read(struct credential *c, FILE *fp, =
int op_type)
>                         c->path =3D xstrdup(value);
>                 } else if (!strcmp(key, "wwwauth[]")) {
>                         strvec_push(&c->wwwauth_headers, value);
> -               } else if (!strcmp(key, "capability[]") && !strcmp(value,=
 "authtype")) {
> -                       credential_set_capability(&c->capa_authtype, op_t=
ype);
> +               } else if (!strcmp(key, "state[]")) {
> +                       strvec_push(&c->state_headers, value);
> +               } else if (!strcmp(key, "capability[]")) {
> +                       if (!strcmp(value, "authtype"))
> +                               credential_set_capability(&c->capa_authty=
pe, op_type);
> +                       else if (!strcmp(value, "state"))
> +                               credential_set_capability(&c->capa_state,=
 op_type);
>                 } else if (!strcmp(key, "password_expiry_utc")) {
>                         errno =3D 0;
>                         c->password_expiry_utc =3D parse_timestamp(value,=
 NULL, 10);
> @@ -329,8 +335,12 @@ static void credential_write_item(FILE *fp, const ch=
ar *key, const char *value,
>
>  void credential_write(const struct credential *c, FILE *fp, int op_type)
>  {
> -       if (credential_has_capability(&c->capa_authtype, op_type)) {
> +       if (credential_has_capability(&c->capa_authtype, op_type))
>                 credential_write_item(fp, "capability[]", "authtype", 0);
> +       if (credential_has_capability(&c->capa_state, op_type))
> +               credential_write_item(fp, "capability[]", "state", 0);
> +
> +       if (credential_has_capability(&c->capa_authtype, op_type)) {
>                 credential_write_item(fp, "authtype", c->authtype, 0);
>                 credential_write_item(fp, "credential", c->credential, 0)=
;
>         }
> @@ -347,6 +357,10 @@ void credential_write(const struct credential *c, FI=
LE *fp, int op_type)
>         }
>         for (size_t i =3D 0; i < c->wwwauth_headers.nr; i++)
>                 credential_write_item(fp, "wwwauth[]", c->wwwauth_headers=
.v[i], 0);
> +       if (credential_has_capability(&c->capa_state, op_type)) {
> +               for (size_t i =3D 0; i < c->state_headers.nr; i++)
> +                       credential_write_item(fp, "state[]", c->state_hea=
ders.v[i], 0);
> +       }
>  }
>
>  static int run_credential_helper(struct credential *c,
> diff --git a/credential.h b/credential.h
> index 2051d04c5a..e2021455fe 100644
> --- a/credential.h
> +++ b/credential.h
> @@ -142,6 +142,11 @@ struct credential {
>          */
>         struct strvec wwwauth_headers;
>
> +       /**
> +        * A `strvec` of state headers from credential helpers.
> +        */
> +       struct strvec state_headers;
> +
>
>         /**
>          * Internal use only. Keeps track of if we previously matched aga=
inst a
>          * WWW-Authenticate header line in order to re-fold future contin=
uation
> @@ -156,6 +161,7 @@ struct credential {
>                  username_from_proto:1;
>
>         struct credential_capability capa_authtype;
> +       struct credential_capability capa_state;
>
>         char *username;
>         char *password;
> @@ -177,6 +183,7 @@ struct credential {
>         .helpers =3D STRING_LIST_INIT_DUP, \
>         .password_expiry_utc =3D TIME_MAX, \
>         .wwwauth_headers =3D STRVEC_INIT, \
> +       .state_headers =3D STRVEC_INIT, \
>  }
>
>  /* Initialize a credential structure, setting all fields to empty. */
> diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
> index 8477108b28..aa56e0dc84 100755
> --- a/t/t0300-credentials.sh
> +++ b/t/t0300-credentials.sh
> @@ -46,9 +46,12 @@ test_expect_success 'setup helper scripts' '
>         credential=3D$1; shift
>         . ./dump
>         echo capability[]=3Dauthtype
> +       echo capability[]=3Dstate
>         test -z "${capability##*authtype*}" || return
>         test -z "$authtype" || echo authtype=3D$authtype
>         test -z "$credential" || echo credential=3D$credential
> +       test -z "${capability##*state*}" || return
> +       echo state[]=3Dverbatim-cred:foo
>         EOF
>
>         write_script git-credential-verbatim-with-expiry <<-\EOF &&
> @@ -99,6 +102,29 @@ test_expect_success 'credential_fill invokes helper w=
ith credential' '
>         EOF
>  '
>
> +test_expect_success 'credential_fill invokes helper with credential and =
state' '
> +       check fill "verbatim-cred Bearer token" <<-\EOF
> +       capability[]=3Dauthtype
> +       capability[]=3Dstate
> +       protocol=3Dhttp
> +       host=3Dexample.com
> +       --
> +       capability[]=3Dauthtype
> +       capability[]=3Dstate
> +       authtype=3DBearer
> +       credential=3Dtoken
> +       protocol=3Dhttp
> +       host=3Dexample.com
> +       state[]=3Dverbatim-cred:foo
> +       --
> +       verbatim-cred: get
> +       verbatim-cred: capability[]=3Dauthtype
> +       verbatim-cred: capability[]=3Dstate
> +       verbatim-cred: protocol=3Dhttp
> +       verbatim-cred: host=3Dexample.com
> +       EOF
> +'
> +
>
>  test_expect_success 'credential_fill invokes multiple helpers' '
>         check fill useless "verbatim foo bar" <<-\EOF
> @@ -122,6 +148,7 @@ test_expect_success 'credential_fill invokes multiple=
 helpers' '
>  test_expect_success 'credential_fill response does not get capabilities =
when helpers are incapable' '
>         check fill useless "verbatim foo bar" <<-\EOF
>         capability[]=3Dauthtype
> +       capability[]=3Dstate
>         protocol=3Dhttp
>         host=3Dexample.com
>         --
> @@ -132,10 +159,12 @@ test_expect_success 'credential_fill response does =
not get capabilities when hel
>         --
>         useless: get
>         useless: capability[]=3Dauthtype
> +       useless: capability[]=3Dstate
>         useless: protocol=3Dhttp
>         useless: host=3Dexample.com
>         verbatim: get
>         verbatim: capability[]=3Dauthtype
> +       verbatim: capability[]=3Dstate
>         verbatim: protocol=3Dhttp
>         verbatim: host=3Dexample.com
>         EOF
