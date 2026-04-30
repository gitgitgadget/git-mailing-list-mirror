Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043D07262A
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 00:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777508015; cv=none; b=uButCzgzrnFQPpOwlvzrgjZTT7h5AmsOLuP/GRcCGUJuWd+BlDo6Ag2ytzTxeG6cLTSwFl6jMaS+4Wq4uxXJDU3t5ABFfY6aAll+3B5BnvKmtJS5efx36WENdkIjMvoasb+YsqL1jGf4JvWHztZpLKmk6h5wGBVTZBbW21YEmok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777508015; c=relaxed/simple;
	bh=HbpFJX/pr+msfCdWNoZcXIm/yQXFf/FnQdsw5Cn4Ffw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLWCdW22+vSfGIApTcPg8zcrvpc6YpW2VoHgJd1yxL5WOOtgJ7sIGDOM1gq5asxYKX56k1krLv7s3XV8NckIgOaPmMQWdDvQWb3/pCTvyfsrpkGjXO/sd9emLS6MdN0eOuUeSeIKXVe0QA/K3ohz+BUXINVjcI0v2akVCs1f1Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=G5f+M/kJ; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="G5f+M/kJ"
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-65318dafbcbso296925d50.2
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 17:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1777508013; x=1778112813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zC6DZeHy85dbCn+SGrpYnPw3IlqBgxTEOJWQmiuP/PM=;
        b=G5f+M/kJE8bZBofpsq8tnfhE6CpAZ05TvhiqIt0fnVbwkuUcofp4PhhFuUqWlQ1/B1
         LMKnIxSx0mxPRCJJhPQscGqwVn8ov/8Qtoo63+UW+3Mt5UbaNWQVGDCshmeOd3PIrYPf
         0Jgil4nj7USg9/uZhPfgKiXfuUSR7YjTtS70JJwpaAUYhCcfZv8iMEXAuF0fz51iGHYK
         8+rFy4BZVTFQutxysRyG1n2MO2GVjWCZQrVW5JW5QhaF0sSlkRKt0hisGqEhCzFVX1Yt
         GzkVLBjbv/KAlAqtQ4STpMTB7JDW49KWk+1rMDCsg2AyLs+kf+U98YQFBmD7HUZ+VkeY
         OzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777508013; x=1778112813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zC6DZeHy85dbCn+SGrpYnPw3IlqBgxTEOJWQmiuP/PM=;
        b=ToYZQIX1o6axxyRliKnWsct1YoP51kmhuOYva5RKRAstsqwXd/NYndMybdF+95wud4
         ZfxO9mIkX+fp7JY8TvnZx5B30ZsphANpOpx7SmrMfS9QnQYGqoHAWBi4Zp6ogmqcP4wx
         VnCpC8WewRy45KZ8eG8yKjrwR/ftTfT8d4USRJeVTdz48qehTwcKv9uPxM/dkxtvluIP
         yxA74tEzJ5qE8JV27omb9uQ9gcOvIznXL/hR7/ekrGM5sWRnnJuY0uOnPrZvnYhNxnGB
         nzKaKmIGLgndyQBPZXd/X5eP3kqYBijck7qqNWabwi5Juwnpdgmntn5pcpR8aA3l8TmG
         Kfpg==
X-Gm-Message-State: AOJu0YzUuQc/dr0pzlulYKP+Xx1aq0ROv/Lsxhjh6ghKa4jzLDJFI7lC
	u8gblg5vQaHdoydGBDl0BIDUFv9deN8uLA/XJkMAmvlPwT4CvPIcS/1YX+Y8kOcbP+48rFJzbpP
	SutH7VkIeOL7x
X-Gm-Gg: AeBDieuwdBqqhKSS24rtx63XyWjsQkr6cM047siD25xTPTHgH9elrqRmLX6G/4+C6nR
	FQJp2MLuBUgNNY7+tfK1UbW+03PDCjzAX99oAMW4h7vwzIa1uHulZTiCPeNACLVp4LfxnjHZgFz
	114nNdE0z//19iIs9nvTRHUTs+KJ2fhY1pDYu2qG/XLVUCVdRuw8qYQ54YU3473J6hZ1490sj+L
	yUBDRtRJDCe+CFlHyEEBujlK8Wkfh+z6R172Pn1uQ5Cca53v8PjYrOCxqBsHs6lckCAJh95NOUY
	yd/DkGjrltypZXKwNgELZWR6fsKwdKcMT465hQsMTfuoeo14x2MEbUoJuqIZzswk+WgfAO4DDFK
	8SVljtqA4K7ZDCW9Rx3zN6vSMF5rAoyI/FpfvM/UInpp3I6YqKY0nED9Pklw1nYPgYcZ2zbodSM
	I/N/PVb40QkqvaJbau7xCG/1jcFlrK3xCmzNtMvoeBNqNml8BSoiXf+1vgTu/l49wBV2AT9Pq3r
	Y50mpLCOozrKkHrnkelxyRIV+ri9qIR9AO7rMTPxxuZL2kVw7HTPVlvQVUtWOXKo0y7z7Bk8fh7
	NlGML5k4ADZpY4+M8a/Ab0DswHc=
X-Received: by 2002:a05:690e:b89:b0:650:36b0:7565 with SMTP id 956f58d0204a3-65c18f322camr459836d50.45.1777508012933;
        Wed, 29 Apr 2026 17:13:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd5512a4d7sm1505637b3.33.2026.04.29.17.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 17:13:32 -0700 (PDT)
Date: Wed, 29 Apr 2026 20:13:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 09/16] repack-midx: factor out
 `repack_prepare_midx_command()`
Message-ID: <1bd2f194c6f7f64f2ff1e7b55a3a69defcb6a344.1777507303.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1777507303.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1777507303.git.me@ttaylorr.com>

The `write_midx_included_packs()` function assembles and executes a
`git multi-pack-index write` command, constructing the argument list
inline.

Future commits will introduce additional callers that need to construct
similar `git multi-pack-index` commands (for both `write` and `compact`
subcommands), so extract the common portions of the command setup into a
reusable `repack_prepare_midx_command()` helper.

The extracted helper sets `git_cmd`, pushes the `multi-pack-index`
subcommand and verb, and handles `--progress`/`--no-progress` and
`--bitmap` flags. The remaining arguments that are specific to the
`write` subcommand (such as `--stdin-packs`) are left to the caller.

No functional changes are included in this patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 repack-midx.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/repack-midx.c b/repack-midx.c
index 0682b80c427..83151d4734a 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -275,6 +275,23 @@ static void remove_redundant_bitmaps(struct string_list *include,
 	strbuf_release(&path);
 }
 
+static void repack_prepare_midx_command(struct child_process *cmd,
+					struct repack_write_midx_opts *opts,
+					const char *verb)
+{
+	cmd->git_cmd = 1;
+
+	strvec_pushl(&cmd->args, "multi-pack-index", verb, NULL);
+
+	if (opts->show_progress)
+		strvec_push(&cmd->args, "--progress");
+	else
+		strvec_push(&cmd->args, "--no-progress");
+
+	if (opts->write_bitmaps)
+		strvec_push(&cmd->args, "--bitmap");
+}
+
 int write_midx_included_packs(struct repack_write_midx_opts *opts)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -289,18 +306,9 @@ int write_midx_included_packs(struct repack_write_midx_opts *opts)
 		goto done;
 
 	cmd.in = -1;
-	cmd.git_cmd = 1;
 
-	strvec_push(&cmd.args, "multi-pack-index");
-	strvec_pushl(&cmd.args, "write", "--stdin-packs", NULL);
-
-	if (opts->show_progress)
-		strvec_push(&cmd.args, "--progress");
-	else
-		strvec_push(&cmd.args, "--no-progress");
-
-	if (opts->write_bitmaps)
-		strvec_push(&cmd.args, "--bitmap");
+	repack_prepare_midx_command(&cmd, opts, "write");
+	strvec_push(&cmd.args, "--stdin-packs");
 
 	if (preferred)
 		strvec_pushf(&cmd.args, "--preferred-pack=%s",
-- 
2.54.0.16.g1c05dfce579

