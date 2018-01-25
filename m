Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5917C1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 23:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbeAYX7q (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:59:46 -0500
Received: from mail-oi0-f74.google.com ([209.85.218.74]:42339 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbeAYX7p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:59:45 -0500
Received: by mail-oi0-f74.google.com with SMTP id r141so5369794oie.9
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=p96gjuA9cyaqjqNznzr1EvNbGzeIZmSzN2fz+eduiQc=;
        b=cJWkt3dP5+J08CXAL9J3+3fc5cR5c2r5Z/ASxoqDaIlj8yZ6/N/uTRYMUtMqPFhBYl
         j6NI9xJS57nCIqYfYgwEnIN9lJh5pOzei3Q7KgJXHzxhk2gzBLO92SJG8JBsqn8CNu/6
         HV3Q5Zh4PkdMN52XaPq/Lw2u30No8vqyrxiFIx4jSzTIA3Awmx/32AF4SL1H2MLweAXW
         8KINVKLJiPI664KRyVla97oeSulb52WXxwv+5kWx9TcQ02uhTvmBi/mpwrMaWpoowQ4R
         KtZKZHticfIIjK22MNBPVYVncf6MwAkPyns3/NyWZzLrzch8XSCyatvBf8wGDLGbzvcP
         FgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=p96gjuA9cyaqjqNznzr1EvNbGzeIZmSzN2fz+eduiQc=;
        b=C1jyuhj9R0oS6TBvOJy0u8rYIZhRKDJt2PbMpMtjLyjEX5LJuKClP/fZUevII7aVA+
         GdckW2RXHMxyZ0MDb4PMBiOS2tEQUQFu57vPZesgJ56j8gwT+MFvLJQOL6CSKaknYHG6
         A7MfUlvvvIL79iuTSsWtey/gk5hD47W4YXgnPqwfw3nyT5ud7VGBRUOqmNEXKIS/VJvs
         Kn5V4B4LUkrcRsigSwzXFjwrqdRmD+uNz1q4fjSxTX/ZDVJPZiIkwy6/MWfgtBk9nixR
         52lGY9xFIJakQFZdKURhsT+Bfqni/6C2Kw4H1CT260E966eKS+21qb7yWkrIFZPkyBxE
         hB1w==
X-Gm-Message-State: AKwxyteNQ+QspbDzycoYjRQcaUFsxXhGlWdjaOnJ0TOEWIDZKvRjk0Dt
        ERsOZDMsB/uz491fWIVPLWDwRYB7cnYCJ2QgDAycHFr8IzDyjvLKp9mIFCDSXxXQnuQX26VnZsZ
        AKoDsyxrLxs3juLgp81NQ2K4jIBna0G1r97AppA9f2g1g/rXq2VkoAqrOng==
X-Google-Smtp-Source: AH8x2260I8x6qz2NLkiMG9Se1XFf+5AXHw22kJNQGNdT0ofyZY4rQNOhgc5xb/OZo2aqKPhp6gRIGK5ecuQ=
MIME-Version: 1.0
X-Received: by 10.157.47.202 with SMTP id b10mr11663955otd.25.1516924784513;
 Thu, 25 Jan 2018 15:59:44 -0800 (PST)
Date:   Thu, 25 Jan 2018 15:58:37 -0800
In-Reply-To: <20180125235838.138135-1-bmwill@google.com>
Message-Id: <20180125235838.138135-27-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180125235838.138135-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v2 26/27] remote-curl: create copy of the service name
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make a copy of the service name being requested instead of relying on
the buffer pointed to by the passed in 'const char *' to remain
unchanged.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 remote-curl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index dae8a4a48..4086aa733 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -165,7 +165,7 @@ static int set_option(const char *name, const char *value)
 }
 
 struct discovery {
-	const char *service;
+	char *service;
 	char *buf_alloc;
 	char *buf;
 	size_t len;
@@ -257,6 +257,7 @@ static void free_discovery(struct discovery *d)
 		free(d->shallow.oid);
 		free(d->buf_alloc);
 		free_refs(d->refs);
+		free(d->service);
 		free(d);
 	}
 }
@@ -343,7 +344,7 @@ static struct discovery *discover_refs(const char *service, int for_push)
 		warning(_("redirecting to %s"), url.buf);
 
 	last= xcalloc(1, sizeof(*last_discovery));
-	last->service = service;
+	last->service = xstrdup(service);
 	last->buf_alloc = strbuf_detach(&buffer, &last->len);
 	last->buf = last->buf_alloc;
 
-- 
2.16.0.rc1.238.g530d649a79-goog

