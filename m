Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44541A0BF3
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792062082; cv=none; b=hTx9GIjeKVQuhEXuABq4DVEFQadcYeTy0J4AKXVBoD18HgJtRW6/88MxMZsivoV+6PcraMEEhsuxQWqDPjPnk9Zme7E5lEMDNBwtRYEvqiYv5GdCPsOBl69xEm+aGtJ30yAs+XJzjTDpogwbq9HlXB1KCCWncsH78ENUcXMy/Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792062082; c=relaxed/simple;
	bh=OcL8gaidOJX922f7DnLP1YQyJt4XdOX9V9ZvMefjdXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6rTY0NclnwpdXFuX0Mv5RmoFBKeXlT9Wkym3j+LeMoImqlH4FJMNQLoVXg+vCNgOmVr7WOooUIiq80rI7YXKV2eCIRP40nGeKgicMA9KSHDaG0WTbiYP2WYOcV1gjbyJJVP7UJaSZ5zxBrakxtFpqN+dnIs9Z40kEJiulWpFOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijyLBo6a; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijyLBo6a"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-78fb9d46f0aso2767680137.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 04:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792062077; x=1792666877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LBDrqC39G6M45k3Fl+1eDxqvKANkAR50/i+MWY9Pen4=;
        b=ijyLBo6aq2wOZvntMRlMFmXbpOxuJoOGnsA00HqF82REytCyGR6opzvenrq5ijf0Uf
         MPEVpYpeK5WsZLGbxiBNNe03pyH3W1XTMJlTZI4R6ADBpwSiDLDrS/gSY4FhcmP0CIxh
         IdyTWhzhPQ5K0YKwclM9kVP24hG2Us6nVtBHTA/Dvxpp5pQgRh6y0b9/F1A/ebnL1SKe
         ZMIW8dvWE29sfhajS+CZGKUw9/aAiwnJZ65JRWWOs1+x6vn5j7KoSgXCQhBmA/g8tkF3
         +XWeXYpjidR1TmNfNgxW/xwzjstpP3FKPNKFujXFoHwoMRFTwG7w5zTa8NXlDZ6BAk70
         kOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792062077; x=1792666877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LBDrqC39G6M45k3Fl+1eDxqvKANkAR50/i+MWY9Pen4=;
        b=SQ18ZECQNp4oF3QuFSWpotX+5ByTDSfH0eLHhjxkmHFDswNIe4nIAOQWCVEShz+3qo
         vH4cX6nXdvoYadxKTRmYUCS6XweIOda+Y6+OluE9aUWYtoBz1Rq4CIhpklU4zLR7cmDp
         pps9ByNXtmEVolY63mqAgjMwzQuH7B+WVAfeUfzMm+YLgQ+XpNNAbGLmdq6KTxEWjh8p
         ciDhRb9j9ynVesnqJqJEXPnfbE3oUujvXURWpIMKHzuCxg52EaOq3nEtUmJSaZF4UDua
         408j4NLMMRKX4PQivQb08XMEN5KgmasUSajHQ26y98Cj4sqZ93vTgQDomE6xW15aIUWk
         j8UA==
X-Gm-Message-State: AFq9FYJYNbSTI5INjIG0O3hEjryOxowTaTzrk3o8aQKSuq9dBB/yV8VJ
	GY4RyBfg4r7tGxzr5MnlvmRlhYea8gjF9KTet45IEPxC7EdQHQCxeXrN9jL3TOTp4t8=
X-Gm-Gg: AYBFou1nwzlFHmwjzQNlqQceFei0vRPA0kMvVWOqqmrLQbDxTtFVSa1A5jJiOBz8vWu
	VSkRNj2Auhdxf5gWTuv+Kg5vX3HET1KNfdfH4agLYDIA3JCX4/3Zodul5F2fRiG7yPkrAm/2kvf
	5x8iuyxmInLqSw2DlTS62P4DS9icky/aOECfUcOs0B+lfr1VjxftpUc+x2RnAnFaMHiAljib7ox
	pY2rtB49OGXtQ3Tw1t33dHoAUOL+gdCfFUz9gQnk15NMNaECfyciPMHDrwXRFKks3u0Hmf+MHBo
	p3sY0FyvUQyo2KnLbaXlEOCVjInrfAGWBq3SpfPuJHNv4Cj/c2aiXL3Y1AbM5pgdEZHra390Osh
	3tsbXovFYWKD7wYGjM1GWQqOGkAkunOeGx/YFh4+hpbfzgewO8/r8F/QGgT84J4VxlVz7iCTN+a
	2SZh7JS90y6KPvK8oxY96YV+9lYGdmdgHCjen0y1XBTpshl2alaY3VgEQFqWTpMxVZI2B7R9O2n
	YRkwWIVfsH82EyuR6hIYZZgl1S61qvf1Q==
X-Received: by 2002:a05:6102:3713:b0:7b9:2aea:1c6a with SMTP id ada2fe7eead31-7cb3a108263mr6075990137.28.1792062072559;
        Thu, 15 Oct 2026 04:01:12 -0700 (PDT)
Received: from isabella-caselli-linux.. ([2804:388:d001:9f94:7eb9:62e0:e1e9:151e])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cb35471536sm13099381137.11.2026.10.15.04.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:01:12 -0700 (PDT)
From: Isabella Caselli <bellacaselli20@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ignacio Encinas <ignacio@iencinas.com>,
	Isabella Caselli <bellacaselli20@gmail.com>
Subject: [PATCH v2 3/3] config: learn the "hostname:" includeIf condition
Date: Thu, 15 Oct 2026 07:58:59 -0300
Message-ID: <20261015105859.3184108-4-bellacaselli20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015105859.3184108-1-bellacaselli20@gmail.com>
References: <20261012015846.2649843-1-bellacaselli20@gmail.com>
 <20261015105859.3184108-1-bellacaselli20@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the same home directory is shared across multiple machines, they
all read the same ~/.gitconfig. Settings that should differ between
machines therefore need a way to make that file behave differently
on each host. The same problem affects people who keep their dotfiles
in a repository and check them out on multiple machines.

Add a "hostname:" keyword to includeIf. The value that follows is a
pattern supporting standard glob wildcards, and the condition is met
when the machine's hostname matches it. If the hostname cannot be
determined, the condition is not met.

Depending on the system configuration, the hostname may be either a
short name or a fully qualified domain name. Making the name fully
qualified ourselves was considered, but it could require a DNS lookup
while reading the configuration. Instead, match the name as the
system reports it, document this, and point to "git var GIT_HOSTNAME"
as a way to check the value being matched.

The tests obtain the hostname with "git var GIT_HOSTNAME" before
writing the configuration, so that a failure to retrieve it makes
the test fail instead of going unnoticed inside the here-document.

Based-on-patch-by: Ignacio Encinas <ignacio@iencinas.com>
Signed-off-by: Isabella Caselli <bellacaselli20@gmail.com>
---
 Documentation/config.adoc  | 14 ++++++++++++
 Documentation/git-var.adoc |  2 ++
 config.c                   | 17 +++++++++++++++
 t/t1305-config-include.sh  | 44 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+)

diff --git a/Documentation/config.adoc b/Documentation/config.adoc
index f67dcd2f8e..aa6360e230 100644
--- a/Documentation/config.adoc
+++ b/Documentation/config.adoc
@@ -232,6 +232,16 @@ As for the naming of this keyword, it is for forwards compatibility with
 a naming scheme that supports more variable-based include conditions,
 but currently Git only supports the exact keyword described above.
 
+`hostname`::
+	The data that follows the keyword `hostname:` is taken to be a
+	pattern with standard globbing wildcards. If the hostname of
+	the machine matches the pattern, the include condition is met.
++
+Depending on how your system is configured, the hostname used for
+matching may be short (e.g., "myhost") or a fully qualified domain
+name ("myhost.example.com"). Run `git var GIT_HOSTNAME` to see the
+hostname Git uses (see linkgit:git-var[1]).
+
 A few more notes on matching via `gitdir` and `gitdir/i`:
 
  * Symlinks in `$GIT_DIR` are not resolved before matching.
@@ -315,6 +325,10 @@ Example
 	path = foo.inc
 [remote "origin"]
 	url = https://example.com/git
+
+; include only if the hostname of the machine matches some-hostname
+[includeIf "hostname:some-hostname"]
+	path = foo.inc
 ----
 
 Values
diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
index e813ab4fd2..fc2def16d3 100644
--- a/Documentation/git-var.adoc
+++ b/Documentation/git-var.adoc
@@ -86,6 +86,8 @@ endif::git-default-pager[]
 
 `GIT_HOSTNAME`::
     The hostname of the machine, as reported by the operating system.
+    This is the hostname matched by `includeIf "hostname:..."` (see
+    linkgit:git-config[1]).
 
 Most path values contain only one value. However, some can contain multiple
 values, which are separated by newlines, and are listed in order from highest to
diff --git a/config.c b/config.c
index e0bb29b53d..c891f63e60 100644
--- a/config.c
+++ b/config.c
@@ -316,6 +316,21 @@ static int include_by_branch(struct config_include_data *data,
 	return ret;
 }
 
+static int include_by_hostname(const char *cond, size_t cond_len)
+{
+	int ret;
+	char my_host[HOST_NAME_MAX + 1];
+	char *pattern;
+
+	if (xgethostname(my_host, sizeof(my_host)))
+		return 0;
+
+	pattern = xmemdupz(cond, cond_len);
+	ret = !wildmatch(pattern, my_host, 0);
+	free(pattern);
+	return ret;
+}
+
 static int add_remote_url(const char *var, const char *value,
 			  const struct config_context *ctx UNUSED, void *data)
 {
@@ -411,6 +426,8 @@ static int include_condition_is_true(const struct key_value_info *kvi,
 	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
 				   &cond_len))
 		return include_by_remote_url(inc, cond, cond_len);
+	else if (skip_prefix_mem(cond, cond_len, "hostname:", &cond, &cond_len))
+		return include_by_hostname(cond, cond_len);
 
 	/* unknown conditionals are always false */
 	return 0;
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 507b8ebd06..01069237ba 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -524,4 +524,48 @@ test_expect_success 'conditional include, worktree without repository but explic
 	test_must_fail nongit git --git-dir=nonexistent config get foo.bar
 '
 
+test_expect_success 'conditional include, hostname' '
+	hostname=$(git var GIT_HOSTNAME) &&
+	cat >>.git/config <<-EOF &&
+	[includeIf "hostname:${hostname}a"]
+		path = bar12
+	EOF
+	cat >>.git/bar12 <<-EOF &&
+	[test]
+		twelve=12
+	EOF
+
+	test_must_fail git config test.twelve &&
+
+	cat >>.git/config <<-EOF &&
+	[includeIf "hostname:$hostname"]
+		path = bar12
+	EOF
+	echo 12 >expect &&
+	git config test.twelve >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'conditional include, hostname, wildcard' '
+	hostname=$(git var GIT_HOSTNAME) &&
+	cat >>.git/config <<-EOF &&
+	[includeIf "hostname:${hostname}a*"]
+		path = bar13
+	EOF
+	cat >>.git/bar13 <<-EOF &&
+	[test]
+		thirteen = 13
+	EOF
+
+	test_must_fail git config test.thirteen &&
+
+	cat >>.git/config <<-EOF &&
+	[includeIf "hostname:$hostname*"]
+		path = bar13
+	EOF
+	echo 13 >expect &&
+	git config test.thirteen >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.43.0

