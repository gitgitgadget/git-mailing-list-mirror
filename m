Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B02DE1F453
	for <e@80x24.org>; Sun, 27 Jan 2019 19:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfA0Tlh (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 14:41:37 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:43105 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfA0Tlg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 14:41:36 -0500
Received: by mail-pg1-f202.google.com with SMTP id v72so10043423pgb.10
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 11:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vkxspNQERKQtD2zbfXs9u9ZH5PO+G1KSGyGwY6+Rpn8=;
        b=ZV4UE/DHSIOy5ZcCPAyM0Q+JnfbGTa4mywjgmLyU1/RVo1IwqzHjepyU86q/KtGEfG
         7k/zsAWpc1qlUCoX2W6ekczrK39TDgn/EH+A9unnigxxO78IgJVLlnQE7RBC2GhJkOYc
         CV5jlGFEPm9r2/VvYNKHWb23CSlG/CANHunD/p5SoHMUMeAAN9n5bxu5Kmt2O74KzrGi
         h4BcG4aDCBPPoMz9FGFXicrRqk2S528k+lhstv2PJcA3+EUIKk8X2RkqBLdyrTZ3i0mE
         /gmwNsLIhXW+SXUOVKfaKid2Tk1PZ9erUouJe34SXtCJcRyS8jHmnfwKOekrfZaYjt0M
         388g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vkxspNQERKQtD2zbfXs9u9ZH5PO+G1KSGyGwY6+Rpn8=;
        b=QovbWYK+bDTcexV1HL08VEI31Ragh+BgyKUvD+C74hXEorkgTcdGQCxSquxYzBr9ku
         UNrkcHYWWbU2/is3EXZnt5097XHJfIKEduLpNpt4VjA9gDBqo88mUeGU0YvqJ3Lkx3yP
         vTqmxe08WRM+grMxdSaZFgAx2dZVBxx1pgOwh5vmr812gSrxvXr8rCVKUtSW9pvV1N5O
         53+6q5UyuyJp++jN7WaFewLE1xq7uL0dKrUbX8uDhTZGc2Td1FC5AvjwEEaZJ2WPaZQM
         kyxABsLw7KNlF74OEDYQb+eN8cVSVojmbFCSWtU/4/cQjZAgfGJBGTeUf+QUyXzNxf3p
         4CcA==
X-Gm-Message-State: AJcUukdZGPJd7tW8s1M32VC1/BRg1P+06hvudpOabXZa5/PSX1l2onf7
        cPb2C/VrNkhKyfa8BKmqru7DklT5sMUkJcaPFM023EYuoEZlq7N6e61WGrmY6rglHwfRCVr/Tt7
        pQVUPYDLaTxxNMBY/mdwdjO6pUnCB9yE6dRU3Y3Adfr1b1aC47ay6UCT8VA==
X-Google-Smtp-Source: ALg8bN4IoD9xWzAqUHXucf+Z98bjimRP4ScHrm4l40Mo2yitQmfS7n4Cg/WP+Ouayz83C18GaqJ4cRXf6y0=
X-Received: by 2002:a17:902:4523:: with SMTP id m32mr7392542pld.4.1548618095637;
 Sun, 27 Jan 2019 11:41:35 -0800 (PST)
Date:   Sun, 27 Jan 2019 11:41:22 -0800
In-Reply-To: <20190127194128.161250-1-sxenos@google.com>
Message-Id: <20190127194128.161250-2-sxenos@google.com>
Mime-Version: 1.0
References: <20190127194128.161250-1-sxenos@google.com>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
Subject: [PATCH v2 2/8] sha1-array: Implement oid_array_readonly_contains
From:   sxenos@google.com
To:     git@vger.kernel.org
Cc:     Stefan Xenos <sxenos@gmail.com>, Stefan Xenos <sxenos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Xenos <sxenos@gmail.com>

Implement a "readonly_contains" function for oid_array that won't
sort the array if it is unsorted. This can be used to test containment in
the rare situations where the array order matters.

The function has intentionally been given a name that is more cumbersome
than the "lookup" function, which is what most callers will will want
in most situations.

Signed-off-by: Stefan Xenos <sxenos@google.com>
---
 sha1-array.c               | 15 +++++++++++++++
 sha1-array.h               |  2 ++
 t/helper/test-sha1-array.c |  6 ++++++
 t/t0064-sha1-array.sh      | 22 ++++++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/sha1-array.c b/sha1-array.c
index b94e0ec0f5..071fce7e90 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -26,6 +26,21 @@ static const unsigned char *sha1_access(size_t index, void *table)
 	return array[index].hash;
 }
 
+int oid_array_readonly_contains(const struct oid_array* array,
+	const struct object_id* oid)
+{
+	int i;
+	if (array->sorted) {
+		return sha1_pos(oid->hash, array->oid, array->nr, sha1_access) >= 0;
+	}
+	for (i = 0; i < array->nr; i++) {
+		if (hashcmp(array->oid[i].hash, oid->hash) == 0) {
+			return 1;
+		}
+	}
+	return 0;
+}
+
 int oid_array_lookup(struct oid_array *array, const struct object_id *oid)
 {
 	if (!array->sorted)
diff --git a/sha1-array.h b/sha1-array.h
index 232bf95017..7273bd5151 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -13,6 +13,8 @@ struct oid_array {
 void oid_array_append(struct oid_array *array, const struct object_id *oid);
 int oid_array_lookup(struct oid_array *array, const struct object_id *oid);
 void oid_array_clear(struct oid_array *array);
+int oid_array_readonly_contains(const struct oid_array* array,
+	const struct object_id* oid);
 
 typedef int (*for_each_oid_fn)(const struct object_id *oid,
 			       void *data);
diff --git a/t/helper/test-sha1-array.c b/t/helper/test-sha1-array.c
index ad5e69f9d3..fefb1c984f 100644
--- a/t/helper/test-sha1-array.c
+++ b/t/helper/test-sha1-array.c
@@ -25,10 +25,16 @@ int cmd__sha1_array(int argc, const char **argv)
 			if (get_oid_hex(arg, &oid))
 				die("not a hexadecimal SHA1: %s", arg);
 			printf("%d\n", oid_array_lookup(&array, &oid));
+		} else if (skip_prefix(line.buf, "readonly_contains ", &arg)) {
+			if (get_oid_hex(arg, &oid))
+				die("not a hexadecimal SHA1: %s", arg);
+			printf("%d\n", oid_array_readonly_contains(&array, &oid));
 		} else if (!strcmp(line.buf, "clear"))
 			oid_array_clear(&array);
 		else if (!strcmp(line.buf, "for_each_unique"))
 			oid_array_for_each_unique(&array, print_oid, NULL);
+		else if (!strcmp(line.buf, "for_each"))
+			oid_array_for_each(&array, print_oid, NULL);
 		else
 			die("unknown command: %s", line.buf);
 	}
diff --git a/t/t0064-sha1-array.sh b/t/t0064-sha1-array.sh
index 5dda570b9a..c1bac6fcdd 100755
--- a/t/t0064-sha1-array.sh
+++ b/t/t0064-sha1-array.sh
@@ -32,6 +32,28 @@ test_expect_success 'ordered enumeration with duplicate suppression' '
 	test_cmp expect actual
 '
 
+test_expect_success 'readonly_contains finds existing' '
+	echo 1 > expect &&
+	echoid "" 88 44 aa 55 >> expect &&
+	{
+		echoid append 88 44 aa 55 &&
+		echoid readonly_contains 55 &&
+		echo for_each
+	} | test-tool sha1-array >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'readonly_contains non-existing query' '
+	echo 0 > expect &&
+	echoid "" 88 44 aa 55 >> expect &&
+	{
+		echoid append 88 44 aa 55 &&
+		echoid readonly_contains 33 &&
+		echo for_each
+	} | test-tool sha1-array >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'lookup' '
 	{
 		echoid append 88 44 aa 55 &&
-- 
2.20.1.495.gaa96b0ce6b-goog

