Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3313A783E
	for <git@vger.kernel.org>; Thu, 14 May 2026 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762508; cv=none; b=ri6m0zeTGsKrutae+xswJoP98Tg8i+nAV5WW6FkUZdg2ZD3LfZ9Td0dYMha0yfHyC255Wm69ObeuGj2eKVQ47MMBoyUXuEPgcJHEXAvo/WA/Ki3IQys4iIHIiqlAGgqq9Ua9y0FuezJ5wq6D4zoqm/ncIEgrbdutLj67xUt5gxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762508; c=relaxed/simple;
	bh=HygjA70fj6duAOmN8XAmeUGcAmbdCIZWfSyagQ+Ikwk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I/P4vB7nvGx3d9NxqM1UB6EkvWrjo3UQZ/SPw5S5YNAI0ul8e3v/yb8Q3z0K2kNN6hlwnKGN3hFLI839XQJfb3G7r01ZgYQYBGZdKeC6UN9spwM6ERvUgKOUeVtfNkxayy21ZlbXR8HI2zqPaj92aM5c497VB3FWDcMiVNLong8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nr5RwFLf; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nr5RwFLf"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2f3c623322bso13374879eec.0
        for <git@vger.kernel.org>; Thu, 14 May 2026 05:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778762506; x=1779367306; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StEqhcomJAVPflL8Oa8F+7ystxhSEXJ8hYfBIJMd6WE=;
        b=Nr5RwFLfm67jN7RINr2vJCsC5usFyrJ/Kszbb/6WiHly9LQgo95jSgSGWNPzaxJhi3
         bS+pcH322zwaiJYC1rUvs3dj1XVJb+wt5VhiOrqU3qXAYZ4fwNZI+4YjDjnoFqbMSIbz
         sXpH6LfOGjVVUyFE4ROuiM2zisVuLu7TjxOCBjecLL4Q53vvM3xfZKG37zddpQ9wf+g4
         RxSKSQ+V0t43qhbsyoQC8SUa2dHeTk/cuy5KM5JGuPIJQl8JYrtbK4/MkRA351jywCCb
         WmgkEy369zGRnnshVJwfRwHAObOPE6kOcJret6EO5DdeCPWAXM5z1WHrVyU6CBOjYloy
         cnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778762506; x=1779367306;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=StEqhcomJAVPflL8Oa8F+7ystxhSEXJ8hYfBIJMd6WE=;
        b=RP2OL7zlekv5TieS/qFozscIepdG06hkrzXx5efIejcpuHep9UhO6lLD7FdKheKGAk
         ZkyhdKxKxXKlElA9DW6wg9O0hAlG8ry6GuXzuyN+js6rMbVmpEnDy69ImL6mzjqhWPNi
         MIAMl5pRONcYvhz+0eb8iGZi8Ow2KdXOHrtAvd8SgSQab870RiFTa+43qpwFnGQXRSpx
         5sViTGNhx3SSrqA8JAeltoPzzssp2YYiAkRd4GuLldt/9FvGQsLgD5xbdG4M+TUmek1L
         LQPoBmU8T9tkch5Z7ILvZ4J0YOHnu0NhXM5X9W1FwWY+1nfwEjWE1p5/i75DjjB9iWdr
         yVdg==
X-Gm-Message-State: AOJu0Yyi/xP9Ewjwt8eABsOXmI3T8HRqFQJ30FGkCAXcwJbLY2mE9e8s
	xF3IMR1FTMsyV53TyoZgM+MkPcjZSvvwqx1tDXPvO1K7dvH0u7px1a9BFWGb5KRF
X-Gm-Gg: Acq92OGmKhV86zHz+VZtn5iGtRQTAg/t0yyZFVN1oshA4MNBsrMCkGx5EIUXt/9Ua2M
	7e5ksqjACZUUB6SzLdvyBgz/X3Ogt9Vorv9y1xDH2D47+WQBIKml22q0/RV4rwnl1Kza1m5c28e
	Ql7PElNKJGM0fZQJzLVFaGSx324vVTg0fmyRL7XtydyFsSPAcNxkhva58qLldQGBzHTlWRWHuF2
	xtBjtpJPTG4LqxObbhsZaKAaiHI5b2r2CDvKCSZann7xWOYpFhkP61uakULI5YBO7CYxYJhffZK
	n+BFJA8ccn+rg+N5fqC8PP9eMDhZ6rsUBhjGkbT/CA55lbqpgevDXq1YAFztMJoaMwchThm+830
	CUn/wABcjFzel6F1Ou+RD7XnMVL1bSJcA+t+ku7gCZJ6VOTy66Q/hoVEbRz1afOseTgnsPhvZi4
	uCStmJdg2utzeOXsSXhNgOhugZcQ==
X-Received: by 2002:a05:7300:ad06:b0:2c8:6361:ab2e with SMTP id 5a478bee46e88-30153fc1151mr4376645eec.8.1778762506086;
        Thu, 14 May 2026 05:41:46 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.45.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6adsm2999691eec.15.2026.05.14.05.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 05:41:45 -0700 (PDT)
Message-Id: <94b79784fe6a4f22dba32a2e1d44316b3e84da48.1778762495.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
References: <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
	<pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 May 2026 12:41:32 +0000
Subject: [PATCH v4 5/8] negotiator: add have_sent() interface
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
Cc: gitster@pobox.com,
    ps@pks.im,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

In a future change, we will introduce a capability to choose specific commit
OIDs as 'have's in fetch negotiation, with the ability to have the
negotiator choose more 'have's to increase coverage beyond that required
core set. The negotiator works to avoid emitting 'have's that can reach each
other, but that logic is hidden beneath the negotiator's iterator function
pointer ('next'). We need a way to communicate to the negotiator that we
have picked a 'have' so it could incorporate that into its logic.

Add a have_sent() method to the fetch_negotiator interface. This is the
signal that allows the negotiator to track the commit as already shown and
can perform the proper bookkeeping to avoid emitting those objects or
anything they can reach.

For our non-trivial negotiators, it is sufficient to mark these commits as
common, so the implementation is quite simple. This logic will be exercised
in the next change.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 fetch-negotiator.h    | 9 +++++++++
 negotiator/default.c  | 8 ++++++++
 negotiator/noop.c     | 7 +++++++
 negotiator/skipping.c | 8 ++++++++
 4 files changed, 32 insertions(+)

diff --git a/fetch-negotiator.h b/fetch-negotiator.h
index e348905a1f..6ca422a064 100644
--- a/fetch-negotiator.h
+++ b/fetch-negotiator.h
@@ -47,6 +47,15 @@ struct fetch_negotiator {
 	 */
 	int (*ack)(struct fetch_negotiator *, struct commit *);
 
+	/*
+	 * Inform the negotiator that this commit has already been sent as
+	 * a "have" line outside of the negotiator's control. The negotiator
+	 * should avoid outputting it from next() and may use it to optimize
+	 * further negotiation (e.g., by treating it and its ancestors as
+	 * common).
+	 */
+	void (*have_sent)(struct fetch_negotiator *, struct commit *);
+
 	void (*release)(struct fetch_negotiator *);
 
 	/* internal use */
diff --git a/negotiator/default.c b/negotiator/default.c
index 116dedcf83..05ab616f39 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -175,6 +175,13 @@ static int ack(struct fetch_negotiator *n, struct commit *c)
 	return known_to_be_common;
 }
 
+static void have_sent(struct fetch_negotiator *n, struct commit *c)
+{
+	if (repo_parse_commit(the_repository, c))
+		return;
+	mark_common(n->data, c, 0, 0);
+}
+
 static void release(struct fetch_negotiator *n)
 {
 	clear_prio_queue(&((struct negotiation_state *)n->data)->rev_list);
@@ -188,6 +195,7 @@ void default_negotiator_init(struct fetch_negotiator *negotiator)
 	negotiator->add_tip = add_tip;
 	negotiator->next = next;
 	negotiator->ack = ack;
+	negotiator->have_sent = have_sent;
 	negotiator->release = release;
 	negotiator->data = CALLOC_ARRAY(ns, 1);
 	ns->rev_list.compare = compare_commits_by_commit_date;
diff --git a/negotiator/noop.c b/negotiator/noop.c
index 65e3c20008..edf1b456f3 100644
--- a/negotiator/noop.c
+++ b/negotiator/noop.c
@@ -29,6 +29,12 @@ static int ack(struct fetch_negotiator *n UNUSED, struct commit *c UNUSED)
 	return 0;
 }
 
+static void have_sent(struct fetch_negotiator *n UNUSED,
+		      struct commit *c UNUSED)
+{
+	/* nothing to do */
+}
+
 static void release(struct fetch_negotiator *n UNUSED)
 {
 	/* nothing to release */
@@ -40,6 +46,7 @@ void noop_negotiator_init(struct fetch_negotiator *negotiator)
 	negotiator->add_tip = add_tip;
 	negotiator->next = next;
 	negotiator->ack = ack;
+	negotiator->have_sent = have_sent;
 	negotiator->release = release;
 	negotiator->data = NULL;
 }
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index 0a272130fb..69472c58e1 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -243,6 +243,13 @@ static int ack(struct fetch_negotiator *n, struct commit *c)
 	return known_to_be_common;
 }
 
+static void have_sent(struct fetch_negotiator *n, struct commit *c)
+{
+	if (repo_parse_commit(the_repository, c))
+		return;
+	mark_common(n->data, c);
+}
+
 static void release(struct fetch_negotiator *n)
 {
 	struct data *data = n->data;
@@ -259,6 +266,7 @@ void skipping_negotiator_init(struct fetch_negotiator *negotiator)
 	negotiator->add_tip = add_tip;
 	negotiator->next = next;
 	negotiator->ack = ack;
+	negotiator->have_sent = have_sent;
 	negotiator->release = release;
 	negotiator->data = CALLOC_ARRAY(data, 1);
 	data->rev_list.compare = compare;
-- 
gitgitgadget

