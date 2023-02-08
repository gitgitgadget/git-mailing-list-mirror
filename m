Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90AEC05027
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 23:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjBHXwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 18:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjBHXwf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 18:52:35 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA6F14EB5
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 15:52:34 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 0ABA55A1E1;
        Wed,  8 Feb 2023 23:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1675900353;
        bh=/ejNQHkOv6wLs4f9YWFHMCgM0mCen6oblZFo3Xz2Zps=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=VfZfkXeR52RbHlvaQiqo2KCR0AwRjhgW5kCBaOLbWQ2O6RUoh2mjisWJdUO/j2t5z
         cpAoHeB04NiqmZydZux+7RF2qRET2qJ/HbLxKaWaD9wMMmlS3ZOPHOL6vdEEc8NYlO
         RnEXrfKvUUB0/YcgbOdo14OZDxTihyjJ+nhRslKRjU8ZnhF0sbSS5m3BwMfEjHqfuK
         OKRB4lLmK1JR94YOgfyp+xxapSBRvry2cD68L+OPe3e+ThwpEQL8KdaRinHzGFOKWw
         FQF0oZ2QE8bd7PlOhCNEN08zs4NSJjjq+c0NYzcWBg+3hlokDbooRm3ybvEicTO1uk
         u4CC3bNZrIS+Rx0L5+iFus3Y5zFFwYgmr4RULS5Qxu33r62E7Vc1TIbmN653yEtdru
         SQZbiReCt71El/bStlrehqgNL387HnkEDunsGRJDQnj+VkknAAkBi9Gyyfiy2CXqCo
         7zWk0frNkvi/zvv+jvThIX84RCClvTov2tQB0zz0cRUL6L5GUMb
Date:   Wed, 8 Feb 2023 23:52:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eli Schwartz <eschwartz93@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [RFC PATCH 1/1] Document a fixed tar format for interoperability
Message-ID: <Y+Q1v/PM6n93xvqu@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Eli Schwartz <eschwartz93@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>
References: <20230205221728.4179674-1-sandals@crustytoothpaste.net>
 <20230205221728.4179674-2-sandals@crustytoothpaste.net>
 <230206.86lela4ebq.gmgdl@evledraar.gmail.com>
 <Y+LYQYMS7ruvRbNW@tapette.crustytoothpaste.net>
 <230208.86wn4sz8a3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BejDgDWXhhwk+B+6"
Content-Disposition: inline
In-Reply-To: <230208.86wn4sz8a3.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--BejDgDWXhhwk+B+6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-02-08 at 11:07:44, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Tue, Feb 07 2023, brian m. carlson wrote:
>=20
> > [[PGP Signed Part:Undecided]]
> > On 2023-02-06 at 22:18:47, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> Maybe there are other changes in the proposed spec that put it at odds
> >> with such a goal, it's unclear to me if this is the only difference.
> >
> > As mentioned in the description, that doesn't address trees, which have
> > never been consistent traditionally.
>=20
> You mention "[...]it produces identical results for identical trees,
> regardless of hash algorithm". I'm not familiar with how we encode trees
> differently based on the hash algorithm. Do we stick the tree OID in
> there somewhere, or is it something else?

If you pass a commit or tag on the command line, you get the timestamp
of the commit or tag.  If you pass a tree, you get the current
timestamp.  Thus, whether the output is reproducible depends on the type
of object you specify.

> IOW do these trees vary within the same hash algorithm, or is it another
> special-case where we now produce a different tarball with SHA-1 and
> SHA-256 with commits, but also with trees?

When we write an archive, we embed a comment with the commit object ID
(see next response).  That's using the hash algorithm in the repository.
If we write an archive for a tree, no object ID is embedded.

> B.t.w. are there some options to tar(1) to make it dump these headers
> you're describing? I coludn't find anything when looking, it looks like
> libtar might support it, but I was hoping for something more compatible
> with my lazyness :)

I don't think so.  However, you can see them with `git archive --format=3Dt=
ar HEAD | env -u LESSOPEN less -R`.

The body of the global header looks like this (my indentation):

  52 comment=3D7ff60001dae72ac39783ca536a4b673862b28587

If you want to see what GNU tar produces, you can run `tar -cf - --posix --=
exclude .git . | env -u LESSOPEN less -R`:

  30 mtime=3D1675633909.844009705
  30 atime=3D1675895555.716075364
  30 ctime=3D1675633909.844009705

> I'm concerned that you're expanding the scope of a "stable" tar format
> to necessarily include one-off fixing various things we've regretted
> over the years.

Well, yes, because if we're specifying a stable format, we should make it
something we want to support long term.  Right now, we don't guarantee
anything; if we find something unsatisfactory, we just fix it.

> Then a v1/v2 is just this pseudocode, isn't it?
>=20
>  	switch (version) {
> 	case 1:
> 		break; /* warts and all */
> 	case 2:
> 		include_oid =3D 0;
> 		satanic_permissions =3D 0;
> 		no_timestamps =3D 1;
> 		break;
> 	}

As I mentioned in the doc, there are multiple ways to encode various
things like lengths and the order of headers.  It's not immediately
obvious from the code how our length encoding works, and that's the kind
of code that could easily have a small refactor or bug fix break things
really badly.

Additionally, we, like most other pax implementations, just encode
headers in whatever order we thought was most expedient when
implementing, and sometimes they're emitted and sometimes they're not.
That's a really great recipe for behaviour that is extremely hard to
test and extremely hard to reproduce.  For example, we'd have to test
the interaction with long paths and symlinks, long paths and large
files, and several other sets of variants to make sure that a minor
refactor doesn't change output.  The current logic of the code is very
subtle.

> Now that you've done the work to specify it, it turns out that a
> proposed format you'd like going forward is almost identical to what we
> currently emit, to the point that supporting that as a v1 seems rather
> trivial (but again, I may still be missing something).

It's relatively similar.  The format I'm proposing is much stricter and
more regular than what we do now.

I'm thinking that the changes will be limited to writing three or four
functions.  It's not terribly invasive, but there will be some departure
=66rom the existing code.

> We have a huge long-tail of users in the wild, forcing those users to go
> through a one-time breakage of their existing archives if we could avoid
> that by making v1 the current format seems entirely unnecessary.

Because right now, the current code is not amenable to producing or
testing reproducible output.  Any significant refactor of the existing
code will result in an output change unless the author is extremely
careful, and I'm not comfortable guaranteeing the current format with
that caveat.  The reason the data hasn't changed is because such a
refactor hasn't happened yet.

I'm specifically thinking about the length calculation in
`strbuf_append_ext_header`, which is extremely magical, and the path
splitting in `get_path_prefix`.  Those are both extremely subtle and
logical places to perform a refactor or adjustment that might change
output in a very minor way for a tiny subset of files.

> When producing a release archive, or packing up a given commit that's
> therefore going to be stable, even between SHA-1 and SHA-256, although
> those two would differ if the OID is put in the header, but that's
> another matter.
>=20
> If I understand you correctly here you seem to be in pursuit of another
> goal entirely, which is that you'd like the same output for different
> commits if they're TREESAME.
>=20
> Or, if you have a bunch of release archives a very nice attribute of
> this is that with a bunch of similar archives on the same FS you could
> e.g. benefit more from block-level deduplication.
>=20
> All of which is cool, but I don't see why it needs to be a hard
> requirement in the design.

I think it's valuable to have the same input data produce the same
output.  That means that I can use Git to produce the archive, or some
other tool implementing the same format, and it just works.  If GNU tar,
libgit2, or libarchive implemented the same format with an option,
people would also be able to produce an identical archive as long as
they excluded the files in `.gitignore` and `.git`.  That approach is
very valuable if you need to slightly modify the contents of the archive
that Git produced in a way not supported by --add-file (and Junio used
to do that himself for Git releases before --add-file).

> But related to that is setting everything to epoch:0, doesn't that mean
> that when you unpack say a release archive that in common filesystem
> browsers all of the files will be dated in the 70s, as opposed to the
> time of release as it is now?

Yes.  That's also the case for current Rust crates and lots of other
reproducible archives.  I've heard exactly zero complaints about that
behaviour since I implemented it in Cargo.  Looking back at the history,
apparently there's some broken behaviour with the actual Epoch and lldb
(because 0 is a sentinel), but the change is just to switch to a
timestamp of 1 instead of 0, which I can do in the next version of my
patch.  No other problems seem to have come up with using a fixed
timestamp.

The only place where I could imagine this being a problem is if you used
Make in a directory after unpacking a new archive over the old one, but
that is a terrible idea in the first place since that leaves now-removed
files from the old version behind which will probably cause your build
to fail at some point.  In any event, because almost everyone uses
`--prefix` with the version number for their archives, it's difficult to
even perform that extraction over top anyway, and so it's unlikely that
anyone actually does such a thing.

Otherwise, there's typically no functional difference.

> Okey, so I might have to take back much of what I said about, so you're
> not opposed to supporting the current format as a "v1" or whatever,
> you'd just like this propsoed "v2" (or "vstable", or whatever) to have
> some "blessed" status.

No, I'm not opposed to supporting both.  There's "default" (v0 if you
like) and "v1".  If you say, "I'd like a tarball", you get what we
produce now (or what it changes to in the future).  If you say, "I want
bit-for-bit compatibility", then you get v1.

> I just don't get why we wouldn't support both, if the delta is as small
> as seems to be the case. If that's right this "v2" is less "extremely
> restricted" to our current "v1", and more "almost identical", just "a
> bit less wart-y".

Right, I think it's very easy to do.

> I just don't see the target audience for that. As the issues that
> prompted these on-list discussions show we have people in the wild who
> deeply care about the current format.
>=20
> They probably care enough about that that we're likely to try to support
> that forever, at least I don't see any currently proposed change to the
> format that seems worth breaking things for those users.

I don't think there's any purpose in guaranteeing the current format,
given what I've said above about testability and the risk of breakage
during a refactor with the current code, and I don't think the project
should do that.  However, downstream users, including various forges, may
wish to do so, and if so I wish them all the best.

> If you're going to switch to some stable format surely that would either
> need to involve massive one-off breakage, or you'd have some "flag day",
> from today all new archives are produced with the new "stable" method.

Nope.  There's simply a new option to produce v1 archives and people
switch over as part of their normal build system maintenance, and
eventually nobody cares about the ancient versions depending on the old
format.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--BejDgDWXhhwk+B+6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY+Q1vwAKCRB8DEliiIei
gfgIAQDo+VnMwtOuS0AVRbR2y3wkGJyYW/XxkO5DqBrXDV0ZlAD+MNS2oexzuwrF
g1tu9v1pNDYzFgdRvyRSm4yB/50KyQ4=
=WuBD
-----END PGP SIGNATURE-----

--BejDgDWXhhwk+B+6--
