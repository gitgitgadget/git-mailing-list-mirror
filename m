Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5738827
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557522; cv=none; b=cRJ+rZbjrdncWzSZ2gFZ92k9yS/y3ULVZWMdR/IA8p7/jqNWcBnxV+UabxmziCiNljyjCrY38+WqEy+O78IxR0ZBMQg9XlIV+zMdoIp+AAiGQVn0UBC6QBsFyZGoZRXnuOwhVp1rLxUfIbB/PMD5iipXqZD6zuNtCjFHMGOFjpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557522; c=relaxed/simple;
	bh=Qnx0O/OrXctxFMHGaam4b1pJg6QcT1J+VVjErr8RY2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfJMSIBEr03E3X0HepVB4/6nsIYrPhKnfSk8vKWP4Vz0V3dSeJqwJnKRDp8dbrN2ZH7jqgVhX1ZFhcZkqVRqn/mM8gqXJyonJwHCv/hLEPmzYfHk9Xd/2GN3kL1mq0r5aZYgEGIsV1Ttkz1VLsQn6D3/q5z7hlrN+Xq6EU+ooCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gTznbhvz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JUgbnSQK; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gTznbhvz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JUgbnSQK"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0604811400CE;
	Mon,  8 Apr 2024 02:25:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 08 Apr 2024 02:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712557519; x=1712643919; bh=Qnx0O/OrXc
	txFMHGaam4b1pJg6QcT1J+VVjErr8RY2g=; b=gTznbhvz8tijR04G3Q6KrHk93a
	pBAZG25io5oWWns+BzVCNu4lUBzKowCzhpFEdcLlJTWnOqmraO0d4W8diuLU3lPt
	4Cp59jcAO8N+0Qi/y7AvR2iDkGm3FNBhIV8isHn/SSe5U0NbzNelw0R7zf60yQpl
	lR/UhAh2ZOxCf+NRLWgeNBhcwqS+MFzjQg+AHQCy6bw5tprrpW7Q9/qw5cqaE0uZ
	fuVE0ESShKC6XVs5cKv8t+6wZshJXVGbQ0iohwsOT0QxZcKLNZJiFZFLY19T4OpA
	n215nt7fk7LKfwm7kr5Esfg/bMAHUCTB8m7O38pB+tv0aaqf0UVg+dXZYIww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712557519; x=1712643919; bh=Qnx0O/OrXctxFMHGaam4b1pJg6Qc
	T1J+VVjErr8RY2g=; b=JUgbnSQKXDu+qKNkLIXYyYMNBUw0oNrjkZAEOnDmXTUF
	Q7iAV+E+XleMeSZ8AJLwS4fUtNUzr+okilvSmQ0YgkClA2d55ND+bx0RL8JZ6AjF
	CfCpI3fmom2UyXUqequScSTROEI5ZnkNdHybQKxbMPpWdnbYd3rYhdDY9evsw2vZ
	EBpEvuQrRvQcdlCq22vdGQtUkxaY/eKLZ+06iaKle3JHPrVZR8Fb9FUaLjQWX1Nk
	4/dt+DSajTk+EvHYJASpW8xjiHknVjioImp0BqjFkG6LcxJQs5HeVZqhecC/k7Iv
	ux3KLiYA47MBZx6XpRdAVTpKyKFjIpm5jc8vxqgESw==
X-ME-Sender: <xms:zo0TZqN6l4JBXtSmKuTfJg50yZYeulJndzGJI2z0GUXLS_3Cc2BicQ>
    <xme:zo0TZo_F52KbFi-hqUkCrK66RDzKtiyny5Sq6dn3cdkLGjDyUKqwvXd7NZV69d21M
    sJMkpS49SIE-DOsSw>
X-ME-Received: <xmr:zo0TZhTwYXGOh7oarPY_vyTZZ_XWAbdromc68_wu-OdSCHPgJuhzwujI96j9Nk2QE7C-OGMmFKlYiDBXJ3EcvHAk3KoejVPHt8cjwo2xf21l354p2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeghedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdorredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpedvueetueekgfdvhfdvtddujeeihfffgeegiefftdduhfelieejleekffehtdeh
    ueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:zo0TZqucuDOYUHkQn7gyrG90w0QqIlXTVzT1kZGsNAnR0lWk23cPyg>
    <xmx:zo0TZicbRNZ2Lzl5p1uXeo-tcMbrsbkpva07PeSYs57r4g-4vuyYbg>
    <xmx:zo0TZu01P8ZFY24OqG_3PjOmZeiBeahz5wPVP_6W2b8R7JPBA68wwA>
    <xmx:zo0TZm91duKCr1o5vlCbjVRDKBZE52BejUG0mhKHXjDnd3Mv2-6j3g>
    <xmx:zo0TZovRmQOO3EBJ8lOij6CXqEvyKPn4tNi6BuvRFn0jafNldo2t--5V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 02:25:16 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id abc0fd33 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 06:25:09 +0000 (UTC)
Date: Mon, 8 Apr 2024 08:25:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Thalia Archibald <thalia@archibald.dev>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/8] fast-import: tighten parsing of paths
Message-ID: <ZhONyBIFlWbNHNwN@tanuki>
References: <20240322000304.76810-1-thalia@archibald.dev>
 <cover.1711960552.git.thalia@archibald.dev>
 <A820E635-14FA-403C-B932-D7F9FE57C092@archibald.dev>
 <CAPig+cSu5dLoDew-efAB-H95B53fteDGNO=_1jc9i_MUqdpw-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fzBF0aONCkjobMt4"
Content-Disposition: inline
In-Reply-To: <CAPig+cSu5dLoDew-efAB-H95B53fteDGNO=_1jc9i_MUqdpw-g@mail.gmail.com>


--fzBF0aONCkjobMt4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 07, 2024 at 07:46:52PM -0400, Eric Sunshine wrote:
> On Sun, Apr 7, 2024 at 5:19=E2=80=AFPM Thalia Archibald <thalia@archibald=
=2Edev> wrote:
> > On Apr 1, 2024, at 02:02, Thalia Archibald wrote:
> > >> fast-import has subtle differences in how it parses file paths betwe=
en each
> > >> occurrence of <path> in the grammar. Many errors are suppressed or n=
ot checked,
> > >> which could lead to silent data corruption. A particularly bad case =
is when a
> > >> front-end sent escapes that Git doesn't recognize (e.g., hex escapes=
 are not
> > >> supported), it would be treated as literal bytes instead of a quoted=
 string.
> > >>
> > >> Bring path parsing into line with the documented behavior and improve
> > >> documentation to fill in missing details.
> > >
> > > Thanks for the review, Patrick. I've made several changes, which I th=
ink address
> > > your feedback. What's the protocol for adding `Reviewed-by`? Since I =
don't know
> > > whether I, you, or Junio add it, I've refrained from attaching your n=
ame to
> > > these patches.
> >
> > Hello! Friendly ping here. It=E2=80=99s been a week since the last emai=
ls for this patch
> > set, so I=E2=80=99d like to check in on the status.
>=20
> Pinging is certainly the correct thing to do.
>=20
> Regarding `Reviewed-by:`: that trailer doesn't mean that someone
> merely read and commented on a patch. Instead, it's explicitly _given_
> by a reviewer to indicate that the reviewer has thoroughly reviewed
> the patch set and is confident that it is ready to be merged into the
> project, at which point Junio typically adds the `Reviewed-by:`.
>=20
> > As a new contributor to the project, I don=E2=80=99t yet have a full vi=
ew of the
> > contribution flow, aside from what I=E2=80=99ve read. I suspect the lat=
ency is because I
> > may not have cc=E2=80=99d all the area experts. (When I sent v1, I used=
 separate Cc
> > lines in send-email --compose, but it dropped all but the last. After P=
atrick
> > reviewed it, I figured I could leave the cc list as-is for v2, assuming=
 I=E2=80=99d get
> > another review.) I=E2=80=99ve now cc=E2=80=99d everyone listed by contr=
ib/contacts, as well as
> > the maintainer. For anyone not a part of the earlier discussion, the la=
test
> > version is at https://lore.kernel.org/git/cover.1711960552.git.thalia@a=
rchibald.dev/.
> > If that=E2=80=99s not the problem, I=E2=80=99d be keen to know what I c=
ould do better.
>=20
> Lack of response may be due to the series being overlooked, or it
> could mean that nobody has any particular interest in the changes
> (which is not to say that there is anything wrong with the changes),
> or that people are simply busy elsewhere. It could also mean that this
> reroll is good enough and reviewers have nothing else to add. So,
> cc'ing potentially interested people makes sense.

Yeah, for this patch series I think it's mostly a lack of interest.
Which is too bad, because it does address some real issues with
git-fast-import(1). Part of the problem is also that this area does not
really have an area expert at all -- if you git-shortlog(1) for example
"builtin/fast-import.c" for the last year you will see that it didn't
get much attention at all.

Anyway, I'm currently trying to make it a habit to pick up and review
random patch series that didn't get any attention at all every once in a
while, which is also why I reviewed your first version. I'm taking these
a bit slower though, also in the hope that some initial discussion may
motivate others to chime in, as well. Which may explain why I didn't yet
review your v2.

In any case I do have it in my backlog and will get to it somewhen this
week.

> > I have several more patch sets in the works, that I=E2=80=99ve held bac=
k on sending
> > until this one is finished, in case I=E2=80=99ve been doing something w=
rong. I want to
> > move forward. Thank you for your time.
>=20
> If the additional patch sets are unrelated to this patch set, then I
> don't see a reason to hold them back. Feel free to send them. Even if
> they are related to this patch set, you may still want to send them.
> After all, doing so may get the ball rolling again on this patch set.

Agreed. Especially given that this is your first contribution, the
quality of your patch series is quite high. So I don't see much of a
reason to hold back the other patch series in case they are unrelated.

Patrick

--fzBF0aONCkjobMt4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYTjccACgkQVbJhu7ck
PpTTvxAAinVmRRQp/BbLP2V2xwFeAZ7sLHFTy07kt+oe8yqHBz0d0VhGkc2DSqsF
eGGuHCLJ08D8rIyVZmzSuvGobxkvKf9IPDTBX4OXlP4goD9f+pZCcmEwnnivJyai
y7tEcI+o8TRlEVHI3UKS0LjiXjYSt2MWzKdkvRuq7Avry+TkTAcgXvhTDHzubu+W
I9sYwpgFG0NWeqT0/kn3nkyzPrqaT1V+404EnFx5DKtMm+XDzrfJSqIA3ieDbOCv
rg2k8K/+F56n3KV8QiCX8cBanw6wc5FJCLSSNuT6Qeauw/kcpvSjwRT6YlTjurQ9
MR1vLiUbsaK3IMSTtDJAyHjrrJfK5rioeyQlQT2pf+Zq8+b4hPTVUlPWgKVB+f+z
8PRXz2DTT85OfP3bVoSem7XMNJCjqZ2SUSF7Q2ALajznXG/czqh6qLcUGW+aoBPH
c+6lZhVRN7oaN/OPDBvnD/FI8ZM6KkpZixABOQMAkR77gZDuxyWEt8m5GABvqAKr
JxHKqUwWcqcd1NuvJ5kSX4IIfRF+IobI7olb8PYOoyGux9kMMK/Rxd57fRxoDr8h
Q7uzoIxdomz4v2k1ASW1HvbYWyuEFVYDqkhM0G3Cyv9lIc/tS1klDB03uWuxk/dF
0f9rXzR2qjgN4RPQolxjlTEqYzBZVu1xlCerrtUiFnPr3dMEUfw=
=cPxc
-----END PGP SIGNATURE-----

--fzBF0aONCkjobMt4--
