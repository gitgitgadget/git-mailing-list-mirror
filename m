Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE6EC56201
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 23:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BD17206D8
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 23:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgKYXET (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 18:04:19 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:36032 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729433AbgKYXES (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 18:04:18 -0500
Received: by mail-ej1-f65.google.com with SMTP id lt17so139559ejb.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 15:04:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNSUJ2eBCtclwqKsbADgiOnBPl94ufWkTN36I+pCmvw=;
        b=OdYVUJzX7gowV6EeCte4lPVM5+xaWYcUj5I0CUZUqURsIodXmkTxO0Uz8HEgitWm9M
         h6Qy2Yv2mfsF5ZJur7z2thMQ5OznqJJTbHLkZE+eUzvTWzAnn0VQ817p09r7022lXqAE
         YeG+U78ZtQvrbD3WvUb/mieFGqO/l6ScDAc4fhrAZtwDazrIxuBU2ZRvDH6Zwzbp2QcV
         vW60Lr9W7T7KTSGv8zlmlineXEIDJtpICUyZXZPKdEHBXc7N6skCc3MNxKaA5yflBfKE
         ZUxV+UMkF/RLua5G78rKmcRfki4vAB/k8B2G2F4eWUHM5L/dvJnhCyBGBLgIO21Cfzj5
         oTog==
X-Gm-Message-State: AOAM533ifCsCsqxc0h1HVwbeqZHZz7EOK4MaeC2m7c2yOwfcfcOIcQDL
        3ELkzMyYKnWLS8GOPAo7mO9N5UvqU8nevL2LX2M=
X-Google-Smtp-Source: ABdhPJxWT4KgCYSii45U5FwpMUsJ2zLwqd5nayR2lb2bNgHaRM3GRrqe2SN5BZVh90A6oyqgobX9BY+zsnlu7IGwaqs=
X-Received: by 2002:a17:906:5587:: with SMTP id y7mr251897ejp.138.1606345456918;
 Wed, 25 Nov 2020 15:04:16 -0800 (PST)
MIME-Version: 1.0
References: <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
 <pull.796.v3.git.1606342376.gitgitgadget@gmail.com> <0c276ffcee4be302be3db9b43ab8371ef26a0aec.1606342377.git.gitgitgadget@gmail.com>
In-Reply-To: <0c276ffcee4be302be3db9b43ab8371ef26a0aec.1606342377.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 25 Nov 2020 18:04:05 -0500
Message-ID: <CAPig+cTVu4tpvzCyje7_nUbVD0ZdZudzw-SDSm9e8LmOo3w5ng@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] config: add --fixed-value option, un-implemented
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 25, 2020 at 5:13 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> [...]
> Add a new '--fixed-value' option that does not currently change the
> behavior. The implementation will be filled in by later changes for
> each appropriate action. For now, check and test that --fixed-value
> will abort the command when included with an incompatible action or
> without a 'value-pattern' argument.
> [...]
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> @@ -9,15 +9,15 @@ git-config - Get and set repository or global options
> +'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get name [value-pattern]
> +'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get-all name [value-pattern]
> +'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] [--name-only] --get-regexp name_regex [value-pattern]

Didn't notice this before (since I wasn't paying close attention), but
portions of the command which are to be filled-in by the user are
normally surrounded by angle brackets. Without the angle brackets, the
interpretation is that the argument is to be typed literally as shown.
So, the above should really be <value-pattern> and <name_regex> (or
even better <name-regex>), just as other fill-in arguments
<file-option> and <type> are formatted already.

I'm not suggesting that this series should tackle such a change since
that would be straying quite far from the original goal (which, as I
recall, was fixing a misbehavior of git-maintenance), but just
pointing out a possible mini-project for someone to tackle at some
point.

> +--fixed-value::
> +       When used with the `value-pattern` argument, treat `value-pattern` as
> +       an exact string instead of a regular expression. This will restrict
> +       the name/value pairs that are matched to only those where the value
> +       is exactly equal to the `value-pattern`.

Likewise, this would also use the angle brackets as `<value-pattern>`
(or '<value-pattern>' with single quotes rather than backquotes, for
which, I believe, Junio recently stated his preference)...

>  --type <type>::
>    'git config' will ensure that any input or output is valid under the given
>    type constraint(s), and will canonicalize outgoing values in `<type>`'s

... just like <type> is shown in angle brackets.

> +       OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when comparing values to 'value-pattern'")),

Here, I think omitting angle brackets is common, so this is probably okay.
