Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B71DE1FCA9
	for <e@80x24.org>; Sat, 10 Sep 2016 09:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752723AbcIJJlh (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Sep 2016 05:41:37 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:7467 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752375AbcIJJlg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Sep 2016 05:41:36 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e35:2ef1:f910:86a6:c8ff:fe05:d3e0])
        by smtp1-g21.free.fr (Postfix) with ESMTPS id D7331B0051E;
        Sat, 10 Sep 2016 11:41:28 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 04/13] i18n: blame: mark error messages for translation
Date:   Sat, 10 Sep 2016 11:41:28 +0200
Message-ID: <2532042.KMOOJ8STkh@cayenne>
User-Agent: KMail/5.2.3 (Linux/4.6.0-1-amd64; KDE/5.25.0; x86_64; ; )
In-Reply-To: <1473259758-11836-4-git-send-email-vascomalmeida@sapo.pt>
References: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt> <1473259758-11836-4-git-send-email-vascomalmeida@sapo.pt>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On mercredi 7 septembre 2016 14:49:08 CEST Vasco Almeida wrote:
> Mark error messages for translation passed to die() function.
> Change "Cannot" to lowercase following the usual style.
> 
> Reflect changes to test by using test_i18ngrep.
> 
> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> ---
>  builtin/blame.c               | 12 ++++++------
>  t/t8003-blame-corner-cases.sh |  4 ++--
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/builtin/blame.c b/builtin/blame.c
> index a5bbf91..3fee197 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2601,7 +2601,7 @@ int cmd_blame(int argc, const char **argv, const char
> *prefix)
> 
>  	if (incremental || (output_option & OUTPUT_PORCELAIN)) {
>  		if (show_progress > 0)
> -			die("--progress can't be used with --incremental or porcelain 
formats");
> +			die(_("--progress can't be used with --incremental or porcelain
> formats")); show_progress = 0;
>  	} else if (show_progress < 0)
>  		show_progress = isatty(2);
> @@ -2727,7 +2727,7 @@ int cmd_blame(int argc, const char **argv, const char
> *prefix) sb.commits.compare = compare_commits_by_commit_date;
>  	}
>  	else if (contents_from)
> -		die("--contents and --reverse do not blend well.");
> +		die(_("--contents and --reverse do not blend well."));
>  	else {
>  		final_commit_name = prepare_initial(&sb);
>  		sb.commits.compare = compare_commits_by_reverse_commit_date;
> @@ -2747,12 +2747,12 @@ int cmd_blame(int argc, const char **argv, const
> char *prefix) add_pending_object(&revs, &(sb.final->object), ":");
>  	}
>  	else if (contents_from)
> -		die("Cannot use --contents with final commit object name");
> +		die(_("cannot use --contents with final commit object name"));
> 
>  	if (reverse && revs.first_parent_only) {
>  		final_commit = find_single_final(sb.revs, NULL);
>  		if (!final_commit)
> -			die("--reverse and --first-parent together require specified latest
> commit"); +			die(_("--reverse and --first-parent together require
> specified latest commit")); }
> 
>  	/*
> @@ -2779,7 +2779,7 @@ int cmd_blame(int argc, const char **argv, const char
> *prefix) }
> 
>  		if (oidcmp(&c->object.oid, &sb.final->object.oid))
> -			die("--reverse --first-parent together require range along first-
parent
> chain"); +			die(_("--reverse --first-parent together require range along
> first-parent chain")); }
> 
>  	if (is_null_oid(&sb.final->object.oid)) {
> @@ -2820,7 +2820,7 @@ int cmd_blame(int argc, const char **argv, const char
> *prefix) &bottom, &top, sb.path))
>  			usage(blame_usage);
>  		if (lno < top || ((lno || bottom) && lno < bottom))
> -			die("file %s has only %lu lines", path, lno);
> +			die(_("file %s has only %lu lines"), path, lno);

Here a plural version is needed.

>  		if (bottom < 1)
>  			bottom = 1;
>  		if (top < 1)
> diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
> index e48370d..661f9d4 100755
> --- a/t/t8003-blame-corner-cases.sh
> +++ b/t/t8003-blame-corner-cases.sh
> @@ -212,12 +212,12 @@ EOF
> 
>  test_expect_success 'blame -L with invalid start' '
>  	test_must_fail git blame -L5 tres 2>errors &&
> -	grep "has only 2 lines" errors
> +	test_i18ngrep "has only 2 lines" errors
>  '
> 
>  test_expect_success 'blame -L with invalid end' '
>  	test_must_fail git blame -L1,5 tres 2>errors &&
> -	grep "has only 2 lines" errors
> +	test_i18ngrep "has only 2 lines" errors
>  '
> 
>  test_expect_success 'blame parses <end> part of -L' '


