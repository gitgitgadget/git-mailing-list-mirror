Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FB432E12B
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710651; cv=pass; b=kltMMgT5qwqZviUI6146TR8mVG4aDtbN4+GPFXyHsO31/qCzm5xrDND729Oi7bt6kb2qrlQTjAnga6xbjmIHh9fd8mPYEXmO4UZbVxaWJ+ttUSANdFxIQLdZp8nSYCvVP0pSvriN3JM0DCKtZFTJ5vvtFFjT1H2TcuBBYIDgOfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710651; c=relaxed/simple;
	bh=3jBeLZLpCm5n4vwgqKp6Jo3+JzqQOCcpjNx26dOdLZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUPnc3XzuPdJH2uqlxrEZR48e7VNIDR82wphV4k5mX8ggxcnBGq6okW8kg+qsGk9M8FsAo51fd519Krrx5l6kpOLe+Q1gNSfQQJYTqQLPA1cX/Z1/tQhGV6moeUJK1yJRJ0Vi/b/m9B0GK+FAbU7Syu8jhXeBJtqqm40LYWJU7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=iT2lsoMY; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="iT2lsoMY"
ARC-Seal: i=1; a=rsa-sha256; t=1760710639; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=grt7kgZ+qOYGWxVdQtB2Wuubg0q4aqkm0Q7ZAkx/fSr0OV7SwMJmbjwqjSJThf6OakQvl6Sigx0uGObZGrrM3t3KwZG++kcEXXNZ6muTcn+JzwcbdWgXklC81RkWVGvuSsaeGjRE4mK4RgqmqJmUxBIHnhStl+ApbxXVUfxfSm0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760710639; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=K1AxlVHyTHyYaEhXHFvf5rwPjO7qmKkbzgmY4X+8tzg=; 
	b=nIKp5TNz8mREGBKRLsZVlD8Tb6iqi3+cwabzIkwAIPvOgmsTdsuBRKT1wwE5D5h66cm6t687QRoA3K65d/o3CWcbfhY3LjzEAuauWnGGs/CPNCRItMEwu2BQkpp2JM7148rBQ2BAa/7+ZUIeSxL6tOEs9EHZDfbhxs5k0ue0Jkw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760710639;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=K1AxlVHyTHyYaEhXHFvf5rwPjO7qmKkbzgmY4X+8tzg=;
	b=iT2lsoMYUTNZcfIhX6rym0FpuHQRHasbS/3JqhmBt9ql+jCJNdDiRLhj+Ns7+v+M
	LeS6VZAvVAUeqYch38AXcZJIMMU9MVtlK6R5+KzZ2iqOFXW0N37/rcjP/Lahbhib0zi
	2H3K7SOOV29OK5jGnB6l40voI9NJ6omlt6rlQi5M=
Received: by mx.zohomail.com with SMTPS id 1760710637014212.04955846143218;
	Fri, 17 Oct 2025 07:17:17 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 04/10] transport: convert pre-push to hook API
Date: Fri, 17 Oct 2025 17:15:38 +0300
Message-ID: <20251017141544.1538542-5-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251017141544.1538542-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Emily Shaffer <emilyshaffer@google.com>

Move the pre-push hook from custom run-command invocations to
the new hook API which doesn't require a custom child_process
structure and signal toggling.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 transport.c | 83 ++++++++++++++++++++++++-----------------------------
 1 file changed, 37 insertions(+), 46 deletions(-)

diff --git a/transport.c b/transport.c
index c7f06a7382..67368754bf 100644
--- a/transport.c
+++ b/transport.c
@@ -1316,65 +1316,56 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
 	die(_("Aborting."));
 }
 
-static int run_pre_push_hook(struct transport *transport,
-			     struct ref *remote_refs)
+static int pre_push_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_task_cb UNUSED)
 {
-	int ret = 0, x;
-	struct ref *r;
-	struct child_process proc = CHILD_PROCESS_INIT;
-	struct strbuf buf;
-	const char *hook_path = find_hook(the_repository, "pre-push");
+	struct hook_cb_data *hook_cb = pp_cb;
+	struct ref *r = hook_cb->options->feed_pipe_ctx;
+	struct strbuf *buf = hook_cb->options->feed_pipe_cb_data;
+	int ret = 0;
 
-	if (!hook_path)
-		return 0;
+	if (!r)
+		return 1; /* no more refs */
 
-	strvec_push(&proc.args, hook_path);
-	strvec_push(&proc.args, transport->remote->name);
-	strvec_push(&proc.args, transport->url);
+	if (!buf)
+		BUG("pipe_task_cb must contain a valid strbuf");
 
-	proc.in = -1;
-	proc.trace2_hook_name = "pre-push";
+	hook_cb->options->feed_pipe_ctx = r->next;
+	strbuf_reset(buf);
 
-	if (start_command(&proc)) {
-		finish_command(&proc);
-		return -1;
-	}
-
-	sigchain_push(SIGPIPE, SIG_IGN);
+	if (!r->peer_ref) return 0;
+	if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) return 0;
+	if (r->status == REF_STATUS_REJECT_STALE) return 0;
+	if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) return 0;
+	if (r->status == REF_STATUS_UPTODATE) return 0;
 
-	strbuf_init(&buf, 256);
+	strbuf_addf(buf, "%s %s %s %s\n",
+		    r->peer_ref->name, oid_to_hex(&r->new_oid),
+		    r->name, oid_to_hex(&r->old_oid));
 
-	for (r = remote_refs; r; r = r->next) {
-		if (!r->peer_ref) continue;
-		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
-		if (r->status == REF_STATUS_REJECT_STALE) continue;
-		if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) continue;
-		if (r->status == REF_STATUS_UPTODATE) continue;
+	ret = write_in_full(hook_stdin_fd, buf->buf, buf->len);
+	if (ret < 0 && errno != EPIPE)
+		return ret; /* We do not mind if a hook does not read all refs. */
 
-		strbuf_reset(&buf);
-		strbuf_addf( &buf, "%s %s %s %s\n",
-			 r->peer_ref->name, oid_to_hex(&r->new_oid),
-			 r->name, oid_to_hex(&r->old_oid));
+	return 0;
+}
 
-		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
-			/* We do not mind if a hook does not read all refs. */
-			if (errno != EPIPE)
-				ret = -1;
-			break;
-		}
-	}
+static int run_pre_push_hook(struct transport *transport,
+			     struct ref *remote_refs)
+{
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	int ret = 0;
 
-	strbuf_release(&buf);
+	strvec_push(&opt.args, transport->remote->name);
+	strvec_push(&opt.args, transport->url);
 
-	x = close(proc.in);
-	if (!ret)
-		ret = x;
+	opt.feed_pipe = pre_push_hook_feed_stdin;
+	opt.feed_pipe_ctx = remote_refs;
+	opt.feed_pipe_cb_data = &buf;
 
-	sigchain_pop(SIGPIPE);
+	ret = run_hooks_opt(the_repository, "pre-push", &opt);
 
-	x = finish_command(&proc);
-	if (!ret)
-		ret = x;
+	strbuf_release(&buf);
 
 	return ret;
 }
-- 
2.49.1

