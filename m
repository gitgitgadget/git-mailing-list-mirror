Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 037EC20C13
	for <e@80x24.org>; Wed, 29 Nov 2017 02:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752895AbdK2CG6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 21:06:58 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:44418 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbdK2CGz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 21:06:55 -0500
Received: by mail-it0-f45.google.com with SMTP id b5so2208562itc.3
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 18:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BibimqWfFQ4bz0RyvbLXKZBxsaCjG/pgZ3GliHCRIlA=;
        b=DlpM/MTeVHxId/MnQVXTBNdSOG6oMJoKBukr6S875mK6I5xXZGmQqmhnxyN25b9ASz
         3ZNScgYwx65y3Sx/BwFEJrjQPnSEhQ1NT6OxZpeh7TvWC+iCCiCPNu1eMhlsJHY8fqt6
         EAztdIrEAPIBBXIwYPGdaz+Dr0b/NJM9T9yrLqbxZx9bo4Aoki/cLG+CdRFOhh/ehE82
         EdBoyEpI5IlmMDwkRBeZ/sP71I9xhOPG0mY7g1Dir6K9n/UN+1YyYFCiwe4x129l9iRp
         A9FP/8e0Ao54IENem7zgssIP/Xpo6JiAt3TvzPhLTXcVAfNfoIe23qv2snl/Di+r0MHJ
         HDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BibimqWfFQ4bz0RyvbLXKZBxsaCjG/pgZ3GliHCRIlA=;
        b=RGQQSYd9WGm2EUdYJQXxnOaKIDU9OkQHo46QI0OxlMybNl8taHhUGMv+BH+llvtdWp
         1mfAy5zzLHLFCpdFNisZbbvwwpCVo5o1UevScdKjAjyAfFr1s0jGjbRaiIUKYJSyCXw2
         0C9cXc2i89bxZG2OocqQ+Ok2z7GWKbiYHJXoTVNwNeqCenAK8H+U4zExYkMOXEaWnBs/
         mEbY9gPHSF6jg/4IZ9F7s6X3A0vu89LmtjnUb6aUvzecblAbkIOg5GAXZmq0B1cnNXyZ
         9hFExfcEX4hTrmHsiUOc1cwqRMc0xQTIG4VJkR+Y5r3Jjr7q7h5nXi7OP3hPj17yzzKJ
         f4yg==
X-Gm-Message-State: AJaThX6xRtC0h/sMykDl1Vl8ljSTQRTizArq2yyvM2576iywNO1oA0Pb
        EqxkrHloXtddFuL9JJjfbZU=
X-Google-Smtp-Source: AGs4zMbik4ppb3zxj9drfE3xlxdrh8clzAESwDR2XBbA3mRvYaBWYz4o8RergS/GzadAgmdbG0OQUA==
X-Received: by 10.36.44.197 with SMTP id i188mr5376256iti.40.1511921214831;
        Tue, 28 Nov 2017 18:06:54 -0800 (PST)
Received: from [192.168.3.104] (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id n7sm292646ioi.57.2017.11.28.18.06.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Nov 2017 18:06:54 -0800 (PST)
From:   liam Beguin <liambeguin@gmail.com>
Subject: Re: [PATCH 3/5] rebase -i: add exec commands via the rebase--helper
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171127045514.25647-4-liambeguin@gmail.com>
 <alpine.DEB.2.21.1.1711272241590.6482@virtualbox>
Message-ID: <6b4e8352-0583-11c2-43ac-ec4ab33cc554@gmail.com>
Date:   Tue, 28 Nov 2017 21:06:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1711272241590.6482@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Thanks for taking the time to review this.

On 27/11/17 05:42 PM, Johannes Schindelin wrote:
> Hi Liam,
> 
> could I ask for a favor? I'd like the oneline to start with
> 
> 	rebase -i -x: ...
> 
> (this would help future me to realize what this commit touches already
> from the concise graph output I favor).

Sure, I'll update the commit subject.

> 
> On Sun, 26 Nov 2017, Liam Beguin wrote:
> 
>> Recent work on `git-rebase--interactive` aim to convert shell code to C.
>> Even if this is most likely not a big performance enhacement, let's
>> convert it too since a comming change to abbreviate command names requires
>> it to be updated.
> 
> Since Junio did not comment on the commit message: could you replace
> `aim` by `aims`, `enhacement` by `enhancement` and `comming` by `coming`?

Ow.. sorry about that! I'll fix those and make sure to proofread better next time!

> 
>> @@ -36,6 +37,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>>  			N_("skip unnecessary picks"), SKIP_UNNECESSARY_PICKS),
>>  		OPT_CMDMODE(0, "rearrange-squash", &command,
>>  			N_("rearrange fixup/squash lines"), REARRANGE_SQUASH),
>> +		OPT_CMDMODE(0, "add-exec", &command,
>> +			N_("insert exec commands in todo list"), ADD_EXEC),
> 
> Maybe `add-exec-commands`? I know it is longer to type, but these options do
> not need to be typed interactively and the longer name would be consistent
> with the function name.

Makes sense. It'll also be more consistent with the rest of the commands above.

> 
>> diff --git a/sequencer.c b/sequencer.c
>> index fa94ed652d2c..810b7850748e 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -2492,6 +2492,52 @@ int sequencer_make_script(int keep_empty, FILE *out,
>>  	return 0;
>>  }
>>  
> 
> As the code in add_exec_commands() may appear convoluted (why not simply
> append the command after any pick?), the original comment would be really
> nice here:
> 
> 	/*
> 	 * Add commands after pick and (series of) squash/fixup commands
> 	 * in the todo list.
> 	 */
> 

I'll make sure to include that comment.
The code is a bit convoluted as you say... I wanted to send it "as is" first
to get comments and update based on feedback from the list.

I just realized we could maybe add exec instructions only after pick commands
if we do add-exec-commands before rearrange-squash. I'll test it out.

>> +int add_exec_commands(const char *command)
>> +{
>> +	const char *todo_file = rebase_path_todo();
>> +	struct todo_list todo_list = TODO_LIST_INIT;
>> +	int fd, res, i, first = 1;
>> +	FILE *out;
>> +
>> +	strbuf_reset(&todo_list.buf);
> 
> The todo_list.buf has been initialized already (via TODO_LIST_INIT), no
> need to reset it again.
> 
>> +	fd = open(todo_file, O_RDONLY);
>> +	if (fd < 0)
>> +		return error_errno(_("could not open '%s'"), todo_file);
>> +	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
>> +		close(fd);
>> +		return error(_("could not read '%s'."), todo_file);
>> +	}
>> +	close(fd);
> 
> As Junio pointed out so gently: there is a helper function that does this
> all very conveniently for us:
> 
> 	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
> 		return error_errno(_("could not read '%s'"), todo_file);
> 
> And as I realized looking at the surrounding code: you probably just
> inherited my inelegant code by copy-editing from another function in
> sequencer.c. Should you decide to add a preparatory patch to your patch
> series that converts these other callers, or even refactors all that code
> that reads the git-rebase-todo file and then parses it, I would be quite
> happy... :-) (although I would understand if you deemed this outside the
> purpose of your patch series).
> 

You guessed well, I mostly did copy-editing... I thought I found this code
a little confusing because I'm not used to as much pointer gymnastics but
it reassures me a bit to read this :-). I'll see if I can come up with a
better solution.

>> +	res = parse_insn_buffer(todo_list.buf.buf, &todo_list);
>> +	if (res) {
>> +		todo_list_release(&todo_list);
>> +		return error(_("unusable todo list: '%s'"), todo_file);
>> +	}
> 
> The variable `res` is not really used here. Let's just put the
> parse_insn_buffer() call inside the if ().
> 

Will do.

>> +	out = fopen(todo_file, "w");
>> +	if (!out) {
>> +		todo_list_release(&todo_list);
>> +		return error(_("unable to open '%s' for writing"), todo_file);
>> +	}
>> +	for (i = 0; i < todo_list.nr; i++) {
>> +		struct todo_item *item = todo_list.items + i;
>> +		int bol = item->offset_in_buf;
>> +		const char *p = todo_list.buf.buf + bol;
>> +		int eol = i + 1 < todo_list.nr ?
>> +			todo_list.items[i + 1].offset_in_buf :
>> +			todo_list.buf.len;
> 
> This smells like another copy-edited snippet that originated from my
> brain, and I am not at all proud by the complexity I used there.
> 
> The function should also check for errors during writing. So how about
> something like this instead?
> 
> 	struct strbuf *buf = &todo_list.buf;
> 	size_t offset = 0, command_len = strlen(command);
> 	int first = 1, i;
> 	struct todo_item *item;
> 
> 	...
> 
> 	/* insert <command> before every pick except the first one */
> 	for (item = todo_list.items, i = 0; i < todo_list.nr; i++, item++)
> 		if (item->command == TODO_PICK) {
> 			if (first)
> 				first = 0;
> 			else {
> 				strbuf_splice(buf,
> 					      item->offset_in_buf + offset, 0,
> 					      command, command_len);
> 				offset += command_len;
> 			}
> 		}
> 
> 	/* append a final <command> */
> 	strbuf_complete_list(buf);
> 	strbuf_add(buf, command, command_len);
> 
> 	i = write_message(buf->buf, buf->len, todo_file, 0);
> 	todo_list_release(&todo_list);
> 	return i;
> 

I'll see how I can include this if calling add-exec-commands before
rearrange-squash works. But it definitely is lighter to read.

> Ciao,
> Dscho
> 

Thanks again,

Liam
