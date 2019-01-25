Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BFCD1F453
	for <e@80x24.org>; Fri, 25 Jan 2019 16:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfAYQag (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 11:30:36 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:38887 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfAYQag (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 11:30:36 -0500
Received: by mail-vk1-f195.google.com with SMTP id w72so2255018vkd.5
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 08:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yfONCnEeNzBQ7wChDjCUcJ+IuQD9yqzZokH4cBU9zQ0=;
        b=Mjhf+BuQQOWy1nfRJcZO1blqzAGxqaKnPpFnCKOEmhEBaJAA2BA2XoLfBKUpzyk9mc
         8GETdpYJtcHVLIynwtVDgWO3HGmr03Z2p4dnaj6h9B3MiF/K7b/vLVWMiSZZLVZUZr8x
         rUbGf96tPNPsdHD3jS2k8DXhMOblPwvwTd5o/vZuNmMCj63FgvMR20kpcJZV7mFMhenE
         pm6sF8INgeccjIdOFp3ZwIhhcpyxxEakbdUsm5SibNSYFp1Bfn+3lox0yfzmdBErLJCP
         kUgxLfBLv1O/iRb2q3MxVky3Mrz9a/NGVaw8Ypg262JWW79adTSVo6X8bovM5JZXuBcn
         EyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yfONCnEeNzBQ7wChDjCUcJ+IuQD9yqzZokH4cBU9zQ0=;
        b=sAArPx5LNmWluRDA3ybDUMDOeqeTFfPNBsMGLfZSVMnilfR3Ny5q9tCAzJpYsS6BqE
         1AUV5r7NofvhRKwwHLvD0FIFnPMNgOHZndi85iypsevL98RSvU1doEkXwwtav05EvVp9
         I0JQYGpQIOFUn33Ta94QDzMglwpYUOa0qFNHZ56/Trhn+qmv7BBt7h1L7sG1h7un2+6E
         K4+VvlEf6dhPQW7KJOyNTkkhVpE9eLrK+lQE3kF49PdWt+IJUtxjd0FgaDfKYAMxwN24
         DtafS6bAUGu5dQfXn9/HQCuY8aZT4BVI1kgYflecVo3gKAqy35CAhcu6m5fffYTXXTfv
         maXw==
X-Gm-Message-State: AJcUukcXbDtjqapC6+LrqRwl64OCt+uXOyw3TrCDbjMqD7oUXV1ZgjKt
        ph0jDWyreq9dQQREx6EO8w+2c9GD3PkFOwaLgCYqZY10+Bw=
X-Google-Smtp-Source: ALg8bN6vCCRe7bou96Syi1uMPHXG03eHXJH6zqUEccbhroXqqtgr6xboSjuDa5+GR7j5iK8tU9JBB0gxzTzjPp5zWfI=
X-Received: by 2002:a1f:a147:: with SMTP id k68mr4636970vke.1.1548433834670;
 Fri, 25 Jan 2019 08:30:34 -0800 (PST)
MIME-Version: 1.0
References: <20190124164654.1923-1-newren@gmail.com> <e9dd9394-e34d-e948-9a9c-83338b672d65@gmail.com>
In-Reply-To: <e9dd9394-e34d-e948-9a9c-83338b672d65@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 25 Jan 2019 08:30:23 -0800
Message-ID: <CABPp-BE9qFHGmJ-qO4Bx+wmO8N7pO_hdros5Q2hxd32=zU0F5A@mail.gmail.com>
Subject: Re: [PATCH] log,diff-tree: add --combined-with-paths options for
 merges with renames
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Jan 25, 2019 at 6:45 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 1/24/2019 11:46 AM, Elijah Newren wrote:
> > As an alternative, I considered perhaps trying to sell it as a bugfix
> > (how often do people use -M, -c, and --raw together and have renames
> > in merge commits -- can I just change the format to include the old
> > names), but was worried that since diff-tree is plumbing and that the
> > format was documented to not include original filename(s), that I'd be
> > breaking backward compatibility in an important way for someone and
> > thus opted for a new flag to get the behavior I needed.
>
> This is wise. Changing the format is likely to break at least one GUI
> client or tool, especially because many depend on the installed version
> of Git instead of shipping with one "blessed" client.
>
> In addition, there may be whitespace in the filenames. It appears the
> diff format separates the filenames with tab characters. Is it
> possible to have tab character in a file name? That would make the output
> ambiguous, but is no worse than our current output in a non-combined
> diff.

No, it's actually unambiguous with or without the -z option. Without
-z, pathnames with "unusual" characters (whose definition depends on
core.quotePath) will cause the pathname to be enclosed in
double-quotes with the unusual characters handed with backslashes and
control characters.  With -z, it separates pathnames with a nul
character instead.

> I'll repeat Brian's request for tests. I trust the compiler and the
> test suite more than I trust my ability to read code.

Yep, I'll add a pair and use filenames with multiple tabs.
