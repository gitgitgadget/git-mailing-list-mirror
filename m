Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1E3381EB4
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110942; cv=none; b=POzImXgqQcb9XvLiBVLEXWsLc3YI91k6SUaqID8Z/G90COHHQK5xRutL4Q7SbjqlKvNuXfvQia+nk5k1tgyR0XaXR320h2t2dSTzEO03GsNPFBOeOpkuCh4THrjQQ0be9vl/521SBk2Evs58zr2g8tSzFZans1+b8trytDWo5t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110942; c=relaxed/simple;
	bh=xoivOwkBfgpNcRD4KHBHSqPrm9KYAPSFjYN6yU6APjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTJGLuu9ISXc/Pr7QuPliPD1W+kTyBoqRRmtQnaebLHbRWn4aoZ57xJYfwOHiUHs4/HHz0gRf/lD49myhcoGnhTLU3AL52v5w1p6YkpgjV3k0iV5TgNGWkN3W/SEM1hxGq4nee0HDwRb1cVkFjEfGrckm5qx/2mT7iX+lhKSsU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZAWr9Jl; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZAWr9Jl"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso1806080f8f.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 06:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786110933; x=1786715733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HAqgELBeVpCpGCm7Yg6hfttkmQV2Wrt4gztJ70XzKJY=;
        b=iZAWr9Jltb8qcx7Lbb53eP8ljWmbBQlgNW14PXyonW+2ou3Ozr1MlodZJHRrs9PHut
         jGu3nqfsXs4GjY837CS2cQmh9EnAWQDcPEqGGA1wGKMs20ndn0f9ywvDsxP/m5TT3bQE
         pYwrSXsZgDpFZFO62EooXYKeXyvzFvoq0bs+2w8sVdWnQtgGCpCwYb/LKs1yofbd8zC0
         XgD4jVpQSC6OzsMhxgd65OAvlJ1LaddYMEShgjpIPssBCHJqzS9Sr3lAYeq25KzwjamQ
         c8ltKc5Wo8ghF1JxW3EJCcwyPAzqY2+RpGzFlMkRjYis2YyzEQjec9XmRqOrJPeLqjx/
         1/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786110933; x=1786715733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HAqgELBeVpCpGCm7Yg6hfttkmQV2Wrt4gztJ70XzKJY=;
        b=aD64Wyu8pdAy8dWZ9XJbRM1NN3BTKrfFr1kEVGOy5O/yopr7/ZCdia+cxAFPJ8sFXo
         jeYUl88PEqaavNwxROus8GJQ7lcAkeXVFtAgf7TOKQhHHldKwNcCTLqhn9je1/lEP6jS
         gXsVuBTcCpVmyESIBVsz0hwLGVny5ZWwUeO24WPM9uAJTwFdoNQQEWSk/M41CiRP9TWP
         CNrw/lOC9W33IskU8qnqQX5xwE2HR2XZIDbERPKyiCYvecfUuNv3QNbqQaqqNkQ1uWSD
         00N3Scr3nz5VsxHEZ+iebqg9a6YYqMPZ+1KMGOdjMs/GgC4MDfPEQ0JIezyEzMSuj4Fi
         8OxA==
X-Gm-Message-State: AOJu0YzGGEkpot8gwClnzlHmloi+w9PZsJclKsFQkVr7bVcG53jP9yQw
	y114HypT2Klk6g/sFRiKyMejjcwADkaJPfCKOyVzIdRqpUEdBzVUUcbugGPkHA==
X-Gm-Gg: AR+sD105TlcqjkMgYPj8lT3FPDjIkb9JMuaOUEZG8ETkn4sn2K3XB1En4U4CNSCWBvU
	VDOjZopmT2LH0RPFfJk7y6DPq2DW7sjLcXqZHNKL53A+sjniJQBAxxIWT4NAtbHfOQlCEWHf71f
	4MZxzebKxjwScPrQUB1bGqObYDDmL3UUVBvoqdU4Jnynrukpk2WrqS5z+wy76JZqKXv/DCZ/uvH
	H9G6Dlg81hoYHHMy16vkj+EabEgdZM/NZkaN+aAeN5CCd+RRsiRjLMsYzGXnkg4sp4HNsf1y9vy
	6X2L5cL7TRCb3w3MNOjhWC1XsgDWDuoMPiUFUiiBDA1mKZwgSsQoOCW6dW+9HRRhwjNdQ/i1BbL
	9avz0zr0WpQdxQGPPpTv8vX82eQ7e6S1b7Lb6tZzm9e+MmnqpBNCTcZlJzlXxo2NiCo5PCP7CoN
	2UfPyhdLe7b818DZCWSYDHF+03bOieibnjr3WKDgu0CDjWRoT0PIhbOe7BoQPHzEZrI9QeE1Kvo
	y9xaszs2ESvG2bBc0MQ2LGIpld4ncWR0Wbgl+eekKUfVj7ufUoqYmc+0yS0FO7jsDxT9sYcORAb
	A/mXjWOOVSw=
X-Received: by 2002:a05:6000:982:b0:481:98d:b24 with SMTP id ffacd0b85a97d-481098d0e88mr3008850f8f.19.1786110933237;
        Fri, 07 Aug 2026 06:55:33 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021ec565sm6094207f8f.22.2026.08.07.06.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:55:32 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/5] upload-pack: read uploadpack.lazyFetchTrusted
Date: Fri,  7 Aug 2026 15:55:10 +0200
Message-ID: <20260807135511.1818458-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.530.gdb3615d990.dirty
In-Reply-To: <20260807135511.1818458-1-christian.couder@gmail.com>
References: <20260710085137.4171240-1-christian.couder@gmail.com>
 <20260807135511.1818458-1-christian.couder@gmail.com>
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

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
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
2.55.0.530.gdb3615d990.dirty

