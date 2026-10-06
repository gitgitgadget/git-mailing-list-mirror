Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6363A9616
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 06:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791269804; cv=none; b=Gedr9JRKySx8osZb+h2OJaC/HNy7PDBtLmXQoE63gAUFm0GWi0ppn9OFmkDdgmN7KDIbUffWqSgn0kCb3VmRYQ6BE+zmFygrg8T3Va7nGGgXxYELj9fHDAe/Pl2UYFV68alRQAEA2j+AdVhwzleRXweZ0UPHxFYpu/pYDuQ00F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791269804; c=relaxed/simple;
	bh=0yRe1juDoCqybumUkOu6DRZXu4I0x2w1r2mznaLcsOo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=snPA+Lp8eQ5tWTPuXgNjbNsRYecPgT1fS+uFV52gMYa5gWv4MJ7PL8BHpdakxzYoHLPHEYfzfSWBf2CZonwOiy7ir0vDDaBm2lsfh3cEch5a2lJUEcIvK5pY2sqc5sjSJJXni07HHkr3ORsecwhWBN8+S9iZiW0TSj1CXYUu1IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n+YIb9Md; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+YIb9Md"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-917a97b39e8so4526716d6.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 23:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791269802; x=1791874602; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ex3SjVOEXkBGiCRzRCRa9mkzDEuHm9zNW6xJcK3YCm4=;
        b=n+YIb9Md/TqqH+4X/BJ02q58Uldls9qVa0B92isTX7q2JtTkENkm/XG5HzrCw3ecXf
         OZK3bUS7dXZLwdc78eMmPAxC+eCy8qkiaoPgHhbKUC4rz3Q2KRchwEDZJqQOaYVRGCUi
         GwsQOqdhxcmRypi4Q7zDA06bJxQ7XdWAihDiLZq6rMdRuQq89/eSOjXvb564lMJLrZ6D
         rvys63iEe26/Le0pW3FWKJgv5fIjUq3qHHI0j9U6cgchqLR5cpOLsYURDU0HJb8scLJj
         wZzVaZRTkPmrVadBH8ptW3bDEouAdrwjmOgFCeNEAcJeN11CcxsAqU2StGdkzLw7Ri2t
         aofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791269802; x=1791874602;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ex3SjVOEXkBGiCRzRCRa9mkzDEuHm9zNW6xJcK3YCm4=;
        b=w3wzBE5Owkc5V/SDOPL/cvKQOviWYGGPxDfQq+c3+115xGan/LOKpl//X5NAs5mC6L
         mLtdY6m/XooMqtcdE9e5UlBTvwRNhRbuR91sdErqYLWe85arEgf+kjVXZfGuwdUTmtR0
         U8nN1IMA6Ww2aejR6ZDj3QE30JpNUsln7lPscLob1bEqlytJ5+6G1YbGFwqf5x6O8lHG
         tUQ34dwh2vga9TQb3fpfnolUBM11KQSTPVJxGy7dAtQZYpFkVSMJv8xQaXDSGZolYvtU
         FapHGmEQ8Y6VB/Jo5etr3XUebMzYeiEbHjScVvZ/p+PKYoM+zJRAg38HTEj0RB7NzN0H
         Z22g==
X-Gm-Message-State: AFuF++m1ZJE14qMaRHfpnrIk0rBbg1+1mrkNGNMTmbs3a9rnb1FU/feo
	ryE+ng7FW19Ezw+QswVHsqBCNGZe0TRiJNTi7XSGikOY9+p0IbNMAHoYAKPNlA==
X-Gm-Gg: AYBFou10JZXBe38TsZtOlg9JjFi2n8YaZkK+BDtj0sj7/UQLMUOIaNZA+Lcdk9eYCwN
	CTlwn9JNy+JI3p1FKZrQr813CQpYArdaiokmIkcbaSq41SXjdtY3kGfsV4Wbc6L8LbRSVzQXe84
	aRWTOJCCTxWl5+EplDwRq3E4G8n/EFnq3OxtDZ99BUU1qOcHTQfsZ60RxNzXfCjLOPLFHCUO0NF
	sJ0g1NpAZlh78sancNuzs+WDlY46p90KvrntXwDQHTpl48a0xN0SOt6xodxwvDs59+AmfWG4CG9
	ov3aBpnM1YRG8Ho0U7bdSuzHRhHdNTqmyOC5lga/xNaJAYHyrDvp4hdQPfLa202D9+cxHusZFI4
	HET6E7qoOxnmH77nZHKKTRDlyETAq92vBd5Nllk7/tDicqZspGgWsmFEvtRxWkymidK8kPT6c5s
	dIWjGLBcfEr5yrae6YQjusDa/DNj5ttmIR6cP4QXBu9hswVcBTAhzePXR6E2X6IXt15nn4yxyOR
	UPgYv6j+iEU
X-Received: by 2002:a05:6214:2f90:b0:917:8d8f:9d6c with SMTP id 6a1803df08f44-9198b7a428amr9339596d6.9.1791269802345;
        Mon, 05 Oct 2026 23:56:42 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.60.104])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917d593a20asm106318876d6.2.2026.10.05.23.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 23:56:41 -0700 (PDT)
Message-Id: <acf1fbd250c347a0f1afc295e603f3463c14217f.1791269798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2419.v6.git.git.1791269798.gitgitgadget@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
	<pull.2419.v6.git.git.1791269798.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Oct 2026 06:56:38 +0000
Subject: [PATCH v6 2/2] ci: point test failures and fixed known breakages at
 their file and line
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
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A failing test gets an annotation in the Annotations list on its job's
summary page, naming it, for example:

    failed: t1060.17 partial clone of corrupted repository

with no indication of where that test lives.

Find the line a test is defined on by searching its script for the
test's own description as a fixed string, using the first match, and
add the file and line to the annotation's own message text:

    failed: t1060.17 partial clone of corrupted repository (t1060-object-corruption.sh:141)

Fall back to naming just the script, with no line, when the
description is not found verbatim, which happens when a test builds
its description at runtime instead of writing it out literally.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 t/test-lib-github-workflow-markup.sh | 29 ++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/t/test-lib-github-workflow-markup.sh b/t/test-lib-github-workflow-markup.sh
index 3fa7859f0b..826c4ac902 100644
--- a/t/test-lib-github-workflow-markup.sh
+++ b/t/test-lib-github-workflow-markup.sh
@@ -31,23 +31,40 @@ start_test_output () {
 	github_markup_script_name=${0##*/}
 }
 
+find_test_case_line_ () {
+	# A description can contain characters like [ or * that would
+	# corrupt a regex search, so match it literally and take the first
+	# hit. The -- keeps a description starting with "-" from being read
+	# as an option.
+	grep -n -F -- "$1" "$TEST_DIRECTORY/$github_markup_script_name" |
+	head -n 1 | cut -d: -f1
+}
+
 # No need to override start_test_case_output
 
 finalize_test_case_output () {
 	test_case_result=$1
 	shift
+
+	case "$test_case_result" in
+	ok|broken)
+		# Exit without printing the "ok" or "broken" tests
+		return
+		;;
+	esac
+
+	test_case_line=$(find_test_case_line_ "$1")
+	test_case_where="$github_markup_script_name${test_case_line:+:$test_case_line}"
+
 	case "$test_case_result" in
 	failure)
-		echo >>$github_markup_output "::error::failed: $this_test.$test_count $1"
+		echo >>$github_markup_output "::error::failed: $this_test.$test_count $1 ($test_case_where)"
 		;;
 	fixed)
-		echo >>$github_markup_output "::notice::fixed: $this_test.$test_count $1"
-		;;
-	ok|broken)
-		# Exit without printing the "ok" or ""broken" tests
-		return
+		echo >>$github_markup_output "::notice::fixed: $this_test.$test_count $1 ($test_case_where)"
 		;;
 	esac
+
 	echo >>$github_markup_output "::group::$test_case_result: $this_test.$test_count $*"
 	test-tool >>$github_markup_output path-utils skip-n-bytes \
 		"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET
-- 
gitgitgadget
