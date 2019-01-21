Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A10ED1F453
	for <e@80x24.org>; Mon, 21 Jan 2019 22:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfAUWc1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 17:32:27 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:41230 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfAUWc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 17:32:26 -0500
Received: by mail-qk1-f202.google.com with SMTP id u197so20134840qka.8
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 14:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P4k5sokn5YRIrZiAlCqOP3X4Q+LX9vKFYbyiWbJmJig=;
        b=Mzz2HjFUXb3RFyjtohGnNst9CWm9nBXM2rs1bHXfpq0+CV+LOK18kqP6zL1EI+d/NA
         UlnH3HUEVI8zF1WQx4Eh7WDD9YKbI7bjCJ4/Xn/sNOyr4OFJsxrMkSk0IW/LiFJkyQeh
         aEydJ4CPR+goXh2DONA+31g/+B9L/gwAl+L30lAH+BuuqMMT9BTVT5NiaaIpQaqm5hII
         X2miQedcEuXLkz3fbCrUoIJdZtsythxWI5/BY5VRAglFgNWNeytbbuOHNnDrnXVF4ifC
         cuCsuPhIk0B72dJrowwSy9wwWW0kTlkLR1qrsfzNmVtLZfz3faBhp1cPl5uKfieXCGRF
         0LPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P4k5sokn5YRIrZiAlCqOP3X4Q+LX9vKFYbyiWbJmJig=;
        b=c6q2hsFHzHlk0chyvlGOKd/9sP4ArCg4dTfSL1nL+8k8q3Wtpz3gYGZ5X9z8k7oWxJ
         IjquLDHBsL5HNB+PP9o5nwkSOV0Y2dURtYSPlpG0N+JOCP3MoCd7yiNDpCvLh3jw/4AP
         GObrwylFNWQMdrtNNWuKmLLLVgJ2zkA26GaTDuNc4LDC0jxKuYHUlN9uA732YImgAvAw
         9eiBxBA2+hoNOWvtacliq8TFkfzFnt4GE9zsY0PgyEgQkbNGqpTpE8EXIDZw+QXE+NlV
         6Oq8HKEThNddEkVtp9WyrH4ZnQkgHGxCSSNxesyl8n9tGNLEATZSAjf93KbY+g+RR5Bd
         lMzw==
X-Gm-Message-State: AJcUukd4okVEOqMjkixN8TkGRwT2eCTYcvFYp5aevGlpJLZyQ2yLj6Iw
        KOkUn97t0m0dReM6xsg7sCGUCmglvumJCg7nRGf9O/DfxQvIkUteYUiBO90GUuWs/HSwqI9HG4U
        6n+w4EI5Lkf66iIZFWmO5QMYSGSDKHvWUVymfOVjTrlaGEkJ8TN8UjCXdWA==
X-Google-Smtp-Source: ALg8bN4IFzRjr42QvHwbE8zwxiHUSqAeEeB/QB/6kRgyeunQIVMvrE0LbFfIEBkQanvshW9RpPopT5oJYQ4=
X-Received: by 2002:a0c:b61a:: with SMTP id f26mr20960827qve.9.1548109945527;
 Mon, 21 Jan 2019 14:32:25 -0800 (PST)
Date:   Mon, 21 Jan 2019 14:32:10 -0800
In-Reply-To: <20190121223216.66659-1-sxenos@google.com>
Message-Id: <20190121223216.66659-2-sxenos@google.com>
Mime-Version: 1.0
References: <20190121223216.66659-1-sxenos@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH 2/8] evolve: Implement oid_array_contains_nondestructive
From:   sxenos@google.com
To:     git@vger.kernel.org
Cc:     Stefan Xenos <sxenos@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Xenos <sxenos@gmail.com>

Implement a "contains_nondestructive" function for oid_array that won't
sort the array if it is unsorted. This can be used to test containment in
the rare situations where the array order matters.

The function has intentionally been given a name that is more cumbersome
than the "lookup" function, which is what most callers will will want
in most situations.
---
 sha1-array.c               | 15 +++++++++++++++
 sha1-array.h               |  2 ++
 t/helper/test-sha1-array.c |  6 ++++++
 t/t0064-sha1-array.sh      | 22 ++++++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/sha1-array.c b/sha1-array.c
index b94e0ec0f5..466937d73d 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -26,6 +26,21 @@ static const unsigned char *sha1_access(size_t index, void *table)
 	return array[index].hash;
 }
 
+int oid_array_contains_nondestructive(const struct oid_array* array,
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
index 232bf95017..a887e7e4eb 100644
--- a/sha1-array.h
+++ b/sha1-array.h
@@ -13,6 +13,8 @@ struct oid_array {
 void oid_array_append(struct oid_array *array, const struct object_id *oid);
 int oid_array_lookup(struct oid_array *array, const struct object_id *oid);
 void oid_array_clear(struct oid_array *array);
+int oid_array_contains_nondestructive(const struct oid_array* array,
+	const struct object_id* oid);
 
 typedef int (*for_each_oid_fn)(const struct object_id *oid,
 			       void *data);
diff --git a/t/helper/test-sha1-array.c b/t/helper/test-sha1-array.c
index ad5e69f9d3..127a4c0b51 100644
--- a/t/helper/test-sha1-array.c
+++ b/t/helper/test-sha1-array.c
@@ -25,10 +25,16 @@ int cmd__sha1_array(int argc, const char **argv)
 			if (get_oid_hex(arg, &oid))
 				die("not a hexadecimal SHA1: %s", arg);
 			printf("%d\n", oid_array_lookup(&array, &oid));
+		} else if (skip_prefix(line.buf, "contains_nondestructive ", &arg)) {
+			if (get_oid_hex(arg, &oid))
+				die("not a hexadecimal SHA1: %s", arg);
+			printf("%d\n", oid_array_contains_nondestructive(&array, &oid));
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
index 5dda570b9a..05512b0461 100755
--- a/t/t0064-sha1-array.sh
+++ b/t/t0064-sha1-array.sh
@@ -32,6 +32,28 @@ test_expect_success 'ordered enumeration with duplicate suppression' '
 	test_cmp expect actual
 '
 
+test_expect_success 'contains_nondestructive finds existing' '
+	echo 1 > expect &&
+	echoid "" 88 44 aa 55 >> expect &&
+	{
+		echoid append 88 44 aa 55 &&
+		echoid contains_nondestructive 55 &&
+		echo for_each
+	} | test-tool sha1-array >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'contains_nondestructive non-existing query' '
+	echo 0 > expect &&
+	echoid "" 88 44 aa 55 >> expect &&
+	{
+		echoid append 88 44 aa 55 &&
+		echoid contains_nondestructive 33 &&
+		echo for_each
+	} | test-tool sha1-array >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'lookup' '
 	{
 		echoid append 88 44 aa 55 &&
-- 
2.20.1.321.g9e740568ce-goog

