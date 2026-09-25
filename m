Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769144F6478
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 20:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369638; cv=none; b=k/UdN/EzsjpRiXdONGoUSW1+GHqBqXDJt+qA15s3BAulKrVD6Y/kacYfw/B2cg177nLodDxwHw38hYRLP351vnqpWAtO8yGn8OTrKtUwPoBeXM20asulinDXpmywwTMaM3wEbvbU9+5tQMtiECCIvFjf53fsjki1S3zEnfqCreU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369638; c=relaxed/simple;
	bh=xYeQwRTpu8bk2ACvjt0S3VtDNASxGmK1OABKEnMLtMM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EVihv74KCj4KH3a4DPLbLlyvisCCui+0K2Rh+8XsJhHlSZdPo7czd4MYQ6GQghNoTcb8y43nrkDrzZya6/cvfk9Y3adYJeAk42zC/T9zqqSdRRs8isV6YSE4VBkc3CEXNSSkYfjNwLHad26eq8lPimydGA2ery2uBOx3g1G8GaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pmonette.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WhBtVFCx; arc=none smtp.client-ip=209.85.160.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pmonette.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WhBtVFCx"
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-530f9b8cd29so24764901cf.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 13:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790369635; x=1790974435; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=laTpkW1FZqk5Xedm93LyTjheVYhpKbeZVdHq/LyhRtc=;
        b=WhBtVFCx/0C7c3PGGXqPzH6uC4rmEKgeao/xZ3cHaLHn5+61f8392q4ngaUMiVeNfo
         79izKTCKkwAsN4fh4sPGDADRpBFooV3rjVEYx+Q7aRVSmg0vxFYO7GNdHWJjZG094f7U
         yfwGaTDnelUFNU/yWg0iWxYATi1kjXfGj+d0FQU+7l41QrAXY1lYu8JJfrVzPxNh+dZD
         xqpu/LjlbYGqC6jWHEJOx6mLNV7BQ0UJ5UmBMG1pWGRUatD4S1eva7Xj6f5ok3+ca041
         gmqf6G4v4PdH10DLwjOtwkOvXIoY/GNXBYLPFxEY3vLArnPM2nw4RbLYPf1oVpB1sKbA
         X8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790369635; x=1790974435;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=laTpkW1FZqk5Xedm93LyTjheVYhpKbeZVdHq/LyhRtc=;
        b=j7UtDAC5EJCO/OGFTOyOsY2DXnqdXp4TQhYM2bsgJ80wb7d1nAYDiwtxH6v4TJQaQM
         JfTXCJ5G6fgPJncuu7g1UyvEqLQdjqj727sdMQ5QrB6a0/82/GzvoD3f8dpOuRB+7XTT
         z3TFwdmWFNik7TEketnBhsDfiNchx8/HST+PHe08PoPP4xORYzH6xWAAGAxC321Th/kn
         keqPJJvURPIW5+hR44JZ8Yh0xME0CPLjp5Xm0bgKNufaa8B7FtvNZ0IcoqU/oojxG9J0
         0lLbOqF0r1yYMyDEnQPxQxR3PEsSjMKM8NqYPkf1Qy0afM0fRjkjZ+ar0xEFZUFvOuwB
         GieA==
X-Gm-Message-State: AFuF++l/4fsJmYbJSyZbgDLEXSeyHNa35D3mT5dM0lMOqrfzgzOuda8h
	OYSE+Pm9vYhvJgZjwKeW7wEs6gkLFum/wuwzvEzh7uzrs6crkVcfaKRTumMnL8DTwrL8/efOq8g
	cfmeJnXfF41PNivY7nIxvmArZQ/koeyTan0HM79ojod2SQyMKSvqSqvvJcfeUuI5cvL4bS0kfMO
	za7IA6HvAZCK3zrtkK08VagP5kvnq8BB4PgHMjbqtsy2k=
X-Received: from qtvj16.prod.google.com ([2002:ac8:4c90:0:b0:533:226b:f99b])
 (user=pmonette job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5dce:0:b0:530:e36d:1855 with SMTP id d75a77b69052e-5330b69495cmr69004181cf.42.1790369634651;
 Fri, 25 Sep 2026 13:53:54 -0700 (PDT)
Date: Fri, 25 Sep 2026 16:53:47 -0400
In-Reply-To: <20260925205348.1210154-1-pmonette@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260925205348.1210154-1-pmonette@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260925205348.1210154-2-pmonette@google.com>
Subject: [PATCH 1/2] replay: handle failure to create commits
From: Patrick Monette <pmonette@google.com>
To: git@vger.kernel.org
Cc: newren@gmail.com, ps@pks.im, toon@iotcl.com, 
	Patrick Monette <pmonette@google.com>
Content-Type: text/plain; charset="UTF-8"

When pick_regular_commit() returns NULL, the caller relies on
`result->clean` to figure out what happened. 1 means success, 0 means a
conflict, and a negative value means an error.

Right now, if the commit creation fails, `result->clean` stays at 1. The
caller doesn't expect the combination of NULL + clean == 1, so it breaks
out of the loop, but the rest of the function treats this as a success.

The next commit will add a failure mode (signing) to the commit
creation, so this needs to be handled correctly. Set `result->clean`
to -1 when the commit creation fails.

Signed-off-by: Patrick Monette <pmonette@google.com>
---
 replay.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/replay.c b/replay.c
index f415103023..ad87863565 100644
--- a/replay.c
+++ b/replay.c
@@ -291,6 +291,7 @@ static struct commit *pick_regular_commit(struct repository *repo,
 					  enum replay_empty_commit_action empty)
 {
 	struct tree *pickme_tree, *base_tree, *replayed_base_tree;
+	struct commit *new_commit;
 
 	if (pickme->parents)
 		base_tree = repo_get_commit_tree(repo, pickme->parents->item);
@@ -361,7 +362,11 @@ static struct commit *pick_regular_commit(struct repository *repo,
 		}
 	}
 
-	return create_commit(repo, result->tree, pickme, replayed_base, mode);
+	new_commit = create_commit(repo, result->tree, pickme, replayed_base,
+				   mode);
+	if (!new_commit)
+		result->clean = -1;
+	return new_commit;
 }
 
 void replay_result_release(struct replay_result *result)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

