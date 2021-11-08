Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1E1C433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 23:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F000D619BB
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 23:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240360AbhKHXGt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 18:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238462AbhKHXGs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 18:06:48 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69002C061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 15:04:03 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id v65so20911586ioe.5
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 15:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xvJb7L/xSdwfSKKPnnJPqH5yTyfsPHjIdgQJlS5E80I=;
        b=QOJCbCP6Go/opqmNJBWO9QfQs9EVyrudWUeQCoKLuzxRPSsqQxO991R/gB8BQEohj1
         BOlbHeH+5TWs5e7rln59em48S5dBHhSxmqKf9dsEYR0RsDrfLtQ+S13EMpKGBCKs04ny
         IQ0LwKihJWrXzmsZvvVQZAtVfvgDlDU5vMM+EiTSD92ADsef5yTiw6Ros2GjHHf/+yFj
         ANQXX74u36slTZYrrMuJj9KGBEXRLSicdABUB+hq6IKUtA8djPyxutTO/agXOn4hnExX
         wY9eu70xN8vaR+F01tfeRufrAHNu59MO36dz3aLwnrLhjnux0MdBzf7IK9JDQ5+V0TBf
         rv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xvJb7L/xSdwfSKKPnnJPqH5yTyfsPHjIdgQJlS5E80I=;
        b=WrCQcucGxdR7L5py+ZiKlWkaz6LzfpWVfYVqnb6n82EgrxtOTTHA1TXm2GKvYB8m4t
         CzkNKtFDkOvpATcrBh3DQU+WCDpr+4I6x8ZXJmhDgArC9LbLdGIEq212VDBnxR0e9dtX
         HcGa1+vqf07lvNONZ+Uq+BkNwzexPX5xnVNm9ozBweXMzSgzc0YvLK/P9akbf0xO11/Q
         3gl+o4B6jKBROC3Sl86Rl1Lu+at8/wXFY2f4DZk4W1OZCLuE4md7OAbJlzjK2+ipV2mi
         y858ODvEgu73Z1G3kldRrl2eoc8Z/QPwYA2O/mIaqs0B6EfDhoMqWDWXB+uRZW/rAb9g
         kDvg==
X-Gm-Message-State: AOAM5323BqMf2B5GuqgskVGs3A/FUwNKNopqvm700GFwZZoIKc2M0lYS
        zlPtui216JtbFXXRzMlLVizQCg==
X-Google-Smtp-Source: ABdhPJxbrhZ0ygIdpC9RPqe4XQUDuzUVxcfLlVZWjO4lfVpfvFLh1YQ2KrnjENvqICylTucWg/VHaw==
X-Received: by 2002:a6b:2ccf:: with SMTP id s198mr1773550ios.101.1636412642815;
        Mon, 08 Nov 2021 15:04:02 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r3sm191732iob.0.2021.11.08.15.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 15:04:02 -0800 (PST)
Date:   Mon, 8 Nov 2021 18:04:01 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        J Smith <dark.panda@gmail.com>
Subject: Re: [PATCH 7/8] grep: simplify config parsing, change grep.<rx
 config> interaction
Message-ID: <YYms4czKVnQFWYQ+@nand.local>
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
 <patch-7.8-677a8f8520f-20211106T210711Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-7.8-677a8f8520f-20211106T210711Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 06, 2021 at 10:10:53PM +0100, Ævar Arnfjörð Bjarmason wrote:
> I.e. a user would correctly expect this to keep working:
>
>     # ERE grep
>     git -c grep.extendedRegexp=true grep <pattern>
>
> And likewise for "grep.patternType=default" to take precedence over
> the disfavored "grep.extendedRegexp" option, i.e. the usual "last set
> wins" semantics.
>
>     # BRE grep
>     git -c grep.extendedRegexp=true -c grep.patternType=basic grep <pattern>
>
> But probably not for this to ignore the new "grep.patternType" option
> entirely, say if /etc/gitconfig was still setting
> "grep.extendedRegexp", but "~/.gitconfig" used the new
> "grep.patternType" (and wanted to use the "default" value):
>
>     # Was ERE, now BRE
>     git -c grep.extendedRegexp=true grep.patternType=default grep <pattern>

OK, so this is the case that we'd be "breaking". And I think that the
new behavior you're outlining here (where a higher-precedence
grep.patternType=default overrides a lower-precedence
grep.extendedRegexp=true, resulting in using BRE over ERE) makes more
sense.

At least, it makes more sense if your expectation of "default" is "the
default matching behavior", not "fallthrough to grep.extendedRegexp".

In any case, I am sensitive to breaking existing user workflows, but
this seems so obscure to me that I have a hard time expecting that
m(any?) users will even notice this at all.

The situation I'm most concerned about is having grep.extendedRegexp set
in, say, /etc/gitconfig and grep.patternType=default set at a
higher-precedence level.

> ---
>  Documentation/config/grep.txt |  3 +-
>  Documentation/git-grep.txt    |  3 +-

Not the fault of your patch, but these two are annoyingly (and subtly)
different from one another. Could we clean this up and put everything in
Documentation/config/grep.txt (and then include that in the
CONFIGURATION section of Documentation/git-grep.txt)?

>  builtin/grep.c                | 10 ++---
>  grep.c                        | 71 +++++------------------------------
>  grep.h                        |  6 +--
>  revision.c                    |  2 -
>  t/t7810-grep.sh               |  2 +-
>  7 files changed, 17 insertions(+), 80 deletions(-)
>
> diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
> index 44abe45a7ca..2669b1757d3 100644
> --- a/Documentation/config/grep.txt
> +++ b/Documentation/config/grep.txt
> @@ -12,8 +12,7 @@ grep.patternType::
>
>  grep.extendedRegexp::
>  	If set to true, enable `--extended-regexp` option by default. This
> -	option is ignored when the `grep.patternType` option is set to a value
> -	other than 'default'.
> +	option is ignored when the `grep.patternType` option is set.
>
>  grep.threads::
>  	Number of grep worker threads to use.
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 3d393fbac1b..078dfeadf50 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -348,8 +348,7 @@ grep.patternType::
>
>  grep.extendedRegexp::
>  	If set to true, enable `--extended-regexp` option by default. This
> -	option is ignored when the `grep.patternType` option is set to a value
> -	other than 'default'.
> +	option is ignored when the `grep.patternType` option is set.

Makes sense, and matches your description.

> diff --git a/grep.c b/grep.c
> index fb3f63c63ef..dda8e536fe3 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -60,8 +60,10 @@ int grep_config(const char *var, const char *value, void *cb)
>  	if (userdiff_config(var, value) < 0)
>  		return -1;
>
> -	if (!strcmp(var, "grep.extendedregexp")) {
> -		opt->extended_regexp_option = git_config_bool(var, value);
> +	if (opt->pattern_type_option == GREP_PATTERN_TYPE_UNSPECIFIED &&
> +	    !strcmp(var, "grep.extendedregexp") &&
> +	    git_config_bool(var, value)) {
> +		opt->pattern_type_option = GREP_PATTERN_TYPE_ERE;
>  		return 0;
>  	}

And here's our "as long as we haven't set the pattern type already via
grep.patternType, allow grep.extendedRegexp to set it". But the same
"only set when unspecified" condition *isn't* in place for
grep.patternType, which is what makes us prefer values from that
configuration over the other. Makes sense.

Everything else looks good here, too.

Thanks,
Taylor
