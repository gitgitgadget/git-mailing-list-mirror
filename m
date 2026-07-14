Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04D9397E73
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030987; cv=none; b=KrUEYJLUiMlUO3yb9f+Nd6ykgNXVk6HuWF82lIptTtaaRely3Ul/thWaSBBa+JBRC1WvWKTgtv9JmwrlFEdcQsVdPfPEB6tTQYVag3mD8sjWG/0P/UPq4j6ix+8zMD0ON97wCEBk9sMJcXAK7Y0hjeLbo+vdFFZKoatnsmjjk+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030987; c=relaxed/simple;
	bh=d3O264YOAPhSs3LowgQv+OytQy4Jom6SpOx2HWimA+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6FxlhIT4yzT1g5gLrHdYDXWuIjmSetxcvMfgzUvM+4RgWVLL7OPH3X9D52D4CQGNLdIsodEv4aCk0QTa5LkTMSw8njV5QCz9FiSLzjpZNmPS1HVHlJDtf69r0oTEVCA2C2yil9PXN1UG50d4eVm1q8G11Jvtqv8OwtaCPcWjcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIPSyzWV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIPSyzWV"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-471eeac43bfso4159225f8f.3
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 05:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030984; x=1784635784; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EVXZwPMEChNzSXzafZxAZRHidiQLdM5L+aaq4pcRY5M=;
        b=kIPSyzWV9/woeYCTzWg9xb+qKo2vbX6nfTrazHMgQh7NARVp6EYEjooxXzgFhaVlXM
         MJkviilIiXOGAk5NUHxNbnF2qnr92ZClD7Mje0JHhQBK82splBhkoZH42FClJ7I+gYTz
         Qth2ou0CWfKizI94yyGz7x7gYW4qQF7ZUYaaEKwWsLBCxroo1gtiFhBwLjB2hFB82atB
         Lxt8x4jlcT9uy0FYujMEks0wTNpI2/DD7kkxyd2TMqQ4DLCCdcXpy4vL23HvrKRJsHJF
         MsYqpNtuMFTh9z4ZwWNVBHhxgDi3kVF4Ux4PPxfLDCHLI4Iev5r9eMNF05Vuw7HdUQU+
         c+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030984; x=1784635784;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EVXZwPMEChNzSXzafZxAZRHidiQLdM5L+aaq4pcRY5M=;
        b=QyrNY3JCGMjHj5ByF+A4g0/a9mGGn/Mdv5Bp7Hmv4Kr09m24srPZ1S5xItWQ59iAsg
         JTJ7fcALLH741bNr5GVM5pcws+qS0mUu/F0vDTb8pC/4oGzDCRSfaX2VekMVZdeqcJ6Y
         A+6yBXYAuMS3JTsK6hD5wrFlMRsAMdmKzzRMYKl50qcmJeU+kY0EovXEkn3BV5/Y3NWB
         qgcfQt9cS35366a1mc7gmbF5sW+aDOQ0rCTprW3S+mx2K6r/5LqJIYM7z8eXhLcYihVr
         wOhvn3faL1hi59rP0gXCswZoLXGhNmQ/3z5nGsZcs52GY+wIxCQIcP/Gn7Kh56s7gOS6
         Tldg==
X-Forwarded-Encrypted: i=1; AHgh+RrPVdXF2c8azzOdLL2kyuONTYvA/VjRSw/Q53AcKCh/VDpkmImCJVEUvyz7GqoRyaHevLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2eD0XcIq1qCAbBuDbK1K0gZLrGOHnXzhnkqMY8T2UhPfOUrrT
	RhBbsTNrXZGBBqEwwMPvSgrYXtfc7C9zynXShA7EO5QwCppbZ3m6IkYP
X-Gm-Gg: AfdE7cl5+5WxkUhbdj7q4HWb8x+8tVKadncyli+nxT/1dJYL8bMrcz25XszkyskYNvT
	JSLTbC4vELOFmdJSm7k++NqH7CC55hLfidbSY+rb8eX+tS/nDFRapYYy+lYMiphY5eAUy+jIaGD
	Hk/n1pX/BYAEXpEYCB5NiyC0JtpYUdhynIKefsUFi0MGfEwzrEd/o392psKsVmlkSec/rdiXNml
	k690lOVVT/tqLeJf2yCP5/MkJkHlV0zMp+WB9mt7a2GLWZXjF+8qPeFC2+mgQq0MAX3WwZ21WvH
	yPVdLAOgkKIUwT02tRNcWyxK5xqgO2Sz1eb6bVnTmh02yZmsuOQtzHaXyVLGWvPRPeMfq1CfK8O
	ddFWCccN3IN6Ed9EwmSZkw7sbkLOKDsP8a9HzoYO1BeY6y/fJkU4Dfqn2/TEY/U53yuK3c4rdbd
	4XYnHMGl9MkygJkPRs+XEAy8jatJ4LqMYCHKR2wvUige9Gj4PsDmwFsnQzNdYLcKkX4qmQDsW06
	6gr6Pb7vHAxv8NJoQUa1mI60PviPo6LD7OWy9dnvk36TEOzlyNptPWuMzzw2hwzhg7+M08uyCK2
	/5BEUf6F+aAm0kfRmCQPDbfc2oEJ4lvxJZ7SZlx2FwBbfpr0SS8HAOVAUaxC1DekelBCDbeQmit
	HbNH9ao1XRRRXp/AWRsEl
X-Received: by 2002:a05:6000:2c05:b0:475:f0c2:75a7 with SMTP id ffacd0b85a97d-47f2dd08aedmr16921216f8f.56.1784030984054;
        Tue, 14 Jul 2026 05:09:44 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c89e5sm7749939f8f.34.2026.07.14.05.09.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 05:09:43 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: pabloosabaterr@gmail.com
Cc: ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	krka@spotify.com,
	mroik@delayed.space,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com
Subject: [PATCH v12 2/7] revision: add next_commit_to_show()
Date: Tue, 14 Jul 2026 14:09:33 +0200
Message-ID: <20260714-ps-pre-commit-indent-v12-2-d50938e006df@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714-ps-pre-commit-indent-v12-0-d50938e006df@gmail.com>
References: <20260713-ps-pre-commit-indent-v11-0-dcb65bc4ba99@gmail.com>
 <20260714-ps-pre-commit-indent-v12-0-d50938e006df@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

get_revision() gets its commits from two sources depending on the mode:

1. Normally it gets the commits from get_revision_internal().

2. --max-count-oldest which was introduced at bb4ce23284 (revision.c:
   implement --max-count-oldest, 2026-05-19) gets the commits by popping
   from a saved list at revs->commits marking SHOWN and CHILD_SHOWN on
   each popped commit.

Extract the choice logic into a helper, next_commit_to_show(), which
returns the next commit regardless of the source it comes from.

This has no change in behavior. The helper is needed in a subsequent
commit that pre-fetches two commits into a buffer for lookahead purposes
and needs to pre-fetch from the same source.

The --reverse branch keeps its own pop loop. Using the helper for
--reverse would additionally set SHOWN and CHILD_SHOWN which is not
desired and a behavior change.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 revision.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/revision.c b/revision.c
index 0c95edef59..288935943f 100644
--- a/revision.c
+++ b/revision.c
@@ -4658,12 +4658,34 @@ static void retrieve_oldest_commits(struct rev_info *revs,
 		commit_list_insert(c, queue);
 }
 
+/*
+ * Returns the next commit that will be shown, regardless of whether it comes
+ * directly from the revision walk or from the list saved by the staged output
+ * of --max-count-oldest.
+ */
+static struct commit *next_commit_to_show(struct rev_info *revs)
+{
+	struct commit *c;
+	struct commit_list *p;
+
+	if (!revs->max_count_stage)
+		return get_revision_internal(revs);
+
+	c = pop_commit(&revs->commits);
+	if (c) {
+		c->object.flags |= SHOWN;
+		if (!(c->object.flags & BOUNDARY))
+			for (p = c->parents; p; p = p->next)
+				p->item->object.flags |= CHILD_SHOWN;
+	}
+	return c;
+}
+
 struct commit *get_revision(struct rev_info *revs)
 {
 	struct commit *c;
 	struct commit_list *reversed;
 	struct commit_list *queue = NULL;
-	struct commit_list *p;
 
 	if (revs->max_count_type == 1 && !revs->max_count_stage) {
 		retrieve_oldest_commits(revs, &queue);
@@ -4693,17 +4715,7 @@ struct commit *get_revision(struct rev_info *revs)
 		return c;
 	}
 
-	if (revs->max_count_stage) {
-		c = pop_commit(&revs->commits);
-		if (c) {
-			c->object.flags |= SHOWN;
-			if (!(c->object.flags & BOUNDARY))
-				for (p = c->parents; p; p = p->next)
-					p->item->object.flags |= CHILD_SHOWN;
-		}
-	} else {
-		c = get_revision_internal(revs);
-	}
+	c = next_commit_to_show(revs);
 
 	if (c && revs->graph)
 		graph_update(revs->graph, c);

-- 
2.54.0
