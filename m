Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD7E192B94
	for <git@vger.kernel.org>; Sun,  8 Dec 2024 20:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733690907; cv=none; b=rUazTI4YlU4/jomH3A6KBU/dVrzkvUXZZnZXyfikyRswqMsCs1WHAlkPjOP8EiXx0u3UJpbb05O6P7liH50LR0nwQOu4U8ofFr05osGFkx3CAVqzHdKSZpwOWA7bl/Oqw55ITZnB4QMiBKeo4PGY+/7an9vKF/ko45C+ItwDirM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733690907; c=relaxed/simple;
	bh=643/CBawqwhLRqNKERnFloB0ipRoZynOuyf9Cx8bR2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVT9lbzJWf3Rjiy1kV7eWIza1v0OocHNNQiyRXK7BRnWYXMYEpBj+9hzsR57puip5aCHY5AfFQwewiQYJOuB2SEd2DwTpdmfR7bayp+MrpTUxZ3fmq+QXMUspJfFjuOFLkincZULhJeuq0luOt7kHiulhz9QLeK+FCDIwlNI0P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXbCo8Hn; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXbCo8Hn"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6d24069b2so46356885a.0
        for <git@vger.kernel.org>; Sun, 08 Dec 2024 12:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733690904; x=1734295704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSvD2qvMeicicHNIU4OaltBTuq7qo7FhQv3OxNcbmB4=;
        b=MXbCo8HnHAnqERzWQu/DCYW2Wr7/L7m1dHbq8K6HdUCumVycpMJXlAT7AlvQufwrRC
         Zfn8AEFRevi0DpbIjcbrnmOY5/Dj2YYyMnWRl1qbSy/MW4KeixSVCrLwuSVFLTr2lt7P
         0o2p5UBNpEhAfaSxJ1YHIxHdEB7dWZLNDTsqB0zsnni2eST0Zz3PlOrvVNMZUYpH7Gg+
         WWv0uyssLmh9rN/ehBrWKfeRC2Ij9x/iJjqLC1YSnuq+5vY0ecmboB3YGIr5srrRtRwj
         TtFbm+eFu5nvGOYoBeOOiZnw+bu6dnz1WLX76Sz29/g1QXmU+VxB0Ra9CRytEeP/QjkU
         cehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733690904; x=1734295704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSvD2qvMeicicHNIU4OaltBTuq7qo7FhQv3OxNcbmB4=;
        b=xBLjVQjdF2apajOAgb/dRMRoKgA9dY4RVMeiINU40gAEg1ze/oHXkOTNrKrm5KrQJ6
         vBuLCu6d+c0wPBV+oLGkPWBNTYxfGHTU3qjwd3iEAmsGqlSqGb3CeMq9i8ybwsgS6p8d
         qs1UI7sr3v9AYCg1jMTx3pEr31gEMHIXdU5Q4YqISzSEHZUWfQjaX2DyCFQ7OKfY9YFO
         HvRVvcgIZC5Fi98EfHTemRId1p/fAWX/U3TTjZiX9bLwg/5NLNjZZpKKFaAWEd0R1jcd
         B65Wu9qnbc0F9rPeoXP38SkLuhP4a7PQlEzGohd/SMoq9Sn+ZOdlu1lRBojOO2HXFWEB
         Wv2A==
X-Gm-Message-State: AOJu0Yzariv1P7bcbofxSWYCFADrxxUYDExCi8Sn7Cx804enyweJbrbK
	NxpkCktCu7/f0tTYZ21QId8NKWZH35i58JqIQBVmuvV2f+k2uVFZRpcjGw==
X-Gm-Gg: ASbGncuAG2XfOWhvtW74SoN9rnW4OHLCmC72G7p9UDNh8lfbycqjvFJsTC7CuzG0fIg
	vr2X1gKHnRCKavqgwT6fnYnn2S+1+RUSGUArWMYmxt6BbgRRsWlrIJ7Ts0x1geDlJRd3PR8EFeT
	3HDhMGceU3MvPC47N58rXZXFU42DdsRvxcPdYEnAT8ONvIqbGrFIwrtn+2yZRTfu+1YxB28ws5x
	aXIx24rPfyIR+bDAIkJnhJBgAU+lxwoa52hm18J2uVppU0YQ1ALvfUeSg2FpaSRAEj+oKNc+pT/
	vT3s9yzrh2fSUV1kcxOonzuGfvpg86YRXPWltzUCg+m2GGaBgo6bZHDXxstX41Hdve57rrC4xE4
	N
X-Google-Smtp-Source: AGHT+IEUrgS+UWcN2QmNQyoDKS69tXMGcQ7o4LVhD8pLdQNEYCKxjvnKlnp+IdkVE6no/tji6bT3nQ==
X-Received: by 2002:a05:620a:4115:b0:7b6:64ad:827a with SMTP id af79cd13be357-7b6bcb849b1mr1451780785a.57.1733690904469;
        Sun, 08 Dec 2024 12:48:24 -0800 (PST)
Received: from McConnellsteinsMonster.computercalum.com (guest40.skill.lafayette.edu. [139.147.200.40])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6d8454780sm4247285a.81.2024.12.08.12.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 12:48:23 -0800 (PST)
Received: from calum by McConnellsteinsMonster.computercalum.com with local (Exim 4.98)
	(envelope-from <calum@mcconnellsteinsmonster.computercalum.com>)
	id 1tKOCV-00000001H9I-0zyO;
	Sun, 08 Dec 2024 15:48:23 -0500
From: Calum McConnell <calumlikesapplepie@gmail.com>
To: git@vger.kernel.org
Cc: Calum McConnell <calumlikesapplepie@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] verify-pack: Fix documentation of --stat-only to reflect behavior
Date: Sun,  8 Dec 2024 15:47:17 -0500
Message-ID: <20241208204733.304109-2-calumlikesapplepie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <1ee9f3ef2bffd148b6225138135462d2d4a5928d.camel@gmail.com>
References: <1ee9f3ef2bffd148b6225138135462d2d4a5928d.camel@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ever since verify-pack was refactored to use `index-pack.c` in commit
3de89c9 (verify-pack: use index-pack --verify, 2011-06-06), the
--stat-only option has been verifying the full pack, rather than just
reading the index file, as it was originally documented to do.

Allowing users to get details of packed objects rapidly without
needing to hash all the objects in packfile is a useful ability.
Interested consumers could use such data to more rapidly estimate the
effectiveness of git's compression, such as to determine if their
.gitignore is adequate, or if they should be removing additional files.
However, implementing that ability would require more changes to index-pack
than the author is able to do at this time, and so a quick fix to simply
update the documentation to reflect current behavior is done instead.

This commit also re-orders the if-else block, to ensure that if both
--stat-only and --verbose are specified, the verbose details are provided.
This fixes another longstanding documentation bug with `verify-pack`.

Signed-off-by: Calum McConnell <calumlikesapplepie@gmail.com>
---
 Documentation/git-verify-pack.txt | 4 ++--
 builtin/verify-pack.c             | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index d7e8869..f734e90 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -30,8 +30,8 @@ OPTIONS
 
 -s::
 --stat-only::
-	Do not verify the pack contents; only show the histogram of delta
-	chain length.  With `--verbose`, the list of objects is also shown.
+	As --verbose, but only show the histogram of delta
+	chain length.
 
 \--::
 	Do not interpret any more arguments as options.
diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index 34e4ed7..5860a96 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -20,10 +20,10 @@ static int verify_one_pack(const char *path, unsigned int flags, const char *has
 
 	strvec_push(argv, "index-pack");
 
-	if (stat_only)
-		strvec_push(argv, "--verify-stat-only");
-	else if (verbose)
+	if (verbose)
 		strvec_push(argv, "--verify-stat");
+	else if (stat_only)
+		strvec_push(argv, "--verify-stat-only");
 	else
 		strvec_push(argv, "--verify");
 
-- 
2.45.2

