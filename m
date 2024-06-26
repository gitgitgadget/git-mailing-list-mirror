Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734D1186E55
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412201; cv=none; b=VO2pYWQGWxgT2qX1dJqKM+1P2EfmFJnW+EBPYYbReAzkQr5wKC1HNQtsWvKlPz50SdCiMLzeOoDKqt1boY+az+PxpakNpmUJKAzOmacn1rpyJz2TEuOxvtol7lKic9UjHXNQhdabT58WaaoY1IOqlLVVdAjZMUTtmTkY0OFbS+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412201; c=relaxed/simple;
	bh=v7pEIAOQacxrKcSmfYu3MMPjIoqKiKMlpNo3w47ds7I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BPI8eeFwl//M4frzofh8ZLDC0ChYN1pnJ4YTtBzVikeptH+4ZxiY75jRMobxOoyKYdLZtAzSTE9LXhnOgJo9Hrvde300yiBNripLDlYNK0oaB4bao9rpxsG1aak1DG8yoniv1yqlKgnGHMzXJRkf/NFV+xiqNuJHlnk5XYH/4hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4Sq93rm; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4Sq93rm"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso69877061fa.3
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 07:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719412197; x=1720016997; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KauGz/GdUXdGho5U7fUDm2FdMS4nlt8MegpX3RmXHxs=;
        b=S4Sq93rm408vhBVlcesgUpYRqYlU/CRpDvaDbXHLGiQecrnkhr65xUm1r6CBlJTCs7
         kcsbODEtjm4h3MPJGiqxzuhf+yvF/c6nlamOiXgtILjp0PwMgE0DifrA7AGeyA91bM/e
         vRYnz6EfQs5vX+0We/cbMIenGC1kSq+IYRclxg0SGQx3zbol+fqPblBFT1ICSbrQHgih
         am6k9Ojg87RXqb6LNFdsKkXVCd5NehlSkiMt2IXaIykNh6E/FW0dGfdiqpbgtAgT8qKh
         7wjtrLesxGbHsB8XRIFva6nBRovyzB0pr2NVUj+gMHtwpjZjLnC4IQSUrHuD1u3Pcdx6
         /Wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719412197; x=1720016997;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KauGz/GdUXdGho5U7fUDm2FdMS4nlt8MegpX3RmXHxs=;
        b=SYaILLu/fMsgjXu+Mygvp3SOYA6diLrupBcbdgU0sdrOSXQwJ2m0SWf0GVYleNl0AH
         rhMqNtFFSiJ76Qn+CT9ghj3UmmgutFBtr3mzWIpELerpEGTWk8mIk7c6kLA8zJTgrY0F
         bWStF90QtWtJkawjC8j52h1HG6RE6mXkte/Wg/vdrVQ17L8OFjMRw2bk+jW3ZQiReBPt
         wfPjU/QvKm1ewBDzpvkFi6PUiUwvExcVa+itEz0h+Ohc65QH9qRY1klQwMB99u/QODbK
         HVSCxzgODP5JXbUQ49f06MJT4+d9BRUibUdmc6OBBWT6KJAHlNqQbZVRzEuCjJX6p4Oo
         ok0w==
X-Gm-Message-State: AOJu0Yy6Xj1JVPAWhrme7R97h7Tal+EpZVv6KL9/0et+FZSGfo0yu5KV
	p5weRKf1Qp+Q50vqvpZBbZhYYG/5gnaZX8DrVbXvAgpDMdD1gj5UaiNO5g==
X-Google-Smtp-Source: AGHT+IHHNdLFeyRuFVru0UuusjqQ+WOpVFIJvdU1nGni+FLPjpGqYv7wnvWONvG01rd3iZyC9/i4Uw==
X-Received: by 2002:a2e:91c7:0:b0:2ec:5172:dbb8 with SMTP id 38308e7fff4ca-2ec593be975mr60289641fa.7.1719412197100;
        Wed, 26 Jun 2024 07:29:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366fbbac944sm5999592f8f.116.2024.06.26.07.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 07:29:56 -0700 (PDT)
Message-Id: <9549f5b8062909253fef1fc9a62dae9114c43481.1719412192.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
	<pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Jun 2024 14:29:50 +0000
Subject: [PATCH v2 4/5] sparse-index: count lstat() calls
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

