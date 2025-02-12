Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C837320B1E5
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380724; cv=none; b=UE+0hGt9/auEcqPuje941vdrhHUuwzNZNq8DqrxReVjh0rS4n6QsujLYE/vQKrYOlgXurIf4kzqMOebbBJL5aWOZGxTCfUh/hF553uiyfFJjYaw4UnSJApB4boBFgrEsq4ErwIjVV0PpnTHBmF44BET83wUputVf9mfK1CCfRlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380724; c=relaxed/simple;
	bh=F2G1EcHtcPkV9O2w17tPXA/w6yCbkLE8JLsmzj5kXPY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k4KMNKQ6bdRVe75VNMpXVTrrtyvGvpF9CxZjcvLhFkZI9nO/S3PVIB/b1ZWFHCFxUAMMGKElBW8mFv6b6SpO9VlSe/sInSmo4z9a0TcSMsPRX+/crvysAedBn/sdj/KHTCyhlkgaI/WGfMrPRuabAkoMt4W/+aZQFDWXIC0KuIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=V+90plq4; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="V+90plq4"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38dc6d55ebaso773227f8f.1
        for <git@vger.kernel.org>; Wed, 12 Feb 2025 09:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1739380720; x=1739985520; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PyInCW6u8G5hUJBiepzgi17u6YRSe3V64VrmsjORqS0=;
        b=V+90plq4zhfiXGKB1nHOMZdJLtWiG0lAN59qXh0MnvMn5ttmqgwe3tb2yOhrS965yD
         edQNQAVy25Zci2M2FMIdagjyznPZMCgXHbpUBXcWvOimOZerxOlyOIghDDQ+W8K891vj
         Au7dcldQgE2Ayy9Vs96r+BtvLfEPDRGyHza28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739380720; x=1739985520;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyInCW6u8G5hUJBiepzgi17u6YRSe3V64VrmsjORqS0=;
        b=l3vh1yznVoYQQUnFUSOKT67KIMCTRO6rRIZjhb+C6WtrFxn8ZJcme03/Su+SmgJDdY
         8FAITrsOXuK3VsbSJ0JtTX+5FGMcX+DnqFuAWyYgEr4OV0bzi45NU8R/L9788CnDtKem
         fntBL3ESoJ5g6T0KSJGxXwvPmtrS2JV5vqRpDt4ZOmWThcbN1x+AVH0OH+c9Np754MMD
         TedRlhx3zt9/GqHe6DQzzS4TPCkeBy45dYZoHsDXJ78wGcVSdw1bcCOSB6gX86av3CuM
         jDxcojV/+bdGxgbP3V4u537g/MSRpwUjj7d3DU8/6LQSw/j0vn3iAkO6dqxchaXx8YPM
         0pCg==
X-Forwarded-Encrypted: i=1; AJvYcCXvTq06c9bjF2V+qeWQtDvBbceEFOGd1kNyII+kQBH7Pxn3xVO2y+nUOxJ7pgM/N2wIAZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ktuvMXpdC+gO/iW+9Ju3q7QPS2/lIxxnVnwvThMA0KS6S/GR
	iXy4GiSgjEg5mqTsd7GLcT6P+MbZvSJAG47TiXSwojC6NTa+nDGudrfobZvBlIw=
X-Gm-Gg: ASbGncvmwlZ5+loFLwoK42/lh04op1wLjYO3kj8nU0erGNJsnOXz3ENWZpfZy5grXpb
	K22FvkXMqiIiD/QWIMYBWtKENI6+pwHm8SY6xEL2wX1npE23WURMcQPDkKZbjNs4wXRx0f+G2MY
	3uDu8GSnzRtUWnpoaF27GPhxqtd0hBz8X7e4vXWAuxEpy90UqIc6e9xxhOjguAu/t9Jg+GmoiKc
	QAhqZfE4CA1RA34vZNPfqeTMCab0/zF8zeBKgTz0XwmYI2ZKv7k2FdqMHgK8vjl4dvrBDFru6CH
	oLwdXlswiDtSgdpOzjMd7aIL1sGBkiodGE1oF/UPGMrheBRz8g==
X-Google-Smtp-Source: AGHT+IHziD1Qfm67nchXDJyFN2F5uYsRkKBezsbVCL8j34p5jRY75EFmatopnKE0gIlKALjpPlInpg==
X-Received: by 2002:a05:6000:4714:b0:38d:df15:2770 with SMTP id ffacd0b85a97d-38f2453998bmr200822f8f.0.1739380719685;
        Wed, 12 Feb 2025 09:18:39 -0800 (PST)
Received: from able.exile.i.intelfx.name ([188.129.244.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcdb54668sm14844650f8f.35.2025.02.12.09.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:18:39 -0800 (PST)
Message-ID: <f0fa961084281b1d5948f59c42cf0c87e731d9bc.camel@intelfx.name>
Subject: Re: [PATCH] rebase: add `--update-refs=interactive`
From: Ivan Shapovalov <intelfx@intelfx.name>
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Alex Henrie <alexhenrie24@gmail.com>
Date: Wed, 12 Feb 2025 21:18:36 +0400
In-Reply-To: <5b605c3e-ef6a-433a-9637-1e8f277dfde9@gmail.com>
References: <20250210191650.316329-1-intelfx@intelfx.name>
	 <1279671f-4063-4347-b153-9f6ff079bd77@gmail.com>
	 <f689c263ead8104ec42f63f1e9ed10350a27ae1d.camel@intelfx.name>
	 <5b605c3e-ef6a-433a-9637-1e8f277dfde9@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-5G46x6bfC94Mc4FYH12P"
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-5G46x6bfC94Mc4FYH12P
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2025-02-12 at 14:26 +0000, Phillip Wood wrote:
> Hi Ivan
>=20
> On 11/02/2025 18:11, Ivan Shapovalov wrote:
> > On 2025-02-11 at 14:36 +0000, Phillip Wood wrote:
> > > On 10/02/2025 19:16, Ivan Shapovalov wrote:
> > >=20
> > > I'm a bit surprised by this - I'd have thought there is more scope fo=
r
> > > messing things up by making a mistake when editing the todo list that
> > > for the non-interactive case. Are you able to explain a in a bit more
> > > detail the problem you have been experiencing please?
> >=20
> > I often find myself managing multiple interdependent downstream patch
> > branches, rebasing them en masse from release to release. Eventually,
> > I found myself typing `git rebase -i --update-refs` more often than
> > not, so I just stuck it into the config as `rebase.updateRefs=3Dtrue`.
> >=20
> > However, sometimes I also maintain those patch branches for multiple
> > releases. Consider a (hypothetical) situation:
> >=20
> > - tag v1
> > - tag v2
> > - branch work/myfeature-v1 that is based on tag v1
> >=20
> > Now, I want to rebase myfeature onto v2, so I do this:
> >=20
> > $ git checkout work/myfeature-v1
> > $ git checkout -b work/myfeature-v2
> > $ git rebase --onto v2 v1 work/myfeature-v2
> >=20
> > With `rebase.updateRefs=3Dtrue`, this ends up silently updating _both_
> > work/myfeature-v2 and work/myfeature-v1.
>=20
> Thanks for the explanation. So this is about copying a branch and then=
=20
> rebasing the copy without updating the original. A while ago there was a=
=20
> discussion[1] about excluding branches that match HEAD from=20
> "--update-refs". Maybe we should revisit that with a view to adding a=20
> config setting that excludes copies of the current branch from=20
> "--update-refs".

This idea stops working once you have a bunch of interdependent feature
branches (consider two branches work/myfeatureA and work/myfeatureB,
with the latter based on the former, with each having two versions as
described above, and then you rebase work/myfeatureB-v2 from v1 onto v2
and expect to update work/myfeatureA-v2 but not work/myfeatureA-v1).
Excluding branches that match HEAD is a very narrow workaround that
only fixes one particular instance of one particular workflow.

I don't understand the opposition, really =E2=80=94 in my understanding, an
ability to restrict update-refs to interactive runs is a significantly
useful mechanism that does not impose any particular policy. It answers
the question of "I want git to _suggest_ updating refs by default, but
only if I have a chance to confirm/reject each particular update".

>=20
> Maintaining multiple versions of the same branch sounds like a lot of=20
> work - whats the advantage over merging a single branch into each release=
?

Different people, different workflows.

--=20
Ivan Shapovalov / intelfx /

>=20
> [1]=20
> https://lore.kernel.org/git/adb7f680-5bfa-6fa5-6d8a-61323fee7f53@haller-b=
erlin.de/
>=20
> > With this in mind, I wrote this patch such that update-refs only
> > happens for interactive rebases, when I have the chance to inspect the
> > todo list and prune unwanted update-refs items.
> >=20
> > Does this make sense? I made an attempt to explain this motivation in
> > the commit message, so if this does make sense but the commit message
> > doesn't, please tell me how to improve/expand the latter.
>=20
> I think having the example in the commit message would help - I feel=20
> like I've now got a clear idea of the problem you are facing whereas I=
=20
> didn't understand what the issue was just from the commit message.
>=20
> > > > Try to find a middle ground by introducing a third value,
> > > > `--update-refs=3Dinteractive` (and `rebase.updateRefs=3Dinteractive=
`)
> > > > which means `--update-refs` when starting an interactive rebase and
> > > > `--no-update-refs` otherwise. This option is primarily intended to =
be
> > > > used in the gitconfig, but is also accepted on the command line
> > > > for completeness.
> > >=20
> > > I'm not convinced allowing "--update-refs=3Dinteractive" on the
> > > commandline improves the usability - why wouldn't I just say
> > > "--update-refs" if I want to update all the branches or
> > > "--no-update-refs" if I don't? I also think supporting
> > > --update-refs=3D(true|false) is verbose and unnecessary as the user c=
an
> > > already specify their intent with the existing option.
> >=20
> > I make heavy use of aliases for various workflows, which invoke one
> > another (making use of the ability to override earlier command-line
> > options with the latter ones), and the ability to spell out
> > `alias.myRebase =3D rebase ... --update-refs=3Dinteractive ...` was use=
ful.
>=20
> You can write your alias as
>=20
>     alias.myRebase =3D -c rebase.updaterefs=3Dinteractive rebase ...
>=20
> instead. It is not quite as convenient but it means we don't have to add=
=20
> complexity to the command line interface that is only useful for aliases=
=20
> (I can't think of a use for "--update-refs=3Dinteractive" outside of an=
=20
> alias definition).
>=20
> > Re: specifying `=3D(true|false)`, the intention was to avoid unnecessar=
y
> > divergence, both in UX and code (and reuse the parser to simplify said
> > code). If you think it will be harmful, I'll remove that.
>=20
> It would be even simpler if we didn't change the command line interface ;=
)
>=20
> > > >    rebase.updateRefs::
> > > > -	If set to true enable `--update-refs` option by default.
> > > > +	If set to true, enable the `--update-refs` option of
> > > > +	linkgit:git-rebase[1] by default. When set to 'interactive',
> > >=20
> > > Our existing documentation is inconsistent in how it formats config
> > > values. rebase.backend uses "apply", rebase.rebaseMerges uses
> > > `rebase-cousins` which I think matches other commands and is therefor=
e
> > > what we should use here and rebase.missingCommitCheck uses a mixture
> > > with "warn" and `drop`.
> >=20
> > Apologies, I'm not sure I understood what exactly you were suggesting
> > here. Did you mean to suggest wrapping "interactive" in backticks
> > instead of single quotes?
>=20
> Sorry that wasn't very clear. Yes that is what I was trying to say.
>=20
> > > > +	if (v >=3D 0)
> > > > +		return v ? UPDATE_REFS_ALWAYS : UPDATE_REFS_NO;
> > > > +	else if (!strcmp("interactive", value))
> > > > +		return UPDATE_REFS_INTERACTIVE;
> > > > +
> > > > +	die(_("bad %s value '%s'; valid values are boolean or \"interacti=
ve\""), desc, value);
> > >=20
> > > I think we normally say "invalid" or "unknown" rather than "bad" in o=
ur
> > > error messages. It'd be clearer just to list the possible values as
> > > there are only three of them.
> >=20
> > It's not just three (see other review from Junio), otherwise OK
>=20
> As this is a hint in a error message I don't think we need to=20
> exhaustively list all the possible synonyms git accepts for "true" and=
=20
> "false"
>=20
> > > > +	/* coerce --update-refs=3Dinteractive into yes or no.
> > > > +	 * we do it here because there's just too much code below that ha=
ndles
> > > > +	 * {,config_}update_refs in one way or another and modifying it t=
o
> > > > +	 * account for the new state would be too invasive.
> > > > +	 * all further code uses {,config_}update_refs as a tristate. */
> > >=20
> > > I think we need to find a cleaner way of handling this. There are onl=
y
> > > two mentions of options.config_update_refs below this point - is it
> > > really so difficult for those to use the enum?
> >=20
> > See above; I opted to make this change as non-invasive as possible and
> > keep the complex argument validation logic (lines 1599, 1606-1609)
> > intact because I'm not even sure I understand it right.
> >=20
> > Besides, even if I convert those uses to use enumerators, I still
> > wouldn't want to deal with non-tristate values beyond this point.
>=20
> We could add a new boolean variable which is initalized here and use=20
> that instead in the code below. Of the code below could just call=20
> should_update_refs() to convert the enum to a boolean.
>=20
> Best Wishes
>=20
> Phillip
>=20
>=20

--=-5G46x6bfC94Mc4FYH12P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJJBAABCgAzFiEE5N8nvImcx2nJlFGce94XyOTjDp0FAmes1+wVHGludGVsZnhA
aW50ZWxmeC5uYW1lAAoJEHveF8jk4w6dyDgP/3VpkLDkVdroMraFr3rabPtYhn5b
I03GTWFd+HM5Pad1xQH1t169E8n5EqJZ8u4gisZ7+ZdD4SxNFLgAfeb6t7dfvujq
eCkrpjkPjjiKCAQxlIh8GWz4tly317HGWmBzQn1W1c+wAaR3RhC+OV5kldjy8nVa
N/v8M/t5P5M16Otcxk/gLhdmh/+siJ+Fng/4SaU/QRTOlg9L+AaAT7sJurd6pIDv
Fi0RNHtiTgUTQlza20wLOmrq2Tkp6ddnKfgfqTfnPeUpwS2OJoHniv2HnLdxx4JJ
zAukS5d7HL+CZWCb1YuKdcddX2AL0KcQB855SLsIwwY8wQtaOBiruTAul9D9207q
qbhNsTRt/nyIqUj8Cua44qormNz9vUXI1ii7MdYfdTyhAstGlKj5B1OIpsNRPjvo
CX0GgUdz1HO1ZoLXrDibZjVhcrMOJF0TW6+ikfRVY/Z0VyGSO/zQO8QSn1NEXlSk
QNZBlaJoP+bDHcQbiD61Fnba3Ild7WeM8Fwi93J9qsxhxeePO5NstiBf/+rPbCNa
gTPylqtW9PvrcO2RjEAUWWPfCLG2xj/VQFdMgA7AgXlOgOsyLGswdFvm2RddndVS
DdZw8eXdy5wjHANur9eMWHi5wwJLyUWK1LymsmqP08EK16im0LVy70jJ3ixSZvCW
qDLBbtS2KBwXURpc
=Vise
-----END PGP SIGNATURE-----

--=-5G46x6bfC94Mc4FYH12P--
