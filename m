Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44030C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 10:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237912AbiAGKyF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 05:54:05 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:56893 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237932AbiAGKyE (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 Jan 2022 05:54:04 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 97A1B5C019F;
        Fri,  7 Jan 2022 05:54:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 07 Jan 2022 05:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:mime-version:content-type; s=fm3;
         bh=GsyDT5uPYQfyOehZeDdFKl/3GhIo2ifrm9VbGN4swA0=; b=qXXeOVwuSCrB
        SLcLIHORwr+fLWWxyPaESIxfNn7GMKsqfnZQuVdiGkakHY253TURf7edzIJWFCxg
        hf02F9F4cn8EdbAB7yXiFtKZ/cmD8u9xY41M7OoQyn7qKVfp+ytvSTplmdDitOHv
        V3UNCAtLhcEooBtYncSz0N0YNFHDzR/bi3jznleFcqgBU56kBN1t/C/+IoT2fh+Z
        pL9U6A4NEzgP1MO4YvvQx3BDbH2a+evXmHIe2vtdTahHC7Y5m7zv9LIYxeAapfPg
        3jP1rTVVR58o2IspfeolxM++SzG6rOPy4/qZ6KV+NIvWRwXfCMzUTNqFAG4fU/Ol
        BxBZS17qmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=GsyDT5uPYQfyOehZeDdFKl/3GhIo2
        ifrm9VbGN4swA0=; b=Z64PIpOD2o5CUFtUrU/Fgz2mWw4cjScnDoa34vh6old+L
        CcEWhJchZIaWp4kuFqrTM99hwyUZRF4BBFTOf+Be8XqSE25Pt8HIzwTZUCKGq+o2
        3y87agDFxr2DlTtQzy1+OpHf+LCtY7L9LnqG5IjYW4RkXyoMxNbXlNceMxX6d7oC
        MmrtUSaPxAk6hm664smyf98NdK2ezYDNd7fcNF3/Q+YZaDUqDwNZjyxUUQDOiA8U
        1G0+sFQbNPCcnGEglrg1VkcwF6IZKUsvLLtzUFcmUY01tzFtzRfqvexEtqm57z9q
        J/6cnFoeIqhoMGrgeUevFqjGc7UuYwsljUIMhW3AQ==
X-ME-Sender: <xms:yxvYYRfqiaqx8273V3BewSVy-s5SKbljhrYSjjGci2CYVlcjCJCW9g>
    <xme:yxvYYfNxM4xRFdCnBMAbKRssndVwRQXL1Ncy8J2AD-mO7SN6VKIVxI-0lZXM-b7XJ
    63Lgsq0ggiDSvR5ZA>
X-ME-Received: <xmr:yxvYYagurKfmm0PLiZVIhWAOJUzVifept8yxhvWfc5J6YGcdgDFnQB74icwcwoS4hoHbs-3_SiMRhgzcuE6P7C_cgb7okTxZgvVxHNZSiOO4QxVYlioeR_J4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudeguddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:yxvYYa85_g0TsSyYs5-jqS2ghUrpzmx-0MrBbwebNJw1N_S66Std7Q>
    <xmx:yxvYYduNqYjalNCrYhtJdpx_-tGv2qguOj1ZrSZjWvQh1usyW7uLJg>
    <xmx:yxvYYZHEbraa7qPm_EjO3les_2t_Lrf2NpPqQ2HVH9fP4M2YL2HyEA>
    <xmx:yxvYYb14wcy6q853QzImDepoT39rFfl2PfoBZ07xXY76crnb1jvGSQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jan 2022 05:54:02 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id de782017 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 7 Jan 2022 10:53:59 +0000 (UTC)
Date:   Fri, 7 Jan 2022 11:53:35 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     iwiedler@gitlab.com
Subject: [PATCH 0/1] Async-signal safety in signal handlers
Message-ID: <cover.1641552500.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xyJLImmc6lc7dnBB"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xyJLImmc6lc7dnBB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

we have recently observed a Git process which has been hanging around
for more than a month on one of our servers in production. A backtrace
showed that the git-fetch(1) process was deadlocked in its signal
handler while trying to free memory. Functions like malloc, free and
most I/O functions aren't reentrant though, which means they must not be
executed in async signal handlers as specified in signal-safety(7).

The fix for git-fetch(1) is rather simple: we can just unlink(2) the
lockfiles, which is indeed allowed, but skip free'ing memory. But in
fact, this is a wider issue we have: we mostly didn't pay attention to
those restrictions, and thus we freely call non-async-signal-safe
functions. It's less clear what to do about this in most of the cases
though:

- git-clone(1) tries to clean up the ".git" directory and its worktree
  on being killed, but needs to allocate memory to compute corresponding
  paths. We can try to preallocate the buffer, but it's not clear
  whether there is a proper upper boundary.

- git-gc(1) will try to commit "gc.log" and write to stderr, both of
  which aren't allowed. I think we'll have to just bail and leave it
  behind in a partially-written state.

- git-repack(1) tries to remove "pack/.tmp-*" files, calling opendir(3P),
  readdir(3P), closedir(3P) and allocates memory. We probably have to
  keep track of all temporary files we create in a global list, which we
  can then access in our signal handler.

- git-worktree(1) is doing the same as git-clone(1), trying to prune the
  new worktree if it's killed. Again, we'd probably have to preallocate
  a buffer to compute paths.

- HTTP pushes do all sorts of HTTP requests in their signal handler to
  unlock the remote server. I don't really see what to do about this
  except drop the code -- setting a global "please clean up and exit
  now" flags is probably not going to fly well.

The tempfiles and tmp-objdir code already handles signals correctly.

Patrick

Patrick Steinhardt (1):
  fetch: fix deadlock when cleaning up lockfiles in async signals

 builtin/clone.c |  2 +-
 builtin/fetch.c | 17 +++++++++++------
 transport.c     | 11 ++++++++---
 transport.h     | 14 +++++++++++++-
 4 files changed, 33 insertions(+), 11 deletions(-)

--=20
2.34.1


--xyJLImmc6lc7dnBB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHYG64ACgkQVbJhu7ck
PpQdRg/7BFFSOXQr8gYV+CW/qRo6BOcMKRx+v2zGXR/BbJUg7NyU9GSS5UX5LVrP
GOo6kA0froaZoC35BLD74eWtOdXWQnTqbLFkpskB/z0APVE0mNgMd2DeGfyegfpx
HKEHWEotD+60cIe0ISC0ulGP6+Y/6zABPF8kFaB6xMnNgJ7GPtQX8mpZ4nyGtc1I
wTHdD/yCHkfkxyYPNccd5y3jNNHXYkwo6G3fzqYftIGAW82pNH2tt/sUCaBlJbiC
q8IqQo0lPn/+aQ4JE8AYFR3RPrZK0nCcQ0VNI+YQNmtvQepFwdxaTDSfnfHmXkb6
nKEvmNuJr1wfP/AGNncKNq/ft5djhnTuXojSqys1kq97qT5zaPCtnlu6TtcoMk9L
BEnGRArkZIcLv1jggR2km/4ljLUGpW1bAP55daol6FTjwAcFlPN10tRYps/vFsKl
H5nk4WBDeIHOnDPg7E7Od2A4WYyF78bDLI57wLX+YDL6gfiue5+CaN3rj7Cz5Li2
ClpzXqQi3RcON3ORQ9S508FYp5skXOHczRrj6V+0irFk4xwvDU/qt1k6GLcK2Lx6
TUH/jnDVdCheCW6OS8dINx/3ceGoPQ+XHLkgPyMxewL5psqIiueY2lgENszKoe86
fh5OkT32Zg0NIdtKOlcjmhuyQEa9B2f/80IwPK1zUvsPpUbOGY4=
=qR2G
-----END PGP SIGNATURE-----

--xyJLImmc6lc7dnBB--
