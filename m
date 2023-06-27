Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE6CEB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 13:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjF0NV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 09:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjF0NVR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 09:21:17 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26361708
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 06:21:14 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-51bef8bb689so5530893a12.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 06:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687872073; x=1690464073;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nELtkyR4SxcpeIG/ZpulalHMC/vYFLPf76LqC5f0ItQ=;
        b=UnyxE1G48QDB72sYzRWIUzhONK8vpXKBBVqwGNzO6jH8zg+dcW+yLaFzbbP1ZFAto0
         uLZUixETzS5XH1hRgNStzzFRBV0PJ59nKv/itXBRkpWHYzHH65Yy4y1R2NVE/xLqlHwJ
         DKXwB0pASltkiZEe3/M3NbgYh/yD4ABtL604RIqBn1i/w0POW0/9ikl3zfIDYXY3HjLs
         JtoqhjFlBrG+sEGchW8c2BaiEQtSoyauJmdAfVeBynaYQd9UKg+xfl2XU5tO9KXKyh5V
         0SmwpUMQa+AkiLUJJWzLy/qu/uVKALHvbqFQrXUGZVpc8ggp+/x4KmvxiBN09OcDXurb
         3q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687872073; x=1690464073;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nELtkyR4SxcpeIG/ZpulalHMC/vYFLPf76LqC5f0ItQ=;
        b=g9x9VXxVuFgA263nDdlipeqy6WVderUkTTVuqEtiHvFG/hSgHuxoehN5HFJaxMDXjH
         bMPaKvuAjp8u5VdcrXqmJK/P2MmFWFVlMQuFNLBnC2q0yD1cIMRX4HaWV8idx/G+1xxe
         mCNsqzq0B4awWe7yuRLjGtJHu5HM6NAov2KXcULO05ZTU6eDnPD4Ves7c4tpvDJNyAlX
         JOFZ1HPz6cOWKSbj0FdB8rxck9BEQkLUKoWUsyJYgN3n9Imfjy75xfEk02wrP5UucJod
         olWdPyvAPAoY5llmZX170A4nybUQixB0u6SwmKFhv8rbSfkCq4S19HotK7c1OqRQV6aR
         Xe4w==
X-Gm-Message-State: AC+VfDyBvokOXJC8WiXOy8jeqMxJt5D0Fv3zJvMQEj+IYmyqxeJWruLH
        YYy1lgwNoypTQUm8HDrfqc28n4HCITp/U7n83yHefk3NosjAoroiKzH+qe2xrJ0KydZRyoha5ak
        QoEZzKW6jo3nnj3E2O04qWD8jqfygT9ER6KsMyDGqSLefFmoVEbuKpEMqITo7qMSo6hYY
X-Google-Smtp-Source: ACHHUZ6vWrTa7IXL5t3efK4uonjyKBnR3LIkaIZLaIbx2wQuBXTSiS7UUkpwgohMiuFdrDoh4jIGoUEfqYnxtQsY
X-Received: from siddhu.muc.corp.google.com ([2a00:79e0:9c:0:6d2b:295:c609:e08e])
 (user=siddhartth job=sendgmr) by 2002:a50:c304:0:b0:51b:ec37:818f with SMTP
 id a4-20020a50c304000000b0051bec37818fmr2649957edb.1.1687872073410; Tue, 27
 Jun 2023 06:21:13 -0700 (PDT)
Date:   Tue, 27 Jun 2023 15:20:26 +0200
In-Reply-To: <20230531155142.3359886-1-siddhartth@google.com>
Mime-Version: 1.0
References: <20230531155142.3359886-1-siddhartth@google.com>
X-Mailer: git-send-email 2.40.GIT
Message-ID: <20230627132026.3204186-1-siddhartth@google.com>
Subject: [RFC PATCH v2] khash_test.c : add unit tests
From:   Siddharth Singh <siddhartth@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Siddharth Singh <siddhartth@google.com>
---
Since v1
- rewrote the code keeping coding style guidelines in mind.
- refactored tests to improve their implementation..
- added a few more tests that cause collisions in the hashmap.
In the v1 patch, there were concerns that new tests were unnecessary becaus=
e of upstream tests. However, I believe it would be beneficial to have test=
s based on the khash implementation in the git codebase because the existin=
g tests[1] for khash do not use the same code for khash as the git codebase=
.=20
E.g. in khash.h file of =E2=80=9Cattractivechaos/klib/khash.h=E2=80=9D [2].=
 There's an implementation for `KHASH_MAP_INIT_INT64` which isn=E2=80=99t d=
efined in =E2=80=9Cgit/git/khash.h=E2=80=9D[3]. So, there=E2=80=99s a possi=
bility that the khash.h in a different repository might move forward and en=
d up being different from out implementation, so writing tests for =E2=80=
=9Cgit/git/khash.h=E2=80=9D would ensure that our tests are relevant to the=
 actual usage of the library.
While my colleagues are currently investigating whether C Tap harness is th=
e best way to test libified code, this RFC is intended to discuss the conte=
nt of unit tests and what other tests would be useful for khash.h. I am uns=
ure of what tests will be valuable in the future, so I would appreciate you=
r thoughts on the matter. Many test cases are easier to construct in C TAP =
harness than in test-tool. For example, In C TAP harness, non-string values=
 can be used directly in hash maps. However, in test-tool, non-string value=
s must be passed as an argument to a shell executable, parsed into the corr=
ect type, and then operated on.
I'm also very new to writing unit tests in C and git codebase in general, s=
o I'll appreciate constructive feedback and discussion..
With this RFC, I hope you can help me answer these questions.
What are the unit test cases to include in khash.h?
What are the other types of tests that would be useful for khash.h?
[1] https://github.com/attractivechaos/klib/blob/master/test/khash_test.c
[2] https://github.com/attractivechaos/klib/blob/master/khash.h
[3] https://github.com/git/git/blob/master/khash.h

 Makefile       |   2 +
 t/khash_test.c | 214 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 216 insertions(+)
 create mode 100644 t/khash_test.c

diff --git a/Makefile b/Makefile
index 660c72d72e..d3ad2fa23c 100644
--- a/Makefile
+++ b/Makefile
@@ -3847,11 +3847,13 @@ $(UNIT_TEST_RUNNER): t/runtests.c
=20
 UNIT_TEST_PROGS +=3D t/unit-tests/unit-test-t
 UNIT_TEST_PROGS +=3D t/unit-tests/strbuf-t
+UNIT_TEST_PROGS +=3D t/unit-tests/khash-t
=20
 $(UNIT_TEST_PROGS): $(CTAP_OBJS) $(LIBS)
 	$(QUIET)mkdir -p t/unit-tests
 	$(QUIET_CC)$(CC) -It -o t/unit-tests/unit-test-t t/unit-test.c $(CTAP_OBJ=
S)
 	$(QUIET_CC)$(CC) -It -o t/unit-tests/strbuf-t t/strbuf-test.c -DSKIP_COMM=
ON_MAIN common-main.c $(CTAP_OBJS) $(LIBS)
+	$(QUIET_CC)$(CC) -It -o t/unit-tests/khash-t t/khash_test.c -DSKIP_COMMON=
_MAIN common-main.c $(CTAP_OBJS) $(LIBS)
=20
 .PHONY: unit-tests
 unit-tests: $(UNIT_TEST_PROGS) $(UNIT_TEST_RUNNER)
diff --git a/t/khash_test.c b/t/khash_test.c
new file mode 100644
index 0000000000..d1a43add13
--- /dev/null
+++ b/t/khash_test.c
@@ -0,0 +1,214 @@
+#include "../git-compat-util.h"
+#include "../khash.h"
+#include <tap/basic.h>
+
+/*
+  These tests are for base assumptions; if they fails, library is broken
+*/
+int hash_string_succeeds() {
+  const char *str =3D "test_string";
+  khint_t value =3D __ac_X31_hash_string(str);
+  return value =3D=3D 0xf1a6305e;
+}
+
+int hash_string_with_non_alphabets_succeeds() {
+  const char *str =3D "test_string #2";
+  khint_t value =3D __ac_X31_hash_string(str);
+  return value =3D=3D 0xfa970771;
+}
+
+KHASH_INIT(str, const char *, int *, 1, kh_str_hash_func, kh_str_hash_equa=
l);
+
+int initialized_hashmap_pointer_not_null() {
+  kh_str_t *hashmap =3D kh_init_str();
+
+  if(hashmap !=3D NULL){
+    free(hashmap);
+    return 1;
+  }
+  return 0;
+}
+
+int put_key_into_hashmap_once_succeeds() {
+  int ret, value;
+  khint_t pos;
+  kh_str_t *hashmap =3D kh_init_str();
+  pos =3D kh_put_str(hashmap, "test_key", &ret);
+  if(!ret)
+    return 0;
+  return pos !=3D 0;
+}
+
+int put_same_key_into_hashmap_twice_fails() {
+  int first_return_value, second_return_value, value;
+  khint_t pos;
+  kh_str_t *hashmap =3D kh_init_str();
+  kh_put_str(hashmap, "test_key", &first_return_value);
+  kh_put_str(hashmap, "test_key", &second_return_value);
+  return !second_return_value;
+}
+
+int put_value_into_hashmap_once_succeeds() {
+  int ret, value =3D 14;
+  khint_t pos;
+  kh_str_t *hashmap =3D kh_init_str();
+  pos =3D kh_put_str(hashmap, "test_key", &ret);
+  if (!ret)
+    return 0;
+  kh_key(hashmap, pos) =3D xstrdup("test_key");
+  kh_value(hashmap, pos) =3D &value;
+  return *kh_value(hashmap, pos) =3D=3D value;
+}
+
+int put_same_value_into_hashmap_twice_fails() {
+  int first_return_value, second_return_value, value =3D 14;
+  khint_t pos;
+  kh_str_t *hashmap =3D kh_init_str();
+  pos =3D kh_put_str(hashmap, "test_key", &first_return_value);
+  if (!first_return_value)
+    return 0;
+  kh_key(hashmap, pos) =3D xstrdup("test_key");
+  kh_value(hashmap, pos) =3D &value;
+  kh_put_str(hashmap, "test_key", &second_return_value);
+  return !second_return_value;
+}
+
+int get_existing_kv_from_hashmap_succeeds() {
+  int ret, value =3D14;
+  int expected =3D value;
+  khint_t pos;
+  kh_str_t *hashmap =3D kh_init_str();
+  pos =3D kh_put_str(hashmap, "test_key", &ret);
+  if (!ret)
+    return 0;
+  kh_key(hashmap, pos) =3D xstrdup("test_key");
+  kh_value(hashmap, pos) =3D &value;
+  return *kh_value(hashmap, kh_get_str(hashmap, "test_key")) =3D=3D expect=
ed;
+}
+
+int get_nonexisting_kv_from_hashmap_fails() {
+  int value =3D 14;
+  khint_t pos;
+  kh_str_t *hashmap =3D kh_init_str();
+  return !kh_get_str(hashmap, "test_key");
+}
+
+int deletion_from_hashmap_sets_flag() {
+  int ret, value =3D 14;
+  khint_t pos;
+  kh_str_t *hashmap =3D kh_init_str();
+  pos =3D kh_put_str(hashmap, "test_key", &ret);
+  if (!ret)
+    return 0;
+  if(!kh_exist(hashmap, pos))
+    return 0;
+  kh_key(hashmap, pos) =3D xstrdup("test_key");
+  kh_value(hashmap, pos) =3D &value;
+  kh_del_str(hashmap, pos);
+  return !kh_exist(hashmap, pos);
+}
+
+int deletion_from_hashmap_updates_size() {
+  int ret, value =3D 14, current_size;
+  khint_t pos;
+  kh_str_t *hashmap =3D kh_init_str();
+  pos =3D kh_put_str(hashmap, "test_key", &ret);
+  if (!ret)
+    return 0;
+  kh_key(hashmap, pos) =3D xstrdup("test_key");
+  kh_value(hashmap, pos) =3D &value;
+  current_size =3D hashmap->size;
+  kh_del_str(hashmap, pos);
+  return hashmap->size + 1 =3D=3D current_size;
+}
+
+int deletion_from_hashmap_does_not_update_kv() {
+  int ret, value =3D 14, current_size;
+  khint_t pos;
+  kh_str_t *hashmap =3D kh_init_str();
+  pos =3D kh_put_str(hashmap, "test_key", &ret);
+  if (!ret)
+    return 0;
+  kh_key(hashmap, pos) =3D xstrdup("test_key");
+  kh_value(hashmap, pos) =3D &value;
+  kh_del_str(hashmap, pos);
+  return !strcmp(kh_key(hashmap, pos),"test_key");
+}
+
+int update_value_after_deletion_succeeds() {
+  int ret, value1 =3D 14, value2 =3D 15;
+  khint_t pos1, pos2;
+  kh_str_t *hashmap =3D kh_init_str();
+  // adding the kv to the hashmap
+  pos1 =3D kh_put_str(hashmap, "test_key", &ret);
+  if (!ret)
+    return 0;
+  kh_key(hashmap, pos1) =3D xstrdup("test_key");
+  kh_value(hashmap, pos1) =3D &value1;
+  // delete the kv from the hashmap
+  kh_del_str(hashmap, pos1);
+  // adding the same key with different value
+  pos2 =3D kh_put_str(hashmap, "test_key", &ret);
+  if (!ret)
+    return 0;
+  kh_key(hashmap, pos2) =3D xstrdup("test_key");
+  kh_value(hashmap, pos2) =3D &value2;
+  // check if the value is different
+  return *kh_value(hashmap, kh_get_str(hashmap, "test_key")) =3D=3D value2=
;
+}
+
+int hashmap_size_matches_number_of_added_elements() {
+  int ret, value1 =3D 14, value2 =3D 15, value3 =3D 16;
+  khint_t pos1, pos2, pos3;
+  kh_str_t *hashmap =3D kh_init_str();
+  pos1 =3D kh_put_str(hashmap, "test_key1", &ret);
+  if (!ret)
+    return 0;
+  kh_key(hashmap, pos1) =3D xstrdup("test_key1");
+  kh_value(hashmap, pos1) =3D &value1;
+  pos2 =3D kh_put_str(hashmap, "test_key2", &ret);
+  if (!ret)
+    return 0;
+  kh_key(hashmap, pos2) =3D xstrdup("test_key2");
+  kh_value(hashmap, pos2) =3D &value2;
+  pos3 =3D kh_put_str(hashmap, "test_key3", &ret);
+  if (!ret)
+    return 0;
+  kh_key(hashmap, pos3) =3D xstrdup("test_key3");
+  kh_value(hashmap, pos3) =3D &value3;
+  return kh_size(hashmap) =3D=3D 3;
+}
+
+int main(void) {
+  plan(14);
+
+  ok(hash_string_succeeds(), "X31 hash value of a string is correct");
+  ok(hash_string_with_non_alphabets_succeeds(),
+     "Get X31 hash value for a string with non-alphabets in it.");
+  ok(initialized_hashmap_pointer_not_null(),
+     "Successfully initialize a hashmap and it's not NULL");
+  ok(put_key_into_hashmap_once_succeeds(),
+     "Put a key into hashmap that doesn't exist.");
+  ok(put_same_key_into_hashmap_twice_fails(),
+     "Put a key into hashmap twice that causes collision.");
+  ok(put_value_into_hashmap_once_succeeds(),
+     "Put a unique key-value pair into hashmap.");
+  ok(put_same_value_into_hashmap_twice_fails(),
+     "Put a key-value pair into hashmap twice that causes collision.");
+  ok(get_existing_kv_from_hashmap_succeeds(),
+     "Get the value from a key that exists in hashmap");
+  ok(get_nonexisting_kv_from_hashmap_fails(),
+     "Get the value from a key that doesn't exist in hashmap");
+  ok(deletion_from_hashmap_sets_flag(),
+     "Delete the key-value from hashmap and the flag is set to false");
+  ok(deletion_from_hashmap_updates_size(),
+     "Delete the key-value from hashmap and the size changes");
+  ok(deletion_from_hashmap_does_not_update_kv(),
+     "Delete the key-value from hashmap but it can be fetched using iterat=
or");
+  ok(update_value_after_deletion_succeeds(),
+     "Updates the value of a key after deleting it");
+  ok(hashmap_size_matches_number_of_added_elements(),
+     "size of hashmap is correct after adding 3 elements");
+
+  return 0;
+}
--=20
2.40.GIT

