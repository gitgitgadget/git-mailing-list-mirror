Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737E5C77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 19:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjEHThY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 15:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjEHThW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 15:37:22 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B16159D4
        for <git@vger.kernel.org>; Mon,  8 May 2023 12:37:21 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1aaea43def7so33696365ad.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 12:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683574641; x=1686166641;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RhljU7AWU1VmwZpLAmLNjD/062UF6xh67ODKbml5SC4=;
        b=anf65cl5vfnod+WbVYdSqtKB8Ld0PD3/TXxOhA1+y9RJC3VsVI9JJpeWQTu9P3MpHF
         iKZV2eyaK0wUGm6e8lWdy1Bor5oxsVaEZBE1bKDgYi7flVcjAfRSBhpoSUea88uypB75
         4nqaW4z2IhmzMaDmRvZBQ7PKqnS6f25bWCmP4Cr8bryOjTSlq1uqKDLI/doH6Z4uGVyI
         hN5eTQhc4M2uJJSArrkADuiZICwtmnYkQrTE4cnzTDqKTyIGaoeKeqc46oTpIGbOoD/N
         EpvSRWufG8K22YV3DQ8jShi2x9AW2dW7Gb6nYR6AdRM3FnXC1sIzupA+OPNGipjuqCnD
         7SUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683574641; x=1686166641;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RhljU7AWU1VmwZpLAmLNjD/062UF6xh67ODKbml5SC4=;
        b=CX1RuhqnLFBhRf4DzhJyq1ig5YqhQ3Y6gWpFOYHx4ttKbd+fyDwSvcAWNxaSkDEjAG
         6kEy54dbNErptBrCCr/hBvj5ZTKDvzWbShS3wp/S6bgoNvxSPjN6NfBn9nwrdMha2Jr1
         i1OUIkWuqzmZqRuAG4gyNMaTzbAnKPt8FcOcT/4bmzDfdLzy0FluJFK+Gdfb+LMTUaog
         PbKIaEyeKUZWUnRRfdTdDL27EF26i2iWMJ4ioSBF8+5llPyYBHHo5AtD0657GPhleZZS
         tZrZhFFr+qJFjG/J168kTDT5OF7orheMZ3qYAOeKn2jImc7T/zLTi92JYq6nKDfNGzc5
         zCKA==
X-Gm-Message-State: AC+VfDzwRM4mCXAjEboXJGW3rXziMzDRSkj585c9aKLMZjB2oR5myry4
        26c8Xu6L5OIs9soMKl+QiO8=
X-Google-Smtp-Source: ACHHUZ7NNzOQuAvNJvX7yDiKr4I4+e4U5ocyw02MFDlJVEP2qTeWMMxRyav+XVnSmkV1YlF6yDkBlw==
X-Received: by 2002:a17:902:b685:b0:1aa:f46a:380a with SMTP id c5-20020a170902b68500b001aaf46a380amr10526625pls.26.1683574640919;
        Mon, 08 May 2023 12:37:20 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id r9-20020a1709028bc900b001a4fecf79e4sm7595745plo.49.2023.05.08.12.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 12:37:20 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>
Subject: Re: [PATCH 04/11] doc: trailer: explain "commit mesage part" on
 first usage
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
        <0c10e40794d208ba408a2b1c394fdbd6caa7a92a.1683566870.git.gitgitgadget@gmail.com>
Date:   Mon, 08 May 2023 12:37:20 -0700
In-Reply-To: <0c10e40794d208ba408a2b1c394fdbd6caa7a92a.1683566870.git.gitgitgadget@gmail.com>
        (Linus Arver via GitGitGadget's message of "Mon, 08 May 2023 17:27:43
        +0000")
Message-ID: <xmqqa5yeobrj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> This phrase is used for the first time here, but it's not explained what
> it means. So explain it just in case it's not obvious.

03+04 should be a single patch (as I read more, I may find other
steps should also be in a single step, I dunno); otherwise it would
waste reviewer's time (just like I did thinking and writing about
03/11).

Or just drop "part".  "git cat-file commit HEAD | sed -e '1,/^$/d'"
is a good material to use with "--no-divider" because it only has
the "commit message".  The "part" implies you first had something
that has both "commit message" and something else and you split
that combination into two (or more) parts.  But that does not have
to be the case.  I think that made 03/11 confusing, at least to me.

> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  Documentation/git-interpret-trailers.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index 3e60a6eaabc..7d6e250f37e 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -22,9 +22,9 @@ This command reads some patches or commit messages from either the
>  <file> arguments or the standard input if no <file> is specified. If
>  `--parse` is specified, the output consists of the parsed trailers.
>  
> -Otherwise, this command applies the arguments passed using the
> -`--trailer` option, if any, to the commit message part of each input
> -file. The result is emitted on the standard output.
> +Otherwise, this command applies the arguments passed using the `--trailer`
> +option, if any, to the commit message part of each input file (as opposed to the
> +patch part following a '---' divider). The result is emitted to standard output.
>  
>  Some configuration variables control the way the `--trailer` arguments
>  are applied to each commit message and the way any existing trailer in
