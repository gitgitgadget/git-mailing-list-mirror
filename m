Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BB1720A93
	for <e@80x24.org>; Fri,  6 Jan 2017 16:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967262AbdAFQXI (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 11:23:08 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:48251 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965034AbdAFQXH (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 11:23:07 -0500
X-AuditID: 12074414-773ff70000004a85-a0-586fc45f4f70
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 0F.DF.19077.F54CF685; Fri,  6 Jan 2017 11:22:57 -0500 (EST)
Received: from bagpipes.fritz.box (p57906F4E.dip0.t-ipconnect.de [87.144.111.78])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v06GMmWq023262
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 6 Jan 2017 11:22:54 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 02/23] refname_is_safe(): correct docstring
Date:   Fri,  6 Jan 2017 17:22:22 +0100
Message-Id: <bda5573d25412123683c36c2ea6669aa6f380c61.1483719289.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483719289.git.mhagger@alum.mit.edu>
References: <cover.1483719289.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsUixO6iqJt4JD/CYOEKDYuuK91MFg29V5gt
        di/uZ7a4vWI+s8WSh6+ZLX609DBbdE6VdWD3+Pv+A5PHzll32T2WL13H6NHVfoTN41nvHkaP
        i5eUPT5vkgtgj+KySUnNySxLLdK3S+DKmDPzIGPBd56K77dmsDUw7uHqYuTkkBAwkbh94z9b
        FyMXh5DAZUaJx9/uM0I4J5gkTi99xwxSxSagK7Gop5kJxBYRUJOY2HaIBaSIWeADo8Svzlns
        IAlhATuJrRtXgzWwCKhKLO7dzwJi8wpESUz7vIkRYp2cxKVtX8BqOAUsJBp3fQOLCwmYS3ya
        eJh5AiPPAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Fnq5mSV6qSmlmxghISayg/HISblD
        jAIcjEo8vBFeeRFCrIllxZW5hxglOZiURHnDHPMjhPiS8lMqMxKLM+KLSnNSiw8xSnAwK4nw
        2h0CyvGmJFZWpRblw6SkOViUxHm/LVb3ExJITyxJzU5NLUgtgsnKcHAoSfA2HgZqFCxKTU+t
        SMvMKUFIM3FwggznARreAVLDW1yQmFucmQ6RP8WoKCXOuwVkqwBIIqM0D64XlgJeMYoDvSLM
        2wPSzgNMH3Ddr4AGMwENFvQEG1ySiJCSamCUmX/jdrb5i0J5p/Cif3PvuUdI/G2dWcTs4T3h
        8copuZcuHjE3fHNWb2/u2w+JoRsYS3cZ266Uc4xV3f7wwZ5n1VctPRXzrtXvkRb899X/r/Me
        ptvsOasflBiqGz4WezxhzvS6H04pN/c23DpzIr+N3+vd5EcNumLxz+2nT5H56/JtHpOi9OFE
        JZbijERDLeai4kQAlHkkhdwCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The behavior of refname_is_safe() was changed in

    e40f355 "refname_is_safe(): insist that the refname already be normalized", 2016-04-27

without a corresponding update to its docstring. The function is in fact
stricter than documented, because it now insists that the result of
normalizing the part of a refname following "refs/" is identical to that
part of the original refname. Fix the docstring.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/refs-internal.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 708b260..dc81acc 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -62,11 +62,12 @@
  * This function does not check that the reference name is legal; for
  * that, use check_refname_format().
  *
- * We consider a refname that starts with "refs/" to be safe as long
- * as any ".." components that it might contain do not escape "refs/".
- * Names that do not start with "refs/" are considered safe iff they
- * consist entirely of upper case characters and '_' (like "HEAD" and
- * "MERGE_HEAD" but not "config" or "FOO/BAR").
+ * A refname that starts with "refs/" is considered safe iff it
+ * doesn't contain any "." or ".." components or consecutive '/'
+ * characters, end with '/', or (on Windows) contain any '\'
+ * characters. Names that do not start with "refs/" are considered
+ * safe iff they consist entirely of upper case characters and '_'
+ * (like "HEAD" and "MERGE_HEAD" but not "config" or "FOO/BAR").
  */
 int refname_is_safe(const char *refname);
 
-- 
2.9.3

