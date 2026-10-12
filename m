Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879E03C988B
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791832650; cv=none; b=GpZY7XF1ngkFPZhhSAT0LZqH/rK92zu+xnS1R1Nt1jLMloHqT6pGG1pNWu6B7wQhESXo151bp4YJRGdoM2Nm6ODGohnNlCjzKrr5CnNtTbvZ1ar1qp7l4z7lhqnkSHzBIucxq4hjQKc6rn3J+nnNYYp5sxsTc3haCQFXGY0TMdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791832650; c=relaxed/simple;
	bh=Gz259xWDpmT5yaeuNlGQvpIy/TCwlx+3f8k5yF3gP9o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cCUzuMqMleTsp3blxMJ6yLdwdQkHvTzlY1tZtFGoTxLpXxAvPPhtwTgIdcU+mazwXg4anrtqqFEC6dr33gipOjKHFhH3iiyWxuMMpn3L/66oanGg/41upzZWjWZcXg69MpNoTILF8VB/Kyp180Yoj2PawboEXtcnK4WcPXi5TJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJ/Ti606; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJ/Ti606"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93e5c8f53a9so186275485a.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 12:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791832648; x=1792437448; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VKwp/HZCGNHqzQLg5FaubiD1lrh9fuuEwHrXkpVQ2NQ=;
        b=IJ/Ti606vs50qU9Fd5HMaUy/FrX5zExUgIqo2BnL6+zlYHTXwozb2LssaZ9/h2RBCH
         yVhvjQcMuK5hn/A7ZdVLLmT+gFAO9IjDu1Ck8FcOUDDYRdDfP4TVhbHjYA978nPWc5Kh
         KFWUE7ASZAO5vjdkBbloyf5lX9zUzrOgrlAylpJ5v+84bHZN7QNdpnLy0NNA4wgwjv0Y
         Tp47uiXg8wRmK8HJgBTkepo3soIy85AbpVZQKsty+RJn/ZD3JnK2MRwGbKPQoeKe5NTs
         ztOBDdln38WwR9D+y7cVv9JpYoX7GwPKeaqoNAEPmNksdEoyCF9ya72r/E7tJB3G+zhC
         WXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791832648; x=1792437448;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VKwp/HZCGNHqzQLg5FaubiD1lrh9fuuEwHrXkpVQ2NQ=;
        b=oD5bP1EiKw5bqEkBd49FMaeLC0j5bbdWKhYrUFrz3zqsObxKW2RefVaRjK5OJZuADo
         bH3pLIzaM2DDt3ibIBDn4aAuKQUsQNs+NBXs37qsAmCXgSMLl90XvsDY3PyUhi3oLQuM
         ewQTvjntxDSkLGWKht8KABILYfKKBg6JJVhCxGCBPWyqr/D/ctP5YCPMqAQphl3TzCMe
         8yiiwcPaXvvGVMtnoIzZJMD1O16xs0IWrhRWDpXdvUTJx+1tXUWdQWtBT55Xxl/5iwZE
         XfD3jRNob3Xe82avfS1WJUvNYUwMPGNHVi4SQT11mdYIcnGxQ5LETavS94r8M7RbnsQp
         SvMg==
X-Gm-Message-State: AFq9FYIcBjsfc0n7sb5JANYp4rGaqcZDUE2Jh93zulKXNcJbZIbAk6Cm
	qYxyEbF8AitWuTffeGZj9wTkGAr4xhUCRjHINmVBazC3ZXWmhPP7f5UPfetgS2xn
X-Gm-Gg: AYBFou3YVWsrq6ty4W4vQ1WHXb1BbZI1VOinjtKKrgUHXEqOuyhglgthxvk0nwp2DNz
	r7A8rRgGiLIZ7zXdFRNmlv0D/Oiy8n4Ge0tloxtaAxtF7xzgoboNEmTelln62jYgClx9YylOIbi
	FSliOvvFXzS6GvkTrkJhUbtCl6mya4+o5JTSWP8RUJqXfh8ITTrERrCtLHpxqhofY2TlTNTd9v3
	fbJrW1eB82XLJpeeE5fvV8iJjdbKcZzbZT/oARhHutFqmq5ibQf2+ducE+2y9SNst/LGcJHWOoo
	gvXhLpPO94GnU9ynYnds0x0iPyzG+DiLl0sdcN/DjlyQNAh8tGjqdbY37N0TIde7lC/aGZoQRGB
	k63gtuV4s5FDDung3YdTA9nzZ8UjDAZE7ryFu4aOa3+nTBvCtfkgumZsYUe/DewMNOb802wKl7B
	xUwXqwqvF/4Z35QRvvX0n0T+pcMpdsaCXRuXg1/6jh0sCzCz9uOfgj+Ky463ppjULmfAgmA8vZu
	Rye
X-Received: by 2002:a05:620a:371b:b0:93e:c12c:f11e with SMTP id af79cd13be357-93ec12d05b8mr1691969585a.74.1791832648238;
        Mon, 12 Oct 2026 12:17:28 -0700 (PDT)
Received: from [127.0.0.1] ([52.224.247.165])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef502497bsm58874385a.17.2026.10.12.12.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 12:17:27 -0700 (PDT)
Message-Id: <2e12486c0d5dd8b94393b08413a85a8d47f86edd.1791832644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2224.v4.git.1791832644.gitgitgadget@gmail.com>
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
	<pull.2224.v4.git.1791832644.gitgitgadget@gmail.com>
From: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 Oct 2026 19:17:23 +0000
Subject: [PATCH v4 1/2] blame: harden ignore-revs parser and tag peeling
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
    Abhijeetsingh Meena <abhijeet040403@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Ravi Mistry <rmistry@google.com>,
    Ravi Mistry <rmistry@google.com>

From: Ravi Mistry <rmistry@google.com>

Currently, blame.ignoreRevsFile and --ignore-revs-file only read paths
explicitly configured by the user, which cannot point to an
attacker-controlled file under Git's threat model. An upcoming commit
will teach git-blame(1) and git-annotate(1) to automatically read the
HEAD:.git-blame-ignore-revs blob by default if it exists, exposing the
ignore-revs parser (oidset_parse_file_carefully() in oidset.c) and its
tag-peeling callback (peel_to_commit_oid() in builtin/blame.c) to
upstream-controlled content at a well-known path.

Harden both code paths before enabling the default blob:

- In oidset_parse_file_carefully(), strbuf_getline() reads up to the
  next newline and records the full line length in sb.len, including
  any embedded NUL bytes. However, strchr(sb.buf, '#') and
  parse_oid_hex_algop(sb.buf, &oid, &p, algop) treat sb.buf as a
  NUL-terminated string. If a line contains an embedded NUL byte after
  a valid object name (such as "<oid>\0garbage" or "<oid>\0# comment"),
  *p is '\0' and trailing bytes on the line are silently ignored.
  Reject any line containing an embedded NUL byte via memchr() before
  stripping comments and whitespace.
- In peel_to_commit_oid(), odb_read_object_info() is called without
  OBJECT_INFO_SKIP_FETCH_OBJECT or OBJECT_INFO_QUICK, and deref_tag()
  calls parse_object() on tag targets without checking whether the
  target object exists locally first. In a partial clone, any missing
  commit OID or tag target listed in the ignore-revs file would trigger
  lazy promisor fetches and pack directory rescans during git-blame(1).
  Use odb_read_object_info_extended() with OBJECT_INFO_LOOKUP_REPLACE |
  OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK and peel OBJ_TAG
  objects one layer per iteration, verifying that each target object
  exists locally and matches the tag's declared type before parsing it.

Signed-off-by: Ravi Mistry <rmistry@google.com>
---
 builtin/blame.c              | 20 +++++++++++++++++--
 oidset.c                     |  3 +++
 t/t8013-blame-ignore-revs.sh | 38 ++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 48d5251c6d..6741a7b9df 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -911,21 +911,37 @@ static int is_a_rev(const char *name)
 static int peel_to_commit_oid(struct object_id *oid_ret, void *cbdata)
 {
 	struct repository *r = ((struct blame_scoreboard *)cbdata)->repo;
+	enum object_type expected_type = OBJ_ANY;
 	struct object_id oid;
 
 	oidcpy(&oid, oid_ret);
 	while (1) {
+		unsigned flags = OBJECT_INFO_LOOKUP_REPLACE |
+				 OBJECT_INFO_SKIP_FETCH_OBJECT |
+				 OBJECT_INFO_QUICK;
+		struct object_info oi = OBJECT_INFO_INIT;
+		enum object_type kind;
 		struct object *obj;
-		int kind = odb_read_object_info(r->objects, &oid, NULL);
+
+		oi.typep = &kind;
+		if (odb_read_object_info_extended(r->objects, &oid, &oi,
+						  flags) < 0)
+			return -1;
+		if (expected_type != OBJ_ANY && kind != expected_type)
+			return -1;
 		if (kind == OBJ_COMMIT) {
 			oidcpy(oid_ret, &oid);
 			return 0;
 		}
 		if (kind != OBJ_TAG)
 			return -1;
-		obj = deref_tag(r, parse_object(r, &oid), NULL, 0);
+		obj = parse_object(r, &oid);
+		if (!obj || obj->type != OBJ_TAG)
+			return -1;
+		obj = ((struct tag *)obj)->tagged;
 		if (!obj)
 			return -1;
+		expected_type = obj->type;
 		oidcpy(&oid, &obj->oid);
 	}
 }
diff --git a/oidset.c b/oidset.c
index c8ff0b385c..90d39204d3 100644
--- a/oidset.c
+++ b/oidset.c
@@ -85,6 +85,9 @@ void oidset_parse_file_carefully(struct oidset *set, const char *path,
 		const char *p;
 		const char *name;
 
+		if (memchr(sb.buf, '\0', sb.len))
+			die("invalid object name: %s", sb.buf);
+
 		/*
 		 * Allow trailing comments, leading whitespace
 		 * (including before commits), and empty or whitespace
diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index cace00ae8d..70fe509a64 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -327,4 +327,42 @@ test_expect_success ignore_merge '
 	test_cmp expect actual
 '
 
+test_expect_success 'ignore-revs-file rejects lines with embedded NUL bytes' '
+	rev_b=$(git rev-parse B) &&
+	printf "%sQgarbage\n" "$rev_b" | q_to_nul >ignore_nul &&
+	test_must_fail git blame file --ignore-revs-file ignore_nul 2>err &&
+	test_grep "invalid object name:" err &&
+
+	printf "%sQ# comment\n" "$rev_b" | q_to_nul >ignore_nul_comment &&
+	test_must_fail git blame file --ignore-revs-file ignore_nul_comment 2>err &&
+	test_grep "invalid object name:" err
+'
+
+test_expect_success 'ignore-revs-file peels chained tags and skips missing tag targets' '
+	test_write_lines BB L2-modified L3 L4 L5 L6 L7 L8 CC >file &&
+	git add file &&
+	test_tick &&
+	git commit -m D &&
+	git tag -a -m "tag 1" D_TAG1 HEAD &&
+	git tag -a -m "tag 2" D_TAG2 D_TAG1 &&
+	git rev-parse D_TAG2 >ignore_tag_chain &&
+	git blame --line-porcelain file --ignore-revs-file ignore_tag_chain >blame_raw &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
+	git rev-parse A >expect &&
+	test_cmp expect actual &&
+
+	test_config extensions.partialClone origin &&
+	test_config remote.origin.promisor true &&
+	test_config remote.origin.url /nonexistent &&
+	missing_oid=$(test_oid deadbeef) &&
+	bad_tag=$(printf "object %s\ntype commit\ntag bad-tag\ntagger T <t@example.com> 0 +0000\n\nmsg\n" "$missing_oid" |
+		git hash-object -t tag -w --stdin) &&
+	test_write_lines "$missing_oid" "$bad_tag" >ignore_bad_tag &&
+	git blame --line-porcelain file --ignore-revs-file ignore_bad_tag >blame_raw 2>err &&
+	test_must_be_empty err &&
+	sed -ne "/^[0-9a-f][0-9a-f]* [0-9][0-9]* 2/s/ .*//p" blame_raw >actual &&
+	git rev-parse HEAD >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

