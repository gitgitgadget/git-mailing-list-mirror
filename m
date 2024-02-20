Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ED12E3E5
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418058; cv=none; b=nk2w7erq+spQLXNKwRC//XDYJDSk3OZIxEFK9uNvzL2KEiLETZXo0VUNcu+csMQKBSjMTk3HLcznsN6g+IEDB6NjvJJOKI44Br0ZT2fe6vuYhsy5CPiuWKDsM0tR2G5autjpYJCx4ZIXHMV4yAt3VN9RIVpix3HpnsfPUTIrlco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418058; c=relaxed/simple;
	bh=rsFLbbY2BLPI42WSsQTldp8uJragsTl7Zkyk+5Y7EPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiSRm3BcDoMHXxpRG203q6j8v7LEavNWRV2KyZ8HxLjhS6tlcExmbMPHdSq+B8zJPgU8++vEG1WaCQJhlN0naHZVbZJ3y6FxL/rlJ2BUDygxYbEkiL371+fhdc+sMRMiVyuFReVAIsZ87IwI/iTJrXTUSBp+druyuVQsoVVVbts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mC0aJJJH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QXGA3dis; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mC0aJJJH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QXGA3dis"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 7A27B180008E;
	Tue, 20 Feb 2024 03:34:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 20 Feb 2024 03:34:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708418054; x=1708504454; bh=P+YrDUwjWU
	bTB9ZNJKTucFXZ6m4f3YRJuPASDrwffR8=; b=mC0aJJJHNNa+zcSL15075gyEqS
	Z28A1bIw2ZWS74H4OPzYyQpVqpRbVt10OOm3QazeAkeFvXHlqC/Ca4h2o9CTloxg
	v6AnWfXdI5kgXbbr0dxFjBIRXSwJ6gutRbcVfEA/5YFx02uPwH1MHiPIbcPCUNsJ
	Dafmjmeahanb3vkM5waZT3Mq249fXXkky0qhCW7Ns+6iY3Lqx0siSp3by6WbBhIa
	1OIB0ko8Zgu8uYzVUUEgFiFBtATy63hcAj2H6PEB7k9YGiqtEMbGVNXK+PUFLHPV
	Y7PQAB/a4lT3a8XROfvo499x6Q1LhECEPd3B7+nysSK2hdxi4ViYQoIkvD+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708418054; x=1708504454; bh=P+YrDUwjWUbTB9ZNJKTucFXZ6m4f
	3YRJuPASDrwffR8=; b=QXGA3disfWM6Oxc1S4lxIPtRN14a40b7Xy2vnhYnF2XY
	Bz8q3xKQc6Y4yq9apYcYIg1OzCWCxG6C0R3VlS7lswDIIoK2HFBsg216EyhuumeF
	31CeNXxbLXVqqjBc781KNDSGVnkL39RmHpUJrQPteQ9ar/3/OwJ8czXPL0fowQGd
	RkKrZJ52ld4ty5pzfJmj6VppSIUwz0//LeaS1kj0C5e0Sng5aYUwKZuRG92H43Yg
	35UmK77d/oLPqcMjUjzqXtnVMzYYeHW7A8bbrSDJ6H26SbHIlSEtUMLQcL1Cb3zh
	L+iEgmZ7QG6lSyfMQvd4f6KBqw+OuZabUmyHHUyvHA==
X-ME-Sender: <xms:BWTUZf_-G4V_VqpGze8pCQhSy5V4ZKcLBw4ruxdkv_3NDoDLfqc96g>
    <xme:BWTUZbvIDlFEgunPoYkeNQBlp-i9aylKwYcdAIJPk8ODwqBY4zFFtJpOMvnOPJmW9
    gZ6WlthJ4towYPNfA>
X-ME-Received: <xmr:BWTUZdDRZ_lCI1HhsaQE6B3YhuLj0yTxpiurQVxs7OiDL42nA5ScDsM3FMvyITi3nOsiFSkORMuj7t7ue0ST6Eb8kDebB5UcUn_tiQ1vXO5Bsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:BWTUZbehWIgdI7U8D8Lxb7mKN7kwNIXcJY63ta4f9qr1CS9LF5OApg>
    <xmx:BWTUZUMJ_7EJJZvgvHt_RHEjcLeeo1RpjHzYWb-Lfiec1SIt1ZEmOw>
    <xmx:BWTUZdm_kxAqa43WdJMtZYyTBfqwz82RUBccZpvBISRbI-WIte-iBQ>
    <xmx:BmTUZdbbGgmVEPFAO9EbutypfWcyM1CWfWYiQszkzoNARJbxaNjmEPHp4J4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 03:34:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b4a51994 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Feb 2024 08:30:08 +0000 (UTC)
Date: Tue, 20 Feb 2024 09:34:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] dir-iterator: support iteration in sorted order
Message-ID: <ZdRkAe5zajmGb95q@tanuki>
References: <cover.1708353264.git.ps@pks.im>
 <8a588175dbf23d1938db45507812aad8f3793dbb.1708353264.git.ps@pks.im>
 <xmqq8r3g10tf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PWWsuq9nJQcLJV/U"
Content-Disposition: inline
In-Reply-To: <xmqq8r3g10tf.fsf@gitster.g>


--PWWsuq9nJQcLJV/U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 03:39:08PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > The `struct dir_iterator` is a helper that allows us to iterate through
> > directory entries. This iterator returns entries in the exact same order
> > as readdir(3P) does -- or in other words, it guarantees no specific
> > order at all.
> >
> > This is about to become problematic as we are introducing a new reflog
> > subcommand to list reflogs. As the "files" backend uses the directory
> > iterator to enumerate reflogs, returning reflog names and exposing them
> > to the user would inherit the indeterministic ordering. Naturally, it
> > would make for a terrible user interface to show a list with no
> > discernible order. While this could be handled at a higher level by the
> > new subcommand itself by collecting and ordering the reflogs, this would
> > be inefficient and introduce latency when there are many reflogs.
>=20
> I do not quite understand this argument.  Why is sorting at higher
> level less (or more, for that matter) efficient than doing so at
> lower level?  We'd need to sort somewhere no matter what, and I of
> course have no problem in listing in a deterministic order.

By sorting at a lower level we only need to sort the respective
directory entries and can then return them without having to recurse
into all subdirectories yet. Sorting at a higher level would require us
to first collect _all_ reflogs and then sort them.

Will rephrase a bit.

> > Instead, introduce a new option into the directory iterator that asks
> > for its entries to be yielded in lexicographical order. If set, the
> > iterator will read all directory entries greedily end sort them before
> > we start to iterate over them.
>=20
> "end" -> "and".  And of course without such sorting option, this
> codepath is allowed to yield entries in any order that is the
> easiest to produce?  That makes sense.
>=20
> > While this will of course also incur overhead as we cannot yield the
> > directory entries immediately, it should at least be more efficient than
> > having to sort the complete list of reflogs as we only need to sort one
> > directory at a time.
>=20
> True.  The initial latency before we see the first byte of the
> output often matters more in perceived performance the throughput.
> As we need to sort to give a reasonable output, that cannot be
> avoided.
>=20
> > This functionality will be used in a follow-up commit.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  dir-iterator.c | 87 ++++++++++++++++++++++++++++++++++++++++----------
> >  dir-iterator.h |  3 ++
> >  2 files changed, 73 insertions(+), 17 deletions(-)
> >
> > diff --git a/dir-iterator.c b/dir-iterator.c
> > index f58a97e089..396c28178f 100644
> > --- a/dir-iterator.c
> > +++ b/dir-iterator.c
> > @@ -2,9 +2,12 @@
> >  #include "dir.h"
> >  #include "iterator.h"
> >  #include "dir-iterator.h"
> > +#include "string-list.h"
> > =20
> >  struct dir_iterator_level {
> >  	DIR *dir;
> > +	struct string_list entries;
> > +	size_t entries_idx;
>=20
> Does it deserve a comment that "dir =3D=3D NULL" is used as a signal
> that we have read the level and sorted its contents into the
> "entries" list (and also we have already called closedir(), of
> course)?

Yeah, probably.

> > @@ -72,6 +75,40 @@ static int push_level(struct dir_iterator_int *iter)
> >  		return -1;
> >  	}
> > =20
> > +	string_list_init_dup(&level->entries);
> > +	level->entries_idx =3D 0;
> > +
> > +	/*
> > +	 * When the iterator is sorted we read and sort all directory entries
> > +	 * directly.
> > +	 */
> > +	if (iter->flags & DIR_ITERATOR_SORTED) {
> > +		while (1) {
> > +			struct dirent *de;
> > +
> > +			errno =3D 0;
> > +			de =3D readdir(level->dir);
> > +			if (!de) {
> > +				if (errno && errno !=3D ENOENT) {
> > +					warning_errno("error reading directory '%s'",
> > +						      iter->base.path.buf);
> > +					return -1;
> > +				}
> > +
> > +				break;
> > +			}
> > +
> > +			if (is_dot_or_dotdot(de->d_name))
> > +				continue;
>=20
> The condition to skip an entry currently is simple enough that "."
> and ".." are the only ones that are skipped, but it must be kept in
> sync with the condition in dir_iterator_advance().
>=20
> If it becomes more complex than it is now (e.g., we may start to
> skip any name that begins with a dot, like ".git" or ".dummy"), it
> probably is a good idea *not* to add the same filtering logic here
> and in dir_iterator_advance().  Instead, keep the filtering here to
> an absolute minumum, and filter the name, whether it came from
> readdir() or from the .entries string list, in a single copy of
> filtering logic in dir_iterator_advance() function.
>=20
> We could drop the dot-or-dotdot filter here, too, if we want to
> ensure that unified filtering will be correctly done over there.

Fair point. As you mention further down below, there are two ways to
approach it:

  - Just filter at the later stage and accept that we'll allocate memory
    for entries that are about to be discarded.

  - Create a function `should_include_entry()` that gets called at both
    code sites.

I don't think the allocation overhead should matter much, but neither
does it hurt to create a common `should_include_entry()` function. And
as both are trivial to implement I rather lean towards the more
efficient variant, even though the efficiency gain should be negligible.

> > +			string_list_append(&level->entries, de->d_name);
> > +		}
> > +		string_list_sort(&level->entries);
> > +
> > +		closedir(level->dir);
> > +		level->dir =3D NULL;
> > +	}
> > +
> >  	return 0;
> >  }
> > =20
> > @@ -88,6 +125,7 @@ static int pop_level(struct dir_iterator_int *iter)
> >  		warning_errno("error closing directory '%s'",
> >  			      iter->base.path.buf);
> >  	level->dir =3D NULL;
> > +	string_list_clear(&level->entries, 0);
> > =20
> >  	return --iter->levels_nr;
> >  }
>=20
> It is somewhat interesting that the original code already has
> conditional call to closedir() and prepares .dir to be NULL,
> so that we do not have to make it conditional here.
>=20
> > @@ -136,30 +174,43 @@ int dir_iterator_advance(struct dir_iterator *dir=
_iterator)
> > =20
> >  	/* Loop until we find an entry that we can give back to the caller. */
> >  	while (1) {
> > -		struct dirent *de;
> >  		struct dir_iterator_level *level =3D
> >  			&iter->levels[iter->levels_nr - 1];
> > +		struct dirent *de;
> > +		const char *name;
>=20
> Not a huge deal but this is an unnecessary reordering, right?

Right.

> >  		strbuf_setlen(&iter->base.path, level->prefix_len);
> > +
> > +		if (level->dir) {
> > +			errno =3D 0;
> > +			de =3D readdir(level->dir);
> > +			if (!de) {
> > +				if (errno) {
> > +					warning_errno("error reading directory '%s'",
> > +						      iter->base.path.buf);
> > +					if (iter->flags & DIR_ITERATOR_PEDANTIC)
> > +						goto error_out;
> > +				} else if (pop_level(iter) =3D=3D 0) {
> > +					return dir_iterator_abort(dir_iterator);
> > +				}
> > +				continue;
> >  			}
> > =20
> > +			if (is_dot_or_dotdot(de->d_name))
> > +				continue;
>=20
> This is the target of the "if we will end up filtering even more in
> the future, it would probably be a good idea not to duplicate the
> logic to decide what gets filtered in this function and in
> push_level()" comment.  If we wanted to go that route, we can get
> rid of the filtering from push_level(), and move this filter code
> outside this if/else before calling prepare_next_entry_data().
>=20
> The fact that .entries.nr represents the number of entries that are
> shown is unusable (because there is an unsorted codepath that does
> not even populate .entries), so I am not worried about correctness
> gotchas caused by including names in .entries to be filtered out.
> But an obvious downside is that the size of the list to be sorted
> will become larger.
>=20
> Or we could introduce a shared helper function that takes a name and
> decides if it is to be included, and replace the is_dot_or_dotdot()
> call here and in the push_level() with calls to that helper.
>=20
> In any case, that is primarily a maintainability issue.  The code
> posted as-is is correct.

Yeah, let's use the proposed helper function. In fact, I think we can
share even more code than merely the filtering part: the errno handling
is a bit special, and the warning is the same across both code sites,
too.

Patrick

> > +			name =3D de->d_name;
> > +		} else {
> > +			if (level->entries_idx >=3D level->entries.nr) {
> > +				if (pop_level(iter) =3D=3D 0)
> > +					return dir_iterator_abort(dir_iterator);
> > +				continue;
> > +			}
> > +
> > +			name =3D level->entries.items[level->entries_idx++].string;
> > +		}
> > +
> > +		if (prepare_next_entry_data(iter, name)) {
> >  			if (errno !=3D ENOENT && iter->flags & DIR_ITERATOR_PEDANTIC)
> >  				goto error_out;
> >  			continue;
> > @@ -188,6 +239,8 @@ int dir_iterator_abort(struct dir_iterator *dir_ite=
rator)
> >  			warning_errno("error closing directory '%s'",
> >  				      iter->base.path.buf);
> >  		}
> > +
> > +		string_list_clear(&level->entries, 0);
> >  	}
> > =20
> >  	free(iter->levels);
> > diff --git a/dir-iterator.h b/dir-iterator.h
> > index 479e1ec784..6d438809b6 100644
> > --- a/dir-iterator.h
> > +++ b/dir-iterator.h
> > @@ -54,8 +54,11 @@
> >   *   and ITER_ERROR is returned immediately. In both cases, a meaningf=
ul
> >   *   warning is emitted. Note: ENOENT errors are always ignored so that
> >   *   the API users may remove files during iteration.
> > + *
> > + * - DIR_ITERATOR_SORTED: sort directory entries alphabetically.
> >   */
> >  #define DIR_ITERATOR_PEDANTIC (1 << 0)
> > +#define DIR_ITERATOR_SORTED   (1 << 1)
> > =20
> >  struct dir_iterator {
> >  	/* The current path: */

--PWWsuq9nJQcLJV/U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXUY/wACgkQVbJhu7ck
PpQJNxAArA0MfBpAATmtMihl/p8PUCJpiqZ5T/ItOzkS6L4XwSIyCaX4HEljH9q7
33HyrfNVMUL5oaEICCfdSniCPA9uf2JRvYhYNtHGenxxpJjcqU2Ftbnjv0KE6HJX
Ce7F8GZYYvUAsarsP/JEVT0Lg/lb+nZdjt3oJ+TDgshu403bxVyjZnpT+3HJvTif
WDYWQMzKBz5AfI3Pa+Urn6UKrydxAYLmDfbgu/tgQ39rBZ6Jycqq0GyK33zKLBcV
/8iBY2SnBoei43v4bnekHdnDZLvEtWmIi9J9MKdcxf4ihVIY6rlqZdzh2Mz6LZ6W
BpspTnyQKMZ2IzcofO7EULEN3Xjf7paukCFl9b+roL521xX5diFwZpz+Vz/551jW
ZpMVER/UgA13jdMTwwdVjFWri/d+4glsZyQGb2XKgO3S5B5Eyie12a5WLDGpdprN
Vv68hck0DQjMlu8HCoEXTP/TQ6YuhfVp8SwNRAxwfeaRQ3Cb/EBZIaufXyLgyOjb
DbSMrkUtCoiosDaXcFQIM01uYr5g8vnk5nr/x7IRbpKMlT6CxOJWUg5H/omLU5lM
scrCL4/d0JnZek6z9KGMzJHShNeM+TO+TWbslUDTMwgsFEIuJTBjZ8mJ5PPDzM0R
PUpmOah5LO2WP2Ye+4O7YtMUenerLmSaQ1aTEXySg1KJPCDW7VE=
=yVuK
-----END PGP SIGNATURE-----

--PWWsuq9nJQcLJV/U--
