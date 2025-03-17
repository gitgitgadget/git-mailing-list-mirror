Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91634191F6A
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231417; cv=none; b=rDE6vDuGirjy+3hoBdsQSR6JtLAsga+Eyv4Ia0Ec1BsrG0kP1SGE0EcytnwczPYcpoPMowIwBYG6SWIgatHmgFT2x5HGhhmcWYl87VZUBQjM0mLqwlYPF+NfKEtTk4ly0mTAVvQ+A0KGlwVXY82PgpXxfH9EIyu+HI6KIZhFmZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231417; c=relaxed/simple;
	bh=fTHOGCHpz40ZDpZ/Er4RtnmqX+Ub5MaY683F6HIUYRc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mspGtvvcsvlQyMJeSOnzXJr/AgWjnehq8DQ0/Wrs7yMg+nV9xg2Q8rbUUtSx9Ie8bpMCK0a/BELDdkvY1hCu2Bn7L2MfiyOMtp+G2gVVzAYqMjnuCuNBkRhzNz1ORrNF+R8IxCPYpSdKyUVlJX+EoaW84eW9dzicRjFOLAo+rfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbWkmbGs; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbWkmbGs"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-224341bbc1dso86544695ad.3
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 10:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742231415; x=1742836215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9TLM9A6aYPyjlTPMx0NBMveMIY1Y+ENJaJqPgL2lHdE=;
        b=IbWkmbGsVYS+ROjeF+3sZkV+SDo4uhjaYDCt3VsQ9yrZx1N3mMBlPMJGURLWABa8nx
         J5Y8kZIn5cvrXALp2mDgR5L+iJMAEOo3UoSyK+NSb2EDzKPAgueca9QT9SaK0vd7MFzm
         ClX9cvuHnhN2hxefzseS+sfVDQQ4uZM93/MszNDJarQmexrHDnMh5KJvCkihkHXz6yZz
         8Yyo0YGk8AJBNS8omnFdkVH/Z/phKF3E8v3BFIbAq3jKIFVvEAOpmIy6gqgW4282Ipd1
         I0H6FG0fp0rjazRQHI93SF1hti/lou/B6jOULuXAgHSrJ3I7R0YBtPhZ7aRgJwbtYtJD
         KO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742231415; x=1742836215;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9TLM9A6aYPyjlTPMx0NBMveMIY1Y+ENJaJqPgL2lHdE=;
        b=qG9M7uDg+3aKiFXUqza+VPxaSU6rt/QRYAYTJv0Ec/ND5cQ0l8DveCFVFGsd1xeoft
         gVFEvtgG7EN0zRAavF9YHwov3Ha++e5RKU8ma4F0kkD2g4MlFmMYZ/9kpEk8WrrhJgpI
         oSmnMh8jZ3vdZuJ0LhjaLwGci4AeQRkPHO44T/a+vbjP9Q8TyR518Imcw7slC6ApfMgu
         LQXwe+VZh6i6KaJ0JvkSHl+Ut7UiKCkGQU8smZenDGMwdEXGfGIHBAKBW6J/FCD7GWtI
         bFeJKe7Kv8MnM7fZcTnNuJvCSetFOUDvGpczvHx6S/ManE5m6DKj69mQWFDg7QJxaouA
         H2bA==
X-Gm-Message-State: AOJu0Yz9qdLScsqhIxUnIJnfjbxrqDVTLdOc7S7WbTWOFretHmLEOtjC
	4jR5AX/K0YsT8nUCb62i5d5nt8mNdjnyY1Jsnpb9VGva6AWrcUSE8yddwrD5
X-Gm-Gg: ASbGncvJR01NELqSrxe6r82vkIHKpEmRpDH5/Yozob2RVmP6YQ3RN3AcmzWsdszh0e8
	KwQre6D/zOXargYsV0jQ9sD4ul6/njSL2kw+iT+8Z3xSUzCm3xm22daBUL10MfCYI/G3pdScW3h
	ZPrR2YuLuOsXYihxETryA315ZxUnYDJdIittA3qKK5LDXqDRhag8URGnGpgkvZ2Atb90HQPhaD7
	JAYYwkBQS33leu+4vw7cjiMlxFD+s6+ej/7gRW+WmRZ6O8oX8D/6PqojJS0XMAgXZWh86PrFmKs
	VYfP72JEn3+h7VRWs9abofemkp/0S4H3obTWYn3L1bPLa/Dtt4p/T6kyvxRV7So=
X-Google-Smtp-Source: AGHT+IFgPvm6T0PpQeB3MhkSNJuSZzr+4oEJ/+gLGT8N8Xb23Tg0127/C5EDgRMz7JwcgXc1vgqm3A==
X-Received: by 2002:a05:6a21:3993:b0:1f5:535c:82df with SMTP id adf61e73a8af0-1fa45a67d14mr523562637.27.1742231414774;
        Mon, 17 Mar 2025 10:10:14 -0700 (PDT)
Received: from [10.53.2.153] (125-86.iitb.ac.in. [103.21.125.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115512e5sm7873946b3a.40.2025.03.17.10.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 10:10:14 -0700 (PDT)
Message-ID: <0286b10c-2f38-43de-b727-bbebc2f05108@gmail.com>
Date: Mon, 17 Mar 2025 22:40:11 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [GSoC PATCH v3] rm: fix sign comparison warnings
From: Arnav Bhate <bhatearnav@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
References: <38de63ce-6d4e-4f1f-95b1-049df78d9cfc@gmail.com>
 <71098ea7-9136-4ab2-8e15-27017773e054@gmail.com>
Content-Language: en-US
In-Reply-To: <71098ea7-9136-4ab2-8e15-27017773e054@gmail.com>
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
pos to make it descriptive, now that it is a function argument.

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
