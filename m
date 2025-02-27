Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E4D26FA5C
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672360; cv=none; b=mThjKE4pVPtxU4i1L6ETcCs5v80gGhkZsHNIur/YOLhMllHx1o6n+xTonxk8h8WEkzi6gjDfnDGbeS30V/IYzBMa5ZHS2bXNA6aoSgQI2I1/qyJsNoylkyFladvQmOPsyQK4NGPi5QTz2OAO7OzpX6dAZAjo1aFXC0QbqTH7lUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672360; c=relaxed/simple;
	bh=91zfuoLoQwgrw0TlcEswgv67DDwoA1hs2npm5rnt8rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XC708OeHv3uyGWARLiNkQCH1Bx4b88QpHX1kW5ifxy4Ow+zxhm3thl22H2JfpXVIpTDHmbEq8zchQzXU2zRir6MBfb9obMHhfytUJbGm9dS+pM/qOxm9sJW7bcI0xCU14vCUf5knClLSsZbU0Ep173QJ15Bq1TaXuYbAZ4kFGcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iG7DbFHm; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iG7DbFHm"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fe8c35b6cbso1856184a91.3
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 08:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740672357; x=1741277157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kn5rEPmZULamx/qgElC3YO1aE9Gj/Fu7ltZCF1dh5ds=;
        b=iG7DbFHm9oQFyX7pMD+DgRtpjdRYhoAuQdfUw7UiQzPzffNQX9wOMX43oL3qSZhLyR
         jC/6p6FUu4tc5O9F0C1dOobosCV6x3wbQK8cWNd03av+1vG3P82VjKyLGg40N6OsGAZS
         of1rLdygw5xmBPL7E4C+at4zoPyo23ueXjV5IsHZU1eVSY3Aoa7ZotKdvwjAE7dfzRhl
         nwIU01x6UeevJ+jDyhEujzNsCwzE6Pv3b3ZyPNEqUp1vp2NetejBybNqg0YwZxHgkwNn
         vcTN7kzj9HHCAv+Ectq2ai9XpQH/bBHyAsOgObcV23MQ8b+gvSdRURML+tOQ0fwvZiBr
         q9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672357; x=1741277157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kn5rEPmZULamx/qgElC3YO1aE9Gj/Fu7ltZCF1dh5ds=;
        b=espVsFkyRigIGNQmDW/zSmAouNoIBVWWEAeMcGWPoyrAe9ZOv7M3+d8AS3SBeJ/6K6
         u5oFbYLQ9k3SlzbMId/eU2ctFa3Sp3CI5z5rn4l383aYcH1ruRPDgHlhHTUt8m3baLI/
         VBxWglIcJu4mzHlOP3/007wvRegC9Z5XEd4jreR+xVghwaHXaMdPHEYcgRnrE0SNTXNc
         CF4SqCQv3kgFqKM5bIviNG2nWqrrtMOUmczw1JYngGg5HbMdwe7LinZMtICjGdSDKbfd
         uul1ZqA9addK+O3Q99mDGq1DhcLgZvI+w7op2IDoGW2GegXdCNF7z9Yw4WfXeGM8R/DU
         YDVg==
X-Gm-Message-State: AOJu0YwNEs9G/7zHrtVLqwuL475KkWQ0mFACCJljeOD1E2MCNkH4fOx5
	CIIgzQa4qG9KrEw4vuNi2zVfLVSf5437sFHXyzjtJ7Oj7KEPWsNlnGGePQ==
X-Gm-Gg: ASbGncutEhQr8YNjby8J6+BJwHVibVaUPl1+XDtVz1jWGCI/Q1sy7kOn/Ux7GUi6WGY
	mb8sZnABOqsk/ik5U4d4gwUUTzLtI/DPNm2/NB2cQApSsLMIpBkm0Rpd3uMOgBCpKfumaN3xZ+X
	jdyepDPz/gHZ7lZR6kJcIi+nd2l1cRJqbmgw1a81222EpQ/yg5hTszrLf1ClSanNrmK1WH60Qz6
	9g+2yawyQj4tMIfMaJkJD3IJStwqs/C+geivyT+sRAVql8qd6azIsMVOXOFqaEZI3M5+wW6Dg+U
	CI/0rtyN+u8mo7PLH8iqzg==
X-Google-Smtp-Source: AGHT+IGhGxkRbal2NMt+fL2TyR4VpxAvKIVHXrCv6FRLedNPMcwVpRuMmNI7s6U8l0ofjARndf49WQ==
X-Received: by 2002:a17:90b:3ece:b0:2ee:d371:3227 with SMTP id 98e67ed59e1d1-2fce78b77eemr46983161a91.17.1740672357153;
        Thu, 27 Feb 2025 08:05:57 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223504c5a11sm16640625ad.150.2025.02.27.08.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:05:56 -0800 (PST)
Date: Fri, 28 Feb 2025 00:06:06 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v8 2/9] builtin/refs: get worktrees without reading head
 information
Message-ID: <Z8CNbjZ3igC2XK7k@ArchLinux>
References: <Z8CMx7O19PMs9sVY@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8CMx7O19PMs9sVY@ArchLinux>

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

