Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9533420DD79
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 18:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742409479; cv=none; b=kAVk4tXwyWqUP/4lMVH/cBMhQvNnpzn2rnDDAxud9sZkYqfbIcXkJ52uUS4DeDonLt3zJGFO52rsckUqfkRDpq4IfMfA9e75letZvLX4AvOpzIoJPgLGBTLXJ0ZIyEpghr+Lite60h6g7FviVt0c/2m3ZO9d8DcTjKlpStyOITI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742409479; c=relaxed/simple;
	bh=gXDQJKbFBhCIQvbvXidpm/80r5b+InmZo7SUxtpcx00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSBnmDOjGGOyjdTJ9JvNi7TPJECC8q2kXcB3l1UfAfyjeuh38+o9MwbccnrIyJwR157iwsPEYChXk+6HKGylixoy+IgnRwAGlZOW/yz9J28q9/iRWh46m9a0pzQ+8g7QEsLnB9jf3EE0jNdKKky6YWNbx6ySvbdutXLZdOZs3aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOEbIA+K; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOEbIA+K"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7272f3477e9so732a34.3
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 11:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742409476; x=1743014276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSFvkJN6PmVD85g/GecVusCu/GUn+xS+6RuX8NMYTL0=;
        b=nOEbIA+Kgz6uCThNbuAZeRUstTSXpemL190Ryk7skH4/k8L7qAejH5436HEDxnXT7h
         HAbDEEwT7xa9z9BmvaLSWnqAXuCUiOSE8l3xrE7r9JdW9iyxkXYPXVQiy27eLli4/sfS
         5jmeB/yxxHx/15l+PgPquYsGawCxGzQR8t7pwSWL66fKq3zc+bPG++3FS0Kc6v+Urb4z
         vyMedv6aMa6xBVZeoZ+z5A8fRY1s09sZd2xHnDrW3ZZVtQG5KiSrg1LFWOHE+0hkbZZ6
         l+nVnSU0ayB+Cb4emR2dAeCfpe2JjrlbPYsj6Iax6TpT25tEcAVnk9UiaAwuitUycPNH
         NUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742409476; x=1743014276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSFvkJN6PmVD85g/GecVusCu/GUn+xS+6RuX8NMYTL0=;
        b=YmBYU1PVBYJB8GvesnbPJnfqPgQR7Q3uRO3Rq/koDID1Fj772mGxrcpE4jVVsU3gDH
         6s4U/pYhbaY2aeXs0RB2USHX8IC7H6Sejul4ZjFfozwFzM4hcEVXUvE8Q5vX0JVakGWG
         CtWqFxBJThft/e4W7x8a8/aqaoq714KDVhCRA3BO5Ao6w6IMKtHzQOS8IQwNO38TyEPy
         7XL0nI7QoFKh2vcq4TaBrcZZaKa5VIrAc/Qpjs/27Ozwn9OSqSMMiONPegVJSY3scrXS
         /1vaOjwbfZMukzrlmB4pAycH+fzTBTRVEcdqyWEMcNWeIX/91l0aI7oDsziInagd8dSH
         GK1A==
X-Gm-Message-State: AOJu0Yx8ZG8sy6DF90t9I5SzuUPeLwRkgKmmxPgg3BU534NHTcz3UVZe
	8Ti4Gp741A4MuSCqAGwegP7syahzoj3Kc+io5YSkbOMgrMNu15NBXb2p9A==
X-Gm-Gg: ASbGncu2KCbizVnbulbZ6oZpLFlOHfBduoba/f5tmAvN7duzw2gdYd7agLt3QwprtHg
	bH+a6p6fped9+2Qn1/JaOvKbrW+uexjlV/FbL62Bb/fy9Rp36X/R8wIohFUoTqC6Hi4IInpaI8j
	SYiiuKnoetLi62S138UplchNXdbZEpaipyko6lPXT/9104q+wwQl6rwpWyG986GZ067vVsp6+0O
	Y9+vpdCA+UDY9bdTuH+z8VLNjXm1cYwuDSMq1WiqDv+BvUP1hBrpHc2Jz6Au8GAb3u/uWCeOYLo
	xurFYaHQvC/3mjT2NRgdXkWp6j6WnnRA8Eo4pQgED9ehv6fdvd/w
X-Google-Smtp-Source: AGHT+IGI+EiQYSOjXAE7crbhWx3k9Db3ndTdB/GrX/I77ZoJgeIcrFt8iOFnX+p62rQkK92m7fzTfA==
X-Received: by 2002:a05:6830:620e:b0:72b:9387:84b2 with SMTP id 46e09a7af769-72bfbf536c8mr3040129a34.27.1742409476207;
        Wed, 19 Mar 2025 11:37:56 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e796sm2561943a34.48.2025.03.19.11.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 11:37:55 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	christian.couder@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 4/5] rev-list: support NUL-delimited --boundary option
Date: Wed, 19 Mar 2025 13:34:09 -0500
Message-ID: <20250319183410.1225428-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2
In-Reply-To: <20250319183410.1225428-1-jltobler@gmail.com>
References: <20250313235747.9583-1-jltobler@gmail.com>
 <20250319183410.1225428-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `--boundary` option for git-rev-list(1) prints boundary objects
found while performing the object walk in the form:

        $ git rev-list --boundary <rev>
        -<oid> LF

Add support for printing boundary objects in a NUL-delimited format when
the `-z` option is enabled.

        $ git rev-list -z --boundary <rev>
        <oid> NUL boundary=yes NUL

In this mode, instead of prefixing the boundary OID with '-', a separate
`boundary=yes` token/value pair is appended.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/rev-list-options.adoc | 12 +++++++-----
 builtin/rev-list.c                  |  9 +++++++--
 t/t6000-rev-list-misc.sh            | 16 ++++++++++++++++
 3 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index aef83813b8..3fc9902d6b 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -371,17 +371,19 @@ ifdef::git-rev-list[]
 <OID> NUL [<token>=<value> NUL]...
 -----------------------------------------------------------------------
 +
-Additional object metadata, such as object paths, is printed using the
-`<token>=<value>` form. Token values are printed as-is without any
-encoding/truncation. An OID entry never contains a '=' character and thus
-is used to signal the start of a new object record. Examples:
+Additional object metadata, such as object paths or boundary objects, is
+printed using the `<token>=<value>` form. Token values are printed as-is
+without any encoding/truncation. An OID entry never contains a '=' character
+and thus is used to signal the start of a new object record. Examples:
 +
 -----------------------------------------------------------------------
 <OID> NUL
 <OID> NUL path=<path> NUL
+<OID> NUL boundary=yes NUL
 -----------------------------------------------------------------------
 +
-This mode is only compatible with the `--objects` output option.
+This mode is only compatible with the `--objects` and `--boundary` output
+options.
 endif::git-rev-list[]
 
 History Simplification
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 17de99d9ca..bcb880f109 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -240,13 +240,18 @@ static void show_commit(struct commit *commit, void *data)
 		fputs(info->header_prefix, stdout);
 
 	if (revs->include_header) {
-		if (!revs->graph)
+		if (!revs->graph && line_term)
 			fputs(get_revision_mark(revs, commit), stdout);
 		if (revs->abbrev_commit && revs->abbrev)
 			fputs(repo_find_unique_abbrev(the_repository, &commit->object.oid, revs->abbrev),
 			      stdout);
 		else
 			fputs(oid_to_hex(&commit->object.oid), stdout);
+
+		if (!line_term) {
+			if (commit->object.flags & BOUNDARY)
+				printf("%cboundary=yes", info_term);
+		}
 	}
 	if (revs->print_parents) {
 		struct commit_list *parents = commit->parents;
@@ -778,7 +783,7 @@ int cmd_rev_list(int argc,
 		if (revs.graph || revs.verbose_header || show_disk_usage ||
 		    info.show_timestamp || info.header_prefix || bisect_list ||
 		    use_bitmap_index || revs.edge_hint || revs.left_right ||
-		    revs.cherry_mark || arg_missing_action || revs.boundary)
+		    revs.cherry_mark || arg_missing_action)
 			die(_("-z option used with unsupported option"));
 	}
 
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 886e2fc710..33881274a4 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -217,4 +217,20 @@ test_expect_success 'rev-list -z --objects' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rev-list -z --boundary' '
+	test_when_finished rm -rf repo &&
+
+	git init repo &&
+	test_commit -C repo 1 &&
+	test_commit -C repo 2 &&
+
+	oid1=$(git -C repo rev-parse HEAD~) &&
+	oid2=$(git -C repo rev-parse HEAD) &&
+
+	printf "%s\0%s\0boundary=yes\0" "$oid2" "$oid1" >expect &&
+	git -C repo rev-list -z --boundary HEAD~.. >actual &&
+
+	test_cmp expect actual
+'
+
 test_done
-- 
2.49.0.rc2

