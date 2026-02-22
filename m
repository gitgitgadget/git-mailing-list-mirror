Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0732E3EBF33
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 00:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771720184; cv=pass; b=fAngNKMU2UOKCGfq5BSaXXFaevTBvy8oUmX6CoNJkbFRieoKDV7DObKtu6WfeBSv4qo2r0UcHxPFw/QiGdl4ec5gBUuVOyvcj+dedpn0MiKFI6SolykJorNhlhSgKudBDloIzjaFRtQZnqnnYuErCENI4qJMjH0W5e3Q1D12eFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771720184; c=relaxed/simple;
	bh=c0SkI4o7W7G2BLyCprFUQd+fWNx2rhQb6KToBRz7hKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4g48mQwyqtPVjTLXD/WUWe0WRQIISd0x4eGp1jTtLE1/cLKpW1W8mvjHdga9aazjuWmO/jNyZWhnbou5+iSsppU3AZGXm5LV7Ru2YEeAkT5y0+4uhnFpZJZgkia4hzgfvZnTjwlZe2BxyEhVjnn43vUEwNWkqOaXex07Tirj30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=iKxSsIMB; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="iKxSsIMB"
ARC-Seal: i=1; a=rsa-sha256; t=1771720165; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=a/KRk38M+V6EOdcCk0mMroK6ZfTbnyrOyl+HLK+Y6+i7ve8txUdytNTIoXEeXWhNDotqDbu3+Zy5An3kgM9AcwOy7kf2CyOiaV6goenTMSzbMLH8RryVao2+BxkSFwib3NGv0NorpWP0AKO8xdXZCRr7UYGSS3mX1aVhfu4OrRw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771720165; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=b5D73cNB3fv5JB/dOhoTUm707VcUqkGJ8774kr+d1L8=; 
	b=CK1rV+O5EKCu0M5aVujdGfNo/MWH7VldGwrWToKZvj+3KQ2m26A9npF4HwP9CRucX8OLq1rySfqkdDYpGUfvYiOANvWyNvqzRgxnIY89wYNxtTLLr4TjRP4r/0LoXf/ma1KH9d1ISA/OtSh4zr7St06jsOjRMFgpoQswx+UKH08=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771720164;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=b5D73cNB3fv5JB/dOhoTUm707VcUqkGJ8774kr+d1L8=;
	b=iKxSsIMBG6Han6B17ptWAgs9xE4JX4ajs/aTBVV387sEuMRODAqhRgcYaEUuns4P
	oQ2p7n/vhACjB5kRIStGPW14MQlS1/A4lmWxSUPQNXvH9amT7MnviNiTKgzfuZhdz/V
	daIywG7PC8rHB1MCBTLvbQKbjgn4hNeakQTJbs3g=
Received: by mx.zohomail.com with SMTPS id 1771720161688729.1395863031851;
	Sat, 21 Feb 2026 16:29:21 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 02/10] config: add a repo_config_get_uint() helper
Date: Sun, 22 Feb 2026 02:28:56 +0200
Message-ID: <20260222002904.1879356-3-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260222002904.1879356-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260222002904.1879356-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Next commits add a 'hook.jobs' config option of type 'unsigned int',
so add a helper to parse it since the API only supports int and ulong.

An alternative is to make 'hook.jobs' an 'int' or parse it as an 'int'
then cast it to unsigned, however it's better to use proper helpers for
the type. Using 'ulong' is another option which already has helpers, but
it's a bit excessive in size for just the jobs number.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 config.c | 28 ++++++++++++++++++++++++++++
 config.h | 13 +++++++++++++
 parse.c  |  9 +++++++++
 parse.h  |  1 +
 4 files changed, 51 insertions(+)

diff --git a/config.c b/config.c
index 156f2a24fa..a1b92fe083 100644
--- a/config.c
+++ b/config.c
@@ -1212,6 +1212,15 @@ int git_config_int(const char *name, const char *value,
 	return ret;
 }
 
+unsigned int git_config_uint(const char *name, const char *value,
+			     const struct key_value_info *kvi)
+{
+	unsigned int ret;
+	if (!git_parse_uint(value, &ret))
+		die_bad_number(name, value, kvi);
+	return ret;
+}
+
 int64_t git_config_int64(const char *name, const char *value,
 			 const struct key_value_info *kvi)
 {
@@ -1907,6 +1916,18 @@ int git_configset_get_int(struct config_set *set, const char *key, int *dest)
 		return 1;
 }
 
+int git_configset_get_uint(struct config_set *set, const char *key, unsigned int *dest)
+{
+	const char *value;
+	struct key_value_info kvi;
+
+	if (!git_configset_get_value(set, key, &value, &kvi)) {
+		*dest = git_config_uint(key, value, &kvi);
+		return 0;
+	} else
+		return 1;
+}
+
 int git_configset_get_ulong(struct config_set *set, const char *key, unsigned long *dest)
 {
 	const char *value;
@@ -2356,6 +2377,13 @@ int repo_config_get_int(struct repository *repo,
 	return git_configset_get_int(repo->config, key, dest);
 }
 
+int repo_config_get_uint(struct repository *repo,
+			 const char *key, unsigned int *dest)
+{
+	git_config_check_init(repo);
+	return git_configset_get_uint(repo->config, key, dest);
+}
+
 int repo_config_get_ulong(struct repository *repo,
 			  const char *key, unsigned long *dest)
 {
diff --git a/config.h b/config.h
index ba426a960a..bf47fb3afc 100644
--- a/config.h
+++ b/config.h
@@ -267,6 +267,12 @@ int git_config_int(const char *, const char *, const struct key_value_info *);
 int64_t git_config_int64(const char *, const char *,
 			 const struct key_value_info *);
 
+/**
+ * Identical to `git_config_int`, but for unsigned ints.
+ */
+unsigned int git_config_uint(const char *, const char *,
+			     const struct key_value_info *);
+
 /**
  * Identical to `git_config_int`, but for unsigned longs.
  */
@@ -560,6 +566,7 @@ int git_configset_get_value(struct config_set *cs, const char *key,
 
 int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
 int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
+int git_configset_get_uint(struct config_set *cs, const char *key, unsigned int *dest);
 int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned long *dest);
 int git_configset_get_bool(struct config_set *cs, const char *key, int *dest);
 int git_configset_get_bool_or_int(struct config_set *cs, const char *key, int *is_bool, int *dest);
@@ -650,6 +657,12 @@ int repo_config_get_string_tmp(struct repository *r,
  */
 int repo_config_get_int(struct repository *r, const char *key, int *dest);
 
+/**
+ * Similar to `repo_config_get_int` but for unsigned ints.
+ */
+int repo_config_get_uint(struct repository *r,
+			 const char *key, unsigned int *dest);
+
 /**
  * Similar to `repo_config_get_int` but for unsigned longs.
  */
diff --git a/parse.c b/parse.c
index 48313571aa..d77f28046a 100644
--- a/parse.c
+++ b/parse.c
@@ -107,6 +107,15 @@ int git_parse_int64(const char *value, int64_t *ret)
 	return 1;
 }
 
+int git_parse_uint(const char *value, unsigned int *ret)
+{
+	uintmax_t tmp;
+	if (!git_parse_unsigned(value, &tmp, maximum_unsigned_value_of_type(unsigned int)))
+		return 0;
+	*ret = tmp;
+	return 1;
+}
+
 int git_parse_ulong(const char *value, unsigned long *ret)
 {
 	uintmax_t tmp;
diff --git a/parse.h b/parse.h
index ea32de9a91..a6dd37c4cb 100644
--- a/parse.h
+++ b/parse.h
@@ -5,6 +5,7 @@ int git_parse_signed(const char *value, intmax_t *ret, intmax_t max);
 int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max);
 int git_parse_ssize_t(const char *, ssize_t *);
 int git_parse_ulong(const char *, unsigned long *);
+int git_parse_uint(const char *value, unsigned int *ret);
 int git_parse_int(const char *value, int *ret);
 int git_parse_int64(const char *value, int64_t *ret);
 int git_parse_double(const char *value, double *ret);
-- 
2.52.0.732.gb351b5166d.dirty

