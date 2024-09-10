Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D5D18CC1D
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935366; cv=none; b=IMAoDq9pICyfHJadzPnjnSA+4B9RUgNfHbYysZTJa975gTVkpgwzzUpxxE/WqRpFwPuqrodvBqlTw8/m54IOFZu0g6JlRI93KeeVAneUhPNHtIlGhcgW3gDytodbC22jVnS+xnS63MlpHFHiH9ZGIZobBm5Eohb46yhWBGNgPeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935366; c=relaxed/simple;
	bh=OZnbhNCEYjp5OWn9TAKT7RyVIJ5N4TUrfQmrSS8Xe1k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JoWrxp5pKRMfPZg+1JPYQa7Noawa93pazQDtbgcakmNcXpwl1Mn16OTU4mtzw3pHq4Pwk9ukay5RSw+pA65wWC3XMeTHT77Eh4NoWsI1a/mUscusKOCMmenfW2QZCVOoi6m6Aj7A7e/71iERfYvWmo/70LX8kYmFCLxdGJU+/gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5sTQ1Xa; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5sTQ1Xa"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d13b83511so361277666b.2
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935363; x=1726540163; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MhPFwdntLbOgzsZ2XNlug6y7NZQg41ztPKUhv4oIYM=;
        b=m5sTQ1Xa7QvUJ9uKqEnM+iK0niVt8JD3hlgqPVQRMmX5EbeuLimq4NPDLnOfUMDB2K
         fHwzmL2m6QYIsV/XuvDy/ppkhRhiJmfhULm18lhJYdhFWpfnFPw5joSxZRKopgSlST4f
         L0PX8BeOJaXJzOe6gZC/rmRljeWOVMCiSEoaamrsOwHJIzHZGgedraiqJOukX1UmYzNH
         Sb+y31emz9jncSZ6G0coTl6m2IHGDgvAtvahmuSaNW09+0mfhp5nIHju8lZJMxoE89Qs
         3wncy7sM+bbyOqzKJyhae8jNBeV1c8kESfZBdYZ0zB7C5M0gEzQVhtsX//RQJ3h/jEbM
         CdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935363; x=1726540163;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MhPFwdntLbOgzsZ2XNlug6y7NZQg41ztPKUhv4oIYM=;
        b=qJKpG1lI+xNMQzE7KQt68k2T4Vybx9bHDjm3X9yZ2HpicfG52F+sIlRF5g0Mpq+Akx
         KmcXr3yAL6AugdegXxlixns3quWBzGeXI37PV7mE7KP2nvnsJ9yfKo0Wcf3KxiST0ud0
         iIn1UIG12VU89MMI4gZ/zZWTUHuZjt9kp4kWFGOlmVedvKNEEHSBsIA60eRLKB4+ue9N
         fjWOp1395fBUjM3hqQ7BSSbbpT117hqrJmt8yz0NdKvnJ/zYjkbWiYRQVTLkF894ImHF
         56s3uKAfE/s0hDM9MrShEhjgvDu5FqpUJ0rpdER6hMIsyJf9NYsFyD1yoIIy8ACnSWAp
         W17Q==
X-Gm-Message-State: AOJu0YxgRsNe+mmbi6JnD0nyRna4CUmYMl3sRZZ5afH6SG2URVNpAVAx
	/5EU2RwEYbIhvlmJwjKvOhjNG/szgjK9i3f+UkHkQspa3JSeIAfsI8yA0A==
X-Google-Smtp-Source: AGHT+IHp4v/GmvHcQTFBZ+nQalOaPB6p+g72tGs2ZqViMQ+KhFQGYpkLeSXcmQS1wIufHb1yQTQtTQ==
X-Received: by 2002:a17:907:3201:b0:a8a:3f78:7b7b with SMTP id a640c23a62f3a-a8a885f4353mr1100370766b.14.1725935362869;
        Mon, 09 Sep 2024 19:29:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a073b1sm412742066b.82.2024.09.09.19.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:22 -0700 (PDT)
Message-Id: <8df39a432fa682212d53d31389d437e86b4513f6.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:53 +0000
Subject: [PATCH 28/30] test-name-hash: add helper to compute name-hash
 functions
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Using this tool, we can count how many distinct name-hash values exist
within a list of paths. Examples include

 git ls-tree -r --name-only HEAD | \
	     test-tool name-hash | \
  	      awk "{print \$1;}" | \
  		 sort -ns | uniq | wc -l

which outputs the number of distinct name-hash values that appear at
HEAD. Or, the following which presents the resulting name-hash values of
maximum multiplicity:

 git ls-tree -r --name-only HEAD | \
	     test-tool name-hash | \
	      awk "{print \$1;}" | \
	       sort -n | uniq -c | sort -nr | head -n 25

For an internal monorepo with around a quarter million paths at HEAD,
the highest multiplicity for the standard name-hash function was 14,424
while the full name-hash algorithm had only seven hash values with any
collision, with a maximum multiplicity of two.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Makefile                  |  1 +
 t/helper/test-name-hash.c | 23 +++++++++++++++++++++++
 t/helper/test-tool.c      |  1 +
 t/helper/test-tool.h      |  1 +
 4 files changed, 26 insertions(+)
 create mode 100644 t/helper/test-name-hash.c

diff --git a/Makefile b/Makefile
index 154de6e01d0..462aff65a50 100644
--- a/Makefile
+++ b/Makefile
@@ -808,6 +808,7 @@ TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-match-trees.o
 TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
+TEST_BUILTINS_OBJS += test-name-hash.o
 TEST_BUILTINS_OBJS += test-oid-array.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-pack-mtimes.o
diff --git a/t/helper/test-name-hash.c b/t/helper/test-name-hash.c
new file mode 100644
index 00000000000..c82ccd7cefd
--- /dev/null
+++ b/t/helper/test-name-hash.c
@@ -0,0 +1,23 @@
+/*
+ * test-name-hash.c: Read a list of paths over stdin and report on their
+ * name-hash and full name-hash.
+ */
+
+#include "test-tool.h"
+#include "git-compat-util.h"
+#include "pack-objects.h"
+#include "strbuf.h"
+
+int cmd__name_hash(int argc, const char **argv)
+{
+	struct strbuf line = STRBUF_INIT;
+
+	while (!strbuf_getline(&line, stdin)) {
+		uint32_t name_hash = pack_name_hash(line.buf);
+		uint32_t full_hash = pack_full_name_hash(line.buf);
+
+		printf("%10"PRIu32"\t%10"PRIu32"\t%s\n", name_hash, full_hash, line.buf);
+	}
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index f8a67df7de9..4a603921002 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -43,6 +43,7 @@ static struct test_cmd cmds[] = {
 	{ "match-trees", cmd__match_trees },
 	{ "mergesort", cmd__mergesort },
 	{ "mktemp", cmd__mktemp },
+	{ "name-hash", cmd__name_hash },
 	{ "oid-array", cmd__oid_array },
 	{ "online-cpus", cmd__online_cpus },
 	{ "pack-mtimes", cmd__pack_mtimes },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index e74bc0ffd41..56a83bf3aac 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -37,6 +37,7 @@ int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__match_trees(int argc, const char **argv);
 int cmd__mergesort(int argc, const char **argv);
 int cmd__mktemp(int argc, const char **argv);
+int cmd__name_hash(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
 int cmd__pack_mtimes(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
-- 
gitgitgadget

