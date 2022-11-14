Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C7EC4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 16:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbiKNQ6m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 11:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238085AbiKNQ60 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 11:58:26 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D21C2F650
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 08:57:13 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id f27so29912616eje.1
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 08:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fHTvopFmN+Ecs3Tb2vag3HXb5ZQCvRVF/65AzBR9xOY=;
        b=KivnpsNav8YXOt2fwPc63Ww7r9JNFAtgqztkb0wceWEh7ZQJzbmzIS7pwDXycCYyPd
         sUwypZP7AXpnSAVrqLvbrturQoeQ6OWAWBwPvgkRMNLPVkVtwHwDo5l+QmXXpDbSPJTT
         mwkMsFs4xegpToX69Iq9Em/Q+5Cq71GN1if0N4dXSRme3WDleaPrmqKrdPNTf/uWwXEJ
         DH86H+ZCgTfJakPX1ESt/9UFv/enHBoVPx5ua3Uv+4jq+QcHopFPIugWOzKug6Byn/f3
         deaMgUAGv+FdIZXitF+jYYTZt0AxPhFnETuTgqHLZHJwjaUnX5oXy61HSkBLRGkRSbQ2
         2SrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHTvopFmN+Ecs3Tb2vag3HXb5ZQCvRVF/65AzBR9xOY=;
        b=m9WmFC2m7Uf4mmsG8VNkqiH6EOUt5yqGiUm8F3wUlvpnhO9vk2Oyu4aVV/gO5obQFP
         14DeQ0/d4WlNlz2k3rY5z0rlQ2yfEgKe0EVsv90RCqy9BGXyCRx4rorWIktExIjY7z4l
         45IirwvzumvN7G6tpbMF8eo+Mq8bd9UTV7uCDz6A5OaZC7fAnNz3nDYCpnaUw/B9AGHb
         InDZHZGp2zFu1We4LZHr1o6QxMpwfw/17sPQBMRweEPeFFKcNFxARZIc9hbEUdtJFUZh
         MLuMgaSzh+rHeAue8bBQTjdzA858tMrOPwaSPaHewmNlPwyv19QC/SPThorjyjuHd/zY
         3TMw==
X-Gm-Message-State: ANoB5pnJO4WFWCPNEjIhMeAHmseYJi5pPCI18hXb2MkfnpcY0jE0RwT7
        wWgH30QPfJBmTJYxCgMCzIPbWauvOD9lKQ==
X-Google-Smtp-Source: AA0mqf7ojtLLxyY2kbskhMI5WBe9+rqUQWyZtTPbXSCv5x8kR1fXpk4CSzzMnx4bjMsEqP+ino9xNQ==
X-Received: by 2002:a17:906:c299:b0:782:55de:4fcf with SMTP id r25-20020a170906c29900b0078255de4fcfmr10955138ejz.85.1668445031567;
        Mon, 14 Nov 2022 08:57:11 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id f4-20020a05640214c400b0045723aa48ccsm4964046edx.93.2022.11.14.08.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 08:57:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oucli-003Gkb-0U;
        Mon, 14 Nov 2022 17:57:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] format-patch: add --mboxrd alias for --pretty=mboxrd
Date:   Mon, 14 Nov 2022 17:53:40 +0100
References: <20221114094114.18986-1-e@80x24.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221114094114.18986-1-e@80x24.org>
Message-ID: <221114.86leodlbix.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 14 2022, Eric Wong wrote:

> mboxrd is a superior output format when used with --stdout and
> needs more exposure.  Including pretty-formats.txt would be
> excessive, since documenting --pretty= for `git format-patch'
> would likely be confusing to users.
>
> Instead of documenting --pretty, add an --mboxrd alias to save
> keystrokes and improve documentation.
>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  Also, --mboxrd without --stdout makes no sense to me,
>  so I'm considering warning on it...
>
>  Side note: some of the OPT_* switches might be misplaced
>  under the "Messaging" OPT_GROUP...

Makes sense, but....

> +--mboxrd::
> +	Use the robust "mboxrd" format with `--stdout` to escape
> +	"^>+From " lines.
> +

...Rather than repeat ourselves, shouldn't we (or in addition to this)
link to a manpage that discusses the --pretty=* formats. I was going to
say that you can also use the "ifdef" asciidoc syntax, but for one
paragraph that's probably overkill...

>  --attach[=<boundary>]::
>  	Create multipart/mixed attachment, the first part of
>  	which is the commit message and the patch itself in the
> diff --git a/builtin/log.c b/builtin/log.c
> index 5eafcf26b49b..13f5deb7a5c0 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1872,6 +1872,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	struct strbuf rdiff2 = STRBUF_INIT;
>  	struct strbuf rdiff_title = STRBUF_INIT;
>  	int creation_factor = -1;
> +	int mboxrd = 0;
>  
>  	const struct option builtin_format_patch_options[] = {
>  		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
> @@ -1883,6 +1884,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL('s', "signoff", &do_signoff, N_("add a Signed-off-by trailer")),
>  		OPT_BOOL(0, "stdout", &use_stdout,
>  			    N_("print patches to standard out")),
> +		OPT_BOOL(0, "mboxrd", &mboxrd,
> +			    N_("use the robust mboxrd format with --stdout")),
>  		OPT_BOOL(0, "cover-letter", &cover_letter,
>  			    N_("generate a cover letter")),
>  		OPT_BOOL(0, "numbered-files", &just_numbers,
> @@ -2106,6 +2109,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  				  rev.diffopt.close_file, "--output",
>  				  !!output_directory, "--output-directory");
>  
> +	/* should we warn on --mboxrd w/o --stdout? */

Does that go for --pretty=mboxrd too?

> +	if (mboxrd)
> +		rev.commit_format = CMIT_FMT_MBOXRD;
> +
>  	if (use_stdout) {
>  		setup_pager();
>  	} else if (!rev.diffopt.close_file) {
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index ba5c395d2d80..f6e2fbdcfa68 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1815,7 +1815,7 @@ _git_fetch ()
>  
>  __git_format_patch_extra_options="
>  	--full-index --not --all --no-prefix --src-prefix=
> -	--dst-prefix= --notes
> +	--dst-prefix= --notes --mboxrd
>  "
>  
>  _git_format_patch ()
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index de1da4673da9..69ed8b1ffaa1 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -2281,7 +2281,7 @@ test_expect_success 'format-patch --attach cover-letter only is non-multipart' '
>  	test_line_count = 1 output
>  '
>  
> -test_expect_success 'format-patch --pretty=mboxrd' '
> +test_expect_success 'format-patch --mboxrd' '
>  	sp=" " &&
>  	cat >msg <<-INPUT_END &&
>  	mboxrd should escape the body
> @@ -2316,7 +2316,9 @@ test_expect_success 'format-patch --pretty=mboxrd' '
>  	INPUT_END
>  
>  	C=$(git commit-tree HEAD^^{tree} -p HEAD <msg) &&
> -	git format-patch --pretty=mboxrd --stdout -1 $C~1..$C >patch &&
> +	git format-patch --mboxrd --stdout -1 $C~1..$C >patch &&
> +	git format-patch --pretty=mboxrd --stdout -1 $C~1..$C >compat &&
> +	test_cmp patch compat &&
>  	git grep -h --no-index -A11 \
>  		"^>From could trip up a loose mbox parser" patch >actual &&
>  	test_cmp expect actual
> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index cdad4b688078..9a128c16a6ee 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -1033,7 +1033,7 @@ test_expect_success 'am --patch-format=mboxrd handles mboxrd' '
>  	>From extra escape for reversibility
>  	INPUT_END
>  	git commit -F msg &&
> -	git format-patch --pretty=mboxrd --stdout -1 >mboxrd1 &&
> +	git format-patch --mboxrd --stdout -1 >mboxrd1 &&
>  	grep "^>From could trip up a loose mbox parser" mboxrd1 &&
>  	git checkout -f first &&
>  	git am --patch-format=mboxrd mboxrd1 &&

Doesn't this leave us without coverage for the --pretty=mboxrd variant?

I must admit I'm not a big outright fan of this, the "log-like" is
confusing enough, with those accepting some options, ignoring others
etc, now we're adding command-specific aliases too...

Why not just document that we accept --pretty=<some subset>? E.g. see
"range-diff"'s docs for an existing case where we discuss accepting a
limited subset.
