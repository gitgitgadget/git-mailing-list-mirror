Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0D63F44C0
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563885; cv=none; b=uxGpr38cWkGK4yv71an47cMnvrO70lAmOMViiPSPjKyTrQRdjKjv/yWdIDdKXi/dDwn4/KYbw/R9XGWQRHTBDpgpWkdcgvc7lreGYQMf4KdnzLrFOcenwI+oerftYkIj/cN/2MNNNKksrdU7ZBPABXvFbvJwIjllBuDhLz0SDwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563885; c=relaxed/simple;
	bh=1xJMFPniy0isx20K4GQaKZhajzhGweU//TV9Gj+2rSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=myIhNH/2NTxg0NDEyKjRd/5W3GdJ62alKrsE8acqgSungX/R5+7xjVI7Zx4s9fvyClZuHnvcta3Gi5fGbX71OeN9wStdvXUySgPFHi1oovJAzQsKv8N7HRJfe4m/v5eVQO7ERXzbGE7/kCtsIZdEqynkXba1e3wXkjXnZepJamI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGW9meYt; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGW9meYt"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c197eaaab00so536565566b.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2026 02:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787563879; x=1788168679; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GegnWJKnYQKkUj2azpIw6ukOXaq2+VV1ZmghQ1+uHh0=;
        b=EGW9meYtjo+MnzdWwy9PdrRqzkGzrHr/+UpSkT2shj5zi5Mr4kZPMZtMuNx26I/nh7
         uc3DBQS/hC9f0+IKQG+Yp6ltlum5uVXpex9zC019T2N2rTVsgDfYa6iUC3dTjnhq+fbY
         uZ9aNPxSgVv2a6q8vRr0kixsBFEE/ZSZ1ejodx0SnngwI0kAjOAXBtdpC2RdAmBiJj+Y
         50CkXHmK/qXcj/eOdczgQvWr+GN3OCF83U/ynTXDdWhfEDFQpkxa3cJz+0ajvSlyRaFH
         dQbtDfnDqFdWr80aMIcKCJfv5Nhkeq5uS29f8o9VLVc0gtvv4KXG0rl2e8gofYPArq8k
         2FYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787563879; x=1788168679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GegnWJKnYQKkUj2azpIw6ukOXaq2+VV1ZmghQ1+uHh0=;
        b=SDagsFc0tgyRywzzqWaLXM+BqZFlBO5Xtxd1CdzaKpjOZ8pug7c9XqRcw258Ueuxw6
         z10qPaz/Oz09TYJmSecRH3Z2+Vg8ZR2ipkxm61m1VJsEiC91bRoA/Cnpyx8CCo8K6cOw
         4vAvxHjsgbHwCWCSqQ3KkP62ABnL5o0VvbE9msHAgawN1onf3x7LPYsx4KL9FnwLOGjB
         gUZqj0nGqNDiU1iAsRfMLoqT1K0PcfsUGwuZ7kG6Rpb3uvBofOhpk6vioGd3voBgA6lI
         2vj9kdZYYFcOk6l41iB/wVwHl6WIRV5fnWbxMk7Tk+sClVRxMBlat3FryHDgMIRyTrpC
         Li6g==
X-Gm-Message-State: AFuF++lBwBpHssNXbwIGWKkj4FuSg2FeEjjvbc2+19IkkCjnrPmfxf/Z
	H8kJB2iPvmrqkiCFV7OvjWaN4tFhlPsDdG3tde2urKZjmUn3UgE2zdJB
X-Gm-Gg: AR+sD10I/BZycLs0E4Hn765glNiCSk8AKjyDuDR2r48ZbEQRsckQDn9HMjuc8clEO5x
	EF7x1KGlhx4ykX/oQMv9yqXW0tzu/ALuPeRW3q6FSzjm2p4EbzhDbRFXxarPRVZliiWCw/lA6aN
	V6uDvZzyshXlyw7/CCsVGbjrQRvby9cB+rkFlR3zSboTbsPT74QHjWO0j6RXkKTg+HtGgC48Y66
	ZaQ9mAbKjhvDWrm1fjJc2ntTpZuaEnDlVI0heYteRnhlu1Dnf/89OJz1rOq3t/49lVKYzYHanJF
	fxCELr+hquFF7xWHvnnCTPFlXX/FCCq+fjo1bmsygdl9ppVqNAR29w+sYCv5vk1XpAafEGfpHLh
	6vv1qG1ODr7qc8dTjl9/TYKspXR9B46L4Kln4qdyldgFGVO9w8NnXoFME/jGog69DfKWJ7/LdhE
	R92YKdw1JCCoRKa6X3+44Q3YagQNnP7sT+I8JXPOJ6/PsHFoSele90OlFHJV/ZnM4DVZcQMtfAd
	TgDjf9IYM8jLM7p/eWOtFWCWwbeMLKEtS4PWvQ=
X-Received: by 2002:a17:907:c30c:b0:c20:9447:bd6d with SMTP id a640c23a62f3a-c246a683fc8mr3017422066b.11.1787563878379;
        Mon, 24 Aug 2026 02:31:18 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:d6d5:360a:4ee9:3f53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f9cbcsm1303013566b.29.2026.08.24.02.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 02:31:17 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 24 Aug 2026 11:31:02 +0200
Subject: [PATCH v2 4/4] reftable/stack: avoid reloading the stack when
 already locked
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-740-optimize-reloading-the-reftable-stack-v2-4-9c9de2eb0af7@gmail.com>
References: <20260824-740-optimize-reloading-the-reftable-stack-v2-0-9c9de2eb0af7@gmail.com>
In-Reply-To: <20260824-740-optimize-reloading-the-reftable-stack-v2-0-9c9de2eb0af7@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com, 
 jltobler@gmail.com, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3701; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=1xJMFPniy0isx20K4GQaKZhajzhGweU//TV9Gj+2rSM=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqMD2AqxDN0AZlR3LquFdWp6B/p9QEReSxfq
 7eLQL2BdOuasIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqjA9gAAoJED7VnySO
 Rox/59oL+QE+z3+eki9z6ryRqdXxTOoX1zj19h+z+SQtX/avJLtXbxwag8cPiqdgS17UrWjy4b7
 V5O63H+Encvd97ObYWaeOsJjgti63cR9gE/jmBYyqMGHK72X5ffLKqyB2dNx/N3MUpezUOEKbDg
 8BG6bMQo0QtTaFQXPTauvCnGSleFzzX3ku132znwCC7X8Dih5kE603w4D+S9yI8ecdoLZe7AUR6
 73fUMY/U3gW4U7y4NwN3vVSI6/z0GPitr6Q5M1kR1DqJ/AvfvZqlOnSTRaDukxMigYs0Nds1eVE
 AxAA6qsSz7QiGQ4LOJv2jAa9ghb67KlxX08aKtKIIhxmO80Cmon4FNn9/vNqpwWtNkN+GO0BmqK
 9U07c5/MQqXmSnDreXIJubx38fF3R8OE1AQr2s3O/XvvjvnwrH6ipoT3i5SH7PJfUpBqwpNZKao
 vTu3cWbrtswDGXVgTu09/u3WeQvKgqnBcR7S2NdZ//gxkOuoKws5rhegvGQzs587z3tpD8zLYf9
 lk=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When making modifications to the reftable stack, the stack obtains a
lock to the list file and removes the lock after the commit phase. Since
most operations reload the stack to ensure we have the latest state, any
branched operation during the locked phase could trigger a state reload.

To prevent data loss due to concurrent writes, state reload is necessary
right after obtaining the lock. But any reloads after that are just a
no-op. Now that the struct has access to the lock file status, simply
skip reloading if the lock is present.

Benchmarking with a fixed, non-symbolic target OID in the 'refs/tags/'
namespace (since it triggers a stack reload when checking if reflog
exists for the given tag name), shows a consistent 15-20% improvement
with these patches:

  refcount   master     patch     speedup
  --------   -------    -------   -------
  2,000       18.5 ms    16.6 ms   1.11x
  20,000     120.7 ms   102.8 ms   1.17x
  50,000     296.5 ms   247.1 ms   1.20x

We can also see the improvements in the number of syscall counts. On
master, the number of calls to `newfstatat()` grows linearly with the
number of refs created. With this patch, the number is now a constant:

  refcount   master   patch
  --------   ------   ------
  1,000      1,059       55
  5,000      5,059       55
  10,000     10,059      55
  20,000     20,059      55

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 reftable/stack.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index c3d4deff29..47a60db079 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -553,14 +553,21 @@ int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 
 /*
  * Check whether the given stack is up-to-date with what we have in memory.
+ * If skip_if_locked is set skip stack reloading if the stack is currently
+ * locked. Stack reloading must _not_ be skipped right after obtaining the
+ * lock, to check for concurrent updates which may have happened.
+ *
  * Returns 0 if so, 1 if the stack is out-of-date or a negative error code
  * otherwise.
  */
-static int stack_uptodate(struct reftable_stack *st)
+static int stack_uptodate(struct reftable_stack *st, int skip_if_locked)
 {
 	char **names = NULL;
 	int err;
 
+	if (skip_if_locked && st->list_lock.fd != -1)
+		return 0;
+
 	/*
 	 * When we have cached stat information available then we use it to
 	 * verify whether the file has been rewritten.
@@ -623,7 +630,7 @@ static int stack_uptodate(struct reftable_stack *st)
 
 int reftable_stack_reload(struct reftable_stack *st)
 {
-	int err = stack_uptodate(st);
+	int err = stack_uptodate(st, 1);
 	if (err > 0)
 		return reftable_stack_reload_maybe_reuse(st, 1);
 	return err;
@@ -693,7 +700,7 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
 		}
 	}
 
-	err = stack_uptodate(st);
+	err = stack_uptodate(st, 0);
 	if (err < 0)
 		goto done;
 	if (err > 0) {
@@ -1200,7 +1207,7 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * we could check that relevant tables still exist. But for now it's
 	 * good enough to just abort.
 	 */
-	err = stack_uptodate(st);
+	err = stack_uptodate(st, 0);
 	if (err < 0)
 		goto done;
 	if (err > 0) {
@@ -1319,7 +1326,7 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * tables with our compacted version. If they don't, then we need to
 	 * abort.
 	 */
-	err = stack_uptodate(st);
+	err = stack_uptodate(st, 0);
 	if (err < 0)
 		goto done;
 	if (err > 0) {

-- 
2.55.GIT

