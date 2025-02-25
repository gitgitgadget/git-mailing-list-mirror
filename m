Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCFE267721
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489678; cv=none; b=S+QN4eIZ4hxc27gfP0wOQAyIxL1cKRRtK03IVQA8QUyLQPYomRAsIO3v0loKgKdDCnEytSdla801QFYlDO3DMiYu4FZbm+MxtUAXWzW5Kg7Nm9crvxRdWNK6Kefv24kK/aFWhDAPB4jMgWcDg7iR2c5EvF5FBit899tN/Q7qP+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489678; c=relaxed/simple;
	bh=91zfuoLoQwgrw0TlcEswgv67DDwoA1hs2npm5rnt8rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKJCEvW0cNIuuz/uzmdqdDefSz8iEYzJXcBb3Mk6m4YGRWhC+PSjPI0iK9x5tSqrqnZsx1v4LhH7//HKtxQ+kvCc2UvV7cFVLMABuXoue7V/2U9ql2LZjvYuM52knp0k5kbD/+pG9YFcZCDBeC7GwnOpOuZNV8pATTs210EmjJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPpcU91d; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPpcU91d"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220c8cf98bbso31793245ad.1
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 05:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740489676; x=1741094476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kn5rEPmZULamx/qgElC3YO1aE9Gj/Fu7ltZCF1dh5ds=;
        b=cPpcU91dF4+lXnRxDpzPo3SNPihV4xsJDsExzodWFTDOYSpxa4u//0GiRx5CeEg/gj
         RIi5hFYTkzyF7QbXT1pCCl2KOA/LfdXKex9PqGk8dJWvKmczS8WXPTnPvqUl9o39OiTv
         lkQyg0IcOEu/Ek2/syYR7lOu9U2Y2u0GadV28aeNdU4bfj103inF5HAbWshDPDToIq1g
         k7u/kc/MwUMx9tFPxftnTksP6X/hQyzcGJ87PvnFRHobP40PxV5rjYxwYopMidM4s+rh
         klTvw611Tvn21aJTBNaGS8nXSbtULf2X3ZY/uC6j5Teq8xCvUKXTUq/P7/bwdw6RgXMb
         8X9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740489676; x=1741094476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kn5rEPmZULamx/qgElC3YO1aE9Gj/Fu7ltZCF1dh5ds=;
        b=UuEvgY84BXGmNXqWeYANVrtzbQVS073wrF8z8NC6zPenWSAzd7aBLfKGz5vsNO58pK
         C8PpoF6gGoou10Nb5CYE+rXngOhcY2pG9ITBi5yqHbldT4QPHqpW7I7TduHclHmpkpZ3
         Y29F0Ui+zVWIHd8hCipPRMGeuRYTGQ+1g5uBhp2bal4qdNwz81di5ZDFzvXIHDFg2Rwv
         8DzHGyb7YiygyaKLs513PiptprQ37Q74FWETx/GYBp3t67F69XDC60B2+aQC6QvWCOXe
         ofvRB2vDJjCzfgb1+kFubYoErCHsQUL5Tg4MZ+JkNZ+h8YxYkWKDujhA3gqAhOqXq8gN
         1dmA==
X-Gm-Message-State: AOJu0Yyh4t06C3hAKF+HuI7ri9JgH+afFKaKbWn0nQN0eXNCLJyRDSi/
	8KRITbF/FIu8r4wORT0UhcEAYfdV+p7XG09ilR0I8793627dV0pMmdV/ow==
X-Gm-Gg: ASbGncuGQgUqyMP7nsOtGt3nqR2Oxt32bbLNwRWg1BWkU5jh3Ax4zODGvNGlYYyhA3q
	J7d04aw63Uzh0rp2IjrhPjZzpmM75oZNq4ndTQKD4PhuyRQ4drwtBReAidQffLcLxhPzJ0MugWq
	v0xiYW6kBZQyG0ZWSefe093LrziII65SkhBEGs5B43+BogLjtIGUBLHX/PXcExlZzLCiHme+64s
	ugZqiSwwGiWhMz/iXheTEeFCNwpTOYFJIq3tUriUfWHd0pMeEemoKKNrHexBfGtfzyecL8Rj4oU
	N2k0ykS+YxNY+JStS++y2g==
X-Google-Smtp-Source: AGHT+IHZBHdR5KZKqlLEfbd0hcDwnYfADbG3LVUWdpQIVWq9Upw0EsCQJ5zf4/GGVPVBZqTkWbDIwA==
X-Received: by 2002:a17:903:2282:b0:216:644f:bc0e with SMTP id d9443c01a7336-221a10dddbbmr309157255ad.24.1740489676056;
        Tue, 25 Feb 2025 05:21:16 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2230a0a3ca8sm13930935ad.169.2025.02.25.05.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:21:15 -0800 (PST)
Date: Tue, 25 Feb 2025 21:21:23 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 2/9] builtin/refs: get worktrees without reading head
 information
Message-ID: <Z73D00MHpcQRUYs-@ArchLinux>
References: <Z73DTwr9RicKMINe@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z73DTwr9RicKMINe@ArchLinux>

In "packed-backend.c", there are some functions such as "create_snapshot"
and "next_record" which would check the correctness of the content of
the "packed-ref" file. When anything is bad, the program will die.

It may seem that we have nothing relevant to above feature, because we
are going to read and parse the raw "packed-ref" file without creating
the snapshot and using the ref iterator to check the consistency.

However, when using "get_worktrees" in "builtin/refs", we would parse
the "HEAD" information. If the referent of the "HEAD" is inside the
"packed-ref", we will call "create_snapshot" function to parse the
"packed-ref" to get the information. No matter whether the entry of
"HEAD" in "packed-ref" is correct, "create_snapshot" would call
"verify_buffer_safe" to check whether there is a newline in the last
line of the file. If not, the program will die.

Although this behavior has no harm for the program, it will
short-circuit the program. When the users execute "git refs verify" or
"git fsck", we should avoid reading the head information, which may
execute the read operation in packed backend with stricter checks to die
the program. Instead, we should continue to check other parts of the
"packed-refs" file completely.

Fortunately, in 465a22b338 (worktree: skip reading HEAD when repairing
worktrees, 2023-12-29), we have introduced a function
"get_worktrees_internal" which allows us to get worktrees without
reading head information.

Create a new exposed function "get_worktrees_without_reading_head", then
replace the "get_worktrees" in "builtin/refs" with the new created
function.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/refs.c | 2 +-
 worktree.c     | 5 +++++
 worktree.h     | 8 ++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/refs.c b/builtin/refs.c
index a29f195834..55ff5dae11 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -88,7 +88,7 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix,
 	git_config(git_fsck_config, &fsck_refs_options);
 	prepare_repo_settings(the_repository);
 
-	worktrees = get_worktrees();
+	worktrees = get_worktrees_without_reading_head();
 	for (size_t i = 0; worktrees[i]; i++)
 		ret |= refs_fsck(get_worktree_ref_store(worktrees[i]),
 				 &fsck_refs_options, worktrees[i]);
diff --git a/worktree.c b/worktree.c
index d4a68c9c23..d23482a746 100644
--- a/worktree.c
+++ b/worktree.c
@@ -198,6 +198,11 @@ struct worktree **get_worktrees(void)
 	return get_worktrees_internal(0);
 }
 
+struct worktree **get_worktrees_without_reading_head(void)
+{
+	return get_worktrees_internal(1);
+}
+
 const char *get_worktree_git_dir(const struct worktree *wt)
 {
 	if (!wt)
diff --git a/worktree.h b/worktree.h
index 38145df80f..a305c7e2c7 100644
--- a/worktree.h
+++ b/worktree.h
@@ -30,6 +30,14 @@ struct worktree {
  */
 struct worktree **get_worktrees(void);
 
+/*
+ * Like `get_worktrees`, but does not read HEAD. Skip reading HEAD allows to
+ * get the worktree without worrying about failures pertaining to parsing
+ * the HEAD ref. This is useful in contexts where it is assumed that the
+ * refdb may not be in a consistent state.
+ */
+struct worktree **get_worktrees_without_reading_head(void);
+
 /*
  * Returns 1 if linked worktrees exist, 0 otherwise.
  */
-- 
2.48.1

