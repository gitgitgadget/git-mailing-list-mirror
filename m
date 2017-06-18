Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F01B520401
	for <e@80x24.org>; Sun, 18 Jun 2017 13:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753158AbdFRNj5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 09:39:57 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:53882 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753145AbdFRNj4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Jun 2017 09:39:56 -0400
X-AuditID: 1207440f-33bff7000000102d-89-594682a730c5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id E3.71.04141.7A286495; Sun, 18 Jun 2017 09:39:53 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE99B.dip0.t-ipconnect.de [84.170.233.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5IDdj8g017544
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 18 Jun 2017 09:39:47 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=98yvind=20Holm?= <sunny@sunbase.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 0/2] Fix a refname trimming problem in `log --bisect`
Date:   Sun, 18 Jun 2017 15:39:40 +0200
Message-Id: <cover.1497792827.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqLuyyS3S4NIrcYu1z+4wWTxff4Ld
        outKN5NFQ+8VZosnc+8yW9xeMZ/ZYsnD18wW3VPeMlr8aOlhtti8uZ3FYsKRFSwWj/resjvw
        ePx9/4HJY+esu+weCzaVejx81cXucWLGbxaPrvYjbB7Pevcwely8pOxxd0IPi8fnTXIBXFFc
        NimpOZllqUX6dglcGVfX3mUs2MNecefVU/YGxiOsXYycHBICJhKXrn5hB7GFBHYwSdz9JNDF
        yAVkn2KSWLrgAQtIgk1AV2JRTzMTiC0ioCYxse0QC0gRs8AyFomuM78YQRLCAh4Su67PB5vE
        IqAq8btrCRuIzStgLjH19G2obfISu9ousk5g5FrAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1
        SNdELzezRC81pXQTIyQA+Xcwdq2XOcQowMGoxMP7ot01Uog1say4MvcQoyQHk5Io7ydZt0gh
        vqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrzdnkA53pTEyqrUonyYlDQHi5I4r/oSdT8hgfTEktTs
        1NSC1CKYrAwHh5IE75ZGoEbBotT01Iq0zJwShDQTByfIcB6g4dK1IMOLCxJzizPTIfKnGHU5
        mj5s+cIkxJKXn5cqJc7LB4x9IQGQoozSPLg5sMTxilEc6C1h3kMg63iASQdu0iugJUxAS5jP
        uIAsKUlESEk1MKaKc5x40R/c8jaxtsnveunva/tmG5/9qvl07gvl+1Nm3X3JfcKHf3rWhowl
        ru0N05rbzVkDq0ysc6epSYVPWjOt+E34Rj7zye5X9mywV1MW2/Vk05bJngdOyt3uvPeJu9Fq
        uzHPTCa2GaZcSv+TYpZc9MloCOnYsq7cw+/hxxPR9pw3tasnGiqxFGckGmoxFxUnAgBUGaMs
        9wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is v2 of these patches. Thanks to Peff and Junio for their
feedback about v1 [1].

Changes since v1:

* Added a test and tweaked the commit message of the first patch.

As before, the second patch is optional. If it is omitted, it might
flush out any other bugs like this one in client code. If it is
included, regressions are less likely, but we won't learn about other
misuses of the API. I have no strong opinion either way.

Michael

[1] http://public-inbox.org/git/cover.1497430232.git.mhagger@alum.mit.edu/

Michael Haggerty (2):
  for_each_bisect_ref(): don't trim refnames
  prefix_ref_iterator_advance(): relax the check of trim length

 refs.c                     | 12 ++++++++++++
 refs.h                     |  5 ++++-
 refs/iterator.c            |  8 ++++----
 revision.c                 |  2 +-
 t/t6002-rev-list-bisect.sh | 14 ++++++++++++++
 5 files changed, 35 insertions(+), 6 deletions(-)

-- 
2.11.0

