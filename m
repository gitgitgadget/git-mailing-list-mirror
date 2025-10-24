Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C7C1547C9
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 02:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761271403; cv=none; b=EFTB6hJFiHCV/FPpL9onSjsa49JqTd+7bqVvzC0j9ZB2T7IhFeVU8/qoYW04yS+hKXOUghk7SRE6ETiR8ieg0jgpZxRIBNlXkRTinGHM60neb+paIUuIzSoVkWp6pnuM0K/p7XvkNQ21eJY41+HeDcqDmIfJ/o9H1bDMICiGc20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761271403; c=relaxed/simple;
	bh=gEpuZFITVUgwg642h82zYetimLpZq1FTlATsjZjk72w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gv0L/xKKQXHtEC32p9cuOZGH1XYm8AyrvuSTHISjX96SGcGwc/A+CU6Zu/6lh5Hk9meR2l9as95gbZ9g3Uszc7mxqt7DDS11sX9d9K32WYvT7UHmf4HVHWCwKovTJOY2aS0f2XvTgLpEF4981mDH5WbsYnRPmrcKffOjY1p5En0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxxjzdSk; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxxjzdSk"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-430e1f19a1aso7627795ab.1
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 19:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761271399; x=1761876199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxjctB0MCjliMzlKlG20q59Y/UVrEkNfYs7uPFWNM/o=;
        b=BxxjzdSkGU9tsy3tHwbzJR7edIxfFYkQqw/Fv9rcK1Zb0oFIdGULBlXH8tZodIRUFc
         A6HSWCt6SDGpTxpgnMU2mjWjcD5hydlzOeFDtZqJxOoFceQvWb+GOZU6vaaRbZVW/53W
         ADxil9mFzogK5gRfJYya3JNBay4FFc/y10FdyO6khK91vnBXjFpV6qmSg7WZI8EM+qU1
         A31eVRSH+tvRxqWRURYgei7oELolOMBlMXVfBr1SP1oluqLKAnQN5bcVhzGP3mIJGdyU
         EgbJZilzAYtUq19lfpKzC8U+k0jEjCo6UMxszC1f8h0EoLYcDYSmt9Vi49CF/8/DXghd
         Nn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761271399; x=1761876199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxjctB0MCjliMzlKlG20q59Y/UVrEkNfYs7uPFWNM/o=;
        b=o26duOV4gWE5f4+oAh92V3UslwzeJBA+gXrwp9rPZU/4xyWOy6jkRLBpqhs3lOEr1w
         +z7bkhHBMwu9ZJ5H8CihnOq6Tp4E/CPn2O7aamyOJSlpk8Zy+fQMlF4B/sXzweGDvP0m
         sbQLM6b58NAzWTxdpzfvWcGoPDZSEXBjIYWh5kujg7LBZjovC5VpdKcfLNG5g/22LQR+
         8y6L72V2VjWosY4W2eoECgENiFk7tGdaGxhoaDWDxmN5uK1Z2YVrhVO5hMlqMm8lUGQm
         m53NEuavwqGNWJEuC25PlNojHSwrv9vSqkXMFroMX9PvQKeito8LSiIE0SNLurTgGG0R
         mB3Q==
X-Gm-Message-State: AOJu0Yx1ygKyee5WB3SnJpBvO+8VyvX+6xCEkR4BKu5flOFQi33TLY3N
	MdMNIckonmxP68FPV3i7YtkagGqhwODufbYcF4Q8X2629wEQbPl0+45OI/N3bBE8eqCl32AXubI
	GrtcZMdIo/OmOx6tbEFr5cnD47so1qt4=
X-Gm-Gg: ASbGncv5HpdKUoURDpZNJeoALwUzoS8ty2dgDX+2fMsZQczikHoJZ9qj8r241VPyABV
	EsN6o9zc7ERjeueDzRhp4cG2ku+bkIyHRrJACQyJm80p/UYpeCTSZPPevK/GVnCHgPU3o4l/YR/
	8qX7sdUxSoY7LNPg65fRC7RdN6x1bdfeawLNnoUuAHs+C9zAdpUizuZkiueBCXVhMVUqtowWLrO
	Rzv9GC7Z166fDDjZ6qaA394jPOg5GoW+HycuwzXijQxiin7TfezE63aFmxo
X-Google-Smtp-Source: AGHT+IFOTGkJofM0oGpMpaOSwf2m0kZjl2YqCLlKvhvElbzDheOoXIVy8XEUQJkMqHPV4Xq281slfx8WXnrcgwSALRs=
X-Received: by 2002:a05:6e02:1a42:b0:42f:a72e:e179 with SMTP id
 e9e14a558f8ab-431eb66831amr15548785ab.11.1761271399208; Thu, 23 Oct 2025
 19:03:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251013084857.1646783-1-christian.couder@gmail.com> <20251013084857.1646783-2-christian.couder@gmail.com>
In-Reply-To: <20251013084857.1646783-2-christian.couder@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 23 Oct 2025 22:03:08 -0400
X-Gm-Features: AS18NWCtjJEvtETK32bdwNakIILuy_DCepSzbm1sddF-5PFmEzeDrQlSBTp3MLY
Message-ID: <CABPp-BEhKH7goFVRJ=BvRi50StNbCDuE3VT=DOozPcxa=AsU6A@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] doc: git-tag: stop focusing on GPG signed tags
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Todd Zullinger <tmz@pobox.com>, 
	Collin Funk <collin.funk1@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 4:49=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> It looks like the documentation of `git tag` is focused a bit too
> much on GPG signed tags.
>
> This starts with the "NAME" section where the command is described
> with:
>
> "Create, list, delete or verify a tag object signed with GPG"
>
> while for example `git branch` is described with simply:
>
> "List, create, or delete branches"
>
> This could give the false impression that `git tag` only works with
> tag objects, not with lightweight tags, and that tag objects are
> always GPG signed.
>
> In the "DESCRIPTION" section, it looks like only "GnuPG signed tag
> objects" can be created by the `-s` and `-u <key-id>` options, and it
> seems `gpg.program` can only specify a "custom GnuPG binary".
>
> This goes on in the "OPTIONS" section too, especially about the `-s`
> and `-u <key-id>` options.
>
> The "CONFIGURATION" section also doesn't talk about how to configure
> the command to work with X.509 and SSH signatures.
>
> Let's rework all that to make sure users have a more accurate and
> balanced view of what the command can do.
>
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-tag.adoc | 48 ++++++++++++++++++++++++++------------
>  1 file changed, 33 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/git-tag.adoc b/Documentation/git-tag.adoc
> index a4b1c0ec05..28d6fe4e1a 100644
> --- a/Documentation/git-tag.adoc
> +++ b/Documentation/git-tag.adoc
> @@ -3,7 +3,7 @@ git-tag(1)
>
>  NAME
>  ----
> -git-tag - Create, list, delete or verify a tag object signed with GPG
> +git-tag - Create, list, delete or verify tags
>
>
>  SYNOPSIS
> @@ -38,15 +38,17 @@ and `-a`, `-s`, and `-u <key-id>` are absent, `-a` is=
 implied.
>  Otherwise, a tag reference that points directly at the given object
>  (i.e., a lightweight tag) is created.
>
> -A GnuPG signed tag object will be created when `-s` or `-u
> -<key-id>` is used.  When `-u <key-id>` is not used, the
> -committer identity for the current user is used to find the
> -GnuPG key for signing.         The configuration variable `gpg.program`
> -is used to specify custom GnuPG binary.
> +A cryptographically signed tag object will be created when `-s` or
> +`-u <key-id>` is used. The signing backend (GPG, X.509, SSH, etc.) is
> +controlled by the `gpg.format` configuration variable, defaulting to
> +OpenPGP. When `-u <key-id>` is not used, the committer identity for
> +the current user is used to find the key for signing. The
> +configuration variable `gpg.program` is used to specify a custom
> +signing binary.
>
>  Tag objects (created with `-a`, `-s`, or `-u`) are called "annotated"
>  tags; they contain a creation date, the tagger name and e-mail, a
> -tagging message, and an optional GnuPG signature. Whereas a
> +tagging message, and an optional cryptographic signature. Whereas a
>  "lightweight" tag is simply a name for an object (usually a commit
>  object).
>
> @@ -64,10 +66,12 @@ OPTIONS
>
>  -s::
>  --sign::
> -       Make a GPG-signed tag, using the default e-mail address's key.
> -       The default behavior of tag GPG-signing is controlled by `tag.gpg=
Sign`
> -       configuration variable if it exists, or disabled otherwise.
> -       See linkgit:git-config[1].
> +       Make a cryptographically signed tag, using the default signing
> +       key. The signing backend used depends on the `gpg.format`
> +       configuration variable. The default key is determined by the
> +       backend. For GPG, it's based on the committer's email address,
> +       while for SSH it may be a specific key file or agent
> +       identity. See linkgit:git-config[1].
>
>  --no-sign::
>         Override `tag.gpgSign` configuration variable that is
> @@ -75,7 +79,10 @@ OPTIONS
>
>  -u <key-id>::
>  --local-user=3D<key-id>::
> -       Make a GPG-signed tag, using the given key.
> +       Make a cryptographically signed tag using the given key. The
> +       format of the <key-id> and the backend used depend on the
> +       `gpg.format` configuration variable. See
> +       linkgit:git-config[1].
>
>  -f::
>  --force::
> @@ -87,7 +94,7 @@ OPTIONS
>
>  -v::
>  --verify::
> -       Verify the GPG signature of the given tag names.
> +       Verify the cryptographic signature of the given tags.
>
>  -n<num>::
>         <num> specifies how many lines from the annotation, if any,
> @@ -236,12 +243,23 @@ it in the repository configuration as follows:
>
>  -------------------------------------
>  [user]
> -    signingKey =3D <gpg-key-id>
> +    signingKey =3D <key-id>
>  -------------------------------------
>
> +The signing backend can be chosen via the `gpg.format` configuration
> +variable, which defaults to `openpgp`. See linkgit:git-config[1]
> +for a list of other supported formats.
> +
> +The path to the program used for each signing backend can be specified
> +with the `gpg.<format>.program` configuration variable. For the
> +`openpgp` backend, `gpg.program` can be used as a synonym for
> +`gpg.openpgp.program`. See linkgit:git-config[1] for details.
> +
>  `pager.tag` is only respected when listing tags, i.e., when `-l` is
>  used or implied. The default is to use a pager.
> -See linkgit:git-config[1].
> +
> +See linkgit:git-config[1] for more details and other configuration
> +variables.
>
>  DISCUSSION
>  ----------
> --
> 2.51.0.438.g6987fc0bae

Looks like some nice clarifications & corrections.
