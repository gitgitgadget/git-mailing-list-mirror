Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB317A729
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110056; cv=none; b=RZAolwV9objRM6OOnrZdQq0xu3mauhT1BwT31dw27CKCvyGUZeHcouB/U4fn9eZqt8tZZNEMBwMerWdbM9lm3Q/V2gHYz/1XSBzVTxBENCOU44NVCtyBhRgH8DqNDYTNlYNhMrGEslHFpQgouCVLx7Qii1V4toSedlmRocvZcHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110056; c=relaxed/simple;
	bh=EJSmtWsyCvnKDbI9eOWnZtoo0278sMK8qqNHM4lfbXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2C6a6Hu3GO5V7uK20TlkJnW6BGWoof1bCfZsb1VL/12mVa5cJSuu9dKGNT/rja0ufMjkxn2yHZBROTtklqVSAzqPPsxwYXgz2A9oAr+zeu4r7pA2r05N5pAFJB/0hgy7VNtl8ygGcm4B8NyxjtYqvirmeYqdc4eRWvysjpZJ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4x55Qcm; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4x55Qcm"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55cd798b394so743434a12.0
        for <git@vger.kernel.org>; Wed, 24 Jan 2024 07:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706110053; x=1706714853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rt4nG+v9RnTzDBZBxdU5eB5Bsi1r4yUtyYzyTqHm4+U=;
        b=C4x55QcmEhcIfncWDRgQjbHopOOCxMUry9uJhEjJoSMR9vB/7pb53J8XawKzLrib4E
         4Dg1WTp3WbdObEIRv1+a3MAM/EiPj4XlLd1gzJw30SJfA4pma6tTGmR+BcQaGVfgqCbE
         fmXhPuavfN/tqixQzkxHMbbYC7XEBUQiR6Q9pzrOk9jbNC6bdMuUyRVRUHdDXEFrkcoQ
         a53IsQF/sk3rbDSwi7fGhSzce5woJ9UTs2tZFFlDDvX45cywT0s1S5EfWuLkAmMuCB92
         P0gAjrVlPBJod0YbKBx7KBKT2ULOx8aZF6h29k9sWJWVkKecKt3Z+a4VurwfXRAKyqgi
         bslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706110053; x=1706714853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rt4nG+v9RnTzDBZBxdU5eB5Bsi1r4yUtyYzyTqHm4+U=;
        b=iRAKCNN/tahWLLf57LTXYGKEnQIDqe10IC43rK22jkvzKBm1/TdHClb2A1M7oCOSNo
         /hBIhvQYjKNXmcncKzuKhrpWqa8cJ/S7SsbMZD7BSfoo/QVyIl+UqOgpMF2iKfpF739y
         LJjdL/yNkg5CVAG6IhA0B7M3vh3GAM9A/Nu/Zc1tp1oF7QVi2YKu//XshriqoXHuZRYK
         2JS5XQNUfTqZ9ksbB3qjytuOJZ5SREyrxogjkW50jRuL1y1jj+GccDekvgTCqY91cwGT
         MyQrb5tm9hT+l4WHPDSoF9cKq8XenEv8qggG0CukrP+wIwKV2rO6o74lQhhGcwSs5Ulo
         Oz0Q==
X-Gm-Message-State: AOJu0Yxav/T5EJcSOGCLocy62aQBXlLsFQL941iG0c86xKGN1v3VtjM/
	HtFfwBv219ozbDJDJ0YVin6pFZFRPCqR3e5ySjANkeCqxkaZKXp7874on1UQ
X-Google-Smtp-Source: AGHT+IHYcLL0n4vvdVvCrUtjHNWDpXUOepGtdA1rat3XjeDAtWAyXaG8PcjDgEPaprz3fWK6jNFZEA==
X-Received: by 2002:a17:907:77d0:b0:a28:a7cf:b014 with SMTP id kz16-20020a17090777d000b00a28a7cfb014mr1527143ejc.2.1706110052550;
        Wed, 24 Jan 2024 07:27:32 -0800 (PST)
Received: from localhost.localdomain (h-213.61.124.196.host.de.colt.net. [213.61.124.196])
        by smtp.gmail.com with ESMTPSA id vh12-20020a170907d38c00b00a2eb648cdc5sm8765225ejc.156.2024.01.24.07.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 07:27:32 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 1/4] refs: introduce `is_pseudoref()` and `is_headref()`
Date: Wed, 24 Jan 2024 16:27:23 +0100
Message-ID: <20240124152726.124873-2-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124152726.124873-1-karthik.188@gmail.com>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240124152726.124873-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce two new functions `is_pseudoref()` and `is_headref()`. This
provides the necessary functionality for us to add pseudorefs and HEAD
to the loose ref cache in the files backend, allowing us to build
tooling to print these refs.

The `is_pseudoref()` function internally calls `is_pseudoref_syntax()`
but adds onto it by also checking to ensure that the pseudoref either
ends with a "_HEAD" suffix or matches a list of exceptions. After which
we also parse the contents of the pseudoref to ensure that it conforms
to the ref format.

We cannot directly add the new syntax checks to `is_pseudoref_syntax()`
because the function is also used by `is_current_worktree_ref()` and
making it stricter to match only known pseudorefs might have unintended
consequences due to files like 'BISECT_START' which isn't a pseudoref
but sometimes contains object ID.

Keeping this in mind, we leave `is_pseudoref_syntax()` as is and create
`is_pseudoref()` which is stricter. Ideally we'd want to move the new
syntax checks to `is_pseudoref_syntax()` but a prerequisite for this
would be to actually remove the exception list by converting those
pseudorefs to also contain a '_HEAD' suffix and perhaps move bisect
related files like 'BISECT_START' to a new directory similar to the
'rebase-merge' directory.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c | 32 ++++++++++++++++++++++++++++++++
 refs.h |  3 +++
 2 files changed, 35 insertions(+)

diff --git a/refs.c b/refs.c
index 20e8f1ff1f..4b6bfc66fb 100644
--- a/refs.c
+++ b/refs.c
@@ -859,6 +859,38 @@ static int is_pseudoref_syntax(const char *refname)
 	return 1;
 }
 
+int is_pseudoref(struct ref_store *refs, const char *refname)
+{
+	static const char *const irregular_pseudorefs[] = {
+		"AUTO_MERGE",
+		"BISECT_EXPECTED_REV",
+		"NOTES_MERGE_PARTIAL",
+		"NOTES_MERGE_REF",
+		"MERGE_AUTOSTASH"
+	};
+	size_t i;
+
+	if (!is_pseudoref_syntax(refname))
+		return 0;
+
+	if (ends_with(refname, "_HEAD"))
+		return refs_ref_exists(refs, refname);
+
+	for (i = 0; i < ARRAY_SIZE(irregular_pseudorefs); i++)
+		 if (!strcmp(refname, irregular_pseudorefs[i]))
+			 return refs_ref_exists(refs, refname);
+
+	return 0;
+}
+
+int is_headref(struct ref_store *refs, const char *refname)
+{
+	if (!strcmp(refname, "HEAD"))
+		return refs_ref_exists(refs, refname);
+
+	return 0;
+}
+
 static int is_current_worktree_ref(const char *ref) {
 	return is_pseudoref_syntax(ref) || is_per_worktree_ref(ref);
 }
diff --git a/refs.h b/refs.h
index 11b3b6ccea..46b8085d63 100644
--- a/refs.h
+++ b/refs.h
@@ -1021,4 +1021,7 @@ extern struct ref_namespace_info ref_namespace[NAMESPACE__COUNT];
  */
 void update_ref_namespace(enum ref_namespace namespace, char *ref);
 
+int is_pseudoref(struct ref_store *refs, const char *refname);
+int is_headref(struct ref_store *refs, const char *refname);
+
 #endif /* REFS_H */
-- 
2.43.GIT

