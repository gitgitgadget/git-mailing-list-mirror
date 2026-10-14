Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A76555C316
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992448; cv=none; b=cNKcRK9JxiykWjkCM5HSnseeMaEr7U6S5LKG57pDqCdBfT32sG+hqG631fp6rw0fINHIdkJ4iNEPGhIaxOokUSTQgh6ANtf1ph9DQgdOxCo4BF60lWLznfxWegxuOF8CK7hXkSR57wfsIYSrqmU+JVdL4Q7/x5Y0HXvbrgHP+oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992448; c=relaxed/simple;
	bh=Umok2u1Q1oKtOY9QSiRGA7Mzv1OUoh8BC4iXMfQwi9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8rTSwfHxfOMg34ZSbGs7EIGjZVZh9oZAEevUlcS0PzTIisGw1u+l//fAJRhwD8iRdwZXroR5WgfnWzmX/z8sGvRG1jdl0EaGLqhXoTaVwBR6jnM//rWotmfVehlyaGsLM93k4fV3CCi35tIQfwcxbehowMrV7/1lnSYOOKZnVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2ka4mU6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2ka4mU6"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so11643975e9.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791992441; x=1792597241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/vWwFfwAM3yQoT6XA+yzvPOPcbYCknX1WqvqDMgFrXo=;
        b=A2ka4mU6wsNFg9e2WUGLTuAupq8LURTe72eh7+Vfb1KioSfRa06MdziWA0g/4PDa8K
         Ti4+cEpxGDG0+CHOF8xYHg3oHA0m8oROK5n63b9rJjFgWh8vE6e8HzcF9PKO9LrRGTZc
         gOcMhoWdE0sp5HhllDc1AO6luW87bY/J5ffqhK4Ekm9XMxLBr8MqvqzjGDTF0UneiWG2
         Wb74qdyXJ6qOzIMdFml6pV/qFCGxeaijL50J4bpslS6BIHbnvUnGXe/c5eD1qU+aPjft
         kiNAtfBDsJLVwJh7pK1+kKR0DhCeg5w7TE7T6feDCaQCW/1nhhGNml/DxxeUJEQwhvUH
         8osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791992441; x=1792597241;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/vWwFfwAM3yQoT6XA+yzvPOPcbYCknX1WqvqDMgFrXo=;
        b=JUcL8YTS9tprQAZrnvyqD+U5uw12wsmpcc1SIgIGg0VgVxnuONVrxuYnR4pFV8szb5
         T0ejMYeU0XXS6zHQqgS4xqNfhDOJclkq28Cd3tNID37iNsiA8M+iuJRu9poI+JpVEoSv
         HfG3wpluJq0Ueehma1l4ltFBVcY1RVRTnWy9nGnkGew0ufZMB42PQm0w/8WU65PgsWFY
         xicnqdMr+9tvvW9QKY5l8BfOvUMpGmE8a819vJvZkLS9X0dc746RL0oLXh7K63Ly3sZP
         Zgl4whd8+vzfwdCQY7boXieMHmDwzdgjAzmA4TKoHubDRDWn+hhGIJZFfmk27+LcZNk4
         62kA==
X-Gm-Message-State: AFq9FYLjMniCqD1Ih6Z2S82aMAwZUv6nWKpPweCsZXEiRWT1v/3KAqum
	IDaeZxFDL+kO29RWfNSGQInG35wMBwgfBWq53A14euFHrxKsCj4HiwuNN3guFg==
X-Gm-Gg: AYBFou0oKGaGmCVZd0yMxHTiSL+XXBhAg8n3Br2ok6LyPYM3XuzMWJAMuJZPrpEsuKf
	3/h//k5U4Ozu4BAobxLNdMcDGnraNMItvj5Y8rLMgaR4PfyHXhbzF+FgpbjSVNRXAHwKWhWqpYz
	HyBVnrMVU4+6EQ9T7M3udPjx99Kgb/3IxWJWwOq7cn9q0TKU2m/8x5uCW5EB+HL7D2U90VXfGcq
	tTFdeVMZy0SxXB8YIzrkCrPFg5Gv5GkbPqZWzf+n8bf1D77h9hM5vjHMq2kTQS0XqNHdqpHDG3S
	NWxMKjG/Cijad98w/8pE87iFx+xRff5ALwhIZJPcuQaM+qel8QVf01hr6r//zrZuiU198B0SNKO
	pcMgk6dlJGoGf1i54S59l7ZoDAqy8BOaLVS7/hBq8f/gKmupAPRvMncDi/K7Qt5acodZW9aWlBq
	sZ0o64zMen0+4X0JNU34uaKzXsLQ6nZi9GmEItEXSg+uMdPeUAkgpiNTjPLaBkoz+YhowkOzFL2
	JOSfhSL8YJVsA==
X-Received: by 2002:a05:600c:6099:b0:4a0:1feb:de6a with SMTP id 5b1f17b1804b1-4a18e4e7a85mr309775845e9.30.1791992441092;
        Wed, 14 Oct 2026 08:40:41 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967acasm10324829f8f.2.2026.10.14.08.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:40:40 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 5/7] stash create: rework temporary index creation
Date: Wed, 14 Oct 2026 16:40:17 +0100
Message-ID: <f799d86f52796cc1b83788460568cc0d9849bed9.1791992404.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1791992404.git.phillip.wood@dunelm.org.uk>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk> <cover.1791992404.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Use create_index_from_tree() instead of reset_tree() when we create a
temporary index file to stash the working tree changes. This matches
what we do for "git stash push -p" and means we can avoid messing with
set_alternate_index_output(). Add a new parameter to control whether
the index is reset, as we need to merge the index rather than reset
it so that we still detect intent-to-add entries. We do not alter the
in-memory index so we can remove the call to repo_read_index_preload()
which saves one lstat() call per changed path.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/stash.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index b4fe7465e4..ddeb5a5d2a 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -374,7 +374,7 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
 }
 
 static int create_index_from_tree(const struct object_id *tree_id,
-				  const char *index_path)
+				  const char *index_path, bool reset)
 {
 	int nr_trees = 1;
 	int ret = 0;
@@ -403,7 +403,7 @@ static int create_index_from_tree(const struct object_id *tree_id,
 	opts.src_index = the_repository->index;
 	opts.dst_index = &dst_istate;
 	opts.merge = 1;
-	opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
+	opts.reset = reset ? UNPACK_RESET_PROTECT_UNTRACKED : 0;
 	opts.fn = oneway_merge;
 
 	if (unpack_trees(nr_trees, t, &opts)) {
@@ -1399,7 +1399,7 @@ static enum create_result stash_patch(struct stash_info *info,
 		goto done;
 	}
 
-	if (create_index_from_tree(head_tree, stash_index_path.buf)) {
+	if (create_index_from_tree(head_tree, stash_index_path.buf, true)) {
 		ret = CREATE_ERROR;
 		goto done;
 	}
@@ -1458,22 +1458,15 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 	repo_init_revisions(the_repository, &rev, NULL);
 	copy_pathspec(&rev.prune_data, ps);
 
-	set_alternate_index_output(stash_index_path.buf);
-	if (reset_tree(&info->i_tree, 0, 0)) {
+	if (create_index_from_tree(&info->i_tree, stash_index_path.buf, false)) {
 		ret = -1;
 		goto done;
 	}
-	set_alternate_index_output(NULL);
 
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = add_diff_to_buf;
 	rev.diffopt.format_callback_data = &diff_output;
 
-	if (repo_read_index_preload(the_repository, &rev.diffopt.pathspec, 0) < 0) {
-		ret = -1;
-		goto done;
-	}
-
 	add_pending_object(&rev, parse_object(the_repository, &info->b_commit),
 			   "");
 	run_diff_index(&rev, 0);
-- 
2.56.0.134.g299a3c16181

