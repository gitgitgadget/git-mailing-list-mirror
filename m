Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FB5C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 01:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443084AbiDVBec (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 21:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443080AbiDVBec (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 21:34:32 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED1849C96
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 18:31:40 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 712C65A410;
        Fri, 22 Apr 2022 01:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1650591099;
        bh=mbDODfnhZ8K3+/FUuNBtGRpTYCuvU7ZUBHj/3v2uKgY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=L8fC4SdirGIGPLtjqP/9pfpoI5RNgsDPzPhcPC2RCedJ+zuiyUcpJQ+C5yD4NM/0D
         zahcot7x6aCM4dWWs1+skGbwa0Pitppp0ELoAVl17XZdk38F0PYT2/Kw8vGRb0E/x9
         O7uAxh4VZA31CApKy2mVTEW4Vnz+9QCmc3PPDqoAAsYO1bJ8EkUMrvc+QxoDFsGXie
         RZGjeq915yg0z/HT2FJn/DOwKepKQwWbsTIoMJgTm5Q1h3YIoId1UzMfwD5U2d2Wt+
         DxsDnUJH+hhIJbIBNGhjcXAWiWOmsj30+3jSWZ/DRA2xKtRerTn+N+/Qk6BCV/IMHk
         sxwAFORW4LhsAsOw7ZAFxYHsBW+5VR+Wl6LcDBwenoDm6JwJGAif8Bth1K7FnKVacL
         J8p7ETLgXPPLR5j0WaQ5XBlLUwyUqeIgvYj9EzfUCi16F8rb1J7mizHZXwokmR1bUQ
         1y8g0ezhSw+rWrCFg/LaNTxaVSlYc8+Dq7O1VaUvjt0jW3Ick6w
Date:   Fri, 22 Apr 2022 01:31:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jason Morgan <jasomorg@qti.qualcomm.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git push locks up forever, file protocol
Message-ID: <YmIFeIrTBx6yghwn@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jason Morgan <jasomorg@qti.qualcomm.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <BN0PR02MB79194599872BD3693CD72CF4F2F49@BN0PR02MB7919.namprd02.prod.outlook.com>
 <BN0PR02MB79195847F60CA239AE9F5CE3F2F49@BN0PR02MB7919.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NJYiKO9myxty/qUU"
Content-Disposition: inline
In-Reply-To: <BN0PR02MB79195847F60CA239AE9F5CE3F2F49@BN0PR02MB7919.namprd02.prod.outlook.com>
User-Agent: Mutt/2.2.3 (2022-04-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--NJYiKO9myxty/qUU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-04-21 at 08:30:50, Jason Morgan wrote:
> Hi,
>=20
> We have a remote repo accessed using the 'file:' protocol, mounted over S=
amba using drvfs into a WSL2 instance of Ubuntu 20.04.
>=20
> We find a 'git push' waits forever. git version 2.25.1

I seem to recall that we've fixed some various issues with protocol
handling in the 2.29 timeframe.  Is it possible you could try 2.36.0 to
see if you can reproduce it there?

Also, it would be interesting to see if there's a difference in
behaviour between setting protocol.version to 0 and setting it to 2.
That might tell us something that would help tracking this down.

> Over a local LAN this works fine, but over a VPN this fails, hinting at s=
ome sort of race condition.
>
> Output from strace hints that git is trying (and failing) to read from a =
closed file handle.

I don't think this is the case.  If Git were trying to read from a
closed file handle, the kernel would immediately return -1 with errno
set to EBADF.  Those operations won't block because there's nothing to
read.

> Final output from strace:
>=20
> -----------
> openat(AT_FDCWD, ".git/objects/ad/065dad4384ae8c81c120c562985078d1f7b34b"=
, O_RDONLY|O_CLOEXEC) =3D 3
> fstat(3, {st_mode=3DS_IFREG|0444, st_size=3D152, ...}) =3D 0
> mmap(NULL, 152, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f3e0e4af000
> close(3)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0
> munmap(0x7f3e0e4af000, 152)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0
> openat(AT_FDCWD, ".git/objects/30/2508dfe5201db6c000ebf17b0c69e3afb31218"=
, O_RDONLY|O_CLOEXEC) =3D 3
> fstat(3, {st_mode=3DS_IFREG|0555, st_size=3D214, ...}) =3D 0
> mmap(NULL, 214, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f3e0e4af000
> close(3)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0
> munmap(0x7f3e0e4af000, 214)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0
> openat(AT_FDCWD, ".git/objects/d2/2323ec2ec40a74fbd519509662254c3cfda206"=
, O_RDONLY|O_CLOEXEC) =3D 3
> fstat(3, {st_mode=3DS_IFREG|0444, st_size=3D161, ...}) =3D 0
> mmap(NULL, 161, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f3e0e4af000
> close(3)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0

FD 3 is closed here...

> munmap(0x7f3e0e4af000, 161)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0
> access(".git/hooks/pre-push", X_OK)=C2=A0=C2=A0=C2=A0=C2=A0 =3D -1 ENOENT=
 (No such file or directory)
> write(4, "00953ea50e3c1f49c33f7dbbb5e3a310"..., 149) =3D 149
> write(4, "0000", 4)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 4
> pipe([3, 6])=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0

And then it's recreated here as one part of a pipe, so it isn't closed.

> fcntl(6, F_GETFD)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
=C2=A0=3D 0
> fcntl(6, F_SETFD, FD_CLOEXEC)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D 0
> mmap(NULL, 8392704, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0=
) =3D 0x7f3e0d641000
> mprotect(0x7f3e0d642000, 8388608, PROT_READ|PROT_WRITE) =3D 0
> clone(child_stack=3D0x7f3e0de40fb0, flags=3DCLONE_VM|CLONE_FS|CLONE_FILES=
|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|=
CLONE_CHILD_CLEARTID, parent_tid=3D[12802], tls=3D0x7f3e0de41700, child_tid=
ptr=3D0x7f3e0de419d0) =3D 12802

My guess is that in the child (which isn't shown here) that FD 6 is
hooked up to either standard output or standard error.  You'd need to
follow children to see.

> pipe([7, 8])=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0
> stat("/usr/lib/git-core/git", {st_mode=3DS_IFREG|0755, st_size=3D3093072,=
 ...}) =3D 0
> pipe([9, 10])=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D 0
> rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) =3D 0
> clone(child_stack=3DNULL, flags=3DCLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID=
|SIGCHLD, child_tidptr=3D0x7f3e0e1dae50) =3D 12803
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) =3D 0
> close(10)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0
> read(9, "", 8)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D 0
> close(9)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0
> close(7)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0
> close(4)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0
> fcntl(8, F_GETFL)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D 0x1 (flags O_WRONLY)
> openat(AT_FDCWD, ".git/objects/3e", O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIREC=
TORY) =3D 4
> fstat(4, {st_mode=3DS_IFDIR|0777, st_size=3D4096, ...}) =3D 0
> getdents64(4, /* 22 entries */, 32768)=C2=A0 =3D 1328
> getdents64(4, /* 0 entries */, 32768)=C2=A0=C2=A0 =3D 0
> close(4)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0
> fstat(8, {st_mode=3DS_IFIFO|0600, st_size=3D0, ...}) =3D 0
> write(8, "^3ea50e3c1f49c33f7dbbb5e3a31017f"..., 83) =3D 83
> close(8)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0
> Enumerating objects: 31, done.ts: 1
> Counting objects: 100% (31/31), done.
> Delta compression using up to 8 threads
> Compressing objects: 100% (23/23), done.
> Writing objects: 100% (23/23), 5.60 KiB | 212.00 KiB/s, done.
> Total 23 (delta 14), reused 0 (delta 0)
> [{WIFEXITED(s) && WEXITSTATUS(s) =3D=3D 0}], 0, NULL) =3D 12803
> --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_EXITED, si_pid=3D12803, si=
_uid=3D1000, si_status=3D0, si_utime=3D2, si_stime=3D6} ---
> read(3,

If FD 6 were wired up to something in the child and the child exited
(which, having received SIGCHLD, is a safe bet), then we'd expect this
to see this process get EOF.

It's not clear to me what's going on here, but I think this code is
ending up in connect.c (search for "transport/file").  Maybe someone
else has an idea?
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--NJYiKO9myxty/qUU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYmIFeAAKCRB8DEliiIei
gSArAQDqu6KAKjV6Y8jk5fZ//FZ5Nbwywvc3VqtbwAcrC58j0AEArknFJUMX9YOU
T+EaghHSTIvG5FWgVpypfIH2Y+5Efgc=
=eJUG
-----END PGP SIGNATURE-----

--NJYiKO9myxty/qUU--
