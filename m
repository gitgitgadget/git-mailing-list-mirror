Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEB821F404
	for <e@80x24.org>; Fri,  7 Sep 2018 23:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbeIHEWM (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 00:22:12 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44228 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725733AbeIHEWM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 00:22:12 -0400
Received: by mail-qk1-f195.google.com with SMTP id d131-v6so10722178qke.11
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 16:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n3rATBspmfWnx4Oo0wQzRKg5eZvpu2psl5g9umTBZ38=;
        b=rXSdPVoOL0WyTOlB48ioLTmw3Tp9aWp5bg1AJFcZ1SlJ6zK+0HMRT7q9oPWr+fLxzo
         EZ3CcXBOphhiRhv/sfMe5OquXi4Dn/4AFf4T9hdfgssQPU2lidxh29JWqA6H6T0Ww/Pv
         Ex0KxeYGV7u10VmFPZzAe+VyyewS+QVeUh0Pqu/ED2JNNuYpvWYPwb8tHsRRLMaP1hP2
         1wDuQz/OGsWUStoVzH5p1bIELh8pdRjEAZCUPU3EB13ttK06wY3rbk7t2GVcH3OkOV6G
         YNMA9yQsBZQcf+NoX1XnYK2IuXKVffvX/b0IYkVNt+/bqYYN5lJhdofhOe9uKkYBYI5K
         qmXg==
X-Gm-Message-State: APzg51CWn74gghk8xyXeK8NQV7TI0kJD3sbXVbZOSUhg47qmgnAIkkKj
        GZTqRY2gNKa64YYPBNpVvXs2p8hBxw4jP91jicA=
X-Google-Smtp-Source: ANB0VdZMBwBJaG+sXjISXytYMW31cZZ3qpkQ27a5Ou3vXqyQV8hJftN6hRMS8S0hG+90mRe1RfhS+Q7Q09ixTiYf5fo=
X-Received: by 2002:ae9:ef13:: with SMTP id d19-v6mr7679844qkg.152.1536363531540;
 Fri, 07 Sep 2018 16:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180905085427.4099-1-timschumi@gmx.de> <20180907224430.23859-1-timschumi@gmx.de>
 <20180907224430.23859-3-timschumi@gmx.de>
In-Reply-To: <20180907224430.23859-3-timschumi@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 7 Sep 2018 19:38:39 -0400
Message-ID: <CAPig+cR1JpZqxBAsR+6_WjLwofnU8siB9VXYdUkXY2P-xQnsuQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/3] t0014: Introduce alias testing suite
To:     timschumi@gmx.de
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 7, 2018 at 6:44 PM Tim Schumacher <timschumi@gmx.de> wrote:
> Introduce a testing suite that is dedicated to aliases.
> For now, check only if nested aliases work and if looping
> aliases are detected successfully.
>
> The looping aliases check for mixed execution is there but
> expected to fail because there is no check in place yet.
>
> Signed-off-by: Tim Schumacher <timschumi@gmx.de>
> ---
> Unfortunately I don't have a fix for the last one yet, so I
> marked it as expect_failure. The problem is that the test suite
> is waiting a full minute until it aborts the running command
> (which I guess should not take that long, as it blocks the whole
> test suite for that span of time).
>
> Should I try to decrease the timeout or should I remove that
> test completely until I manage to get external calls fixed?

Perhaps just comment out that test for now and add a comment above it
explaining why it's commented out.

> As a last thing, is there any better way to use single quotes
> than to write '"'"'? It isn't that bad, but it is hard to read,
> especially for bash newcomers.

You should backslash-escape the quotes ("foo \'bar\' baz"), however,
in this case, it would make sense to use regex's with 'grep' to check
that you got the expected error message rather than reproducing the
message literally here in the script.

More below.

> diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
> @@ -0,0 +1,38 @@
> +#!/bin/sh
> +
> +test_description='git command aliasing'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup environment' '
> +       git init
> +'

"git init" is invoked automatically by the test framework, so no need
for this test. You can drop it.

> +test_expect_success 'nested aliases - internal execution' '
> +       git config alias.nested-internal-1 nested-internal-2 &&
> +       git config alias.nested-internal-2 status
> +'

This isn't actually testing anything, is it? It's setting up the
aliases but never actually invoking them. I would have expected the
next line to actually run a command ("git nested-internal-1") and the
line after that to check that you got the expected output (whatever
"git status" would emit). Output from "git status" isn't necessarily
the easiest to test, though, so perhaps pick a different Git command
for testing (something for which the result can be very easily checked
-- maybe "git rm" or such).

> +test_expect_success 'nested aliases - mixed execution' '
> +       git config alias.nested-external-1 "!git nested-external-2" &&
> +       git config alias.nested-external-2 status
> +'

Same observation.

> +test_expect_success 'looping aliases - internal execution' '
> +       git config alias.loop-internal-1 loop-internal-2 &&
> +       git config alias.loop-internal-2 loop-internal-3 &&
> +       git config alias.loop-internal-3 loop-internal-2 &&
> +       test_must_fail git loop-internal-1 2>output &&
> +       grep -q "fatal: alias loop detected: expansion of '"'"'loop-internal-1'"'"' does not terminate" output &&

Don't bother using -q with 'grep'. Output is hidden already by the
test framework in normal mode, and not hidden when running in verbose
mode. And, the output of 'grep' might be helpful when debugging the
test if something goes wrong.

As noted above, you can use regex to match the expected error rather
than exactly duplicating the text of the message.

Finally, use 'test_i18ngrep' instead of 'grep' in order to play nice
with localization.

> +       rm output

Tests don't normally bother cleaning up their output files like this
since such output can be helpful when debugging the test if something
goes wrong. (You'd want to use test_when_finished to cleanup anyhow,
but you don't need it in this case.)

> +'
