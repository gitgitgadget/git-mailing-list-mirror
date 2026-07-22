Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B603D0927
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 07:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704247; cv=none; b=DbkpAr0HmXsJn0YAlUtIyoHMGO7TfiTnyMfNhNIg3brZYJ2jc6YYoaMsjnyWpfpreQdwpFEgS06m0+ON7H8RW9tNkY/xBallRuez6UpHGkAC2ySi8FY6/RdozTobgRXGzL3LrS2mywlD/3HjHY6Fu18ExH+6JiZ2TQHSztCPn4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704247; c=relaxed/simple;
	bh=PVFgTwX2p4jaVVrIaUUQi/Sbwfmh/ev3/LdCuzX7+X4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=m7yUhXB98BkKfzQWtzpDlLnFFhpePlveTGQIn9cD6fPsFas4jyRJy51V4e+Kt+tNX8TepVUOIJ9Wm/kUwkbGr1enwXDY6TOLo0pQI7b1ZMufT1FDP8O7Spdr4cSa43yJdXRHeOzVClfq89OzF3Mm0j2+WvbcyyhK3PNNPlDP5SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUnyaXs3; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUnyaXs3"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92f0b5ed131so792613085a.3
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 00:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784704244; x=1785309044; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K9cJbpx8ZfkQh3EZ5g3AEUtzDNQDPQHz2sCij1sZAZU=;
        b=FUnyaXs3EU9xFYx6qQ9NPSC1ZaQay/QeEYLUngiyp4ifRk4g1ovYLgx0l/W2lruJ5o
         BwVPqvcRrolkLDMdaCkqRyRD3TftodUG4JOqQ0e3MlW2838v0SmtnFwkzzC3+XfwnykF
         q3CPdYBNzlqC9kIfARHc3ECgjVxP2x8ouiYrlQC82NnNl/r9jSSQ+O0kHIHMkHaH5Azq
         cHE8ai3n3a+Zj/QOGuWLR5KIcQJoVNKWvqKdyAjZKzXCFdd5AkcbmjCh2rIAQh6InI+f
         Bm2BQp9w2B6pDKBDOf4HkJ4mVW2ro9zGAK3tI4ZX09w53rVsh/0aXY19vGuz1PLCc/o3
         tg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784704244; x=1785309044;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K9cJbpx8ZfkQh3EZ5g3AEUtzDNQDPQHz2sCij1sZAZU=;
        b=oeIJ21ThagDSUzH3k6T2FseVikcW5BPSUudHPUAFxV3aSK7SLWMnHAEJkaZvZZWbu8
         ylEbQkP8Hyw1g92uZVwzFtgkGdeGyTRMO3x7nMdgDF28DYC47CDEyZpzylMzqPLQtnH8
         MwPMirDj6H3slcIvNsmy4WbbooQDOoUfnBMuR9EE+6iVocNB8qw1zUkQtcYstPJHDe3h
         C/JBfgaofDtS055dGQ1eynboP6DbzbOgTVjAg8UPAs+Q6cdsOnKZgIe1SssfhSR5/263
         a0WrzgxMxNsG1fHkHODD6RO7nNL01l/QOE/LMexzYV5F7CdHI9swkgJp8cWIWQAlsPSb
         IjMQ==
X-Gm-Message-State: AOJu0Yw/D1NtJ/MgezEBK4AeXx3QtVJ6v0Zu+aLlQmlZe5vKPGOQGQAM
	4NS9NSEVMrkVWqrkGMjTKFq2mpJiG83b8RT62W+4tLIq8IQO1ESLIrr/EF2qrQ==
X-Gm-Gg: AR+sD12f1rcFKxRBSYSeclnttfXhugHc0NUcyqWgOioiU+badO/cjuOnbJXiGGt3DHY
	PJBhOXO8X58Wa26X5ZTDrrs+w6yz6XmnMLvVoZIAITLFOLA3q0hYJEgfgNiD/1EiphRawj0ptrp
	QGM1W3Uptb2asz+28oJZWY6DCEhM+xChyS4OJxH+/6azYrEjmesgZB2UBFl1LrlDcQUs80kZdMr
	dD0IyhA9j+nrIdkJwUMJa07jl9ZpEZcZPH+CLNLwWECKQCSFdL1m/F/141sFjD/bCqIkZ7gw206
	3vdoJtG4Cgsg/LMDRaGQEtrgsu5zda3GaF7HGbJ/ii78BAhvCvfHpwJ+EAhsyKwmiwBEQLoLZ0O
	q62VI4x/ODz8lExutBNx8cIUAUhQ00jKXla56QDP8Lrp+MBZUms+A4uGTz1T/uvn/rNhxMF9IVG
	I3cgU=
X-Received: by 2002:a05:620a:4101:b0:92e:c118:18b4 with SMTP id af79cd13be357-930b43b93b4mr2117674885a.83.1784704244354;
        Wed, 22 Jul 2026 00:10:44 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.53.82])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f6a6a157sm97510185a.37.2026.07.22.00.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 00:10:43 -0700 (PDT)
Message-Id: <46268acec55a42f5220262635937903eb14a7efe.1784704238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v20.git.git.1784704238.gitgitgadget@gmail.com>
References: <pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
	<pull.2285.v20.git.git.1784704238.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Jul 2026 07:10:35 +0000
Subject: [PATCH v20 4/7] branch: prepare delete_branches for a bulk caller
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

