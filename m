Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4190CC77B7A
	for <git@archiver.kernel.org>; Wed, 31 May 2023 15:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjEaPw7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 May 2023 11:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjEaPw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2023 11:52:57 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E187297
        for <git@vger.kernel.org>; Wed, 31 May 2023 08:52:54 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-5149385acd0so3751465a12.3
        for <git@vger.kernel.org>; Wed, 31 May 2023 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685548373; x=1688140373;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LpAoyo9kQTlDx/5YflidzuIwBBTuyfoJ8wY9aZbLYxw=;
        b=46lbmjVIc/m+c6leC6UhBQTETOuXCwVTW0bP4n8BvpcG9yElxMZmyADND8H2rsl/RH
         cJ83CCP9wTSZ3upX01io7GUSGhyvS5mcDkEISalL62L/Mff5ST5oS7HtJnfDKgimoWSR
         aKDQFOADUJHFThMqCZgkqnW3hn6VMiCBR3fvrpZlU2fPVmg5HirJM6AGWYalfKrtHuSL
         qImHqEl/e1/4Q0LAUq51L3J75vXEqWBW49mHqH3YDnA5ykcXrs95v/kh7p4yHWSBve7Z
         2RY/ELf5pho+dU/cgMkpSAcCojyaQHlbte0MmLOHpgiG7qXZA130K8uQaX9PIp6v4WpJ
         DJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685548373; x=1688140373;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LpAoyo9kQTlDx/5YflidzuIwBBTuyfoJ8wY9aZbLYxw=;
        b=SkwdLS/pfcRaQJa866+fW7FixwD73rPSGXWc3uyH8m9jcsy+qhL0kXrIN7babTyaPQ
         6AenYfjX6JXCZEMJUca/qofTpVoNU31XRnUaspP2e0xqDkHnJZhblCmhvnAO1AOUw3cT
         trY3KcIZoyfMoPBDpWzvXTGaM3Mc9sQDsXjB7zOju7iAa4m3a/S+ZlCVVSL4UbANy3u8
         AgG/En1R1jqTV68idtPJuARRk3rzlRoVrjKMvlst2jnlXXC/AzzfvjAjkQ0WnBlZdOcW
         kz90jMLwE5DaAomqlp7Fnk8vXnve9HiSV8HeuOPTNs23Hk8KbqCkilWAt+y3skgGsyYJ
         Jviw==
X-Gm-Message-State: AC+VfDxzwJsPCiwXRpNL0FymnBsxd8dJPKoMH06s+zlmmT1lNPzUk6UF
        NhhEbHoeU9G9YrZygefGnDLgsgjTHTrVTgjlXhOHPPydjK2K3D12O3LMrxUVjEiNndiwmimLrAi
        MOU5ql4NXWjgYadKjwhDfN6nFzwK1oTI8ZQpWut8kfu5GWBM4nRStqXqdSjdwQoRcZugo
X-Google-Smtp-Source: ACHHUZ6ZIMy/V59Y8UmDO6Fm5MV2X8jFDGKPnTu4j9vUZA+S6E/IMOyMSeZZfli/SrUp7Do+FVRVZ/hFY6UYFVHW
X-Received: from siddhu.muc.corp.google.com ([2a00:79e0:9c:0:bbc9:7869:40c9:d55b])
 (user=siddhartth job=sendgmr) by 2002:a50:f695:0:b0:512:6dbf:b378 with SMTP
 id d21-20020a50f695000000b005126dbfb378mr1995077edn.7.1685548373583; Wed, 31
 May 2023 08:52:53 -0700 (PDT)
Date:   Wed, 31 May 2023 17:51:42 +0200
In-Reply-To: <20230531155142.3359886-1-siddhartth@google.com>
Mime-Version: 1.0
References: <20230531155142.3359886-1-siddhartth@google.com>
X-Mailer: git-send-email 2.40.GIT
Message-ID: <20230531155142.3359886-2-siddhartth@google.com>
Subject: [RFC PATCH 1/1] khash_test.c: add unit tests
From:   Siddharth Singh <siddhartth@google.com>
To:     git@vger.kernel.org
Cc:     Siddharth Singh <siddhartth@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tests check if a hashmap
1. Gets hash value for a string
2. Has correct value for '__ac_HASH_UPPER'
3. Initializes succesfully.
4. Put a key value pair.
5. Gets the value from key.
6. Delete the key-value pair.
7. Updates the value after deleting it.
8. Update Value of before deleting.
9. Contains the right number of elements.

Signed-off-by: Siddharth Singh <siddhartth@google.com>
---
 Makefile       |   1 +
 t/khash_test.c | 173 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+)
 create mode 100644 t/khash_test.c

diff --git a/Makefile b/Makefile
index 660c72d72e..59cb76e5e5 100644
--- a/Makefile
+++ b/Makefile
@@ -3852,6 +3852,7 @@ $(UNIT_TEST_PROGS): $(CTAP_OBJS) $(LIBS)
 	$(QUIET)mkdir -p t/unit-tests
 	$(QUIET_CC)$(CC) -It -o t/unit-tests/unit-test-t t/unit-test.c $(CTAP_OBJS)
 	$(QUIET_CC)$(CC) -It -o t/unit-tests/strbuf-t t/strbuf-test.c -DSKIP_COMMON_MAIN common-main.c $(CTAP_OBJS) $(LIBS)
+	$(QUIET_CC)$(CC) -It -o t/unit-tests/khash-t t/khash_test.c -DSKIP_COMMON_MAIN common-main.c $(CTAP_OBJS) $(LIBS)
 
 .PHONY: unit-tests
 unit-tests: $(UNIT_TEST_PROGS) $(UNIT_TEST_RUNNER)
diff --git a/t/khash_test.c b/t/khash_test.c
new file mode 100644
index 0000000000..cd27618d4d
--- /dev/null
+++ b/t/khash_test.c
@@ -0,0 +1,173 @@
+#include <tap/basic.h>
+#include "../git-compat-util.h"
+
+#include "../khash.h"
+
+int khash_testACX31HashString(){
+    const char * str = "foobar";
+    khint_t value = __ac_X31_hash_string(str);
+    khint_t expected = 3026088333;
+    if(value == expected)
+        return 1;
+    return 0;
+}
+
+int khash_testAC_HASH_UPPER(){
+    const double expected = 0.77;
+    if(expected == __ac_HASH_UPPER){
+        return 1;
+    }
+    return 0;
+}
+
+KHASH_INIT(str, const char *, int *, 1, kh_str_hash_func, kh_str_hash_equal);
+
+int khash_testInit(){
+    kh_str_t * hashmap = kh_init_str();
+    if(hashmap != NULL){
+        return 1;
+    }
+    return 0;
+}
+
+int khash_testPut(){
+    kh_str_t * hashmap = kh_init_str();
+    int ret;
+    int pos = kh_put_str(hashmap,"test_key",&ret);
+    int value = 14;
+    if(ret){
+        kh_key(hashmap, pos) = xstrdup("test_key");
+		kh_value(hashmap, pos) = &value;
+    }else return 0;
+    if(*kh_value(hashmap,pos) == value){
+        return 1;
+    }
+    return 0;
+}
+
+int khash_testGet(){
+    kh_str_t * hashmap = kh_init_str();
+    int ret;
+    int pos = kh_put_str(hashmap,"test_key",&ret);
+    int value = 14;
+    if(ret){
+        kh_key(hashmap, pos) = xstrdup("test_key");
+		kh_value(hashmap, pos) = &value;
+    }else return 0;
+    int value_pos = kh_get_str(hashmap,"test_key");    
+    int returned_value = *kh_value(hashmap,value_pos);
+    if(returned_value == value){
+        return 1;
+    }
+    return 0;
+}
+
+int khash_testDelete(){
+    kh_str_t * hashmap = kh_init_str();
+    int ret;
+    int pos = kh_put_str(hashmap,"test_key",&ret);
+    int value = 14;
+    if(ret){
+        kh_key(hashmap, pos) = xstrdup("test_key");
+		kh_value(hashmap, pos) = &value;
+    }else return 0;
+    int current_size = hashmap->size;
+    kh_del_str(hashmap,pos);
+    if(hashmap->size + 1 == current_size && !kh_exist(hashmap, pos)){
+        return 1;
+    }
+    return 0;
+}
+
+int khash_testUpdateValueAfterDeleting(){
+    kh_str_t * hashmap = kh_init_str();
+    int ret;
+    int pos1 = kh_put_str(hashmap,"test_key",&ret);
+    int value1 = 14;
+    if(ret){
+        kh_key(hashmap, pos1) = xstrdup("test_key");
+		kh_value(hashmap, pos1) = &value1;
+    }else return 0;
+
+    kh_del_str(hashmap,pos1);
+    int pos2 = kh_put_str(hashmap,"test_key",&ret);
+    int value2 = 15;
+    
+    if(ret){
+        kh_key(hashmap, pos2) = xstrdup("test_key");
+		kh_value(hashmap, pos2) = &value2;
+    }else return 0;
+
+    int value_pos = kh_get_str(hashmap,"test_key");    
+    int returned_value = *kh_value(hashmap,value_pos);
+    if(returned_value == value2){
+        return 1;
+    }
+    return 0;
+}
+
+int khash_testUpdateValueBeforeDeleting(){
+    kh_str_t * hashmap = kh_init_str();
+    int ret;
+    int pos1 = kh_put_str(hashmap,"test_key",&ret);
+    int value1 = 14;
+    if(ret){
+        kh_key(hashmap, pos1) = xstrdup("test_key");
+		kh_value(hashmap, pos1) = &value1;
+    }else return 0;
+
+    int pos2 = kh_put_str(hashmap,"test_key",&ret);
+    int value2 = 15;
+    
+    if(ret == 0){
+        return 1;
+    }
+    return 0;
+}
+
+int khash_testSize(){
+    kh_str_t * hashmap = kh_init_str();
+    int ret;
+    int pos1 = kh_put_str(hashmap,"test_key1",&ret);
+    int value1 = 14;
+    if(ret){
+        kh_key(hashmap, pos1) = xstrdup("test_key1");
+		kh_value(hashmap, pos1) = &value1;
+    }else return 0;
+
+    int pos2 = kh_put_str(hashmap,"test_key2",&ret);
+    int value2 = 15;
+    if(ret){
+        kh_key(hashmap, pos2) = xstrdup("test_key2");
+		kh_value(hashmap, pos2) = &value2;
+    }else return 0;
+
+
+    int pos3 = kh_put_str(hashmap,"test_key3",&ret);
+    int value3 = 16;
+    if(ret){
+        kh_key(hashmap, pos3) = xstrdup("test_key3");
+		kh_value(hashmap, pos3) = &value3;
+    }else return 0;
+
+    if(kh_size(hashmap) == 3){
+        return 1;
+    }
+    return 0;
+}
+
+int main(void){
+    plan(9);
+    
+    ok(khash_testACX31HashString(),"__ac_X31_hash_string works");
+    ok(khash_testAC_HASH_UPPER(),"__ac_HASH_UPPER has correct value");
+    ok(khash_testInit(), "Initialize hashmap");
+    ok(khash_testPut(), "Put Key-Value pair");
+    ok(khash_testGet(), "Get the value from hashmap");
+    ok(khash_testDelete(), "Delete the key-value from hashmap");
+    ok(khash_testUpdateValueAfterDeleting(), "Update Value of a Key after deleting");
+    ok(khash_testUpdateValueBeforeDeleting(), "Update Value of a Key before deleting");
+    ok(khash_testSize(),"Test if 3 elements are present in hashmap");
+
+    return 0;
+}
\ No newline at end of file
-- 
2.40.1.606.ga4b1b128d6-goog

