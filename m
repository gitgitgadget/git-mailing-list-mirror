Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E7344A725
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929431; cv=none; b=CaTDk6uKMzR89Tkxrpl0buFoy2NuGKo5tNKgImtOM4nYfadp3u2HvENg2eQRAdBclOQwVKmBGS1rTyWXIi6pC2cJlOOwidbAn04ocybiZ7dnFlU2sJQg2vVuL2leT3StVGPAa+SLZMNW+qCpmpKqgRN4ATxbfS/a84wQoPgpSs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929431; c=relaxed/simple;
	bh=fRPiqV5l4fI/gCT34y2gwqFj7D94F0yrwCnWBQPUUsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n14kOL6qq3yD0PAZ5q0vhPTF9tNYVy7w2rw72uqKmDM6uTW2C4JqseHoQglX40bA/qXCmXawDZzbwwz8CCWg4HCCHcq6jINOFKe9F5e2QbhHsRFFLOg1Q1w+GmSNpwSsjZS1uxICje0op6rMuuKKO8TvGIcVNPicUzDKpSBk61w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/70SyJ0; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/70SyJ0"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b01d89b23so1597763f8f.2
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 01:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790929425; x=1791534225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e5bX8jQGYQPiKmEqD8l9dvqoP76bqt7UHQBq+ac8vSk=;
        b=s/70SyJ0NDbZOnt2VwtmSsRac/WWUHr9LcgsttIQQmVB/2cfBiRfjwE7qe/KYOv/RJ
         R52yqqS/fnlpJRR93frnpqLaGtkBA0yA8GeUTFSHQmiGr4ePXi++oZFpit/aXXfDQxIP
         KEdBzBky0iekyrohpBFjyKyr1FHqUN6jQgE0phqRph0SpP2lEhoxfd2p5FYsbXsldfqN
         dbqvmqhZG4PV0tFHREMswY3uQj+FqFahu6wDqm/m03f8wGmTKhtDdfpVtcrayOLHBetH
         bFzIa6sUiMoRqvGKaJ0l81yU8gcoUJGC3ciiC7EqEKd8H/u3BeiguC/fNf8EsAN/6TCz
         5SAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790929425; x=1791534225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e5bX8jQGYQPiKmEqD8l9dvqoP76bqt7UHQBq+ac8vSk=;
        b=ueNc33aj2b9Z6C4y+QLpAxiLl8y6InZjxHDFQWW/t0fBv/bMLrJVG9MqDSB3IaLkDR
         zeodANtoasdpz1z3ImggDvDXpp+/TlRykB5pyd4eSNvF525xtDsibAszSg9GNcn9zzlV
         IUzisjw77yDXc/6k4nzbpONB4w2Ll9h8tFBd6V00xYzu3AIZWWazmMSw8Tz6sON/UZhl
         U0hszjOv8jt2LDAvLjnEX9gzSmvZklpqmJeC6Bjdyx35FGfvSQLRPVqp9AR/NDQV76pQ
         LzLQ4wv+wZunbNcpgJCQpYGS4JxT8B7Zztn9NuXreT2YfEnRisM7SiwCgs4UJXCFQwJg
         b5JQ==
X-Gm-Message-State: AFq9FYIjuC/+ypDCNBCj8PEwgmc5niJk+/d+Kjx6ONkiwk4QuojpQidf
	+quwMbsEMI5ORrdFLvA11VGAxJJNhrZe3P5UfN24NB2A3QiQiI7QRjSj0m3hKA==
X-Gm-Gg: AYBFou1sqov4uqacde3gwJSWrWt61l8W25664MevIRAKwiYwVinZuxHO/ZP61aWSsR0
	eJWiQ2T9HPH4mJJYPfNmLKb5lNJ6fFEJ8ke+PHgwga34KFjyLbmJC+DSsiwyZF9+k6DCwnd2S8b
	IeMKKiTlUgTGeN3fhGJTxMgFTJ97Q7aFAYmaO1SjwJGWJf6MG+ic8ZKeQT6OqeL+1Qf6qbNrMjf
	7geCSOz48p+37KilFkMBwZ9rN3kivlAyGp1kX0TR/iQ4x7y5EII8YRkRBU3g10kkocLnagxB/Us
	7gr+kuG0xp8KGqQaa4F1mEy0ApY2oWZ7XIW/lYviPJ6TUajxNYXaRgJnS6HmPgKbBoDuUohw7b5
	5tLw5ivqmm045VQPVI2RVnEAG1VcP9onwIxsL10zFOAXHclStDMWR2PuHrp50xE7XHP6XMTvgf8
	wZziYC8AD3LyMTUQdIAP2FPF5lPUahsTc6Rz4MKkZ3GPB1/OgvFd9GZI5MNLjktuPrYC3f9nJc2
	nU6me10Gqr0FXcvNmtZgkn3T2bjz88kYu3sceDq/rtYj2hMq9krxHGFNiubia/0zNB1kEDqZgwi
	EdKHpYU51Mdx7tMMvx58vCZufdx2sHwy1vtAG2IOSuVTawwinfp9Beb117E5mQT3fp3xuFcM+it
	rDq+xGfS2
X-Received: by 2002:a05:6000:2798:b0:487:11e1:cab2 with SMTP id ffacd0b85a97d-48b1272d3cdmr2096118f8f.49.1790929425091;
        Fri, 02 Oct 2026 01:23:45 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b382f8ab4sm3905817f8f.35.2026.10.02.01.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 01:23:44 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 3/5] upload-pack: read uploadpack.lazyFetchTrusted
Date: Fri,  2 Oct 2026 10:23:20 +0200
Message-ID: <20261002082322.2682869-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.rc2.20.g34f06850c1
In-Reply-To: <20261002082322.2682869-1-christian.couder@gmail.com>
References: <20260928133846.2094261-1-christian.couder@gmail.com>
 <20261002082322.2682869-1-christian.couder@gmail.com>
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
allowlisted as "/srv/repo/.git" (or as the directory its ".git" file
points to, if it has a ".git" file instead of a ".git" directory).

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

