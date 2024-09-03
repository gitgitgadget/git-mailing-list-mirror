Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1161D58A2
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 22:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725401214; cv=none; b=OqvpvC+EOTaWnm56dc+Nndsvd40dtEIESikrU6DJ2C659p1fPSlgcOU5uDLNxr/AJ0ki6Qm2CjUmEcDyRKLrrIzZ60VBv1um7zJDEHD8syiWHf1M/wchyvXKMV8xLvCR9ZEz4wlaIV9pQoJaQ0V5OuDgIxO01dX4U+Fy1gqFY+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725401214; c=relaxed/simple;
	bh=y3vvVP6IwvuIFwKPTuSdOLOsBfuXRyYpS0D0qUnkmck=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=t8udroVu8J5WdG8WTHPixO03terZD1ROp3Au7TLhNx9hRATJJn50rYQZmmWSghcyyL/cXEDMSsBAJ8yhABzQ37uFHCGUQ4VhBlzgn24C7I4DwuTbqN8PUcNKTUNZth3EhaE6tN08eHKo0kkiPQ3zZdmMX+vwTkOkUEHF4+oTSdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XP0BHhtm; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XP0BHhtm"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso5531774a12.3
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 15:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725401211; x=1726006011; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiLCQgSI0RN/qaGSBlsSMDWWC7ZyEXa22FwToiJZsjI=;
        b=XP0BHhtmMHupzyjnyPLFH8Vqyr5fUuiI5QaTAgzZMYssR0N3DyKSmKm0/f7KniMqwe
         G3UDaOY2YkaKRazr0LJJTk+PXefyLo3FG2c3+fObDSiBaHmKmBcY3GWqkxl45/lvOTcs
         BXApeBSPYCXUKYEnTmryTgfQ5P/1Vdrl2fOtsMv0tCaYRP+tuxxzLxamQ4LIfwZY2olf
         cPJbZPQQcbbhKMIyIKeAzjDJk65AdKNfc86arLLlnm0NOSH9EG2XRHFkjFRNXe9Vlg67
         zDsXzjdDT8EYWAWuokvIKmZ5A86Gl08K+Y3iqYDfJVY1qW12CjvhgI+fraY2kG0QStI2
         HXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725401211; x=1726006011;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiLCQgSI0RN/qaGSBlsSMDWWC7ZyEXa22FwToiJZsjI=;
        b=t5w8+tncTmo70HBu5rZlqILq7kHzEQ+//GnXqzjX14e3nt79h/yfBXbL8jI/hnFdxu
         fsV9epqWsz+2p+yQ/D/tLm0kwqR5VkEELSrewc732nA74gbXwg3GDWFfDkWDUai0FwXH
         fW8DrR1MIlUzAVlGmdM+TbbZRI479eIlIIbTUOpXYTy40bqU/AuvCII4floUeAGZJ6Oy
         Kca9NbqjJmW4mYKOldG4i1/HXHc9FhySbyqZ1VvrmM0/UBNymST+gjc44oqWbGVTKz9/
         3tSuE1hrHnt1PN0yPgDjpas/FwXJDebUTp5vziirhHjO8faMfKQP/WCiwLI/0Epd6bcl
         +kJQ==
X-Gm-Message-State: AOJu0YzuA/84SqMScZsoX5h9TgR8LLCayl9fcmqpRep080nIffkzLG7+
	ky63tinmZr1fX/dU78pOh+8Xyf+1q1+Ifo8kUKOS0r1CGx/1IwFCp2ejcw==
X-Google-Smtp-Source: AGHT+IGeTetnlc7RYne4rFkCTKR2xGT/8xNyOW3KnttFgHFVmGVPZInRPMYV3RnocebNYz5/JkajkA==
X-Received: by 2002:a05:6402:13c8:b0:5c2:1f74:114f with SMTP id 4fb4d7f45d1cf-5c24301db2emr8904315a12.34.1725401209677;
        Tue, 03 Sep 2024 15:06:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c6a40bsm6864721a12.19.2024.09.03.15.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 15:06:49 -0700 (PDT)
Message-Id: <73fe71abcd578316a81615feee9561015c2a1c53.1725401207.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1770.v4.git.git.1725401207.gitgitgadget@gmail.com>
References: <pull.1770.v3.git.git.1725386044.gitgitgadget@gmail.com>
	<pull.1770.v4.git.git.1725401207.gitgitgadget@gmail.com>
From: "Kevin Lyles via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Sep 2024 22:06:46 +0000
Subject: [PATCH v4 1/2] t1092: allow run_on_* functions to use standard input
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Kevin Lyles <klyles+github@epic.com>,
    Kevin Lyles <klyles@epic.com>

From: Kevin Lyles <klyles@epic.com>

The 'run_on_sparse' and 'run_on_all' functions do not work correctly for
commands accepting standard input, because they run the same command
multiple times and the first instance consumes it. This also indirectly
affects 'test_all_match' and 'test_sparse_match'.

To allow these functions to work with commands accepting standard input,
first slurp standard input to a temporary file, and then run the command
with its standard input redirected from the temporary file. This ensures
that each command sees the same contents from its standard input.

Note that this does not impact commands that do not read from standard
input; they continue to ignore it. Additionally, existing uses of the
run_on_* functions do not need to do anything differently, as the
standard input of the test environment is already connected to
/dev/null.

We do not explicitly clean up the input files because they are cleaned
up with the rest of the test repositories and their contents may be
useful for figuring out which command failed when a test case fails.

Signed-off-by: Kevin Lyles <klyles@epic.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 6fa7f5e9587..4cbe9b1465d 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -179,22 +179,26 @@ init_repos_as_submodules () {
 }
 
 run_on_sparse () {
+	cat >run-on-sparse-input &&
+
 	(
 		cd sparse-checkout &&
 		GIT_PROGRESS_DELAY=100000 "$@" >../sparse-checkout-out 2>../sparse-checkout-err
-	) &&
+	) <run-on-sparse-input &&
 	(
 		cd sparse-index &&
 		GIT_PROGRESS_DELAY=100000 "$@" >../sparse-index-out 2>../sparse-index-err
-	)
+	) <run-on-sparse-input
 }
 
 run_on_all () {
+	cat >run-on-all-input &&
+
 	(
 		cd full-checkout &&
 		GIT_PROGRESS_DELAY=100000 "$@" >../full-checkout-out 2>../full-checkout-err
-	) &&
-	run_on_sparse "$@"
+	) <run-on-all-input &&
+	run_on_sparse "$@" <run-on-all-input
 }
 
 test_all_match () {
@@ -221,7 +225,7 @@ test_sparse_unstaged () {
 	done
 }
 
-# Usage: test_sprase_checkout_set "<c1> ... <cN>" "<s1> ... <sM>"
+# Usage: test_sparse_checkout_set "<c1> ... <cN>" "<s1> ... <sM>"
 # Verifies that "git sparse-checkout set <c1> ... <cN>" succeeds and
 # leaves the sparse index in a state where <s1> ... <sM> are sparse
 # directories (and <c1> ... <cN> are not).
-- 
gitgitgadget

