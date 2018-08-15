Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 578A61F404
	for <e@80x24.org>; Wed, 15 Aug 2018 18:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeHOU6s (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 16:58:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43439 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeHOU6r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 16:58:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id b15-v6so1840623wrv.10
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 11:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fFYQTOE/JPpaOaYNEfjVD6/7NHeLo8nOWaLZ+dZVQIg=;
        b=rfMoUZ9pXQjnjwNKZWUkCDYudUvmLXvfjR6PF7UVGUsNlj62hMWBoEWnZlDHg9A0Qw
         cyBDp3OD6ew7IcXVdsl6aCxxJFTwxqD5wgwOUonptb4qNEB7otv+GedM5F1IXjLxYBjP
         A2qgpVX2BsU4o7YMFKvY+GGTDe1wSddRufluzqPc6fCQ22pX8iSP2CFdY7D2CFP6yskU
         goJZjJ4dk8RbVlXBkVKqz4p/KpJq9VDN7U6Qe5BPl7d90WVqvGIWGSfD6VWA1vviTMde
         BCAK0W720f/YBp1a5rwQfAfz4twDyoEBhGqEOb6973K0E1iu/Lt/jUDKxOzvSlARe2Bz
         Ax+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fFYQTOE/JPpaOaYNEfjVD6/7NHeLo8nOWaLZ+dZVQIg=;
        b=uJw56ZdEKv3UzW8win9ljemLhHcHnZpkvYv/e/2h/R2y0D4VO1L5yq/96hC99zFjQL
         IWTxb22iEi/PHjGwu065BCyG/tkyWTk6POI6J0phoLduWFDzVbjSFAijM9DdTrs89PjO
         PUQ4vhXtVmKHnE0TfFu2bTF9XZJjnjVMuK/+QWCY3oti14DJQC63mjyA0DNYXQe0u50u
         cdmzKxK+EMHqBU3qRTnUYCn2Nm5RqyjIs6tFFxq6AT75Jdv5QPsCtAUzHcPHpuyn9IT/
         n6Bw8Mz6+y3jaViuWzGoJvV7g+QLIg9plX/NC1vX1wwr4bHQKho1+dWTzbSlBY8c/jek
         Tt7g==
X-Gm-Message-State: AOUpUlGylBhX6/ApAkIOZ8F+CcPDyi9czw3cP1L9yKvwseSII43UduSX
        40t47fxDcftvQzueqekS9Uk=
X-Google-Smtp-Source: AA+uWPwu9mADfYK18XE4Z+b+LqZgfrpqMG27p3eXxBoFFI5ZUynALcQ9bzq3X5EIOTUvGqJ9UQI+iA==
X-Received: by 2002:adf:f485:: with SMTP id l5-v6mr17875320wro.259.1534356334839;
        Wed, 15 Aug 2018 11:05:34 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r13-v6sm1208867wmf.35.2018.08.15.11.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 11:05:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: fix numbering in squash message
References: <20180815094125.12530-1-phillip.wood@talktalk.net>
Date:   Wed, 15 Aug 2018 11:05:33 -0700
In-Reply-To: <20180815094125.12530-1-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Wed, 15 Aug 2018 10:41:25 +0100")
Message-ID: <xmqqbma3ijyq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Commit e12a7ef597 ("rebase -i: Handle "combination of <n> commits" with
> GETTEXT_POISON", 2018-04-27) changed the way that individual commit
> messages are labelled when squashing commits together. In doing so a
> regression was introduced where the numbering of the messages is off by
> one. This commit fixes that and adds a test for the numbering.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  sequencer.c                | 4 ++--
>  t/t3418-rebase-continue.sh | 4 +++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 2eb5ec7227..77d3c2346f 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1387,13 +1387,13 @@ static int update_squash_messages(enum todo_command command,
>  		unlink(rebase_path_fixup_msg());
>  		strbuf_addf(&buf, "\n%c ", comment_line_char);
>  		strbuf_addf(&buf, _("This is the commit message #%d:"),
> -			    ++opts->current_fixup_count);
> +			    ++opts->current_fixup_count + 1);
>  		strbuf_addstr(&buf, "\n\n");
>  		strbuf_addstr(&buf, body);
>  	} else if (command == TODO_FIXUP) {
>  		strbuf_addf(&buf, "\n%c ", comment_line_char);
>  		strbuf_addf(&buf, _("The commit message #%d will be skipped:"),
> -			    ++opts->current_fixup_count);
> +			    ++opts->current_fixup_count + 1);
>  		strbuf_addstr(&buf, "\n\n");
>  		strbuf_add_commented_lines(&buf, body, strlen(body));
>  	} else

Good spotting.  When viewed in a wider context (e.g. "git show -W"
after applying this patch), the way opts->current_fixup_count is
used is somewhat incoherent and adding 1 to pre-increment would make
it even more painful to read.  Given that there already is

		strbuf_addf(&header, _("This is a combination of %d commits."),
			    opts->current_fixup_count + 2);

before this part, the code should make it clear these three places
refer to the same number for it to be readable.

I wonder if it makes it easier to read, understand and maintain if
there were a local variable that gets opts->current_fixup_count+2 at
the beginning of the function, make these three places refer to that
variable, and move the increment of opts->current_fixup_count down
in the function, after the "if we are squashing, do this, if we are
fixing up, do that, otherwise, we do not know what we are doing"
cascade.  And use the more common post-increment, as we no longer
depend on the returned value while at it.

IOW, something like this (untested), on top of yours.

 sequencer.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 77d3c2346f..f82c283a89 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1331,8 +1331,9 @@ static int update_squash_messages(enum todo_command command,
 	struct strbuf buf = STRBUF_INIT;
 	int res;
 	const char *message, *body;
+	int fixup_count = opts->current_fixup_count + 2;
 
-	if (opts->current_fixup_count > 0) {
+	if (fixup_count > 2) {
 		struct strbuf header = STRBUF_INIT;
 		char *eol;
 
@@ -1345,7 +1346,7 @@ static int update_squash_messages(enum todo_command command,
 
 		strbuf_addf(&header, "%c ", comment_line_char);
 		strbuf_addf(&header, _("This is a combination of %d commits."),
-			    opts->current_fixup_count + 2);
+			    fixup_count);
 		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
 		strbuf_release(&header);
 	} else {
@@ -1387,18 +1388,19 @@ static int update_squash_messages(enum todo_command command,
 		unlink(rebase_path_fixup_msg());
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
 		strbuf_addf(&buf, _("This is the commit message #%d:"),
-			    ++opts->current_fixup_count + 1);
+			    fixup_count);
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_addstr(&buf, body);
 	} else if (command == TODO_FIXUP) {
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
 		strbuf_addf(&buf, _("The commit message #%d will be skipped:"),
-			    ++opts->current_fixup_count + 1);
+			    fixup_count);
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_add_commented_lines(&buf, body, strlen(body));
 	} else
 		return error(_("unknown command: %d"), command);
 	unuse_commit_buffer(commit, message);
+	opts->current_fixup_count++;
 
 	res = write_message(buf.buf, buf.len, rebase_path_squash_msg(), 0);
 	strbuf_release(&buf);


