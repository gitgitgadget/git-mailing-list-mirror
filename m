Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3A5E1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932443AbeFZHdF (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:33:05 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:45778 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752706AbeFZHbB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:31:01 -0400
Received: by mail-io0-f196.google.com with SMTP id l25-v6so14978714ioh.12
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5K79rZg56VEXZEOmQRHi0+QbwdDqdCEB0JH27wID0R8=;
        b=cX4vLtLBKy382fI30nxqkXu3lxfziwI4Br++GR3cxdiJVBI98E+0eE6yMb++yYeNNf
         JzzEHOGls+9MWrWlxti39R/NBVLTP+Dlf10Edm3PYK3iYnMu3JxMbqY/2YxtRXAv0Okz
         s6ASDytHnzDpfXfN9E9N3jXnYkjku9fKWj92L67NtdikmJ8xfRDK2DmYR9VaArudrTq8
         1Hv79XEL+U7uzq4HSen62QXRnIoa2exxH07WzvozLPPr+G7J5TsYpCUXne94mNEpYagb
         G9Tw0PxYGwEt+qlFiyHZmU9ZLCz0IFZ1y9Csuph+PPp95jmKJfyntCTs+j/KGosueqC3
         9uQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=5K79rZg56VEXZEOmQRHi0+QbwdDqdCEB0JH27wID0R8=;
        b=iEsgesiewquPFBbG900PwPsOq6j73nhi0A9iI1FrR3oHFgi83gI8kvcnwJYWsUIKoN
         JrR1UJZoBI+W0axInv9g4ZPbrKyjqwsL9jtTcMktChp3ovXocCSkHOJM0Da8LVf51lUX
         0IxwGAxy99hBwh1pdBg3mHcsc8VaBiNvvaGE56PGhKlg8lNoV7DX5hOutLlRbF6qd+R6
         aU08V+f0byvaRWYYVqVTRXxSAWB4NFMLEe6raSQtyif+HiVxBufWm13ToJIelpA4w1Oi
         aZeQUGBhdz5j0z22Qyp6hLkoi6NG5t5hmLdM9D4VRxAcbmqebt8PJnr1rAMMPj3L+4Nd
         JUPw==
X-Gm-Message-State: APt69E1J7LrXVb7glgmNZYKE7lKzM6GvpwT2I5FbR3PzVCvgaCZMcaCa
        Xu6ZkmDqiRAECZsRlUuh2zy6Zw==
X-Google-Smtp-Source: AAOMgpdP+DX74vZk00ns+/sUkjshy49LBSOq6UvVoHUZKC6aFu0iGFhnNy530/P7OkAXcVegYlvsWQ==
X-Received: by 2002:a6b:6315:: with SMTP id p21-v6mr308529iog.72.1529998260877;
        Tue, 26 Jun 2018 00:31:00 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.31.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:31:00 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 11/29] t9104: use "{...}" block around "||" expression rather than subshell
Date:   Tue, 26 Jun 2018 03:29:43 -0400
Message-Id: <20180626073001.6555-12-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test uses "(... || svn ...)" as a shorthand for an if-then-else
statement. The subshell prevents it from breaking the top-level
&&-chain.

However, an upcoming change will teach --chain-lint to check the
&&-chain inside subshells. Although it takes special care to allow
"||" inside subshells, it only recognizes "(... || git ...)" and
"(... || test*), so the "||" in this test will trip up --chain-lint.

A test later in this same script employs the same "... || svn ..."
construct, however, it wraps it in a "{...}" block instead of a
subshell. Therefore, rather than adding "(... || svn ...)" as a yet
another --chain-lint special case, follow suit and make this test use
"{...}", as well.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t9104-git-svn-follow-parent.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index 5e0ad19177..f9aa734d4e 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -53,10 +53,10 @@ test_expect_success 'init and fetch from one svn-remote' '
         '
 
 test_expect_success 'follow deleted parent' '
-        (svn_cmd cp -m "resurrecting trunk as junk" \
+	{ svn_cmd cp -m "resurrecting trunk as junk" \
                "$svnrepo"/trunk@2 "$svnrepo"/junk ||
          svn cp -m "resurrecting trunk as junk" \
-               -r2 "$svnrepo"/trunk "$svnrepo"/junk) &&
+		-r2 "$svnrepo"/trunk "$svnrepo"/junk; } &&
         git config --add svn-remote.svn.fetch \
           junk:refs/remotes/svn/junk &&
         git svn fetch -i svn/thunk &&
-- 
2.18.0.419.gfe4b301394

