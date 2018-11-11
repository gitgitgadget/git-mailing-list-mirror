Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26C391F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 06:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeKKQLB (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 11:11:01 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39032 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeKKQLB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 11:11:01 -0500
Received: by mail-oi1-f196.google.com with SMTP id 192-v6so4763941oii.6
        for <git@vger.kernel.org>; Sat, 10 Nov 2018 22:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9+LUPzmLQAjcx0lP9hKzfHOMaos3NdiJIOHNt17kb2s=;
        b=ke6YPX/do6LwPRqR1NFOVQ6XZJW08hWPIY7TKDPBzJ4WphBu9eiRJLe/6/wzEEqOZ9
         TN8sHnp+gZjn4FxDfeujPUBOliGrYnXB59n/38xKb587xudlLeweK1LtH1YtiVmXodV4
         6r/etM/0rhTRIdixHz2vtQpkEv5iIuUta0Tfd9PiVkmtgafHqfatK7ANcGNT6Erw9sXS
         DINdpFaVcV2K/tE/ErQoGl28usGVTtKzgWol7xZBrF7kxxpvRoPSLiLdrjT1ldQf7cMn
         APO9jv/G6Lu8RnWJxB2zcH2hp7BI8GI6+MUdNtIkpAXWnFz8tiQtoDHSTQXzaiUzAZPR
         3BRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+LUPzmLQAjcx0lP9hKzfHOMaos3NdiJIOHNt17kb2s=;
        b=T8S5Ub1bgmt9TQUfEOWTFpCecdAPNAQh10+VMMRKc6tW9i4G/hym4a3m+HyUwBCz+r
         s0YzfZ1mIvFYEP5Aa54JP4nLbDZm4JhSIp2pNFmp8QHg+KZSb3vo27DUZt64Gkdoatmp
         PWYelabFfjA4S7i0qDI3CB6dDjjF7zX4nN/Cy3VtHhooKA4hsf74E3/zLHno6z8PekX1
         9qTOZ0sY8AQLegUU/QWWztUzz9IkIVdnD7nxU8JHU/dhhshBBhQbM9hC+cvJKTclcCpQ
         NTt65tOZlpQrH0culTAY4y3lZAnj+xjgKARn6QzSs8lKZqcqXgPLIBZKuUOVNdBmzwAD
         Ld1w==
X-Gm-Message-State: AGRZ1gJSdKOqVzRfJRNJTab6CqZnKDESZOux6SsuKI4KxcV3iwjJEMDs
        QiB4SXUppPn0iYK+Zi8MOTKasany
X-Google-Smtp-Source: AJdET5fwV0RGet1utUelrWEHLEWhvTd9pWDpEs0MbW9noJUSDIeYba67ZjgGv8UO2dE4V0l4fvor5w==
X-Received: by 2002:aca:62c3:: with SMTP id w186-v6mr8959267oib.320.1541917402585;
        Sat, 10 Nov 2018 22:23:22 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id f34sm1286855otb.25.2018.11.10.22.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Nov 2018 22:23:22 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     larsxschneider@gmail.com, sandals@crustytoothpaste.net,
        peff@peff.net, me@ttaylorr.com, jrnieder@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 03/10] fast-export: use value from correct enum
Date:   Sat, 10 Nov 2018 22:23:05 -0800
Message-Id: <20181111062312.16342-4-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.866.g82735bcbde
In-Reply-To: <20181111062312.16342-1-newren@gmail.com>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ABORT and ERROR happen to have the same value, but come from differnt
enums.  Use the one from the correct enum.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fast-export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 456797c12a..1a299c2a21 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -752,7 +752,7 @@ static void handle_tag(const char *name, struct tag *tag)
 	tagged_mark = get_object_mark(tagged);
 	if (!tagged_mark) {
 		switch(tag_of_filtered_mode) {
-		case ABORT:
+		case ERROR:
 			die("tag %s tags unexported object; use "
 			    "--tag-of-filtered-object=<mode> to handle it",
 			    oid_to_hex(&tag->object.oid));
-- 
2.19.1.866.g82735bcbde

