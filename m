Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B48C11F454
	for <e@80x24.org>; Tue, 30 Oct 2018 16:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeJaBXH (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 21:23:07 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:19623 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbeJaBXH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 21:23:07 -0400
Received: from [192.168.2.240] ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id HWsvgWY5UpXFjHWswgC04D; Tue, 30 Oct 2018 16:28:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1540916934;
        bh=anPVaD515cx59WrmchmhAm1q6d56E+0RgA8FDmJ6IlI=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dvXD1/jAoWh1aabgJPHzQyNOmWxiuIICnRa1p53JMv+FS3vIidIxNeV6TP4SHIJ0y
         SS4Qw1DNciVCmhYmXErvWAORJhn5WSh1n9oQfLuD2R85qvWaVOl5ubkVYLPv035hL+
         +wR+yrWUPbdgF6mTIkC2As4ky2jxObku3cqFfe3c=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=4n960clBGhiagGxI3pkA:9 a=qrQXQc4nH5N94NyY:21 a=HlrRHbSzPSKji0NQ:21
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 04/16] sequencer: introduce todo_list_write_to_file()
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181027212930.9303-1-alban.gruin@gmail.com>
 <20181027212930.9303-5-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <03475c29-5317-b105-6102-5cae3a5ae926@talktalk.net>
Date:   Tue, 30 Oct 2018 16:28:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181027212930.9303-5-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfILEt5D2/AR+gKeJd7E4an11guwe3ek9vTyqaP9ZgCk6vD4Njjuhy4ZUBGVNxInMhsnVJbF/4thVBTPSEPv2rIm7JQQQC3ifroIkK8MbRdnlAMGUtakm
 Z84FqLI1Ftza4d7noV8019DAvcebTgXcrgXx8EDk5WzglTaJK62a2mG9+Ket/u5L/5WhUuLSOx/zMYuzZ0EkoaBgbwYLJ7tq6yjBqEgbdy7y6yMg9AIMKZqd
 MTJW9e9Y/OPfJWGppAizzSVbB60OmKpXsiOBGtV2d6A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

I like the direction this is going, it is an improvement on re-scanning 
the list at the end of each function.

On 27/10/2018 22:29, Alban Gruin wrote:
> This introduce a new function to recreate the text of a todo list from
> its commands, and then to write it to the disk.  This will be useful in
> the future, the buffer of a todo list won’t be treated as a strict
> mirror of the todo file by some of its functions once they will be
> refactored.

I'd suggest rewording this slightly, maybe something like

This introduces a new function to recreate the text of a todo list from
its commands and write it to a file. This will be useful as the next few 
commits will change the use of the buffer in struct todo_list so it will 
no-longer be a mirror of the file on disk.

> This functionnality can already be found in todo_list_transform(), but

s/functionnality/functionality/

> it is specifically made to replace the buffer of a todo list, which is
> not the desired behaviour.  Thus, the part of todo_list_transform() that
> actually creates the buffer is moved to a new function,
> todo_list_to_strbuf().  The rest is unused, and so is dropped.
> 
> todo_list_write_to_file() can also take care to append the help text to

s/care to append/care of appending/

> the buffer before writing it to the disk, or to write only the first n
> items of the list.

Why/when do we only want to write a subset of the items?

> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>   sequencer.c | 59 ++++++++++++++++++++++++++++++++++++-----------------
>   sequencer.h |  4 +++-
>   2 files changed, 43 insertions(+), 20 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 07296f1f57..0dd45677b1 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4256,24 +4256,27 @@ int sequencer_add_exec_commands(const char *commands)
>   	return i;
>   }
>   
> -void todo_list_transform(struct todo_list *todo_list, unsigned flags)
> +static void todo_list_to_strbuf(struct todo_list *todo_list, struct strbuf *buf,
> +				int num, unsigned flags)
>   {
> -	struct strbuf buf = STRBUF_INIT;
>   	struct todo_item *item;
> -	int i;
> +	int i, max = todo_list->nr;
>   
> -	for (item = todo_list->items, i = 0; i < todo_list->nr; i++, item++) {
> +	if (num > 0 && num < max)
> +		max = num;
> +
> +	for (item = todo_list->items, i = 0; i < max; i++, item++) {
>   		/* if the item is not a command write it and continue */
>   		if (item->command >= TODO_COMMENT) {
> -			strbuf_addf(&buf, "%.*s\n", item->arg_len, item->arg);
> +			strbuf_addf(buf, "%.*s\n", item->arg_len, item->arg);
>   			continue;
>   		}
>   
>   		/* add command to the buffer */
>   		if (flags & TODO_LIST_ABBREVIATE_CMDS)
> -			strbuf_addch(&buf, command_to_char(item->command));
> +			strbuf_addch(buf, command_to_char(item->command));
>   		else
> -			strbuf_addstr(&buf, command_to_string(item->command));
> +			strbuf_addstr(buf, command_to_string(item->command));
>   
>   		/* add commit id */
>   		if (item->commit) {
> @@ -4283,27 +4286,46 @@ void todo_list_transform(struct todo_list *todo_list, unsigned flags)
>   
>   			if (item->command == TODO_MERGE) {
>   				if (item->flags & TODO_EDIT_MERGE_MSG)
> -					strbuf_addstr(&buf, " -c");
> +					strbuf_addstr(buf, " -c");
>   				else
> -					strbuf_addstr(&buf, " -C");
> +					strbuf_addstr(buf, " -C");
>   			}
>   
> -			strbuf_addf(&buf, " %s", oid);
> +			strbuf_addf(buf, " %s", oid);
>   		}
>   
>   		/* add all the rest */
>   		if (!item->arg_len)
> -			strbuf_addch(&buf, '\n');
> +			strbuf_addch(buf, '\n');
>   		else
> -			strbuf_addf(&buf, " %.*s\n", item->arg_len, item->arg);
> +			strbuf_addf(buf, " %.*s\n", item->arg_len, item->arg);
>   	}
> +}
>   
> -	strbuf_reset(&todo_list->buf);
> -	strbuf_add(&todo_list->buf, buf.buf, buf.len);
> +int todo_list_write_to_file(struct todo_list *todo_list, const char *file,
> +			    const char *shortrevisions, const char *shortonto,
> +			    int command_count, int append_help, int num, unsigned flags)

This is a really long argument list which makes it easy for callers to 
get the parameters in the wrong order. I think append_help could 
probably be folded into the flags, I'm not sure what the command_count 
is used for but I've only read the first few patches. Maybe it would be 
better to pass a struct so we have named fields.

Best Wishes

Phillip

> +{
> +	int edit_todo = !(shortrevisions && shortonto), res;
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	todo_list_to_strbuf(todo_list, &buf, num, flags);
> +
> +	if (append_help) {
> +		if (!edit_todo) {
> +			strbuf_addch(&buf, '\n');
> +			strbuf_commented_addf(&buf, Q_("Rebase %s onto %s (%d command)",
> +						       "Rebase %s onto %s (%d commands)",
> +						       command_count),
> +					      shortrevisions, shortonto, command_count);
> +		}
> +		append_todo_help(edit_todo, flags & TODO_LIST_KEEP_EMPTY, &buf);
> +	}
> +
> +	res = write_message(buf.buf, buf.len, file, 0);
>   	strbuf_release(&buf);
>   
> -	if (todo_list_parse_insn_buffer(todo_list->buf.buf, todo_list))
> -		BUG("unusable todo list");
> +	return res;
>   }
>   
>   int transform_todo_file(unsigned flags)
> @@ -4320,9 +4342,8 @@ int transform_todo_file(unsigned flags)
>   		return error(_("unusable todo list: '%s'"), todo_file);
>   	}
>   
> -	todo_list_transform(&todo_list, flags);
> -
> -	res = write_message(todo_list.buf.buf, todo_list.buf.len, todo_file, 0);
> +	res = todo_list_write_to_file(&todo_list, todo_file,
> +				      NULL, NULL, 0, 0, -1, flags);
>   	todo_list_release(&todo_list);
>   	return res;
>   }
> diff --git a/sequencer.h b/sequencer.h
> index 029d842ac5..a299c977fe 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -113,7 +113,9 @@ struct todo_list {
>   #define TODO_LIST_INIT { STRBUF_INIT }
>   
>   int todo_list_parse_insn_buffer(char *buf, struct todo_list *todo_list);
> -void todo_list_transform(struct todo_list *todo_list, unsigned flags);
> +int todo_list_write_to_file(struct todo_list *todo_list, const char *file,
> +			    const char *shortrevisions, const char *shortonto,
> +			    int command_count, int append_help, int num, unsigned flags);
>   void todo_list_release(struct todo_list *todo_list);
>   
>   /* Call this to setup defaults before parsing command line options */
> 

