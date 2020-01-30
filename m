Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E62C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C202082E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNSUQw4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgA3WTH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:19:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46758 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgA3WTH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 17:19:07 -0500
Received: by mail-pl1-f195.google.com with SMTP id y8so1869621pll.13
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 14:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Gy/CfVMl8O2mVAI574268ZsPiqDv1+3TQfKme75vmM=;
        b=rNSUQw4W7y0zZVsi3s/yEFQD8xZGdM52rQWb/1NfIhvN4nTKkzUkaODutVefpVOLww
         K0mFnzRx4Ju2egFTqQUm3Q6wA771Slxf3Uqby0HFbBZL2ng9qZVFm9CM06SaqbhXn3Ll
         Uga2fUdPyJOuEV4sIOtnsJJ26Z+BYuHOJDxb6FnwESxFiMomE3ew/so45e3beIS5oXNB
         WWgr0MMx/VD2g7cwc+L3jcUticCLnJVeYiF1pISYPv1FYubojrwmZ+e66bdxNrVAjX6P
         tf4MSFQynXrLco2A+srRzoZ0rFcrR5DrgU5E/tf356uP5YWdl/HjPuq1DqAMh7rjwn+m
         k8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Gy/CfVMl8O2mVAI574268ZsPiqDv1+3TQfKme75vmM=;
        b=hMlsB5c06tItiu+2T66Unblc2FYiuj+D52dqCJoxiDtau0GDglbDWxqzFlKQpbqr4A
         q2CB2FUHVb0KwuI2BfPAXTe2L8o5tNXAoo2x3/ejGMhMyDoeNZo3SdHOA0jFE5T0gzLe
         ccCPxItTpZoDM6dwQdLn+LAQhODG5OWcpx/HuagoVOSH6sRw2Qj2rUG0ZoEB3yC56pVE
         O3nw2b9MkoLnaWieV7SgdUUMJrpyMRkm9KOErcnnweN98j0Jxh6Ee3bx3TkD3OHq1VqS
         F5t7yKR5uV4NIQG//a5SBf1djTQ1de8jOITz6TKISPvAawKJpb6IzQ+51ZmhOEQMEYy9
         atgA==
X-Gm-Message-State: APjAAAVFUoNqt5Eom6xHmLP/PhH3ntPwKKRNzzP6b4SCzg6hPvJe06Lt
        JDtvJtXC5mOmzt5ZI4bMSPpK3dafm6ppYFucJduKla4b
X-Google-Smtp-Source: APXvYqz7zIPvQjseATIm5WILp2ttlmRzqd9XcDLKmItQ9+AcpiWbmuBrdkb20Q4VAboDKrbkjSJyLCcoUhJQaaomVwI=
X-Received: by 2002:a17:902:a706:: with SMTP id w6mr6923125plq.79.1580422746555;
 Thu, 30 Jan 2020 14:19:06 -0800 (PST)
MIME-Version: 1.0
References: <20200124033436.81097-1-emilyshaffer@google.com> <20200124033436.81097-2-emilyshaffer@google.com>
In-Reply-To: <20200124033436.81097-2-emilyshaffer@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 30 Jan 2020 23:18:55 +0100
Message-ID: <CAN0heSoaASfMhgLwZx4MZAdoGOfGK1fJK5X9VfUJN5R38gFVTA@mail.gmail.com>
Subject: Re: [PATCH v5 01/15] bugreport: add tool to generate debugging info
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 24 Jan 2020 at 05:56, <emilyshaffer@google.com> wrote:
>
> From: Emily Shaffer <emilyshaffer@google.com>
>
> Teach Git how to prompt the user for a good bug report: reproduction
> steps, expected behavior, and actual behavior. Later, Git can learn how
> to collect some diagnostic information from the repository.

("Later" meaning "later in this series", or "any day now"? ;-) )

> +SYNOPSIS
> +--------
> +[verse]
> +'git bugreport' [-o | --output <path>]

Hmm. Should that be "[(-o | --output) <path>]"?

> +DESCRIPTION
> +-----------
> +Captures information about the user's machine, Git client, and repository state,
> +as well as a form requesting information about the behavior the user observed,
> +into a single text file which the user can then share, for example to the Git
> +mailing list, in order to report an observed bug.

Nice description. Got it.

> +The following information is requested from the user:
> +
> + - Reproduction steps
> + - Expected behavior
> + - Actual behavior
> +
> +The following information is captured automatically:
> +
> + - Git version (`git version --build-options`)
> + - Machine information (`uname -a`)
> + - Versions of various dependencies
> + - Git config contents (`git config --show-origin --list`)
> + - The names of all configured git-hooks in `.git/hooks/`

I would have expected these points to appear later, both to make it
clear what this does commit does (and not), and to highlight what
user-visible (documentation-worthy) changes later commits bring along.

> +OPTIONS
> +-------
> +-o [<path>]::
> +--output [<path>]::

Drop the "[" and "]"? If you give -o, you'd better give a path as well?

> +       Place the resulting bug report file in <path> instead of the root of the

`<path>`

> +"Please review the rest of the bug report below.\n"
> +"You can delete any lines you don't wish to send.\n");

"send" sounds like we're *just* about to send this report somewhere, but
it's "only" going to be written to the disk. Maybe "share", instead?

> +       if (option_output) {
> +               strbuf_addstr(&report_path, option_output);
> +               strbuf_complete(&report_path, '/');
> +       }

I thought I'd use `-o` to indicate the filename, but it turns out it's
the *directory* where the file (of some semi-random, generated name)
will end up. Re-reading the docs further up, I can see how this is
consistent. I sort of wonder if this should be `--output*-directory*`
for symmetry with `git format-patch`.

> +       strbuf_addstr(&report_path, "git-bugreport-");
> +       strbuf_addftime(&report_path, "%F", gmtime(&now), 0, 0);
> +       strbuf_addstr(&report_path, ".txt");
> +
> +

(Double blank line?)

> +       get_bug_template(&buffer);
> +
> +       report = fopen_for_writing(report_path.buf);

Report might be NULL here.

If there's already such a file, we overwrite. Should we generate the
filename using not just today's date (two bug reports in a day wouldn't
be unheard of?) but also something like hh:mm:ss?

> +       strbuf_write(&buffer, report);
> +       fclose(report);

Maybe clear the strbuf around here...

> +       launch_editor(report_path.buf, NULL, NULL);
> +       return 0;

... and/or UNLEAK it here, together with report_path.

Maybe "return -launch_editor(...)"?

> +#!/bin/bash

Use /bin/sh instead?

> +# Headers "[System Info]" will be followed by a non-empty line if we put some
> +# information there; we can make sure all our headers were followed by some
> +# information to check if the command was successful.
> +HEADER_PATTERN="^\[.*\]$"
> +check_all_headers_populated() {
> +       while read -r line; do
> +               if [$(grep $HEADER_PATTERN $line)]; then

I think this is a bash-ism.

> +                       read -r nextline
> +                       if [-z $nextline]; then

Likewise.

> +                               return 1;
> +                       fi
> +               fi
> +       done
> +}
> +
> +test_expect_success 'creates a report with content in the right places' '
> +       git bugreport &&
> +       check_all_headers_populated <git-bugreport-* &&
> +       rm git-bugreport-*
> +'
> +
> +test_expect_success '--output puts the report in the provided dir' '
> +       mkdir foo/ &&

If foo isn't there, do we not create it? Apparently not -- in my
testing, we segfault. (We don't check for NULL after opening the file.)

> +       git bugreport -o foo/ &&
> +       test -f foo/git-bugreport-* &&

test_path_is_file

> +       rm -fr foo/
> +'
> +
> +test_expect_success 'incorrect arguments abort with usage' '
> +       test_must_fail git bugreport --false 2>output &&
> +       grep usage output &&
> +       test ! -f git-bugreport-*

test_path_is_missing


Martin
