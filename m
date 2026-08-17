Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95103ECBED
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 23:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009959; cv=none; b=gB3LVnTSVVJcqYGqala7JIv9inusNtaD+ajD0dMDHwJHkKvFd7Fv0fKfFh3TwNy4H708MY72y3whI4RWUWQDmRpL9Br1M1uV7e/k5XzyzsSfCkjzeDhyp6lT/jaJxfYb6G/NhgKzDTwBjoLyb9zpRw0L/S5FrZUpfK3AAAwHY4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009959; c=relaxed/simple;
	bh=EeTCbpr6r3KS+1qAbErhOjXUquaRcqM99LoRlROhHaE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=la/fKXtavqEfr84zfF51ybvhOhA70G6ZZadJ2loUMHMg4e3Z9vLlLAvDPiFDG2k++46na/n+8OIe679RHzUESkZwIWBJO3RO+HgB178w4lJLd7QUC/Y0VdwuumcU7am0P35mdhconG2ACnaS9ZvddnFhWw3JTmMEUmeQsZBdSx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=SIvyI2A/; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="SIvyI2A/"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92f03daaa97so228723685a.2
        for <git@vger.kernel.org>; Mon, 17 Aug 2026 16:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1787009957; x=1787614757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ppYM4AefGz2maTWbufd1Bux9vGDWcBt4rHEV7yRpHLU=;
        b=SIvyI2A/ixG5/tfO3VjcmL1HiEsRr7jAUqbzB33kv1GKa3V/soiBRIxLTgrmfFZWkJ
         Mlx6v07nmixE+hnMS17daDZng5GQdkKSQ0DJcReUIzwXXee1JVYryQqJcFB3UfpUNji3
         NdG0TtuOkIn3fYum035o1smIgiIwRX4FkKqtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787009957; x=1787614757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ppYM4AefGz2maTWbufd1Bux9vGDWcBt4rHEV7yRpHLU=;
        b=iyS0SC8v5f0UduxeplNIQdC6MwGXx//YmMbA49cUS/+LvSNMCAs5vLj9UoYHlkUjSF
         eRE1w+scHVdeVuFs/APfYcD+vrUY1B5vOhYd5LbNeCtKiT8FVUgg/fbjDPcxUUfFw57f
         m+IHQ54eBDDQNxbZOAEDBQr87EXgO4+k/ckd6qSQoU97ULW3JZd1dTCg5+5LE6YYTGAw
         9p+lGbSSUYeH8F5GB9WDJgVSPFaO6BhejMvfeZCHid3GHZ0f1wCjzxBymKM0e8EgTofw
         COw35T9WRVoumsz5n96dV/e45ESCn4X9bMSERBXnAyjOj2UCydskBB8eNWe3TepQdz9+
         gHiA==
X-Gm-Message-State: AOJu0YzuQUjVIddBK3js8M9WQE7pMnkNOZpMb9bfBggeH+lcMdf9dR89
	msKVUvqFcyppyUlkollOj1IzgRIysJ/bTIL8H5VNR138lPgsiYuH8mBZc9UNLtvRX0ALtfxGMBE
	S555Cq2w=
X-Gm-Gg: AR+sD10sDxrXeZ46Ywkn1bNY1+1MgJzTqL9uXZblu1Wra4D7bwA3gFV01K1h4Zvf/3D
	KEe17k9Il3O2jZR1IJjNLxtOcTuVjeDtVKV/dhtdpDZ6/51Okex9TiKsiWg6PxWBE7qyUZYCZUa
	PYBUV74xM6VW2aXu3L4IULqkwFu9w8+2wrLwhYu0ssJ3hShr5IgUpXEksfd6A0bYZ7avV/zgkyl
	92WCItpkxqPCB1yn8a+WLWhSwr7f6fxp9/GRp/NT3CogKqYDncQlYKnkFtdJdPlre1ocTa1Oit9
	frb8Dz8pQwRQARHCnIVyxkscuCsujIR1AvMTBBU82A31KH8xc3eq+EbJIe6F2I8tN0OMdz9fSlr
	qWEVWm44Awc0cMU/uAMSYVDc4L/wHKtKtPPNsxpsiZd/zq9CE4LuRHEU3KXN98OtFHlziiny2jn
	Y0eVWSXI7dA6ZTTq6gDyUflwyo6OJE0PxVnfPlaAX1ms0bfrHdJEzKbX6k6XReFhkPXatN0bErp
	VtmCbWfJnfi+dQr4JcpDXeT8yU=
X-Received: by 2002:a05:620a:1235:b0:932:fd59:3e57 with SMTP id af79cd13be357-936d233ca52mr2388997385a.41.1787009956577;
        Mon, 17 Aug 2026 16:39:16 -0700 (PDT)
Received: from com-58127.corp.openai.org ([199.47.143.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93703429b4bsm155937385a.43.2026.08.17.16.39.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Aug 2026 16:39:16 -0700 (PDT)
From: friel@openai.com
To: git@vger.kernel.org
Subject: [PATCH] pack-objects: trace pack bytes written
Date: Mon, 17 Aug 2026 16:39:15 -0700
Message-ID: <20260817233914.8740-2-friel@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Friel <friel@openai.com>

We want to measure how compression settings affect push performance on
the client. Different settings can produce different-sized packs from
the same objects. Trace2 records the object count, but we also need the
pack size to compare those settings.

Add a write_pack_file/wrote_bytes Trace2 datum alongside
write_pack_file/wrote. Count packs written to stdout or disk, including
each pack's header and trailing checksum. When pack.packSizeLimit splits
the output, report the sum of the pack sizes.

Signed-off-by: Friel <friel@openai.com>
---
 builtin/pack-objects.c |  7 +++++++
 t/t5300-pack-object.sh | 24 ++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1ec5b6f206..bbf1adb437 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1337,6 +1337,7 @@ static void write_pack_file(void)
 	uint32_t nr_remaining = nr_result;
 	time_t last_mtime = 0;
 	struct object_entry **write_order;
+	off_t bytes_written = 0;
 
 	if (progress > pack_to_stdout)
 		progress_state = start_progress(the_repository,
@@ -1347,6 +1348,7 @@ static void write_pack_file(void)
 	do {
 		unsigned char hash[GIT_MAX_RAWSZ];
 		char *pack_tmp_name = NULL;
+		off_t pack_bytes;
 
 		if (pack_to_stdout) {
 			/*
@@ -1389,6 +1391,8 @@ static void write_pack_file(void)
 			display_progress(progress_state, written);
 		}
 
+		pack_bytes = hashfile_total(f) +
+			the_repository->hash_algo->rawsz;
 		if (pack_to_stdout) {
 			/*
 			 * We never fsync when writing to stdout since we may
@@ -1419,6 +1423,7 @@ static void write_pack_file(void)
 				write_bitmap_index = 0;
 			}
 		}
+		bytes_written += pack_bytes;
 
 		if (!pack_to_stdout) {
 			struct stat st;
@@ -1510,6 +1515,8 @@ static void write_pack_file(void)
 		    written, nr_result);
 	trace2_data_intmax("pack-objects", the_repository,
 			   "write_pack_file/wrote", nr_result);
+	trace2_data_intmax("pack-objects", the_repository,
+			   "write_pack_file/wrote_bytes", bytes_written);
 }
 
 static int no_try_delta(const char *path)
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 9dabb3615a..aac139e6a0 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -33,6 +33,30 @@ test_expect_success 'setup' '
 	} >expect
 '
 
+test_expect_success 'pack-object traces bytes written to stdout' '
+	test_when_finished "rm -f pack.trace pack.pack" &&
+	GIT_TRACE2_EVENT="$PWD/pack.trace" \
+		git pack-objects --quiet --revs --stdout >pack.pack <<-EOF &&
+	$commit
+	EOF
+	bytes=$(test_file_size pack.pack) &&
+	test_grep "\"key\":\"write_pack_file/wrote_bytes\",\"value\":\"$bytes\"" pack.trace
+'
+
+test_expect_success 'pack-object traces bytes written to split pack files' '
+	test_when_finished "rm -f split.trace traced-pack-*" &&
+	GIT_TRACE2_EVENT="$PWD/split.trace" \
+		git -c pack.packSizeLimit=3m pack-objects --quiet traced-pack <obj-list &&
+	test 2 = $(ls traced-pack-*.pack | wc -l) &&
+	bytes=0 &&
+	for pack in traced-pack-*.pack
+	do
+		pack_size=$(test_file_size "$pack") &&
+		bytes=$((bytes + pack_size)) || return 1
+	done &&
+	test_grep "\"key\":\"write_pack_file/wrote_bytes\",\"value\":\"$bytes\"" split.trace
+'
+
 test_expect_success 'setup pack-object <stdin' '
 	git init pack-object-stdin &&
 	test_commit -C pack-object-stdin one &&

base-commit: 18e66859d87fb4b76599f73460b54f0848c76b16
