Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBDE413D9C
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 19:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921386; cv=none; b=S05AyeMfHiioKob1mME3+EkYRovwRx6AgE8r6OtONiTCbR0O5i7dSk242qVgX7jIcVPcxTInkb9F6M5e7CCutny5PXG1MLg/+nr1TS23qLiUGsNQmTHsAaEK+xMX3Wy+ZhhIPN1nRLMDGzycgOSVWwwHyMdLxTvQ2s5bY8fJYRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921386; c=relaxed/simple;
	bh=PVFgTwX2p4jaVVrIaUUQi/Sbwfmh/ev3/LdCuzX7+X4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MfGGe9pJ6/IZb4JYDe46V4DmwDrglk+v/CCeyC6+UT9MZUBC1SAcyx6sZgq8KiNBH42BJsjnO5j4Ygk1YxgiYxcq9f1lm4+pjd06+qzuxZmwJxrfgn+luLiR+yDNu6391wr9wwWU5D0O9k8p+V98okpgWh0dBDIX6BRZpIXL1Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=otu6nfMd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otu6nfMd"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ceed7018c8so6014725ad.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 12:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784921382; x=1785526182; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K9cJbpx8ZfkQh3EZ5g3AEUtzDNQDPQHz2sCij1sZAZU=;
        b=otu6nfMdllMFOeD8amldHyuGafYIUcw6Zv3QIyO2UcqA8l0sId6jNnC2+LLw4zfsto
         ERR454Wq6sC1mAvLhk9QfwdrYUpmyr5BBkLufqjVYqs7DTNGZukeOAQQZjrmoPr/IFTt
         0cOg224VDiRFWn7v7swUip5Mph0+VeuHRi3tYUnq0/100c2BLXXdZID2EspB8jLOdrEO
         ha+nwniAV7um9kHdiSJAC+OIDYZdwvDkZZkdQSB4KJS6mX//MpsrYGXY3zjMwp41XkOe
         zPvRBSMvcQDRJHPwRveltaoczwUCxWCtE1+fE+gYuhKtHmhf4hWiKPfRW5OdflY520Ec
         DR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784921382; x=1785526182;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K9cJbpx8ZfkQh3EZ5g3AEUtzDNQDPQHz2sCij1sZAZU=;
        b=T4Gn8usPq937I5eQJhaYt0O4ylzsIysQh8SERXYzcgXbm/lhC79ZPBjVb5PVv/YGm9
         45WQXem9dPBP5lu8N0CGDp86Xq+fP+OeIMs04bw47YwFJv9arBIGosHwnNy75p+rkWCx
         yUWNoYBS9vJkzrMihoo1nHc99DCp/GR55ihbzL3fQRkhB/Z/3EDpDm2e9n9y1L8xcoOM
         Q9xs4eRWQnluFkdOrWqlSAE0KVQjIvr7Mhz73ZLlpG4CBfWJKMfgc8oRnjlFj8qYWzv/
         4Gxvf6tW/Kgin18ua8fPg2M+s0A6YB4Nwc+ha1q94Zn2l7oe2hYIDk4DA5vwTzJaEDfK
         TiSg==
X-Gm-Message-State: AOJu0YxXyctwrb4kJa+3I3sEOPkQCUVfC9zivFW8KO/fQinflpKKGikY
	aV7VNZ/VM1UVRMa0p87UmB1s5vMK8U5I1AMdGVpzGxLb2V9UfZOBcqRk5sVAHQII
X-Gm-Gg: AR+sD12x9/T+WIfLn35s/n9+SbxkiN+Oi05hWh1l9eRjUg40qWRmp0FU5rZuWFPff3q
	lMQD7L0IRevM3Uf5z4LZ5MrrmiMFpS72QqdcQ1Yxhqh5ZkxUrzaNI6/7y4gixN6tCAL5uneJC78
	KZfUQKAi/MQoLWUt6ZkuMFeAz9xDaXU51RrNQ95XpQ7cp4ZvORtcCyn2DcrvlLY50C8zD5fjG1e
	GuuHITOpsxeNskdbvPPfZ75bY12ajMsriJJSYgxnENnMDFnognjQyA12NJqq/UsIM1r3JXjLNls
	iVml6QP6AZtVmhPaEzybHzPq6VsFqB6pfXFDxYdfucLPk885oAJOki9EGgj1WIom7E8MZ0pgy0c
	MXN0JkYVcyLQ31P25mJ0avkE8NVqIzUaMIG0mqQdGbA/5pDRz60/ma/BLTbXbPfQiBZCwQZfcZG
	yhF0AypA==
X-Received: by 2002:a05:6a20:ae2f:b0:3c3:a41f:ce83 with SMTP id adf61e73a8af0-3c44b24e86amr8654750637.61.1784921382270;
        Fri, 24 Jul 2026 12:29:42 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.211.27])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e261fsm2245360eec.6.2026.07.24.12.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:29:41 -0700 (PDT)
Message-Id: <e70e64c866676f4223059e5422a3fb38115f4763.1784921375.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v22.git.git.1784921375.gitgitgadget@gmail.com>
References: <pull.2285.v21.git.git.1784889377.gitgitgadget@gmail.com>
	<pull.2285.v22.git.git.1784921375.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Jul 2026 19:29:32 +0000
Subject: [PATCH v22 4/7] branch: prepare delete_branches for a bulk caller
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Teach delete_branches() a new mode for the upcoming --delete-merged
caller that checks whether a branch is merged into its upstream without
falling back to HEAD when there is no upstream. Existing callers keep
their current behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 504117d1c3..1ef8362c12 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -168,10 +168,13 @@ static int branch_merged(int kind, const char *name,
 	 * upstream, if any, otherwise with HEAD", we should just
 	 * return the result of the repo_in_merge_bases() above without
 	 * any of the following code, but during the transition period,
-	 * a gentle reminder is in order.
+	 * a gentle reminder is in order.  Callers that opt out of the
+	 * HEAD fallback by passing head_rev=NULL are not interested in
+	 * the reminder either: they have already established that the
+	 * branch has an upstream, so HEAD is irrelevant to the decision.
 	 */
-	if (head_rev != reference_rev) {
-		int expect = head_rev ? repo_in_merge_bases(the_repository, rev, head_rev) : 0;
+	if (head_rev && head_rev != reference_rev) {
+		int expect = repo_in_merge_bases(the_repository, rev, head_rev);
 		if (expect < 0)
 			exit(128);
 		if (expect == merged)
@@ -193,6 +196,7 @@ enum delete_branch_flags {
 	DELETE_BRANCH_FORCE = (1 << 0),
 	DELETE_BRANCH_QUIET = (1 << 1),
 	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
+	DELETE_BRANCH_NO_HEAD_FALLBACK = (1 << 3),
 };
 
 static int check_branch_commit(const char *branchname, const char *refname,
@@ -262,7 +266,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	}
 	branch_name_pos = strcspn(fmt, "%");
 
-	if (!(flags & DELETE_BRANCH_FORCE))
+	if (!(flags & DELETE_BRANCH_FORCE) &&
+	    !(flags & DELETE_BRANCH_NO_HEAD_FALLBACK))
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
 
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
-- 
gitgitgadget

