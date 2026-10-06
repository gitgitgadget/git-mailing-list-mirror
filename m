Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BA822425B
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 06:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791269804; cv=none; b=Xmrb0SKWmk2855HLX3c6R3OYScYJuES0xdV7S5TaGwf2/OlJfppEdoGtbn5aLLjytQoq+0ENzdpa0l9pfS4dGGc3S321hHqGANhuBI0CLd2rPaIkt8hrMgXizCACi0opiZe/jQ8wbhROj6aS3k2rwziLyrsjfvLvaAWYSh5SriY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791269804; c=relaxed/simple;
	bh=WAYGV3liKp7nxZXMjYQ9uZKD+mzROXopZIGrdYOayEc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dzG5gKzQ6xdD2K1FfFvd1+0DoQVmfXiOSd1qs8nJbLXuNEcb74BF+9dz1v3nLqNfhVChdZ366siKQKjmASyTZaUCNaMp3+fx9kwVh4OdkV6xPNQC0PSOSgU3tLfHejOTd90GY7+02vJkgnOHnHh1QdJfBJ+m7xVtmzRWTVYwfKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EafA+HQz; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EafA+HQz"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-9178d514951so20774406d6.0
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 23:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791269801; x=1791874601; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xz5OmE8d0d+EwLBHqxOo9f8ljFZwrF/pcGU8Odnk2Fg=;
        b=EafA+HQza09/Jko2G2z7AFKuSmcR/0cA6JOuqbOdSG3jqF7piur0oHPNV3RXp6KGbp
         S3a+pX3DUvQ0QFJfMQQDekJQ30E1XM4gjmqbCxIc21DHzPMRw1m24dTA/EJv1ejrOIiC
         vXifiB7+6M0AnO5CPxyrMqZ6EkrcKAcUO27B5LhLPoz0v4RtLMlHjClPl0NoPkJ+DtFY
         8tRkC5sxqUpf6JETZP8mCc7UJRXy8qkIGRrKwQFY7xt/wLjfhqO7LXEpciDLfCrBuyka
         b+L7IrHI0CM3sYwCXyOjoonYIGNaTv6fdMtpm+K8fB3l1OYWkqguEq6E4+wBfKqShFZu
         q1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791269801; x=1791874601;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xz5OmE8d0d+EwLBHqxOo9f8ljFZwrF/pcGU8Odnk2Fg=;
        b=cj0XUt0UrbLry4Cu7mRmCAb0GVA2vDD8bABDMrwUigN9J6/68LMPY+RfH6+BJtOcgV
         pamEKAukW6TVrV2jKAqjSb6xQ5lM760jU+iUy83wMbBrfqX8Jk67WolH41ZR5BVVIUS6
         ja82cEzj+TJiH8v9iYGf1454cxQL0QQg0CgtiA0dsufDTCKAymK0ZVoiKsWIoSRItF0w
         q62O4JE6Hl4ptCm1UnMaKktPiOa10Imt4GpYaYoA7z3ptDAiqJ1Uv2EVvf2MG1BxRpHX
         prpctxNB5ejSOsoQxcMWJGPDSifRnV/NM6qJicbA1Svr64WlBZkl+6L3tsz2puMQ9hUQ
         OfGg==
X-Gm-Message-State: AFq9FYLOYm51tNBVZlz4l/6uVVJlCgJCK1gstjsf2pyew4nBoVS5yRYQ
	bQSxzJR+rfY92qhBAoMfr9SLGbGnH+gIvbSk0BmNPMK0hFW5lnoX8TsdCSgkcg==
X-Gm-Gg: AYBFou3bENAJ2rHu5xBBDPWKwrw7Rjqdi4715HQfa0hbPhzjIpTHVAKLT7fUwARRX8R
	g8vKowFSd4wZ/00LYUUVa8y+3e3+AV2UlRLy8RooL2jPgAP9nlkkw/Kl7ryJJCZkSOR7pyOaSCE
	ZX+5vmV43SD/NMUScXf6U9hX0ZGrod24Ivz13o9/dkCuZ6Q0wM1j3LV1+ARmOrFJUkpOykTWlp5
	Q1DRi95O53zs09sgwvn5sbfNe9EH13gpgabcEkqyLo1E7bMI1ZWwsHo8z7PaDyB/lldFLL+2c1F
	cPUGsw9hrbsCGgiqlbXHujC3HpLUi+xCiWJgFkZFZITjDLHm2mTmX++A9Qwyl9DUf+YnTU8KdDl
	EGnIu/0NDTjBCoVkyp47YFH0F14J3jiI1d6Fs60q3Q8nYTw1az+zuW+R1gEUoV93uvepTntlv2y
	JsNSdtioKbWthyjoSD4c2eyv3QMicwRqd9OW0NczcZEkhbDUK68RMqsv6eBLIiGSmMcyCHmQG19
	avemZSKuUNo
X-Received: by 2002:a05:6214:ac1:b0:917:b7c2:7faa with SMTP id 6a1803df08f44-9195d1dee57mr181863516d6.41.1791269801304;
        Mon, 05 Oct 2026 23:56:41 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.60.104])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0bcf9f5sm105794826d6.32.2026.10.05.23.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 23:56:40 -0700 (PDT)
Message-Id: <917f373f916945b7a01b151756eba90f55a347fe.1791269798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2419.v6.git.git.1791269798.gitgitgadget@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
	<pull.2419.v6.git.git.1791269798.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Oct 2026 06:56:37 +0000
Subject: [PATCH v6 1/2] ci: annotate leaks and stop a leak-sanitizer script at
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

Give a leak its own annotation, naming the script it turned up in, the
exact line isn't known, only which script:

    memory leak logged in t1060 (t1060-object-corruption.sh)

Put the sanitizer report in a log group next to it, so it stays
visible.

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
 t/test-lib-github-workflow-markup.sh | 10 ++++++++++
 t/test-lib.sh                        |  6 +++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

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
index fa29a62aa3..3fa7859f0b 100644
--- a/t/test-lib-github-workflow-markup.sh
+++ b/t/test-lib-github-workflow-markup.sh
@@ -28,6 +28,7 @@ start_test_output () {
 	github_markup_output="${GIT_TEST_TEE_OUTPUT_FILE%.out}.markup"
 	>$github_markup_output
 	GIT_TEST_TEE_OFFSET=0
+	github_markup_script_name=${0##*/}
 }
 
 # No need to override start_test_case_output
@@ -53,4 +54,13 @@ finalize_test_case_output () {
 	echo >>$github_markup_output "::endgroup::"
 }
 
+finalize_test_leak_output () {
+	echo >>$github_markup_output \
+		"::error::memory leak logged in $this_test ($github_markup_script_name)"
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

