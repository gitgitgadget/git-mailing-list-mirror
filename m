Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A8D83A12
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718310314; cv=none; b=tZLI4T9JE2ec5IKkBMVyg/608smDA/Szq8BSiecXAn+ZxOPuwKQXCJlHcIR1gjEaujPMEimTFN9rMXvXzYHWsV0JNaIx+7K62X22a4+oaLkz2tzgsry5ET0AoMQ09W10xitcgSlJC+tpi9eSrOv4XhG7ILIUFfnp17jVQLX3JVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718310314; c=relaxed/simple;
	bh=5ndp5kc1EkksktK0FqHk2q/UQlZ+VcDAkqqo4gh0kiA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cYJiSfPJDth5y0F7SqUbPvTPRl8JsHfp5cZxwx7LVOVtxqcOZzRJnYhXrlhs+q3SawstNOfJCXEm/xWZz8iLaBJi2rLG52KQK9/HchQHKLnN4nzJxtK0d+5Rx9sOdQSKRUHfwRiZwgBuTxB77D2qvT4AAxSsZQP0wMmnSBoRR9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJWNh2fg; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJWNh2fg"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-35f090093d8so1236356f8f.0
        for <git@vger.kernel.org>; Thu, 13 Jun 2024 13:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718310311; x=1718915111; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4N2+McsKqskjMX3WjohnPbDfySDHNpuGo3pNeSOEAI=;
        b=UJWNh2fgy5l4o+QmIk0lBQBWxa60j0rJsC0BZmNMUP39PcpQ+SyCNwM5fpHSAvgOYG
         2EM+mleuflDKOuwb1CY4Aox1oSb506CvvRetYs152axTXVKKnioqRJRQqcO6LevmeS4d
         61EOBdBBw4+Rcx8iM7zeXFvfIKYUe3J3F6LNZc25T5JgktyUPFjKa6q0LyqyO+MeCXIQ
         nBf4TRi3T42X6TF57Id9Or82fyin4AEzka8gvVOu8HeTqBvlTFG++k6e6Vuhvy3rhrsB
         Sx378NbLcv846JV9Ozx8XlVdIdG35OC/ei1DNbDznZe7MlvR+hK38eNAFgaOCvqs6izy
         tyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718310311; x=1718915111;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4N2+McsKqskjMX3WjohnPbDfySDHNpuGo3pNeSOEAI=;
        b=EA+9ldOKZjPEQYIxVaJD+Pbhd2aSd6U958oAdGmqrH2An/foTK6FxhVA22cNMAcA3c
         s9RE6uuCdSOi59zdm37HgSXMv9LNgelu3nnY5r7AcvTso4eVTK0xG0KvRvg2lvzIJ1yB
         le24e3vD6jGGYQDGkmIKFBTGMkMs4rrxm9oS9to8iu8MGVjU4p+eNJ91pSXBiNHeaz3T
         LWgzoTAi83lwqJjsvBSUvLrI9zCOGyEjTnpqhnXdPBT7mnPXywpmUvKYg7DqA1RzbXua
         A6nlh16KlAUYi4lTy+zQ4eEhcSoKpR+IzqwKSwLCKfd0OiSu4HJeY0I6Ml+gYWmkyWPW
         3V9Q==
X-Gm-Message-State: AOJu0YxvxidwJpPbPPRgOIHl2/OJ6ZpSUYBkA0XBpI/OffWSwPHD8Kcg
	FMvTx31L9rCgsv9WuSkxMkBHpj0v5sQLpkRtfvvwWAC+D9VvPWnTk4kdNA==
X-Google-Smtp-Source: AGHT+IFqQC3pLeu9cOJIqv/K9y65wD1G3f3moVUf45cOA6XIeraF0FowFF+IutRxRSOghk3sR1xoig==
X-Received: by 2002:adf:e802:0:b0:35f:1d13:c843 with SMTP id ffacd0b85a97d-3607a720704mr504615f8f.11.1718310311066;
        Thu, 13 Jun 2024 13:25:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c911sm2583377f8f.33.2024.06.13.13.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 13:25:10 -0700 (PDT)
Message-Id: <17c97301baa829a993cf8838deb9271add5bd1cd.1718310307.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Jun 2024 20:25:02 +0000
Subject: [PATCH 2/7] merge-ort: maintain expected invariant for priv member
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

The calling convention for the merge machinery is
   One call to          init_merge_options()
   One or more calls to merge_incore_[non]recursive()
   One call to          merge_finalize()
      (possibly indirectly via merge_switch_to_result())
Both merge_switch_to_result() and merge_finalize() expect
   opt->priv == NULL && result->priv != NULL
which is supposed to be set up by our move_opt_priv_to_result_priv()
function.  However, two codepath dealing with error cases did not
execute this necessary logic, which could result in assertion failures
(or, if assertions were compiled out, could result in segfaults).  Fix
the oversight and add a test that would have caught one of these
problems.

While at it, also tighten an existing test for a non-recursive merge
to verify that it fails correctly, i.e. with the expected exit code
rather than with an assertion failure.

Reported-by: Matt Cree <matt.cree@gearset.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c           |  3 ++-
 t/t6406-merge-attr.sh | 42 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 10f5a655f29..6ca7b0f9be4 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -5015,7 +5015,7 @@ static void move_opt_priv_to_result_priv(struct merge_options *opt,
 	 * to move it.
 	 */
 	assert(opt->priv && !result->priv);
-	if (!opt->priv->call_depth) {
+	if (!opt->priv->call_depth || result->clean < 0) {
 		result->priv = opt->priv;
 		result->_properly_initialized = RESULT_INITIALIZED;
 		opt->priv = NULL;
@@ -5052,6 +5052,7 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
 		    oid_to_hex(&side1->object.oid),
 		    oid_to_hex(&side2->object.oid));
 		result->clean = -1;
+		move_opt_priv_to_result_priv(opt, result);
 		return;
 	}
 	trace2_region_leave("merge", "collect_merge_info", opt->repo);
diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
index 156a1efacfe..b6db5c2cc36 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -185,7 +185,7 @@ test_expect_success !WINDOWS 'custom merge driver that is killed with a signal'
 
 	>./please-abort &&
 	echo "* merge=custom" >.gitattributes &&
-	test_must_fail git merge main 2>err &&
+	test_expect_code 2 git merge main 2>err &&
 	grep "^error: failed to execute internal merge" err &&
 	git ls-files -u >output &&
 	git diff --name-only HEAD >>output &&
@@ -261,4 +261,44 @@ test_expect_success 'binary files with union attribute' '
 	grep -i "warning.*cannot merge.*HEAD vs. bin-main" output
 '
 
+test_expect_success !WINDOWS 'custom merge driver that is killed with a signal on recursive merge' '
+	test_when_finished "rm -f output please-abort" &&
+	test_when_finished "git checkout side" &&
+
+	git reset --hard anchor &&
+
+	git checkout -b base-a main^ &&
+	echo base-a >text &&
+	git commit -m base-a text &&
+
+	git checkout -b base-b main^ &&
+	echo base-b >text &&
+	git commit -m base-b text &&
+
+	git checkout -b recursive-a base-a &&
+	test_must_fail git merge base-b &&
+	echo recursive-a >text &&
+	git add text &&
+	git commit -m recursive-a &&
+
+	git checkout -b recursive-b base-b &&
+	test_must_fail git merge base-a &&
+	echo recursive-b >text &&
+	git add text &&
+	git commit -m recursive-b &&
+
+	git config --replace-all \
+	merge.custom.driver "./custom-merge %O %A %B 0 %P %S %X %Y" &&
+	git config --replace-all \
+	merge.custom.name "custom merge driver for testing" &&
+
+	>./please-abort &&
+	echo "* merge=custom" >.gitattributes &&
+	test_expect_code 2 git merge recursive-a 2>err &&
+	grep "^error: failed to execute internal merge" err &&
+	git ls-files -u >output &&
+	git diff --name-only HEAD >>output &&
+	test_must_be_empty output
+'
+
 test_done
-- 
gitgitgadget

