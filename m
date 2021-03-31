Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47469C433E2
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 11:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 082B9619A7
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 11:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhCaLZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 07:25:45 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59461 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235165AbhCaLZN (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 Mar 2021 07:25:13 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2310F5C0187;
        Wed, 31 Mar 2021 07:24:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 31 Mar 2021 07:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=b5P52NfmDL7JovCiU3N6RAuS1gn
        dOZJLdnY1SyM5E5k=; b=t0PFR0/FDSk2ZZvRFae1vupLoIBQxkFHbFNXvEO2hWR
        uAUGlm2Dt8rAzZXYW8jyRAXd2hTsY86hYtLqNX51T2UQOQcdbmRDhviYc8D9XBJO
        Fn3wIRJsdNobE2Z3Ox2UN/bpwPLN7166lOxVG1UNG6eBjivYfD9Q7T/s1MsP5aB/
        v0CbfwzQyvMzqTMaFNgGpmbcJJmZ0FM3UejKD5JVL4aHONQ08lBtcjGsmqf8oANA
        3aJYCwAsLkXpyv0uJ8hTzbDjRrhAHUmkAvyewZi2lH3ze5fYAMMErgfHlEva7oPX
        S2D0HyqUhf6Xf0L98XCdOcSHku0P8FuA58EQEOnpQ1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=b5P52N
        fmDL7JovCiU3N6RAuS1gndOZJLdnY1SyM5E5k=; b=Cpst03xkPX1JQGJpeV2riv
        HNGeXPh4rKscaDp1LApPGmzv3cdYIPOmpAfr8zfTW8nTJtzc+0jfFQbj+z4je8aK
        oqZRZqZ8gTtguM1W98CSiTRXCYct47/oGINH37ebkECmDFyZZ770FFrFGIP4Sn+H
        6PgqOzuxIgANhex+KEzFsQyito7IDFW2nNeW6UDx7pdOvQ0qhVaMytg1dJ5m0YQH
        ygsqW06vYDOqxcl5cK1veWvD//Lki+zNotEzdiF3krOqCuV4gKtrAwDI96wruoy1
        U/iIDPzGtz2wGkscfTYdSKFF6oXoQ1SjOzwZW4I5FHmMW/Hnd4ll5zryE+XWw7xg
        ==
X-ME-Sender: <xms:7VtkYLxoboN4MORKrj5KQUle_q4B8i0Z13GHVG1Q_4XgBrWjkeUG_Q>
    <xme:7VtkYDScYQV58OwFqgHh-l1ABUQeESCS0EA9RRZ9BpD8848GXycs5puerGtR7OZvu
    U4xuxtSHkfB11YfYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeivddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepkeelrddugedrfeejrdduheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:7VtkYFWSNgw8cNRKEFw57QEb2SPA9cHZ3XfIc0HcjExz_MU7VhZOzQ>
    <xmx:7VtkYFgY9BsiCTj26-ZpswWJ6tSFQKuETJLgsgq1HQq7vvS3JrF9lQ>
    <xmx:7VtkYNAxMTI7OIGhfvJ3GsFQcNc4atg2ry6MxP5zs8Pc-nOQmgHQng>
    <xmx:71tkYAOpIiZofCBBWL7pU776_hgF9BuZ0yuxkBFRkKJnKYKmq-R1cw>
Received: from vm-mail.pks.im (dynamic-089-014-037-153.89.14.pool.telefonica.de [89.14.37.153])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1E94124005C;
        Wed, 31 Mar 2021 07:24:29 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 5667aa86 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 31 Mar 2021 11:24:26 +0000 (UTC)
Date:   Wed, 31 Mar 2021 13:24:24 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: Pass or not to pass config environment down...
Message-ID: <YGRb6CCH06rga6QO@ncase>
References: <xmqqk0px3dfu.fsf@gitster.g>
 <CA+P7+xokjz-2nC5+F9HG0tBqS948uZcuq-1eY9uGuNyzbFGbZQ@mail.gmail.com>
 <xmqqmtut1qyj.fsf@gitster.g>
 <CA+P7+xo9rUYWzCT0YZFU5Nz1ojP1qRt8VfGtK08-LmYV9KK0hw@mail.gmail.com>
 <xmqqim5h1otg.fsf@gitster.g>
 <YFuHd1MMlJAvtdzb@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VVD0W6sAf+cmueTM"
Content-Disposition: inline
In-Reply-To: <YFuHd1MMlJAvtdzb@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VVD0W6sAf+cmueTM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 24, 2021 at 02:39:51PM -0400, Jeff King wrote:
> On Tue, Mar 23, 2021 at 03:35:07PM -0700, Junio C Hamano wrote:
>=20
> > > So, I think this direction is good. I imagine a full patch would
> > > include also dropping the specialized helper function that is no
> > > longer needed, and possibly adding new tests for the behavior of
> > > GIT_CONFIG_COUNT?
> >=20
> > Yeah, coding that is the easiest part.  Thinking through
> > ramifications of making (or not making) such a change is much
> > harder.
> >=20
> > I said "assuming" number of times, because I am not so sure if the
> > subprocesses spawned from other codepaths do or do not want to see
> > the one-shot custom configuration settings.  If that assumption
> > turns out to be wrong and the processes spawned using the helper in
> > various helper functions in submodule.c are the oddball cases that
> > want to see the custom configuration, then such a change would break
> > existing users.
>=20
> I think it really depends on the command being spawned. But keep in mind
> that the local_repo_env list is not limited just to callers inside of
> Git. We expose it to the user via rev-parse, so scripts can do:
>=20
>   unset $(git rev-parse --local-env-vars)
>   cd /some/other/repo
>=20
> I'm hesitant to change the output there, since we don't know exactly how
> it's used in the wild[1]. Changing what our internal callers do is less
> risky, though I'd generally avoid doing so unless there is a known
> benefit. And I'm sure what the benefit is; I think this came up mostly
> because you were looking at harmonizing the behavior of the two config
> systems (and I think that _is_ worth doing, but I'd probably choose the
> historical behavior for the new system).

Agreed. I wasn't aware of this helper function at all, and aligning both
config systems so they have the same behaviour there seems like the
right thing to do to me.

> I also think it really depends on the specific config the user is
> expecting to get passed. Remember we used to have a whitelist for "this
> config is OK to pass to submodules", but it was such a mess that we did
> away with it in 89044baa8b (submodule: stop sanitizing config options,
> 2016-05-04).

That also came to my mind while this thread. I can see why it would be
useful if e.g. `gc.auto=3D0` gets passed down to all subcommands spawned
by git. But if the user for example injects remote configuration via
config envvars, then it'd certainly be unexpected if submodules would
try to fetch from the same in-memory remote as the parent on a recursive
fetch.

> > I _think_ the one in connect.c, which runs either the ssh transport
> > (for which the processes that run on the other side in the other
> > repository won't be affected by our environment anyway) or the file
> > transport that runs another process and talks with it over a pipe is
> > probably OK if the configuration on the "client" side leaks through
> > to the "server" side, e.g.
> >=20
> >     $ git -c advice.ignoredHook=3Dfalse clone file:///the/repo.git/ here
> >=20
> > would probably want the other end (i.e. the one that runs upload-pack
> > in /the/repo.git/ directory) to see the one-shot configuration, too.
>=20
> That example is one of the reasons I prefer _not_ to pass config here.
> It only works over local-process invocations! Not over ssh://, nor
> git://, nor https://. Even though it will do what you want in this case,
> the overall behavior is more confusing.
>=20
> The more-consistent (or less inconsistent, perhaps) way is:
>=20
>   git clone -u 'git -c advice.ignoredHook=3Dfalse upload-pack' \
>     file:///the/repo.git
>=20
> which also works with ssh. It of course _doesn't_ work with other
> protocols, but I think the technique at least makes it more clear why
> that is the case (you do not get to specify arbitrary shell commands to
> https servers).
>=20
> > I do not think it makes much difference to the use of local_repo_env
> > in object-file.c::for_each_alternate_ref() either way; it could be
> > used (via core.alternateRefsCommand) an arbitrary command in each
> > alternate repository, but by default it runs for-each-ref in them,
> > and I do not think of any configuration variables that would be
> > useful on "the other side".
> >=20
> > And I suspect that trailers.c::apply_command() excludes these
> > environment variables just out of habit without much deep thinking.
> > It is not going in a different repository to run the command, and
> > santitizing the environment that pertains to this repository should
> > not have any meaningful effect [*].
> >=20
> > So, I would not be surprised if it were a totally safe change, but I
> > am not yet sure.
>=20
> My suspicion is that for most cases, nobody cares that much either way
> (which is why we have not seen people ask "hey, why is my config not
> passed down" in any context _except_ submodules).

Probably not, but it may be a good idea to document config boundaries
such that nobody is caught by surprise there.

Patrick

--VVD0W6sAf+cmueTM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBkW+cACgkQVbJhu7ck
PpQqmQ//Xi4EIruq8xKW7fzA23w3QSd7tEGI0CWWpwR7dh8X3UlHlhyikDEmoHLt
He8Miwhnrz2zuHwyAU0h5T8kldpj0KBnO+AVDle8Ygj1z5BBFVeThZFMZ7DdYmjg
1rdmX6vmz65hBhfdrn8vB6KPNtr4w9Qy3gFW/VUac0wSGaP050YPTktwM2scMfc2
539l2Sm9J0oeUTDNvbsHt3gyswqxu2UodU1eon+3W8f/m9WGDT/jfLIvYsr4Dj3Q
vpB6IynGLw+JXzRX615M/kUo0Pa32NqACjzPQecDj65JAGtcdcaDrM25Xflubisv
SnNk3NRkXtW8Bvp3/8134yXcyiMUnUBHoInFwUQFtNfw9VS5nKC80tG371XYkh7E
qoTS9y5HbG9qPZEUIrzxHI2prIRzahkL1eNnejDRtbXiWWFsbQyYQJhR6vC1wjET
4HAlsq4fxQ+RWmUbwWrrmBul1c5//8+VPgHehGczFahxyYfXU0hg75EeY9YQnwY0
ZJSS08aNlDNgVZSS9MofhCn9c11OwRZw2lh4RBjULZHAya4ZwSivvjsFg8pCkMjE
mpxOAnZK4BSE26O+6KMtkl6B/YWpuWZMHdBzOZt85PRP4wfYUVHIfkZcvtVrDfGh
Ve8vrl19jkPdyhPynwVCm3XhNMbnsmV3M108N8pOQly4fSUy9s8=
=Vb9h
-----END PGP SIGNATURE-----

--VVD0W6sAf+cmueTM--
