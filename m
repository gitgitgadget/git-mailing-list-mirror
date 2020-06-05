Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3567C433E1
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 05:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A689920659
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 05:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="J8Yueenz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgFEFPU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 01:15:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:46099 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgFEFPS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 01:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591334105;
        bh=3FNTqr1rHIZ6qc95cuTn9arOVpJsnO2+nEz+1WFZRfc=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=J8Yueenzzj4BAyN2gzBlCnsA/mmEwhbhNbG1FIqE8zAoTBS+J+uxnRfaEloib+zG+
         HoilscI1A1rDVnMbO65Y3fN50WbLdxtKf6P8E1yzCyUniDrmWnbUVyo8OCK42lkoK5
         +t/NE34kIyK7VApMm2UzrEgZWY1RT8UJXPkV/DsU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.65.3] ([94.21.166.201]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MacSY-1j66FP0vVa-00cApt; Fri, 05
 Jun 2020 07:15:05 +0200
To:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
From:   Billes Tibor <tbilles@gmx.com>
Subject: git-fast-import out of memory
Message-ID: <c53bb69b-682d-3b47-4ed0-5f4559e69e37@gmx.com>
Date:   Fri, 5 Jun 2020 07:15:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:oryRwvpm0Z4yg8aq7zY2YnT6yE6YJAWkD9wNTzhiMGOoj9jN6sg
 wcb4NZFwFgPT2I3TPvo7h25HFmaw3p6pTeNiukCfkzSsnKfZ5/fFUJ2qNrHUxaD0Dw08Xb2
 q5KWjoOZY03pdUmCNMs4NxVvkAhbJiew9ULs/HAzNYDzAdyyouG553MHk4ZQmUmb/62KzTI
 PzpVwSvKwQXNP1hX7maqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bw2RoafUK9U=:XbmsJyViWWmrsT3aGgUTTc
 Ldtlb/kXdAUCcJCQNXDs3faxdwko83F7ornga7zEH5ckh+8jeVRKfYUbGqVqKQcQInm8gTr3/
 +wCjiArw0AtYHemXq5YUDLXA2ooyfascKwlXJdcS4wAqoomPx1lzdKocJ7rBIuj5d5Kl9HD0r
 XjK/immG+6rYpwwwsMAF36F0AeIVC+nvaOMCNjQbhk4ki9NqqwBKMLVaKt6ip/OEEZApuOhg1
 0RDm7vBLTYGvwTXL802Rv+8bDKQtubm86CKU00SNkpmug0bo27xFDkfClRfww6VXq0hk4MnCv
 eP2+gOLKecZ/oupkNGDqDkvJuKtKstcVR2YG3pwXoJ/O2nhoog1ersWX7p65mozeHPGsCFUiK
 iDlrOE1hAY7RVHrG2s55coiSEpAFlcW07cRpCabgGdNDBdfwfVTrYKQ8CRBXsfihoEtEu8UdR
 DkyUy3Bz3IeCvuwOP+ZUyA7qfvTxDOYR0CYlNS1Z8gSInXpYoG+NZaENwBRCuWyQtNvytzVFU
 tLisew7AMMBCqoTFVg2dtulg9K+b4ypofviLcxLble8yp0ni0csDwSxvch+eQrvdkNkDlOyYQ
 UWDHofFqzrRW1Uh+p8LGmP1itGN1rkpRRoPvHgrnQAQeeDXHCfI7lnPJQv0XmOgj65ToqbWkD
 D9g3/2Z0UNVQMEkSrUotIR1se7Fghws3s5gPS5KpArizH8/da7Dl4TRYZCBOYNsn7kGPPXgyZ
 c/6tDb1oYea+q//EOfISdTkrRXmK1dx3R/cKV+vc8SToSaViFdODuxrX30LZTOm9d3iVWJhfu
 sz7yPa8Di+/BI2VAEaad2aIH5nrYeFvKZq1tzIcndCiMSKcdGR+ndrulCE8fGnm7a5TuNpQad
 8eNJe5YpxnWBLtagDX3PMuqL001QI/dSFubM0QDedHlwAQSZVQTzFtBdcdxkdTO2fXj4W8/2c
 1oR6Y7y4AoZljo80IUYvO9AWoQOeGoPR7smJa42v5wzor4+RBJv5b7jL8YMdpKvdtJ9OWJ5WF
 yG9kUr10YOlPHRruULibLga9aQVmlOPVXbENTOoECTxhPPvNOvS0VY26cSUyl+v0PC/0IO2WD
 0xNh97HiNqkqTOJRY+XqoA9VIfCHf+0VlnrcapxEKkpWlQTHnaozMHAzukSAUqI7KNPAzlh3t
 6XRI+keZIrKs4z3fVUGIQIWWGOM8bn7vBZa2GHesyudabgSYJAT8FPUkIN/VIC1um9DLy1+Gz
 8WmJx5WD0K4fij4Gg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I recently upgraded my git to version 2.27.0-1~ppa0~ubuntu18.04.1 and
noticed
that git-fast-import uses so much memory it gets killed. I'm fetching from=
 a
Mercurial repo using an importer from
https://github.com/mnauw/git-remote-hg.git which uses git-fast-import to
fetch
commits from Mercurial.

Here is an output of a git fetch showing is used 14Gb of RAM (on a 16Gb
machine)
# time git fetch
error: git-fast-import died of signal 9
fatal: error while running fast-import
Command exited with non-zero status 128
2.02user 3.82system 0:08.00elapsed 73%CPU (0avgtext+0avgdata
14744800maxresident)k
104920inputs+0outputs (414major+3688606minor)pagefaults 0swaps

strace shows that git-fast-import is reading the marks from a file, then
allocate some memory, reads more marks, allocates more memory, and so on:

11191 06:19:08.180572 read(7<.../.git/hg/origin/marks-git>, "79798
8ea080f15ab22807608aae4696dd23edefd8febe\n:220396
919079de10d43caf3fcde56bb1a17994b47a6214\n:75683
928813193a1535dc1274ed9da2f54f5de2caf2f4\n:155297
9108211d7ba318076fb53b2bd3d291102b376dbf\n:162042
9458fe329e9be30ad2b61e75197595889d80144b\n:305834
93485ce7991b4330a1114136b5d8e08d8bd1505b\n:223654
9750bdef7d22a885d2522bdd9e0a0e882979098e\n...", 4096) =3D 4096 <0.000027>
11191 06:19:08.182162 mmap(NULL, 2101248, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7f5be38ef000 <0.000024>
11191 06:19:08.183403 mmap(NULL, 2101248, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7f5be36ee000 <0.000127>
11191 06:19:08.184775 mmap(NULL, 2101248, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7f5be34ed000 <0.000059>
11191 06:19:08.186036 mmap(NULL, 2101248, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7f5be32ec000 <0.000121>
11191 06:19:08.187412 mmap(NULL, 2101248, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7f5be30eb000 <0.000110>
11191 06:19:08.188743 mmap(NULL, 2101248, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7f5be2eea000 <0.000022>
11191 06:19:08.189929 mmap(NULL, 2101248, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7f5be2ce9000 <0.000039>
11191 06:19:08.191150 mmap(NULL, 2101248, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7f5be2ae8000 <0.000019>
11191 06:19:08.192329 mmap(NULL, 2101248, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7f5be28e7000 <0.000023>
11191 06:19:08.193536 mmap(NULL, 2101248, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7f5be26e6000 <0.000038>
11191 06:19:08.194523 mmap(NULL, 2101248, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7f5be24e5000 <0.000019>
11191 06:19:08.195474 mmap(NULL, 2101248, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7f5be22e4000 <0.000212>
11191 06:19:08.196677 mmap(NULL, 2101248, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7f5be20e3000 <0.000027>
11191 06:19:08.197729 mmap(NULL, 2101248, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7f5be1ee2000 <0.000128>
11191 06:19:08.198883 mmap(NULL, 2101248, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7f5be1ce1000 <0.000043>
11191 06:19:08.199881 mmap(NULL, 2101248, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7f5be1ae0000 <0.000124>
11191 06:19:08.200959 mmap(NULL, 2101248, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7f5be18df000 <0.000020>
11191 06:19:08.201943 mmap(NULL, 2101248, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7f5be16de000 <0.000021>

The following shows that memory allocation seems to be linear with
respect to
the number of marks, but with a very high constant factor:
# cut -d' ' -f 3 /tmp/gitfetch.strace | cut -d '(' -f 1 | uniq -c

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ ... cut (this is not the sta=
rt of the allocations) ... ]
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 read
 =C2=A0=C2=A0=C2=A0=C2=A0 47 mmap
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 read
 =C2=A0=C2=A0=C2=A0=C2=A0 79 mmap
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 read
 =C2=A0=C2=A0=C2=A0=C2=A0 36 mmap
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ ... removed some other sysca=
lls ... ]
 =C2=A0=C2=A0=C2=A0=C2=A0 73 mmap
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 read
 =C2=A0=C2=A0=C2=A0 141 mmap
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 read
 =C2=A0=C2=A0=C2=A0 173 mmap
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 read
 =C2=A0=C2=A0=C2=A0 204 mmap
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 read
 =C2=A0=C2=A0=C2=A0 235 mmap
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 read
 =C2=A0=C2=A0=C2=A0 267 mmap
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 read
 =C2=A0=C2=A0=C2=A0 297 mmap
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 read
 =C2=A0=C2=A0=C2=A0 329 mmap
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 read
 =C2=A0=C2=A0=C2=A0 361 mmap
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 read
 =C2=A0=C2=A0=C2=A0 392 mmap
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 read
 =C2=A0=C2=A0=C2=A0 424 mmap
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 read
 =C2=A0=C2=A0=C2=A0 454 mmap
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 read
 =C2=A0=C2=A0=C2=A0 493 mmap

My marks file contains 91k entries, git fetch reads only 1400 before kille=
d.

I bisected the problem, below is my bisect log:
git bisect start
# good: [af6b65d45ef179ed52087e80cb089f6b2349f4ec] Git 2.26.2
git bisect good af6b65d45ef179ed52087e80cb089f6b2349f4ec
# bad: [b3d7a52fac39193503a0b6728771d1bf6a161464] Git 2.27
git bisect bad b3d7a52fac39193503a0b6728771d1bf6a161464
# bad: [af986863c1ae2e306d5627f4e42cc6d2cf2a057f] Merge branch
'dd/ci-musl-libc'
git bisect bad af986863c1ae2e306d5627f4e42cc6d2cf2a057f
# bad: [7a8bb6db7cc04add05484c4fc907e34f76b12fb9] Merge branch
'jm/gitweb-fastcgi-utf8'
git bisect bad 7a8bb6db7cc04add05484c4fc907e34f76b12fb9
# bad: [4e4baee3f44da26a5eaab27c76d597b04fef5259] Merge branch
'bc/filter-process'
git bisect bad 4e4baee3f44da26a5eaab27c76d597b04fef5259
# good: [883e23820ed21b4ae65463f2a87152285bf77937] Merge branch
'en/oidset-uninclude-hashmap'
git bisect good 883e23820ed21b4ae65463f2a87152285bf77937
# bad: [1bdca816412910e1206c15ef47f2a8a6b369b831] fast-import: add
options for rewriting submodules
git bisect bad 1bdca816412910e1206c15ef47f2a8a6b369b831
# good: [bf154a878281b6a971ece0fb6d917938298be60d] t/helper: make
repository tests hash independent
git bisect good bf154a878281b6a971ece0fb6d917938298be60d
# good: [e02a7141f83326f7098800fed764061ecf1f0eff] worktree: allow
repository version 1
git bisect good e02a7141f83326f7098800fed764061ecf1f0eff
# bad: [abe0cc536414f2b9cfa37f208b36df5126e6356a] fast-import: add
helper function for inserting mark object entries
git bisect bad abe0cc536414f2b9cfa37f208b36df5126e6356a
# bad: [ddddf8d7e254f4af6297d0ed62ea6a5d7eabdb64] fast-import: permit
reading multiple marks files
git bisect bad ddddf8d7e254f4af6297d0ed62ea6a5d7eabdb64
# good: [42d4e1d1128fa1cb56032ac58f65ea3dd1296a9a] commit: use expected
signature header for SHA-256
git bisect good 42d4e1d1128fa1cb56032ac58f65ea3dd1296a9a
# first bad commit: [ddddf8d7e254f4af6297d0ed62ea6a5d7eabdb64]
fast-import: permit reading multiple marks files

According to the bisect the first bad commit is:

commit ddddf8d7e254f4af6297d0ed62ea6a5d7eabdb64 (refs/bisect/bad)
Author: brian m. carlson <sandals@crustytoothpaste.net>
Date:=C2=A0=C2=A0 Sat Feb 22 20:17:45 2020 +0000

 =C2=A0=C2=A0=C2=A0 fast-import: permit reading multiple marks files

 =C2=A0=C2=A0=C2=A0 In the future, we'll want to read marks files for subm=
odules as well.
 =C2=A0=C2=A0=C2=A0 Refactor the existing code to make it possible to read=
 multiple marks
 =C2=A0=C2=A0=C2=A0 files, each into their own marks set.

 =C2=A0=C2=A0=C2=A0 Signed-off-by: brian m. carlson <sandals@crustytoothpa=
ste.net>
 =C2=A0=C2=A0=C2=A0 Signed-off-by: Junio C Hamano <gitster@pobox.com>

When doing the bisect it was easier for me to use git from the Ubuntu
package and only replace the git-fast-import binary with the one I was
testing.
I hope it doesn't falsify the bisect results. The behavior seemed to be
consistent: it either produced the issue above, or it worked perfectly fin=
e.

Can you help me fix this issue? I hope the information I gathered is
enough to
help you find the cause of this behavior. I'd be happy to provide more
information if needed or test patches.=C2=A0 Unfortunately the source code=
 I was
fetching is proprietary, I cannot post it.

Best Regards,
Tibor Billes
