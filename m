Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43727C433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 05:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0004B2076C
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 05:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UctPYmuV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qQ0iSOxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgFHFfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 01:35:12 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:48381 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726929AbgFHFfM (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 8 Jun 2020 01:35:12 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B67242E1;
        Mon,  8 Jun 2020 01:35:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 08 Jun 2020 01:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=SZcaa8XvJUxS/igGSFEtuN6nbpk
        2iDloJnO8pfjt+UI=; b=UctPYmuVCCzoyG+NsoFwOhtBkMpFc0iVObYAXKZ9X76
        JubRq8KQvNkFaZb9LTf9e0SdPLzogFKqFASizI+6NFGYJ/PJpR6/CGstCmZKClk0
        1FD/zXbTLH1hf11709jx7Vbbb/7ZpsD4NzwXEky5LnwiCYVXBaOVP/mqd7ys+VJG
        qNrNj3S5aZe5tS6BQjwwi8zwhxwFw6XKj28oVn5diqNC1/QO58RwKFffDRcO2Qcm
        dnwZiJOjij41pO41Bpjr1uaf9InK3NVJfCtfA8Urhh6LO6LK43pSpd1qwK1I40O9
        qxBe5jVtyEaticMHbv21AKQRVEJuZrbnpSAImf31oMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=SZcaa8
        XvJUxS/igGSFEtuN6nbpk2iDloJnO8pfjt+UI=; b=qQ0iSOxUjN2+Aa5//G/+Yp
        ArPxgEboQj02N2e+jcaXPNc+zFXl2EXytI6U7KO3iUIajgukbQtUF9KgxJQvGGJF
        0eoA7//vzIFBxY9BNAVAT4M6T7kznkL4TsxbeKcZF2/9KXlRMJ3kcSIiNalL4pHr
        uAouzpu9dQu1dZV9Q2Ben0u48azUVCbanyG2ExBVOs6mih9gUDwzaClA6JPbFok+
        2QVLfmuAm5y45SrK3Zw2ECbXjIMR2t84UDFIy1yOorHE2YOipE/VrFHS3lKi1taT
        LEZVaYhq7FMOA1/7SHLyaoTDJmnROhHQdbiGBtfHPVkRiw5vMsiCcgN1qaSMrZMQ
        ==
X-ME-Sender: <xms:Dc7dXsSn01i1cGwbLea2gvdGcq7CbuUygwG4lTx_hYrqqY-oqMQnkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehtddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtudenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnheptdffjeeiudduleehvdfgteeifeelheejte
    dvteduiedttedvtdffffefhfdvgffgnecukfhppeejkedrheehrdduvddtrdduieegnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:Dc7dXpyifuPbs-_CcDQ__jK8vKnftgcD2Opz42a-CfVPf2c6qAQpiQ>
    <xmx:Dc7dXp28M8rpArXlOPqr2LyIO3SM5XXuwrfi1UjUVPkd8MLV6BlEsg>
    <xmx:Dc7dXgDJG9-si9salTv5kWwaA2YKWdHACeNU_Opi1_g6fTa2FGmacg>
    <xmx:Ds7dXvcMos4Y59DUm2hPz13oKQMhwslKFGTwxfOTVZUovNDANKNT_g>
Received: from vm-mail.pks.im (x4e3778a4.dyn.telefonica.de [78.55.120.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5B0A53280063;
        Mon,  8 Jun 2020 01:35:09 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 2c26b3c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 8 Jun 2020 05:35:02 +0000 (UTC)
Date:   Mon, 8 Jun 2020 07:36:05 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] refs: implement reference transaction hooks
Message-ID: <20200608053605.GA851@tanuki>
References: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
 <xmqq4krttl4k.fsf@gitster.c.googlers.com>
 <20200603112604.GA25644@tanuki.pks.im>
 <20200607201233.GB8232@szeder.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <20200607201233.GB8232@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 07, 2020 at 10:12:33PM +0200, SZEDER G=E1bor wrote:
> On Wed, Jun 03, 2020 at 01:26:04PM +0200, Patrick Steinhardt wrote:
> > On Tue, Jun 02, 2020 at 10:47:55AM -0700, Junio C Hamano wrote:
> > > Patrick Steinhardt <ps@pks.im> writes:
> > >=20
> > > > The above scenario is the motivation for a set of three new hooks t=
hat
> > > > reach directly into Git's reference transaction. Each of the follow=
ing
> > > > new hooks (currently) doesn't accept any parameters and receives th=
e set
> > > > of queued reference updates via stdin:
> > >=20
> > > Do we have something (e.g. performance measurement) to convince
> > > ourselves that this won't incur unacceptable levels of overhead in
> > > null cases where there is no hook installed in the repository?
> >=20
> > Not yet, but I'll try to come up with a benchmark in the next iteration.
> > I guess the best way to test is to directly exercise git-update-refs, as
> > it's nearly a direct wrapper around reference transactions.
> >=20
> > > > +	proc.in =3D -1;
> > > > +	proc.stdout_to_stderr =3D 1;
> > > > +	proc.trace2_hook_name =3D hook_name;
> > > > +
> > > > +	code =3D start_command(&proc);
> > > > +	if (code)
> > > > +		return code;
> > > > +
> > > > +	sigchain_push(SIGPIPE, SIG_IGN);
> > > > +
> > > > +	for (i =3D 0; i < transaction->nr; i++) {
> > > > +		struct ref_update *update =3D transaction->updates[i];
> > > > +
> > > > +		strbuf_reset(&buf);
> > > > +		strbuf_addf(&buf, "%s %s %s\n",
> > > > +			    oid_to_hex(&update->old_oid),
> > > > +			    oid_to_hex(&update->new_oid),
> > > > +			    update->refname);
> > > > +
> > > > +		if (write_in_full(proc.in, buf.buf, buf.len) < 0)
> > > > +			break;
> > >=20
> > > We leave the loop early when we detect a write failure here...
> > >=20
> > > > +	}
> > > > +
> > > > +	close(proc.in);
> > > > +	sigchain_pop(SIGPIPE);
> > > > +
> > > > +	strbuf_release(&buf);
> > > > +	return finish_command(&proc);
> > >=20
> > > ... but the caller does not get notified.  Intended?
> >=20
> > This is semi-intended. In case the hook doesn't fully consume stdin and
> > exits early, writing to its stdin would fail as we ignore SIGPIPE. We
> > don't want to force the hook to care about consuming all of stdin,
> > though.
>=20
> Why?  How could the prepared hook properly initialize the voting
> mechanism for the transaction without reading all the refs to be
> updated?

Because the hook might not want to implement a voting mechanism after
all but something entirely different which we're currently not
foreseeing as a valid usecase. We don't enforce this anywhere else
either, like e.g. for the pre-receive hook. If that one exits early
without consuming its stdin then that's totally fine.

> > We could improve error handling here by ignoring EPIPE, but making every
> > other write error fatal. If there's any other abnormal error condition
> > then we certainly don't want the hook to act on incomplete data and
> > pretend everything's fine.
>=20
> As I read v2 of this patch, a prepared hook can exit(0) early without
> reading all the refs to be updated, cause EPIPE in the git process
> invoking the hook, and that process would interpret that as success.
> I haven't though it through how such a voting mechanism would work,
> but I have a gut feeling that this can't be good.

As said, I lean towards allowing more flexibility for the hook
implementation to also cater for other usecases. But I agree that in a
voting implementation, not reading all of stdin is a bad thing and may
point to a buggy hook implementation. Aborting the transaction if the
hook didn't read all of stdin would be a nice safeguard in that case.

With the current implementation of using a single hook for "prepared",
"committed" and "aborted", it'd also force the hook implementation to do
something in cases it doesn't care about. E.g.

    #!/bin/sh
    case "$1" in
        prepared)
            VOTE=3D$(sha1sum <&0)
            cast $VOTE
            ;;
        aborted|committed)
            cat <&0 >/dev/null
            ;;
    esac

That being said, I'm not opposed to enforce this and not treat EPIPE
differently.

Patrick

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl7dzkQACgkQVbJhu7ck
PpR8nw//WzNQZvuX+Ok+0WU7ZjXJFFGS3h11WL6IPaft+WJVrSTHoJBNEcyAIP4w
7KdZaPnaN2wgFEpejdQGtW+OZoRzHBQuLEZ/kjNChOrKu4HvnNZrWZiJv5AjeA6Q
w8bwpteUVOIKwyUCLMN5T6eQ9niyAE/cgFt5yvEKzdmjzcR5fODMvdwAmp66Mkhc
Zr4j/BRsslsEa3yLy2V0GkmLc4hekhGmRiHriZ06w5zCsI0rUyv8P05iE8Y1s6XN
/5lHQ64g2h/q9LzZ6AKC7sxv8o8LdTL0jHN90ij9kVtZu0Fjr4+1aBK4WBYleQQa
whEwwsXzuJ9YTPBNz9RyHfseO2w6WDrWdILY90P/AWcRZBNJ8BHxigzOYGwUF1ho
6Aww4FJslGl/7ifdCPN5WHhspU+3Gm6LULKY6UFY41d9EukrDL+pOi7uzJnR9hsF
ir1dtKYhJ6TpRK8SRr/TUGC+Zcy8DpzNKCk/2hdUQ+b3Bcm4tJN4jWClVz5D0LYC
HceQ6abotaeJytM0ovRF0HfqbfQaXzMOHjC98Oguic4nOmDc+hSI9QxD6tp2RlaL
zeM80XCLG0qgGI5x+M/470Dz3YJHqPtZ+IbYa1Grn8s0WICf3uUaZCNy21fck1Zq
AZ59gt05p2AH+wJQQW/of9o9lzE8lNWKFEabA2k8zwo4QBuO7KE=
=282X
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
