Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A1B36A004
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345933; cv=none; b=TO+p5nMf8EJfqdcgTsiL1wJ3kUAedn4EXpYWZEXQ8EoZKVNjWWE81A3kRHkXbxE6JSeadraurR+4qkbzZQowB3wwe4WkFQ8PtRXHgpLy6Gc+nc/PzqCgWj2qMqZVX59EX0NeZ5Y6DJ2D8KRphacYt7FKvnaxuu+axiWOhJsAlFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345933; c=relaxed/simple;
	bh=2FuFh310S+XbI4m/OU885Z3pMJsMxTWCYO/p+0d8z8k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNFnW8+qxHL7Fa7YyCF5DaYxrfJa+n5LhL3lCqQA43o1Bdza4MkrEzeBTyBMI33xje9Y4VBq7oMPoKQgFgCo2hYv/AQVnMKMrhhLbrikauSWL8znZfDX+ZjSaD+b/hYq5Lw1zqZfldH9Yxx5HZrGfqIV7HZgkzswbgspDsb9Hvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HjWGNlkj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WRD7Bovh; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HjWGNlkj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WRD7Bovh"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 3A0901D00056;
	Wed, 29 Jul 2026 13:25:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 29 Jul 2026 13:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785345931; x=
	1785432331; bh=JSK1dhjb59LyNrdpaQ4UEtDVaPiSjFfpz9UvcMGEKpk=; b=H
	jWGNlkj4/r1Flz6g/ydIzoImdX9Z5tcGsHxRnObV8zyvkh8CiHz0/EYQAUZaQ6vw
	yjk+XiZtZ+lbOKBeZzH7dabDjpkrk06yNlr5jayQE0bMH2bdm218SW4CyExjM3w0
	lvMFSH/lTddbT3/ekLbyf6uTYlc2qoIRbeJduTBqSS1pZMI2DKcNdY+uop3oMtHO
	Loz4AK8hZYiQb52BXqIrEk165b70cALvkX0NbMsgy/l/3joZRIc/P6bNvRJ3lm+b
	H+h9oD1JCp27Ht/x1pDlvLV0sx3nMHHemhJPB7opXptzZE76LaZhcGZdvkK39Y13
	UMgeT2V25cCplei7cJwoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1785345931; x=1785432331; bh=JSK1dhjb59LyNrdpaQ4UEtDVaPiS
	jFfpz9UvcMGEKpk=; b=WRD7BovhGpRQH1CfrlQIC6/bDGrRkVppDttDDAgI9DtN
	LKxa71njCtTyb+wTcAnkpQZ6eoVTowY3Os5R6/CKi8uHWzCndUAQW6tROPPNZY/f
	VmlcnryB4q/hamgRfHh93AF4DUSACG3i8b9CIjS1EOflx6QGxu1sKpvJtbU7GK/Z
	Ih0KMBCodM2/y9nCMHHlsJT7Aw4v7jUpuqLzJqlUwkJjVf4z3rjG5UW2SCwsnL5r
	plmzeW24hKZEV7fJq+oS/wtJ1bUgfGoLQ+tr0VYgrZAAfhYQVUs/DfWjt4xKBP9L
	DtPTmfGvdZI3rlQA0Ub8VBmvpKF8+wUZlC/sdWQSHA==
X-ME-Sender: <xms:ijdqaudaxfR3CBVdcSid-UF_HGb_yZyE8wSJdRDJrrZAA_ITFHrqlQ>
    <xme:ijdqauPdOn8TwH9QzJX5F_oBRXEeiXrJlALAhLeGipvmBwiA-H0SyIQWzrwRibRLS
    u3cMZboipw7CP1crdX0Zo-xVxtTDiGV3ZqFoSpJG87tyvMYvWLzqWc>
X-ME-Received: <xmr:ijdqatJh96pYJhiyCJqqpDKUv-fFwRx0WtyRwquGaTW2OypF2dIUcK4VDsy7pUCUDdpghlZpntJC_cpl1zzq0o08GlrMjZruZA>
X-ME-Proxy-Cause: dmFkZTEOfrxFAlxrNocGwlX9Xe58YtJfVauubty3vKotQlHg8Vw2q2OJt9XOFRZZYTr565
    5WtY/QemwnB0ZyDulj27iwXkMZOrM1UffTnbCAUxXs2Tm8u85QfYb9kxP3/JVrVS1RGTmH
    cdIr5Cic8dMxnMn56/iAGNeLbUQwWBwmMYMlQOXheawcTKkp2+RVke1UCGPa1Vo98WBLc6
    rrcCnmGhzYDGPE1n4v6RHXS9oxU2Tt7to0zgsvUDRmhx4b85fdmJ0DkWtgRijbdMoUG2w0
    3gAhXzHrcRuzC/Vqh1RHRyBBUtSxi/UbQaQobNR1ucf2gObAjalSVz2Nd6RSNrS5dT/FSc
    A0UZpXyGvuMy/fhKPKwCurevd60B24y8w9QvZwyhtSWsv4q1M75Yg2GBj6Pv4GfXLmzSfB
    FqQwjCaRhO/yTUxjTt75AZG3HIJNgzQ4Eo1PTHYSLBZynMz29h5j5E7n43rC8nLCj00Krg
    zwTUcJJmQ5CRu1lTboqB215K+ZpxxVG1u+to+G8IpfKhcUoJbgYX0Eyb8kVYY9tjgotU0O
    WD7YxwgfQOZaFxSk1kogK9X0plsp+5FGemvuU9BZIa2b21DlwNijLYQaW5ZT18+2tZs9oi
    DE18/QKt/v9Y4xsI+fjKMFW+n4LeZNE9s7NI5EwtujZmqPyYk+H6u8Ung+mw
X-ME-Proxy: <xmx:izdqanGbqX48onLJk8VSp82YNMyWJVhj2NhQ-dT4abzCdeBMTL69yw>
    <xmx:izdqatQy0YPs7BoY9WyWtGp7b5QrIli6xb5H3MbUq-4zBAaEslrcRw>
    <xmx:izdqarEHxWSW3ueTBRiXVRqkLdnnK1zQ6HI7vdrW8ukmPLbLbfA9Pw>
    <xmx:izdqah__jV0mv5VbCDngBH3BXaz4GvmLtCifKhhdLgqZ5TjnxBDoYg>
    <xmx:izdqap3ovNZFKgPGjZ4Ex2IhCLQzzJU0ZT5x30SUq3YFvkaSOoWGfY59>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 13:25:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 3/4] read-cache: add remove_file_from_index_with_flags()
Date: Wed, 29 Jul 2026 10:25:23 -0700
Message-ID: <20260729172524.4022621-4-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-609-g9a17695db7
In-Reply-To: <20260729172524.4022621-1-gitster@pobox.com>
References: <20260728215219.753678-1-gitster@pobox.com>
 <20260729172524.4022621-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add_file_to_index() takes flags such as ADD_CACHE_PRETEND and
ADD_CACHE_VERBOSE and internally handles both reporting (e.g.,
"add 'path'") and suppressing index updates during dry runs.

In contrast, remove_file_from_index() takes only istate and path
without flags.  Callers that perform file removals (such as
update_callback() in read-cache.c) are forced to manually inspect
ADD_CACHE_PRETEND and ADD_CACHE_VERBOSE flags for removed
files.

Introduce remove_file_from_index_with_flags() to encapsulate
pretend mode and verbose reporting for index removals.  Update
update_callback() to use the new helper.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache-ll.h |  3 +++
 read-cache.c    | 19 +++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/read-cache-ll.h b/read-cache-ll.h
index 71b87615eb..8eb266cfd1 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -391,11 +391,14 @@ int remove_index_entry_at(struct index_state *, int pos);
 
 void remove_marked_cache_entries(struct index_state *istate, int invalidate);
 int remove_file_from_index(struct index_state *, const char *path);
+int remove_file_from_index_with_flags(struct index_state *, const char *, int);
+
 #define ADD_CACHE_VERBOSE 1
 #define ADD_CACHE_PRETEND 2
 #define ADD_CACHE_IGNORE_ERRORS	4
 #define ADD_CACHE_IGNORE_REMOVAL 8
 #define ADD_CACHE_INTENT 16
+
 /*
  * These two are used to add the contents of the file at path
  * to the index, marking the working tree up-to-date by storing
diff --git a/read-cache.c b/read-cache.c
index 58c378414a..ad77c0d5e2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -638,6 +638,20 @@ int remove_file_from_index(struct index_state *istate, const char *path)
 	return 0;
 }
 
+int remove_file_from_index_with_flags(struct index_state *istate,
+				      const char *path,
+				      int flags)
+{
+	int verbose = flags & (ADD_CACHE_VERBOSE | ADD_CACHE_PRETEND);
+	int pretend = flags & ADD_CACHE_PRETEND;
+
+	if (verbose)
+		printf(_("remove '%s'\n"), path);
+	if (pretend)
+		return 0;
+	return remove_file_from_index(istate, path);
+}
+
 static int compare_name(struct cache_entry *ce, const char *path, int namelen)
 {
 	return namelen != ce_namelen(ce) || memcmp(path, ce->name, namelen);
@@ -4004,10 +4018,7 @@ static void update_callback(struct diff_queue_struct *q,
 		case DIFF_STATUS_DELETED:
 			if (data->flags & ADD_CACHE_IGNORE_REMOVAL)
 				break;
-			if (!(data->flags & ADD_CACHE_PRETEND))
-				remove_file_from_index(data->index, path);
-			if (data->flags & (ADD_CACHE_PRETEND|ADD_CACHE_VERBOSE))
-				printf(_("remove '%s'\n"), path);
+			remove_file_from_index_with_flags(data->index, path, data->flags);
 			break;
 		}
 	}
-- 
2.55.0-609-g9a17695db7

