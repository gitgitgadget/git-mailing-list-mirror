Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D679C1F6C1
	for <e@80x24.org>; Sat, 27 Aug 2016 17:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754775AbcH0R6l (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 13:58:41 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:35603 "EHLO
        zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754374AbcH0R6l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 13:58:41 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Aug 2016 13:58:40 EDT
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Sat, 27 Aug 2016 19:53:36 +0200
  id 000000000000005E.0000000057C1D3A0.00003B76
Date:   Sat, 27 Aug 2016 19:53:36 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     git@vger.kernel.org
Subject: Crash when using git blame on untracked file
Message-ID: <20160827175336.bphgkb6zclvwfntk@ruderich.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512; protocol="application/pgp-signature"; boundary="=_zucker.schokokeks.org-15222-1472320416-0001-2"
Content-Disposition: inline
User-Agent: Mutt/1.6.2-neo (2016-08-08)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-15222-1472320416-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I'm seeing the following crash with Git 2.9.3 on Debian sid
(amd64):

    $ git init foo
    $ cd foo
    $ touch x
    $ git add x
    $ git commit -m test
    $ touch x.conf
    $ git blame x.conf
    segmentation fault

I've tested it on Debian stable's 2.1.4 which works fine:

    $ git blame x.conf
    fatal: no such path 'x.conf' in HEAD

It requires the blamed file to be present, but in some cases it
works only if the file e.g. "x" is already tracked in Git and the
other file is called "x.conf" (".conf"-suffix). But in an empty
repo it seems to happen always.

Sadly Debian's git has no dbg-package, so the stacktrace is not
very useful:

    #0  __strcmp_sse2_unaligned () at ../sysdeps/x86_64/multiarch/strcmp-ss=
e2-unaligned.S:31
    #1  0x000000000041ad7a in ?? ()
    #2  0x0000000000406171 in ?? ()
    #3  0x0000000000405321 in ?? ()
    #4  0x00007ffff6f9f700 in __libc_start_main (main=3D0x4051c0, argc=3D0x=
3, argv=3D0x7fffffffe1a8, init=3D<optimized out>, fini=3D<optimized out>, r=
tld_fini=3D<optimized out>, stack_end=3D0x7fffffffe198)
        at ../csu/libc-start.c:291
    #5  0x00000000004057d9 in ?? ()

Regards
Simon
--=20
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-15222-1472320416-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXwdObAAoJEJL+/bfkTDL5NdkP/3GBhv8uA46LeDZyCPU+RM5X
GdZb7mEL1Cgr7GLSfgJExnE7Y2QL71oO3oxj22ydadT6ra1ZSwCbd2xiAX41I/1C
f0xrDMDhkot1eFUiT8SS8+/I/v9dgQgaQdD1PoOa3c9vqjPax/rWGN9B+cqth5v+
EwxEvJlyhfiNQlSUIonRcDZUb6YzqBn2dPoqmpdNR1Xgm6yrbWP1hc7Ux53byJXN
TKqVlNG3PCoV2DdgP5zQ/JnBavXapS+89Ef80Fck9asBMWItSyHSEy4/B6BaXo8p
XODoHJDRAxBlQ5xgoRSqi+VO58r9Nvb6/9D+OKWR8zhk78RRpwexWzyL0zAu59iv
yna/wf+0pKmgjSNZW3E3Hvux0xO7QlNi5qhdmyCm3PZThGrPkgl0CbpAh8GF9N0r
5yFqrqdlS+n8elsT+YwzDD/AtVYj7dOYdhUKGQG/sTLP6CJe6qzaPBq7UlKrtu/1
UKDGCvsHZAiJ4xUfhS1rzaq8PBUiwDF8Pj8ZrYgIeAhbRiA2Zrl7AKT8jmZj02R/
fjs1BwsEeMxqHPjIjYysxtx+xN8tutOSn7Tbwn4iD9eFUgreaaYIeIAN3BzmQYd+
pRZQ3g/p5AP+xRRDE1DkpI2Oi1HQeX5xFOJeMQz0PLlmEFhSNKXDrwT6CVfnS0Y7
GjjPOZN+ZhmfYQEET+Ee
=g+kz
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-15222-1472320416-0001-2--
