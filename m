Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F4615ADB1
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 22:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661290; cv=none; b=IfNGlnGozjKY7zi1Ci+zQIOe4/OZdkPQc57+ZwVw+hJxlSqiLa5Q4LUvCv/E2kdIAY4fmHPulVFOKZjcVpty/hf2ikztLPlGhXRgxF94eoTjCfq2Cq47PefYIKzgDKB+Fk47kEfFg2FNOeD6wMcef/ek4FQ12LFVGFpEldPtPCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661290; c=relaxed/simple;
	bh=IXmU79gdG/icTWTSWtZq6xpmqqsEzvlYOuCdyVQRf08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MTSIPic4RNJ4o0zoyMGVjkmHoTkL/MoFrSEzu/6xlxOZEXgl9tNlETHpoLhBH5Wta1khY/cOxUccwuF58HXAIeLAJ1IkkjAJIYXPEahmVpOKFltqsnH8od5l7swaxSZWY84RSSl5HjhtcGviAYNJk2pA9SMIOcBxrUHYiDnT0Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hvKMYq6/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hvKMYq6/"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2053f49d0c9so41591065ad.1
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 15:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725661289; x=1726266089; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UixZiE6IiF+TJjsM/CfMJgptyLdm7/OvGi1tWJyuDLc=;
        b=hvKMYq6/KzAWeJxztUsT9HkT9moGP961YPUModBSZiN+UAEJb4IyB+9ktPofga9u+O
         XYBeF53AYSa3jYJwB3uMr7YvtVJN1sJCc4l+CzaH5nYBvIh1vGeg0b+4zZvVC1hUdy7C
         uo2iVra+qWsEvEkEdOB43Zjir7V+7ItuDjSsaUZ5O4y0UHiv02DWXrj5u2aPXio7Mamx
         QWbSsx2tkWIfRGl5gj58EgWxiKWtUCKTVuJqI7hklcfwUGj60d1J/p07bBpycyhofyCn
         KC3Hrm1UNOF23+rNEOYufRfCM1/dCyCYEgtVdfj0GkwiAO5/LS3HRP0Dvm2zBqA9BSsZ
         8E6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725661289; x=1726266089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UixZiE6IiF+TJjsM/CfMJgptyLdm7/OvGi1tWJyuDLc=;
        b=UWXSScJWzfRULtQtt0TtWR0EFzrUHuvbzlMKM81oNTkll7817hdd8uT5y5qLE5LhVk
         ywD/Ut8nZorDab/0nSbrTCsneI/+vz55ad8TwR6qUPNBCoS5s0VkZxGbD/Kti78VttEc
         nUHw/iFRF/uLxK9bYGaku4jBW5FnxAhADOqn/uLlmFzQbwhKRvlNg5CTOa3ONRCGJM2Y
         k1pKme43ru22egTvdyJ1uBASlsfuGqxkPxA8G5rspILmj2tVqwrGXJ1uiXZDTq7c7qQ7
         Lw/AQ91ZwyJpM4OAqaLwQJd4gDuQ6fH2k37UlPTFASJLqFmYoKC3GDkAd6qhnGtrAKug
         xxfQ==
X-Gm-Message-State: AOJu0YzcErn2bdrN1GATCqd8O5qbG011IHdgKt7drd8nun8AP7FSLZko
	1/3pP3WsdKlz4PsjnUj66SLCdQxhXo/vnSOK3kYUf+wqpvNv0LiK5yy3KjJbnaweSIbhquVZmgD
	wmrB5k22MzKC6r/DKQ8e6slBaPewtYN8BkIZL6G5Hu4ABVWE+AeJsT8l/vKRrbtN8vJXto0LA+y
	PVg0gbR4sQJtMnyIaQhsG3Vq6fDZtBimVStyptovU/kKfo
X-Google-Smtp-Source: AGHT+IEKrLCpVw6QqaE2tCzKYQldTu0Kt2VdBFu98IGjQyUVgYmugpO2DIEgRsl3ShYbZHw2u8hVeqdPehp6vFs=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:d503:b0:201:cdcd:4227 with SMTP
 id d9443c01a7336-206eebdb9f9mr3744475ad.6.1725661287536; Fri, 06 Sep 2024
 15:21:27 -0700 (PDT)
Date: Fri,  6 Sep 2024 22:21:14 +0000
In-Reply-To: <20240906221853.257984-1-calvinwan@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240906221853.257984-1-calvinwan@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240906222116.270196-4-calvinwan@google.com>
Subject: [PATCH v3 4/6] config: add git_configset_alloc() and git_configset_clear_and_free()
From: Calvin Wan <calvinwan@google.com>
To: git@vger.kernel.org
Cc: Josh Steadmon <steadmon@google.com>, spectral@google.com, emilyshaffer@google.com, 
	emrass@google.com, rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, 
	sandals@crustytoothpaste.net, Jason@zx2c4.com, dsimic@manjaro.org, 
	Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Josh Steadmon <steadmon@google.com>

Add git_configset_alloc() and git_configset_clear_and_free() functions
so that callers can manage config_set structs on the heap. This also
allows non-C external consumers to treat config_sets as opaque structs.

Co-authored-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Change-Id: I21684c87691d978e3303e04324428aa3567dbd70
---
 config.c | 11 +++++++++++
 config.h | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/config.c b/config.c
index 6421894614..444db8de79 100644
--- a/config.c
+++ b/config.c
@@ -2324,6 +2324,11 @@ static int config_set_element_cmp(const void *cmp_data UNUSED,
 	return strcmp(e1->key, e2->key);
 }
 
+struct config_set *git_configset_alloc(void)
+{
+	return xmalloc(sizeof(struct config_set));
+}
+
 void git_configset_init(struct config_set *set)
 {
 	hashmap_init(&set->config_hash, config_set_element_cmp, NULL, 0);
@@ -2353,6 +2358,12 @@ void git_configset_clear(struct config_set *set)
 	set->list.items = NULL;
 }
 
+void git_configset_clear_and_free(struct config_set *set)
+{
+	git_configset_clear(set);
+	free(set);
+}
+
 static int config_set_callback(const char *key, const char *value,
 			       const struct config_context *ctx,
 			       void *cb)
diff --git a/config.h b/config.h
index 54b47dec9e..074c85a788 100644
--- a/config.h
+++ b/config.h
@@ -472,6 +472,11 @@ struct config_set {
 	struct configset_list list;
 };
 
+/**
+ * Alloc a config_set
+ */
+struct config_set *git_configset_alloc(void);
+
 /**
  * Initializes the config_set `cs`.
  */
@@ -520,6 +525,11 @@ int git_configset_get_string_multi(struct config_set *cs, const char *key,
  */
 void git_configset_clear(struct config_set *cs);
 
+/**
+ * Clears and frees a heap-allocated `config_set` structure.
+ */
+void git_configset_clear_and_free(struct config_set *cs);
+
 /*
  * These functions return 1 if not found, and 0 if found, leaving the found
  * value in the 'dest' pointer.
-- 
2.46.0.469.g59c65b2a67-goog

