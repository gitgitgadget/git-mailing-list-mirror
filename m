Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8118139D6FA
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 09:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280330; cv=none; b=JOfUEJQmf8O0IpCvhvXOdeu0Cx+YlLJ6/nBkw6nww48CxvgfmdFnBteAbk8RCmvXeScyFDAPweRNE2pkHNx1TTlD1WPsRQXnRxkc59gS6FQylXoWR+ovz0234LyVrzLm5Ut1zZrzyM8YEfD54ZLgq05TyskCxTIREiPDka9CY98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280330; c=relaxed/simple;
	bh=bqOEoXZkym6ghjyBgVt2yxmdQnEu328CkCfGnZ4oNNw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TtHW5dddNC+XI9VdGryNuXselBVrYpbg1clkt0Wbv/yXN1gIOoxa2cgtVquA+M8wRxNnHaqPaXdmbdOEXxPlxIaIfipX99rIH/FsLFwgnKguTo0NlwKUKty38fvOU6ISJrgtoJXBPefLyq40BoEezoGilPl3NR+Aw5Qb7L6N8qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuLGd7LD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuLGd7LD"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so29462945e9.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 02:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791280326; x=1791885126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hg1pswKTroMqjYk/5U2iFiuNN24w7tQKhe5wfVfFH8g=;
        b=DuLGd7LDso6R3RRJ8b67qR0iXwDumLUso1vAoRHZX+JGBOMw3CgjLoJcGgNAUkNRrf
         yALfixSnQUaKFfDwDmuT6Kj7tPYosFTk0lW9ixOHRlE6G0ybFdXJ9rMSgY1udqMoxg/8
         SDgp7vKt9AP4HhsPNwmwP6OXC/DAYrENNEbLvtNp9B5yw7XfkMMIJCoed2i0Y3LQ7U2f
         f/BvIzpArHj1075rTSSnQh2CembL1UI1gvGBgp8fKAyFz+uQfU+0pawIZRzOCNBgw0FV
         yknNMM5EYSMof/4P+EQbEg/TYIarnP8SNwq64bv+jGBM5ENBNVeYAkWI9ELykC+PmhlX
         w7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791280326; x=1791885126;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hg1pswKTroMqjYk/5U2iFiuNN24w7tQKhe5wfVfFH8g=;
        b=cHYRr8SvsiBIPPBmoF+ol3v/XTUMYywfibtRdduYfTAMdmQWof923YHNRPobKyYV7t
         k96T9R7yfGIcs+Bnb9FJlx5sFUNJCQ5GJ+/MeP8WNWGTXuaA+rdCtJjOEgoJEOnp9sp2
         2r/85Vuw8XnWbSG0qwURWnH4QAgPEBkRwTJ9QbzkouQAlKVzujE24xa1hxaZozed3Yga
         u/1fv+oBlpYmVizD5og0o2w6wP/ZhQMUwlljOSh/UGj2hKsAmUwMQhbesZf/+LbBJFGg
         kSc5P2umYrf1ysn5UCKh3/lyfoa7CPrydc+siNzyLKKP4bAkdJxwON4/j2CbXAetJKhT
         pPug==
X-Forwarded-Encrypted: i=1; AKwUvBzbTAXD3PpTkKxjM5OZT7fMmYQvaOwkR0fEtJqqfzdm8MXggJcwEGn5hdnNdx7XwWgAqC8=@vger.kernel.org
X-Gm-Message-State: AFuF++lvsF8jT1J7BGcsJVlH1b/vLbJJLXY+MGrnlJo8VrORi3wabE7p
	xZ0u7zO5qxoOwnFOHVZikASjp5Or/6Y2PCZRrWRFIR+mIdRYljB9r83h
X-Gm-Gg: AYBFou15KXTSTU9Eh4NOnBCjqv4uJnywBDAegFkGwrQD3cdwP9H61Ldc6fdbWHwMSYn
	IfuyZ4oTF6dNTGTLCwK1v0kuiEFhDV9lAlP/eDnYQUT04gGVf/JleasNiVfDa+Yht5g1vEdlarc
	mDJ3tJNOjfH02mwxJAiXPAyiwZmGGcKsCAV4dvroeMzLdMquMmT0HHcFB9W0wtZ/gjjgf2Usf4D
	asRlUnytGSAdcbrfauVoP5t53Wq8jWQsR/xBLKIwkX7pQbFdF+rc0gaVMqQWtsHRJlNLHYTpkAp
	o0NsIYQSFqxwSa6CIafQBr+dzaf6X5K3HJ7wIkJg4CTRWxF1mNMlBcdE+OLiLc0HXTwWionuFHF
	vtgX5V0GvUCn3uDVzgaOofKoqaF1JQbL98+t0wqoz3OZr5cKpGx6YWQH/KBK3wvit/LvBCiCnra
	EnM/Pf2Mm8P4Th9J8t2lSe4uaW6ZYodr0fyLc5zPBwhXr7NIF2zq2WzBVLPnGBk+9WUkwEXvUSZ
	JaNtN1Zuim6OJEa9IyX/hPCnBTXkTAVyZqWK9OYAaJDQ8PZNriE
X-Received: by 2002:a05:600c:3e0e:b0:4a1:76c9:5408 with SMTP id 5b1f17b1804b1-4a176c9543fmr59559105e9.11.1791280326436;
        Tue, 06 Oct 2026 02:52:06 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c6229291fsm9992064f8f.27.2026.10.06.02.52.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 02:52:05 -0700 (PDT)
Message-ID: <2554cf1e-9612-4dbf-958f-f9ff7ea71dc7@gmail.com>
Date: Tue, 6 Oct 2026 10:52:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 0/2] ci: link failure and leak annotations to the test
 script
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ben Knoble <ben.knoble@gmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
 <pull.2419.v6.git.git.1791269798.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2419.v6.git.git.1791269798.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 06/10/2026 07:56, Harald Nordgren via GitGitGadget wrote:
> Link failure and leak annotations in CI to the test script, so both can be
> found from the job summary.
> 
> V7 CI job where failures and leaks are reported:
> 
>   * https://github.com/git/git/actions/runs/37205086805?pr=2426
> 
> Changes in v7:
> 
>   * Revert the linking in annotation message, direct direct line fails when
>     error pointed to an unchanged file in that PR, which regresses the
>     experiences in many cases. Instead now show the file and line as plain
>     text in the annotation.
>   * Don't name the the line number as 1 for leaks, where it's never
>     available, just omit the line number.

This has been sent as v6, but the range-diff looks good and matches the 
changes listed here. Lets get this merged!

Thanks

Phillip

> Changes in v6:
> 
>   * Update commit message.
> 
> Changes in v5:
> 
>   * Removed % escaping entirely, verified on CI that it isn't needed. Every
>     existing test description that uses % renders correctly unescaped.
>   * Rewrote the file/line commit message with a concrete example (failed:
>     t1060.17 partial clone of corrupted repository).
> 
> Changes in v4:
> 
>   * Clarify commit messages and simplify escaping logic.
> 
> Changes in v3:
> 
>   * Fixed bug in the --immediate exit ordering: the --immediate &&
>     --invert-exit-code path called exit 0 before the test's annotation was
>     written, now a single unconditional call covers both exit paths.
>   * github_escape_message_ no longer relies on \r being a portable sed escape
>     sequence (not POSIX-guaranteed and BSD sed implementations can differ),
>     it splices in the literal carriage-return byte via printf instead.
>   * Reverted unrelated test-tool line back to its original form.
> 
> Changes in v2:
> 
>   * Split into two commits, each explaining its own reasoning.
>   * Leak output is no longer capped or embedded in the message, it's now an
>     uncapped fold, so multiple leaks in the same test both show in full. A
>     second leak in a different test still won't show in the same run,
>     --immediate stops the script at the first failure, but it no longer gets
>     buried under every later test falsely reporting "not ok" either.
>   * Drops the giant unfolded message that annotations used to carry, which is
>     what probably caused the scrolling behavior.
> 
> Harald Nordgren (2):
>    ci: annotate leaks and stop a leak-sanitizer script at its first
>      failure
>    ci: point test failures and fixed known breakages at their file and
>      line
> 
>   ci/lib.sh                            |  1 +
>   t/test-lib-github-workflow-markup.sh | 39 +++++++++++++++++++++++-----
>   t/test-lib.sh                        |  6 ++++-
>   3 files changed, 39 insertions(+), 7 deletions(-)
> 
> 
> base-commit: 8103b446517e0c44e67561b9d0ccce56efa60a71
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2419%2FHaraldNordgren%2Fci-annotation-file-line-v6
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2419/HaraldNordgren/ci-annotation-file-line-v6
> Pull-Request: https://github.com/git/git/pull/2419
> 
> Range-diff vs v5:
> 
>   1:  851efeec8b ! 1:  917f373f91 ci: annotate leaks and stop a leak-sanitizer script at its first failure
>       @@ Commit message
>        
>                Process completed with exit code 1.
>        
>       -    Give a leak its own annotation. Point it at the test script, the exact
>       -    line isn't known, only which script the leak turned up in, and put the
>       -    sanitizer report in a log group next to it, so it stays visible.
>       +    Give a leak its own annotation, naming the script it turned up in, the
>       +    exact line isn't known, only which script:
>       +
>       +        memory leak logged in t1060 (t1060-object-corruption.sh)
>       +
>       +    Put the sanitizer report in a log group next to it, so it stays
>       +    visible.
>        
>            Once a script has one leak, it keeps running: the sanitizer log
>            directory is never cleared between tests, so every later test in the
>       @@ t/test-lib-github-workflow-markup.sh: start_test_output () {
>         	>$github_markup_output
>         	GIT_TEST_TEE_OFFSET=0
>        +	github_markup_script_name=${0##*/}
>       -+}
>       -+
>       -+github_annotation_ () {
>       -+	echo >>$github_markup_output "::$1 file=$2,line=$3::$4"
>         }
>         
>         # No need to override start_test_case_output
>       @@ t/test-lib-github-workflow-markup.sh: finalize_test_case_output () {
>         }
>         
>        +finalize_test_leak_output () {
>       -+	# The exact line the leak turned up on isn't known, only the script,
>       -+	# so point at line 1.
>       -+	github_annotation_ error "t/$github_markup_script_name" 1 \
>       -+		"memory leak logged in $this_test"
>       ++	echo >>$github_markup_output \
>       ++		"::error::memory leak logged in $this_test ($github_markup_script_name)"
>        +
>        +	echo >>$github_markup_output "::group::leak: $this_test.$test_count"
>        +	cat "$TEST_RESULTS_SAN_FILE".* >>$github_markup_output
>   2:  46f93a9e16 ! 2:  acf1fbd250 ci: point test failures and fixed known breakages at their file and line
>       @@ Metadata
>         ## Commit message ##
>            ci: point test failures and fixed known breakages at their file and line
>        
>       -    When a test fails, GitHub shows an annotation naming it, for example:
>       +    A failing test gets an annotation in the Annotations list on its job's
>       +    summary page, naming it, for example:
>        
>                failed: t1060.17 partial clone of corrupted repository
>        
>       -    but the location GitHub attaches to that annotation is the CI
>       -    workflow file itself, not the test script, so there is nothing
>       -    pointing at where the test actually lives.
>       +    with no indication of where that test lives.
>        
>            Find the line a test is defined on by searching its script for the
>            test's own description as a fixed string, using the first match, and
>       -    attach that file and line to the annotation instead. Fall back to
>       -    line 1 when the description is not found verbatim, which happens when
>       -    a test builds its description at runtime instead of writing it out
>       -    literally.
>       +    add the file and line to the annotation's own message text:
>       +
>       +        failed: t1060.17 partial clone of corrupted repository (t1060-object-corruption.sh:141)
>       +
>       +    Fall back to naming just the script, with no line, when the
>       +    description is not found verbatim, which happens when a test builds
>       +    its description at runtime instead of writing it out literally.
>        
>            Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>        
>       @@ t/test-lib-github-workflow-markup.sh: start_test_output () {
>        +	head -n 1 | cut -d: -f1
>        +}
>        +
>       - github_annotation_ () {
>       - 	echo >>$github_markup_output "::$1 file=$2,line=$3::$4"
>       - }
>       -@@ t/test-lib-github-workflow-markup.sh: github_annotation_ () {
>       + # No need to override start_test_case_output
>       +
>         finalize_test_case_output () {
>         	test_case_result=$1
>         	shift
>       @@ t/test-lib-github-workflow-markup.sh: github_annotation_ () {
>        +	esac
>        +
>        +	test_case_line=$(find_test_case_line_ "$1")
>       ++	test_case_where="$github_markup_script_name${test_case_line:+:$test_case_line}"
>        +
>         	case "$test_case_result" in
>         	failure)
>        -		echo >>$github_markup_output "::error::failed: $this_test.$test_count $1"
>       -+		github_annotation_ error "t/$github_markup_script_name" "${test_case_line:-1}" \
>       -+			"failed: $this_test.$test_count $1"
>       ++		echo >>$github_markup_output "::error::failed: $this_test.$test_count $1 ($test_case_where)"
>         		;;
>         	fixed)
>        -		echo >>$github_markup_output "::notice::fixed: $this_test.$test_count $1"
>       @@ t/test-lib-github-workflow-markup.sh: github_annotation_ () {
>        -	ok|broken)
>        -		# Exit without printing the "ok" or ""broken" tests
>        -		return
>       -+		github_annotation_ notice "t/$github_markup_script_name" "${test_case_line:-1}" \
>       -+			"fixed: $this_test.$test_count $1"
>       ++		echo >>$github_markup_output "::notice::fixed: $this_test.$test_count $1 ($test_case_where)"
>         		;;
>         	esac
>        +
> 

