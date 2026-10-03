Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021E6386C13
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 08:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791015126; cv=none; b=Rhw4gP0aRJ7wqTZFA6tUORmzZ5vxWEJocQ1VLJmjwjx0E7ymVXP4w4Bl7dEdyf38GUlKZ4y3QTn95NEoQLLD8+1CLDaGAsbzIEiP66pLLgcFYATG6TD7FUNv4pmIN2QtTsilJIR6jbeHS6MogPK7jiRgXyX1OGe/7tG0xgu4aJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791015126; c=relaxed/simple;
	bh=jLvs07Tm9hPrszf9cGXnPiOpevPhY7/kh2s+3g+f05o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uCFbyt9E6xTlKJnM3xaUCzmTpL8cMIhbYYuYkIveBINgwOr2Bpp1dBXo1DkMVLbAfQGF+NT62g2c+Sw+UXNj0wlL/EDVnJSDEmLCi13cJjDBA9NNhTFyxjKKlL+wx5PH+GjHjjQQ1AhhnYWDG44kmZOnOVbLuKJQMjPdNw371gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXpVkrf6; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXpVkrf6"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3410209aa6aso40648eec.1
        for <git@vger.kernel.org>; Sat, 03 Oct 2026 01:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791015121; x=1791619921; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WV2KsLTXs23y9MgOA5KWA23ZnR6bPtlFgXyRgd1a5FY=;
        b=lXpVkrf69nKZCpVaJECaEKTQypBeHvC6io5CD5IbrbR8SoQO2Xtf1hcJ0N0C2nTehV
         Dn1CuEMMVh7QpylGMdkRRgJG0CtptjP6fJU0xIR+QmEGZVVjIbJiv75C5NY/dmhPDj07
         FwG5dtfZ9+FLfDmN6RcGY6BJJSkJd4udPj/bykwAwf0YsRSaFnHcit7SjcsT0kVLk6j4
         ZgTP+J+LScIdKfN5TqPtfOdvO/NmQdTirguz9I6oDnm45N3JfiQYnanSvWgilt2Kaul2
         6gWxhF63t2v5uRiwDDIjLUo5vao2GSi8zYmc7Dv/4aR1Oiw7PEMJusu8o6YOuV8T1zUo
         dbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791015121; x=1791619921;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WV2KsLTXs23y9MgOA5KWA23ZnR6bPtlFgXyRgd1a5FY=;
        b=0s/QEw+ZdNW/HcG7grvt7UfLUJYGt0OF+5nG5guNT5BvT1BEepMRk1h++Aq1hCy9Bn
         zhHXEvt9I71wIoNiwOqa38c1/XzDMkCaH39GQtFFJMHMmaX4M6Qt8gyClIZpC3j4IgPp
         QBHHCZJmkUoI5egBRu/FzuqHQTqN8UKEh8wyvGeYeLZhWtHEE/KTBqmjHZxCWxr02EF+
         GmABSGLfmgHQCk9yhdcaEIVhV4Pb37SCqgpUK6kj5Q6x5Q1woRPe2v36CsvXeRXpW7aZ
         7KuKUT3AZZmksbUXV/+A49XSMXj4y44shCiV/1ZBTOKPN+fDLQLhefKFlWdjUPN5FR6w
         YU7w==
X-Gm-Message-State: AFuF++kKROZQF4TWRnQbU7HNTIeF+YCH3DHajSbHGyCIsf+fC0nxdpnq
	jTv+W6seUC6UVS0u2XQw2jfsApQqR76gcPFR9vpyTdRB+LS3wQWQy+xLK4GPPA==
X-Gm-Gg: AYBFou0l3ucpgihbxOz5XOPfNNhXS7KluYSXL6XvTD5wJ7aq0SUxEz6shVc/XSATowK
	9ASALk4xyNEN/eatsfA4d4mCGsMO1QqIN3fSMIaWXE/rHjCGRGGfwjbO8MPXtTwsU7v+WhWKxNI
	dhpzwbhEF5vDexF2P74NRde6YntfkzDVNGvVS8ValFCTrn3RI9NNCbGCeuSLSVGezSibBYhZszj
	u7cw4TDo1Dab/iTmEovi0g6eKNg7ztpvDUPHoc1I5xNKF4UAt1iwx3UPSOC3tf68P0vjKi+cJAV
	zXUoXwf+VyvicpxLgPvTCRH91o4NLX8WvrClds3muYePa+PYOfA8PRTyUe6cr5vBtvHdldyzm3+
	vq/s/k9mArWv83AMXJkwy/xk1TupVjDL9XHfSQYQaXGidBgb8qfjq2gYWf16FZG6VQINF/PSemX
	eiK/GlmN06LpdsQ646ujhSxFavcPNxTVmBcbm1xPWzbkhAsYgs2YpakxofUpgN2IjxZSO7zAJ29
	M4=
X-Received: by 2002:a05:701b:2918:b0:148:bce6:429b with SMTP id a92af1059eb24-14dd07fc33dmr8128427c88.8.1791015120752;
        Sat, 03 Oct 2026 01:12:00 -0700 (PDT)
Received: from [127.0.0.1] ([20.189.187.214])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fc39a6cbsm4035540c88.5.2026.10.03.01.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 01:12:00 -0700 (PDT)
Message-Id: <851efeec8b363807effe81779ff75552816fdb8f.1791015117.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2419.v5.git.git.1791015117.gitgitgadget@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
	<pull.2419.v5.git.git.1791015117.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 03 Oct 2026 08:11:56 +0000
Subject: [PATCH v5 1/2] ci: annotate leaks and stop a leak-sanitizer script at
 its first failure
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

A leak is only discovered once, at the end of a whole script, well
after every test has already reported ok, and it gets no annotation at
all, so a leak-sanitizer job's only visible failure is:

    Process completed with exit code 1.

Give a leak its own annotation. Point it at the test script, the exact
line isn't known, only which script the leak turned up in, and put the
sanitizer report in a log group next to it, so it stays visible.

Once a script has one leak, it keeps running: the sanitizer log
directory is never cleared between tests, so every later test in the
same script sees the same leftover log entries and also reports "not
ok", burying the one real failure in copies of itself. Stop a
leak-sanitizer script at its first failure with --immediate instead.

A failing test already gets its own annotation once its script
finishes, but --immediate exits as soon as that test fails, before
reaching the code that writes it. Write the annotation first, so
turning on --immediate here does not silently drop it.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 ci/lib.sh                            |  1 +
 t/test-lib-github-workflow-markup.sh | 16 ++++++++++++++++
 t/test-lib.sh                        |  6 +++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index c6ccbf8c17..a89f480a78 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -382,6 +382,7 @@ linux-leaks|linux-reftable-leaks)
 	export NO_CVS_TESTS=LetsSaveSomeTime
 	export NO_SVN_TESTS=LetsSaveSomeTime
 	export NO_P4_TESTS=LetsSaveSomeTime
+	GIT_TEST_OPTS="$GIT_TEST_OPTS --immediate"
 	;;
 linux-asan-ubsan)
 	export SANITIZE=address,undefined
diff --git a/t/test-lib-github-workflow-markup.sh b/t/test-lib-github-workflow-markup.sh
index fa29a62aa3..0d54496358 100644
--- a/t/test-lib-github-workflow-markup.sh
+++ b/t/test-lib-github-workflow-markup.sh
@@ -28,6 +28,11 @@ start_test_output () {
 	github_markup_output="${GIT_TEST_TEE_OUTPUT_FILE%.out}.markup"
 	>$github_markup_output
 	GIT_TEST_TEE_OFFSET=0
+	github_markup_script_name=${0##*/}
+}
+
+github_annotation_ () {
+	echo >>$github_markup_output "::$1 file=$2,line=$3::$4"
 }
 
 # No need to override start_test_case_output
@@ -53,4 +58,15 @@ finalize_test_case_output () {
 	echo >>$github_markup_output "::endgroup::"
 }
 
+finalize_test_leak_output () {
+	# The exact line the leak turned up on isn't known, only the script,
+	# so point at line 1.
+	github_annotation_ error "t/$github_markup_script_name" 1 \
+		"memory leak logged in $this_test"
+
+	echo >>$github_markup_output "::group::leak: $this_test.$test_count"
+	cat "$TEST_RESULTS_SAN_FILE".* >>$github_markup_output
+	echo >>$github_markup_output "::endgroup::"
+}
+
 # No need to override finalize_test_output
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 321c2ba339..a893963f86 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -199,6 +199,7 @@ mark_option_requires_arg () {
 start_test_output () { :; }
 start_test_case_output () { :; }
 finalize_test_case_output () { :; }
+finalize_test_leak_output () { :; }
 finalize_test_output () { :; }
 
 parse_option () {
@@ -822,6 +823,9 @@ test_failure_ () {
 	say_color error "not ok $test_count - ${pfx:+$pfx }$1"
 	shift
 	printf '%s\n' "$*" | sed -e 's/^/#	/'
+	# Write the annotation before either --immediate exit path below,
+	# both of which call exit and would otherwise skip it.
+	finalize_test_case_output failure "$failure_label" "$@"
 	if test -n "$immediate"
 	then
 		say_color error "1..$test_count"
@@ -835,7 +839,6 @@ test_failure_ () {
 		check_test_results_san_file_ "$test_failure"
 		_error_exit
 	fi
-	finalize_test_case_output failure "$failure_label" "$@"
 }
 
 test_known_broken_ok_ () {
@@ -1218,6 +1221,7 @@ check_test_results_san_file_ () {
 		return
 	fi &&
 	say_color >&4 error "$(cat "$TEST_RESULTS_SAN_FILE".*)" &&
+	finalize_test_leak_output &&
 
 	if test "$test_failure" = 0
 	then
-- 
gitgitgadget

