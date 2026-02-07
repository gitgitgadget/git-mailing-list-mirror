Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737F633893D
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770464423; cv=none; b=Kc+jLDk9XVLIOcM9U0QKwet1dldIZepFt/AgTHCxkSMV4iiHMfa8UDl0fMBViHfOJJ9QFLpFNSpNoDl2fa4rltQkjvcIoSD9MSOGpGl6BpN9CdCxaAFqoLaJF+WyRJgROieDyfelw4UH+HRIcKdqrVzSZ/eXUuGKISi3dnvLiNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770464423; c=relaxed/simple;
	bh=M7v1ADnsiL0R0q1Nlxg4GfuZy6/HkETTyDYMshMbU0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RefCxI7ZVdl+OrQe8wW7uq6Qj7DQpmVfrn/oSaQ9fYZipC936EWmzyNRFPE4ZVmlSD2QoTTWLZyPeeB1DKPRGJiWB06LOa46lw/bCBMSADTqRjcWVaNMTB4TiahIxkeH+DOshYrUfcVp0fqIIUOUSbTCR9pTrLZO7+MqVBQqXHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAx2lLVS; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAx2lLVS"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-352e2c59264so2002389a91.0
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 03:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770464422; x=1771069222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bi/MJ+lBUKRsaKz9xG0VER9VH9PUMqCIyO+tXpLEqog=;
        b=QAx2lLVSBePmnU9ON1TGvU44i242/odnci+n2n9+fZWSs256DtN/fifeu6a8B/Z/w3
         GST92fELlFtH15COCQbUy1iE9bX+ZuXB/PRX93vkeCmOwN5vWhaQN3Yfgyek+7CdB50I
         QwhyjZ6JnW9QPVLygPES9Q9lfL0HCu7KlHKWAnBtf8V5fAR7Qo/j0ICtBPWw1PjMVhOK
         /TAJW81RVBvk71LJBBcK43Q3ZPmnVs1upPmdVCwWwoU/PB48Lnxf2yTzOCuPQWcI8qT5
         o+4oqKWa3/jCcNsrUD2J3fiNZC2PrDl4G1OZ3+WeewjyZ7KMaQGgFznhR4om+hiVka3+
         CKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770464422; x=1771069222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bi/MJ+lBUKRsaKz9xG0VER9VH9PUMqCIyO+tXpLEqog=;
        b=GZROF28HTOXtqN5EVAmhElRzVywuJV5fo440fwgFMlQaeonBmfnGiDoNGYEaYB5lcD
         bSJB6rJeGYuOSm8whlTp0q5NYS8IJ3xlYn1CACJlWu2AlkqfA6WZBN9Raw28uJtLO34K
         NskQNlPXJzQad5TPAE8Im6VGqqQH7R21HXXVrvPq+eMJi8QQpISUYnngXo1MQebZYj8j
         jcbv3jy/NIwitb6omCUcf24pto30/1gw2hAhhk2e+WvePKZ9snBmbRQwtfXOZWjJ8IAb
         4TDmfO+W0nJVBkVdX8eFCsdOeJFRNqik6xmpNZfHJ9FQCU/l9nMBReqxoh+sWZcXv9yU
         tPuA==
X-Gm-Message-State: AOJu0YyXwh0NRL4OV5M8/JI0LH7RlgxJOaGWeGqOFfE1DCUYTt6nlBnE
	SZM740HLp+miiuuEslJIoYpyDddmOFNwg5kz5ofWRYQhe7TNbompzc+D0BQtMNL1
X-Gm-Gg: AZuq6aJw6a4Zgb90gLVzbd2DaJCUk0OCmN/nPOj88OxNGtjXrrb4mdV37vykRLQruxJ
	+rzPT5rBMrGR7DoZtuh6rEUDZLFRkXH+ZJ1Y2nIzTj7PMNlIu+D4nQSQDEOAZ+LHD7M3Ww6tpNt
	8NHGmc1upT1/EGXvvYetAxE4fabOba+gxYmPeMKCA3HVihZd11qZt50Zu2s/L6zBvb+6aucjukD
	HiJsku3uPjJB/6k9PYiZU/Jj0f11iUygPMYV5ji/UL9v67nQ3W4jx72f9V07gWc/uvV1M1s61lF
	F1wAoZq7pfhxCYjxc/KvoivuriA/CzmcFHsIE6G0rnk0JJQhC/YDP/UIWStIJogl9qbQBfLeNLn
	Cm9T85aNMPExz4z7P3FOxvw20tVsevJ4kftmbnd7b3tEtWjecaPM3GWdB90moBRzfreLtQZjmba
	UP1P/iyXkcVuMQHH4GQpLEb4Y=
X-Received: by 2002:a17:90a:ec87:b0:356:268e:ffa7 with SMTP id 98e67ed59e1d1-356268f0393mr47502a91.7.1770464421784;
        Sat, 07 Feb 2026 03:40:21 -0800 (PST)
Received: from AyushJha ([2409:40e4:4b:7889:a803:a194:3c70:2073])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3551a042ad6sm1701008a91.3.2026.02.07.03.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 03:40:21 -0800 (PST)
From: Ayush Jha <kumarayushjha123@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	Ayush Jha <kumarayushjha123@gmail.com>
Subject: [PATCH] [RFC][GSoC][PATCH] attr: use local repository state in read_attr
Date: Sat,  7 Feb 2026 17:10:07 +0530
Message-ID: <20260207114007.40-1-kumarayushjha123@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

read_attr() currently relies on is_bare_repository(), which
implicitly depends on the global the_repository.

As attr.c is a reusable library component used by multiple
commands, this prevents correct behavior when operating on
secondary repositories (e.g. submodules or in-process repos)
whose bareness may differ from the_repository.

Update read_attr() to determine bareness using the repository
associated with istate->repo, based on repository configuration
and worktree presence, instead of relying on global state.

No functional change is intended for the primary repository case.

Signed-off-by: Ayush Jha <kumarayushjha123@gmail.com>
---
 attr.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/attr.c b/attr.c
index 4999b7e09d..f2d25b1863 100644
--- a/attr.c
+++ b/attr.c
@@ -848,21 +848,29 @@ static struct attr_stack *read_attr(struct index_state *istate,
 		res = read_attr_from_index(istate, path, flags);
 	} else if (tree_oid) {
 		res = read_attr_from_blob(istate, tree_oid, path, flags);
-	} else if (!is_bare_repository()) {
-		if (direction == GIT_ATTR_CHECKOUT) {
-			res = read_attr_from_index(istate, path, flags);
-			if (!res)
-				res = read_attr_from_file(path, flags);
-		} else if (direction == GIT_ATTR_CHECKIN) {
-			res = read_attr_from_file(path, flags);
-			if (!res)
-				/*
-				 * There is no checked out .gitattributes file
-				 * there, but we might have it in the index.
-				 * We allow operation in a sparsely checked out
-				 * work tree, so read from it.
-				 */
+	} else {
+		int is_bare;
+		int is_bare_cfg = -1;
+
+		repo_config_get_bool(istate->repo, "core.bare", &is_bare_cfg);
+		is_bare = is_bare_cfg && !repo_get_work_tree(istate->repo);
+
+		if (!is_bare) {
+			if (direction == GIT_ATTR_CHECKOUT) {
 				res = read_attr_from_index(istate, path, flags);
+				if (!res)
+					res = read_attr_from_file(path, flags);
+			} else if (direction == GIT_ATTR_CHECKIN) {
+				res = read_attr_from_file(path, flags);
+				if (!res)
+					/*
+					 * There is no checked out .gitattributes file
+					 * there, but we might have it in the index.
+					 * We allow operation in a sparsely checked out
+					 * work tree, so read from it.
+					 */
+					res = read_attr_from_index(istate, path, flags);
+			}
 		}
 	}
 
-- 
2.53.0.windows.1

