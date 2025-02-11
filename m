Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5601E3DD0
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 18:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739297514; cv=none; b=AwmYZuvbJ/akYTTBxJoPq+jUqCkw/hdjM7s83eSpAzVRn5YCvg6ViHNysnb6nu2kvW8X/uLrySiUXmdpkmwmB5AopQxuYxVSweAo0L5Z70oThVZSkBU8bKqLA3VcNgCujzivCw2N4sYu5m8akVlichOcwb46gGQRMhFQqllX/DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739297514; c=relaxed/simple;
	bh=H7mSmL04gQdoADKlagPnPm+JrpC4smgqH/grDUv6xV0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q2hJtOwAsosqe3pwaE+RuKOeQDzdOOegn5CQuA6E49vc3JnUfyQ3Xz5FcDpMyLX9XNevZsourq/4Pqwusq2qh3Ahp0QKMANiVjKGd9dsIEbhWiFnE2VYH/5f98ttg0F+MJ7kOfK4pSEpF044mfBMCzr59orzKF5opV4EgJrgSkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=LTrpZJH+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="LTrpZJH+"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-439350f1a0bso174685e9.0
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 10:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1739297510; x=1739902310; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qC231pLiJpvoC2WMUeY3OtEbICCDa7UuooMWN/X3FP4=;
        b=LTrpZJH+gd9ef88OZxTzAcJ7WkjXhDOvDh0o/TCjLY06IIqjFwfxG5m+EFgh1+f8eR
         8Pk9iP85NODUwLe6BxzGQYgPnv0ZvDGh+R69HI6+nzV2p4OUS/DShANuCDuy87gRTPIW
         b6jRG0AmKdRd6EbVasngASimy5qtgBlnIUo0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739297510; x=1739902310;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qC231pLiJpvoC2WMUeY3OtEbICCDa7UuooMWN/X3FP4=;
        b=rvGbbvXsS/kOtAiERj34i4h9DhGE98NpWaNsF4QToAUlgUBmftF0KTtyKg/GuFZQnH
         dHfHX1ZzSJ8cgLSOrWO2M4GQtra/E8P5y93VqSUh4pdyy1ulv01y9jKdy/F7dn+Ju9A0
         sTlyk7uPJtm/4edjb6vlZWhLIP8EWct+rwxN1sELzVXeQqSRFbXAt5OFUHp4wMVnb0d6
         9AcWlx80ydrRnrSPZVK9giQIn+wKGsEaYNTQnpnl/nceDYimgyFmpPfmVi/bPmLJZn5c
         NssWM/vH9Hnl8yp0p9wLzmspQVGyxbE6KdDwxv/07KTE7VkCrC/gvVgCvSqi4N9l1MYX
         kHiw==
X-Forwarded-Encrypted: i=1; AJvYcCUJEwzRxAmHHxB9rXX0RJArVRjemiZdc4ulRr+eXR/DSUjpa5arwSYKWPZ7gZDOetawKz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7AowWNzO/6gUVBAEVDW+UG/eRW/6vLEMAuGFtpf4FyPAXmGAV
	tg1zjDNeDTOLKB8cuuGX/gvlhdGxNNmRpE05WbzLk0CqjSADTrLLC1KASzsvDcg=
X-Gm-Gg: ASbGnct1pNQxgzrUXxQyPUMJsKqkxDIiDrnr4f8wTTXgJ+E8eCqvz6N0CLgzhI68C3d
	KD4s7sWcib19xUn9GHs6wnDLChJgYRPus01neW6XaUpeuAxwfv/Me40oIQRNYaJ3sCxXeWNXB9B
	K32mp4uTqSyFoCjvnwUVLYFNk8qi+SkIesAftM99fAUzce/0ktmgQxNiFh/a9CU9RtN9nAGoHYa
	JYBb8kUm7ohVpqj+ST6oru6U/bMHncFe6Goq+wytOgxRHfx4Sve/KjmN+CLapWSUqeh1e5Oz+Cn
	yeQST9YEHcUsdbmpZo3tPKEWNCdtLkHoMuTwKbGxVS1ANBijhQ==
X-Google-Smtp-Source: AGHT+IGgEHyk+NCoYShsTkCJCQqaApAXcVawGVLPMeTBOr3tj3hv+GCNBhmgDV7gL7wwlM1vtanugA==
X-Received: by 2002:a05:600c:3ac4:b0:434:f9ad:7222 with SMTP id 5b1f17b1804b1-439583b4e03mr291685e9.7.1739297509486;
        Tue, 11 Feb 2025 10:11:49 -0800 (PST)
Received: from able.exile.i.intelfx.name ([188.129.244.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dcae5c7sm182401515e9.18.2025.02.11.10.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 10:11:48 -0800 (PST)
Message-ID: <f689c263ead8104ec42f63f1e9ed10350a27ae1d.camel@intelfx.name>
Subject: Re: [PATCH] rebase: add `--update-refs=interactive`
From: Ivan Shapovalov <intelfx@intelfx.name>
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Alex Henrie <alexhenrie24@gmail.com>
Date: Tue, 11 Feb 2025 22:11:45 +0400
In-Reply-To: <1279671f-4063-4347-b153-9f6ff079bd77@gmail.com>
References: <20250210191650.316329-1-intelfx@intelfx.name>
	 <1279671f-4063-4347-b153-9f6ff079bd77@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-5L2HG8iIisxBTLzhjo1L"
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-5L2HG8iIisxBTLzhjo1L
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2025-02-11 at 14:36 +0000, Phillip Wood wrote:
> Hi Ivan
>=20
> On 10/02/2025 19:16, Ivan Shapovalov wrote:
> > In rebase-heavy workflows involving multiple interdependent feature
> > branches, typing out `--update-refs` quickly becomes tiring, which
> > can be mitigated with setting the `rebase.updateRefs` git-config option
> > to perform update-refs by default.
> >=20
> > However, the utility of `rebase.updateRefs` is somewhat limited because
> > you rarely want it in a non-interactive rebase (as it does not give you
> > the chance to review the update-refs candidates, likely leading to
> > updating refs that you didn't want updated -- I made quite an amount
> > of mess by setting this option and subsequently forgetting about it).
>=20
> I'm a bit surprised by this - I'd have thought there is more scope for=
=20
> messing things up by making a mistake when editing the todo list that=20
> for the non-interactive case. Are you able to explain a in a bit more=20
> detail the problem you have been experiencing please?

I often find myself managing multiple interdependent downstream patch
branches, rebasing them en masse from release to release. Eventually,
I found myself typing `git rebase -i --update-refs` more often than
not, so I just stuck it into the config as `rebase.updateRefs=3Dtrue`.

However, sometimes I also maintain those patch branches for multiple
releases. Consider a (hypothetical) situation:

- tag v1
- tag v2
- branch work/myfeature-v1 that is based on tag v1

Now, I want to rebase myfeature onto v2, so I do this:

$ git checkout work/myfeature-v1
$ git checkout -b work/myfeature-v2
$ git rebase --onto v2 v1 work/myfeature-v2

With `rebase.updateRefs=3Dtrue`, this ends up silently updating _both_
work/myfeature-v2 and work/myfeature-v1.

With this in mind, I wrote this patch such that update-refs only
happens for interactive rebases, when I have the chance to inspect the
todo list and prune unwanted update-refs items.

Does this make sense? I made an attempt to explain this motivation in
the commit message, so if this does make sense but the commit message
doesn't, please tell me how to improve/expand the latter.

>=20
> > Try to find a middle ground by introducing a third value,
> > `--update-refs=3Dinteractive` (and `rebase.updateRefs=3Dinteractive`)
> > which means `--update-refs` when starting an interactive rebase and
> > `--no-update-refs` otherwise. This option is primarily intended to be
> > used in the gitconfig, but is also accepted on the command line
> > for completeness.
>=20
> I'm not convinced allowing "--update-refs=3Dinteractive" on the=20
> commandline improves the usability - why wouldn't I just say=20
> "--update-refs" if I want to update all the branches or=20
> "--no-update-refs" if I don't? I also think supporting=20
> --update-refs=3D(true|false) is verbose and unnecessary as the user can=
=20
> already specify their intent with the existing option.

I make heavy use of aliases for various workflows, which invoke one
another (making use of the ability to override earlier command-line
options with the latter ones), and the ability to spell out
`alias.myRebase =3D rebase ... --update-refs=3Dinteractive ...` was useful.

Re: specifying `=3D(true|false)`, the intention was to avoid unnecessary
divergence, both in UX and code (and reuse the parser to simplify said
code). If you think it will be harmful, I'll remove that.

>=20
> >   rebase.updateRefs::
> > -	If set to true enable `--update-refs` option by default.
> > +	If set to true, enable the `--update-refs` option of
> > +	linkgit:git-rebase[1] by default. When set to 'interactive',
>=20
> Our existing documentation is inconsistent in how it formats config=20
> values. rebase.backend uses "apply", rebase.rebaseMerges uses=20
> `rebase-cousins` which I think matches other commands and is therefore=
=20
> what we should use here and rebase.missingCommitCheck uses a mixture=20
> with "warn" and `drop`.

Apologies, I'm not sure I understood what exactly you were suggesting
here. Did you mean to suggest wrapping "interactive" in backticks
instead of single quotes?

>=20
> > +	only enable `--update-refs` by default for interactive mode
> > +	(equivalent to `--update-refs=3Dinteractive`).
> > +	This option can be overridden by specifying any form of
> > +	`--update-refs` on the command line.
>=20
> > @@ -129,10 +129,17 @@ struct rebase_options {
> >   	int reschedule_failed_exec;
> >   	int reapply_cherry_picks;
> >   	int fork_point;
> > -	int update_refs;
> > +	// UPDATE_REFS_{UNKNOWN,NO,ALWAYS} numeric values must never
> > +	// change as post-option-parsing code works with {,config_}update_ref=
s
> > +	// as if they were ints
>=20
> This feels a bit fragile - why can't we update the code to use the enum?=
=20

It'd just be a lot of code to update, incl. stylistically (especially
the implicit truthy/falsy coercions or `>=3D 0`). I opted to make the
change as non-invasive as possible.

> Also note that comments should be formatted as
>=20
> /* single line comment */
>=20
> or
>=20
> /*
>   * multi-line
>   * comment
>   */

OK

>=20
> > +	enum {
> > +		UPDATE_REFS_UNKNOWN =3D -1,
> > +		UPDATE_REFS_NO =3D 0,
> > +		UPDATE_REFS_ALWAYS =3D 1,
> > +		UPDATE_REFS_INTERACTIVE,
> > +	} update_refs, config_update_refs;
>=20
> I don't think we want to change the type of `update_refs` as I'm not=20
> convinced we want to change the commandline option.
>=20
> > +static int coerce_update_refs(const struct rebase_options *opts, int u=
pdate_refs)
>=20
> I'd be tempted to call this "should_update_refs(...)"

OK

>=20
> > +{
> > +	/* coerce "=3Dinteractive" into "no" rather than "not set" when not i=
nteractive
> > +	 * this way, `git -c rebase.updateRefs=3Dyes rebase --update-refs=3Di=
nteractive [without -i]`
> > +	 * will not inherit the "yes" from the config */
>=20
> Style - see above

OK

>=20
> > +	if (update_refs =3D=3D UPDATE_REFS_INTERACTIVE)
> > +		return (opts->flags & REBASE_INTERACTIVE_EXPLICIT)
> > +		       ? UPDATE_REFS_ALWAYS
> > +		       : UPDATE_REFS_NO;
> > +	return update_refs;
> > +}
> > [...]  =20
> > +static int parse_update_refs_value(const char *value, const char *desc=
)
> > +{
> > +	int v =3D git_parse_maybe_bool(value);
>=20
> Style: there should be a blank line after the variable declarations at=
=20
> the start of a function.

OK

>=20
> > +	if (v >=3D 0)
> > +		return v ? UPDATE_REFS_ALWAYS : UPDATE_REFS_NO;
> > +	else if (!strcmp("interactive", value))
> > +		return UPDATE_REFS_INTERACTIVE;
> > +
> > +	die(_("bad %s value '%s'; valid values are boolean or \"interactive\"=
"), desc, value);
>=20
> I think we normally say "invalid" or "unknown" rather than "bad" in our=
=20
> error messages. It'd be clearer just to list the possible values as=20
> there are only three of them.

It's not just three (see other review from Junio), otherwise OK

>=20
> > +	/* coerce --update-refs=3Dinteractive into yes or no.
> > +	 * we do it here because there's just too much code below that handle=
s
> > +	 * {,config_}update_refs in one way or another and modifying it to
> > +	 * account for the new state would be too invasive.
> > +	 * all further code uses {,config_}update_refs as a tristate. */
>=20
> I think we need to find a cleaner way of handling this. There are only=
=20
> two mentions of options.config_update_refs below this point - is it=20
> really so difficult for those to use the enum?

See above; I opted to make this change as non-invasive as possible and
keep the complex argument validation logic (lines 1599, 1606-1609)
intact because I'm not even sure I understand it right.

Besides, even if I convert those uses to use enumerators, I still
wouldn't want to deal with non-tristate values beyond this point.

--=20
Ivan Shapovalov / intelfx /

>=20
> Given a bit more detail I could be convinced that the config option is=
=20
> useful but I don't think we should be changing the commandline option.
>=20
> Best Wishes
>=20
> Phillip
>=20

--=-5L2HG8iIisxBTLzhjo1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJJBAABCgAzFiEE5N8nvImcx2nJlFGce94XyOTjDp0FAmerkuEVHGludGVsZnhA
aW50ZWxmeC5uYW1lAAoJEHveF8jk4w6d+WkP/jACzCAwGro8diaV48z4EtDn9X1b
z2lNTCyxRYui50gzA3dwDZmuFTE3YHEPUuc89q8lIFmca2SmrKoJ2X5zHkb7W8hZ
7nd8sdr1Bmxy+5d4x1NV5Pr4s2Mfk40F+lLF2wSq/C5++zuMicRibeB0PgcrobvW
NdcEtUNwDzey3ANiOrAEs93D/9QaHwzeA1y0ZzF55WtxTNdmweTz1bgvv8uwi3q+
RdGREgnVQXecqtoJvdu9VZASpAl9GbhYjOXzbiLh4MIyjeo60Dhh8380PXTDrfqo
2otbZxZ4E1eOmjvwILEd3FXyCpJka+pUUTkNvi/1ZdTSXgTh3U5X3xvJP6LEA15m
q16mRf4st723xs0iNOXZklqEgGWMX41AmJsrdKofUx+NJzbUh/ILjQSVdKZJKLef
rFpBjKZXs10ATdavBr6cKU3KNqMF1zRfeRLDzku35nM04ils+/SRJ4357TScjOmI
fBK4TYkhWLVSKTJLYMpC5UBgNkgVs5hPLKQRIsp7IzGIPhEo8I3csSMh5vaYuhuw
3y4WNlMP1kAMgKaKs9FCY2ZcIFKv/yKYewk+SHKA+yKBeK6K8RADQC0Qm8SAZK6b
efP6BEoUlZAfDIW9z+KA06olJYr/SnH5rEWM4Ucdwc1jQM5vuMUhB/8i2IHeCWZT
hEzlD8Xg+PCguDA1
=YPfR
-----END PGP SIGNATURE-----

--=-5L2HG8iIisxBTLzhjo1L--
