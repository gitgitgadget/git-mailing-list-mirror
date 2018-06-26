Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E23F1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932074AbeFZHbE (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:31:04 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38400 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752716AbeFZHbC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:31:02 -0400
Received: by mail-it0-f66.google.com with SMTP id v83-v6so862010itc.3
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c41Z116KSDeQVjrbZlaK0kNrHcLLP5MHcZ4BtmYcLiM=;
        b=Tkh/7EYv408EvhXD/Y09zm8F6FZVhbW/O4VSbVfYcazoGroW4MzKcftjX3KVrcsuKy
         k1+isBDGeuHGKNexHOW1/v6X2BLlGAUq+DPuHzpG4M1QMI21+WyF3z9KXWMUC1Oc71QZ
         XbwrfOaJYctzOfkiAQUC3aUR/NSamDNmO31JqI8HFSLL0p062Dl4rRcBELptXqeUzAoi
         SQ3d+dbHEBxpC15LBf/HPN/dkoVxnEsTe9onnekHf2YKv04r7DAEtrZfQEsTxcRMqolR
         eqpIwcF4WS/gcQrlPkRCLduKQdNO78FUVNfJHBkR8bIcJ0UJUWODHRg2N7iGeo66UZSR
         E+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=c41Z116KSDeQVjrbZlaK0kNrHcLLP5MHcZ4BtmYcLiM=;
        b=VpSevSb7CqTS8upZOv0QKZjryHdw4rmGf+7uVpSt7+90ASAV45Zb2q96FvW+omeoQR
         +cIx1pmFHYNecUm5JmYDXA43i8iaA2xxJwuPtGs+QBLGjU5b9JdBpXuojAvqZDc9gCf+
         jbGhWYVyoG6WtVpoZudsEQ6BK2/8gdsofFo2BmUdz3jUBYssEtL6AWB6FUsX69X12nmj
         Ip5bLDtvxnKbYtnKJbs6HABTX9QJvtIQMhIXvZO0DuszVUtVta1W2wLwk/B7EIuCT5BN
         QSktR7tdNicuD0ThCMPBUhygxSWL/o1N9hVjMZL4ByXuHy8E08wi28VQ+gFS09O2ADMc
         U8mA==
X-Gm-Message-State: APt69E2AqFIay/PmeowAZrCOfvKwJBEoMXyRhoEOjVJi9JIdXAywyyOS
        8tfBD8WFxjIhVyOSst5n7YUq/g==
X-Google-Smtp-Source: ADUXVKKX3Dah7Up3HbJn5var6fi/zdMP/gSbBl9+UU54fgAdKoQwFyEd7M8Qy1/UqNrB3Z3DwaJtfA==
X-Received: by 2002:a24:243:: with SMTP id 64-v6mr513502itu.20.1529998261811;
        Tue, 26 Jun 2018 00:31:01 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.31.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:31:01 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 12/29] t9401: drop unnecessary nested subshell
Date:   Tue, 26 Jun 2018 03:29:44 -0400
Message-Id: <20180626073001.6555-13-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test employs an unnecessary nested subshell:

    (cd foo &&
     statement1 &&
     (cd bar &&
      statement2))

An upcoming change will teach --chain-lint to check the &&-chain in
subshells. The check works by performing textual transformations on the
test to link the subshell body directly into the parent's &&-chain. It
employs heuristics to identify the extent of a subshell, however,
closing two subshells on a single line like this will fool it.

Rather than extending the heuristics even further for this one-off case,
just drop the pointless nested subshell.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t9401-git-cvsserver-crlf.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index 84787eee9a..8b8d7ac34a 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -288,9 +288,9 @@ test_expect_success 'add bin (guess)' '
 test_expect_success 'remove files (guess)' '
     (cd cvswork &&
     GIT_CONFIG="$git_config" cvs -Q rm -f subdir/file.h &&
-    (cd subdir &&
+    cd subdir &&
     GIT_CONFIG="$git_config" cvs -Q rm -f withCr.bin
-    )) &&
+    ) &&
     marked_as cvswork/subdir withCr.bin -kb &&
     marked_as cvswork/subdir file.h ""
 '
-- 
2.18.0.419.gfe4b301394

