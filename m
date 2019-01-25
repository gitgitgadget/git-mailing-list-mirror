Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 980DB1F453
	for <e@80x24.org>; Fri, 25 Jan 2019 12:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfAYMZb (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 07:25:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37949 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfAYMZb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 07:25:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so6495471wml.3
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 04:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RntaxFzSTfgN+b4i7aBLI5MbnxGnkuCE9exntM5LjhA=;
        b=KX8C2oAOH1kcMMfxdtbhDHmWe9tVDt5F1CtkFVOKDXMBBK+W/SLVanIH9k13V02saj
         oQrOy/z9jIKSNd8edoV7wL5aObOCdFlWdInBPJpH4HMJRyWvJsxDyohNZtEOPZE83VHt
         8p8m1cCON4Fn2+GXIEL/J0MwB2QF8cLe3IJRb34H6NvdI0qqQpXYrH5VCV5OE72ogwrp
         t1Z+07I7thKh0GvNrZg0/nrxNyDCy9xDiqmplcNrKQqNjkA/34FrojIb2Gp8sEaY4qPn
         pM536RESfepsnohbgY5L7iIoD8cu6GBVHCW3Uo8ZlW99k1x656F3raC3fbUtStQeVfDT
         X2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RntaxFzSTfgN+b4i7aBLI5MbnxGnkuCE9exntM5LjhA=;
        b=Ur8K8vBeWu/RFCGZzuNUhVeIFMR+08h6vOIC8yL0G7onNuIThwkK/AgiHKGXk0pzKU
         hqiLQKp/0d7DTo4d9h+vyb2EJEZTnwb9noJWSTZ8jLFWXTNFKPj5IwWWrA6SP+Dtawyb
         hb2wCxaQIHWyqC0rEFyCzBO95KoJJXmn30+UpjpI6wvHFzG3UE63knxZSas9S4Rsoi85
         NPORyeH8FXUfdX7d6SgNrxKiPtFiY6D3Nl0706caOIaEnSOlxzsPW5mly0WZ2BjEjZvr
         lm2YMpDQ3K1Ys+lG1/32/lP71hCpNzewk++fc6kAlqqL2h7G7YA/YE5l9+CXbZYHekL/
         YrCQ==
X-Gm-Message-State: AJcUukdh6BEqcSnzkAfgp9QoQsZMDdM4b23cklJgzrfm0BVVC3vYHQbF
        gPlMXlpfiIY6QQKgu7AcfDc=
X-Google-Smtp-Source: ALg8bN6nPqOyDgjUdvG7uQAtP+u4nmPH+ztSE74Qj52/Y5/j6XUGgQ2Ywb97hKRchJ3PsH6rlmQIEA==
X-Received: by 2002:a1c:5fd7:: with SMTP id t206mr7049269wmb.145.1548419129037;
        Fri, 25 Jan 2019 04:25:29 -0800 (PST)
Received: from localhost.localdomain (x4db9b7c2.dyn.telefonica.de. [77.185.183.194])
        by smtp.gmail.com with ESMTPSA id o8sm102973136wrx.15.2019.01.25.04.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Jan 2019 04:25:28 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] strbuf.cocci: suggest strbuf_addbuf() to add one strbuf to an other
Date:   Fri, 25 Jan 2019 13:25:17 +0100
Message-Id: <20190125122517.29026-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.642.gc55a771460
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The best way to add one strbuf to an other is via:

  strbuf_addbuf(&sb, &sb2);

This is a bit more idiomatic and efficient than:

  strbuf_addstr(&sb, sb2.buf);

because the size of the second strbuf is known and thus it can spare a
strlen() call, and much more so than:

  strbuf_addf(&sb, "%s", sb2.buf);

because it can spare the whole vsnprintf() formatting magic.

Add new semantic patches to 'contrib/coccinelle/strbuf.cocci' to catch
these undesired patterns and to suggest strbuf_addbuf() instead.

Luckily, our codebase is already clean from any such undesired
patterns (but one of the in-flight topics just tried to sneak in such
a strbuf_addf() call).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Inspired by:

  https://public-inbox.org/git/20190125112203.GB6702@szeder.dev/

 contrib/coccinelle/strbuf.cocci | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf.cocci
index e34eada1ad..d9ada69b43 100644
--- a/contrib/coccinelle/strbuf.cocci
+++ b/contrib/coccinelle/strbuf.cocci
@@ -12,6 +12,36 @@ constant fmt !~ "%";
 )
   );
 
+@@
+expression E;
+struct strbuf SB;
+format F =~ "s";
+@@
+- strbuf_addf(E, "%@F@", SB.buf);
++ strbuf_addbuf(E, &SB);
+
+@@
+expression E;
+struct strbuf *SBP;
+format F =~ "s";
+@@
+- strbuf_addf(E, "%@F@", SBP->buf);
++ strbuf_addbuf(E, SBP);
+
+@@
+expression E;
+struct strbuf SB;
+@@
+- strbuf_addstr(E, SB.buf);
++ strbuf_addbuf(E, &SB);
+
+@@
+expression E;
+struct strbuf *SBP;
+@@
+- strbuf_addstr(E, SBP->buf);
++ strbuf_addbuf(E, SBP);
+
 @@
 expression E1, E2;
 format F =~ "s";
-- 
2.20.1.642.gc55a771460

