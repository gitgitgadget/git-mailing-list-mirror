Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD511494DF
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806059; cv=none; b=df0P9ZvcJdAwp7zJGAf9fHEHzZAdQ/TRpM3n2bqgjyynJbz4bzNBqULxNdqI6PyvEv1Ja1l38hxChHRtmpGFI071jSP5eiWWWAWdbBBSO3ivPLu0vihhKLU3T55W+8hjH2j+I4qGgp8PGnm4SnLNRDBW2HL4BbfYSSRM8Qf4mIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806059; c=relaxed/simple;
	bh=SY6eW+g/AU+o3pgtqSMiyAZsH8u8w487AvPmnIK6kVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMn6RAQGXdO/inm4E56IZlm51VEmiayHd8Vhuk0XYFz3Pez7jHCSHEE3hY1b/mzucTbSNmhpmFam1w7N8fqnc3y6ejUQyB4XBtUYjba0SY2hcZflaG+Ugaty7zfhXJ0+jAtbAOyWokI/joXj3q7qCz3I/WA5GdH5101wp9QBZ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CifdOb1W; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CifdOb1W"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220f4dd756eso51856805ad.3
        for <git@vger.kernel.org>; Mon, 17 Feb 2025 07:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739806056; x=1740410856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yriQTKExB0dg72AwocvBsFJLRtdMcjCnlQiS60+wFTo=;
        b=CifdOb1WritfZXm+Ax3pf436hJC7Z6adO88Sc9gOIAoJ9Zb6xBgelcz8eOmEDnY+Vs
         Cy8MpqoHkcfOsKMBOBNlwr00kqGgy+QFNHq+eZcrCA1hASIpVzk9lRuRs/qmZz7qeuE5
         DRbdzCyj1jfdvj+nzvP7HDFadbbFQfMp96siIFrTuvvYp79OCIkWYDWTwFa6KFAzY6K4
         jyp6VpAuYkDLX0ZJT/LoFagveMS/0rTfvqBKpNS6QBiij06o8Dl6gZ/rZQWNafHYGlv9
         HRTesYgr0XNXBnlpejXdBcODA+3D1NbmF1hBAlE5937mu5ptcvYqMIPQjw+VNsOkXRMd
         IjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739806056; x=1740410856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yriQTKExB0dg72AwocvBsFJLRtdMcjCnlQiS60+wFTo=;
        b=NAyvHlnSNvs3fp91Z6YSw8+Q8DAlXUqbWq5sx6bEVZZCue2rz0MqshmO3+JCpUkrke
         1ISRB9kgFbw/VMeGZczDAD88MBY1q1iMEJY2X+kDdlZlgxkvrHINTIThLFbfMbMX3Daa
         /cfJfdzj03hqCXkej2Bdg7a9VwwCXtDVjjhnWCdv7w5xOiO1NOirmJBPiG+5D01oDS6n
         Y6DEuicoYkFJKhiPstHRsJLNC2e6ItY4Hzq1oUYSTr+JbsdaXU21JnkCEuMUW6cu/UpK
         BECGwn+aZKStvjsX+jy4eYBEPsmlgJTu9pUcYg/0xnWafbK0rOZpShaHjC/gBWSj27k1
         tS2Q==
X-Gm-Message-State: AOJu0YwLQBC/NHBeSktH8HeJKbw92+zQ9fPczDeuDHbnAMRa+HoDnuZi
	+LlArLr8mo34TnW0QVUVfuNl2p1PROG2YaJNZEabtPXvvRlyBUNjQCMhHw==
X-Gm-Gg: ASbGncsM9+LRDILnr7Cpuq1LXGMaJ+vQIRsQE6mOnd5UcdlcjXvBiKU9huWBX44lOQK
	zhzARTDMYhb4glY0da4/xhKSfgXJJHT81ZWirgnqVKrOJnbzuTPWQymqJ97XOXlZchXeFu9V95d
	MhcTzNKvt2lAzTaqu3Kpgi9LyMV++An0uRcbw/8BUVbq0YJNYc2ucfuIfdYyHoup0wiUcDxHTTP
	2+xY2FLA1QvyAQvPPVHj2xeCgspuKP1lcrtFGSbIaNwzeSgrIGWV42+B2y5b3Tb7Cv+mXkYzBJQ
	gUfy2nJQRB4=
X-Google-Smtp-Source: AGHT+IEM7NQ7xrwCpTWJvV7qpHe7iXzmTOC8EOYiF13nPheTeCu17/H9AXzLO8XB/pctbvLx99VLjA==
X-Received: by 2002:a17:903:3d0c:b0:216:53fa:634f with SMTP id d9443c01a7336-221040d8414mr172703965ad.48.1739806056488;
        Mon, 17 Feb 2025 07:27:36 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d545cf76sm72644375ad.131.2025.02.17.07.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 07:27:35 -0800 (PST)
Date: Mon, 17 Feb 2025 23:27:34 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 2/8] builtin/refs: get worktrees without reading head
 information
Message-ID: <Z7NVZvAlNJ_00WX3@ArchLinux>
References: <Z7NU5fZfc8vfSvZ0@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7NU5fZfc8vfSvZ0@ArchLinux>

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
 worktree.h     | 7 +++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

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
index 38145df80f..f7003a9c12 100644
--- a/worktree.h
+++ b/worktree.h
@@ -30,6 +30,13 @@ struct worktree {
  */
 struct worktree **get_worktrees(void);
 
+/*
+ * Like `get_worktrees`, but does not read HEAD. Skip reading HEAD allows to
+ * get the worktree without worrying about failures pertaining to parsing
+ * the HEAD ref. This is useful when we want to check the ref db consistency.
+ */
+struct worktree **get_worktrees_without_reading_head(void);
+
 /*
  * Returns 1 if linked worktrees exist, 0 otherwise.
  */
-- 
2.48.1

