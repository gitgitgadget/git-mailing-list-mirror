Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24FB3B14B1
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784884316; cv=none; b=XJ94Qnvi9beHEDJbrXBOSZayXgqLx57niMNZXi8TKXimW0h4bUT2iYT0ZVXkvVmWZ6NwQwOpKnbxl61fvVRdoZxl2zew96nH4l/XawM9xl8wpNlcp0iTLuElwRfjADda41W2MpG+jKKJvw5malofQ6Nfid7TUHiYAPXGkVQG5Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784884316; c=relaxed/simple;
	bh=kl1L9WEB4hlGYau2b5LSYAN7EMlN7a05zvT0P9uT5fs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gj3BukYcjNvJ4prHYKV8d+Ws9QPYG1QREnj09F6VtzgB68tlPInsZPI3Upd18IrDTGnhoFr56MLMHS45Yrue5AFXzAakw2CivuK4ezCu1U1RqmPi7zg++3oZu/CsVIZnO4wJB2nIeCRP9HCqY5YoLRS6sKgPQ6OKYkNl74pxvXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=THuK2imX; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="THuK2imX"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c8612812170so32264a12.2
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 02:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784884314; x=1785489114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gIP+9G35JMOafhFl1avKqq4UsN7L5NauJKz9wdGhLQs=;
        b=THuK2imXClr5/myOEE4FuFuOEx/u5Vj3CHGgqJ93a5qjsCzjEmVGIxaVb/SXFuzizU
         l+gy9g181fmtYXKbTL8js4w0S7dNBLggY/3F3mU0XtgfnGjlL75lrew7HPkDPqSpjpui
         xe/j9CJOlwed0E3p04D1wkv9tMW4QENqWnCrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784884314; x=1785489114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gIP+9G35JMOafhFl1avKqq4UsN7L5NauJKz9wdGhLQs=;
        b=GDvJCSo4Nwiy+iYtT9rVXus9d39gp5nBCQy243VeHJPCf/07MICEFXxkK3ZYFATYW5
         hdPT7H5lmvqWYuMfVg7TWmHAwpDjqOI0itg1hu9uK3aXGithgm37XyV1qLNd4zr3slmB
         Ldkn9HaaeaGoZ703viYp1cXZEAC+csKIh3tLbDerGnBqOEb+PrC8L3Up9czmXfG8c+Kl
         AKgGaA6Hwp0aKqYbp9V9Ch9+Y/AclF+AnUETxVpl0FJU0PgRudgEWwdF9FqtZavyRtrH
         d8h3hFEt6mneDr7tETGs94tAzZZcUjqr5UWiv3SFAQdloz0sdli3kO7nVnc0EfpVjniK
         ibGA==
X-Gm-Message-State: AOJu0Yw5JboyomwFDBR8g/sSsdm8zRnvWBa8un+mubxAr4WWdC9AvDqY
	KG46l2ZVpNPLO0Xs1BgqEeD7UYEhmBL2q8PRiMewPGFsHenow/GYidN890b4O/vuCLhAY0XOiLe
	cydRTpzg=
X-Gm-Gg: AR+sD10f6m6Z4UHCK8O+QxmjHl+bMPwm6f9KdpAWYhtzpkgBmcDulSwzGDnoghK5Iig
	AkgZrrKhX9bOYFO9lIPQsdnDzzrsV321AYVJ1JYEwUu0v6jSIqe+HpIPei6RqsyL21OWEhMUSbZ
	F2gUR0EVq5mZS6pUALXI4NJbLEMac4ZoDutRVoRqucX9rK0dMZw6ZbNxKfjqY1kFmZOBafwamdH
	0o+QnSu7qVIUMTPR0R0b0TRozoxUMYRVGUiAMpQNYACub1uSITjoEe8XVyx8qjVZIWO6tUk3KZd
	5uqnwUcTHR09rS0/ppIqO+rY10dyHiB/RCVsdLV7ewTn9Trs1DVVETZjhKRoSvuH01DbKjVq51I
	cuQLwQwgmD5LPXsbKH9WQFfM/Z3LhNs8Ly/kLhfp8a5J/SnUv9KjzPOxw7gW4fAewb1ML2IqftM
	2g7JxIbmG11DfviNK0lSqiYtbwcl93uWLViLCniJ9oQvYkS2BgShLUotdWXcHAXmsCpu9qqKb2+
	D3xwjdilH0K348KMdnOpylxZw==
X-Received: by 2002:a17:903:1b4c:b0:2c9:ed4a:c3a4 with SMTP id d9443c01a7336-2cfbc786e8emr26530095ad.0.1784884314078;
        Fri, 24 Jul 2026 02:11:54 -0700 (PDT)
Received: from com-76773.corp.openai.org ([2601:646:300:69b0:f912:1358:fd39:7404])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc8b0cdsm28143961eec.11.2026.07.24.02.11.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 02:11:53 -0700 (PDT)
From: tnyman@openai.com
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	haraldnordgren@gmail.com,
	Ted Nyman <tnyman@openai.com>
Subject: [PATCH] branch: avoid slow strvec Coccinelle matching
Date: Fri, 24 Jul 2026 02:11:53 -0700
Message-ID: <20260724091152.27794-2-tnyman@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ted Nyman <tnyman@openai.com>

The --delete-merged implementation declares a loop index at function
scope and reuses it to walk its strvec of upstreams and its list of
candidate branches. Coccinelle 1.1.1 spends hours matching this against
the separate_loop_index rule in tools/coccinelle/strvec.cocci, causing
the static-analysis job on 'seen' to reach its six-hour timeout.

Declare each index in its for loop instead. This avoids the expensive
separate-index rule, limits each index to the loop that uses it, and
leaves the branch deletion behavior unchanged.

Signed-off-by: Ted Nyman <tnyman@openai.com>
---
This applies on top of hn/branch-delete-merged and addresses the long
static-analysis runs on 'seen'. Coccinelle 1.1.1 spends hours matching
the existing separate_loop_index rule against delete_merged_branches().

Declare each loop index in its for statement instead of sharing an
index declared at function scope. This avoids the pathological matching
without changing branch behavior.

The CI failure reproduces locally with Coccinelle 1.1.1: applying
strvec.cocci to the original builtin/branch.c still times out with
"spatch --timeout 120". With this change, the same check completes in
0.06 seconds.

The full coccicheck run completes in 47 seconds, and all 190 tests in
t3200-branch.sh pass with a fresh DEVELOPER=1 build.

 builtin/branch.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 42f2221547..2415a275ea 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -797,10 +797,9 @@ static int delete_merged_branches(const struct strvec *upstreams,
 	struct strbuf key = STRBUF_INIT;
 	struct hashmap_iter iter;
 	struct strmap_entry *entry;
-	size_t i;
 	int ret = 0;
 
-	for (i = 0; i < upstreams->nr; i++)
+	for (size_t i = 0; i < upstreams->nr; i++)
 		if (ref_filter_forked_add(&filter, upstreams->v[i]) < 0)
 			die(_("'%s' is not a valid branch or pattern"),
 			    upstreams->v[i]);
@@ -809,7 +808,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 	filter.name_patterns = argv;
 	filter_refs(&candidates, &filter, filter.kind);
 
-	for (i = 0; i < (size_t)candidates.nr; i++) {
+	for (size_t i = 0; i < (size_t)candidates.nr; i++) {
 		const char *branch_refname = candidates.items[i]->refname;
 		const char *branch_name;
 		struct branch *branch;
-- 
2.54.0.8.g047e0526de
