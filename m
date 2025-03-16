Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6148819066B
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742119988; cv=none; b=aGOFZAO4SGrXkQD/xa+aPDHr1ntXijo3XwhOWJPaBQD7jvpsK40oyAt43V2WJVHNE+G+QpQpYQlaYI6xjlxZlhm92TkWv9+fbc3+HxC8DvkrV958u/BW7VDHMPAUVViK9NqsnZoUtyu4S83tRuRTub8AoZiZV82mJoQBiPB6mc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742119988; c=relaxed/simple;
	bh=rdujzLArmWfZfwDe6eu1qRjUPIZ5Y4u0QSf8yNwdVg0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=mr9t5FOZo7cDowd6LK6h+qNg6bD3N8hiLqiRD3mFlrCT3ghDTjIvmUl+lQGxzoil1pYo9p2TQzas4Z38tTKm4tpoF92ZPfRv6X6MERKAXLlS5whPlSEinji7P/OCgv3lo9sfXowDPTSXnGLX21Lb/fEWzkSsIdefzSyBEWFnsD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7f+4asZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7f+4asZ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22359001f1aso9973175ad.3
        for <git@vger.kernel.org>; Sun, 16 Mar 2025 03:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742119986; x=1742724786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ez7akv5KQQjkMXtAwneYNRtYOpdeV7TMAA6NKGW5GRA=;
        b=f7f+4asZI3wbsUOVuzIl34kKGOPoTJyGaar7NsdqIBzwAV2zi1eKYTVrEJXvV68u2S
         N5n6uzTtkiDttId0c2Lezq+BP2wXLEzmldD8aZgEL85MN+1Jc0SCEcqSJdxac4b38dab
         hSDjisZ3WLXA/svnMVjZDsZGzOh4xh1F9vh+iQiB4W/PbxWZ5N71elelCOLKqa0/ROBu
         LEevUusUXQMqvponXayVU/Y0UqzeQ3jdBV2aJgcmTqvRkQQBuyacRPzcsYQLNYJ6tN/Y
         khAD15fJf43RF7eKzEuOY9SVyeqYcc0PsKX7ZYl0j1idILIlzQsM1+31txuw5w8BknyZ
         WxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742119986; x=1742724786;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ez7akv5KQQjkMXtAwneYNRtYOpdeV7TMAA6NKGW5GRA=;
        b=KC62Q9++e0ERgKzDQnVf/m34LSzaKBEJn/NQvJjOLeel7WrSk5jF+9oXHhkEMCXWXg
         j2+Td9PAxxC5VpqNW/uduMkWYRiaC9fr8gSFhkcCfGIQ7XaQRtih0yPN0ZtWDQtS0yA5
         fZap2jfKWp4BTrwpKvnovTLT+Ow500gxyTVlJYH9e1ind/4bjXhVSfJkwKn9QImt6Ge1
         dXeKZcphfhlwMMi1yqiWWMCFvZJy9gVXb9u3EI30apwCuypY2QMrjTvwP2MXtOYk4Pmc
         lLFugmg/+x9ebs9AyUwqIWQXLREEvr7PrmKdRqBWOcbnAQBgiUDQzJ+K3yWYtgnBHgs9
         KM1g==
X-Gm-Message-State: AOJu0Yxa1hJDz1WA6Kt/Bfor7HsYLGJ9ZqdrP4crmJsoRR4yZJKrrvPa
	YXcjCGErwBwdjEqW6YihX5iDjsqtNEIRY1iWSgVhOUye1dzuENNlMX2vkBf5
X-Gm-Gg: ASbGncsJT+NUue5DOoaK/7D4l9/gb3mU98LmbsJzwiZwuLbPrVLV9mymBa/ESlmfpZM
	z6xk0u2BtgaQmuOr8cIKDKSPZlnjgFNJZlwpYQTeJTB4aa4A2/Svni8veWU61TfUuSdFGsfZYrn
	JMAzIY6jAv17N6T7sG/eVVISNzGY5EyAvbgv2486svjhL+UhOjNgZeGUyCv1/n7c8rDgUhZ+UGr
	Mfk79rNS+KhspucWdSoWrreK5lAXcRPZfz5l0lCGgCZ+NGJj6QGe6NjlftstDZCjuDipoESTO49
	13vsG6guvsjrLnKnC4T0HaAsyrOv5q+Z9u7TnXHB2tbiXxrgR8PdvD3mpKwGxlImAcpsfGap21A
	mwXRyl9Wxn/2ABh4=
X-Google-Smtp-Source: AGHT+IF2NxeOU9q8Cmps0CgKesdUY0VjHRtKJs3JpBLrCppJrk54yWsyP6lu3wbX/miYJfdJ2CQLmQ==
X-Received: by 2002:a17:902:ea06:b0:21f:1bd:efd4 with SMTP id d9443c01a7336-225e0a643c0mr97150195ad.19.1742119986553;
        Sun, 16 Mar 2025 03:13:06 -0700 (PDT)
Received: from ?IPV6:2400:1f00:2:fe0a:50c9:c0c5:fb7d:882? ([2400:1f00:2:fe0a:50c9:c0c5:fb7d:882])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4c80sm55694285ad.239.2025.03.16.03.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Mar 2025 03:13:06 -0700 (PDT)
Message-ID: <71098ea7-9136-4ab2-8e15-27017773e054@gmail.com>
Date: Sun, 16 Mar 2025 15:43:03 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [GSoC PATCH v2] rm: fix sign comparison warnings
From: Arnav Bhate <bhatearnav@gmail.com>
To: git@vger.kernel.org
References: <38de63ce-6d4e-4f1f-95b1-049df78d9cfc@gmail.com>
Content-Language: en-US
Cc: Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <38de63ce-6d4e-4f1f-95b1-049df78d9cfc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There are multiple places in loops, where a signed and an
unsigned data type are compared. Git uses a mix of signed and unsigned
types to store lengths of arrays. This sometimes leads to using a signed
index for an array whose length is stored in an unsigned variable or
vice versa.

get_ours_cache_pos is a special case where i, though derived from a
signed variable is never negative. Move this part to the caller side
and make i an unsigned argument of the function. Rename i to
inverted_pos to make it more descriptive, now that it is a function
argument.

Replace signed data types with unsigned data types and vice versa
wherever necessary. Where both signed and unsigned data types have been
used, define a new variable in the scope of the for loop for use as the
iterator. Remove #define DISABLE_SIGN_COMPARE_WARNINGS.

Signed-off-by: Arnav Bhate <bhatearnav@gmail.com>
---
 builtin/rm.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 12ae086a55..a5c9fc644e 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -5,7 +5,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "advice.h"
@@ -40,14 +39,12 @@ static struct {
 	} *entry;
 } list;
 
-static int get_ours_cache_pos(const char *path, int pos)
+static int get_ours_cache_pos(const char *path, unsigned int inverted_pos)
 {
-	int i = -pos - 1;
-
-	while ((i < the_repository->index->cache_nr) && !strcmp(the_repository->index->cache[i]->name, path)) {
-		if (ce_stage(the_repository->index->cache[i]) == 2)
-			return i;
-		i++;
+	while ((inverted_pos < the_repository->index->cache_nr) && !strcmp(the_repository->index->cache[inverted_pos]->name, path)) {
+		if (ce_stage(the_repository->index->cache[inverted_pos]) == 2)
+			return inverted_pos;
+		inverted_pos++;
 	}
 	return -1;
 }
@@ -58,7 +55,7 @@ static void print_error_files(struct string_list *files_list,
 			      int *errs)
 {
 	if (files_list->nr) {
-		int i;
+		unsigned int i;
 		struct strbuf err_msg = STRBUF_INIT;
 
 		strbuf_addstr(&err_msg, main_msg);
@@ -83,7 +80,7 @@ static void submodules_absorb_gitdir_if_needed(void)
 
 		pos = index_name_pos(the_repository->index, name, strlen(name));
 		if (pos < 0) {
-			pos = get_ours_cache_pos(name, pos);
+			pos = get_ours_cache_pos(name, -pos - 1);
 			if (pos < 0)
 				continue;
 		}
@@ -131,7 +128,7 @@ static int check_local_mod(struct object_id *head, int index_only)
 			 * Skip unmerged entries except for populated submodules
 			 * that could lose history when removed.
 			 */
-			pos = get_ours_cache_pos(name, pos);
+			pos = get_ours_cache_pos(name, -pos - 1);
 			if (pos < 0)
 				continue;
 
@@ -314,7 +311,7 @@ int cmd_rm(int argc,
 	if (pathspec_needs_expanded_index(the_repository->index, &pathspec))
 		ensure_full_index(the_repository->index);
 
-	for (i = 0; i < the_repository->index->cache_nr; i++) {
+	for (unsigned int i = 0; i < the_repository->index->cache_nr; i++) {
 		const struct cache_entry *ce = the_repository->index->cache[i];
 
 		if (!include_sparse &&
-- 
2.48.1
