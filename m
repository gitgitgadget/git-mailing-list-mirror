Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5402B20467
	for <e@80x24.org>; Mon, 16 Oct 2017 17:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754256AbdJPRzt (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 13:55:49 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:51371 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753676AbdJPRzr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 13:55:47 -0400
Received: by mail-it0-f49.google.com with SMTP id o135so2153953itb.0
        for <git@vger.kernel.org>; Mon, 16 Oct 2017 10:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wnnkOhs4Nd1+uMIAxAffcElUEPuhpm6Abd2Hg/4peHY=;
        b=ZKL/dyKKOb4fwU4u1mQaQ9/7/A9J77LvrOTUzuIBioi/PObAiOAcD3Iw5AD+XwHVGx
         ctoHRu6aJH/pIETzi0IsXGcjCkMPeqflvK76Rl1HDsrMqR+5u1awkZoAZZYt34lv5d5w
         PfgX5W1XjvyGekYPtgz2z30yxVa9JpsUITuET0hJ8KNrErVzuV1i8QzyzakGsP5JHCMh
         0e164A8lwlrlgO53KwukoDMo7yYc5JfRkfixkEZxdJ/DhvDlxCZ3qn1rwKBNdHAJIfGr
         XCRoGDJ21YxKd5TYvi739E4eEeE0eosXcbXU9C3HPYGy6slcoKUZtWIl/zpSjXILKqCL
         0lvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wnnkOhs4Nd1+uMIAxAffcElUEPuhpm6Abd2Hg/4peHY=;
        b=cl2MGb4G8oYlFBit7wLxG0iheQBklSdV8FsaDA7CeKliMrl2FZvM8PZEltZxZ1PneP
         IQTU8ZGceYkJ7ABtorO2w2AVTzwxW9ltmXbDPzTTVSjfNoalt0CcCEfZOAYWlypaXUst
         VM/uTculzQ75lVApKdhOfE6DN2jqq80K1tvUKhYFSY8uB0B19QKN8K0M8g/N3FJVWBNF
         1aJ1LuTrWVF3orIR0B4QfiubRgaHFA171gNQRvUeMxRLnK2jbZqocEqBRz137xDaLbzm
         VyzIDJ0HFdH507EHpVZoV6GPpaspaTsgfsPYQcnmYcGgSjQ0w3Lze64S4X8qR94ommXY
         NJ3A==
X-Gm-Message-State: AMCzsaUyl8bpQlXs9uB4D/i3bUNTsAuJYs5+y5o3gTvGNFBFItPZtMxR
        ojlO9rwudc52KqxtzV/ZrnS0I9zJOeA=
X-Google-Smtp-Source: ABhQp+RP0IvAgQya8n6KRemHQd+FAruWNaodW+tu4aKagtk8Je5RVYgtERsNHdNJYyyPJ38K4MUcUA==
X-Received: by 10.36.107.132 with SMTP id v126mr2092877itc.43.1508176546038;
        Mon, 16 Oct 2017 10:55:46 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s74sm3813071ita.21.2017.10.16.10.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Oct 2017 10:55:44 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     martin.agren@gmail.com, simon@ruderich.org, bturner@atlassian.com,
        git@jeffhostetler.com, gitster@pobox.com, jonathantanmy@google.com,
        jrnieder@gmail.com, peff@peff.net, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 02/11] pkt-line: add packet_write function
Date:   Mon, 16 Oct 2017 10:55:23 -0700
Message-Id: <20171016175532.73459-3-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc-goog
In-Reply-To: <20171016175532.73459-1-bmwill@google.com>
References: <20171003201507.3589-1-bmwill@google.com>
 <20171016175532.73459-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a function which can be used to write the contents of an arbitrary
buffer.  This makes it easy to build up data in a buffer before writing
the packet instead of formatting the entire contents of the packet using
'packet_write_fmt()'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pkt-line.c | 6 ++++++
 pkt-line.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/pkt-line.c b/pkt-line.c
index 647bbd3bc..7006b3587 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -188,6 +188,12 @@ static int packet_write_gently(const int fd_out, const char *buf, size_t size)
 	return 0;
 }
 
+void packet_write(int fd_out, const char *buf, size_t size)
+{
+	if (packet_write_gently(fd_out, buf, size))
+		die_errno("packet write failed");
+}
+
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 {
 	va_list args;
diff --git a/pkt-line.h b/pkt-line.h
index 66ef610fc..3dad583e2 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -22,6 +22,7 @@
 void packet_flush(int fd);
 void packet_write_fmt(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 void packet_buf_flush(struct strbuf *buf);
+void packet_write(int fd_out, const char *buf, size_t size);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
-- 
2.15.0.rc0.271.g36b669edcc-goog

