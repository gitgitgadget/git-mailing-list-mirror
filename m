Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BABF20756
	for <e@80x24.org>; Wed,  4 Jan 2017 22:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968478AbdADWBn (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 17:01:43 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34271 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968470AbdADWBl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 17:01:41 -0500
Received: by mail-pg0-f45.google.com with SMTP id y62so179669322pgy.1
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 14:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JNL8Ckz7ToGu3SqbTrYV0aZ7CrEB8bMUhYcvQVKjqhs=;
        b=El/PFi7PdUElGCr2Ic2k/EBBPjVBLUlNqCEcZ7HE6RxGprGeQ1uYqbVoK8Vv6dMz2d
         hvVF9EUjlqIVtH9sOdLIc90m3XDwJGClcQZ7kPF3jPdAP08u4rzJVE/M2OgGW1iOi9il
         xnIQcv01v6jqYSqxKH+DydRRJnaqIHEbOjBXRqMI7LCr4gUXZw5or8H6PqU6251clVRj
         AjmxIseHZfWkRqJ7potCG+YlHd7uwf4OliMyRCkeTNmaiTL3FaPwlsYOOrhwPHDTjm03
         6LeOEQKdPFHIMYYMWiHje5Z8qOd+Gh+ogMDDys0SjNCufDSb7+uhSWKnwMhyuR6HQ3T2
         AqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JNL8Ckz7ToGu3SqbTrYV0aZ7CrEB8bMUhYcvQVKjqhs=;
        b=bKnAmxIXMJHaZr+x0mMNbGVrpCTcYCZE6OTIDf/IBFIBZaM1+QnRWIS9eGBGu+dBxZ
         BT+oJALL6X+2Zae6NzFQFt4Ue3ucCj0xeG6NvvePkOa1o4Y5hUrmpBtmS0wyYbXU2/7X
         l0iOSVryDdPpwYcgnTtO/EwVYVCuqCTdHjx7WUIXaVbMT6PVYQmhZQxi6b8KhnTGKVmE
         002e2ecpeRD1i965hz5AiLsE+sHugv6mpnn6Hcd6RTk2+XM2xuQae0Fqn2n3mmcKfYb+
         SeYlBqIx7p+WeP6H5z0HeL71Fo5FDMtAT5o0Y5qiPnyOO9T19QU+eKTxIiXD/ZqwsP85
         t1jA==
X-Gm-Message-State: AIkVDXI4x59BBuFqe6GWC+wvd0oSZe1yJd6Dw4Z1b39qXgH84p2R92vrUX1HoNNw8+eoDJQq
X-Received: by 10.84.202.12 with SMTP id w12mr151622205pld.156.1483567296990;
        Wed, 04 Jan 2017 14:01:36 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id n29sm550351pfg.80.2017.01.04.14.01.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 14:01:35 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, j6t@kdbg.org,
        pclouds@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v5 3/5] real_path: create real_pathdup
Date:   Wed,  4 Jan 2017 14:01:22 -0800
Message-Id: <20170104220124.145808-4-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170104220124.145808-1-bmwill@google.com>
References: <20170103190923.11882-1-bmwill@google.com>
 <20170104220124.145808-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create real_pathdup which returns a caller owned string of the resolved
realpath based on the provide path.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 abspath.c | 13 +++++++++++++
 cache.h   |  1 +
 2 files changed, 14 insertions(+)

diff --git a/abspath.c b/abspath.c
index a200d4220..72f716f80 100644
--- a/abspath.c
+++ b/abspath.c
@@ -209,6 +209,19 @@ const char *real_path_if_valid(const char *path)
 	return strbuf_realpath(&realpath, path, 0);
 }
 
+char *real_pathdup(const char *path)
+{
+	struct strbuf realpath = STRBUF_INIT;
+	char *retval = NULL;
+
+	if (strbuf_realpath(&realpath, path, 0))
+		retval = strbuf_detach(&realpath, NULL);
+
+	strbuf_release(&realpath);
+
+	return retval;
+}
+
 /*
  * Use this to get an absolute path from a relative one. If you want
  * to resolve links, you should use real_path.
diff --git a/cache.h b/cache.h
index 7a8129403..e12a5d912 100644
--- a/cache.h
+++ b/cache.h
@@ -1068,6 +1068,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 		      int die_on_error);
 const char *real_path(const char *path);
 const char *real_path_if_valid(const char *path);
+char *real_pathdup(const char *path);
 const char *absolute_path(const char *path);
 const char *remove_leading_path(const char *in, const char *prefix);
 const char *relative_path(const char *in, const char *prefix, struct strbuf *sb);
-- 
2.11.0.390.gc69c2f50cf-goog

