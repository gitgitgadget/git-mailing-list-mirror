Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05E5C433F5
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 16:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239211AbiCRQtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 12:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiCRQtA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 12:49:00 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03972F09EF
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 09:47:41 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB37C110953;
        Fri, 18 Mar 2022 12:47:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tu7xnL0rC5DgsxRfs5Zz9wOdhiuptgeLtjINq6
        TUMBI=; b=fMnMlp7WzVcYqLZFdEsQnDToeuHWjpLtkIvLioW9q1CLpn9Vdzt8Yd
        QYS2opLOxEUVqbZVGAEZA4BZewWorOabR5WIhkBahIIwoaX8sASv1dhmx4YwFhS2
        ILQoA15gHmfHBlGuFVurD2WLL8MpqmZ5S8ZmeSbpw30WYVvMY/Ubo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E2907110952;
        Fri, 18 Mar 2022 12:47:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5594011094E;
        Fri, 18 Mar 2022 12:47:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     derrickstolee@github.com, vdye@github.com, git@vger.kernel.org,
        newren@gmail.com
Subject: Re: [PATCH v4 1/1] Documentation/git-sparse-checkout.txt: add an
 OPTIONS section
References: <20220311132141.1817-1-shaoxuan.yuan02@gmail.com>
        <20220317123718.480093-1-shaoxuan.yuan02@gmail.com>
        <20220317123718.480093-2-shaoxuan.yuan02@gmail.com>
Date:   Fri, 18 Mar 2022 09:47:39 -0700
In-Reply-To: <20220317123718.480093-2-shaoxuan.yuan02@gmail.com> (Shaoxuan
        Yuan's message of "Thu, 17 Mar 2022 20:37:18 +0800")
Message-ID: <xmqqfsnfb42c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FD422CE-A6DB-11EC-AECB-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:

> Add an OPTIONS section to the manual and move the descriptions about
> these options from COMMANDS to the section.

The above description does not seem to match what the patch does at
all, though.  Sent a wrong patch, possibly just the tip of a series,
when you needed to send more than one patches?  For example, the
header for the hunk -103,33 tells us that the file already has OPTIONS
section before this patch gets applied.

> @@ -48,6 +48,14 @@ COMMANDS
>  	following the 'set' subcommand, and update the working directory to
>  	match.
>  +
> +By default, the arguments to the `set` command are interpreted as a
> +list of directories. The sparse-checkout patterns are set to match
> +all files within those directories, recursively, as well as any file
> +directly contained in a parent of those directories. See INTERNALS
> +-- CONE PATTERN SET below for full details. If --no-cone is specified,
> +then the arguments are interpreted as sparse-checkout patterns. See
> +INTERNALS -- FULL PATTERN SET below for more information.
> ++
>  To ensure that adjusting the sparse-checkout settings within a worktree

That reads well.

> @@ -59,8 +67,10 @@ file. See linkgit:git-worktree[1] and the documentation of
>  'add'::
>  	Update the sparse-checkout file to include additional directories
>  	(in cone mode) or patterns (in non-cone mode).  By default, these
> -	directories or patterns are read from the command-line arguments,
> -	but they can be read from stdin using the `--stdin` option.
> +	directories or patterns are read from the command-line arguments.
> +  These directories or patterns are interpreted the same way as stated
> +  above in `set` command, and they can be read from stdin using the
> +  `--stdin` option.

The original removed by the patch said "directories or patterns",
and I understand that this change is an attempt to say that the
command chooses between directories and patterns using the same
criteria as the "set" command, but the added "are interpreted the
same way as ..." in the middle interrupts the flow of thought the
sentence conveys.  To me, it looks like the first sentence gives
clear enough explanation of that already.

Broken indentation aside, I do not see why this change is needed.

> @@ -103,33 +113,9 @@ OPTIONS
>  	Use with the `set` and `reapply` commands.
>  	Specify using cone mode or not. The default is to use cone mode.
>  +
> -For `set` command:
> ...
> -flags, with the same meaning as the flags from the `set` command, in order
> -to change which sparsity mode you are using without needing to also respecify
> -all sparsity paths.
> +For the `set` command, the option to use cone mode or not changes
> +the interpretation of the remaining arguments to either be a list
> +of directories or a list of patterns.

These three lines are not technically incorrect, but is not written
in a way that helps readers.

Read these three lines a few times, pretending that you have never
used the sparse-checkout, and try to answer this question: "I am
giving a few arguments to the command using the cone mode.  Are they
taken as directories, or patterns?"

It is hard for me to guess what is being improved upon because I do
not have the preimage of this hunk, but the new text is much less
clear than "directories (in cone mode) or patterns (in non-cone
mode)" we saw earlier in the description for the 'add' command,
which would help us answer the question (answer: they are taken as
directories).

Thanks.
