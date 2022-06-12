Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEF7C433EF
	for <git@archiver.kernel.org>; Sun, 12 Jun 2022 06:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbiFLGSs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jun 2022 02:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiFLGSq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jun 2022 02:18:46 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3F539BA6
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 23:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1655014701;
        bh=1UVCC78FdXD4x06vNF2gJTXUHfIxiKSYmgoRCp6h724=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=Cwz+OT5js8HpT/YkR5JHgbnKQDzAg+nHc8RbDEp43HVIGzCMpbJcGqyhjlHtCwqsP
         oZrmSvBILy/yzpdambaA18SPdJr3x1YnTvBZkKkUbMNUKd6AcsQlSxJSdj2KY5jKnI
         WoY5g0hnqWwh0ozWaajfEowH+mRyCwQDOInv/0cA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9ZZo-1o3aJc3Ra8-005kiY; Sun, 12
 Jun 2022 08:18:20 +0200
Message-ID: <0a6877c3-07f2-b0e2-f23c-9ea4c588e8a5@web.de>
Date:   Sun, 12 Jun 2022 08:18:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: [PATCH v3 4/5] archive-tar: use OS_CODE 3 (Unix) for internal gzip
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de>
In-Reply-To: <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZMD5m2x3NvG36FYnYGrEoWqUFYtakQdpuu8kP51VxxIHzxam956
 DQwisIObJyQcUjeC+VFWN1fwqObuUqCyu5TvdAKjq3LZNaqGMHXL9izBu+OdoAJaz3i2ZBB
 8CaOizSt1JwkhglnCWdMeG1zJF5llSoSOETk2UnqpYN/n5Nb+Qf4rUlsnt8ph/72//PKl4E
 gOctF/R7mkTC4euKm34Wg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gF9pEg64btI=:sCd1qBLCt/X/oKw05HKrpW
 Knt4kxmgGT+KalDljIbobWNDfh+bXqF+lnhe5WozmLVaV18FMwQ36Ab2P3AK+IMsmrMG2Le03
 FoGr1MbnIrKSL95n9EVv2PxxIaLEm0UIeqstH2TImCFJBOdi78HQio8+UJIYjLD0r/WV/CGOu
 bZell81ypIH+GEBnGFYfdSgu1LSN6wfl+ANaHj/7SiEYHJ/duB/xkxn/WT453UgJaBjAB3yVp
 61xWKcQ9GbyUbhlcT6yJRmIZqxYYKc4VRZ3/PX69SaCgHfFXirNAbTkyjpMDoWsbeDwRKggrs
 l24/D2nx+xvlyonPEFpTLxzTALVszPUe8NWPk/NPqaG9hLckvu7ebBMQrDdoPjh6pdeBzOgej
 BqCLdUtXwVKWU82xmlihn0lsimpvjiuyLj0eE9j9LFfjKOfTy6q/4V6GgyjapMXvH/FEMKCpz
 ZXChuuIntirgkOCieNSa4xduBtq9f7TRrzjxWsBWjJJPJsegWlaObgRuVx7PYd0QOf1QCkmSW
 3KJuxvqN/qWdEJsqN4k+8IaFTP9MuiOPVHGiV113UkQwaj9wAmMA1ji1PzZhna9gVfmrk6jbk
 b1P8fvPVnf+MPb2qQTYrKEJhhFB1DwhKQJsiDKFwjQHFOsO9EKBdcyhRZ5VbgEi5UsxN+MS0Q
 H/Iu9WOM0k9pdZYG8iuIig7Pn/tgiJA/VQjjOUtaCqSxpf1k2Rv3hVZFw88UU0BH2IHVVM+cI
 B06/DFjzyy3ZRSuAhVm66lLnLVkP0YkyfKMYjaXeKd6I93xt22qKa0M/pthgnZHEZtozuHO/L
 TPkO5B++Z34YLsDxcqThiopNJ7O4mvcJTaXcZod6yiXBVcTCeeGL2O1d2Z5E2IP+IZ8enyzNx
 pLnPTaZqzT1z6bYC89Z7xb/S3gWaZvBAsJJ5IyV/Te5gBVqzm3lk3HXJa1YE6C1MuVBIpYixo
 XviY/6nQuWIj0lXuT8YCU0K3yJs5KscXA0PG9UUy9i5tppBAmvpMsr6YU4VndtYnLCpZw7Uea
 gF6GS9x3rg1/RYhlfqUemeBycOc1jKBkJPr2wLb5R4pdtgs8Xir/PbLcy1lBOhSRT8njASVY1
 WNUF4va6zWpsm2RB0owIDf6TiI698dxnjrA
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gzip(1) encodes the OS it runs on in the 10th byte of its output. It
uses the following OS_CODE values according to its tailor.h [1]:

        0 - MS-DOS
        3 - UNIX
        5 - Atari ST
        6 - OS/2
       10 - TOPS-20
       11 - Windows NT

The gzip.exe that comes with Git for Windows uses OS_CODE 3 for some
reason, so this value is used on practically all supported platforms
when generating tgz archives using gzip(1).

Zlib uses a bigger set of values according to its zutil.h [2], aligned
with section 4.4.2 of the ZIP specification, APPNOTE.txt [3]:

         0 - MS-DOS
         1 - Amiga
         3 - UNIX
         4 - VM/CMS
         5 - Atari ST
         6 - OS/2
         7 - Macintosh
         8 - Z-System
        10 - Windows NT
        11 - MVS (OS/390 - Z/OS)
        13 - Acorn Risc
        16 - BeOS
        18 - OS/400
        19 - OS X (Darwin)

Thus the internal gzip implementation in archive-tar.c sets different
OS_CODE header values on major platforms Windows and macOS.  Git for
Windows uses its own zlib-based variant since v2.20.1 by default and
thus embeds OS_CODE 10 in tgz archives.

The tar archive for a commit is generated consistently on all systems
(by the same Git version).  The OS_CODE in the gzip header does not
influence extraction.  Avoid leaking OS information and make tgz
archives constistent and reproducable (with the same Git and libz
versions) by using OS_CODE 3 everywhere.

NB: The function deflateSetHeader() was introduced by zlib 1.2.2.1,
released 2004-10-31.

At least on macOS 12.4 this produces the same output as gzip(1) for the
examples I tried:

   # before
   $ git -c tar.tgz.command=3D'git archive gzip' archive --format=3Dtgz v2=
.36.0 | shasum
   3abbffb40b7c63cf9b7d91afc682f11682f80759  -

   # with this patch
   $ git -c tar.tgz.command=3D'git archive gzip' archive --format=3Dtgz v2=
.36.0 | shasum
   dc6dc6ba9636d522799085d0d77ab6a110bcc141  -

   $ git archive --format=3Dtar v2.36.0 | gzip -cn | shasum
   dc6dc6ba9636d522799085d0d77ab6a110bcc141  -

[1] https://git.savannah.gnu.org/cgit/gzip.git/tree/tailor.h
[2] https://github.com/madler/zlib/blob/master/zutil.h
[3] https://pkware.cachefly.net/webdocs/casestudies/APPNOTE.TXT

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Perhaps makes sense for remote-curl as well (out of scope of this
series)?

 archive-tar.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/archive-tar.c b/archive-tar.c
index 53d0ef685c..bf7e321e0e 100644
=2D-- a/archive-tar.c
+++ b/archive-tar.c
@@ -460,6 +460,14 @@ static void tgz_write_block(const void *data)

 static const char internal_gzip_command[] =3D "git archive gzip";

+static void tgz_set_os(git_zstream *strm, int os)
+{
+#if ZLIB_VERNUM >=3D 0x1221
+	struct gz_header_s gzhead =3D { .os =3D os };
+	deflateSetHeader(&strm->z, &gzhead);
+#endif
+}
+
 static int write_tar_filter_archive(const struct archiver *ar,
 				    struct archiver_args *args)
 {
@@ -473,6 +481,7 @@ static int write_tar_filter_archive(const struct archi=
ver *ar,
 	if (!strcmp(ar->filter_command, internal_gzip_command)) {
 		write_block =3D tgz_write_block;
 		git_deflate_init_gzip(&gzstream, args->compression_level);
+		tgz_set_os(&gzstream, 3); /* Unix, for reproducibility */
 		gzstream.next_out =3D outbuf;
 		gzstream.avail_out =3D sizeof(outbuf);

=2D-
2.36.1
