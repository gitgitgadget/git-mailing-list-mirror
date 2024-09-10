Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38946189906
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935363; cv=none; b=FRUXVRJdq63TA0TsCJheUAJP6lf9j41sMXACBRePB+sXBkb4FQVPUER3pePKkq2y+/b7NCz7ncjMBtOn9pOgCoipo/t3leRCCauD00y54iy9NSrnhFj/Ny0zWOFS/BpBYbDtw7iquRUQGj2gAt9/jzXbH297iy2VIc0+d/tlMSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935363; c=relaxed/simple;
	bh=dKJz/bU0aUqqVivSFtqiUbLMRpABpe0JfV8yjnQpXtA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZVZdPbZJ8VIbprm9le1djTQTOfUC6nGN1IjRCD5XQspiUHikxJe+P9I9r+Sstzh/Q3kSMn1HSB5Anee0AT9YuodEoUaYmjuFxqnbdw8ZiVLkwFA+aYX6qNIPFZqYvm615fS+1SMGi6/8ree0qVdb/QbcIxgkYXGNnDIJH0HyjRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgNNe4it; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgNNe4it"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d4979b843so292100766b.3
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935360; x=1726540160; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ND5FrZLmEENSHzE4xHQvMnbro+PrdtvzAI1FSaIYoKw=;
        b=WgNNe4itdoiqEsIlSlUjctJSA9dOYoMc/7CZF5sHACZVye6YSTkF5nRlzPoHhhPZHb
         mrzYYfRtoG5laukz8dJZVWnhaAGfcxeeR3636rQpPR9MjAWTgQhb9mpMekyRG+CuEa8I
         5riMmjh8RBgySV3ltdh0QJlcA+szSMy8MhFzei9cK//uJTCMR7t1AV3WaOaW6jSd7EiK
         Y3hyzqLnZAxnWYhBSpsXXAxEdE7oi9mj0yNZkN9iG+PLbh47tZ+fS+zM22f1oq8FRfok
         ZC+g6GsW7oerzZZkyb7D+Q6scGjuwFbz1FpjNJ9HU634hX3qDpa4bQTrxVgF/Dc5SDoD
         tmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935360; x=1726540160;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ND5FrZLmEENSHzE4xHQvMnbro+PrdtvzAI1FSaIYoKw=;
        b=oUW+YmA1TSsqPdFwDWpS3ryGAwmcOmD8fdWfq5FkPsjb6gpJf/pzZXFT+LWhqSZr6O
         vZost48CmcuD5utX47A+ojrgwNxwm2GGjhOiSFVLlHQrB/vY6+T2QE2fqqXp2SmZlxmL
         fMW61X70806byCRrsnRKkDPE3M5fNVeSZAVbwUCQk1iPfteTnb0+kUsGd45gFovbECgP
         8VEwSPdgGYVAnogiYYVre5cg+mFl/fXYHS5DflH0vflne7KtjhW2IZ4MkgTqMxkAtYih
         ZivdXoblPNpMlz8Rf346Nfrc86TKUsU5n0n6jAnql65tiL4t9543hYMOuHJOfoAIrSUr
         vW4g==
X-Gm-Message-State: AOJu0YzFmu6jVw91FTLJPtTQyJnowD8MzQfEdlMCJsDHzwo5czlqPEa/
	OU+1Bq5WuUe6ziqH8Zfu90ivUMEMAWG/UD8s0ZDd1z3x9UHP0ZBIYRcevA==
X-Google-Smtp-Source: AGHT+IGtFroj12R10mIkKv8SIlYxdSWCPy07Ih+/w+exT+8DZIdhDZey3cpDOk8OjSPPBtLiREBCFA==
X-Received: by 2002:a17:907:7f03:b0:a8d:5e1a:8d7b with SMTP id a640c23a62f3a-a8d5e1a9021mr414316266b.43.1725935360047;
        Mon, 09 Sep 2024 19:29:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d2583382dsm413050766b.27.2024.09.09.19.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:19 -0700 (PDT)
Message-Id: <d3284d090d36e3bff3816123e9939ef0128f323e.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:49 +0000
Subject: [PATCH 24/30] repack: add --path-walk option
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
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Since 'git pack-objects' supports a --path-walk option, allow passing it
through in 'git repack'. This presents interesting testing opportunities for
comparing the different repacking strategies against each other.

For the microsoft/fluentui repo [1], the results are very interesting:

Test                                            this tree
-------------------------------------------------------------------
5313.10: full repack                            97.91(663.47+2.83)
5313.11: full repack size                                449.1K
5313.12: full repack with --path-walk           105.42(120.49+0.95)
5313.13: full repack size with --path-walk               159.1K

[1] https://github.com/microsoft/fluentui

This repo suffers from having a lot of paths that collide in the name
hash, so examining them in groups by path leads to better deltas. Also,
in this case, the single-threaded implementation is competitive with the
full repack. This is saving time diffing files that have significant
differences from each other.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/repack.c             |  5 +++++
 t/perf/p5313-pack-objects.sh | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index 62cfa50c50f..9e39a1ea8f8 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -57,6 +57,7 @@ struct pack_objects_args {
 	int no_reuse_object;
 	int quiet;
 	int local;
+	int path_walk;
 	struct list_objects_filter_options filter_options;
 };
 
@@ -288,6 +289,8 @@ static void prepare_pack_objects(struct child_process *cmd,
 		strvec_pushf(&cmd->args, "--no-reuse-delta");
 	if (args->no_reuse_object)
 		strvec_pushf(&cmd->args, "--no-reuse-object");
+	if (args->path_walk)
+		strvec_pushf(&cmd->args, "--path-walk");
 	if (args->local)
 		strvec_push(&cmd->args,  "--local");
 	if (args->quiet)
@@ -1158,6 +1161,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("pass --no-reuse-delta to git-pack-objects")),
 		OPT_BOOL('F', NULL, &po_args.no_reuse_object,
 				N_("pass --no-reuse-object to git-pack-objects")),
+		OPT_BOOL(0, "path-walk", &po_args.path_walk,
+				N_("pass --path-walk to git-pack-objects")),
 		OPT_NEGBIT('n', NULL, &run_update_server_info,
 				N_("do not run git-update-server-info"), 1),
 		OPT__QUIET(&po_args.quiet, N_("be quiet")),
diff --git a/t/perf/p5313-pack-objects.sh b/t/perf/p5313-pack-objects.sh
index fdcdf188f95..48fc05bb6c6 100755
--- a/t/perf/p5313-pack-objects.sh
+++ b/t/perf/p5313-pack-objects.sh
@@ -52,4 +52,24 @@ test_size 'big recent pack size with --path-walk' '
 	wc -c <out
 '
 
+test_perf 'full repack' '
+	git repack -adf --no-write-bitmap-index
+'
+
+test_size 'full repack size' '
+	du -a .git/objects/pack | \
+	   awk "{ print \$1; }" | \
+		       sort -nr | head -n 1
+'
+
+test_perf 'full repack with --path-walk' '
+	git repack -adf --no-write-bitmap-index --path-walk
+'
+
+test_size 'full repack size with --path-walk' '
+	du -a .git/objects/pack | \
+	   awk "{ print \$1; }" | \
+		       sort -nr | head -n 1
+'
+
 test_done
-- 
gitgitgadget

