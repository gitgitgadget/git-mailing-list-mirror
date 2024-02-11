Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F081E4B8
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 18:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707676770; cv=none; b=EsMCs2lE2Gk+XhS+MLTpj3Rz4eyy3pNYLy4wWHlSE2AHnmKDUwx4WZI4QijytMO5rGJULgRlpmGAlqkU5psKYZb41eetIoQCTXB1SxX5PUSOaMDjsdukDjyDnU5zl4bqzLjd+k1ZpIpwoDQOjTtWJRpLFgWOH+IlB8vtpRwNIzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707676770; c=relaxed/simple;
	bh=CvOaKPfvQP+0K6egEHgQKPOab/UC67lLwrXW0phiMJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7dhTqMSpx8t1uri3wkDGWGDFgrft35L8F7h6J5Um3NOyPfkMCiiVJVGxZa9O/tPfDtPE8VSSDr1JhFvnJ6HWh4q1kjtA3KwEqS8Q4Aw7ly8hCfS8Jvyznf16lRM8WbQgH3woxpaPa5eavKQxv5JT+X3D1RUwdfkotp3arPkZ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGiPHAO2; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGiPHAO2"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a38392b9917so321048966b.1
        for <git@vger.kernel.org>; Sun, 11 Feb 2024 10:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707676767; x=1708281567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nk2qVT806rDHDYk4aclkk1FWi54V2TibjmD9T2J6Sok=;
        b=NGiPHAO2JKluDfpXhUS2V8H8fhVoB9iwepLBWzVCUyG8gOZVLf3cURnPdkwzpzotWk
         Zc9IsA/YLmbH/KWzNbEIXypQS7RZZHpMcaG4FWR9wcI8q7SjCZA0EgKiJNpbVoYdwYDW
         9VGQwGkRvKaaqRpwZCWzXVu8VWOuhC1hPIruzZV2nbxPJZ/+Z2WSl79aQ/48Awe6bhkG
         ttl6uLvFP2yNCZZ345TmP3PUiea6aPiAJYNOJ4K+i49/ivwMCJvXkuF/CKEjS0fTr0Zx
         ehjjAcHwaDC3feXOPF7LNBC0/tneJRqXcbHVZr1YvnGpUr/4/FLL33NpsuqIzK/e3RXQ
         VlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707676767; x=1708281567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nk2qVT806rDHDYk4aclkk1FWi54V2TibjmD9T2J6Sok=;
        b=L4LecPI3+4KJrhKp7IIMHNNpCefHzwrC6CeMFIQiqZITrmUAWfkwbI5qv/TuV4MgtU
         YZA5mP9wvgFKZBdD3nfdooxfsJcAfqTBOQjfzqhfrumoMhfREu/5/1zxYlFuve8Lvl+4
         ATyLw57AxyK1D4Go4aGyj5eJvFajS39lNQaEkcuVZFV5InqhOb2q9xW0ClDNbdUWdkwL
         rCK4zQnWTaAaoUNvI46r9ubYsdd+PgUGd4LgcXnfTYRktFLvTCTIsTaERqAVy/6RlgWV
         b7vIgAav2hgRm5E2CoJaXUyppIh1L4eQR00mjcN3gfC3X/XII7njmvYVDiAWPQEzXA7T
         BpOg==
X-Gm-Message-State: AOJu0Yx8uhJmDJ2GwwvYHPQqSa+M0LjZk3OQHgHcWLBmWX2hjhlHQCg4
	KT/iTonHb/ayZaxW3Z1xaFWD46DRByFPFLk9zyGlXy7VeAfASEdTfY7Ylpwz
X-Google-Smtp-Source: AGHT+IEKP+Znl0qhF9JxyFxUCa9uM+O3J2n7G3Ucnn6+pdYy9i8SrqO5m7HfA2z0eMAiEevSMFUXSA==
X-Received: by 2002:a17:906:a92:b0:a3c:177d:cb1b with SMTP id y18-20020a1709060a9200b00a3c177dcb1bmr3258067ejf.10.1707676766955;
        Sun, 11 Feb 2024 10:39:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOHiIQ3v1GPji7hcXECt/9Z7ADbdVM89MRmr+/9XEN5YUIEEb3u8fYMtmsCReLn39G5Fr26lmDfmNocAZcolG6vso30BRTZXfkQqumk24QJYw+tZbgqomfXLGeve2sOPH+NWY03+equraQz7VJDLJOoAp95be22+PTvQ==
Received: from localhost.localdomain (h-213.61.124.196.host.de.colt.net. [213.61.124.196])
        by smtp.gmail.com with ESMTPSA id w12-20020a170906130c00b00a3716299b40sm3069808ejb.155.2024.02.11.10.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 10:39:26 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v4 1/5] refs: introduce `is_pseudoref()` and `is_headref()`
Date: Sun, 11 Feb 2024 19:39:19 +0100
Message-ID: <20240211183923.131278-2-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211183923.131278-1-karthik.188@gmail.com>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240211183923.131278-1-karthik.188@gmail.com>
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

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c | 41 +++++++++++++++++++++++++++++++++++++++++
 refs.h |  3 +++
 2 files changed, 44 insertions(+)

diff --git a/refs.c b/refs.c
index fff343c256..d8e4cf9a11 100644
--- a/refs.c
+++ b/refs.c
@@ -860,6 +860,47 @@ static int is_pseudoref_syntax(const char *refname)
 	return 1;
 }
 
+int is_pseudoref(struct ref_store *refs, const char *refname)
+{
+	static const char *const irregular_pseudorefs[] = {
+		"AUTO_MERGE",
+		"BISECT_EXPECTED_REV",
+		"NOTES_MERGE_PARTIAL",
+		"NOTES_MERGE_REF",
+		"MERGE_AUTOSTASH",
+	};
+	struct object_id oid;
+	size_t i;
+
+	if (!is_pseudoref_syntax(refname))
+		return 0;
+
+	if (ends_with(refname, "_HEAD")) {
+		refs_resolve_ref_unsafe(refs, refname,
+   					RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+   					&oid, NULL);
+   		return !is_null_oid(&oid);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(irregular_pseudorefs); i++)
+		if (!strcmp(refname, irregular_pseudorefs[i])) {
+			refs_resolve_ref_unsafe(refs, refname,
+   						RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+   						&oid, NULL);
+			return !is_null_oid(&oid);
+		}
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
index 303c5fac4d..f66cdd731c 100644
--- a/refs.h
+++ b/refs.h
@@ -1023,4 +1023,7 @@ extern struct ref_namespace_info ref_namespace[NAMESPACE__COUNT];
  */
 void update_ref_namespace(enum ref_namespace namespace, char *ref);
 
+int is_pseudoref(struct ref_store *refs, const char *refname);
+int is_headref(struct ref_store *refs, const char *refname);
+
 #endif /* REFS_H */
-- 
2.43.GIT

