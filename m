Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCFF81FF32
	for <e@80x24.org>; Fri, 20 Oct 2017 13:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751031AbdJTNJg (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 09:09:36 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:15070 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbdJTNJf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 09:09:35 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20171020130934epoutp031f3ad6486e9e168c530d43bd58f6b156~vSUgODDKp0687406874epoutp03o;
        Fri, 20 Oct 2017 13:09:34 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.42.56]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20171020130933epcas1p3ada563b2c0809d6e1240cbc404742b66~vSUf9svWQ1680916809epcas1p3M;
        Fri, 20 Oct 2017 13:09:33 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        79.99.04388.D85F9E95; Fri, 20 Oct 2017 22:09:33 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20171020130933epcas1p4d0ba8c5be6e2570613185f71b1cea078~vSUfgpaAc1417614176epcas1p4c;
        Fri, 20 Oct 2017 13:09:33 +0000 (GMT)
X-AuditID: b6c32a38-d89ff70000001124-69-59e9f58df3cb
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.5B.06995.D85F9E95; Fri, 20 Oct 2017 22:09:33 +0900 (KST)
Received: from [106.109.129.81] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0OY400L7MHVV5850@mmp1.samsung.com>; Fri, 20 Oct 2017 22:09:33 +0900 (KST)
Subject: [PATCH v4] commit: check result of resolve_ref_unsafe
From:   Andrey Okoshkin <a.okoshkin@samsung.com>
To:     Jeff King <peff@peff.net>, gitster@pobox.com
Cc:     git@vger.kernel.org, Ivan Arishchenko <i.arishchenk@samsung.com>,
        Mikhail Labiuk <m.labiuk@samsung.com>
Organization: Samsung RnD Institute Russia
Message-id: <a9cce39c-e432-d5a7-d9ad-6b67d9e04d23@samsung.com>
Date:   Fri, 20 Oct 2017 16:09:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.4.0
MIME-version: 1.0
In-reply-to: <c5f72436-df4e-5c51-d58b-8699dfcfd70c@samsung.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZdlhTX7f368tIg/6dmhZdV7qZLBp6rzBb
        bL59i9Hi4+wTLBY/WnqYHVg9nvXuYfS4eEnZo2/LKkaPz5vkAliiuGxSUnMyy1KL9O0SuDJa
        by5mLZjBVbFiG1sD42aOLkZODgkBE4m3D2Yxg9hCAjsYJdq3OXUxcgHZ3xklNm+YxQRTdOHa
        H2aIxG5GiTXvDrJCOPcZJfrbDzOCVAkL2Ence3YWrINNQE/i/K8J7CC2iICBxIuH58FsZoFc
        iVet71lBbH4BLYnLP+aBreYF6t28bDdYnEVAVeLj+utgcVGBCInjh5czQtQISvyYfI+li5GD
        g1PAXmLiQ06IkZoSL75MYoGwxSWO3b/JCGHLS2xe8xbsaAmBI2wS7VcusIP0Sgi4SGxYJgnx
        mLDEq+NboMLSEpeO2kKE6yVaO56wQbR2MEp8nrWUHSJhL7GlazsbxHw+iXdfe1ghenklOtqE
        IEo8JC6uucYMYTtKrG48Cw2qbUwSKzc1M05glJ+F5JtZSF6YheSFWUheWMDIsopRLLWgODc9
        tdiwwESvODG3uDQvXS85P3cTIziNaFnsYNxzzucQowAHoxIP74YLLyKFWBPLiitzDzFKcDAr
        ifB2fXoZKcSbklhZlVqUH19UmpNafIhRmoNFSZxXdP21CCGB9MSS1OzU1ILUIpgsEwenVAOj
        +JGmZ4uuzV7SXTylZ/c33dTuPvMph9SLJQWNX2i8cEia+39B/b8MzRl5dyVE1m20d1vyPC6R
        Mc5Td5q2nf+RG4dcP7AZCYrkmRZsnSevKqt3c8I9u5VfmDj279n3sDCg6PbLd18DX5sK/Qnc
        WZEu0Gqm/kjwxpyGV7ff1Lw96/pijS3DCzNuJZbijERDLeai4kQA8IsAzx8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsVy+t9jAd3ery8jDfYc57ToutLNZNHQe4XZ
        YvPtW4wWH2efYLH40dLD7MDq8ax3D6PHxUvKHn1bVjF6fN4kF8ASxWWTkpqTWZZapG+XwJXR
        enMxa8EMrooV29gaGDdzdDFyckgImEhcuPaHGcQWEtjJKLH3vHYXIxeQ/ZBRomPnVbCEsICd
        xL1nZ5lAbDYBPYnzvyawg9giAgYSLx6eB7OZBXIlju/9wATRvINJ4tSP/YwgCX4BLYnLP+aB
        DeIFGrR52W5WEJtFQFXi4/rrYHFRgQiJ583vWSFqBCV+TL7H0sXIwcEpYC8x8SEniMksoC4x
        ZUouxCpxiWP3bzJC2PISm9e8ZZ7AKDgLSfMshI5ZSDpmIelYwMiyilEytaA4Nz232KjAMC+1
        XK84Mbe4NC9dLzk/dxMjMOy3Hdbq28F4f0n8IUYBDkYlHt6Icy8ihVgTy4orcw8xSnAwK4nw
        dn16GSnEm5JYWZValB9fVJqTWnyIUZqDRUmc93besUghgfTEktTs1NSC1CKYLBMHp1QD46Zf
        kx+r+9zoeWjesuudSIuYuaH+h18M7+NmW9R9/SRyo+r4bbUfLHdPHNA6ueVc4JPayzV+L3Q/
        cTM7q0jd0M9cph4cE1Diali6u/uC4mutLdcLD9nNXl76QFKGSW0D99x3Nm5ZNSdnbo3POnrs
        RUDZ4XR15pMMS29ueL3qUOaHhEcZHz3+FCixFGckGmoxFxUnAgDvNkMbdwIAAA==
X-CMS-MailID: 20171020130933epcas1p4d0ba8c5be6e2570613185f71b1cea078
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
        <5fa1f5c6-249e-2aa9-5e9f-c00ebe2c0d9d@samsung.com>
        <20171019174452.hd3c47ocducddvgr@sigill.intra.peff.net>
        <c5f72436-df4e-5c51-d58b-8699dfcfd70c@samsung.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add check of the resolved HEAD reference while printing of a commit summary.
resolve_ref_unsafe() may return NULL pointer if underlying calls of lstat() or
open() fail in files_read_raw_ref().
Such situation can be caused by race: file becomes inaccessible to this moment.

Signed-off-by: Andrey Okoshkin <a.okoshkin@samsung.com>
---
Hello,
I think this way is better for user experience:
* git doesn't crash;
* warning is shown;
* commit has been successfully created then it's safe to show a summary message
with already known information and without resolved HEAD.

Best regards,
Andrey

 builtin/commit.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1a0da71a4..647d6ab3e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1483,7 +1483,10 @@ static void print_summary(const char *prefix, const struct object_id *oid,
 	diff_setup_done(&rev.diffopt);
 
 	head = resolve_ref_unsafe("HEAD", 0, junk_oid.hash, NULL);
-	if (!strcmp(head, "HEAD"))
+	if (!head) {
+		warning_errno(_("unable to resolve HEAD after creating commit"));
+		head = _("unresolvable HEAD");
+	} else if (!strcmp(head, "HEAD"))
 		head = _("detached HEAD");
 	else
 		skip_prefix(head, "refs/heads/", &head);
-- 
2.14.2
