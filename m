Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E5C82018B
	for <e@80x24.org>; Tue, 28 Jun 2016 17:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbcF1Rp2 (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 13:45:28 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:32788 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360AbcF1RpY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 13:45:24 -0400
Received: by mail-lf0-f66.google.com with SMTP id l188so2515147lfe.0
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 10:45:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CRbsAbIEyAOJ35jeGi9H+61mymWN3hNIc/cBjfz3rM4=;
        b=mi78fpHb0qXlScUwucEUNmJzZEvRk343QsRammbFGTCKi4RF4M6ikrUilQNP8B3tCd
         K4Dd+4eACG5mveL7gWe+/PT0poyFtjJh9YkX59XwJMlqUi2gqIpHb4tPEUlJwBZrgfY9
         3L+FpquUZJAyPm3b8DAjHk+ogeptHpHBYiU/hQDSpbBpSUXK4CVssmtIr5VUcSoEgxcX
         w8nxfNBZDfeKDuQMgzgMnuVZOl9ApGRFLk1k63HQApbzAjUK9TPk5x1Qn9PYbouYFyFK
         /vSLzhIFQmflBfrKuYWxKbjC6TglnCqcqbTYqt5EF+ngdJNb0GnkdTPxxuvEHS5ZPQrt
         7BCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CRbsAbIEyAOJ35jeGi9H+61mymWN3hNIc/cBjfz3rM4=;
        b=Ki/Vv3nDBmJqL+WgY13UwTDI9MGlVf9jVP7OzJDBhO12tn7LqMIVxjEg/Oyce6IWPV
         HINrVoaLw3OY3vRcGP157BL13Ba9sOnQp9gxJFssX9cCnFTDM8CyRjnadT+ig2N9kFfU
         869DZb83UjWxNwn95sMsEO9/XGrFWy6hcVIk9dOVdBjVdb+IbumfogY+PjSZGxHj1sxn
         Q8RKMCjJ9dwqKWFYVHXuY1VugoRJtCJAmUGlrpiGT0ASu5Vd/81y1RSdFirO0Zgq3fws
         j11wqW+mc+KqMiKqZlpPQ+KApGG+HWEIBWjW7lvoQZ91osItWrzng01yMn37b7/FRCgd
         WzSg==
X-Gm-Message-State: ALyK8tKbnSDxOEpetGQXUQ1aXT5OfqAlRlch5s2lVqxjrPAdKoMmdzvDNVL/RWKfXYIS2Q==
X-Received: by 10.25.40.8 with SMTP id o8mr1435440lfo.22.1467134810573;
        Tue, 28 Jun 2016 10:26:50 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 73sm4409435ljf.8.2016.06.28.10.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jun 2016 10:26:49 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	sschuberth@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/2] add skip_prefix_mem helper
Date:	Tue, 28 Jun 2016 19:26:40 +0200
Message-Id: <20160628172641.26381-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.531.gd073806
In-Reply-To: <20160628172641.26381-1-pclouds@gmail.com>
References: <20160626070617.30211-1-pclouds@gmail.com>
 <20160628172641.26381-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jeff King <peff@peff.net>

The skip_prefix function has been very useful for
simplifying pointer arithmetic and avoiding repeated magic
numbers, but we have no equivalent for length-limited
buffers. So we're stuck with:

  if (3 <= len && skip_prefix(buf, "foo", &buf))
	  len -= 3;

That's not that complicated, but it needs to use magic
numbers for the length of the prefix (or else write out
strlen("foo"), repeating the string). By using a helper, we
can get the string length behind the scenes (and often at
compile time for string literals).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 git-compat-util.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 49d4029..c99cddc 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -473,6 +473,23 @@ static inline int skip_prefix(const char *str, const char *prefix,
 	return 0;
 }
 
+/*
+ * Like skip_prefix, but promises never to read past "len" bytes of the input
+ * buffer, and returns the remaining number of bytes in "out" via "outlen".
+ */
+static inline int skip_prefix_mem(const char *buf, size_t len,
+				  const char *prefix,
+				  const char **out, size_t *outlen)
+{
+	size_t prefix_len = strlen(prefix);
+	if (prefix_len <= len && !memcmp(buf, prefix, prefix_len)) {
+		*out = buf + prefix_len;
+		*outlen = len - prefix_len;
+		return 1;
+	}
+	return 0;
+}
+
 /*
  * If buf ends with suffix, return 1 and subtract the length of the suffix
  * from *len. Otherwise, return 0 and leave *len untouched.
-- 
2.8.2.531.gd073806

