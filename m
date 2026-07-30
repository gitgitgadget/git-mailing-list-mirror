Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329003839AA
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 03:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785382873; cv=none; b=EiCdq27S6oYLP1OfOf3UdETBik9EKiQj2dPhe3kOG4Wurjxdptwy7MID9g6B8IWDeuf1tCCG+Rng0PnVFR7fjr57pBAa4eLBYP+Gfrg9N4y0vCiMydaQXvfCs6RH7hg+yb8dZi33yqFrn+OjE/eABpXAq9bcVkJ0PN11wCHOiQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785382873; c=relaxed/simple;
	bh=JUovlP0oEt5/xe4fCwh99dMSdQKBagUf2iQotrUFeeg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFRYDRltBNfJudkSrxGHmQFFiRbaHkTDiJZhwW5w1FVTNaQkzWCROTSiGA/rUAtp1+JnjxP5QiDI/weDI3MYDEjcQnI1FCzysGA1tjZEf/aoGCSgpXH7Qi5bE8KdQvIRRgOwIxA8eNZC3aXTkBEj5H8zXGNORvz5ltlwPSQb5bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cXsZqP4p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rdKn1nqi; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cXsZqP4p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rdKn1nqi"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 591CAEC07C6;
	Wed, 29 Jul 2026 23:41:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 29 Jul 2026 23:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785382871; x=
	1785469271; bh=HKl55Geod49bkjumfaSMqWLjR8grVsh1mFpgvDfIAWg=; b=c
	XsZqP4pLZdUPnU42/SPL5mE3jF6v3rRUICnbX+dvSoPXymSX6UGEzAkGjRQDu4Uv
	dSCIiGjnhkKAAWN8q4vwJOQ0T/ZBAFi5U7D+GBsYKbsGWgj06BoZm3ekJQBBi1wC
	z0RncSVeuk0a1bepcy9sUG3kLslTKBWAjN38hkiE02Br0E6EJ/Vz9CGNnKZ5fIvz
	hXowlmnBsmePzWMehPzSK041kE3FwiFJf2ut4DYdSNtUl8aPVx9y0DNyA9tAlDWf
	qvChFPNgkMLA99eGS21S2zqfxRTxFMpyEXPg6RasB0Vate8CKqOtUw3/pBSH9Feo
	ypet0nPEGZFT0M7+1TUhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1785382871; x=1785469271; bh=HKl55Geod49bkjumfaSMqWLjR8gr
	Vsh1mFpgvDfIAWg=; b=rdKn1nqiMkFHXUK1wYto7IXHCApDKAP7ZGLZco/B7/yQ
	E0ebzCMUgXYFBYNlmoJPXhkS6vyVJQeuIgpUbh6cAeyEhtXa9uqxiH8bMldAHt5F
	FfxrBZESabdwp7fUgoiBQsTI9hOpKnjs4kRdWYY861WyX3KEa2OhiUgu1dRNX6JZ
	Ep04T161Ifjomd+H36aYocdTAhJMFdAEFqVyo9f32UoBGE1Y3OAp94UrD84fV0or
	qaQl4bzwoyJ/M5mO5+Sz7+L4ijmLzr9HSFuXLPIoMDietd8D1rvQ9ozfVs1nMAja
	i7bpib+uiJdvkWcT1JvDOWlX1ly8cGhy8U+pBmj+TQ==
X-ME-Sender: <xms:18dqavjNeZtYBfWn8HiPPY8OgtVWJGMybD--v6vpl-gU5ztO5xp02w>
    <xme:18dqaiAiHWub2oA7LIdGzl7j54My4mJP_jAPNcACmLGQroizy6BnpKXuNtCL7E247
    KfOVJtBvBGjakXdEZbnPOQxgkCIfAgL4oCdBKY7fe8M44voZOMIVn4>
X-ME-Received: <xmr:18dqass92TFCewNzMZetJCbtQqEZx0Ht1BxsKDIYwppxeJ6gk7FX3CqkY2-En6zDLxFGXVOIH2jyMSeqm0HUtNUXJGiDaW7w7Q>
X-ME-Proxy-Cause: dmFkZTFsE1BsIMENIm/qyDeURXaXQS5u9ATgKO/saClpSAi6N7VYG6gU+6U8jVPlrL67S2
    ptoc4ButuFZn0L0HedRx6xgxFHSRd5DQ21qF81lDALbE1Ot+JPFoDJEG39CCPmzoSDtulN
    LX5Nig05u3XetiULrtjyuiTD1U33OnDMqZhX4x84XnqzqJVyxql4esEfduuRXUqXWVbvSo
    URAD3Vufcx9AFYrLhpHQdu8tMOd2qMLWG0KyXnOqipjOYV6rb0BbG3tROpNheuUOlllBxX
    QCKJF9TFbOqTiaJeMoUsxJchRl0ngEhpUeftFR6jh1I4cI8/f+glRZzn6kAt4TbZkFC0X4
    X2bGSlGPIf2t1HNLm1mZzvySNjaMB0OvWisHc6MmMxqEyZ4JRtCClgIVVKe3pWDUuORNK1
    Gsa6GUFswuxBYz3ONbc2g2UWW1PFWXYdHen881o9HYkUKYtdVBoyLOzCMpWwWRPnfoi7jp
    f56NwK4tgVDcygmHsH1oGt0uQNgfCBSRYvYY9f7mqIS3bRWfAAnE5fjioWymqljh6bPYBa
    lzfnXGzf8PhIdeyKe18V7lzMSBXkBKQt+IQdUI05LSP4h6TRUS3l/pQyhhGtifLnaI/YxA
    HtGOs2ehupCIm/NrZBleCBM414EI7K3t+zz2FRxXepOjvCokS+KirY5apiDA
X-ME-Proxy: <xmx:18dqanb6AZDeT9Zz708OLx_ghZXRnjALwU3sI7FnhxtRxKY8Xgv7Tw>
    <xmx:18dqavUlbDpZ4W0rjz5W7bOw0erEi8CNUrg-7JuE2Op_91KXJpTwBw>
    <xmx:18dqar4ymhsdfxdnMcs5rDprz3jRseH5uwYgxqp9_mEyYBrOEv3mlQ>
    <xmx:18dqaqgB-7AA9CPQK9pMZaYHdjlYpGwNpnvD5FobgtCvkXNANBHESg>
    <xmx:18dqai44ZeHnanKniO6NcfxJ2Tbtqp1vVaFB1psJ4ppzylokKdov9gWb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 23:41:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/2] stash: record positional index in 'struct stash_info'
Date: Wed, 29 Jul 2026 20:41:07 -0700
Message-ID: <20260730034108.765430-2-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-597-ge6126a35d6
In-Reply-To: <20260730034108.765430-1-gitster@pobox.com>
References: <20260730034108.765430-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_stash_info() resolves revision arguments (such as 'stash@{0}'
or '2') and checks whether they refer to 'refs/stash', but it
does not allow callers to determine the 0-based positional
reflog index.

Record '.stash_idx' in 'struct stash_info'.  Populate it in
get_stash_info(), setting it to 0 when omitted (defaulting
to the latest stash), to 'n' when a valid positional index
'@{n}' is specified, or to -1 when the index specification
is invalid or non-positional (such as a time-based reference).

Subcommands that manipulate reflog entries by index can use
'.stash_idx' directly, instead of parsing the revision arguments
themselves.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/stash.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/builtin/stash.c b/builtin/stash.c
index c4809f299a..5041a9ba81 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -175,6 +175,7 @@ struct stash_info {
 	struct strbuf revision;
 	int is_stash_ref;
 	int has_u;
+	int stash_idx;
 };
 
 #define STASH_INFO_INIT { \
@@ -248,6 +249,7 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 	char *expanded_ref;
 	const char *revision;
 	const char *commit = NULL;
+	const char *at;
 	struct object_id dummy;
 	struct strbuf symbolic = STRBUF_INIT;
 
@@ -300,6 +302,19 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
 	}
 
 	free(expanded_ref);
+
+	at = strstr(revision, "@{");
+	if (at) {
+		char *ep;
+		unsigned long u = strtoul(at + 2, &ep, 10);
+		if (ep > at + 2 && *ep == '}' && u < 100000000)
+			info->stash_idx = (int)u;
+		else
+			info->stash_idx = -1;
+	} else {
+		info->stash_idx = 0;
+	}
+
 	return !(ret == 0 || ret == 1);
 }
 
-- 
2.55.0-597-ge6126a35d6

