Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B4091FF32
	for <e@80x24.org>; Thu, 19 Oct 2017 09:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbdJSJg6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 05:36:58 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:27712 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbdJSJg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 05:36:56 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20171019093654epoutp03e19773bb1d75da96a19557668d4ddee0~u7xi-ikla2109821098epoutp03S;
        Thu, 19 Oct 2017 09:36:54 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.42.56]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20171019093654epcas1p2b92f831120c7c19f42167c9b172ce743~u7ximV3Kg2818528185epcas1p2K;
        Thu, 19 Oct 2017 09:36:54 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        3D.15.04388.63278E95; Thu, 19 Oct 2017 18:36:54 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20171019093654epcas1p18c81bdc1cfd4ab8c0dfa52962b9a2dd2~u7xiTcEcR0667706677epcas1p1p;
        Thu, 19 Oct 2017 09:36:54 +0000 (GMT)
X-AuditID: b6c32a38-d71ff70000001124-15-59e872361f20
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.A2.06995.53278E95; Thu, 19 Oct 2017 18:36:53 +0900 (KST)
Received: from [106.109.129.81] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0OY2009RCDDEVT60@mmp1.samsung.com>; Thu, 19 Oct 2017 18:36:53 +0900 (KST)
Subject: [PATCH v2] commit: check result of resolve_ref_unsafe
From:   Andrey Okoshkin <a.okoshkin@samsung.com>
To:     peff@peff.net, gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, l.s.r@web.de,
        avarab@gmail.com, krh@redhat.com, rctay89@gmail.com,
        Ivan Arishchenko <i.arishchenk@samsung.com>,
        Mikhail Labiuk <m.labiuk@samsung.com>
Organization: Samsung RnD Institute Russia
Message-id: <5fa1f5c6-249e-2aa9-5e9f-c00ebe2c0d9d@samsung.com>
Date:   Thu, 19 Oct 2017 12:36:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.4.0
MIME-version: 1.0
In-reply-to: <0e396c24-167f-901e-9122-cdc17164ec1e@samsung.com>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfOtuNwdpqaT1qKq4SkTEXqFKYFQedDgX0o1A/V0sM0ncqO
        dwItVERdrdoUF4loUt4Qr600w+m8wNS8ZBevpCxJZpaXVkLldhT89n/e5//jef4PL4FJ9Hx3
        IjYhmVEmyOKlAhHe1n3U//hJ5WKE/5cckqo3T/GogvFCHpWtGseo5snPiLo3bOJRptYHGPXj
        ST9OFWosiLLmFGFUcadeeE5Ev9JNC2mzqgPRI6OH6O+d7wX0/ZYaRK82edKT5jY8TBgpCo5m
        4mNTGeWJkJuimCnjAJ6US6Rvzqj42cgoKEAOBJBB0F69wS9AIkJC6hGMD5QKueIXgqWyHmzH
        pZ6z8LhGOwKNumsbmUWgaqzdKgjCmQyB/vksGyAg/WD4j1po0y7kYRhcr7PDGGlEsFI2ybc1
        9pC+MGYts08Qb7FdJWv2nXDyCKxOr9hhVzIc+rqfI86zF6yPZ3CbdiBDYcI0xbNpjDwD5r+5
        fE67Qe/sJ8RpL2ius2C2wUD+E4D2qYbHxbkAlRUPhZx2hm99LUJbACA9YNR4lnvOgtz8BQHH
        5iNY1VVt+0OhpeClgBvgBMvrRXyOFUN+noSz0DBSN7F9ufNQe3dw+1iPEAxV1uNq5KXblUe3
        K4NuVwbdrgzlCK9B+5gkViFn2ICkID9WpmBTEuR+UYmKJmT/T76UHnUMXTIgkkBSR3F58dcI
        CV+WymYoDAgITOoiTgxbjJCIo2UZmYwy8YYyJZ5hDciDwKVuYteGiXAJKZclM3EMk8Qod7o8
        wsE9G11WRZUc47+L1JxyjA6cs774bRmuD04b6esn1KNMcyBueq3b7zqvNd3+Gbpaympon/I1
        w6CyZkF7/UNkgpO0gbgqb12u2Bw1r6df3CjUf0wf671Shw56Vrnd6rlTkamffRZXY26Ul1Zs
        er/VeeeJi5ZMb6pPa9vTDvhsuLcNXJPibIwswBdTsrL/kC06L0sDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsVy+t9jAV3ToheRBnO3WVqsfXaHyaLrSjeT
        RUPvFWaLzbdvMVo0nT/DZHFmaz+zxcfZJ1gsuqe8ZbT40dLDbDFt3w52By6PnbPusns8693D
        6HHxkrLH+31X2Tz6tqxi9Pi8Sc7j9rNtLAHsUVw2Kak5mWWpRfp2CVwZd46eZClo5aj4fa+X
        tYHxKFsXIyeHhICJxIQHb5m6GLk4hAR2Mkrcfr6MEcJ5yCjRPu8oUIaDQ1jATuLE43qQBjYB
        PYnzvyawg9giAioSZ7+uAWtmFjjOKLH8x3FmiOYpjBIb/38BW8EvoCVx+cc8ZhCbF2jQwekQ
        cRYBVYnPdz+ATRIViJB43vyeFaJGUOLH5HssIDangL3EtTN3mEBsZgEziS8vD7NC2OISx+7f
        ZISw5SU2r3nLPIFRcBaS9llIWmYhaZmFpGUBI8sqRsnUguLc9NxiowLDvNRyveLE3OLSvHS9
        5PzcTYzAiNp2WKtvB+P9JfGHGAU4GJV4eD2mPI8UYk0sK67MPcQowcGsJMKbH/AiUog3JbGy
        KrUoP76oNCe1+BCjNAeLkjjv7bxjkUIC6YklqdmpqQWpRTBZJg5OqQbGmRqbsi+ce3BfSmXG
        A/+DuefZ/ptbFOWHM7MaPDt5JWlvOV/RPq+ZiSpN7c5nSu/6yy42+alYIvp70VeruxfO8Sc6
        m5t+1/2z4voSrijWczGpouyVoeerLn2t2O3kVJzPqPbFI2m2W1hd5vJNMg3X7k+7XZHb3fy0
        Xdz2+NWzM+7wbf4Wv+CYEktxRqKhFnNRcSIA7gnRfaQCAAA=
X-CMS-MailID: 20171019093654epcas1p18c81bdc1cfd4ab8c0dfa52962b9a2dd2
X-Msg-Generator: CA
X-Sender-IP: 182.195.42.142
X-Local-Sender: =?UTF-8?B?QW5kcmV5IE9rb3Noa2luG1NSUi1TVyBUb29scyBMYWIb?=
        =?UTF-8?B?7IK87ISx7KCE7J6QG0xlYWRpbmcgRW5naW5lZXI=?=
X-Global-Sender: =?UTF-8?B?QW5kcmV5IE9rb3Noa2luG1NSUi1TVyBUb29scyBMYWIbU2Ft?=
        =?UTF-8?B?c3VuZyBFbGVjdHJvbmljcxtMZWFkaW5nIEVuZ2luZWVy?=
X-Sender-Code: =?UTF-8?B?QzEwG0NJU0hRG0MxMEdEMDFHRDAxMDE1Nw==?=
CMS-TYPE: 101P
X-CMS-RootMailID: 20171018170047epcas2p4310be357e11e194d6d08ac3bdc478ba3
X-RootMTR: 20171018170047epcas2p4310be357e11e194d6d08ac3bdc478ba3
References: <CGME20171018170047epcas2p4310be357e11e194d6d08ac3bdc478ba3@epcas2p4.samsung.com>
        <0e396c24-167f-901e-9122-cdc17164ec1e@samsung.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add check of the resolved HEAD reference while printing of a commit summary.
resolve_ref_unsafe() may return NULL pointer if underlying calls of 
lstat() or
open() fail in files_read_raw_ref().
Such situation can be caused by race: file becomes inaccessible to this 
moment.

Signed-off-by: Andrey Okoshkin <a.okoshkin@samsung.com>
---
Thank you for your review.

Changes since the previous patch:
* BUG is replaced with die, message;
* Message is changed.

  builtin/commit.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1a0da71a4..cc27c9af7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1483,6 +1483,8 @@ static void print_summary(const char *prefix, 
const struct object_id *oid,
  	diff_setup_done(&rev.diffopt);

  	head = resolve_ref_unsafe("HEAD", 0, junk_oid.hash, NULL);
+	if (!head)
+		die(_("unable to resolve HEAD after creating commit"));
  	if (!strcmp(head, "HEAD"))
  		head = _("detached HEAD");
  	else
-- 
2.14.2
