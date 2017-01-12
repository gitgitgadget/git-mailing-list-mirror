Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A242E1FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 20:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751072AbdALU4R (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 15:56:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53184 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750967AbdALU4P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 15:56:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6002760DE5;
        Thu, 12 Jan 2017 15:56:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=umcyJ029rKLkcP1aImLw+8lnauU=; b=fDrAq0
        9RwSYE9ilDoEWynJbV6DT6X2YvNGADxBXDnozA+IWmWaYij6jE1BzkT+HRszxdqu
        kse1YNS3xtBS4lW2IjpsKJgdJLChw4pWXJ4VhtQ3xiF6W+TjVuSF56H/9288l6mD
        a/k6pQrBm/vvgNyqkIz+aRnRe5xuBSL1thcks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B7ZAbZLIzAUrGXVF1XZjOBCPnLdrn+HI
        BoLYiUBzrCDwBPU76MXOWmuyCBT0Zpt4gi71fFVxC9czTkRuhKuVxSbbWSNKI5+J
        AbCLHR13CPjTjY/YqI1RunDCPOdafC+fN245Uv1eRLLu094O7z9YNB3pU7GzjkXB
        Rfz4gPsS4BY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 57FB960DE4;
        Thu, 12 Jan 2017 15:56:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F97A60DE3;
        Thu, 12 Jan 2017 15:56:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v2] diff: add interhunk context config option
References: <1484223671-5476-1-git-send-email-vegard.nossum@oracle.com>
Date:   Thu, 12 Jan 2017 12:56:12 -0800
In-Reply-To: <1484223671-5476-1-git-send-email-vegard.nossum@oracle.com>
        (Vegard Nossum's message of "Thu, 12 Jan 2017 13:21:11 +0100")
Message-ID: <xmqq4m14j8ur.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8DAA2A78-D909-11E6-9073-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vegard Nossum <vegard.nossum@oracle.com> writes:

> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index 58f4bd6..d8cd854 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -60,6 +60,12 @@ diff.context::
>  	Generate diffs with <n> lines of context instead of the default
>  	of 3. This value is overridden by the -U option.
>  
> +diff.interHunkContext::
> +	Show the context between diff hunks, up to <n> lines, thereby
> +	fusing the hunks that are close to each other. The default is 0,
> +	meaning no fusing will occur. This value is overridden by the
> +	--inter-hunk-context option.

This is good if it were a description for
"--inter-hunk-context=<n>", but the text needs to be adjusted if it
were to be used for "diff.interHunkContext".  It is unclear how the
'<n>' the description refers to comes from.

I suspect that it would be sufficient to just revert the first
sentence to exactly match the way --inter-hunk-context=<lines> is
described.

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index e6215c3..a219aa2 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -511,6 +511,8 @@ endif::git-format-patch[]
>  --inter-hunk-context=<lines>::
>  	Show the context between diff hunks, up to the specified number
>  	of lines, thereby fusing hunks that are close to each other.
> +	Defaults to `diff.interHunkContext` or 0 if the config option
> +	is unset.

This one is good, but then "The default is 0, meaning no fusing will
occur." in "diff.interHunkContext" is misleading and unnecessary.
When "diff.interHunkContext" is not set, it simply is not set (as
opposed to having a default value of 0).

> diff --git a/t/t4032-diff-inter-hunk-context.sh b/t/t4032-diff-inter-hunk-context.sh
> index e4e3e28..d9ac9d1 100755
> --- a/t/t4032-diff-inter-hunk-context.sh
> +++ b/t/t4032-diff-inter-hunk-context.sh
> @@ -16,11 +16,15 @@ f() {
>  }
>  
>  t() {
> +	use_config=""

It is more customary to just say

	use_config=

All of the above are micronits that I can locally touch-up.  For
now, I'll queue the following.

-- >8 --
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Thu, 12 Jan 2017 13:21:11 +0100
Subject: [PATCH] diff: add interhunk context config option

The --inter-hunk-context= option was added in commit 6d0e674a5754
("diff: add option to show context between close hunks"). This patch
allows configuring a default for this option.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-config.txt      |  6 ++++++
 Documentation/diff-options.txt     |  2 ++
 diff.c                             |  8 ++++++++
 t/t4032-diff-inter-hunk-context.sh | 27 ++++++++++++++++++++++++++-
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index d8570f2a75..15521f5191 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -60,6 +60,12 @@ diff.context::
 	Generate diffs with <n> lines of context instead of the default
 	of 3. This value is overridden by the -U option.
 
+diff.interHunkContext::
+	Show the context between diff hunks, up to the specified number
+	of lines, thereby fusing the hunks that are close to each other.
+	This value serves as the default for the `--inter-hunk-context`
+	command line option.
+
 diff.external::
 	If this config variable is set, diff generation is not
 	performed using the internal diff machinery, but using the
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index e6215c372c..a219aa2907 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -511,6 +511,8 @@ endif::git-format-patch[]
 --inter-hunk-context=<lines>::
 	Show the context between diff hunks, up to the specified number
 	of lines, thereby fusing hunks that are close to each other.
+	Defaults to `diff.interHunkContext` or 0 if the config option
+	is unset.
 
 -W::
 --function-context::
diff --git a/diff.c b/diff.c
index e2eb6d66a9..f08cd8e033 100644
--- a/diff.c
+++ b/diff.c
@@ -32,6 +32,7 @@ static int diff_rename_limit_default = 400;
 static int diff_suppress_blank_empty;
 static int diff_use_color_default = -1;
 static int diff_context_default = 3;
+static int diff_interhunk_context_default;
 static const char *diff_word_regex_cfg;
 static const char *external_diff_cmd_cfg;
 static const char *diff_order_file_cfg;
@@ -239,6 +240,12 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 			return -1;
 		return 0;
 	}
+	if (!strcmp(var, "diff.interhunkcontext")) {
+		diff_interhunk_context_default = git_config_int(var, value);
+		if (diff_interhunk_context_default < 0)
+			return -1;
+		return 0;
+	}
 	if (!strcmp(var, "diff.renames")) {
 		diff_detect_rename_default = git_config_rename(var, value);
 		return 0;
@@ -3362,6 +3369,7 @@ void diff_setup(struct diff_options *options)
 	options->rename_limit = -1;
 	options->dirstat_permille = diff_dirstat_permille_default;
 	options->context = diff_context_default;
+	options->interhunkcontext = diff_interhunk_context_default;
 	options->ws_error_highlight = ws_error_highlight_default;
 	DIFF_OPT_SET(options, RENAME_EMPTY);
 
diff --git a/t/t4032-diff-inter-hunk-context.sh b/t/t4032-diff-inter-hunk-context.sh
index e4e3e28fc7..bada0cbd32 100755
--- a/t/t4032-diff-inter-hunk-context.sh
+++ b/t/t4032-diff-inter-hunk-context.sh
@@ -16,11 +16,15 @@ f() {
 }
 
 t() {
+	use_config=
+	git config --unset diff.interHunkContext
+
 	case $# in
 	4) hunks=$4; cmd="diff -U$3";;
 	5) hunks=$5; cmd="diff -U$3 --inter-hunk-context=$4";;
+	6) hunks=$5; cmd="diff -U$3"; git config diff.interHunkContext $4; use_config="(diff.interHunkContext=$4) ";;
 	esac
-	label="$cmd, $1 common $2"
+	label="$use_config$cmd, $1 common $2"
 	file=f$1
 	expected=expected.$file.$3.$hunks
 
@@ -89,4 +93,25 @@ t 9 lines	3		2
 t 9 lines	3	2	2
 t 9 lines	3	3	1
 
+#					use diff.interHunkContext?
+t 1 line	0	0	2	config
+t 1 line	0	1	1	config
+t 1 line	0	2	1	config
+t 9 lines	3	3	1	config
+t 2 lines	0	0	2	config
+t 2 lines	0	1	2	config
+t 2 lines	0	2	1	config
+t 3 lines	1	0	2	config
+t 3 lines	1	1	1	config
+t 3 lines	1	2	1	config
+t 9 lines	3	2	2	config
+t 9 lines	3	3	1	config
+
+test_expect_success 'diff.interHunkContext invalid' '
+	git config diff.interHunkContext asdf &&
+	test_must_fail git diff &&
+	git config diff.interHunkContext -1 &&
+	test_must_fail git diff
+'
+
 test_done
-- 
2.11.0-559-ge2476dcca1

