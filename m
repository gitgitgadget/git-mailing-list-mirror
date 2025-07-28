Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABFB266584
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 13:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708152; cv=none; b=g+frcYwzwP8RK+jqhIytJegWVC4UV9Mcg7kt97mk8s3zMtieaLnUBsHrzm/owNmtsTr61P+zSdSqIpM9ozWo4v2sqREEIxqM6TCkHzS65yu6qtSi0R3ScrK6TnvE5se98Ka46rrP0hLsm5kD2ncjMbClkrYOh8BoZRqOX7tOVSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708152; c=relaxed/simple;
	bh=6lBDNqzU9IYHMujtkcBD1NMsjuOBX6+KeOSi6dPraYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O9pJHErvClozx3r1FVs8xO0cACqOpv3kMVzItJ/RujtobLJr/g3BkQLHKmZP1yHDRFKTXHWkjJbNw0pEV3Aorw3dYbGBuGaLuFBw77VP+Ysf02FzV/kCAnvDM7l1kH7e+Uozigj2PSn3HyiTx9rM9TUtm3hTm2EYnWtfYENP0pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kCRM0u7h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KcQHOkph; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kCRM0u7h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KcQHOkph"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 92DDDEC0090;
	Mon, 28 Jul 2025 09:09:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 28 Jul 2025 09:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753708149;
	 x=1753794549; bh=8VQLfGxIMzTaXhCqF3ku1pixL53MAWRkxgTF4dFTY60=; b=
	kCRM0u7h2ft5FCznQos5WftBNubvpwcpE0/KvZ/8fDdIuNlmN5QYnp67Vbl6MFIz
	UC0CJPXFbBsHAiuE7DWPbVaC4W3lYl9l7fKCjN9nsvD/vlRzR5PJOKPL1n8yegA7
	8jTE7MN7wfRn+5YWHPCneTmWmztQcP0YrRKWBSu11vMedvxqLVRsfoCBU33BfuOq
	2fpoHLb+44TLlig644QbJ2IbGhKcG5qbrJzSLdcw5iF326izFuhJ3++ONzF7t0ue
	0R89zDfrkzzTNsMlWlOyiDPQdwt/mx1atJijlhOiuUmxurnszCx/kKBloQJl1iM2
	eiWkw8C8KQXpcy0n56XYVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753708149; x=
	1753794549; bh=8VQLfGxIMzTaXhCqF3ku1pixL53MAWRkxgTF4dFTY60=; b=K
	cQHOkphQpGMa+Jyl+dH+TLOvPbJJ+/oL7f5sB5Gggq/xM91McQnCLvirvLIq8nzI
	QXaonZy6ZwrFEv1HNJB0dBseMGMiJQY+b4zb2wk175UxI+41Z/0mi94jH1zan8jA
	2cVzs8AOrVBmij/9rTIT7lt/BN/lz9xIwWe+EAijq96nTt/PmfKa1+u5w2Y8OD4c
	4nImMbYgTI4Tgns+yzWPfKG7/9y793MsT7gEJrhAK9BMqWcv+9L55XKuli2qvmT6
	LxTrgTNs3igzFWnm1gaobtWRii1PVoOT+KaU6pgnhsMPBaUsuIn/KlBIPRGL/U9+
	rL1f0qpYcVHacEG5Hnw8A==
X-ME-Sender: <xms:dXaHaJmjGlGBc4D6Cz5TIE7vWjKQehKnpZnRx5aIgru6-CPwXsaxzQ>
    <xme:dXaHaPYrSWQxMij-32E3b6-R99hUID3tsngKXqxDKrRHWFLs5ut9lLjRX0FbatUwd
    sFg7Z60KdN-A9OfWw>
X-ME-Received: <xmr:dXaHaMPJjiT9CX2u6Kz--Z3lhuSusb0Jt1dYnlMBuJLoFSwDxlg8kM2mrdYEsjrSIHY46vQDgwTCkO_vFGmeeyEKOxI25LjsV1Y-_lCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgf
    dtudffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehjhhgtrghrlhdtkedugeesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvght
X-ME-Proxy: <xmx:dXaHaMZPFqE0AuWk5oFyWljWRzYeA8V4K1S8l0kvpUjT81HGoVoPSQ>
    <xmx:dXaHaC0pSi_nIloXJrPDFknh7ABNJPoCBir0C71Fh7qMIBp0v8YfHA>
    <xmx:dXaHaKcJ-Ub9kdw9-a8-FdMusqoZZE4q-f2tE-Xqq5pH5i_B8jJnvw>
    <xmx:dXaHaLEM1snLmOedUUiFf4vJ7jqkn9Dgn3c_wEhKwM0XsflYlA55dA>
    <xmx:dXaHaIWq0lsRDJNT8k-KamD28OSOQaAp6xs1L6VqTIsOXiCGQInsG70U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 09:09:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c8a36dac (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 28 Jul 2025 13:09:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 28 Jul 2025 15:08:48 +0200
Subject: [PATCH 4/4] builtin/remote: only iterate through refs that are to
 be renamed
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250728-pks-remote-rename-improvements-v1-4-f654f2b5c5ae@pks.im>
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
In-Reply-To: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Han Jiang <jhcarl0814@gmail.com>
X-Mailer: b4 0.14.2

When renaming a remote we also need to rename all references
accordingly. But while we only need to rename references that are
contained in the "refs/remotes/$OLDNAME/" namespace, we end up using
`refs_for_each_rawref()` that iterates through _all_ references. We know
to exit early in the callback in case we see an irrelevant reference,
but ultimately this is still a waste of compute as we knowingly iterate
through references that we won't ever care about.

Improve this by introducing `refs_for_each_rawref_in()`, which knows to
only iterate through (potentially broken) references in a given prefix.

The following benchmark renames a remote with a single reference in a
repository that has 100k unrelated references. This shows a sizeable
improvement with the "files" backend:

    Benchmark 1: rename remote (refformat = files, revision = HEAD~)
      Time (mean ± σ):      42.6 ms ±   0.9 ms    [User: 29.1 ms, System: 8.4 ms]
      Range (min … max):    40.1 ms …  43.3 ms    10 runs

    Benchmark 2: rename remote (refformat = files, revision = HEAD)
      Time (mean ± σ):      31.7 ms ±   4.0 ms    [User: 19.6 ms, System: 6.9 ms]
      Range (min … max):    27.1 ms …  36.0 ms    10 runs

    Summary
      rename remote (refformat = files, revision = HEAD) ran
        1.35 ± 0.17 times faster than rename remote (refformat = files, revision = HEAD~)

The "reftable" backend shows roughly the same absolute improvement, but
given that it's already significantly faster than the "files" backend
this translates to a much larger relative improvement:

    Benchmark 1: rename remote (refformat = reftable, revision = HEAD~)
      Time (mean ± σ):      18.2 ms ±   0.5 ms    [User: 12.7 ms, System: 3.0 ms]
      Range (min … max):    17.3 ms …  21.4 ms    110 runs

    Benchmark 2: rename remote (refformat = reftable, revision = HEAD)
      Time (mean ± σ):       8.8 ms ±   0.5 ms    [User: 3.8 ms, System: 2.9 ms]
      Range (min … max):     7.5 ms …   9.9 ms    167 runs

    Summary
      rename remote (refformat = reftable, revision = HEAD) ran
        2.07 ± 0.12 times faster than rename remote (refformat = reftable, revision = HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/remote.c | 15 +++++----------
 refs.c           |  8 +++++++-
 refs.h           |  2 ++
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index b1c55909184..11981f732bc 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -710,16 +710,8 @@ static int rename_one_ref(const char *old_refname, const char *referent,
 {
 	struct rename_info *rename = cb_data;
 	struct strbuf *new_referent = rename->buf1;
-	const char *ptr = old_refname;
 	int error;
 
-	if (!skip_prefix(ptr, "refs/remotes/", &ptr) ||
-	    !skip_prefix(ptr, rename->old_name, &ptr) ||
-	    !skip_prefix(ptr, "/", &ptr)) {
-		error = 0;
-		goto out;
-	}
-
 	renamed_refname(rename, old_refname, rename->new_refname);
 
 	if (flags & REF_ISSYMREF) {
@@ -976,8 +968,11 @@ static int mv(int argc, const char **argv, const char *prefix,
 		rename.progress = start_delayed_progress(the_repository,
 							 _("Renaming remote references"), 0);
 
-	result = refs_for_each_rawref(get_main_ref_store(the_repository),
-				      rename_one_ref, &rename);
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "refs/remotes/%s/", rename.old_name);
+
+	result = refs_for_each_rawref_in(get_main_ref_store(the_repository), buf.buf,
+					 rename_one_ref, &rename);
 	if (result < 0)
 		die(_("renaming references failed: %s"), rename.err->buf);
 
diff --git a/refs.c b/refs.c
index b820c3908bd..861a0deb924 100644
--- a/refs.c
+++ b/refs.c
@@ -1840,7 +1840,13 @@ int refs_for_each_namespaced_ref(struct ref_store *refs,
 
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", NULL, fn, 0,
+	return refs_for_each_rawref_in(refs, "", fn, cb_data);
+}
+
+int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
+			    each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref(refs, prefix, NULL, fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
diff --git a/refs.h b/refs.h
index a39f873b1fe..9decd3126e3 100644
--- a/refs.h
+++ b/refs.h
@@ -428,6 +428,8 @@ int refs_for_each_namespaced_ref(struct ref_store *refs,
 
 /* can be used to learn about broken ref and symref */
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
+int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
+			    each_ref_fn fn, void *cb_data);
 
 /*
  * Iterates over all refs including root refs, i.e. pseudorefs and HEAD.

-- 
2.50.1.565.gc32cd1483b.dirty

