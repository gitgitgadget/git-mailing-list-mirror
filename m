Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA64A30C168
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 22:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791241060; cv=none; b=NoGDcPvZG6MK49q+d+x80WRgiDEd4p7c7NCDBbSHMErXGt9FNBbeDX4Xu44naknGINbLITQe39yGyYIWsm5WJ+oxo5QH5qGio1idzzagSWFNt3Au6xtDEelqSmmm6W5HwKcKyoz47ys2k2DRKHEMs/JzkYHKqkpyc6SOpnZ0TLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791241060; c=relaxed/simple;
	bh=8bdlWKvwGM/aAp198Txq7goRA/B87toGXtyaeiBRUj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hx2F6PPQv/bLporDRN3sD2CVfR91TCINKVDvS6GS5D9X6Cz8gKtdbI8ULP6jasNKpCXW87qx7QFrRcsQm2Gmha9WPih3jlr4tNlmC8y/dC83NDXaLmNB3igpcyTYMgREwjeyLhLwT6osS5BWDjO0ZSYbMFQq3zuWwavKiWCAp9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=bR8pQuvU; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="bR8pQuvU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1791241050;
	bh=8bdlWKvwGM/aAp198Txq7goRA/B87toGXtyaeiBRUj4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=bR8pQuvUEXiAcVYm3Zp4gQZVBnJEXtkGklkjnAH6l/k5yYFEQ7rrQiAzcunJmIkt8
	 HCZ5WkLBgZtAqmbju9KN2vxDGaxWN7JbDhHbQWGSzyprQcYOSs1XFyfAsFq788vJ4a
	 CPaNQz0oQNIZpYaN0lzS5gUAA29c8+RaBSwHgSTCaHH5yChDzI837Rq934sIlsmQ28
	 KOzMzK/OL25gF+aLA9s9ZcDQjWdszzfttCIADS4RY3wP7Ch2BN4Wa9Wx2gjZviELjf
	 BxLYpu10QnWyMse5QJgOL19HrYHbw3075d1nEMV0ztSlY8wLcUfpEdHqkAlQXhcap3
	 ygij057TvGDf8kcNwS5axk9M/+CTd6BiipDT8baX7hprFGjT4BOOfVZj7JNUEjA/2J
	 wGl6ocK+FNor1dfxwJ+Vhv04N2TOW4ibXTIESXhqUvaUee8d5mPGg4EwJ7BlWQnfXb
	 jIlpEoRFHl/E1VvpuhRRHgNZ9BUSFpDGryPz+M4qNeRnt0O/88Z
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:3b5f:558:e3d6:2c05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4F24B20077;
	Mon,  5 Oct 2026 22:57:30 +0000 (UTC)
Date: Mon, 5 Oct 2026 22:57:29 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Scott Chacon <schacon@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Scott Chacon <scott@gitbutler.net>,
	git@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] sign a SHA-256 digest of the tree in commits and
 tags
Message-ID: <asQrWAKQXV9zn1Vq@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Scott Chacon <schacon@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Scott Chacon <scott@gitbutler.net>, git@vger.kernel.org
References: <20261002081846.25144-1-scott@gitbutler.net>
 <asAAn8NZwB29WhGR@fruit.crustytoothpaste.net>
 <CAP2yMaKF4CRvtfTQDVe51SqEm_DnoVOmED5kcUSg7UvLkBp4Xg@mail.gmail.com>
 <asOa6dgpj0qV5QAU@pks.im>
 <CAP2yMaJ+ss9M_27+kBN0q_aFUd-5GNqzQHM2orayKH+enOAG1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E1WG4U1rFDlvoasr"
Content-Disposition: inline
In-Reply-To: <CAP2yMaJ+ss9M_27+kBN0q_aFUd-5GNqzQHM2orayKH+enOAG1Q@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--E1WG4U1rFDlvoasr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-10-05 at 14:16:48, Scott Chacon wrote:
> Thanks Steiny,
>=20
> A quick response,

Hey,

> On Mon, Oct 5, 2026 at 2:41=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
> > The biggest problem I have is that the ecosystem has been entirely
> > unwilling to do anything about the SHA-256 move before we announced that
> > this is going to become mandatory. Only then were developers even able
> > to convince anybody (especially those paying the wages) to get the time
> > to implement support for it.
>=20
> Bit of a simple question, but is it possible that this is because
> nobody really finds it a concerning problem?

I think that's an oversimplification.  I think people don't realize that
Git is using SHA-1 and once SHA-256 is the default they will be very
much in favour of using it.  As I've said elsewhere in the thread, the
need to move away from SHA-1 is going to become gradually urgent for a
large segment of major institutions.

I can say that I've also had inquiries from large government agencies
and corporations and they very much know about SHA-256 and want it.
It's also very much desired by many in the open source community based
on feedback that I've received there.

To respond to what Patrick said, I think in general there is a huge
reluctance to invest in Git as an open source project and much open
source investment is driven by internal corporate needs.  As such,
there's been a huge investment in scaling Git and a lot less investment
in anything else, even if sometimes that ends up with less desirable
outcomes.  Customers get developers paged if their repositories don't
scale, but they don't page about SHA-256.  That doesn't mean it's not
important or valuable.

> > So there is some kind of ossification happening in the space. But things
> > are finally moving now that the due-date is drawing closer. I would be
> > extremely hesitant to change course again and drop this breaking change
> > now that there finally is some movement. Because the only consequence of
> > that would be that the ecosystem will stop working on it again. And even
> > more so, I would even expect that this will make the next time we want
> > to do a breaking change exponentially harder as the lesson learned is
> > that nobody needs to do anything.
> >
> > Maybe I'm too pessimistic about this, but I don't think so. We've been
> > working on this whole transition for almost a decade by now, and only
> > now where we're forcing the ecosystem to adapt are large players like
> > GitHub even moving.
>=20
> I want to remind everyone here quickly what "working on this whole
> transition for a decade" has looked like, because this seems to be
> phrased like everyone wanted this but GitHub was hesitant and pulled
> into this important work only by the heroic 3.0 breaking change
> decision.
>=20
> GitHub has been essentially the _only one_ pushing this endeavour from
> the beginning of this problem set.

I will merely say in this regard that I don't speak in my corporate
capacity from this email address, so I don't think I'd like to respond
to this statement.  Patrick and I and the other contributors have
discussed SHA-256 and Git 3.0 at the Contributor's Summits in 2024,
2025, and 2026 and so I think there's a good understanding of where
different people and companies have been contributing to that and other
efforts.

What I will say is that my experience on SHA-256 is that it challenges a
lot of assumptions that people have built into their code over the years
and therefore any sort of migration to support SHA-256 involves a lot of
work, including substantial code changes and database migrations.  That
means that sometimes people have been doing substantial work behind the
scenes and it's just not visible until it's done.  You can see how this
works by looking at open source projects like libgit2 and gitoxide,
where extensive changes have landed over time.  My experience is that
reftable is another project where this is the case as well.

> If we assume Brian, Haggerty, Peff, Taylor and Derrick have been
> acting on behalf of GitHub, then you Steiny, are essentially the only
> major contributor to this project in the last decade that is not
> GitHub/MS (Eric maybe?). Very honestly, nobody else seems to care. GH
> has single handedly created this issue and then somehow simultaneously
> been the blocking factor to it's rollout because it also,
> simultaneously, does not really find it to be an actually important
> issue. Google maybe helped design the transition plan in 2017, but
> hasn't seemed to care too much since then. Nobody else has really
> weighed in, at least with patches.

I do want to clarify this, since I think there's a lot of confusion.
When I send contributions or patches from my personal email address,
they're personal contributions.  Only if the patches contain my work
address (which is extremely rarely) are they in my corporate capacity or
done on corporate time.

The SHA-256 work that I've been doing has almost exclusively been in my
personal capacity[0].  There is some of the interoperability work that I
was able to do on work time and those patches reflect the appropriate
email address and sign-off, but before that I have done almost no
SHA-256 work on company time.  This work has been done mostly on nights
and weekends, as with almost all of my other contributions, including on
the security list.  I contribute because I like the project and want it
succeed, not because I'm paid to do so.

I also want to state that I've received a great amount of assistance and
contributions, including reviews, patches, thoughtful ideas, and
miscellaneous assistance, from a wide variety of contributors to the
list and I could not have done it without them.  Someone who has only
provided reviews or design ideas has still aided the SHA-256 project and
Git as a whole immensely.  Patrick is just one of many people who have
aided in such a way.

As mentioned earlier, I am of course not going to comment on anything
related to my employer on any of this.  If you want their opinion, you
should ask them.

[0] The interested reader may wish to run the following command:
    git log --format=3D'%ae' | grep -E '^(sandals|bk2204)@' | sort | uniq -c
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--E1WG4U1rFDlvoasr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrEK1gJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ+7Iy+yqsBt6+MyQ6QssHVM/jqNgQf3bhbHEQCzYQ9SU
FiEECCzmip28ZfuD0cORfAxJYoiHooEAALn7AQCXrpwOrq0+u9SJ7zCjb/FrFZs4
Yl4b+rRrzgYMTGC3egEA/vlYGpcwr+5BNvChsatxLOqRCZ933M2mFeW+gDhgnwQ=
=afBe
-----END PGP SIGNATURE-----

--E1WG4U1rFDlvoasr--
