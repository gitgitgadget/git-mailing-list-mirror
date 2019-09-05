Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D37D1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 22:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbfIEWtG (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 18:49:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:33623 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730236AbfIEWtG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 18:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567723733;
        bh=SeMLqO86JoYG6v14vtoeMLSS93ntr0h4oFy0tBB+37g=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Qor1So1yERtvv3DStluZeuQJaZoOifr4PRriQSmiVue17F05mbFK/oL5bqsji6VqG
         de5o6w17wuMDpeKhCaBn/UvKIRvhsYzdNSLBXbZM/8uNDxjItRJB0e/e1Bk0jAPCnL
         JdRVM+vA+zLKS4oUDj90SgDXCli9Ch44QMilPgxY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([88.70.128.63]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MvbG2-1iPC4J2rri-00saOP; Fri, 06 Sep 2019 00:48:53 +0200
From:   Stephan Beyer <s-beyer@gmx.net>
To:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Shawn O. Pearce" <spearce@spearce.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
Subject: [PATCH v2 1/4] am: fail if no author line is given in --rebasing mode
Date:   Fri,  6 Sep 2019 00:48:30 +0200
Message-Id: <20190905224833.24913-1-s-beyer@gmx.net>
X-Mailer: git-send-email 2.23.0.43.g31ebfd7ae6.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BAZEHeAiGgGYpYbZwaeeFHP3E6Zah5UgiTRBi2qMQyrbVJgI5gd
 wCk+Czm9bU4e45sownegwnQrzlkQ1HKKA0Jd6EMGqoM7Ke+eRxr9bieywqq5wMxJ56xKBlM
 KHcgZlj8yC0V06uv1Ya/T5n0vDAxs4kAKS5MZ3atMkPXPTfvIMuGpD0MRSqjpHwYZtiFF1M
 KfDbZ1j1llTMV6CTsCRbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2nAg6GmvtNc=:6nK9jzCIAQE4HJfL7ZIyRP
 Cv9/T7JX6Q/wg8nv5ijKXg9lD4PfibFJAtIKxQMbJUSgXQrnCvsVqeBlrVPmziWNYHN/pjCNi
 GUug8cCdcrshty7AT3IJmTeW9DtGE5zFJhrhOEkewsDOQEDtLcG9dF8EKTzi6YQHeWRWX4X3F
 h2mJPKn2xFy3HgB4EkiiBNwM+hOpv9I5tn9lSumw/WPJo95Yft8krsI52hR8HIKRPHpMKrkvA
 5BxviEx07GsHAhHKqwUDVFh9n0NqBtwdRwI8cZfjbQS/dIGYohSwc6vMbXKhvTMMARWfHCosz
 QVsRWkQKp8ozHd+LKmijSEqgAvSCIBlIeDK1HE0Lz8+N4LR0GC03ciJRyv6UOnh6IsRLLrXZT
 +YW2dO2M+4ZEk78js5OQh3L213BTc9H0J2g5n2YWt6rv5N8q+julZscD9xGb3WxXh5KtoaXDT
 m1PQe1sBQdmN3+Pkd9UAFbB6fAimvce0h7IJ4uPlo5CTJSF7qQq+AVfON7qVAT4ypoPDlx5AJ
 xUoeW6cXtKQE/nkULmeD08MmhL1RGBoDr7diigZ+jUKAreh+Du1q32816TwsL4c2pwwfkOQtP
 xHo4tZ5q47RtMT3nfYO+pAjsuYgKe7zxVZjAzxX0axWxcrMJ/PKpvczy6bZ0Hkl7zA2TxPQ+n
 refp8p0QVw57gdAoOTIyD9ucqlIgXtbn7/oZFGUH2/UfSwWnIIpkUbBOZxeE7quKMh2GISJGB
 6b82clHIObo+RMoL8ja7of/GrJCG1EaNoJqC6E7oZzEDOicZnKZ7K2nCjFVQXcreruZYmsZRw
 4lP+9czEouA+TNrbxd0SNKAeOTbisTkRusewmy1X25t8Mhvo/PRFc51psSVrNlOdUMYlGTBhP
 OM/uyS4dV0YzeIrjWENUuwt5hjhL9i3xbV3qlBmWofOSaWlBbEjaPN/ANfjvlOJMAVhjwTREd
 6/MV+BdNPLEqTGVVYbIyWjWdW+cEhXl0/9jlc6vF09tBBDUkwoB8f1HWI3YqmxMAJH0MGpRdp
 PWkLQ3x4U1QbPeGBVyO2qpPkujTubzDhjFC3dTH9JYp8csw4mkOIi3vkUhOclwMbikK9ExHtk
 KMGmT2ZFSn9stnh875w+DEfJ5g/B97SY+F+x3I/oulWhfbp+hMIoPHjmRlt6+Vm2UPMuxUpXD
 /L+wFYD6QTWQHGxss7PcuFT3aum+iFzf2qTJifAFWKRDrohHS3Q0eVbxmjGEjxpnWzSn8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This prevents a potential segmentation fault.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
=2D--
 builtin/am.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1aea657a7f..71da34913c 100644
=2D-- a/builtin/am.c
+++ b/builtin/am.c
@@ -1272,7 +1272,8 @@ static void get_commit_info(struct am_state *state, =
struct commit *commit)
 	buffer =3D logmsg_reencode(commit, NULL, get_commit_output_encoding());

 	ident_line =3D find_commit_header(buffer, "author", &ident_len);
-
+	if (!ident_line)
+		die(_("no author line"));
 	if (split_ident_line(&id, ident_line, ident_len) < 0)
 		die(_("invalid ident line: %.*s"), (int)ident_len, ident_line);

=2D-
2.23.0.43.g31ebfd7ae6.dirty

