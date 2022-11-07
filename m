Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8B6C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 14:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiKGOuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 09:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiKGOuU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 09:50:20 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306491A3A4
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 06:50:19 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id kt23so30723424ejc.7
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 06:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WUllkS7GEV5JU2+1yyBvAL4FRK4kakh2D1AlUK4YAnY=;
        b=akM42anJ6iu7kOMnHXGYiwOYB4dkWFUXbiPsb3BSw8tTuP3gLHhyvvO/RbniqjSxID
         AFcz4e8o/HX82oYcPPnvrQfv+VAR6jiTprpMx2Z5HFq2XjGTxBILgFZQtS/+MkoXsVL1
         IO9T8yBcPXtQu3ZnSaRrUBePI/nlcd5JHZgfBINmhPcqLrI6bCF0hPXyLoh80rHE7UKq
         JaiwNi5L1tTX9Y21q6SQgYWNHNvUom96hnGZK8fLGFni+4H4k9Uk27LGYo4o7DMds1dw
         jPZ3qInvN5owdkonDAc56waQN3MKo+rpTn7FD//jVhkc69EWTkmOyx+lzELpjfDTjNQw
         1Jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUllkS7GEV5JU2+1yyBvAL4FRK4kakh2D1AlUK4YAnY=;
        b=j/TAa8JwwNqMKQQE7lECI13doaFDW2tXL2fPdkQVWtT4tZbRUi9JmjFahZxCmrRsPX
         neuggNifqVnf/dEHDGWL9zRQ05ghsNRsYik8pjpt+y3W/8DLHJPGkvLYq+sq56rcplfZ
         Uy+GTXvzquITbz1MoO7TMYDax7bFoeM1HhRUG3Bh0NVsuxGaa4DA7SETsYAZZtpWva7n
         /oMbIfOP0vvpdxt99z3MwuKN7jLDs0kwNsSv8yw8QmiS2g2d9H+Qw0zanP3XQtJ/6Koo
         omyASGXybmw0cJW7z6VYGs8drVz1TpFLJ36bCqFWWDRqeeiXw/GK6lU6ckj6fCIHzWM7
         thyg==
X-Gm-Message-State: ACrzQf2cxBfxUeviZ/fRR3jrBHNmYomxqUYTxIa6wMKDHUti4WEyMR3Z
        RpD6UM1Aj5NeQU9PucLOV+8=
X-Google-Smtp-Source: AMsMyM7IwZiVFWoShxAjSsNmR6l5L/WC/dJym732kSQ9saE8R4rle5OgDHg4JTsFEnXTHSnlW/SXVg==
X-Received: by 2002:a17:907:701:b0:780:2c44:e4dd with SMTP id xb1-20020a170907070100b007802c44e4ddmr15450727ejb.589.1667832617661;
        Mon, 07 Nov 2022 06:50:17 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 24-20020a170906329800b0077e6be40e4asm3556100ejw.175.2022.11.07.06.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 06:50:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1os3S4-00084T-2M;
        Mon, 07 Nov 2022 15:50:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 1/3] notes.c: introduce "--blank-line" option
Date:   Mon, 07 Nov 2022 15:45:38 +0100
References: <cover.1667828335.git.dyroneteng@gmail.com>
 <2381947abdd6b965c02e114af297fc908ed3132b.1667828335.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <2381947abdd6b965c02e114af297fc908ed3132b.1667828335.git.dyroneteng@gmail.com>
Message-ID: <221107.864jvax1hz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 07 2022, Teng Long wrote:

> When appending to a given object which has note and if the appended
> note is not empty too, we will insert a blank line at first. The
> blank line serves as a split line, but sometimes we just want to
> omit it then append on the heels of the target note. So, we add
> a new "OPT_BOOL()" option to determain whether a new blank line
> is insert at first.
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  Documentation/git-notes.txt | 11 +++++++++--
>  builtin/notes.c             |  5 ++++-
>  t/t3301-notes.sh            | 12 ++++++++++++
>  3 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> index efbc10f0f5..43770ddf84 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -11,7 +11,7 @@ SYNOPSIS
>  'git notes' [list [<object>]]
>  'git notes' add [-f] [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
>  'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
> -'git notes' append [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
> +'git notes' append [--allow-empty] [--blank-line] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
>  'git notes' edit [--allow-empty] [<object>]
>  'git notes' show [<object>]
>  'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>
> @@ -86,7 +86,9 @@ the command can read the input given to the `post-rewrite` hook.)
>  
>  append::
>  	Append to the notes of an existing object (defaults to HEAD).
> -	Creates a new notes object if needed.
> +	Creates a new notes object if needed. If the note of the given
> +	object and the note to be appended are not empty, a blank line
> +	will be inserted between them.
>  
>  edit::
>  	Edit the notes for a given object (defaults to HEAD).
> @@ -159,6 +161,11 @@ OPTIONS
>  	Allow an empty note object to be stored. The default behavior is
>  	to automatically remove empty notes.
>  
> +--blank-line::
> +--no-blank-line::
> +	Controls if a blank line to split paragraphs is inserted
> +	when appending (the default is true).

Just make this:

	--no-blank-line:
		Suppress the insertion of a blank line before the
		inserted notes.

Or something, i.e. when adding a "true by default" let's add a "no-..." variant directly.

>  	int allow_empty = 0;
> +	int blankline = 1;

So keep this...

>  	const char *object_ref;
>  	struct notes_tree *t;
>  	struct object_id object, new_note;
> @@ -584,6 +585,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
>  			parse_reuse_arg),
>  		OPT_BOOL(0, "allow-empty", &allow_empty,
>  			N_("allow storing empty note")),
> +		OPT_BOOL(0, "blank-line", &blankline,

...and just make this "no-blank-line", and parse_options() will do the
right thing. I.e. PARSE_OPT_NONEG is implied.

> -		if (d.buf.len && prev_buf && size)
> +		if (blankline && d.buf.len && prev_buf && size)
>  			strbuf_insertstr(&d.buf, 0, "\n");

Maybe this needs to be elaborated in the docs? I.e. it sounds as if
we'll insert a \n unconditionally, which this shows isn't the case.

>  		if (prev_buf && size)
>  			strbuf_insert(&d.buf, 0, prev_buf, size);
> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 3288aaec7d..76beafdeb8 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -521,12 +521,24 @@ test_expect_success 'listing non-existing notes fails' '
>  	test_must_be_empty actual
>  '
>  
> +test_expect_success 'append to existing note without a beginning blank line' '
> +	cat >expect <<-\EOF &&
> +		Initial set of notes
> +		Appended notes
> +	EOF
> +	git notes add -m "Initial set of notes" &&
> +	git notes append --no-blank-line -m "Appended notes" &&
> +	git notes show >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'append to existing note with "git notes append"' '
>  	cat >expect <<-EOF &&
>  		Initial set of notes
>  
>  		More notes appended with git notes append
>  	EOF
> +	git notes remove HEAD &&

This should be a test_when_finished "", for the previous test, otherwise
this one will presumably fail if you use the "wrong" --run="" arguments
to skip the last test.
