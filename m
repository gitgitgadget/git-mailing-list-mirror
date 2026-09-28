Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BED3B0AF5
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602755; cv=none; b=Wgo510bKQpVBrWayE+I1YG5Ug9Fym26t0DQUiIKlOs2yCRh5dUY0vpc5ZlN8jPZj+fIszzicis5kxU9PKYTFaksVi5rm/wwLG/tGBweTjfjdirjJ5v68Zk3gsPJOQeqQ97Z8yl+qUzgwV8gM3x2obdKSyzWIyfMhinKPZody+1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602755; c=relaxed/simple;
	bh=0jHPCzKKHfNViQmsKYuu97U/2T3KUa7KbZb1CvOl7tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sFSkOuFGNmeuPEa47vy3kmNihCEAuoCk6tXkMJSUvnyeocpzyvMPcNTob3fyt+5Fd0cdHKu1sWE5vKBSKDks7QZXLsa4AWGhBpclko3+THkvw0nKym9bW3zmq2gTQNNdrx9z2h3gCzzB4/g+8qdoVlbYxescQuq/+qO0NEsbbVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U98iW5AZ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U98iW5AZ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ff9621c5dso13549235e9.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 06:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602751; x=1791207551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lUbbwJcPohGtmYaGiuGXr17NRxWxGo4v/RYr55PdJv8=;
        b=U98iW5AZRvzgu+wRM+7nSLp+MKgV2vZBqlBI21O5MYqvHw/Rh29ihREPd+eXirmHZT
         SdW9y5WyrBHco1gWMmPwQVz/Sh0JlNeZ1k7pQRhKtSUxS9SjbHsIPSPiD7yyoFpL//dv
         kR8XgxzDGnEyWz/ploXcoALyHa8oK4J5kLvJPJO4F6JGEv3PPGhASbFDIOpX5lN4iBvB
         OmCxlHl1j8HbRLbuTig5EssQLU60S8O2DXtTNn6J13mP8Ze+q1z7o7aLMnbaFab7V3HL
         VrtCxoFtlyx6AoLGSiG1FLNZi6Aair9ySea7/u5V97TW2k/Ozz0KvMo5OHz+bgpB+Iuf
         n0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602751; x=1791207551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lUbbwJcPohGtmYaGiuGXr17NRxWxGo4v/RYr55PdJv8=;
        b=WT83qL5QwvweZS4l45ynbA9rVW6ox8w9Z2EiiHwWMhoh9Tgk0AciS2QQx3dcP0F84w
         HE52VmRaTRrU6uthW6MsoS9PhBFtjv4gEkHBJba3Y0wVP5CEm14YxwA+JynJkWVlymN/
         baDZmUcYfe5Ale2oKC+xWovnQl3xucthNcFyRalVOCG4hxzNqVA4ZxcFO6mmO+0xUXiW
         7l/LXst5qYYCWNpOQZ7y3yKQwAEteIkrb6W0u0gvxy+Pa2xWaoT1gnNsjSdbbvi7WwAT
         tZ+xqfHXpMaEj6DAMzVzmmtrZNq9xvgh2eCQLyuZTNXysM4zn3hVVce/4hkuu6GFfNXX
         lEDg==
X-Gm-Message-State: AFuF++lSb9dBK7/X/wEkWG3RNwSAYJEjqAixRPz57/3bVKbWVl9X7dK1
	FrnM1zsosnkgXRSMg8OMKfOTOONMfcqOiSgrDxuZpWEri0VOxNaRpoBvDR9Sbw==
X-Gm-Gg: AYBFou0vdhiA7hOou8Q494o1eF7pEs+tEtZeXsfgSI4e67xinKY/AjDJS95ji7VIflb
	2hXqN6rqk59P+3TbzJZ60JNueT77yEZ8ff+eXOgJxZzUCjhR48AsrfbJkkU4ZmHChgKqNuZzUgE
	pJZL/vzRMTQMGQaMTCOMyuhm4clZuYktPhzNPfuNrQWKf6CKGMBmzJEr5kJldvjdmerw5xrKqmq
	jTMEXgLImUYmbkb/1+DZNsixhq47uUUdlY8SoUmsjMhT8+/ZUa2F9ddNaRW6TVUmsgYc80voE4K
	lMfPny/ZIjlbRwIp/3Z54NbbtxYXhfjJ0go/wDc5MliY3YgiWQW35IMXZfq3eR4N2HI8KJVJxhM
	8lVEZ/mUSBogOubPhB4u1W/93EEv6lJIj3ErH4BUA0NOVvZPdoIQ03I2x64PYV9YnjnEPYJacWt
	rdmIChHUcUN7xwNqf+0nrLQOf4wbq8t2Mp748sRY3OnYl+6q8mhGF1Oq/EzYwFhJ2Wngxx0u7HE
	37Gn+zQ9qgTeTltPCzBTVLgZnj0YtPbONDABPo+p/OCk/t8cbC+whL5k0itOhu11t1sEq5X0+b0
	IlGwR0dNq4oABhwZBzhavq+zf4q0g6DRHM5+8s7+GAdV25t4XXEsS6RK14b1/eYMQKwP9ktu8bk
	hM60KIYp3+zoyzwE2cTo=
X-Received: by 2002:a05:600c:5493:b0:4a0:2c6:165d with SMTP id 5b1f17b1804b1-4a002c618b1mr62039645e9.5.1790602750723;
        Mon, 28 Sep 2026 06:39:10 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00c0730a8sm5554505e9.0.2026.09.28.06.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:39:10 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 3/5] upload-pack: read uploadpack.lazyFetchTrusted
Date: Mon, 28 Sep 2026 15:38:44 +0200
Message-ID: <20260928133846.2094261-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.rc2.20.g34f06850c1
In-Reply-To: <20260928133846.2094261-1-christian.couder@gmail.com>
References: <20260908164129.560396-1-christian.couder@gmail.com>
 <20260928133846.2094261-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous commits created and prepared the path_allowlist_apply()
and path_allowlist_config_apply() functions, but used them only for the
"safe.directory" configuration variable.

Let's reuse these functions for a new "uploadpack.lazyFetchTrusted"
configuration variable.

It allows us to:

  - read an allowlist from that config variable,
  - check if the current repo is in that list, and
  - return the result from a new upload_pack_lazy_fetch_trusted()
    function.

As path_allowlist_config_apply() lets each caller decide which paths
it is willing to accept using a callback, let's pass it a new
allow_trusted_path() callback. Unlike the "safe.directory" callback, it
accepts only absolute paths, and not ".", as `upload-pack` always
serves a repository given by an absolute path, so there is no "current
repository" for "." to refer to.

Note that a served repository is identified by its git directory, and
not by its worktree. This is because `upload-pack` uses enter_repo()
instead of the usual repository discovery, so it never learns about a
worktree and `r->worktree` is always NULL there. In practice this
means that a non-bare repository served as "/srv/repo" has to be
allowlisted as "/srv/repo/.git".

The new upload_pack_lazy_fetch_trusted() function will be used in a
following commit.

Note that the new config variable should be read only from protected
configuration files.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 upload-pack.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++
 upload-pack.h |  3 +++
 2 files changed, 62 insertions(+)

diff --git a/upload-pack.c b/upload-pack.c
index 22573ad365..a300870fa9 100644
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
@@ -1343,6 +1345,63 @@ static int upload_pack_config(const char *var, const char *value,
 	return parse_hide_refs_config(var, value, "uploadpack", &data->hidden_refs);
 }
 
+/*
+ * Only absolute paths make sense here. Unlike 'safe.directory', "."
+ * is not accepted, as the served repository is always identified by
+ * an absolute path.
+ */
+static bool allow_trusted_path(const char *path, void *cbdata_)
+{
+	struct path_allowlist_cb_data *cbdata = cbdata_;
+
+	if (is_absolute_path(path))
+		return true;
+
+	warning(_("%s '%s' not absolute"), cbdata->key, path);
+	return false;
+}
+
+struct lazy_fetch_trusted {
+	char *repo_path;
+	bool trusted;
+};
+
+static int upload_pack_protected_lazy_fetch_config(const char *var, const char *value,
+						   const struct config_context *ctx UNUSED,
+						   void *cb_data)
+{
+	struct lazy_fetch_trusted *data = cb_data;
+	struct path_allowlist_cb_data cbdata = { .key = var };
+
+	if (strcmp("uploadpack.lazyfetchtrusted", var))
+		return 0;
+
+	path_allowlist_config_apply(var, value, data->repo_path, &data->trusted,
+				    allow_trusted_path, &cbdata);
+
+	return 0;
+}
+
+bool upload_pack_lazy_fetch_trusted(struct repository *r)
+{
+	struct lazy_fetch_trusted data = { 0 };
+
+	/*
+	 * A served repository is identified by its git directory, as
+	 * `upload-pack` uses enter_repo() instead of the usual repository
+	 * discovery, so its worktree, if any, is never known here.
+	 */
+	data.repo_path = real_pathdup(r->gitdir, 0);
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
2.56.0.rc2.20.g34f06850c1

