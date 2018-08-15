Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC8931F404
	for <e@80x24.org>; Wed, 15 Aug 2018 19:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeHOWLW (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 18:11:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39131 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbeHOWLW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 18:11:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so2009695wre.6
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 12:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YimNIGHvOQUISmZU+N8KdTP0OHXqVy/MeW8zzkp6weM=;
        b=gKChRWjTn7/WAEim3XJbvbemHAF523y+OBpImXr/IszRKsfbkN5My0GGqg8J4Fo37+
         /93Ir6ojdJdwSOODpYNEITsa457EpAnqDzkxEC27pUPEOpWLOcSOUlIGseG3LE6XweyR
         D7wuAlfyZB/6frw+R1KEOnU+FNOYymMXuvtNzj8ZRqFQMFS7/GsGfqh6TzQ0Oul8w/gy
         YpmK0jPsjsElmzEmzenDxklZAiKiTDiN0naGdLz0Cz4cJbxfiviZJ8zupgR2Qpd7MiCZ
         0jaRM+IaDLDiP+Qs2PMTBdp1hTT6t2hJfmC2A5spzMUy5OrJKk/W3iD/6JCaRJy6rAAH
         3xaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YimNIGHvOQUISmZU+N8KdTP0OHXqVy/MeW8zzkp6weM=;
        b=mSXKMdpX9XA0lBHoUhXWW5teVGkfVKN4/Vhow+RMKlA7hLGHbojcGoaZ+J+4wGsGJ8
         SsHtgfJQTBcEH6XyMo5rIa2m3gUivLT5b1YziTc+YWUhhzHABKtDbU3yIsPtGdY02EFU
         1b+Ux26stRZtrEhugxvvh5Fqa6Mqq8yWF+vxd15Iea7D+4wzsWPwa+iATnI5DpOX1Old
         q3AW461qaQc0/YFyGD+3N+ARbgpsr54iI1PfMnVbPTElo535Azbq5elY1Q/9iXMNrmyw
         Tj5Ks9iFw/l0F9cluGhOVzcIoPzBqOqS9JPFOwTnCvmosun7PkDwc9RLBVQPJBn3Pa7O
         oIGw==
X-Gm-Message-State: AOUpUlEUFMxgVBFyfin7HorbcE//nqJzXz2SLNlfsLI9UEZoNHd1WBSz
        m8+pee2gZlPGaIEof7UDGCw=
X-Google-Smtp-Source: AA+uWPxxxPYbrxGt1AtqT9vlawnxEQ/8+xWJXTpGpmrxQKZzsn6eb7WoQU8ufLDm9wPr7Xuslze+tQ==
X-Received: by 2002:a5d:52c4:: with SMTP id r4-v6mr15848437wrv.98.1534360674264;
        Wed, 15 Aug 2018 12:17:54 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q3-v6sm1675679wmf.21.2018.08.15.12.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 12:17:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: fix numbering in squash message
References: <20180815094125.12530-1-phillip.wood@talktalk.net>
        <xmqqbma3ijyq.fsf@gitster-ct.c.googlers.com>
        <27c91e67-7567-f820-c641-c7980965fcef@talktalk.net>
Date:   Wed, 15 Aug 2018 12:17:52 -0700
In-Reply-To: <27c91e67-7567-f820-c641-c7980965fcef@talktalk.net> (Phillip
        Wood's message of "Wed, 15 Aug 2018 19:33:31 +0100")
Message-ID: <xmqqy3d7h21r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

>> I wonder if it makes it easier to read, understand and maintain if
>> there were a local variable that gets opts->current_fixup_count+2 at
>> the beginning of the function, make these three places refer to that
>> variable, and move the increment of opts->current_fixup_count down
>> in the function, after the "if we are squashing, do this, if we are
>> fixing up, do that, otherwise, we do not know what we are doing"
>> cascade.  And use the more common post-increment, as we no longer
>> depend on the returned value while at it.
>> 
>> IOW, something like this (untested), on top of yours.
>
> I think you'd need to change commit_staged_changes() as well as it
> relies on the current_fixup_count counting the number of fixups, not the
> number of fixups plus two.

I suspect you misread what I wrote (see below for the patch).  

The fixup_count is a new local variable in update_squash_messages()
that holds N+2; in other words, I am not suggesting to change what
opts->current_fixup_count means.

> Having said that using 'current_fixup_count +
> 2' to create the labels and incrementing the count at the end of
> update_squash_messages() would probably be clearer than my version. I'm
> about to go away so it'll probably be the second week of September
> before I can re-roll this, will that be too late for getting it into 2.19?

I actually do not mind to go with what you originally sent, unless a
cleaned up version is vastly more readable.  After all, a clean-up
can be done separately and safely.

Thanks.

>>  sequencer.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>> 
>> diff --git a/sequencer.c b/sequencer.c
>> index 77d3c2346f..f82c283a89 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -1331,8 +1331,9 @@ static int update_squash_messages(enum todo_command command,
>>  	struct strbuf buf = STRBUF_INIT;
>>  	int res;
>>  	const char *message, *body;
>> +	int fixup_count = opts->current_fixup_count + 2;
>>  
>> -	if (opts->current_fixup_count > 0) {
>> +	if (fixup_count > 2) {
>>  		struct strbuf header = STRBUF_INIT;
>>  		char *eol;
>>  
>> @@ -1345,7 +1346,7 @@ static int update_squash_messages(enum todo_command command,
>>  
>>  		strbuf_addf(&header, "%c ", comment_line_char);
>>  		strbuf_addf(&header, _("This is a combination of %d commits."),
>> -			    opts->current_fixup_count + 2);
>> +			    fixup_count);
>>  		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
>>  		strbuf_release(&header);
>>  	} else {
>> @@ -1387,18 +1388,19 @@ static int update_squash_messages(enum todo_command command,
>>  		unlink(rebase_path_fixup_msg());
>>  		strbuf_addf(&buf, "\n%c ", comment_line_char);
>>  		strbuf_addf(&buf, _("This is the commit message #%d:"),
>> -			    ++opts->current_fixup_count + 1);
>> +			    fixup_count);
>>  		strbuf_addstr(&buf, "\n\n");
>>  		strbuf_addstr(&buf, body);
>>  	} else if (command == TODO_FIXUP) {
>>  		strbuf_addf(&buf, "\n%c ", comment_line_char);
>>  		strbuf_addf(&buf, _("The commit message #%d will be skipped:"),
>> -			    ++opts->current_fixup_count + 1);
>> +			    fixup_count);
>>  		strbuf_addstr(&buf, "\n\n");
>>  		strbuf_add_commented_lines(&buf, body, strlen(body));
>>  	} else
>>  		return error(_("unknown command: %d"), command);
>>  	unuse_commit_buffer(commit, message);
>> +	opts->current_fixup_count++;
>>  
>>  	res = write_message(buf.buf, buf.len, rebase_path_squash_msg(), 0);
>>  	strbuf_release(&buf);
>> 
>> 
