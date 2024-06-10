Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA2A135A6D
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718027334; cv=none; b=eqoAXHQjal2K0CiUOBxSBdUF20wSz0PcFETViY9+9y2EjYB4uS9ga2sKVUZ4c88rrrUtg/Cdq7Z2j+2RxWm0DpR7+WJ0Us5vqK6frPw/eX1TcMq0jFO2uHoA9pLWl1VViSLEwnPwaxdfVVDEJYN3mJHHsHle3UGPGxMg+nb+99E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718027334; c=relaxed/simple;
	bh=Bk+ekDIt+yatXXLE9WI/+fQlUUJfDCYEoIm0nlsTHDI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hALc1u8QG60Ls0LaWt47qWxFhuImwRJUlFvVD5YZ0gxF4l2x6ZrajEiOuUApGuLQoVROFLKpc8D7+8vnYTSAZZ4p7BHw1pUVdP7mn0I7it0KuYoF3n2qo0/bEF+UCmRAxgPuR3212t62bZh2cYFyMAykxxs5Zm5bQDBjdpFK1Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJ4I/vX+; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJ4I/vX+"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52bc1acb9f0so2979670e87.2
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 06:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718027330; x=1718632130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zWTlb5LwvLe9AIrvyqk/28so9+B75X8LTRv4iqVW2cQ=;
        b=iJ4I/vX+FpR8WVNiwfORLQtyrwcOw9hJNR/RcHB/OJ6ZryFJE1T3b3f4GPJhs/fmdi
         wEUe4rNbnQe1f78kQ8fAOUma/MKC2zGaTO2nZxIDYCpJdWAnMevMQxee189M8ftOlyMf
         zN0oRyUVIvZk9Uvrxr1Mo4yf4rG86IAKbqLsdE8X9j4Q777imjJ9TvldT9E/RfF8ULPR
         d5znZSC65lCLl4MHo9wBGaz7v4pmsT9oDH2FioCvX2+kzKKiLGgxJJ3RP1O3Mhmz6WlP
         23JVi/577ZixMPDUgC9p0Rd8+ligWrwTlvq+3tgdolD9tLh+bjRB1k3Rkq5iPnHRys3a
         GuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718027330; x=1718632130;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWTlb5LwvLe9AIrvyqk/28so9+B75X8LTRv4iqVW2cQ=;
        b=hKKLIOomCtOxGNecIWaGzhilKilEV+soe0RI4UuPTon6yGCL46sKozF55wlCdEyJay
         a8nZ/d6xoCaWANZ7cdZQcXW5Cj5gqQodHIAsuvmxOQAxUUkr2T+Q8E5NIlgfLJpxMWiE
         AapESX/leTTiq4RNdVj2bI5XIlx703737dgpD2IaLRULMVUxNEpitCkUZfbkP0UZMzm+
         Xu5+y8vblVKdq+VgY6+HFpTAuigDODbgeVKtpfo3sOabYEwxEzLeC+H04Uf0r+Cp0mbC
         fTsE8AyzjqEtG7BhIbS+Q7gMFEZ9KxB6p8l/cIW1LZHPM/aP5IEQasY2aQLayjjmgIjE
         s6mw==
X-Forwarded-Encrypted: i=1; AJvYcCWH5M5ALumDVjUP6So8TxZEnkceTUVVazK/R6mx4xiTHnscruDbUQokRQFaGI1XLoWT/MgGK2OZFjdOjuMzojqNVFev
X-Gm-Message-State: AOJu0Yy/jH6XawXlchrq3Ttjzii+MkvhGegbvCVZV/+ctekBxAAl7XJv
	BOnMWBbjJvJXMjo+GPNaIjX1SqCaZTWjJrHuvGEKCvsEpC3rbKoE
X-Google-Smtp-Source: AGHT+IE/dfoB6Ut0Qw79wE5W87tmqGgsZoFwoNNEq9EuqF75Kz16VsPhayQSnTpePoG4VK720DBgnA==
X-Received: by 2002:a19:f707:0:b0:52c:83ef:19f0 with SMTP id 2adb3069b0e04-52c83ef1e9cmr2742400e87.44.1718027329904;
        Mon, 10 Jun 2024 06:48:49 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f2774bb64sm1579318f8f.103.2024.06.10.06.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 06:48:48 -0700 (PDT)
Message-ID: <7aabf47d-7e0e-44e3-b85e-ba46951ad0e0@gmail.com>
Date: Mon, 10 Jun 2024 14:48:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/3] diff: fix --exit-code with external diff
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 German Lashevich <german.lashevich@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Johannes Sixt <j6t@kdbg.org>
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
 <82561c70-ec33-41bf-b036-52310ffc1926@web.de>
 <e2e4a4e9-55db-403c-902d-fd8af3aea05c@web.de>
 <168fecaa-2ebd-4897-b0ba-3bd2a37c01e7@web.de>
Content-Language: en-US
In-Reply-To: <168fecaa-2ebd-4897-b0ba-3bd2a37c01e7@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi René

On 09/06/2024 08:35, René Scharfe wrote:
> Changes since v2:
> - rebase; config strings are no longer const
> - document the handling of unexpected exit codes
> - document that external diffs are skipped with --quiet and trustExitCode=off
> - silence external diff output with --quiet
> - check output in tests
> - test diff runs without --exit-code and --quiet as well
> - slightly untangle the exit code handling code to make it easier to read
> - fix copy/paste error in documentation of diff.<driver>.trustExitCode

The changes in this version all look good. I've re-read the patches and 
didn't spot any other issues so this is ready as far as I'm concerned.

Thanks

Phillip

>    t4020: test exit code with external diffs
>    userdiff: add and use struct external_diff
>    diff: let external diffs report that changes are uninteresting
> 
>   Documentation/config/diff.txt   | 18 +++++++++
>   Documentation/diff-options.txt  |  5 +++
>   Documentation/git.txt           | 10 +++++
>   Documentation/gitattributes.txt |  5 +++
>   diff.c                          | 68 +++++++++++++++++++++++++--------
>   t/t4020-diff-external.sh        | 66 ++++++++++++++++++++++++++++++++
>   userdiff.c                      |  8 +++-
>   userdiff.h                      |  7 +++-
>   8 files changed, 168 insertions(+), 19 deletions(-)
> 
> Range-Diff gegen v2:
> 1:  118aba667b < -:  ---------- t4020: test exit code with external diffs
> -:  ---------- > 1:  d59f0c6fdf t4020: test exit code with external diffs
> 2:  0b4dabebe1 ! 2:  4ad160ab1f userdiff: add and use struct external_diff
>      @@ diff.c
>       @@ diff.c: static int diff_color_moved_ws_default;
>        static int diff_context_default = 3;
>        static int diff_interhunk_context_default;
>      - static const char *diff_word_regex_cfg;
>      --static const char *external_diff_cmd_cfg;
>      + static char *diff_word_regex_cfg;
>      +-static char *external_diff_cmd_cfg;
>       +static struct external_diff external_diff_cfg;
>      - static const char *diff_order_file_cfg;
>      + static char *diff_order_file_cfg;
>        int diff_auto_refresh_index = 1;
>        static int diff_mnemonic_prefix;
>       @@ diff.c: int git_diff_ui_config(const char *var, const char *value,
>      @@ userdiff.h: struct userdiff_funcname {
>        };
> 
>       +struct external_diff {
>      -+	const char *cmd;
>      ++	char *cmd;
>       +};
>       +
>        struct userdiff_driver {
>        	const char *name;
>      --	const char *external;
>      +-	char *external;
>       +	struct external_diff external;
>      - 	const char *algorithm;
>      + 	char *algorithm;
>        	int binary;
>        	struct userdiff_funcname funcname;
> 3:  4d54ca8281 ! 3:  29c8d3b61a diff: let external diffs report that changes are uninteresting
>      @@ Commit message
>           diff is not able to report empty diffs.  We can only do that check after
>           evaluating the file-specific attributes in run_external_diff().
> 
>      +    If we do run the external diff with --quiet, send its output to
>      +    /dev/null.
>      +
>           I considered checking the output of the external diff to check whether
>           its empty.  It was added as 11be65cfa4 (diff: fix --exit-code with
>           external diff, 2024-05-05) and quickly reverted, as it does not work
>      @@ Documentation/config/diff.txt: diff.external::
>        	your files, you might want to use linkgit:gitattributes[5] instead.
> 
>       +diff.trustExitCode::
>      -+	If this boolean value is set to true then the `diff.external`
>      -+	command is expected to return exit code 1 if it finds
>      -+	significant changes and 0 if it doesn't, like diff(1).  If it's
>      -+	false then the `diff.external` command is expected to always
>      -+	return exit code 0.  Defaults to false.
>      ++	If this boolean value is set to true then the
>      ++	`diff.external` command is expected to return exit code
>      ++	0 if it considers the input files to be equal or 1 if it
>      ++	considers them to be different, like `diff(1)`.
>      ++	If it is set to false, which is the default, then the command
>      ++	is expected to return exit code 0 regardless of equality.
>      ++	Any other exit code causes Git to report a fatal error.
>       +
>        diff.ignoreSubmodules::
>        	Sets the default value of --ignore-submodules. Note that this
>      @@ Documentation/config/diff.txt: diff.<driver>.command::
>       +diff.<driver>.trustExitCode::
>       +	If this boolean value is set to true then the
>       +	`diff.<driver>.command` command is expected to return exit code
>      -+	1 if it finds significant changes and 0 if it doesn't, like
>      -+	diff(1).  If it's false then the `diff.external` command is
>      -+	expected to always return exit code 0.  Defaults to false.
>      ++	0 if it considers the input files to be equal or 1 if it
>      ++	considers them to be different, like `diff(1)`.
>      ++	If it is set to false, which is the default, then the command
>      ++	is expected to return exit code 0 regardless of equality.
>      ++	Any other exit code causes Git to report a fatal error.
>       +
>        diff.<driver>.xfuncname::
>        	The regular expression that the diff driver should use to
>        	recognize the hunk header.  A built-in pattern may also be used.
> 
>      + ## Documentation/diff-options.txt ##
>      +@@ Documentation/diff-options.txt: ifndef::git-log[]
>      +
>      + --quiet::
>      + 	Disable all output of the program. Implies `--exit-code`.
>      +-	Disables execution of external diff helpers.
>      ++	Disables execution of external diff helpers whose exit code
>      ++	is not trusted, i.e. their respective configuration option
>      ++	`diff.trustExitCode` or `diff.<driver>.trustExitCode` or
>      ++	environment variable `GIT_EXTERNAL_DIFF_TRUST_EXIT_CODE` is
>      ++	false.
>      + endif::git-log[]
>      + endif::git-format-patch[]
>      +
>      +
>        ## Documentation/git.txt ##
>       @@ Documentation/git.txt: parameter, <path>.
>        For each path `GIT_EXTERNAL_DIFF` is called, two environment variables,
>        `GIT_DIFF_PATH_COUNTER` and `GIT_DIFF_PATH_TOTAL` are set.
> 
>       +`GIT_EXTERNAL_DIFF_TRUST_EXIT_CODE`::
>      -+	Setting this environment variable indicates the the program
>      -+	specified with `GIT_EXTERNAL_DIFF` returns exit code 1 if it
>      -+	finds significant changes and 0 if it doesn't, like diff(1).
>      -+	If it's not set, the program is expected to always return
>      -+	exit code 0.
>      ++	If this Boolean environment variable is set to true then the
>      ++	`GIT_EXTERNAL_DIFF` command is expected to return exit code
>      ++	0 if it considers the input files to be equal or 1 if it
>      ++	considers them to be different, like `diff(1)`.
>      ++	If it is set to false, which is the default, then the command
>      ++	is expected to return exit code 0 regardless of equality.
>      ++	Any other exit code causes Git to report a fatal error.
>      ++
>       +
>        `GIT_DIFF_PATH_COUNTER`::
>        	A 1-based counter incremented by one for every path.
>      @@ diff.c: static void run_external_diff(const struct external_diff *pgm,
>        {
>        	struct child_process cmd = CHILD_PROCESS_INIT;
>        	struct diff_queue_struct *q = &diff_queued_diff;
>      ++	int quiet = !(o->output_format & DIFF_FORMAT_PATCH);
>       +	int rc;
>       +
>       +	/*
>      @@ diff.c: static void run_external_diff(const struct external_diff *pgm,
>       +	 * external diff program lacks the ability to tell us whether
>       +	 * it's empty then we consider it non-empty without even asking.
>       +	 */
>      -+	if (!(o->output_format & DIFF_FORMAT_PATCH) && !pgm->trust_exit_code) {
>      ++	if (!pgm->trust_exit_code && quiet) {
>       +		o->found_changes = 1;
>       +		return;
>       +	}
>      @@ diff.c: static void run_external_diff(const struct external_diff *pgm,
>        	diff_free_filespec_data(two);
>        	cmd.use_shell = 1;
>       -	if (run_command(&cmd))
>      ++	cmd.no_stdout = quiet;
>       +	rc = run_command(&cmd);
>      -+	if ((!pgm->trust_exit_code && !rc) || (pgm->trust_exit_code && rc == 1))
>      ++	if (!pgm->trust_exit_code && rc == 0)
>      ++		o->found_changes = 1;
>      ++	else if (pgm->trust_exit_code && rc == 0)
>      ++		; /* nothing */
>      ++	else if (pgm->trust_exit_code && rc == 1)
>       +		o->found_changes = 1;
>      -+	else if (!pgm->trust_exit_code || rc)
>      ++	else
>        		die(_("external diff died, stopping at %s"), name);
> 
>        	remove_tempfile();
>      @@ diff.c: void diff_setup_done(struct diff_options *options)
>        	if (options->flags.follow_renames)
> 
>        ## t/t4020-diff-external.sh ##
>      -@@ t/t4020-diff-external.sh: test_expect_success 'no diff with -diff' '
>      - check_external_exit_code () {
>      - 	expect_code=$1
>      - 	command_code=$2
>      --	option=$3
>      -+	trust_exit_code=$3
>      -+	option=$4
>      -
>      - 	command="exit $command_code;"
>      +@@ t/t4020-diff-external.sh: check_external_diff () {
>      + 	expect_out=$2
>      + 	expect_err=$3
>      + 	command_code=$4
>      +-	shift 4
>      ++	trust_exit_code=$5
>      ++	shift 5
>      + 	options="$@"
>      +
>      + 	command="echo output; exit $command_code;"
>       -	desc="external diff '$command'"
>       +	desc="external diff '$command' with trustExitCode=$trust_exit_code"
>      + 	with_options="${options:+ with }$options"
> 
>      - 	test_expect_success "$desc via attribute with $option" "
>      + 	test_expect_success "$desc via attribute$with_options" "
>        		test_config diff.foo.command \"$command\" &&
>       +		test_config diff.foo.trustExitCode $trust_exit_code &&
>        		echo \"file diff=foo\" >.gitattributes &&
>      - 		test_expect_code $expect_code git diff $option
>      - 	"
>      + 		test_expect_code $expect_code git diff $options >out 2>err &&
>      + 		test_cmp $expect_out out &&
>      +@@ t/t4020-diff-external.sh: check_external_diff () {
> 
>      - 	test_expect_success "$desc via diff.external with $option" "
>      + 	test_expect_success "$desc via diff.external$with_options" "
>        		test_config diff.external \"$command\" &&
>       +		test_config diff.trustExitCode $trust_exit_code &&
>        		>.gitattributes &&
>      - 		test_expect_code $expect_code git diff $option
>      - 	"
>      -@@ t/t4020-diff-external.sh: check_external_exit_code () {
>      + 		test_expect_code $expect_code git diff $options >out 2>err &&
>      + 		test_cmp $expect_out out &&
>      +@@ t/t4020-diff-external.sh: check_external_diff () {
>        		>.gitattributes &&
>        		test_expect_code $expect_code env \
>        			GIT_EXTERNAL_DIFF=\"$command\" \
>       +			GIT_EXTERNAL_DIFF_TRUST_EXIT_CODE=$trust_exit_code \
>      - 			git diff $option
>      - 	"
>      - }
>      -
>      --check_external_exit_code   1 0 --exit-code
>      --check_external_exit_code   1 0 --quiet
>      --check_external_exit_code 128 1 --exit-code
>      --check_external_exit_code   1 1 --quiet # we don't even call the program
>      -+check_external_exit_code   1 0 off --exit-code
>      -+check_external_exit_code   1 0 off --quiet
>      -+check_external_exit_code 128 1 off --exit-code
>      -+check_external_exit_code   1 1 off --quiet # we don't even call the program
>      + 			git diff $options >out 2>err &&
>      + 		test_cmp $expect_out out &&
>      + 		test_cmp $expect_err err
>      +@@ t/t4020-diff-external.sh: test_expect_success 'setup output files' '
>      + 	echo "fatal: external diff died, stopping at file" >error
>      + '
>      +
>      +-check_external_diff   0 output empty 0
>      +-check_external_diff 128 output error 1
>      +-
>      +-check_external_diff   1 output empty 0 --exit-code
>      +-check_external_diff 128 output error 1 --exit-code
>      +-
>      +-check_external_diff   1 empty  empty 0 --quiet
>      +-check_external_diff   1 empty  empty 1 --quiet # we don't even call the program
>      ++check_external_diff   0 output empty 0 off
>      ++check_external_diff 128 output error 1 off
>      ++check_external_diff   0 output empty 0 on
>      ++check_external_diff   0 output empty 1 on
>      ++check_external_diff 128 output error 2 on
>      ++
>      ++check_external_diff   1 output empty 0 off --exit-code
>      ++check_external_diff 128 output error 1 off --exit-code
>      ++check_external_diff   0 output empty 0 on  --exit-code
>      ++check_external_diff   1 output empty 1 on  --exit-code
>      ++check_external_diff 128 output error 2 on  --exit-code
>       +
>      -+check_external_exit_code   0 0 on --exit-code
>      -+check_external_exit_code   0 0 on --quiet
>      -+check_external_exit_code   1 1 on --exit-code
>      -+check_external_exit_code   1 1 on --quiet
>      -+check_external_exit_code 128 2 on --exit-code
>      -+check_external_exit_code 128 2 on --quiet
>      ++check_external_diff   1 empty  empty 0 off --quiet
>      ++check_external_diff   1 empty  empty 1 off --quiet # we don't even call the program
>      ++check_external_diff   0 empty  empty 0 on  --quiet
>      ++check_external_diff   1 empty  empty 1 on  --quiet
>      ++check_external_diff 128 empty  error 2 on  --quiet
> 
>        echo NULZbetweenZwords | perl -pe 'y/Z/\000/' > file
> 
>      @@ userdiff.h
>       @@ userdiff.h: struct userdiff_funcname {
> 
>        struct external_diff {
>      - 	const char *cmd;
>      + 	char *cmd;
>       +	unsigned trust_exit_code:1;
>        };
> 
> --
> 2.45.2
