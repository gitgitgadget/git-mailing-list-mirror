Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB801E86E
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 04:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738641972; cv=none; b=dJkx1bWv3kHkzPuAjJDKF+mUJOBwb/EQo2WVkU6gWjl2f7zFEKMrRvNeO7wv0EmziCOdEapC3IB9DmtOAaahre02JT7vodhXbSAPCmse6YKzpqk/WTYknPxk+21r/4iJo/RgVuS4kXXmHow3UlOcRxe1R0qIhtaa4fB0UfKQtgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738641972; c=relaxed/simple;
	bh=M+ZyVYSBVPxPQXNw8GRFPvnS9/7hRNvMyX2F+ofKHPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OPGHBV0UeZwuRrxXdegULqa+tHC93LzY6ZLBJg/dOtbWpC4oyniTHzQrY7lU43YY9aFetIn9Ay29NuE1PWQ7r4MPEm8UVn/1t8kdwmINiKfx+wGvX99McvuUg5Yro32/NWbqyVEFjdcvpb1jcMvCyIvtRr9FfvWjqHSFUNfQJsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3WGe7nJ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3WGe7nJ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21649a7bcdcso89185995ad.1
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 20:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738641969; x=1739246769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPs+pVBrIP21zpkuhISs9jJHORFBB6K5p8XwuYzdVgw=;
        b=O3WGe7nJqNpTJQtGB1GTl00oUtkdZCYHwjIeH/vfYj6LBRRp4+9HA6xwdLaK1HQiyi
         YDOYIUADhH/awBejvza8RaPaNe0Ubh4zdz2G4cWbgo1a0mMPWnx3MNO5xVBDL7o+TMak
         l9Gx7wCxyTeo6KbPrTfDmbCidFyeXpMCkCOMDpGlhoG+jYCHZVovkJ70E1doMvTqvM9J
         u8ttNxKCa4ZBaMairvKVOY+ezkbo2BA6g1cHzprBaKM/z6oMMHd38NOckXa6gaqRmb5l
         kaD+3NFDivhthl+mOtqWlRQ1lsHEHG6b4daQkxi18kNUn+/frwcnS4G1dQRV7EBbzjMr
         4iIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738641969; x=1739246769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QPs+pVBrIP21zpkuhISs9jJHORFBB6K5p8XwuYzdVgw=;
        b=mLBugn/BmbbTyRtebLPN/JCqrxTjARGsR0o8Oti6Ux3RPXBEdqigakhWESXJLw7HEQ
         M+FJjqSNK4EW47U4HyeA6SPDG8SgH1jEVHNeaYD2YQ0Ot0Dz0rTA1UgxZ+31Pp3YgKQq
         TbuFuefTb+BavyD+dZv1EEZU/zJpMU03CdrA7gY4440ZC8+MgUCEeGcc4Zd2u8Gy05zb
         12UJ2XPRyK5cIEpZwInqT2JBMWdxQt1XerxUCCNdhrwrfTH5py8daFESU+G7Lnm1mv95
         LLVkdBqxXfhyGMNrUn2i23toNTxkiPASYaeDgNHIYPzD+Wp3uLPTI5zuRAd76q2oYBJa
         7Gqw==
X-Gm-Message-State: AOJu0YwnC/ppkUiQsdkT9DMQFMPSqCLVzosx4dA4ehplmMU0us7qvOws
	x86gSXKIlc4BG6U4IuVVsdz9VxwRk4ucG3OyZvzwH9X5OkdgmYp1stcUNA==
X-Gm-Gg: ASbGnctJYQQVgXHoEF8fDoNm8xSfzALBJDsr458KacGtALje/rhOVK9EINjxB+KvBQg
	1QSliM6VdYgI5cvrzsunYNwHw6uL0lYrP6QscjUnvrpTkF8cdZ3QRAtv4zxCwk9yrOdUk5Bi68w
	mn931Vmj9jGq04Jyut2nVTQjfUK5MKYXG+TiqGasIniLG0HkdT3YUP1eiShvxgLNzg+41NVB3mK
	GsUVhPwFPM87fIvWHfXy88Kh0UnFlkJISd64bjarsrTtxGr+8SX7C2UfLOBYzeELXrpiRpXV1T/
	ove0PkE9KocPYw==
X-Google-Smtp-Source: AGHT+IFxUkKyZRpBlj2zNylJI3VKoGf7F9P5QdM0NGo4goxgs/+dkeGZONFUexSIawyfr8llucg+Ew==
X-Received: by 2002:a17:903:41cc:b0:215:bb50:6a05 with SMTP id d9443c01a7336-21dd7c499d2mr340912635ad.9.1738641968839;
        Mon, 03 Feb 2025 20:06:08 -0800 (PST)
Received: from meet.. ([103.240.169.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bd09cb1sm12272583a91.21.2025.02.03.20.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 20:06:08 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: shubham.kanodia10@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Junio C Hamano <gitster@pobox.com>,
	Pavel Rappo <pavel.rappo@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>,
	Matthew Rogers <mattr94@gmail.com>
Subject: [GSoC][PATCH v4 1/5] remote: rename function omit_name_by_refspec
Date: Tue,  4 Feb 2025 09:35:54 +0530
Message-Id: <20250204040558.34766-2-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204040558.34766-1-meetsoni3017@gmail.com>
References: <20250201064202.76116-1-meetsoni3017@gmail.com>
 <20250204040558.34766-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the function `omit_name_by_refspec()` to
`refname_matches_negative_refspec_item()` to provide clearer intent.
The previous function name was vague and did not accurately describe its
purpose. By using `refname_matches_negative_refspec_item`, make the
function's purpose more intuitive, clarifying that it checks if a
reference name matches any negative refspec.

Rename function parameters for consistency with existing naming
conventions. Use `refname` instead of `name` to align with terminology
in `refs.h`.

Remove the redundant doc comment since the function name is now
self-explanatory.

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 builtin/remote.c | 2 +-
 remote.c         | 8 ++++----
 remote.h         | 6 +-----
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 0435963286..258b8895cd 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -383,7 +383,7 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 				states->remote->fetch.items[i].raw);
 
 	for (ref = fetch_map; ref; ref = ref->next) {
-		if (omit_name_by_refspec(ref->name, &states->remote->fetch))
+		if (refname_matches_negative_refspec_item(ref->name, &states->remote->fetch))
 			string_list_append(&states->skipped, abbrev_branch(ref->name));
 		else if (!ref->peer_ref || !refs_ref_exists(get_main_ref_store(the_repository), ref->peer_ref->name))
 			string_list_append(&states->new_refs, abbrev_branch(ref->name));
diff --git a/remote.c b/remote.c
index 0f6fba8562..cb70ce6f3b 100644
--- a/remote.c
+++ b/remote.c
@@ -944,12 +944,12 @@ static int refspec_match(const struct refspec_item *refspec,
 	return !strcmp(refspec->src, name);
 }
 
-int omit_name_by_refspec(const char *name, struct refspec *rs)
+int refname_matches_negative_refspec_item(const char *refname, struct refspec *rs)
 {
 	int i;
 
 	for (i = 0; i < rs->nr; i++) {
-		if (rs->items[i].negative && refspec_match(&rs->items[i], name))
+		if (rs->items[i].negative && refspec_match(&rs->items[i], refname))
 			return 1;
 	}
 	return 0;
@@ -962,7 +962,7 @@ struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec *rs)
 	for (tail = &ref_map; *tail; ) {
 		struct ref *ref = *tail;
 
-		if (omit_name_by_refspec(ref->name, rs)) {
+		if (refname_matches_negative_refspec_item(ref->name, rs)) {
 			*tail = ref->next;
 			free(ref->peer_ref);
 			free(ref);
@@ -1021,7 +1021,7 @@ static int query_matches_negative_refspec(struct refspec *rs, struct refspec_ite
 	}
 
 	for (i = 0; !matched_negative && i < reversed.nr; i++) {
-		if (omit_name_by_refspec(reversed.items[i].string, rs))
+		if (refname_matches_negative_refspec_item(reversed.items[i].string, rs))
 			matched_negative = 1;
 	}
 
diff --git a/remote.h b/remote.h
index bda10dd5c8..66ee53411d 100644
--- a/remote.h
+++ b/remote.h
@@ -261,11 +261,7 @@ int resolve_remote_symref(struct ref *ref, struct ref *list);
  */
 struct ref *ref_remove_duplicates(struct ref *ref_map);
 
-/*
- * Check whether a name matches any negative refspec in rs. Returns 1 if the
- * name matches at least one negative refspec, and 0 otherwise.
- */
-int omit_name_by_refspec(const char *name, struct refspec *rs);
+int refname_matches_negative_refspec_item(const char *refname, struct refspec *rs);
 
 /*
  * Remove all entries in the input list which match any negative refspec in
-- 
2.34.1

