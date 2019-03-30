Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E01AA20248
	for <e@80x24.org>; Sat, 30 Mar 2019 09:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbfC3JMn (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 05:12:43 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46577 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729755AbfC3JMm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 05:12:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id d1so3993010edd.13
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 02:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=u8HWfSsNAtfKrsRQZ4pE7JePlEiDt3Cuv9U4lCywMSg=;
        b=gr4nh7kj/r7Pb0tj3buj8MvGcFYqjJulF8TUiCVsWbLBXs22zk/SR3c+dMakxxxm0N
         gO4FNnQOj3fg/+T0rxpk309I5JXUI05LBG2ti43NC76SfobvLyVK77dL8uPCsYtarkAb
         Qwuq+/Qr+Luz7FzxFHPiYbh+HwmgckH9L2ebAAGkLIStPkThayCbgc+3D3EzaktFtn6b
         X8OwNbgE1J33THJaMj+WB3+/PPBO3OeNek0hC1vPxSAg2d2EiY1DUx0wSLaVMVWdonte
         FzNDZXpLgeI4saFj6XsAZGDbxwqE7K+f/wsnkOIh8zoOqTIPIYgZjmAZma7g6sZhA6hz
         gCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=u8HWfSsNAtfKrsRQZ4pE7JePlEiDt3Cuv9U4lCywMSg=;
        b=p8Nk6RiBJQ8+IfYp6WkMNy+68v4W0s0VoPx2/+ZePwzLSJ3ikaEdolzVnMUCQ6BEo5
         dM2PcTRPkUTFMcPYeJG09qIGWijXHR5/8LCMVMeO9NUBWs0oqfJ9vk5ZZOd9g8pF8J5J
         k7/j6+ZI5uBe/X/rAAuRA7RdlhtPrdyX6V9iZdwj2lIcuXHWGeann9vNslN/wvRA6/IW
         M1wxijSj+ZB4OxvEG3VZhuvdkIOCMZLS0GCw9POXZTwAKpmxwzTe/3SSobrrd401wYx5
         SteFb8QeozNoxTnOQRUaiy5fbog40efL5rPvnIXK2HEQtdDPQD3mzuIldrsAkDHxzp5c
         ttAg==
X-Gm-Message-State: APjAAAUf+NBXjZMfbJpDIXfhYz3jSBl77exuiej2YHttXPbZUfoA/6eJ
        EGByXwxVQV2bwlCTPJJHDv8=
X-Google-Smtp-Source: APXvYqx+rRZ1WDA4YXHBYB3xozlTNOOXj0krOMN0zuieO/EPolLM2y5s2JahiwDQJx1stZZgzPCvGg==
X-Received: by 2002:a50:aa0f:: with SMTP id o15mr34926330edc.129.1553937160847;
        Sat, 30 Mar 2019 02:12:40 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id x45sm1342572edm.64.2019.03.30.02.12.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 02:12:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>
Subject: Re: [PATCH v2 15/15] merge-recursive: switch directory rename detection default
References: <20190306002744.14418-1-newren@gmail.com> <20190330003336.21940-1-newren@gmail.com> <20190330003336.21940-16-newren@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190330003336.21940-16-newren@gmail.com>
Date:   Sat, 30 Mar 2019 10:12:39 +0100
Message-ID: <87imw0afp4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 30 2019, Elijah Newren wrote:

I may have more, just quickly skimming this for the first time...

>  merge.renames::
> -	Whether and how Git detects renames.  If set to "false",
> -	rename detection is disabled. If set to "true", basic rename
> -	detection is enabled.  Defaults to the value of diff.renames.
> +	Whether Git detects renames.  If set to "false", rename detection
> +	is disabled. If set to "true", basic rename detection is enabled.
> +	Defaults to the value of diff.renames.
> [...]
> +	if (!git_config_get_string("merge.directoryrenames", &value)) {
> +		if (!strcasecmp(value, "true"))
> +			opt->detect_directory_renames = 2;
> +		else if (!strcasecmp(value, "false"))
> +			opt->detect_directory_renames = 0;
> +		else if (!strcasecmp(value, "conflict"))
> +			opt->detect_directory_renames = 1;
> +		else {
> +			error(_("Invalid value for merge.directoryRenames: %s"),
> +			      value);
> +			opt->detect_directory_renames = 1;
> +		}
> +		free(value);
> +	}

Instead of making your own true/false parser you can use
git_parse_maybe_bool(). See what we do for merge.ff:

    builtin/merge.c-617-    else if (!strcmp(k, "merge.ff")) {
    builtin/merge.c:618:            int boolval = git_parse_maybe_bool(v);
    builtin/merge.c-619-            if (0 <= boolval) {
    builtin/merge.c-620-                    fast_forward = boolval ? FF_ALLOW : FF_NO;
    builtin/merge.c-621-            } else if (v && !strcmp(v, "only")) {
    builtin/merge.c-622-                    fast_forward = FF_ONLY;
    builtin/merge.c-623-            } /* do not barf on values from future versions of git */
    builtin/merge.c-624-            return 0;

Small nit, but allows us to document "this config takse bool or ..."
without having different verions of "bool" in various places.

Also, I don't care personally, but this also violates the "if one thing
requires braces put it on all the if/else arms" in CodingGuidelines.
