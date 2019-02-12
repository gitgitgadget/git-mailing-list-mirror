Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC4D51F453
	for <e@80x24.org>; Tue, 12 Feb 2019 15:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfBLPVe (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 10:21:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51903 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfBLPVe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 10:21:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so3399354wmj.1
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 07:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VaVTW1O6RlGiYmVt95bRc9ViAUEeKsWMhEoIY/uURBg=;
        b=gj02NrHQlz5CrwTtaQl3skS5zP7xtro4Pa9pR7NHpW4doQr782UJ28RWS4XjXWqFHC
         tliGGu7zBDfXny4s07/lcwHC93kHETirZ9LSVAAZltaf5QESZOp7VmMcL2SA9t9Hx5DM
         sxRgO87InHHWhzOg0cCYQQhwxRXM8vsJmR/uhbYNjY20M3V6GGDsQcfBBKBNLlLZSRQZ
         PmAYWRsZCpOOQkkRnm8Qb9DuqHbXksyXFfCmAfUThVo7UmCqpiCnmu1PxphzKaI7zSKJ
         FH8/N2CKsmJSnt3rji0Pi2vBoHBstDGcJ2OD/SRPP2PBdIOjNl8rMapa5xehWLYRj2kB
         0Qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VaVTW1O6RlGiYmVt95bRc9ViAUEeKsWMhEoIY/uURBg=;
        b=lO19u3gCwBEHn7UNRTaoHMeggmFmVNoAMQ0NbfrElF1mu1UPYLTXuzZ+ue/DmbzIh6
         2UBwRehDRu22+U+Q1Dpyffvhuhof0/7rnoB64ie4VIYzpAzqFzFFm+YLHGyE6/yYDkmJ
         LmB7/FqrazqgMgT5yqd7c9abZ10wzwslFuctTxcJG+Z0zykhT2M2e1xPZVWqhSqc9ld6
         sLkq1a4sOT9Mg9vQAAWs6bSHMsx3po9U8MdTlyepgvBv5+8n161o77AefKhN3ne+hatE
         3DvG+zzjG0FXcg110FXeKLHuLWZ4xlppiQZfe/q16IGZy+sZzNYhrA3/aOUsNspX0mbg
         Zh8Q==
X-Gm-Message-State: AHQUAuY5GbeZNVyK8vQi4JWddv8gIr/Ht5CpytnkpwUF025eaaC71jcI
        nap7VLnIVB8NukTGS5+A2QxCENs1
X-Google-Smtp-Source: AHgI3IYGZBqaGFuZu7P3FurB2UsjlTewqXjAYqy/QS0GtXkFNGFdbZJLZpqlSMecrs8m6bhumkcEOA==
X-Received: by 2002:a1c:4e17:: with SMTP id g23mr3480074wmh.78.1549984891199;
        Tue, 12 Feb 2019 07:21:31 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-658-1-21-92.w86-222.abo.wanadoo.fr. [86.222.20.92])
        by smtp.gmail.com with ESMTPSA id n11sm8812805wrw.60.2019.02.12.07.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 07:21:30 -0800 (PST)
Subject: Re: [PATCH v7 07/16] sequencer: refactor
 sequencer_add_exec_commands() to work on a todo_list
To:     phillip.wood@dunelm.org.uk, Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20190129150159.10588-1-alban.gruin@gmail.com>
 <20190210132648.12821-1-alban.gruin@gmail.com>
 <20190210132648.12821-8-alban.gruin@gmail.com>
 <4c8f904a-329c-a42c-c2a4-06d5b348dce3@talktalk.net>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d334fd63-4053-7034-64f9-eee82bdd06c2@gmail.com>
Date:   Tue, 12 Feb 2019 16:21:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <4c8f904a-329c-a42c-c2a4-06d5b348dce3@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Le 12/02/2019 à 11:52, Phillip Wood a écrit :
> Hi Alban
> 
> I think this is almost there, I've got a couple of small comments below.
> 
> On 10/02/2019 13:26, Alban Gruin wrote:
>> -%<-
>> diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
>> index df19ccaeb9..c131fd4a27 100644
>> --- a/builtin/rebase--interactive.c
>> +++ b/builtin/rebase--interactive.c
>> -%<-
>> @@ -221,6 +222,11 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>>  		warning(_("--[no-]rebase-cousins has no effect without "
>>  			  "--rebase-merges"));
>>  
>> +	if (cmd && *cmd) {
>> +		string_list_split(&commands, cmd, '\n', -1);
> 
> I'd suggest a comment along the lines of
> /* As cmd always ends with a newline the last item is empty */
> 
>> +		--commands.nr;
> 
> Style: commands.nr--
> 
>> +	}
>> +
>>  	switch (command) {
>>  	case NONE:
>>  		if (!onto && !upstream)
>> @@ -228,7 +234,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>>  
>>  		ret = do_interactive_rebase(&opts, flags, switch_to, upstream, onto,
>>  					    onto_name, squash_onto, head_name, restrict_revision,
>> -					    raw_strategies, cmd, autosquash);
>> +					    raw_strategies, &commands, autosquash);
>>  		break;
>>  	case SKIP: {
>>  		struct string_list merge_rr = STRING_LIST_INIT_DUP;
>> @@ -262,11 +268,12 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>>  		ret = rearrange_squash(the_repository);
>>  		break;
>>  	case ADD_EXEC:
>> -		ret = sequencer_add_exec_commands(the_repository, cmd);
>> +		ret = sequencer_add_exec_commands(the_repository, &commands);
>>  		break;
>>  	default:
>>  		BUG("invalid command '%d'", command);
>>  	}
> 
> Before freeing the string list it would be good to reset the number of
> items with commands.nr++ (with a comment explaining why) so the NUL in
> the last item gets freed.
> 
>> +	string_list_clear(&commands, 1);
> 
> As we don't use item.util I think the second argument would be better as 0.
> 
>>  	return !!ret;
>>  }

FWIW I just stumbled across string_list_remove_empty_items(), which
seems to do exactly the same thing, but that way we don’t have to do
this kind of hacks.

>> diff --git a/sequencer.c b/sequencer.c
>> index 99e12c751e..82ca3432cd 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -4505,21 +4505,27 @@ int sequencer_make_script(struct repository *r, FILE *out,
>>   * Add commands after pick and (series of) squash/fixup commands
>>   * in the todo list.
>>   */
>> -int sequencer_add_exec_commands(struct repository *r,
>> -				const char *commands)
>> +static void todo_list_add_exec_commands(struct todo_list *todo_list,
>> +					struct string_list *commands)
>>  {
>> -	const char *todo_file = rebase_path_todo();
>> -	struct todo_list todo_list = TODO_LIST_INIT;
>> -	struct strbuf *buf = &todo_list.buf;
>> -	size_t offset = 0, commands_len = strlen(commands);
>> -	int i, insert;
>> +	struct strbuf *buf = &todo_list->buf;
>> +	size_t base_offset = buf->len;
>> +	int i, insert, nr = 0, alloc = 0;
>> +	struct todo_item *items = NULL, *base_items = NULL;
>>  
>> -	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
>> -		return error(_("could not read '%s'."), todo_file);
>> +	base_items = xcalloc(commands->nr, sizeof(struct todo_item));
>> +	for (i = 0; i < commands->nr; i++) {
>> +		size_t command_len = strlen(commands->items[i].string);
>>  
>> -	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
>> -		todo_list_release(&todo_list);
>> -		return error(_("unusable todo list: '%s'"), todo_file);
>> +		strbuf_addstr(buf, commands->items[i].string);
>> +		strbuf_addch(buf, '\n');
>> +
>> +		base_items[i].command = TODO_EXEC;
>> +		base_items[i].offset_in_buf = base_offset;
>> +		base_items[i].arg_offset = base_offset + strlen("exec ");
>> +		base_items[i].arg_len = command_len - strlen("exec ");
>> +
>> +		base_offset += command_len + 1;
>>  	}
>>  
>>  	/*
>> @@ -4527,39 +4533,60 @@ int sequencer_add_exec_commands(struct repository *r,
>>  	 * are considered part of the pick, so we insert the commands *after*
>>  	 * those chains if there are any.
>>  	 */
>> -	insert = -1;
>> -	for (i = 0; i < todo_list.nr; i++) {
>> -		enum todo_command command = todo_list.items[i].command;
>> -
>> -		if (insert >= 0) {
>> -			/* skip fixup/squash chains */
>> -			if (command == TODO_COMMENT)
>> -				continue;
>> -			else if (is_fixup(command)) {
>> -				insert = i + 1;
>> -				continue;
>> -			}
>> -			strbuf_insert(buf,
>> -				      todo_list.items[insert].offset_in_buf +
>> -				      offset, commands, commands_len);
>> -			offset += commands_len;
>> -			insert = -1;
> 
> I like the simplification of using insert as a flag. Perhaps we should
> document the assumptions. Maybe something like
> 
> We insert the exec commands immediately after rearranging any fixups and
> before the user edits the list. This means that a fixup chain can never
> contain comments (any comments are empty picks that have been commented
> out the the user did not specify --keep-empty) and so it is safe to
> insert the exec command without looking at the command following the
> comment.
> 

I slightly reworded this and added it to the existing comment just
before the for loop:

	/*
	 * Insert <commands> after every pick. Here, fixup/squash chains
	 * are considered part of the pick, so we insert the commands *after*
	 * those chains if there are any.
	 *
	 * As we insert the exec commands immediatly after rearranging
	 * any fixups and before the user edits the list, a fixup chain
	 * can never contain comments (any comments are empty picks that
	 * have been commented out because the user did not specify
	 * --keep-empty).  So, it is safe to insert an exec command
	 * without looking at the command following a comment.
	 */

>> +	insert = 0;
>> +	for (i = 0; i < todo_list->nr; i++) {
>> +		enum todo_command command = todo_list->items[i].command;
>> +		if (insert && !is_fixup(command)) {
>> +			ALLOC_GROW(items, nr + commands->nr, alloc);
>> +			COPY_ARRAY(items + nr, base_items, commands->nr);
>> +			nr += commands->nr;
>> +
>> +			insert = 0;
>>  		}
>>  
>> -		if (command == TODO_PICK || command == TODO_MERGE)
>> -			insert = i + 1;
>> +		ALLOC_GROW(items, nr + 1, alloc);
>> +		items[nr++] = todo_list->items[i];
>> +
>> +		if (command == TODO_PICK || command == TODO_MERGE || is_fixup(command))
> 
> I'm not sure what the is_fixup() is for, if the command is a fixup then
> it will have been preceded by a pick or merge so insert will already be 1
> 
> I feel a bit mean suggesting a reroll when we're on v7 already but I
> think these clean-ups would improve the maintainability of the code.
> I'll take a look at the rest of the changes to this series sometime this
> week.
> 
> Best Wishes
> 
> Phillip
> 

Cheers,
Alban

