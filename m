Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15E75013C4
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863229; cv=none; b=N+bsgwsv283RLT7ds/sTWD1RHGlriC+EbcZ7UHi90dq35xCDy6r1rrruQtHwR5gDcIn3NsOeR9hZAU35ICe6AJG+IBKsm6KgUn5Lf4bd3P0as2J7INkOq6/t70D6gpclHr/klf1bHYvuZReYrySjaOGaniJIPqGb2SRSLHacmw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863229; c=relaxed/simple;
	bh=WzOcS1WLXBBuyQwK1MjqFgeB8DwxmNNWao3PG9u3Gmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F1eiVNvZYD911RrG6xUPcVTr/VUaLDIl/oVVGWm5KTd6GeB2936xBuUqa+OqllTLn3A71igaerwQbq0tXepci5LZoLSMy63+lM79wChaN6tolH/pSqzwzHXd8lP99DIQVjaq7YXDCK52+Z6Z8vTXzpwg9PVoMXNX+5WeZPgKnAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeAod0ft; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeAod0ft"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48449f62b93so361865f8f.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 03:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788863226; x=1789468026; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AdzVEEGWxrcOHMswh+uTkAA12Wc/DREv0buX+aRLl9k=;
        b=SeAod0ftAHlPniKhDmcsrfCR8W+OrX3z0CPSq6QJ5cZh8jXiMw2dDclHiRvki6oHet
         u+z0A5Vq1qEa+72W8dgLmE8eHS0HgE3iLQooV3kuHBQ/e+Mqq+EAlffll9qr7k7KDLcn
         OLfFIqOEUMX5v+wohUcXAGLu3aVvL7RX1MgdU0KUgVTZiL7ld55IBgpd9eDHsCkqLvCw
         EK1/Oq85IM7clQcyBJgOEVGQWtQXvWYrUFRHV0Ro11gLWEosDdiEOoBsaOjjsFGb0bz6
         eO+5au/0oWJoXnHVyP9ZlqT5GEqmi5trWIa62Md7g1yG7aGtFmIWxuRkJdXjT6eakjkn
         bQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788863226; x=1789468026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AdzVEEGWxrcOHMswh+uTkAA12Wc/DREv0buX+aRLl9k=;
        b=MDzD0gV7yY7MHgpoaAGMWNDf6p26tej4d5jkj2sLKSwDfIJliM8EWks/DNtKU5mcMh
         r8hxwwDViNDr8lTEBC3f7LsYylWXv52cjK9Rf10EYl3JjAx3o/ozgLf/QmX6EJsQzrH/
         qT1v+R4y7+nVmEB1u1DShmXycGt1RGzXHQQ/M/tajUJEVCwsfp6lcmUkFpy+H/ZayFtm
         49aUwZsDCShBRTxMdjcfYazWhJPBoCmaNB5Q9KuCxd2/V0/7L1E62J5pcmKYHAlRbwew
         u2vUy6lKuJcuddlwkJqh3xBecdAgFAFCeHqhnkkDBndcH/lHmvMyYlB+IxztEaXOz+Zu
         sOFg==
X-Gm-Message-State: AFuF++lW+cVN52qF3gxdn9rQVTs256tVNfTLdkbyfPUnh/qIHkTUsqiR
	SdDkVr6nircp6SPT9EHccVmoKBAicqpQ7BSNDN3HqRsH+tEs1hlinFi9
X-Gm-Gg: AYBFou3JkbX+SkdlnOFuMUpi968LdLH/mpZ+XxhjSF1Q1z3hK7v1x2XCMLXSCCcOqR+
	RzbiiVY8Sdj9LRmRlTUDYuC3e8nkNND2gDPiKeFjmCJ62Snbvgy54v+kdD+XzUfDQ39Lepp9kIF
	B8rapNEDIaiI2vSo0ayylWXI6xS427SoBC366g8bKBC31T5XqT+R22ncAtkOpOU4fZscVgXzvo/
	yQmyRXP6L7yxpsNuBzmQXM9r19jniaHc8qVCL4s0xmt+QiISpbyIYll+mdA3yC0bLOzF33HLXoY
	ddfPqtB+huri3lwnuI/56hMgDnQ/iNvheIpHZVa2lsMbxrnabr4T1vGYlIs6vNOr/dREmDmiTk1
	gyVgaSEEqAUOnBXYYcxPsCD2vufRTFCW2sK46t5xM/Hryj4voFZzqTwbDBQcQF0tXeQXh7nbkx+
	uQWVIQ2NLQkWaCe5Cjl22VBjUy04mBMyN0WHmAWhBq0Wp01SV2KCvfHAaoPjdHWsSeyQHTIfdh7
	NdjTqjGpkmpqBwAqfS2RZXVoYFqwCjPujdRAA==
X-Received: by 2002:a05:6000:4685:b0:485:8ddf:7a5e with SMTP id ffacd0b85a97d-485a241877emr5366382f8f.11.1788863225736;
        Tue, 08 Sep 2026 03:27:05 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:ed36:96cf:ac4a:2747])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885be1c1sm34446572f8f.32.2026.09.08.03.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 03:27:05 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 08 Sep 2026 12:27:01 +0200
Subject: [PATCH v8 1/4] doc: add proc-receive hook info in
 'git-receive-pack.adoc'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-758-introduce-hook-v8-1-be88a671ae1f@gmail.com>
References: <20260908-758-introduce-hook-v8-0-be88a671ae1f@gmail.com>
In-Reply-To: <20260908-758-introduce-hook-v8-0-be88a671ae1f@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=WzOcS1WLXBBuyQwK1MjqFgeB8DwxmNNWao3PG9u3Gmg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqf4veJ9SRLOwr6GtsZYiKV4MSpdDXjgGsDk
 G1FsIobxGcqn4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqn+L3AAoJED7VnySO
 Rox/35EL/RB5U3LTBDJBtyM2T1i5wpmSBw2JH4DjvG/G9LFX5iJUWPz5Akvrtu9B9vI8+jpKHln
 ek68Zxrv9b+tGVq8sWtOvTIaXG+ND9DwFegsTsRTyzaglN9QJEyOVx0Uf/VvA6z4F2isPU4wn4b
 a3wZJdYns5LCCq4AVUEnK9CBeIlWWhDGz9NudbfjqiwA0g8MUSBSO3lgNTVdNetGwH8RF+gm2JR
 0lHTuqOR7BOTZBva8Zv5X8D/bOb9M6+PRNTQ8H3huq8nmkPk3zv8TxyOKJ8kZnxzffqon4JtqMl
 2L3b+u4q0cki+WZBLq56MauXpaj4THAOx4cZFXMhe7/YABspU1572FGFyIlP2KQ/+KxHIKI4lLP
 PmBRkYsWuWzEJeN2K8m7xHsBDFxmP9831Bd/2+vaSLbPZ5zeHrN+axlgSIvpPt81XJ8TesA6nGN
 g1f5TqxJ0fwXWu+8dt9eLSC7EnnIGTZTA3JdKSYUUILuGTfsHe/G/ds2hgFIrRbixCGdM89V9L7
 O0=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The manpage of git-receive-pack(1) documents hooks invoked when
receiving a push. The manpage does not mention the 'proc-receive' hook
though, which is also invoked as part of that process. Add a paragraph
about this hook to plug that gap.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-receive-pack.adoc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/git-receive-pack.adoc b/Documentation/git-receive-pack.adoc
index 0956086d61..5806792ba7 100644
--- a/Documentation/git-receive-pack.adoc
+++ b/Documentation/git-receive-pack.adoc
@@ -236,6 +236,14 @@ if the repository is packed and is served via a dumb transport.
 exec git update-server-info
 ----
 
+PROC-RECEIVE HOOK
+-----------------
+This hook is invoked by linkgit:git-receive-pack[1].  If the server has
+set the multi-valued config variable `receive.procReceiveRefs`, and the
+commands sent to 'receive-pack' have matching reference names, these
+commands will be executed by this hook, instead of by the internal
+`execute_commands()` function.  This hook is responsible for updating
+the relevant references and reporting the results back to 'receive-pack'.
 
 QUARANTINE ENVIRONMENT
 ----------------------

-- 
2.55.GIT

