Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC62C433E0
	for <git@archiver.kernel.org>; Sat, 16 May 2020 18:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F3652076A
	for <git@archiver.kernel.org>; Sat, 16 May 2020 18:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5Bzz5bd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgEPSdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 14:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726238AbgEPSdq (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 14:33:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A648C061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 11:33:46 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i15so7102820wrx.10
        for <git@vger.kernel.org>; Sat, 16 May 2020 11:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3GY5TvCVNtVGm4yYi9JfRL2mjyrvX4wXav+dvTC5qO8=;
        b=L5Bzz5bdAGMd5n09+Z+2robKeF13N5cmTa7TWadP+OHHph5fqAOXCBlpMHkfroX4YG
         pOPsbByJajW5Dr/6yxG7B0RN6lv+y052Jd7NzvJaarLS+veIwx024c3wJ3u9we7YjVQ7
         DDhONWjnNRBKf/OFrHX/dKuO9PnzwIpKu7oAM/ING8k2RvQf0KmhqnRdRTc+Ni2mR9VO
         VAeCupIA9spM84mv38x9kAeNqlOSDMpUxJuC24zM4ePRBCCHUwvN4O0pmGghItmUfZfK
         M2OZQ1RTQUvdznhgWokqyVFR1k0943SLm/ZeY7hE5hgPGTbbcAtP2eUHON5gJO0M2KmI
         LUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3GY5TvCVNtVGm4yYi9JfRL2mjyrvX4wXav+dvTC5qO8=;
        b=ZGerI19tW39L3txpTXOF6CR6t0uqhS9rMsW2XVMr+/sZ0sLmr5LxiROFu6gEyHzv4e
         32U6D9OP766Prni9wR914b2/k2Cj1V+X7XlMV1bEFP0f/BAZx8o/HCcR4hpYbGtmDqzN
         epCDj+6fso4PSz1TzRoBx7hs2rBMHHAPHI8nWY73OLJWZ9LTZLbWI2vGlKVgVAWP2TXb
         Tc1DakJ5XbAf/uqLFjZ8fFU5kSSzjEOUEGejzx7r1/aFGTxVJblndIWariM9UtVvQmwY
         g/h/mjRBcDxia9OaGcdL/JEjNZV4e9oqyHzmRWQNPEz8xEZGjNpcnlK+y5zmityqTp2J
         3rPg==
X-Gm-Message-State: AOAM5332TCvHVyaT04o+pBulb+Q8fIAxdV21PYUWmPEU9no4HTh0K6Tf
        dXNr/mTDg271GrR5w2mHtY9FTBlD
X-Google-Smtp-Source: ABdhPJxAdZY4brmneUGVm0Vnp0FrzsjmsYoPLyf74lu79hNpGj+Op7tapX2IrJ6bi2tZWrTbyZsJlw==
X-Received: by 2002:a5d:6a8c:: with SMTP id s12mr11065100wru.345.1589654024269;
        Sat, 16 May 2020 11:33:44 -0700 (PDT)
Received: from [192.168.1.240] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id q5sm9574319wra.36.2020.05.16.11.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 11:33:43 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] diff: add config option relative
To:     Laurent Arnoud <laurent@spkdev.net>,
        Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20200515155706.GA1165062@spk-laptop>
 <20200515233130.GC6362@camp.crustytoothpaste.net>
 <xmqq1rnk923o.fsf@gitster.c.googlers.com> <20200516173828.GB34961@spk-laptop>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <92cb6302-09a8-6780-9398-890b1e766680@gmail.com>
Date:   Sat, 16 May 2020 19:33:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200516173828.GB34961@spk-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Laurent

On 16/05/2020 18:38, Laurent Arnoud wrote:
> The `diff.relative` boolean option set to `true` show only changes on
> the current directory and show relative pathnames to the current
> directory.
> 
> Teach --no-relative to override earlier --relative
> 
> Signed-off-by: Laurent Arnoud <laurent@spkdev.net>
> ---
>   Documentation/config/diff.txt   |  4 ++
>   Documentation/diff-options.txt  |  2 +
>   diff.c                          | 10 ++++
>   t/t9904-diff-relative-config.sh | 93 +++++++++++++++++++++++++++++++++
>   4 files changed, 109 insertions(+)
>   create mode 100755 t/t9904-diff-relative-config.sh
> 
> diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
> index ff09f1cf73..76537c3b0c 100644
> --- a/Documentation/config/diff.txt
> +++ b/Documentation/config/diff.txt
> @@ -105,6 +105,10 @@ diff.mnemonicPrefix::
>   diff.noprefix::
>   	If set, 'git diff' does not show any source or destination prefix.
> 
> +diff.relative::
> +	If set to "true", 'git diff' does not show changes outside of the directory
> +	and show pathnames relative to the current directory.
> +
>   diff.orderFile::
>   	File indicating how to order files within a diff.
>   	See the '-O' option to linkgit:git-diff[1] for details.
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index bb31f0c42b..fdc5aefa37 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -651,6 +651,8 @@ ifndef::git-format-patch[]
>   	not in a subdirectory (e.g. in a bare repository), you
>   	can name which subdirectory to make the output relative
>   	to by giving a <path> as an argument.
> +--no-relative::
> +	Turn off relative pathnames and include all changes in the repository.

It might be helpful to mention that this is the default and this option 
exists to override the config setting

>   endif::git-format-patch[]
> 
>   -a::
> diff --git a/diff.c b/diff.c
> index d1ad6a3c4a..c4dcf01ec0 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -48,6 +48,7 @@ static const char *diff_order_file_cfg;
>   int diff_auto_refresh_index = 1;
>   static int diff_mnemonic_prefix;
>   static int diff_no_prefix;
> +static int diff_relative;
>   static int diff_stat_graph_width;
>   static int diff_dirstat_permille_default = 30;
>   static struct diff_options default_diff_options;
> @@ -386,6 +387,10 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>   		diff_no_prefix = git_config_bool(var, value);
>   		return 0;
>   	}
> +	if (!strcmp(var, "diff.relative")) {
> +		diff_relative = git_config_bool(var, value);
> +		return 0;
> +	}
>   	if (!strcmp(var, "diff.statgraphwidth")) {
>   		diff_stat_graph_width = git_config_int(var, value);
>   		return 0;
> @@ -4558,6 +4563,8 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
>   		options->b_prefix = "b/";
>   	}
> 
> +	options->flags.relative_name = diff_relative;
> +
>   	options->color_moved = diff_color_moved_default;
>   	options->color_moved_ws_handling = diff_color_moved_ws_default;
> 
> @@ -5494,6 +5501,9 @@ static void prep_parse_options(struct diff_options *options)
>   			       N_("when run from subdir, exclude changes outside and show relative paths"),
>   			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
>   			       diff_opt_relative),
> +		OPT_SET_INT_F(0, "no-relative", &options->flags.relative_name,
> +			      N_("disable diff.relative config option"),
> +			      0, PARSE_OPT_NONEG),

Rather than adding a new option, it would be better to modify the 
existing --relative option. If you remove PARSE_OPT_NONEG from the 
declaration above it will support --no-relative. You will also need to 
modify diff_opt_relative() to handle clearing the option.

Best Wishes

Phillip

>   		OPT_BOOL('a', "text", &options->flags.text,
>   			 N_("treat all files as text")),
>   		OPT_BOOL('R', NULL, &options->flags.reverse_diff,
> diff --git a/t/t9904-diff-relative-config.sh b/t/t9904-diff-relative-config.sh
> new file mode 100755
> index 0000000000..23ab1af5e0
> --- /dev/null
> +++ b/t/t9904-diff-relative-config.sh
> @@ -0,0 +1,93 @@
> +#!/bin/sh
> +
> +test_description='config diff.relative'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	git commit --allow-empty -m empty &&
> +	echo content >file1 &&
> +	mkdir subdir &&
> +	echo other content >subdir/file2 &&
> +	git add . &&
> +	git commit -m one
> +'
> +
> +check_diff_relative () {
> +	dir=$1
> +	shift
> +	expect=$1
> +	shift
> +	relative_opt=$1
> +	shift
> +	short_blob=$(git rev-parse --short "$(git hash-object subdir/file2)")
> +	cat >expected <<-EOF
> +	diff --git a/$expect b/$expect
> +	new file mode 100644
> +	index 0000000..$short_blob
> +	--- /dev/null
> +	+++ b/$expect
> +	@@ -0,0 +1 @@
> +	+other content
> +	EOF
> +	test_expect_success "config.relative $relative_opt -p $*" "
> +		test_config -C $dir diff.relative $relative_opt &&
> +		git -C '$dir' diff -p $* HEAD^ >actual &&
> +		test_cmp expected actual
> +	"
> +}
> +
> +check_diff_no_relative () {
> +	dir=$1
> +	shift
> +	expect=$1
> +	shift
> +	relative_opt=$1
> +	shift
> +	short_blob_file1=$(git rev-parse --short "$(git hash-object file1)")
> +	short_blob_file2=$(git rev-parse --short "$(git hash-object subdir/file2)")
> +	cat >expected <<-EOF
> +	diff --git a/file1 b/file1
> +	new file mode 100644
> +	index 0000000..$short_blob_file1
> +	--- /dev/null
> +	+++ b/file1
> +	@@ -0,0 +1 @@
> +	+content
> +	diff --git a/$expect b/$expect
> +	new file mode 100644
> +	index 0000000..$short_blob_file2
> +	--- /dev/null
> +	+++ b/$expect
> +	@@ -0,0 +1 @@
> +	+other content
> +	EOF
> +	cat expected
> +	test_expect_success "config.relative $relative_opt -p $*" "
> +		test_config -C $dir diff.relative $relative_opt &&
> +		git -C '$dir' diff -p $* HEAD^ >actual &&
> +		git -C '$dir' diff -p $* HEAD^ >/tmp/actual &&
> +		test_cmp expected actual
> +	"
> +}
> +
> +check_diff_relative . file2 false --relative=subdir/
> +check_diff_relative . file2 false --relative=subdir
> +check_diff_relative . file2 true --relative=subdir/
> +check_diff_relative . file2 true --relative=subdir
> +check_diff_relative subdir file2 false --relative
> +check_diff_relative subdir file2 true --relative
> +check_diff_relative subdir file2 true
> +check_diff_relative subdir file2 false --no-relative --relative
> +check_diff_relative subdir file2 true --no-relative --relative
> +check_diff_relative . file2 false --no-relative --relative=subdir
> +check_diff_relative . file2 true --no-relative --relative=subdir
> +
> +check_diff_no_relative . subdir/file2 false
> +check_diff_no_relative . subdir/file2 true --no-relative
> +check_diff_no_relative . subdir/file2 false --no-relative
> +check_diff_no_relative subdir subdir/file2 false
> +check_diff_no_relative subdir subdir/file2 true --no-relative
> +check_diff_no_relative subdir subdir/file2 false --no-relative
> +
> +test_done
> --
> 2.26.2
> 
