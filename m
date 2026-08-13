Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51320374A17
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786636132; cv=none; b=d8JeJ9J2XK17kiZWOsnwKRavTEpzCRVClC8/XYLjIagxFxZ6+EjmzIkdFgxgNLb5gSJ5wiWsPSB32ZRDUC6uv0RSBu1RftLSJPjTmEv/3oTYXh8tjtXF1j3IFohgY6MyFqfIgWSWTFUqRQDbg5c6ChOiBgWvodOHZJDJFaFIT0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786636132; c=relaxed/simple;
	bh=ZdhJzlq7x/uqvhjDxVjKaTxRTuL99GLIcJxg2dJhIA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUCxBj3qvKGmtI6nkVUVNMeshaxdM4vF/ym2ipCM6XfsLSqUT2k0xV7RrCszCFcVe91Wz+8/7332vjkCFaliLtl/px7KVULLLqD9LkQlFEdzlIputS+fZmTthkXdOxLmutS03uzAE5CV+a5FrGTxdMxsmNZk/OT8AqfTPakG/Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCfntCT4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCfntCT4"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4998590d392so862505e9.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 08:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786636128; x=1787240928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lrurd5UTlOyQIz/0xsKKJ3ctHYFWkMQi8BRd4t+QyHc=;
        b=iCfntCT4G52m7i3Fl+LBwM8wk+S1JaFwoBL2FBl1jpfXueWpa22G4/hhaTt171eZFS
         IWSAJbi83wLXD+Ox/0CqPEJES5JVrq7BA6AsDDtsG1xbxab6EcjSGfdIooiAw8DJfkqN
         iSBe9iRVeUmMKGn41xyqcp6yd1CsrqN8NrYiQrXtdfJf67XPp3pDiuMZUpS7jdg6pMFC
         sI9bkgBVWKtW4niZMkONSjHYOczKfTY7lkF6Du8XsVfVYoTDa6Bw8Xt5MQoUFis67ddi
         sg2cU1w1RkO+onxJlXXLh4AtNx4ykmMrKMuXk37MI/NY4WT+5aPjAiKSHKpoz5ssW3hm
         SP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786636128; x=1787240928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lrurd5UTlOyQIz/0xsKKJ3ctHYFWkMQi8BRd4t+QyHc=;
        b=JChOWsQsHghQF90ha4QYgWXz6AFZ9APOygDLFFEjlBElpz1W29rkIW55jrH1WKCElC
         4oUJ3bmFtRiZIxKtdvtyuOn2svysQmcKavjTENNNE1p76CxrxdH/h5iH2BjYaKtdzj5G
         JkAELRVFwRMucKud8sywspCtzlAzalluWS7sn149QwBGGTBu7l2Nqbvjkt3rjaO0VXaQ
         M1tRlUFnxXLOJ5IfYq0tiOjz9YNqve0zCMHGeYurHHOyhyem6mzR60cbuZtZWuVMlSml
         LLiLCpHr0ymBJDdEIbZihNmjItll1h17kGMlEVXKOWmuyv9zKS1FYnrb/OD6EiIUNeyD
         Bc6A==
X-Gm-Message-State: AOJu0YwzgCoeTmNxEzigvdUYwEYjbyaNQHBjQMW4gZtLrwydi7HAjvsg
	GVtk7dBqWgEHIRP7Ftww4WngEJ7QmbetcbPhSuFWyDogi6FExD2JDo11dshWfw==
X-Gm-Gg: AR+sD10qYg9PdLK3lBNTH/p+c2xGcsZBHg2SX/ea+tkPNLb1ZDc+q3meFxliqDuzBuj
	DLbco/9RPh8sPVp7AZ7wyEXIrSQbt6huuIGU4LytN06/XUsZJpg5teo0QLu2vKUygbqrVMiaytj
	+0hhb5KQV41mO/P/sFKoBbnB+7OZ4LXtSL7rkk/sdIbZp3QVLDcoYYVBfPh/ZJw+cvBgHy2O41q
	kHwAg+use2ASVVN6bHVm2r6nQ+hXrry0IleCS+j+5+u8ZUNMPA65RHqZqFuEPmixmsIY43css1w
	swcHy3YR7S4v9MYzIVpRZeyFnrKzmddHtZbBFQ1q0I6iPthkfCM51seI1TR7SomNcECVHSIrRMc
	5ruxfNZwJHe2U8kW3bfeHm6KYeKvgbppihouscW58SfEX5GX/08Zs/+S/XZMwHzAtC2c3gmI8zH
	I89HTTOUyyb53R5NSAc/GYMzSRiIIlE68Q+SLHH/a9KKu8QYRu0SHq1qAYypE3mi3B8o3dSaUhw
	/qyfImzKx+RT3qvknoKzGMhw8OvqmIOFrgdYC+1NnbloKUhXfYfo/djAiKTDJgDVybsyMZBoEVw
	ic8Q
X-Received: by 2002:a05:600c:6812:b0:499:48be:3189 with SMTP id 5b1f17b1804b1-49982180f58mr103816785e9.0.1786636127948;
        Thu, 13 Aug 2026 08:48:47 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([2001:863:5c0:e90b:439b:8502:172e:8dcf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499821217acsm60633555e9.2.2026.08.13.08.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 08:48:47 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 4/5] upload-pack: read uploadpack.lazyFetchTrusted
Date: Thu, 13 Aug 2026 17:47:47 +0200
Message-ID: <20260813154748.2378747-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.547.gbb97bea608.dirty
In-Reply-To: <20260807135511.1818458-1-christian.couder@gmail.com>
References: <20260807135511.1818458-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous commits created and prepared the path_allowlist_apply()
function.

Let's reuse this function for a new "uploadpack.lazyFetchTrusted"
configuration variable.

It allows us to:

  - read an allowlist from that config variable,
  - check if the current repo is in that list, and
  - return the result from a new upload_pack_lazy_fetch_trusted()
    function.

The new function will be used in a following commit.

Note that the new config variable should be read only from protected
configuration files.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 upload-pack.c | 37 +++++++++++++++++++++++++++++++++++++
 upload-pack.h |  3 +++
 2 files changed, 40 insertions(+)

diff --git a/upload-pack.c b/upload-pack.c
index a52856d869..29e700e43b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -34,6 +34,8 @@
 #include "json-writer.h"
 #include "strmap.h"
 #include "promisor-remote.h"
+#include "setup.h"
+#include "abspath.h"
 
 /* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
@@ -1378,6 +1380,41 @@ static int upload_pack_config(const char *var, const char *value,
 	return parse_hide_refs_config(var, value, "uploadpack", &data->hidden_refs);
 }
 
+struct lazy_fetch_trusted {
+	int trusted;
+	char *repo_path;
+};
+
+static int upload_pack_protected_lazy_fetch_config(const char *var, const char *value,
+						   const struct config_context *ctx UNUSED,
+						   void *cb_data)
+{
+	struct lazy_fetch_trusted *data = cb_data;
+
+	if (!strcmp("uploadpack.lazyfetchtrusted", var)) {
+		path_allowlist_apply(var, value, data->repo_path,
+				     &data->trusted, false);
+		return 0;
+	}
+
+	return 0;
+}
+
+bool upload_pack_lazy_fetch_trusted(struct repository *r)
+{
+	struct lazy_fetch_trusted data = { 0 };
+
+	data.repo_path = real_pathdup(r->worktree ? r->worktree : r->gitdir, 0);
+	if (!data.repo_path)
+		return false;
+
+	git_protected_config(upload_pack_protected_lazy_fetch_config, &data);
+
+	free(data.repo_path);
+
+	return !!data.trusted;
+}
+
 static int upload_pack_protected_config(const char *var, const char *value,
 					const struct config_context *ctx UNUSED,
 					void *cb_data)
diff --git a/upload-pack.h b/upload-pack.h
index d6ee25ea98..b2212992c3 100644
--- a/upload-pack.h
+++ b/upload-pack.h
@@ -12,4 +12,7 @@ struct strbuf;
 int upload_pack_advertise(struct repository *r,
 			  struct strbuf *value);
 
+/* Is this repo trusted for lazy fetching? */
+bool upload_pack_lazy_fetch_trusted(struct repository *r);
+
 #endif /* UPLOAD_PACK_H */
-- 
2.55.0.565.gc116661202

