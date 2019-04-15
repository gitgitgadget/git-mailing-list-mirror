Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C44E20248
	for <e@80x24.org>; Mon, 15 Apr 2019 07:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfDOHI6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 03:08:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40641 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfDOHI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 03:08:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so20400273wre.7
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 00:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=qCbGoJo5vDVBpfq5sCcy04qfBVc7axku9ZcIgphppqc=;
        b=mtgUEU8MlCkU0ZeKznhDOM0U/Cvnn4pJ5M7JTHndNy4hOYM27SUlVX7x/ikRhTj6IW
         Aj/z50V+kuUwMelw8T4LJUEGDlgWCOEYKa7k4t/qXijY0Bq/93lONtd7zYHVbRGpHFQj
         Gmq1oqqSrbjJAigyWVTuybGnLf6mCiGBOh2DexO/w/EkDzUDZ+Pgji2EVLHkYQ/34bsA
         tbFIecwArgvpgipbUl7/BlIjJehX7XgmYQAK35znhs50q69v8U2TMXTM++7xGw7BDLg6
         AkF22YoR/pYHqgm8kyWzjJ7eyLyBmU3wdMQ+HpXeyGk6LmzlK6i6xvHWz8hLZqoCts2w
         9/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=qCbGoJo5vDVBpfq5sCcy04qfBVc7axku9ZcIgphppqc=;
        b=cT9KCtw8td/03LJMMu4MK0wRAZ6nvEv+bBJuXVlYs5DZxVYOnhuhOaCqRRPV9LUSHl
         Yfy1hGOOzeCWOwOy6nfbJ43jZsBmPdjiAbhSSkc7VEIN1yOG5oyOp6vyBR/jJaySz9U6
         BzrYbhZJPbmlYExSxuEuWofTBb6tRDXCWGiOK0Uw6JfZS9Tki7po6d4EdQoXmiLg7UuB
         U5x+qbdPdJ+UnH9frQQHJMuvqceXNoEoxoaCqOtE/2/cQtVLPoBtIMGYAbybIM/XwmFo
         nawRdnfBozkw73FP9F9ycL+e7JfBOQDQ4EW3b02pOm9R7LGTau4WfuzKTYbjjWopU9q3
         tT8Q==
X-Gm-Message-State: APjAAAWPRssW9CWAFIx2fad67OAa7dXLqO/+L+HwiuCHtRDqMTDZzEYA
        fmttJRoiAIoPKbchd7bG9gs=
X-Google-Smtp-Source: APXvYqzJkm9a88lzR5kZflzdNv38xTcyFV2pCPjnfpJgKh7W7GiS8COdDrBcfvFv+9+QmsLU24HMOg==
X-Received: by 2002:a5d:6706:: with SMTP id o6mr48958950wru.36.1555312136815;
        Mon, 15 Apr 2019 00:08:56 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id y127sm20351263wmg.29.2019.04.15.00.08.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 00:08:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/7] help -a: do not list commands that are excluded from the build
References: <pull.168.git.gitgitgadget@gmail.com>
        <7dc5293e9e0f8997674b1273393f22954e72c4cd.1555070430.git.gitgitgadget@gmail.com>
Date:   Mon, 15 Apr 2019 16:08:55 +0900
Message-ID: <xmqqo957sq2g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When built with NO_CURL or with NO_UNIX_SOCKETS, some commands are
> skipped from the build. It does not make sense to list them in the
> output of `git help -a`, so let's just not.

The objective makes sense quite a lot.

>  command-list.h: $(wildcard Documentation/git*.txt) Documentation/*config.txt Documentation/config/*.txt
> -	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh command-list.txt >$@+ && mv $@+ $@
> +	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh \
> +		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \

Each whitespace separated token on $(EXCLUDED_PROGRAMS) is the name
of a program to be excluded and we know there is no funny characters
in it, hence quoing in "^$1 " (without protecting us against
funnies) is sufficient.

> +		command-list.txt >$@+ && mv $@+ $@
>  
>  SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
>  	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
> diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
> index 709d67405b..7867b99d19 100755
> --- a/generate-cmdlist.sh
> +++ b/generate-cmdlist.sh
> @@ -6,7 +6,7 @@ die () {
>  }
>  
>  command_list () {
> -	grep -v '^#' "$1"
> +	eval grep -ve '^#' $exclude_programs "$1"

The original protects against $IFS in the filename given as $1, but
with the eval that is no longer true.  We have been feeding the
constant "command-list.txt" to the program since its inception, and
I do not expect it to change, so this regression in defensiveness
does not matter in practice.  Also because # is prefixed with ^, the
unintended loss of quotes around it when the eval makes the shell
re-parse the generated command line would not make the remainder
into a comment.

But it does look brittle, and smells like a trap for less
experienced shell programmers to blindly copy & paste & tweak
without understanding what is going on, leading to bugs.

	eval "grep -v -e '^#' $exclude_programs" <"$1"

or something like that, perhaps?

> @@ -93,6 +93,14 @@ EOF
>  EOF
>  }
>  
> +exclude_programs=
> +while test "a$1" = "a--exclude-program"

s/a/z/g; if you want to pretend to be old-fashioned, but s/a//g;
should be sufficient in the modern world.

> +do
> +	shift
> +	exclude_programs="$exclude_programs -e \"^$1 \""
> +	shift
> +done

As I said, this part looks good enough given the things we feed as
parameters to --exclude-program option.

Thanks.
