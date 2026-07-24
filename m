Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BF9425891
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889387; cv=none; b=GGsNj/HZdarFlMOyjuDUv0noOw//Y30r/YFDcw8j+9nb93A9vwP8CBShXuWRMezrs0fUFNmUaWYlsAYngHVtTA9u738h44/og2irrTxWYPbeyWyhhu2EC/agVnLKnG5ww8KS1HL9CG8HN6hQCWq08Wp4yINOtOpwMf0/nAAcOv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889387; c=relaxed/simple;
	bh=PVFgTwX2p4jaVVrIaUUQi/Sbwfmh/ev3/LdCuzX7+X4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fPbKXUgxLzrFlb72qBJllCDk7sZpq3qyY9ljxdF4BlRBqqZiEaAVKnuWI26yGyhnkEBw7L4bFYdyuBny1tHkzN5b0hIvkbE+tUvIYRGEwLaEI+JCEZwi8aCmq8TeHVpPryYr5Cn4hl/VQEltjLtW40Lpg86HMK9dBKBbEZ4FH9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtwPA57S; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtwPA57S"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84867f07d63so306949b3a.2
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784889386; x=1785494186; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K9cJbpx8ZfkQh3EZ5g3AEUtzDNQDPQHz2sCij1sZAZU=;
        b=MtwPA57SadPHhGCBCCc25ulIYA/amSjmcdaDSK2zAL7+orolAIO4OWs29ZXwTrAqgT
         3vxgL38OilNx/qyquUsK8PhiAsLMzHGAicPVxrkNWjtNJW75ZSoQL9Gjpb5nC2vrI06c
         5j+sC9NDiGrB1bI5DDqbGQNysG8IyU6+z6Q3SC2jGALXdoa956q+bd30AENgL+XDilM7
         zULZ1Qnsh72IAwCYcJc7OB3zQ40mmxcKfM9t8WSSDNc7cv8PfTcVGPTv6HOjJGxaehru
         7rQJS/2O4Ho6L/LT5MlahcWdIPT8XJS9Gb0kZkueZohdpJ/M4sKsohWKH/DRNO6Bjpoh
         8A5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784889386; x=1785494186;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K9cJbpx8ZfkQh3EZ5g3AEUtzDNQDPQHz2sCij1sZAZU=;
        b=UP+MkjESu87mhb7blB9QKO+5g+oIsthzaXw3ndJiL0Rvxnnzd9Hc46qdUwtQAPovgc
         Yy0Qgk2XjXBoOgn5lmaFlfj3hSOuZj+AaPYz9hLo9zJGThbkoLanwtECBm2a270KiTtO
         0zeizNeWC6hs/gx2T9gNkY5a/3SFrmA6bLnyKXqS5Clj+DijDwV77cshRuDZD7Mjn4Jh
         Cr1rfYbzZnb6LSR4RjpNFRyOvth9ye1teLjLfEMdsA7XTCmU7auJmFEYwQYuCyZteueT
         vjIli0WKyk0IuGjHcarvG2x0ZGeghWqwNbo74upnkDB1daLu25LZmGuJ1h5T18UWwnxK
         3+/w==
X-Gm-Message-State: AOJu0YzpIBTQSocpRl+ioNNH1J03DRZtaXtftHLt0+dqkv0T0oF5FDjh
	CkKSdzQvA/N7k4MrQJf+LcdOI77+sYNdM2Q8BqZ6sWZems51ApeUps6f0tU50Q==
X-Gm-Gg: AR+sD12Hq0U58Y7YlACRRL65rwOwpvxZaYvy9kgLMow73zK1PybqzakYc3woewNjWc4
	m787SDu/aC6sXAR73wkhXYV8k8nkK7iPbX+cd3a24agrMd/wahTt3kYEtJQ5TdhB8VNB9bQQ9Sv
	6ydmpaGBLcnCoYyrYUE1eAC3gpCzo1ErTmLOjttTgDhVF6KibscrMUaVJ/bqV4gCSB6UmVWlSIs
	v9cEFCn/teT94raxNLMEacKms0BLC6u20dEj9nX4nHijanBmZ0f1okcfDxAAruKrv9844OFiGCh
	IO6CsadA+dg40p8rzbjvrpXex3MzrwSb0oRpPJKLNX2aenRhljXHfBPuaWjBNWK6AvRRM593e8b
	GBjnTWQN2vQV/rOVlsV1gzARUT3SziIz7NMLT1CxO8jcbZ2Jyrpg60kcMO673C939D7AhEpeQjB
	iR75qycg==
X-Received: by 2002:a05:6a00:9512:b0:848:2f7a:2e57 with SMTP id d2e1a72fcca58-84e2bba37b3mr7164588b3a.70.1784889385957;
        Fri, 24 Jul 2026 03:36:25 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.128.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17237c32sm4458258b3a.6.2026.07.24.03.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 03:36:24 -0700 (PDT)
Message-Id: <e70e64c866676f4223059e5422a3fb38115f4763.1784889377.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v21.git.git.1784889377.gitgitgadget@gmail.com>
References: <pull.2285.v20.git.git.1784704238.gitgitgadget@gmail.com>
	<pull.2285.v21.git.git.1784889377.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Jul 2026 10:36:14 +0000
Subject: [PATCH v21 4/7] branch: prepare delete_branches for a bulk caller
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

