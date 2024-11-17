Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1F47462
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 01:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731807124; cv=none; b=q/A0CSnnTGJvwmYV11Rvnyuch1FwC9Vbcn3NmQ+nobEYLMPhMzFKbbFvnGpRjkk9cy8RD2CmtLdSO7PiqpUAT6Lh6qk7c7WPEkX6QW3yiWJPyMWLAxlgGiR4icOEd3b+Vq2pVDlaCDs7+3GaHQG1aeuY7+fnIfuHV4xzS9pU3mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731807124; c=relaxed/simple;
	bh=Hzyf1CFMPpffb+csxhpqOAD+QjqqdA97Gvqyit/qX1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHJDlfqvyovdfnz5cBcw89Q3vyaRETYCMKO6TMUsOAHkJ8+3vET1b3ePW4n7n881BitooBnmi+97Pjsy6vViMot9+ta9skrEZSLcjvfBiVwZ1sjO1bCUpu1Wj2pG33xQyGkPPwwUFD0pRMQVOyEG8SF+wVKZzME4AlFFiDNBrBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=kF79sDoh; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="kF79sDoh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1731807115;
	bh=Hzyf1CFMPpffb+csxhpqOAD+QjqqdA97Gvqyit/qX1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=kF79sDohibKJi5kTPFThObb5tDEoC8njmeXs+uI8mi+sqIbnGndHk2d87A17k5a2k
	 4UUaXxVO83zA2eXm34BuAwzIqjC917lMNqSK8MMhtwJ9PCzXIXujb2iecsPk6P8RCC
	 OwwYtOjsaM8UkbsSqIvUg4nd6hrLZlAJLPhWcrWQeEMx6eh3sYoXJzhzxHiVbwBJVN
	 yIda35UGP8O/KXOuSqwngov54Q5opud9tq5nswYMNTuslOedqTaLSrQrf4BFbMOJns
	 N1RmQyK56fVNlue1llqLmvrOVkIsfcuydF4I37MGOlZjZu0MxABi3tHXBEb8hDKmdm
	 D8UWjutUH4mpHpF3PrOVRRehfOXImepFjXhmKIrMQhdrl4BPICuT04z17WawFgDxgb
	 D/oaBnlwKJaJTO3UkEExAo/lT8b3rxifX4k0SSVZawxsC9mB3joYqru/pwtMxRf3pp
	 MS/sN5p9/N1N2xfumRTmk6dymw6eagr4NX7q+Gc0iejE5o8yHPc
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4244724444;
	Sun, 17 Nov 2024 01:31:55 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sam James <sam@gentoo.org>
Subject: [PATCH 1/2] index-pack: rename struct thread_local
Date: Sun, 17 Nov 2024 01:31:48 +0000
Message-ID: <20241117013149.576671-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20241117013149.576671-1-sandals@crustytoothpaste.net>
References: <87ed3apy2u.fsf@gentoo.org>
 <20241117013149.576671-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"thread_local" is a keyword in C23.  To make sure that our code compiles
on a wide variety of C versions, rename struct thread_local to "struct
thread_local_data" to avoid a conflict.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/index-pack.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 9d23b41b3a..a6942233e5 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -94,7 +94,7 @@ static LIST_HEAD(done_head);
 static size_t base_cache_used;
 static size_t base_cache_limit;
 
-struct thread_local {
+struct thread_local_data {
 	pthread_t thread;
 	int pack_fd;
 };
@@ -117,7 +117,7 @@ static struct object_entry *objects;
 static struct object_stat *obj_stat;
 static struct ofs_delta_entry *ofs_deltas;
 static struct ref_delta_entry *ref_deltas;
-static struct thread_local nothread_data;
+static struct thread_local_data nothread_data;
 static int nr_objects;
 static int nr_ofs_deltas;
 static int nr_ref_deltas;
@@ -148,7 +148,7 @@ static uint32_t input_crc32;
 static int input_fd, output_fd;
 static const char *curr_pack;
 
-static struct thread_local *thread_data;
+static struct thread_local_data *thread_data;
 static int nr_dispatched;
 static int threads_active;
 
@@ -390,7 +390,7 @@ static NORETURN void bad_object(off_t offset, const char *format, ...)
 	    (uintmax_t)offset, buf);
 }
 
-static inline struct thread_local *get_thread_data(void)
+static inline struct thread_local_data *get_thread_data(void)
 {
 	if (HAVE_THREADS) {
 		if (threads_active)
@@ -401,7 +401,7 @@ static inline struct thread_local *get_thread_data(void)
 	return &nothread_data;
 }
 
-static void set_thread_data(struct thread_local *data)
+static void set_thread_data(struct thread_local_data *data)
 {
 	if (threads_active)
 		pthread_setspecific(key, data);
