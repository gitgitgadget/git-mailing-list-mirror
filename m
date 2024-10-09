Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5652118DF74
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474804; cv=none; b=URUWts1cguMU7jTDLdHt6nRc0Gu+RgzEprO5I5ar3gyAJbGfATLhQ+KdiJ8LVWxqwMHO06dHO5Pq0NR1kbQUO3ELMs6cWaDoiwJfVwfPlPUNYrHrOQwRnm4TmQHw1qSzU5hiQi/+CuOijHT+IuuAUQHbqaA0mvryfaEkQzqak/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474804; c=relaxed/simple;
	bh=lSQwqDM9N4eysFMn+tZacKbxX7AM3eU6ehw3m9lbOak=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AA/aMW620gGlDVv8Z5tvPt3UmhjRDQ9eHom3RO/IQZ+bOpKDmXWzQkrPm610LsUCx51d07v9zy6QNCY/Kjv4mtIgOAwAnbzH5oCs1Bdn8gkRe2jl6FONOhaR8HXl82nIquxC4ijOgh3X7ALovszwJxhT799QbDW0rKEy3/FOMRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0hp2Ju7; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0hp2Ju7"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5398e3f43f3so7854410e87.2
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 04:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728474800; x=1729079600; darn=vger.kernel.org;
        h=mime-version:user-agent:disposition-notification-to:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lSQwqDM9N4eysFMn+tZacKbxX7AM3eU6ehw3m9lbOak=;
        b=I0hp2Ju7PuS9oTyqrdoDRXdHZv7Bzq3PN5Nq/pdiyS3Qkxdg6HhJ47lxvrNBd6rRpB
         9kZONq2O4Hd7nOUQ168FMOIQCu07smskoVU7fqbm8p9niHhggOKRUmXw0GKQneKZ4zIN
         DR9Tq1yS0HV6C8pkBlF4MCVpJfJugzsAZOYbjAWwsz65136tnyzQMby4xO24APdWW0mO
         27ma0/ZxLYiU3iQL/wq+3l2m5TAklb22SkFAAZa9lTjOFerHU90go9mZkD4AQLGdYYHZ
         imSItFMdEFLNmgVOyWIHk3FSNEyxiDxeLa0dUPvnqyC0NkKhthw4Ddpe849nuDU2QxET
         Ne4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728474800; x=1729079600;
        h=mime-version:user-agent:disposition-notification-to:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSQwqDM9N4eysFMn+tZacKbxX7AM3eU6ehw3m9lbOak=;
        b=H6mN7O50vwsiD0RFFFAeVedZkSHKulSEEUGNdM7297gqrGEtQwDYSghJ2Bu8w+gozT
         awWRojD3AlxGb7wUevxJlm5IFawlrmgEH/bHoLpoLReQYi8/Gd7NzBPBhUwbyPw0xkFv
         T7PUvIaeDGyzAl6wYP4Za5jDb0IisSHETo4i4sIxfTCphvz7dAITJQQpyTt6uoUBpbux
         bSTyTqOixnJIgy17/Gm4dsYBWD7fh5Y4DFJpBBvRD9lMouCqOVuMmBCqPwSNSrwFbC44
         +aCg8KZGwEsjcz3QcU7iO/cWCtx9y17W5Fqu0GRXWo8oE7ujeX796eaapnyfmCJwJqWc
         TQJQ==
X-Gm-Message-State: AOJu0Yxjv4rUaLMsjY47IaywH96pq2YiMXMKQiNYEW2ldoXWHmAHjrth
	g4UBYSK5mWeV5/yEljy/AAAJOxF4oX4F8E5pbPWm/Zur3ZggrZE=
X-Google-Smtp-Source: AGHT+IG54Zvoig1IU9igrrvD1KBYf48fpqrJasilp/Fj4wOXbIn7I1AzMAy4xgSb2ZojLvnu8t1w/g==
X-Received: by 2002:a05:6512:3b23:b0:52e:74d5:89ae with SMTP id 2adb3069b0e04-539c4951548mr1332642e87.39.1728474799612;
        Wed, 09 Oct 2024 04:53:19 -0700 (PDT)
Received: from ?IPv6:2001:67c:10ec:578f:8000::133? (2001-67c-10ec-578f-8000--133.net6.ethz.ch. [2001:67c:10ec:578f:8000::133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d32fcd05esm3213031f8f.84.2024.10.09.04.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 04:53:18 -0700 (PDT)
Message-ID: <5cd07a8d3c554815d4fce20996c018c6294c63e6.camel@gmail.com>
Subject: Re: Bug: `git init` with hook `reference-transaction` running `git
 rev-parse --git-dir` fails
From: Gabriel =?ISO-8859-1?Q?N=FCtzi?= <gnuetzi@gmail.com>
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 09 Oct 2024 13:53:17 +0200
In-Reply-To: <ZwZPSA-J1RFQKYrw@pks.im>
References: <0084cc18b6d90ba14849a7f788939f4a1d0d61c9.camel@gmail.com>
	 <ZwOVy4FltrEjxHn_@pks.im>
	 <867f42bea10de470532d2f30eacceafa2b03d8de.camel@gmail.com>
	 <ZwO-j0C59vuYsEnt@pks.im>
	 <a8807b44026458097267932f429ef61d5b77aa4c.camel@gmail.com>
	 <ZwPEwL-fKHBkUOcm@pks.im> <xmqqiku38w51.fsf@gitster.g>
	 <ZwZPSA-J1RFQKYrw@pks.im>
Autocrypt: addr=gnuetzi@gmail.com; prefer-encrypt=mutual;
 keydata=mDMEZkXiuBYJKwYBBAHaRw8BAQdAGuoC79ZXUA/zkkAgeLEElUIBjYsvKXPlkbWqF5RcZ
 q+0N0dhYnJpZWwgTsO8dHppIChFZDI1NTE5L0N1cnZlMjU1MTkpIDxnbnVldHppQGdtYWlsLmNvbT
 6IkwQTFgoAOxYhBPJPUqh3/IpkCoNuHfnjsP+dTnqBBQJmReK4AhsDBQsJCAcCAiICBhUKCQgLAgQ
 WAgMBAh4HAheAAAoJEPnjsP+dTnqBOsoBAMzBqtykviO+gsSRXCRLsoy2qtxZbZjR/ES9zZLTobhn
 AQDZJiTrILQTFNHNJ26NLVDM+Av+cjgeOezlCEcAa/N0Aw==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-aL6ZPzg9BlOq3E9CTLAe"
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-aL6ZPzg9BlOq3E9CTLAe
Content-Type: multipart/alternative; boundary="=-jlzK/ndkUq3fdShkv4Db"

--=-jlzK/ndkUq3fdShkv4Db
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


> We have another solution that is even simpler: just do nothing. I do not =
=20
> think that the behaviour we exhibit is wrong. Unwieldy? Maybe. But it is =
=20
> merely stating facts: we are executing a transaction in a repository =20
> that is not yet fully set up. If you don't want that, either don't set =
=20
> up a global reference-transaction hook, or alternatively handle that =20
> edge case in your script.

But then Git should at least give the hooks maintainers a chance to know wh=
at it is doing.
Could we have a new env. variable or mechanism stating that the repository =
is not yet setup or so?
The issue here comes from the fact that Githooks is a hooks manager which b=
asically calls `reference-transaction` for you, but before
it does it calls `git rev-parse --git-dir` to get the correct Git directory=
, basically not doing env. lookup on GIT_DIR which this command actually do=
es, but that apparently only works on a "initialized" repo, so currently I =
do a workaround and looking directly at GIT_DIR.
I would be really happy also if I could somehow know when Git is creating a=
 new repository (clone, or init), that would also improve other scenarios I=
 came across. Basically you cannot react on hook `post-checkout` only when =
a new repo is created...


Gabriel

-----Original Message----- =20
**From**: Patrick Steinhardt <[ps@pks.im](mailto:Patrick%20Steinhardt%20%3c=
ps@pks.im%3e)> =20
**To**: Junio C Hamano <[gitster@pobox.com](mailto:Junio%20C%20Hamano%20%3c=
gitster@pobox.com%3e)> =20
**Cc**: Gabriel N=C3=BCtzi <[gnuetzi@gmail.com](mailto:Gabriel%20%3d%3fISO-=
8859-1%3fQ%3fN%3dFCtzi%3f%3d%20%3cgnuetzi@gmail.com%3e)>, [git@vger.kernel.=
org](mailto:git@vger.kernel.org), Karthik Nayak <[karthik.188@gmail.com](ma=
ilto:Karthik%20Nayak%20%3ckarthik.188@gmail.com%3e)> =20
**Subject**: Re: Bug: `git init` with hook `reference-transaction` running =
`git rev-parse --git-dir` fails =20
**Date**: 10/09/2024 11:39:26 AM

On Mon, Oct 07, 2024 at 02:02:02PM -0700, Junio C Hamano wrote:

> Patrick Steinhardt <[ps@pks.im](mailto:ps@pks.im)> writes:
>=20
>=20
> > `$GIT_DIR` _is_ defined during hook
> > execution. So in theory, if git-rev-parse(1) behaved exactly as
> > documented, it shouldn't even care whether or not it is executing in a
> > repository.
>=20
>=20
> I've always considered "git rev-parse --git-dir" and friends were to
> verify the validity of the repository before returning "Your GIT_DIR
> is here".=C2=A0 Otherwise there is no easy way to ask "I have this direct=
ory.
> Is it a valid repository you can work with?".
>=20
> So, I am not sure I agree with the above.


Well, I'm not sure either. I was merely pointing out that the documented =
=20
behaviour is different than the actual behaviour. Which of both is the =20
more sensible one is a different question.


> For what is worth, I am skeptical to the "solution" that tentively
> creates a bogus HEAD file while the repository is being initialized.
> The code today may ignore certain bogosity in such a HEAD (like the
> ".invalid" magic used during "git clone"), but there is no guarantee
> that a random third-party add-on a hook script may invoke do the
> same as we do, and more importantly, what a repository with its
> initialization complete look like may change over time and it may
> not be enough to have HEAD pointing at "refs/heads/.invalid" to fool
> our bootstrap process.=C2=A0 If we were to go that route, I would rather
> see us pick a pointee that is *not* bogus at the mechanical level
> (i.e., "git symbolic-ref HEAD refs/heads/.invalid" would fail) but
> is clearly a placeholder value to humans, soon to be updated.
>=20
> Let's say if we were to create a repository with the name of initial
> branch as 'main', we could create HEAD that points at refs/heads/main
> bypassing any hook intervention, then call the hook to see if it
> approves the name.=C2=A0 We'd need to make sure that we fail the
> repository creation when the hook declines, as it is refusing to set
> a HEAD, one critical element in the repository that has to exist,
> and probably remove the directory if we are not reinitializing.
>=20
> Or we could use a name that is clearly bogus to humans but is still
> structurally OK, say "refs/heads/hook-failed-during-initialization",
> ask the hook if it is OK to repoint HEAD to "refs/heads/main" from
> that state, and (1) if it approves, HEAD will point at "refs/heads/main"
> and "hook-failed-during-initialization" will be seen nowhere but the
> reflog of HEAD, or (2) if it refuses, we stop, and the user will be
> left on an unborn branch with a long descriptive name that explains
> the situation.


I dunno. It all feels rather complex.


> A much simpler alternative would be to simply ignore any hooks,
> traces, or anything that want to look into the directory we are
> working to turn into a repository but haven't completed doing so,
> during repository initialization, I would think, though.


That could work, yes, but it would limit the usefulness of the hook. In =
=20
theory, you can create a full log of all changes in the repository from =
=20
its inception. If we didn't log the first item, that log would be =20
incomplete.

We have another solution that is even simpler: just do nothing. I do not =
=20
think that the behaviour we exhibit is wrong. Unwieldy? Maybe. But it is =
=20
merely stating facts: we are executing a transaction in a repository =20
that is not yet fully set up. If you don't want that, either don't set =20
up a global reference-transaction hook, or alternatively handle that =20
edge case in your script.

Patrick

--=-jlzK/ndkUq3fdShkv4Db
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<blockquote type=3D"cite">
<p>We have another solution that is even simpler: just do nothing. I do not=
<br />
think that the behaviour we exhibit is wrong. Unwieldy? Maybe. But it is<br=
 />
merely stating facts: we are executing a transaction in a repository<br />
that is not yet fully set up. If you don't want that, either don't set<br /=
>
up a global reference-transaction hook, or alternatively handle that<br />
edge case in your script.</p>
</blockquote>
<p>But then Git should at least give the hooks maintainers a chance to know=
 what it is doing.
Could we have a new env. variable or mechanism stating that the repository =
is not yet setup or so?
The issue here comes from the fact that Githooks is a hooks manager which b=
asically calls <code>reference-transaction</code> for you, but before
it does it calls <code>git rev-parse --git-dir</code> to get the correct Gi=
t directory, basically not doing env. lookup on GIT_DIR which this command =
actually does, but that apparently only works on a &quot;initialized&quot; =
repo, so currently I do a workaround and looking directly at GIT_DIR.
I would be really happy also if I could somehow know when Git is creating a=
 new repository (clone, or init), that would also improve other scenarios I=
 came across. Basically you cannot react on hook <code>post-checkout</code>=
 only when a new repo is created...</p>
<p>Gabriel</p>
<p>-----Original Message-----<br />
<strong>From</strong>: Patrick Steinhardt &lt;<a href=3D"mailto:Patrick%20S=
teinhardt%20%3cps@pks.im%3e">ps@pks.im</a>&gt;<br />
<strong>To</strong>: Junio C Hamano &lt;<a href=3D"mailto:Junio%20C%20Haman=
o%20%3cgitster@pobox.com%3e">gitster@pobox.com</a>&gt;<br />
<strong>Cc</strong>: Gabriel N=C3=BCtzi &lt;<a href=3D"mailto:Gabriel%20%3d=
%3fISO-8859-1%3fQ%3fN%3dFCtzi%3f%3d%20%3cgnuetzi@gmail.com%3e">gnuetzi@gmai=
l.com</a>&gt;, <a href=3D"mailto:git@vger.kernel.org">git@vger.kernel.org</=
a>, Karthik Nayak &lt;<a href=3D"mailto:Karthik%20Nayak%20%3ckarthik.188@gm=
ail.com%3e">karthik.188@gmail.com</a>&gt;<br />
<strong>Subject</strong>: Re: Bug: <code>git init</code> with hook <code>re=
ference-transaction</code> running <code>git rev-parse --git-dir</code> fai=
ls<br />
<strong>Date</strong>: 10/09/2024 11:39:26 AM</p>
<p>On Mon, Oct 07, 2024 at 02:02:02PM -0700, Junio C Hamano wrote:</p>
<blockquote type=3D"cite">
<p>Patrick Steinhardt &lt;<a href=3D"mailto:ps@pks.im">ps@pks.im</a>&gt; wr=
ites:</p>
<blockquote type=3D"cite">
<p><code>$GIT_DIR</code> <em>is</em> defined during hook
execution. So in theory, if git-rev-parse(1) behaved exactly as
documented, it shouldn't even care whether or not it is executing in a
repository.</p>
</blockquote>
<p>I've always considered &quot;git rev-parse --git-dir&quot; and friends w=
ere to
verify the validity of the repository before returning &quot;Your GIT_DIR
is here&quot;.=C2=A0 Otherwise there is no easy way to ask &quot;I have thi=
s directory.
Is it a valid repository you can work with?&quot;.</p>
<p>So, I am not sure I agree with the above.</p>
</blockquote>
<p>Well, I'm not sure either. I was merely pointing out that the documented=
<br />
behaviour is different than the actual behaviour. Which of both is the<br /=
>
more sensible one is a different question.</p>
<blockquote type=3D"cite">
<p>For what is worth, I am skeptical to the &quot;solution&quot; that tenti=
vely
creates a bogus HEAD file while the repository is being initialized.
The code today may ignore certain bogosity in such a HEAD (like the
&quot;.invalid&quot; magic used during &quot;git clone&quot;), but there is=
 no guarantee
that a random third-party add-on a hook script may invoke do the
same as we do, and more importantly, what a repository with its
initialization complete look like may change over time and it may
not be enough to have HEAD pointing at &quot;refs/heads/.invalid&quot; to f=
ool
our bootstrap process.=C2=A0 If we were to go that route, I would rather
see us pick a pointee that is <em>not</em> bogus at the mechanical level
(i.e., &quot;git symbolic-ref HEAD refs/heads/.invalid&quot; would fail) bu=
t
is clearly a placeholder value to humans, soon to be updated.</p>
<p>Let's say if we were to create a repository with the name of initial
branch as 'main', we could create HEAD that points at refs/heads/main
bypassing any hook intervention, then call the hook to see if it
approves the name.=C2=A0 We'd need to make sure that we fail the
repository creation when the hook declines, as it is refusing to set
a HEAD, one critical element in the repository that has to exist,
and probably remove the directory if we are not reinitializing.</p>
<p>Or we could use a name that is clearly bogus to humans but is still
structurally OK, say &quot;refs/heads/hook-failed-during-initialization&quo=
t;,
ask the hook if it is OK to repoint HEAD to &quot;refs/heads/main&quot; fro=
m
that state, and (1) if it approves, HEAD will point at &quot;refs/heads/mai=
n&quot;
and &quot;hook-failed-during-initialization&quot; will be seen nowhere but =
the
reflog of HEAD, or (2) if it refuses, we stop, and the user will be
left on an unborn branch with a long descriptive name that explains
the situation.</p>
</blockquote>
<p>I dunno. It all feels rather complex.</p>
<blockquote type=3D"cite">
<p>A much simpler alternative would be to simply ignore any hooks,
traces, or anything that want to look into the directory we are
working to turn into a repository but haven't completed doing so,
during repository initialization, I would think, though.</p>
</blockquote>
<p>That could work, yes, but it would limit the usefulness of the hook. In<=
br />
theory, you can create a full log of all changes in the repository from<br =
/>
its inception. If we didn't log the first item, that log would be<br />
incomplete.</p>
<p>We have another solution that is even simpler: just do nothing. I do not=
<br />
think that the behaviour we exhibit is wrong. Unwieldy? Maybe. But it is<br=
 />
merely stating facts: we are executing a transaction in a repository<br />
that is not yet fully set up. If you don't want that, either don't set<br /=
>
up a global reference-transaction hook, or alternatively handle that<br />
edge case in your script.</p>
<p>Patrick</p>

--=-jlzK/ndkUq3fdShkv4Db--

--=-aL6ZPzg9BlOq3E9CTLAe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTyT1Kod/yKZAqDbh3547D/nU56gQUCZwZurQAKCRD547D/nU56
get0AP9v5ztNR/WbmVhqA8RQPL5RDAqO1VCQnsvELtQYjs6BpAEAhr+JA/mlW23E
sEohTf2AH7dwkuUWLZfRv8b4y3jngwE=
=9pbZ
-----END PGP SIGNATURE-----

--=-aL6ZPzg9BlOq3E9CTLAe--
