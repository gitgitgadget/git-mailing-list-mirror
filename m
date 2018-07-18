Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62C131F597
	for <e@80x24.org>; Wed, 18 Jul 2018 17:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbeGRSYF (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 14:24:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34943 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730487AbeGRSYD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 14:24:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id a3-v6so5519286wrt.2
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 10:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Rfy48yO6eerMXco6Jwnn+TO9fTRWv1cudKKRu9vqp4c=;
        b=Iya1FcAVW7hlq8VTrKq4/5lmtIvztKjKvNIMH28IjWau+PkEuZfn6JRTqT9yl4LlmS
         Y9DF5PAS1bygIFUKN9p/k62tImhM8iROhqNSs3fZPC9hC17ANpCuEljO9mOkVmmWryIm
         qhrB+eoWRGjrnt+40ZfWhQk52iwB9iParS15IyHeR4W6gFgpUffAlgLsTPPjvRPFEHdH
         klFMxMbmAu8R7V0BHmtGvacY7OpOnwcDDbUq3Jtt4ZOvzv2QYl3AHOKmqxRHKpWr4NP7
         /DmHvbfPznVP8sBMfIjBuJpXTwrJt2S4TZ25Ok/tz6fpTFJdlCvftrZdHvtZpt8LpXEK
         AX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Rfy48yO6eerMXco6Jwnn+TO9fTRWv1cudKKRu9vqp4c=;
        b=DjA8C4cZCYRZPKDGQeCQoKBZRWt46A+aLnlNIyyqrq8DnuEYtqNfrhn8KltYEUoF1A
         uZEr7RBMpQOYimgpSiWFYRmAqkiZ2fXsBSV/7kU+6nNFuIAGRJz9jutLtyy3VQDHflZf
         DUsV6eFI6PfDSIGf1jvvcXLbVQ6bwltcwNN78/OTariq98b/v8iEJmU5cg0QEFxlxfc/
         sjaemlUqcakx/+xruqWMgs40OJNigjT19DLp6ysWJ33VDMrKKPulW4LvKXStGqimK9C7
         w4D4HrVhI5V1CVCqLS1fhvxFgAhefl+VM3QTLoYCeNVIq5GU2RtltpMaFfT3gYDMCrV+
         fl6A==
X-Gm-Message-State: AOUpUlGN8tDJycG3f3QyAvZ97yoXR7ZzRJutwUiXZ/OdlSMNO62lpciJ
        7PzilrXudaZBelddBSetlSk=
X-Google-Smtp-Source: AAOMgpe1xiciPZQWuOrRNyjldYURFyG7AP4qfyl4ZJqgFJyEHMEpEzyEi4Fcsaf0vgMEbuYZdIuFhQ==
X-Received: by 2002:adf:8276:: with SMTP id 109-v6mr5264017wrb.127.1531935904005;
        Wed, 18 Jul 2018 10:45:04 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g15-v6sm7469168wrh.48.2018.07.18.10.45.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 10:45:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff.c: offer config option to control ws handling in move detection
References: <20180718005311.136329-1-sbeller@google.com>
Date:   Wed, 18 Jul 2018 10:45:02 -0700
In-Reply-To: <20180718005311.136329-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 17 Jul 2018 17:53:11 -0700")
Message-ID: <xmqqy3e8jv4x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 143acd9417e..8da7fed4e22 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -294,8 +294,11 @@ dimmed_zebra::
>  
>  --color-moved-ws=<modes>::
>  	This configures how white spaces are ignored when performing the
> -	move detection for `--color-moved`. These modes can be given
> -	as a comma separated list:
> +	move detection for `--color-moved`.
> +ifdef::git-diff[]
> +	It can be set by the `diff.colorMovedWS` configuration setting.
> +endif::git-diff[]

The patch to diff.c::git_diff_ui_config() we see below does not seem
to make any effort to make sure that this new configuration applies
only to "git diff" and that other commands like "git log" that call
git_diff_ui_config() are not affected.

And I do not see a strong reason why "git log --color-moved" should
not honor this setting, either, so I am not quite sure why we want
this ifdef/endif pair to hide it from "git log --help".

Or am I totally misunderstanding the reason why we want ifdef/endif
here?

Puzzled...

> diff --git a/diff.c b/diff.c
> index f51f0ac32f4..9de917108d8 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -35,6 +35,7 @@ static int diff_rename_limit_default = 400;
>  static int diff_suppress_blank_empty;
>  static int diff_use_color_default = -1;
>  static int diff_color_moved_default;
> +static int diff_color_moved_ws_default;
>  static int diff_context_default = 3;
>  static int diff_interhunk_context_default;
>  static const char *diff_word_regex_cfg;
> @@ -332,6 +333,13 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>  		diff_color_moved_default = cm;
>  		return 0;
>  	}
> +	if (!strcmp(var, "diff.colormovedws")) {
> +		int cm = parse_color_moved_ws(value);
> +		if (cm < 0)
> +			return -1;
> +		diff_color_moved_ws_default = cm;
> +		return 0;
> +	}
>  	if (!strcmp(var, "diff.context")) {
>  		diff_context_default = git_config_int(var, value);
>  		if (diff_context_default < 0)
> @@ -4327,6 +4335,7 @@ void diff_setup(struct diff_options *options)
>  	}
>  
>  	options->color_moved = diff_color_moved_default;
> +	options->color_moved_ws_handling = diff_color_moved_ws_default;
>  }
>  
>  void diff_setup_done(struct diff_options *options)
