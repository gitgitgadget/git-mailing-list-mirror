Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99F9C433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 08:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiKUIJw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 03:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiKUIJu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 03:09:50 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773F823160
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 00:09:49 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id z26so10664234pff.1
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 00:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cmpWSTdzDHF8fsLiQpfbZNGpovx2LWjKhdthSRzkics=;
        b=ay/1gJ2eLap6gx5lo1sVgPZRsNL8yWRpyRpiWZFD7Qmzb7sm66HZwNwH7Mr1HQGDF2
         J+OqpsKxGq7/vCFZwDdu4DMKwGBGYI1pU1loTmCmuHu0hOTiXIXPfy40Fp8/oowRGO2g
         2OQvTmmGHock2uGeI+TyFJbTMvfY6dp3UbTFeHwsga/rd/Dr/0+qAZQWGs9HQWUUjfv4
         FMSyIet5JL62Ltd/PzWWxODHOZZ8Bg7Rl+yCI2PaoUtSJAnFHcmPefV2NNbtRlosCQME
         ARUITV/v75KxP9jJrCZ8borOu3yVVY9iKzySNQExnxkS60V0MTWBWUH+On6Tjq+BrpFV
         rvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cmpWSTdzDHF8fsLiQpfbZNGpovx2LWjKhdthSRzkics=;
        b=YYdPYaEOoRXc8xXTmPvpTCcJoqlUfKAKmXxB7dgp8OByesctn3URnWRQ3HOix/Qxfd
         rHegyUyWI6suNWCtFzzYjA+/hASF2sx4w5rlv20YhUl0QbyIg9GS07Ua9foI+3Ty5GKj
         Aq8Eg40kUAUtjcVS1bxhKt6p+JzWGv5mgPD8XvNsfPqmY2NNE3L9QsVLwPuPN75m5Zlt
         GhjNeGhsg7k9ERj6u01it3P8TOpv6o+oGbMriYen7IGkUsX4qbhHViIQzq7ck0vjC7U1
         DXnyPtTQ+q/UaaQDV8BKssCn3Sy0wygpOg6mcU3w3x9olqWxEw4JICpDcBi1ezykBOMX
         TTGQ==
X-Gm-Message-State: ANoB5plgt3tdofBAW/wJwUyYFzEuFk63tIN1daOLhRn3nGo5RqBJnhVl
        86Me98PohWMRfWgxTY/iSgDiqbtocxWNXw==
X-Google-Smtp-Source: AA0mqf43BBuddhXnF+z73YBnJMAn5PzVQz+BoKjJY0WmshvlDMQd9XLckpR0kjokOAqDYzpHopkq8g==
X-Received: by 2002:a05:6a00:798:b0:566:9f68:c0ad with SMTP id g24-20020a056a00079800b005669f68c0admr1024521pfu.57.1669018188774;
        Mon, 21 Nov 2022 00:09:48 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id ix9-20020a170902f80900b001782a0d3eeasm9000925plb.115.2022.11.21.00.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 00:09:48 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Subject: Re: [PATCH] var: add GIT_SEQUENCE_EDITOR variable
References: <pull.1424.git.1668972017089.gitgitgadget@gmail.com>
Date:   Mon, 21 Nov 2022 17:09:47 +0900
In-Reply-To: <pull.1424.git.1668972017089.gitgitgadget@gmail.com> (Sean Allred
        via GitGitGadget's message of "Sun, 20 Nov 2022 19:20:16 +0000")
Message-ID: <xmqq1qpwwwxg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sean Allred via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sean Allred <allred.sean@gmail.com>
>
> Provides the same benefits to scripts as exposing GIT_EDITOR, but
> allows distinguishing the 'sequence' editor from the 'core' editor.
>
> See also 44fcb4977cbae67f4698306ccfe982420ceebcbf.

Why should we ;-)?

If you explain why "git var GIT_SEQUENCE_EDITOR" is useful in a more
direct way, you do not even have to refer to a long hexadecimal string
which by itself does not mean anything to sane human beings.

    The editor program used by Git when editing the sequencer "todo"
    file is determined by examining a few environment variables and
    also affected by configuration variables.  Introduce "git var
    GIT_SEQUENCE_EDITOR" that gives users an access to the final
    result of the logic without having to know the exact detail.

    This is very similar in spirit to 44fcb497 (Teach git var about
    GIT_EDITOR, 2009-11-11) that introduced "git var GIT_EDITOR".

or something like that, perhaps?

> +GIT_SEQUENCE_EDITOR::
> +    Text editor for use by Git sequencer commands. Like `GIT_EDITOR`,

Do our readers know what "Git sequencer commands" are?  "rebase -i"
of course is the primary one, but "cherry-pick" and "revert" that
deals with multiple commits are technically "sequencer commands", as
they also use the sequencer machinery.  But for them, the users do
not get a chance to edit the "todo" list with their sequence editor,
unlike "rebase -i".

I am wondering if it is easier to understand, without losing
technical correctness, to exactly name the command, without
pretending as if the sequence editor is used in situations wider
than where "rebase -i" is used, e.g.

	The text editor program used to edit the 'todo' file while
	running "git rebase -i".

or something.

> +    the value is meant to be interpreted by the shell when it is used.
> +    The order of preference is the `$GIT_SEQUENCE_EDITOR` environment
> +    variable, then `sequence.editor` configuration, and then the value
> +    of `git var GIT_EDITOR`.

OK.

> diff --git a/builtin/var.c b/builtin/var.c
> index 491db274292..9a2d31dc4aa 100644
> --- a/builtin/var.c
> +++ b/builtin/var.c
> @@ -19,6 +19,16 @@ static const char *editor(int flag)
>  	return pgm;
>  }
>  
> +static const char *sequence_editor(int flag)
> +{
> +	const char *pgm = git_sequence_editor();
> +
> +	if (!pgm && flag & IDENT_STRICT)
> +		die("Terminal is dumb, but EDITOR unset");

I know this was copied from editor(), but the message does not make
much sense.  It's not like the caller of read_var() is not prepared
to see a NULL returned, so letting it return NULL would make more
sense.  Since the ancient past back when editor() function was
written, launch_editor() and the logic to die with "on dumb terminal
you must specify an EDITOR" have migrated to editor.c and there is
no strong reason to keep the corresponding die() even in editor()
function (I do not recommend removing it as part of this topic,
though), and adding a new one makes even less sense.

