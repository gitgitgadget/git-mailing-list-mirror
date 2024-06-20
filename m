Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDEE1B29C2
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899888; cv=none; b=R/rkF/YCdURvbbqI5xNH1c9OjCtQk33sPBBxLE9aAcBUUEiBuim2dw65ayFop/oOyWzc2y4dlHZD/kENf9jazgF68nCIqpjDxcxGpONfZijmIdyoduq/jTDP36K4KIrZ8BKWjVc5jrGY1C3d6z9fjhEW1QVBr6lA6RfmmEQJu3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899888; c=relaxed/simple;
	bh=v7pEIAOQacxrKcSmfYu3MMPjIoqKiKMlpNo3w47ds7I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kDWrt2eDp8F4K7GdZ+lvZonj9ZbHccpj2PZ4Zht6FRVXJjACzX1AGcGSKkYDfMd+LlktlIZijL4Luajp2RcbrepzuGNN/YeP16kfKkU8GN1Z5hN50ys2UqHIsd7mrJWz8EMHjAt6zBifTuGIUGOwmQ6ucu/q3rNgRmbQ5t21eOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHsfW5ev; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHsfW5ev"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42278f3aea4so10596765e9.1
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 09:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718899882; x=1719504682; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KauGz/GdUXdGho5U7fUDm2FdMS4nlt8MegpX3RmXHxs=;
        b=dHsfW5evkM/gKe+MQSldyIFUuqm6ECFYNqLUd93Qj+gOuUaO0GB1bxhhcsd+HBbSZI
         PmOQ0JFFGHrUj2bSg9hg5W5Z2L2NyIABHX+DSd7jMgmcmvr3s1myvTO7IM4MH19X8nWd
         E3d+/S3bVLAFyEQpazH7HcO+75sIH+bj7dDhrEc1SmOyFaZ0fgO0fqiXaQIX4BwjJT+U
         74eHT14sY8ZZoQcpWXnBGcGmJ/hxmTo7QYQ39D3INhHWcW9KUnMND+61Cn7X33TIXc1s
         HppVQT3P7An7iit4GSWIu/0IiEscilFH7TDG0kglITvSF9eoevy05MzaHvNDJvvoaFXO
         G6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718899882; x=1719504682;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KauGz/GdUXdGho5U7fUDm2FdMS4nlt8MegpX3RmXHxs=;
        b=qhfZjtULVyas9NbedvjtC2iprNqw/+JU9rBAm8DCVpXrsKspfddvgPiWwDEmGL2Vbf
         D7YxIUT1kOb8gtZyfTCGg1+/bVukxPJuN7FLbJ7fyZPya6JrwSIF7RyWZuSCUIf4kRjZ
         TjYmTk0N/8ynPxYCS8lVxCSCQ+4rwnC7tq0q9EiM+20ep37RqTK1VbZUgstsjwN8DXAp
         HkKyh3iCUEa1FlGQLNGaTOKEUC4kpo/+3SLmcEhpmqiLUmb0FaUzvQdMp1eGHn7CCybK
         SikYfmwf2NugOR8kWq8TRB1Ko0NDxsMM5ZF8ppIJgC4UzURF8MzkMOdbdxcI9UNL8wsA
         RIzw==
X-Gm-Message-State: AOJu0YxFhsBr9kaCtk6FlxA97YK4Lh7Q7OMhGnUR6YdtLOrVzitFcFL8
	4WBEFSwSKrdhHNNvfs4zzJ8x+9CdwaSo4dlfIpku4o8Wk5UsxY2FsQel1g==
X-Google-Smtp-Source: AGHT+IHYoIRNeLtHZRszvvtc75jZsOXs+4ixSoWqYlZW5+vL5nUtaSUFZbhfoY8Z7NAds2K+BQBXWg==
X-Received: by 2002:a5d:698f:0:b0:35f:1d7a:c41c with SMTP id ffacd0b85a97d-36319a85dfemr4471260f8f.60.1718899882404;
        Thu, 20 Jun 2024 09:11:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360940d992fsm11861245f8f.116.2024.06.20.09.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 09:11:22 -0700 (PDT)
Message-Id: <88a3145e585169fde8cd7d43a435daa07eb82667.1718899877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 20 Jun 2024 16:11:16 +0000
Subject: [PATCH 4/5] sparse-index: count lstat() calls
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    newren@gmail.com,
    anh@canva.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The clear_skip_worktree.. methods already report some statistics about
how many cache entries are checked against path_found() due to having
the skip-worktree bit set. However, due to path_found() performing some
caching, this isn't the only information that would be helpful to
report.

Add a new lstat_count member to the path_found_data struct to count the
number of times path_found() calls lstat(). This will be helpful to help
explain performance problems in this method as well as to demonstrate
future changes to the caching algorithm in a more concrete way than
end-to-end timings.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 sparse-index.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sparse-index.c b/sparse-index.c
index fec4f393360..8577fa726b8 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -442,6 +442,7 @@ void ensure_correct_sparsity(struct index_state *istate)
 struct path_found_data {
 	struct strbuf dir;
 	int dir_found;
+	size_t lstat_count;
 };
 
 #define PATH_FOUND_DATA_INIT { \
@@ -469,6 +470,7 @@ static int path_found(const char *path, struct path_found_data *data)
 	/*
 	 * If path itself exists, return 1.
 	 */
+	data->lstat_count++;
 	if (!lstat(path, &st))
 		return 1;
 
@@ -493,6 +495,7 @@ static int path_found(const char *path, struct path_found_data *data)
 	strbuf_reset(&data->dir);
 	strbuf_add(&data->dir, path, newdir - path + 1);
 
+	data->lstat_count++;
 	data->dir_found = !lstat(data->dir.buf, &st);
 
 	return 0;
@@ -524,6 +527,8 @@ static int clear_skip_worktree_from_present_files_sparse(struct index_state *ist
 
 	trace2_data_intmax("index", istate->repo,
 			   "sparse_path_count", path_count);
+	trace2_data_intmax("index", istate->repo,
+			   "sparse_lstat_count", data.lstat_count);
 	trace2_region_leave("index", "clear_skip_worktree_from_present_files_sparse",
 			    istate->repo);
 	clear_path_found_data(&data);
@@ -553,6 +558,8 @@ static void clear_skip_worktree_from_present_files_full(struct index_state *ista
 
 	trace2_data_intmax("index", istate->repo,
 			   "full_path_count", path_count);
+	trace2_data_intmax("index", istate->repo,
+			   "full_lstat_count", data.lstat_count);
 	trace2_region_leave("index", "clear_skip_worktree_from_present_files_full",
 			    istate->repo);
 	clear_path_found_data(&data);
-- 
gitgitgadget

