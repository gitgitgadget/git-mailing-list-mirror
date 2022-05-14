Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E550C433F5
	for <git@archiver.kernel.org>; Sat, 14 May 2022 09:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiENJdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 May 2022 05:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiENJc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 May 2022 05:32:59 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F100EDFF0
        for <git@vger.kernel.org>; Sat, 14 May 2022 02:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1652520754;
        bh=ILFSSWeqa1ykyCcmi7J18IgNT5Mvl6Dp61thlTPWzL0=;
        h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
        b=It706Rhprlt9fT5osmV17bkgSbkNKYfdO+cRiwxQfE0F6mIvFixPOlWz3bOhj/tv+
         u1Z1NVgz9hl602IZbJYHzlidt/Y2xeegRazvQKmU7HWyRKJasD8y+GArPwCh9mZBof
         juFL1HWtXOzDkxbwnvF5UKLnLpdek5Bw5TpvOXCE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([91.47.145.161]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MV2OY-1nNeMe0u6I-00SZoc; Sat, 14
 May 2022 11:32:34 +0200
Message-ID: <a6a14213-bc82-d6fb-43dd-5a423c40a4f8@web.de>
Date:   Sat, 14 May 2022 11:32:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Bug: combined diff with --ignore-matching-lines
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V22dkRAMeMf05gHafW0AyXEYYvs2nsgMU7lnDH7kYg2jbxNCKmo
 1FMEVN+/0sX+9iSrg3vJbCBusLhJ8Lj6Md1jj1+fbaAJn0L8txunud98B5IYbs4bzYvPdUp
 L8HuJpzgRq2FfqmnMbfRRnGm4uni7ltm1LwuMHInsmy9hjD2yJhdQPOfMRibVYqBWyBp/Hn
 tnZU21Kxd1mWliswQ+Vug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KPpY8GeBV/I=:jBswYj9OxKuOevJMlOjekA
 KBwLr577p/xcvXzE8dKgoGteu0rS7rRgVh81LWvOvmXpIBXzgNpkouHGf9PnBwT/qg6ujl4Aq
 ZATLmlcBXu/jH3cWk5BK4KiBVICDGzJVFVMdZTS84YwM+d6lhvK3gDHl4h/DVwCbSFmZr87ci
 DXJ2QJ96wBYT8TbUeVhLqlDwjZLKIoSf3++/FFQgjaEOBQdSpz6XS5eJwUvynkaFMtgoI637V
 NEQBeXFA/U5dBVM0B6pyCtG+XqEvq9Ig++33Tv53rx6ijEAdCPcbejXxln7DBSur4K7kNNT92
 m7H+JFPyzYXyCYGDn2TePqWLtxfSN+OsyACY6P6kjCEniDFCW8wP6DBQJkfFfK93jf+5Tl4Hv
 htRCmNXrOZ0DtL3ypkeEfpoLP5x2GOXsWtZa4ZNr5ee3XuJfgN3A90AzySyDSeeL7QkU4WXBO
 3LIbcFdtyOstWB11PohlvWjUKgqqjg4ftY99QS9a7KuPPjy3dzkGcI2bpje033bLj2CduGv1e
 eYUerCkPw+NnTyRMq2+NrYXBcg5XDpC+IbKDI3Uq9O+AXfQgDqllZffQk8OFh9ktfumIq5K81
 hzZxwGbG4ywMX0vuN0oBYQKhJXsElagYMpUwSCoOMtiBX+eJaYZoN0EUUUUsFb+iZP/KtLqMn
 cFaIjFPS89dSCdUWzLI8gXdS+n+heeqkY3SvufCwQnsmvZPGV2CmVVX+ScZlh2qynYtO2fh09
 vJ2PMkmE4wFDfS3AEz9fwU+U8XjLoDFSkxiWN5IB8afikcFCj+54zr+UWJP/P4DDWN8F6HbX1
 Iu7bkWzeWkZEy3YKdD57+n/cZZKHXiiFo/GRj8Drk1mT5ty8TVx0j3WqkO6cL8beiin6hJ51X
 cOucAcAG+NTRMPrRUQfSuStTtU37usZbt0KIJ8AZXbK7mtBQhSl5wzhQXyqi3Bz6Y4g6KWALZ
 Uza2yPGtN2DuQ/5CBC+yBb8M8vXGEvu+udUSoMKuX20k26YWP3wce6KImZQqyYzj8nfGVIgZ6
 7rUsEfBLpzABmgZe8iLmIjPOLW7+2P8UHG+ggopA9nlrF2Yk0w4ex2EQeWRcwkiZPQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

git diff segfaults when it's asked to produce a combined diff and ignore
certain lines with --ignore-matching-lines/-I, e.g.:

   $ git diff -I DEF_VER v2.33.3 v2.33.3^@
   zsh: segmentation fault  ./git-diff -I DEF_VER v2.33.3 v2.33.3^@

That's because combine-diff.c::diff_tree_combined() copies a diffopt
without making a deep copy of the ignore_regex array and frees it, then
later tries to use it.

The segfault can be fixed by adding "diffopt.no_free =3D 1;" or reverting
c45dc9cf30 (diff: plug memory leak from regcomp() on {log,diff} -I,
2021-02-11).

But even with that the only thing the command ignores is the option -I;
the GIT-VERSION-GEN changes in the middle should have been omitted:

   $ git diff -I DEF_VER v2.33.3 v2.33.3^@
   diff --cc Documentation/RelNotes/2.33.3.txt
   index 0000000000,0000000000..e2bada12a1
   new file mode 100644
   --- /dev/null
   +++ b/Documentation/RelNotes/2.33.3.txt
   @@@ -1,0 -1,0 +1,4 @@@
   ++Git Documentation/RelNotes/2.33.3.txt Release Notes
   ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
   ++
   ++This release merges up the fixes that appear in v2.33.3.
   diff --cc GIT-VERSION-GEN
   index d81eab5f00,e7efe58866..86a3a2870c
   --- a/GIT-VERSION-GEN
   +++ b/GIT-VERSION-GEN
   @@@ -1,7 -1,7 +1,7 @@@
     #!/bin/sh

     GVF=3DGIT-VERSION-FILE
   - DEF_VER=3Dv2.33.2
    -DEF_VER=3Dv2.32.2
   ++DEF_VER=3Dv2.33.3

     LF=3D'
     '
   diff --cc RelNotes
   index 8e79de2efe,4ac68388c3..899139d9ec
   --- a/RelNotes
   +++ b/RelNotes
   @@@ -1,1 -1,1 +1,1 @@@
   - Documentation/RelNotes/2.33.2.txt
    -Documentation/RelNotes/2.32.2.txt
   ++Documentation/RelNotes/2.33.3.txt

Just setting need_generic_pathscan is not enough.  Ideas?

Ren=C3=A9

