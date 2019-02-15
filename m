Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0960C1F453
	for <e@80x24.org>; Fri, 15 Feb 2019 04:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbfBOEbW (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 23:31:22 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:33733 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbfBOEbV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 23:31:21 -0500
Received: by mail-vk1-f202.google.com with SMTP id y196so3578714vkd.0
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 20:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BnUr70dQjdSP35dYSkLHaX7qPVy/AkZksikxppfXp+o=;
        b=bGY2t0nnyO4E5BVUlGJrXhq5Rvtp+IITsVKY5/Z5B2vINHzH7/1p2ZG+T22QogKrUr
         EAlXcygu7jGTBspmlbhUBapAkDNY1bXtAqsQB/I550drt1cTwM5GnI929kcjCq93NqlC
         tUTQrsixkIhcmy4wbLVdeChJOH7ATNAb8aUy0or8w/oV8wSgE/HruTaQ1RAXRTs8xkmn
         i7GLTjefnNJgwTPjLGkMeGEKsuTEArp4aPQ8/K4aAZkXjb65/OPodxhciIkFusit+aNb
         r0aNvedDV2EXU8WHhdnbU+H7FCyPOxGQYi+LVT4pKzav3xUo8blMjwe5w/Oj7hA2u40W
         bkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BnUr70dQjdSP35dYSkLHaX7qPVy/AkZksikxppfXp+o=;
        b=ojuoFDppB+rbNd2G5sez8ddWzrFfzLCc28lUZMx6CGwZtxf1Z5LBErL//R68zWt2Zv
         D+iSg+30/QHXLJJ+845z0POvVZkxc/mkhl8SZkenP+OnJxtEj4LG/fDjf3lr23X/Omtv
         0i6TOk7SkD532AfBK1R9yt0q78ie/rfsQjpugxbQZIICVd2gviSPm6/mZwoKqqe15LSL
         d+n0TKbQA4ApJgK3u/l8QFsED8vdFlR9rWDYx1XZWP++sFZnyZasnrwABVgqcafnRTgB
         LBmN1hOM831tyLmkpS0fddQ99mO8K6Cqc9lNUy0r79WknH7XrepG8bLyVWX+XUXn0qLw
         NMXw==
X-Gm-Message-State: AHQUAua+ERXIW1AVUFlLeWrQKH+1WIbNnPSt7egBUc+TaETVzFCF9g+a
        wDmSQKpJbiuGKAg4b+YIvZc+WlhnOyPuKHKqCGllRwL4LIiI0SgIzvwyox3ASOC1IdhqE7uHYyn
        Evv5zhM1GMMnTg3cPoqIi5B1p462NOIrKX+jnI+WR0RUk2ywR7PWAzQkycA==
X-Google-Smtp-Source: AHgI3Ia4EfH4xpn2Xtcm3QPFm9tS8Si4bjSUIMWycj99bFyQc4ZltbH06pUrgb0VWuei6m/+++7ISPe06IY=
X-Received: by 2002:a9f:2981:: with SMTP id s1mr4634735uas.9.1550205080571;
 Thu, 14 Feb 2019 20:31:20 -0800 (PST)
Date:   Thu, 14 Feb 2019 20:30:59 -0800
In-Reply-To: <20190215043105.163688-1-sxenos@google.com>
Message-Id: <20190215043105.163688-2-sxenos@google.com>
Mime-Version: 1.0
References: <20190215043105.163688-1-sxenos@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH v5 2/8] sha1-array: implement oid_array_readonly_contains
From:   sxenos@google.com
To:     git@vger.kernel.org
Cc:     Stefan Xenos <sxenos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Xenos <sxenos@google.com>

Implement a "readonly_contains" function for oid_array that won't
sort the array if it is unsorted. This can be used to test containment in
the rare situations where the array order matters.

The function has intentionally been given a name that is more cumbersome
than the "lookup" function, which is what most callers will will want
in most situations.

Signed-off-by: Stefan Xenos <sxenos@google.com>
---
 sha1-array.c               | 13 +++++++++++++
 sha1-array.h               |  2 ++
 t/helper/test-sha1-array.c |  6 ++++++
 t/t0064-sha1-array.sh      | 22 ++++++++++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/sha1-array.c b/sha1-array.c
index d922e94e3f..d1adcbfc8a 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -26,6 +26,19 @@ static const unsigned char *sha1_access(size_t index, void *table)
 	return array[index].hash;
 }
 
+int oid_array_readonly_contains(const struct oid_array* array,
+	const struct object_id* oid)
+{
+	int i;
+
+	if (array->sorted)
+		return sha1_pos(oid->hash, array->oid, array->nr, sha1_access) >= 0;
+	for (i = 0; i < array->nr; i++)
+		if (oideq(&array->oid[i], oid) == 0)
+			return 1;
+	return 0;
+}
+
 int oid_array_lookup(struct oid_array *array, const struct object_id *oid)
 {
 	if (!array->sorted)
diff --git a/sha1-array.h b/sha1-array.h
index 55d016c4bf..06d3ad2994 100644
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
index 5dda570b9a..512dd0f56b 100755
--- a/t/t0064-sha1-array.sh
+++ b/t/t0064-sha1-array.sh
@@ -32,6 +32,28 @@ test_expect_success 'ordered enumeration with duplicate suppression' '
 	test_cmp expect actual
 '
 
+test_expect_success 'readonly_contains finds existing' '
+	echo 1 >expect &&
+	echoid "" 88 44 aa 55 >>expect &&
+	{
+		echoid append 88 44 aa 55 &&
+		echoid readonly_contains 55 &&
+		echo for_each
+	} | test-tool sha1-array >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'readonly_contains non-existing query' '
+	echo 0 >expect &&
+	echoid "" 88 44 aa 55 >>expect &&
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
2.21.0.rc0.258.g878e2cd30e-goog

