Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E233F5BC3
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704706; cv=none; b=Zr/Gk+36PaBcMBIxackY3bAa2BRHP1o8y3IoLVmSc6q5t13xSgMZkSJVA9J77+DoUiakTUowJFZzAclhls5chdpX1+Kzc0Lnh5MqIO/QMsjLZIHu3FFJnBN/WN7MMfmVRIoIxyUsz2tofRnzLatWux0MYeVJ28vQCzx91NtpnUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704706; c=relaxed/simple;
	bh=xb8UTnrnrcQEM9hGpPoIBSbHRaELfrtfWH6uzODGjGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3OsY2sdo/RH5gT5ZZgg6AGDDd8dhZu/fH4Wk+qWlooO+iRJN+kT/BZUK/y8fj66W8u4CHVQJcH5A3A/yyxnuP1sp5jdu9caPEAxL5fsYlSxPke0oi0B3n5wP8q/JcDNmiaIiRTynli8qXw7ZJO0Q6OjDow6doWL9B26jOxj1Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=GrVP+Kvt; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="GrVP+Kvt"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45fe59255beso3295307f8f.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 06:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781704702; x=1782309502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pgnjeirYsbYFVkwr4ZTPruWXktwwqTL5tZG1aaR+mBA=;
        b=GrVP+KvtLItKFC3cyCDtIPlwgJx4tmc8xzOeh/S4JV0NUYgS8MQPt4YkED33EYjQYF
         eGda1u1tXlmSLtG9DPqo84D3W3bGN6r/4jtrmS3T1tZjLg0dsO5Uh6GxSV69S6Bryszb
         02D+xyA16eDtS2limeAEklSTyZ2/0R4aJ1TDXZsggIsvy5SjbyE2FzpYHKxC7wNiZTyb
         01Tni22LqVDYicmkmSnUtYN24aLqFx516IaL4L01fRjHgeZnygZyd/1aekgERL7RpJ7Z
         5WS61G9kRdP7Ety/CW/O4IsulmJnu5LHU6I2/vozFGTt3j9uxyg/e9NhREz93i6/DEC1
         +ZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781704702; x=1782309502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgnjeirYsbYFVkwr4ZTPruWXktwwqTL5tZG1aaR+mBA=;
        b=rYNbsgYRWGBWqr2jnDeWAzF2V7P0N9kNRnVGLTq3fh1dINMXVkSLKDoejA+74rUTIb
         AsXwxEpBhf9/bDn9aG7LlE3TNseVtsydFbZMFYmbtjHDbIwCoa5jrTSvLGXnqVSxtbp1
         8EBxpFXzVOY3S//R7fCrV4jLC+KE10j8bAH2IzWX++IMUR/rpECLmwIr6RC04n1UOCQ+
         7TvUrZY6t0x8kIDOGgxtdn0cYO4KJLz26RQHmZDojWP5ueNpOoo9PF4Ht6GBP3farTyI
         1/tAm2YhVXCI08wW0ieHU/55q7idKudltum9w6bFDDn5KKvH6BTzR9pMUUfwTYBRhHZz
         RGCA==
X-Gm-Message-State: AOJu0Yx5LmeGdpdMhXmtKl1I9DtCSPSDLCbytY4vRjc9yFnQF0HITg99
	EmZJY4PSAMaZWmseSzjFGrUouPq7J2rmjM+BVnmXdK3BovqgFB9D/a1SZDYeWfTAfjc=
X-Gm-Gg: AfdE7cmSe/b3gyTt48wZORBG5Jk8GUrMgr+VNUV6rAlX7jQoG5pHI0ScycP9f2afswM
	Yi7S+gvPSpSXkCvptjnWSVtDOq0xaK91LlEf1DGzz7AKQxVCEgCSd1dwrH8/hHzMBmEptAfaU2u
	lnc6E4pu+7jzMMyeWdLP1JlCkae0YIO90oSj/rEAwOupnDuHjUoyeeAdzjrN2hUKsa1D5YtjhQv
	SxWiwz4rUxZq5Lo9FtwmhvntFsMlXnJVZXu/rrV4Otkc9LBpvFJGS/1AoZidUWirJPmmUya2gwi
	JVAZqDkkEKaLS5Fp2RPEf3+uWGVSAQ0w228JnjYcagAVW1U5IWJXl6ae0eOYIPl11maqK02l34+
	7B990lie9vDtNcIoB3uox/FWoXzzXXwtyXMFshSqaCyonl8JD7xN9Oxq6fPoybY0j05bcW1DpMr
	Q3PQMA3sGx8GmLvy2SVn+pVGbzWn2AYXGX2t0Fu+kiIOLHuOaNx/eeujkWgl+fzQbk5/4RlrPvz
	EoK
X-Received: by 2002:a05:6000:184a:b0:462:a822:915d with SMTP id ffacd0b85a97d-462a8229518mr4506920f8f.39.1781704701859;
        Wed, 17 Jun 2026 06:58:21 -0700 (PDT)
Received: from localhost (p200300f65f47db00e4c4f0746abf89ff.dip0.t-ipconnect.de. [2003:f6:5f47:db00:e4c4:f074:6abf:89ff])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-462e7fc53fasm4116703f8f.33.2026.06.17.06.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 06:58:20 -0700 (PDT)
Date: Wed, 17 Jun 2026 15:58:19 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] sequencer: Skip copying notes for commits that disappear
 during rebase
Message-ID: <ajKimV1TDCgE-GzK@monoceros>
References: <20260616174012.601651-2-u.kleine-koenig@baylibre.com>
 <xmqqzf0txpu4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="65zxkq5peiii3by4"
Content-Disposition: inline
In-Reply-To: <xmqqzf0txpu4.fsf@gitster.g>


--65zxkq5peiii3by4
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] sequencer: Skip copying notes for commits that disappear
 during rebase
MIME-Version: 1.0

Hello Junio,

On Wed, Jun 17, 2026 at 06:24:03AM -0700, Junio C Hamano wrote:
> Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> writes:
>=20
> > Note that Phillip also suggested to integrete the test into
> > t3400-rebase.sh . IMHO it doesn't matter much if this is considered a
> > rebase test or a notes test. I kept it where I have it because I'm lazy
> > and failed to understand the git history created in that test.
>=20
> I do not think his suggestion was about "is this rebase or notes?"
> at all.  It was a lot more about "let's not add a new test script
> that does only one thing, when there is already a script that covers
> the same command and the same option for the command".  In fact,
> around 3400.28 there are test pieces that rebases commits that have
> notes.

OK, sounds fair.

> >  sequencer.c             | 20 ++++++++++----------
> >  t/meson.build           |  1 +
> >  t/t3322-notes-rebase.sh | 37 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 48 insertions(+), 10 deletions(-)
> >  create mode 100755 t/t3322-notes-rebase.sh
>=20
> We need some documentation updates to describe that the users can
> lose notes by doing a rebase and under what condition, no?

Well, the current state is that we're not losing notes, but that we
attach it to commits that most of the time are completely unrelated to
the commit the note was initially attached to. (i.e. in general it's not
attached to the commit that made the currently picked commit empty.) So
essentially the notes are lost, too, but also add confusion to where
they happen to get attached to.

> It is not yet clear to me if we want to _always_ discard a note from
> a commit that would become "empty" during a rebase session (in other
> words, a commit that becomes empty during a rebase is _always_ a
> sign that the change it brings in is _already_ in the new base of
> the rebase

Yeah, or in a patch that was picked before.

> and the necessary information the note wanted to carry to
> the target branch is there without need to _duplicate_ it by copying
> the note).  But assuming that we want the behaviour, the code change
> to sequencer.c looks very reasonable to me, except for one thing that
> I am not clear about.

I think given the commit goes away, it's natural that the note goes
away, too. And to come back to your question above: I think it doesn't
need documentation, that if a commit disappears its notes go away, too.
But that might be subjective?!

> > diff --git a/sequencer.c b/sequencer.c
> > index 57855b0066ac..da2185a37c5d 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > ...
> > @@ -4965,7 +4965,7 @@ static int pick_one_commit(struct repository *r,
> >  		return error_with_patch(r, commit,
> >  					arg, item->arg_len, opts, res, !res);
> >  	}
> > -	if (is_rebase_i(opts) && !res)
> > +	if (is_rebase_i(opts) && !res && !dropped_commit)
> >  		record_in_rewritten(&item->commit->object.oid,
> >  				    peek_command(todo_list, 1));
>=20
> If we have a sequence of commits where a commit that was *not*
> dropped is followed by a fixup commit that *is* dropped (e.g.,
> because it became empty/redundant), wouldn't it prevent the
> previously pending commit from being flushed to skip
> `record_in_rewritten` entirely for the dropped fixup commit?
>=20
> For example, if we have
>=20
>     pick X (with note)
>     fixup B (dropped because it is redundant)
>     pick C
>=20
> 1. `pick X`: calls `record_in_rewritten(X, TODO_FIXUP)`. `X` is
>    written to `pending`, but not flushed because the next insn is
>    `TODO_FIXUP` (B).
>=20
> 2. `fixup B`: gets dropped. `dropped_commit` is 1 in the code above,
>    so `record_in_rewritten` is skipped.
>=20
> 3. `pick C`: calls `record_in_rewritten(C, -1)`. `C` is written to
>    `pending`. Since next insn is not a fixup, it flushes `pending`
>    (which contains both `X` and `C`) to the commit created for `C`.

Huh, sounds possible. I wonder if that makes the change so complicated
that my time isn't well spend working on that given that I'm not used to
git's source code and it's better addressed by someone with deeper
knowledge. Sounds as if we need a state signaling "Current commit is
done".

> Wouldn't it map the note for `X` to rewritten `C`?
>=20
> > diff --git a/t/t3322-notes-rebase.sh b/t/t3322-notes-rebase.sh
> > new file mode 100755
> > index 000000000000..0eddde7f9961
> > --- /dev/null
> > +++ b/t/t3322-notes-rebase.sh
> > @@ -0,0 +1,37 @@
> > +#!/bin/sh
> > +
> > +test_description=3D'Test notes on rebase'
> > +
> > +. ./test-lib.sh
> > +
> > +test_expect_success setup '
> > +	git init &&
> > +	git config notes.rewriteRef refs/notes/commits &&
> > +	git version > version &&
> > +	echo A > A &&
>=20
> Style.  In our codebase, redirection operator sticks to the
> redirection target without SP in between, i.e.
>=20
> 	git version >version &&
> 	echo A >A &&
>=20
> > +	git notes add -m "This is B" @ &&
>=20
> '@' is hard to read; when you refer to HEAD, please write HEAD.
>=20
>=20
> > +test_expect_success 'rebase B + C on top of BD' '
> > +	git rebase @ master
> > +'
> > +
> > +test_expect_success 'assert there is no note on BD' '
> > +	if git notes list branch >/tmp/lalaa; then return 1; fi
> > +'
>=20
> Do not step outside of $TRASH_DIRECTORY without a good reason.

Oh, that is a debug thing that shouldn't have made it into the patch.
=20
> Style.  In our codebase, shell scripts do not use ';' and written
> more like
>=20
> 	if git notes list branch >notes-list
> 	then
> 		return 1
> 	fi
>=20
> But more importantly, if you want to make sure the command makes a
> controlled exit (not crash), use
>=20
> 	test_must_fail git notes list branch

Ah, I really wondered if I'm missing something because it should be
easier to say "this command should fail".

Best regards
Uwe

--65zxkq5peiii3by4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoyp/kACgkQj4D7WH0S
/k677Af9GiidUVkbk+80zw/zVtRiWctbI0+PlTI4svrQz1R00ALyBjUPBx9vFu3U
+feTZKCsMgKB9lysf16tljWGehmzYz1EcUWfAsHfFa6DEHrwbkh2pHRRjasUCaFI
y8HzaeXau9Wj/MV7NOvjTQlNepT6U0Jpg+2ZCMM6GikJJbRLr3GvSn2RmP06GJ26
NBBBYgfSLyLvEnUqm8Ptu3u70kdwWnTe9Jqd1XimD/iANyklTKssMwSGoYP5aOqP
apyKRrUkjh6WwTthnGYCpRvhw+AilmKFywP0J4PZTpZavqIx5yC9EqorqPOq5bzg
it35Qmx53hG5RmeqsnNUB8MlmXywMw==
=ZoKj
-----END PGP SIGNATURE-----

--65zxkq5peiii3by4--
