Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9D2388E7A
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 23:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787182095; cv=none; b=HXoVtkafcOPLSyl4xDL3IWg8j2Fx+3c+gJbkLYnUDPO9q+sP5MBN6i65SiuQY4h5eJjQFxEm0dj9KelGX5Ii5RsUW9ve0C1TcT6vASNoIdZAYm4tp/b8W4fee4xepDfJKyAM/dHfA5nPGv3RM/reAW2KD8U3wWjOGJqvr2brtXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787182095; c=relaxed/simple;
	bh=tuYm/x6EumxoYa5bjCvngMcrByseOU/z+7zPmwarah4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRckRbo+VMJJrE2zzqzajj97jHXtXFDL0CfSFLheIMpAs2SaVRNBsM117FzOky6YM60tO97UtcVWSAO37XZn6ihs4bHQDxY9rGaxMTm9VaWLFC3Uwe3If3bJ4eS9piV3FeBSl9FdqAw9qCJ8JXLnbm3E4DhfzWUzy99C4hBUrJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=EurM+m2l; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="EurM+m2l"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso11709316d6.3
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 16:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1787182092; x=1787786892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BZZfMrOuUdI4z+6pHJ76+JC1FgcNvMAUhiqyddcKoGQ=;
        b=EurM+m2l5lpE/6M18X4ebZ2aSEQRSfrISkM1PR9g3VXs8nAjI3tPSXPoSdTMdUA8Ep
         johbY9KpTz6p4hw/7laIxm3nuT5uf6ggm14UNBcimWeDbk8FjNoCFUGnX6q8HveoPOok
         TFhFRnX/sFj88iRbMVLlpLxFZwPywrJE79bFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787182092; x=1787786892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BZZfMrOuUdI4z+6pHJ76+JC1FgcNvMAUhiqyddcKoGQ=;
        b=C3GL4ny/zfj3UbgbMWWkI1NjilmCV87QyIjZY28+NBj7bP+nvpZeoctt2K5BbItMue
         LS5wSRMKsSI4GJuXbrXpXlcyX7X2wLC5vjyYPDbmxInV6s9SURyZqGiLZDDqORY/Fvz1
         kVslENEJj1V4mvtdo+5Jie/QTiG8xWosqKsPeHUQOoyCn8yfzjOFNH+kHYiLDBGu4huW
         Q2NBjJu/oQUpMe7MZRiwDRNsoaTc+yhUi9POFSiU2Glxl5cqdTkiuB2JnxG1IWBtENeO
         NNljP37a+E4xqcb2tJMSGZv7F1CbKw0FYb+EjqmLBO7rUX6XB4Z1dgtSBC24RSs3rxlE
         AplA==
X-Gm-Message-State: AFuF++lnOs8Sv4eq5O+EbG7U6PF3s6NKNOa/u4BUZlnM2GN+Y4tOOskp
	enJGwuKUWwy6F6kwvxuuV5DaXWh1S23F8fDjiuGDRvx9BC41fuQ0ejy1LX1BBNAoTl2Tca2Kuby
	cFXpCevU=
X-Gm-Gg: AR+sD124YxtMdOMEnjRXJirMww9mXsaYBsj5SCVJ3hMm4XXsAOQnR0dCABN3tR3P+Tt
	l3zqcYovEPURCZAJyXtZK8U797OkuCLJ6rnqucHWZTPWmyCabiOwWOazoTWeDsjP2Fz+ijjZ5gp
	f/nC7r4vyTEmpjyxQeT+gdMI3R34zdWtH4Bw/wz7yad/Yoml/V7AAajQewTWb+5sfSfQ/YDcOXC
	EUnFf/xRm8BF/Qc/Z3QCNcHDNJ6wR5KcuHJnLk39jehCK7oAaLMDWbRI1WwKrCQ08exTPvwiCLm
	HNo/Kj30MRwDenKZXJd4uYSC5OFEVKTxDaPxdLqQa3iY1IV7oAUBlMywJ2jwBj9yhxlyofA0zbV
	kX/Xpbnz28/HxcwdXvHU6y7C+52yBgcGnS9wLDK/i5AXKVH4CGzs2Z3Ng6Rwg7ll7ZDYWWOBgM4
	vnPsDC1HzmjjQC9QVfj31oD3KEvDgr2CAPTvlyVljxtADoRNXosz0Ld0nWjunvE8d8GyWRQCifW
	uaGle/ObuoHEWEu
X-Received: by 2002:a05:6214:76f:b0:907:c6bb:5ce4 with SMTP id 6a1803df08f44-90c5eaf2e7amr87117446d6.32.1787182092499;
        Wed, 19 Aug 2026 16:28:12 -0700 (PDT)
Received: from com-58127.corp.openai.org ([199.47.143.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5f28feffsm24940316d6.27.2026.08.19.16.28.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Aug 2026 16:28:11 -0700 (PDT)
From: friel@openai.com
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: [PATCH v2] pack-objects: trace pack bytes written
Date: Wed, 19 Aug 2026 16:28:10 -0700
Message-ID: <c6a8cdac36d2202055d637ebcc97e484122cdcd4.1787158152.git.friel@openai.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqqo6f02q2f.fsf@gitster.g>
References: <20260817233914.8740-2-friel@openai.com> <xmqqo6f02q2f.fsf@gitster.g>
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
Junio, you're right. Updating bytes_written before finalization is
equivalent. I've dropped pack_bytes; everything else is unchanged.
Thanks.

 builtin/pack-objects.c |  5 +++++
 t/t5300-pack-object.sh | 24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1ec5b6f206..252530172c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1337,6 +1337,7 @@ static void write_pack_file(void)
 	uint32_t nr_remaining = nr_result;
 	time_t last_mtime = 0;
 	struct object_entry **write_order;
+	off_t bytes_written = 0;
 
 	if (progress > pack_to_stdout)
 		progress_state = start_progress(the_repository,
@@ -1389,6 +1390,8 @@ static void write_pack_file(void)
 			display_progress(progress_state, written);
 		}
 
+		bytes_written += hashfile_total(f) +
+			the_repository->hash_algo->rawsz;
 		if (pack_to_stdout) {
 			/*
 			 * We never fsync when writing to stdout since we may
@@ -1510,6 +1513,8 @@ static void write_pack_file(void)
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

Interdiff against v1:
  diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
  index bbf1adb437..252530172c 100644
  --- a/builtin/pack-objects.c
  +++ b/builtin/pack-objects.c
  @@ -1348,7 +1348,6 @@ static void write_pack_file(void)
   	do {
   		unsigned char hash[GIT_MAX_RAWSZ];
   		char *pack_tmp_name = NULL;
  -		off_t pack_bytes;
   
   		if (pack_to_stdout) {
   			/*
  @@ -1391,7 +1390,7 @@ static void write_pack_file(void)
   			display_progress(progress_state, written);
   		}
   
  -		pack_bytes = hashfile_total(f) +
  +		bytes_written += hashfile_total(f) +
   			the_repository->hash_algo->rawsz;
   		if (pack_to_stdout) {
   			/*
  @@ -1423,7 +1422,6 @@ static void write_pack_file(void)
   				write_bitmap_index = 0;
   			}
   		}
  -		bytes_written += pack_bytes;
   
   		if (!pack_to_stdout) {
   			struct stat st;

base-commit: 18e66859d87fb4b76599f73460b54f0848c76b16
