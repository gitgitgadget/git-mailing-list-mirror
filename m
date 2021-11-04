Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D34AC433FE
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 14:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86ACB611C3
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 14:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhKDOyL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 10:54:11 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57391 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230420AbhKDOyK (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 4 Nov 2021 10:54:10 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1E0325C0117;
        Thu,  4 Nov 2021 10:51:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 04 Nov 2021 10:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=ERzi13n1UFxpif8f/oIgro3kLuG
        76YfIp8mpYqSbsRQ=; b=uPSpcdWqvh/4lR0SLwTVtXYWApLq6CAISpc11xeir2j
        set35uSbyGM99Ml6gdqJqurczAds/5XLALQ1jzqttjIEka6vSN4AxYEgPxGIsLYC
        jToTWwHEMXnADTZc+BOJiS1da14Fg/3yMSur4O9CyQyMKHO2AikEsdJtksqkbUlT
        KU4ID/d6gb2ZrX6V8wdsY6d4G4VaKW7Px76g6p+D95vayXxc+dwFz659v/BjYLLV
        yZQvmDMhIAFhaZcZ84mNtmjNdgMj/w4zIcftby7JHKQzPJpx7ndaqxbCdSET2adH
        Jfiseore5UJIMomKUYSIhvOin9PSNO/kb6lazvW6C+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ERzi13
        n1UFxpif8f/oIgro3kLuG76YfIp8mpYqSbsRQ=; b=fvCblhm8HnScjjaCyFwLAu
        Rv3QsEIYm+ZR+i0rIZmqg+NbEROsDr496anFsX7MqYGYTlkQck3mIlIlPpeI/E36
        +QMyrYenaJ+YaYTVEGnB04CveBCJgrRpz6q0yzYwWwUj06jgwCSf+4RA7MA0J/j0
        SaDh6jPX+JVoLPnWuFWy/sa+VyrGJs6BEd4kbThP2B1mcyNYPPSpjcCo9pobJT5R
        fWNfHe5sg7JwQpuRrwt+SDJuNKcAni66b2/Ox7vKIYJwlOuviLE3ioeX5/szXPMY
        JrLx7fXswZbRtpiRuG0pBhVmwfA+OFTcrEp/fpmbTy6CS4oYwlkMqiI9oEjCQ7fw
        ==
X-ME-Sender: <xms:cvODYTTiffkZKXI9kBPjnGjnUnj8ngZ7oObINlyItwtJjrTxdGy2Uw>
    <xme:cvODYUwkujuhvM34Yr6R4uHXC8tugJ12RymLC2HwU2WheDZf2mWsnHQK4ME3Uj1k-
    OKZCqG132g5b5CIPw>
X-ME-Received: <xmr:cvODYY0UTgA_LjwjWBIB6NCE8ZWDcHrCLpLJcVgt_OkUzd3Wfnu3_5mxPbmHDyLCA_2mQc_GaIKVD83br-OTT55zPWdz57hmFg17bZ1_fPjessOBlJpAcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrtdeggdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epkeehteegueekfeehhedvueehkeeigeekffdthfetleevkeetvdejgfdtieethfevnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghdpshhtrggtkhhovhgvrhhflhhofidrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhm
X-ME-Proxy: <xmx:cvODYTDalMQYazeH2LmQuXfQqTrWT3SXyZR1JxCGzvocyuOLn6bSpA>
    <xmx:cvODYcjK629ykVGgYpjJKTwpjzJ9StD9tty7ZneDHBZvna6YGgm0GQ>
    <xmx:cvODYXqj22DIISLCaWNdL3oAOGigE6g5axKInZV6lbhGJF6W-LIyEQ>
    <xmx:c_ODYftoCiT1vTphEc6QrXuSqqPPp4BU0Ey18EWm_Y6cKC2IlvNyaQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Nov 2021 10:51:29 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 7a1458ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 4 Nov 2021 16:39:31 +0000 (UTC)
Date:   Thu, 4 Nov 2021 15:51:08 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH] refs: sync loose refs to disk before committing them
Message-ID: <YYPzXEJ5L5vjjtJp@ncase>
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
 <211104.86ilx8hwvi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="km/9zzX5Dl/u21UD"
Content-Disposition: inline
In-Reply-To: <211104.86ilx8hwvi.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--km/9zzX5Dl/u21UD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 04, 2021 at 02:14:54PM +0100, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
>=20
> On Thu, Nov 04 2021, Patrick Steinhardt wrote:
>=20
> > When writing loose refs, we first create a lockfile, write the new ref
> > into that lockfile, close it and then rename the lockfile into place
> > such that the actual update is atomic for that single ref. While this
> > works as intended under normal circumstences, at GitLab we infrequently
> > encounter corrupt loose refs in repositories after a machine encountered
> > a hard reset. The corruption is always of the same type: the ref has
> > been committed into place, but it is completely empty.
> >
> > The root cause of this is likely that we don't sync contents of the
> > lockfile to disk before renaming it into place. As a result, it's not
> > guaranteed that the contents are properly persisted and one may observe
> > weird in-between states on hard resets. Quoting ext4 documentation [1]:
> >
> >     Many broken applications don't use fsync() when replacing existing
> >     files via patterns such as fd =3D
> >     open("foo.new")/write(fd,..)/close(fd)/ rename("foo.new", "foo"), or
> >     worse yet, fd =3D open("foo", O_TRUNC)/write(fd,..)/close(fd). If
> >     auto_da_alloc is enabled, ext4 will detect the replace-via-rename
> >     and replace-via-truncate patterns and force that any delayed
> >     allocation blocks are allocated such that at the next journal
> >     commit, in the default data=3Dordered mode, the data blocks of the =
new
> >     file are forced to disk before the rename() operation is committed.
> >     This provides roughly the same level of guarantees as ext3, and
> >     avoids the "zero-length" problem that can happen when a system
> >     crashes before the delayed allocation blocks are forced to disk.
> >
> > This explicitly points out that one must call fsync(3P) before doing the
> > rename(3P) call, or otherwise data may not be correctly persisted to
> > disk.
> >
> > Fix this by always flushing refs to disk before committing them into
> > place to avoid this class of corruption.
> >
> > [1]: https://www.kernel.org/doc/Documentation/filesystems/ext4.txt
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  refs/files-backend.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index 151b0056fe..06a3f0bdea 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -1749,6 +1749,7 @@ static int write_ref_to_lockfile(struct ref_lock =
*lock,
> >  	fd =3D get_lock_file_fd(&lock->lk);
> >  	if (write_in_full(fd, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
> >  	    write_in_full(fd, &term, 1) < 0 ||
> > +	    fsync(fd) < 0 ||
> >  	    close_ref_gently(lock) < 0) {
> >  		strbuf_addf(err,
> >  			    "couldn't write '%s'", get_lock_file_path(&lock->lk));
>=20
> Yeah, that really does seem like it's the cause of such zeroing out
> issues.
>=20
> This has a semantic conflict with some other changes in flight, see:
>=20
>     git log -p origin/master..origin/seen -- write-or-die.c
>=20
> I.e. here you do want to not die, so fsync_or_die() doesn't make sense
> per-se, but in those changes that function has grown to mean
> fsync_with_configured_strategy_or_die().
>=20
> Also we need the loop around fsync, see cccdfd22436 (fsync(): be
> prepared to see EINTR, 2021-06-04).
>=20
> I think it would probably be best to create a git_fsync_fd() function
> which is non-fatal and has that config/while loop, and have
> fsync_or_die() be a "..or die()" wrapper around that, then you could
> call that git_fsync_fd() here.

Thanks for pointing it out, I'll base v2 on next in that case.

> On the change more generally there's some performance numbers quoted at,
> so re the recent discussions about fsync() performance I wonder how this
> changes things.

Yeah, good question. I punted on doing benchmarks for this given that I
wasn't completely sure whether there's any preexisting ones which would
fit best here.

No matter the results, I'd still take the stance that we should by
default try to do the right thing and try hard to not end up with
corrupt data, and if filesystem docs explicitly say we must fsync(3P)
then that's what we should be doing. That being said, I wouldn't mind
introducing something like `core.fsyncObjectFiles` for refs, too, so
that folks who want an escape hatch have one.

> I've also noted in those threads recently that our overall use of fsync
> is quite, bad, and especially when it comes to assuming that we don't
> need to fsync dir entries, which we still don't do here.

Yeah. I also thought about not putting the fsync(3P) logic into ref
logic, but instead into our lockfiles. In theory, we should always be
doing this before committing lockfiles into place, so it would fit in
there quite naturally.

> The ext4 docs seem to suggest that this will be the right thing to do in
> either case, but I wonder if this won't increase the odds of corruption
> on some other fs's.
>=20
> I.e. before we'd write() && rename() without the fsync(), so on systems
> that deferred fsync() until some global sync point we might have been
> able to rely on those happening atomically (although clearly not on
> others, e.g. ext4).
>=20
> But now we'll fsync() the data explicitly, then do a rename(), but we
> don't fsync the dir entry, so per POSIX an external application can't
> rely on seeing that rename yet. Will that bite us still, but just in
> another way on some other systems?
>
> 1. https://stackoverflow.com/questions/7433057/is-rename-without-fsync-sa=
fe

Good point. I'd happy to extend this patch to also fsync(3P) the dir
entry. But it does sound like even more of a reason to move the logic
into the lockfiles such that we don't have to duplicate it wherever we
really don't want to end up with corrupted data.

Patrick

--km/9zzX5Dl/u21UD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGD81sACgkQVbJhu7ck
PpQE1A/+L0+KaxrkJoXW253xTk1eplB/RbslfIczwhNAwJ+eAjMtxXA7F0pUL0GR
Q8wGX78TWKaOZkj9G0TyYu05jr6OsP08vfHMApdu6Uzw5R3KbryM8WNO1w8WsTLT
7fn2CWA3eCzm4yVf3/Uf/0ul4YEOLXYZ3VX8irwO5m3cb0QhApAZ0m4uwKpl8Ec4
MHeULvaUam6w1J7nByJ3Aa3wUgV8ePVGkcj4p0Tq+42ANm8762ljX6PusvyA5AF/
DcYmgxDZruyQwsb+yw1QXrsekd9OIjS0eY53R7y9S6JZCDWkr4ilryhsNXl7qfpN
VUvdckbIUCXdtYxPxXjjg3DoMmv4g0DQT17n2K86DdlxvGPIi9IjvAPp1hcLhtn8
17M05cYjKfAZ6w7es994hQrGvdaeYalSreOttMUpoXQLDH0HqJjHCoNVk0/ZcicP
6tg6l4eAZXhBgECl+NW2Si/6OH+2h2jyAKRm6WN1Bnh7UhsbCGqR21ktHKemna+r
PZZs44nudLC7UOtJ+cUY+M/4H4sDOYNSIhp2hBsxCuY0TgN09RY4+dL8Ykj0Z2hx
jjTnfOVSbQZjc60nHSDIQWuESq4pqe+sG25rV1SY8iqgwiTKqnChqAjr9a8w1ktb
y0p+5h+AeWMBcC3HKyct0mpL/kIUf/CjedgY9NYcTPM3iOCdUPY=
=KsHd
-----END PGP SIGNATURE-----

--km/9zzX5Dl/u21UD--
