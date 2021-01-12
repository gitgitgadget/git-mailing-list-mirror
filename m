Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88749C433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A95923109
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387436AbhALMXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 07:23:37 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:48839 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733275AbhALMXf (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Jan 2021 07:23:35 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id E1C4C1B13;
        Tue, 12 Jan 2021 07:22:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 12 Jan 2021 07:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=Tg8T4zOKHsQHpffszL/qOmLcRnd
        D2rYgREUUJmodj9s=; b=tKL+ZVZQLce0gL/V11l/vrq5TbGDCvHVXEhIANmdagT
        JBURaOPPMXXw8BQHu/3gxfd/vfzSDsGdm7PYjiZgojfXcvY/pCuQoPUlKlIX9Im7
        A2BX2CA6SZNJgZKuMi5S4n2S0CHApP/hM40jt6UVp1Jr4/ZyZLLE47fWuc/xACu6
        q1a9GFYrs3y4IV/4Ved7iXF/tkiJam4agByaPOKO9Hhr/C1khQ7ZuhIEDpx3DyBF
        bA30aR1uBMMvA8oamUL1JTim5/K13Gfo2+xRTOXQgUjBZhGVMQAUergGk9S7ezUq
        /B6uPevj4G6l96XWQQRfrS3cUTHUhqhwjYYyH3XO9gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Tg8T4z
        OKHsQHpffszL/qOmLcRndD2rYgREUUJmodj9s=; b=iGHRVWRh18yZCL17Hwop+r
        mQGQObAyFMyRE2vSAba2Pch7VmN3ofzpUrc0urM+SDxoTcii2ixY3JQxYdOSc14Z
        sicf3B2NjBLF0G7JIF2pQDGVKzgaNOTrrdO4K/0POEdAvdlTJWrmtF5gv1STjMJM
        tBW8e5cPxH/G5dGxewHiyZbWZblsDhkLIeDY8cdll6OyfOjxT+jrKvpKL1swldTW
        x3WNU4yBgQ3O98HKfukUfBhR6+076qx2NfXGpWOrIHhhO4ki+IUo+BlkJ20wfLzA
        m/JgQ0IruVNSf5dmpJ7vfYan14TRjia857HOfUCAh7y/AFdv5WoprLAR1BQbpF+g
        ==
X-ME-Sender: <xms:k5T9X6-cO7Cv98NqWglCtsfz-sZbu6DXwqUgbZkmZQwHqkGVZc0TZw>
    <xme:k5T9X6sMcRP0cZQAINLEj0Gx9KHLjNaZvnOgJD9l3uXUV2RcC-OGsTut8eA_u9DW4
    2gE85CqfmWzvYNc7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddtgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epiedvjeefheeiteekgeejveefffdtvedvudfgvdeuheeffeejfeetudeutdefgfegnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepjeejrddufedrhedvrdelfeenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhk
    shdrihhm
X-ME-Proxy: <xmx:lJT9XwBfiMf-R0hs0qrwAZkfYz6MSYVbjx2UdGZkcbzaMiOuox6YSw>
    <xmx:lJT9XyffTVPVGzTy6bsiOo71bcbVBhsDXf4WeqawTScWPV-3xs4WTQ>
    <xmx:lJT9X_PR3DSmXlXZmpKGwwPOX-zb6tqTsEPxULh_vdWFhEN0Hn1RQg>
    <xmx:lJT9X10Ina8j6hAp4X3OWK0Nc00S1OAKxnI_23JDS7tis65UapRLMQ>
Received: from vm-mail.pks.im (dynamic-077-013-052-093.77.13.pool.telefonica.de [77.13.52.93])
        by mail.messagingengine.com (Postfix) with ESMTPA id 53E7724005A;
        Tue, 12 Jan 2021 07:22:43 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 6734560e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 12 Jan 2021 12:22:41 +0000 (UTC)
Date:   Tue, 12 Jan 2021 13:22:40 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] fetch: implement support for atomic reference
 updates
Message-ID: <X/2UkKS0AhT6jLXj@ncase>
References: <cover.1610027375.git.ps@pks.im>
 <cover.1610107599.git.ps@pks.im>
 <53705281b60285837905137f45fc8607012d2f19.1610107599.git.ps@pks.im>
 <xmqq7dongeji.fsf@gitster.c.googlers.com>
 <X/wrgYYcZfYZj+4/@ncase>
 <xmqq5z438ddv.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="clkeI2uOA+fTKPUP"
Content-Disposition: inline
In-Reply-To: <xmqq5z438ddv.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--clkeI2uOA+fTKPUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 11, 2021 at 11:47:08AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >> It would be much more preferrable to see this series go like so:
> >>=20
> >>     [1/4] create append_fetch_head() that writes out to
> >>           fetch_head->fp
> >>=20
> >>     [1.5/4] convert append_fetch_head() to ALWAYS accumulate in
> >>             fetch_head->buf, and ALWAYS flushes what is accumulated
> >>             at the end.
> >
> > This is a change I'm hesitant to make. The thing is that FETCH_HEAD is
> > quite weird as the current design allows different `git fetch --append`
> > processes to write to FETCH_HEAD at the same time.
>=20
> Hmph, do you mean=20
>=20
> 	git fetch --append remote-a & git fetch --append remote-b
>=20
> or something else [*1*]?

That's what I mean.

> With the current write-out codepath, there is no guarantee that ...
>=20
> > > +		fprintf(fetch_head->fp, "%s\t%s\t%s",
> > > +			old_oid, merge_status_marker, note);
> > > +		for (i =3D 0; i < url_len; ++i)
> > > +			if ('\n' =3D=3D url[i])
> > > +				fputs("\\n", fetch_head->fp);
> > > +			else
> > > +				fputc(url[i], fetch_head->fp);
> > > +		fputc('\n', fetch_head->fp);
>=20
> ... these stdio operations for a single record would result in a
> single atomic write() that would not compete with writes by other
> processes.  So I wouldn't call "the current design allows ... at the
> same time."  It has been broken for years and nobody complained.

Fair enough. I somehow blindly assumed that `git fetch --all`, which
does invoke `git fetch --append`, did perform the fetch in parallel. If
that's not the case: all the better.

> > If we change to
> > always accumulate first and flush once we're done, then we essentially
> > have a change in behaviour as FETCH_HEADs aren't written in an
> > interleaving fashion anymore, but only at the end.
>=20
> I view it a good thing, actually, for another reason [*2*], but that
> would take a follow-up fix that is much more involved, so let's not
> go there (yet).  At least buffering a single line's worth of output
> in a buffer and writing it out in a single write() would get us much
> closer to solving the "mixed up output" from multiple processes
> problem the current code seems to already have.

The buffering of a single line is exactly what we're doing now in the
non-atomic case. Previously there had been multiple writes, now we only
call `strbuf_write()` once on the buffer for each reference.

> > Also, if there is any
> > unexpected error in between updating references which causes us to die,
> > then we wouldn't have written the already updated references to
> > FETCH_HEAD now.
>=20
> That one may be a valid concern.
>=20
> Thanks.

Just to be explicit: are you fine with changes in this patch as-is? They
don't solve concurrent writes to FETCH_HEAD, but they should make it
easier to solve that if we ever need to.

Patrick

>=20
> [Footnote]
>=20
> *1* "git fetch --all/--multiple" was strictly serial operation to
>     avoid such a mixed-up output problem, but perhaps we weren't
>     careful enough when we introduced parallel fetch and broke it?
>=20
> *2* When fetching from a single remote, the code makes sure that a
>     record that is not marked as 'not-for-merge' is listed first by
>     reordering the records, but it does not work well when fetching
>     from multiple remotes.  Queuing all in the buffer before showing
>     them would give us an opportunity to sort, but as I said, it
>     takes coordination among the processes---instead of each process
>     writing to FETCH_HEAD on their own, somebody has to collect the
>     records from them, reorder as needed and write them all out.
>=20
>     cf. https://lore.kernel.org/git/X8oL190Vl03B0cQ%2F@coredump.intra.pef=
f.net/
>=20
>    =20

--clkeI2uOA+fTKPUP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/9lI8ACgkQVbJhu7ck
PpQ3Mg/8CMucFarcrXxcV1A79jgVY09QDZQvvSbRdRBqiLUZWGwuHlXU5pD0Fixb
Z3ODypPm/gpW1Rjfoqa3oydiVb+2ad8dcIokapCBhdAsCnd2kwhNjgNzIlhH/s15
zCM/kJTId8wHgxrGpRN/G7SxcANCZPuGvrSRr/VSfKDJxWKdhge9S6vVLhacPsfH
0y3AKTD/7JYD7OXGutZ5V1aG+ySjihaKLLfLFYcZ1G17NZlPUZcHXpz6dHdcgglh
Rc8hVYPmzGRxY7LIqL3ZTEr9oiKIV+UVnq2ErrHe3elB/beosuzgsPvmaE+YdRp7
GLKCmfGLsiu1roJPTek1VgFasHpWhcgqenIHb5Bpsp3t4U61V1CUJ5PQz4Ut/4bm
8G9v0Uu+CEM1yin9gkS6QTZgNYL/3oU/SC9NV6yZirm07Z4sOcmIcKIqivXd7V7L
AGVkp+5whHTcfFWp8YFH5USlhydsr/i3+lfm7akwD7SsjqZ6ieio6bkMmefutKmg
0avbWajl7AspEbmkLuXBmr21dgQUrwjGQj27+ND5/w8diSJ16Gspk8IEvpCq6JP7
3Vf+3KeKf4RrmJ4kJQhIz6tEDNN3rXdw5pF6gY8iIJ7QWi7bvl6GQEQ3HIH4N965
bZFIYrbWFm3/Fem7xj2J37NeCikeIJk4gQmfshTJHZEDQtg+aEU=
=HQ7+
-----END PGP SIGNATURE-----

--clkeI2uOA+fTKPUP--
