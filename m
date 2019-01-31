Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 909A61F453
	for <e@80x24.org>; Thu, 31 Jan 2019 20:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbfAaUh7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 15:37:59 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38131 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbfAaUh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 15:37:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so3996350wml.3
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 12:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YC2MTnomLqWE+D+r2tfknFiuFd7Mcys+kG+4oLvlZ8k=;
        b=tr860o0rE6Lc3ErOlgukXzbXY5NUtXkblBuHyJcA+jzXLuRmJUZ4bBtDH4kt/GzKca
         kPncKJjqc6Kuy5FlVEMcZDmCb+ltbCaQ1VisyBLIGd0YVUgxKmb2VbBoKZ3uWt2ktG17
         Oa+ZFRT29XWxGzpwRb8kIDscV2cXxH8TclzwVvQu6m6ejkLDxkKZ2OEeY2pJvfdUmn3b
         XViCOZE7O452B0r/Du5ZKXHex4pfK/2uUEL9NvRoedoaoQMaWg1sJEzF1l3ej+jaQcHX
         v3/ZbjONaer0LCwEVQ/aS1HuYuEKCWzfUEchZNJO2UqSc1pQJxFu35K4jWR8KOjRcO8l
         7qhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YC2MTnomLqWE+D+r2tfknFiuFd7Mcys+kG+4oLvlZ8k=;
        b=EJOx0nwXC07K0cJE1zNbXDFEC0F7BTcIGlWZeRSJXJnrFPRYwEbSVLB7FZc/FcE7tC
         1QiC2IZo4nT6lpC6BGoN3NYYLJOpwGcFlSqrH6j2JF6PQVLgnvwubw+eukRxRy/aOb6U
         Fh6sOna3u+f/sE05RnXe1z1gtRvHKMh/QZA+/B4dtltOnKWx1/CGKDk8wyvMqwAeuypz
         E0zfWKpt0YWScVn5dGajR3AIXv/GIZk4IQsRkMWyo2hQS1yEKrWM8VxlVV49KjSRRJ1+
         PRr53qdNM+fPzHamrQSWVzXfULu+ZvF76kV/+zVW0dqnXLIrE4t/2NNpGE/iduLqF3wx
         J4Fg==
X-Gm-Message-State: AJcUukcblcM6k67kQJbkNeVRz5DJWxapgPGv9YjukBQwZ8BnvMVQ95xJ
        HOteOCcZy7Q81aRahXUrPf0=
X-Google-Smtp-Source: ALg8bN5D/zTTUjoLBj1JdhqAoRqceuF33Qd7PHhIKIBcMpXBL2UAikXGYA6KSEc2N2geIUpvS9b6Xg==
X-Received: by 2002:a1c:b10a:: with SMTP id a10mr30226030wmf.148.1548967075901;
        Thu, 31 Jan 2019 12:37:55 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-658-1-47-104.w86-221.abo.wanadoo.fr. [86.221.54.104])
        by smtp.gmail.com with ESMTPSA id 60sm12450238wrb.81.2019.01.31.12.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 12:37:55 -0800 (PST)
Subject: Re: [PATCH v6 07/16] sequencer: refactor
 sequencer_add_exec_commands() to work on a todo_list
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20190123205821.27459-1-alban.gruin@gmail.com>
 <20190129150159.10588-1-alban.gruin@gmail.com>
 <20190129150159.10588-8-alban.gruin@gmail.com>
 <434cf0f7-1df6-7966-b460-e69e8f8b5e99@talktalk.net>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c5e3c1cc-12fa-ddf6-7008-ae47659ddc19@gmail.com>
Date:   Thu, 31 Jan 2019 21:37:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <434cf0f7-1df6-7966-b460-e69e8f8b5e99@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Le 31/01/2019 à 15:30, Phillip Wood a écrit :
> Hi Alban
> 
> On 29/01/2019 15:01, Alban Gruin wrote:
>> This refactors sequencer_add_exec_commands() to work on a todo_list to
>> avoid redundant reads and writes to the disk.
>>
>> Instead of inserting the `exec' commands between the other commands and
>> re-parsing the buffer at the end, they are appended to the buffer once,
>> and a new list of items is created.  Items from the old list are copied
>> across and new `exec' items are appended when necessary.  This
>> eliminates the need to reparse the buffer, but this also means we have
>> to use todo_list_write_to_disk() to write the file.
>>
>> todo_list_add_exec_commands() and sequencer_add_exec_commands() are
>> modified to take a string list instead of a string -- one item for each
>> command.  This makes it easier to insert a new command to the todo list
>> for each command to execute.
>>
>> sequencer_add_exec_commands() still reads the todo list from the disk,
>> as it is needed by rebase -p.
>>
>> complete_action() still uses sequencer_add_exec_commands() for now.
>> This will be changed in a future commit.
>>
>> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
>> ---
>>  builtin/rebase--interactive.c |  15 +++--
>>  sequencer.c                   | 110 +++++++++++++++++++++-------------
>>  sequencer.h                   |   5 +-
>>  3 files changed, 82 insertions(+), 48 deletions(-)
>>
>> diff --git a/builtin/rebase--interactive.c
>> b/builtin/rebase--interactive.c
>> index df19ccaeb9..53056ee713 100644
>> --- a/builtin/rebase--interactive.c
>> +++ b/builtin/rebase--interactive.c
>> @@ -65,7 +65,7 @@ static int do_interactive_rebase(struct replay_opts
>> *opts, unsigned flags,
>>                   const char *onto, const char *onto_name,
>>                   const char *squash_onto, const char *head_name,
>>                   const char *restrict_revision, char *raw_strategies,
>> -                 const char *cmd, unsigned autosquash)
>> +                 struct string_list *commands, unsigned autosquash)
>>  {
>>      int ret;
>>      const char *head_hash = NULL;
>> @@ -116,7 +116,7 @@ static int do_interactive_rebase(struct
>> replay_opts *opts, unsigned flags,
>>          discard_cache();
>>          ret = complete_action(the_repository, opts, flags,
>>                        shortrevisions, onto_name, onto,
>> -                      head_hash, cmd, autosquash);
>> +                      head_hash, commands, autosquash);
>>      }
>>  
>>      free(revisions);
>> @@ -139,6 +139,7 @@ int cmd_rebase__interactive(int argc, const char
>> **argv, const char *prefix)
>>      const char *onto = NULL, *onto_name = NULL, *restrict_revision =
>> NULL,
>>          *squash_onto = NULL, *upstream = NULL, *head_name = NULL,
>>          *switch_to = NULL, *cmd = NULL;
>> +    struct string_list commands = STRING_LIST_INIT_DUP;
>>      char *raw_strategies = NULL;
>>      enum {
>>          NONE = 0, CONTINUE, SKIP, EDIT_TODO, SHOW_CURRENT_PATCH,
>> @@ -221,6 +222,12 @@ int cmd_rebase__interactive(int argc, const char
>> **argv, const char *prefix)
>>          warning(_("--[no-]rebase-cousins has no effect without "
>>                "--rebase-merges"));
>>  
>> +    if (cmd && *cmd) {
>> +        string_list_split(&commands, cmd, '\n', -1);
> 
> This whole splitting and later skipping 'exec ' is a bit of a shame - it
> would be much nicer if we could just have one exec command per -x option
> but I think that is outside the scope of this series (If I have time I'd
> like to look at calling do_interactive_rebase() directly from
> builtin/rebase.c without forking rebase--interactive).
> 

Yes, I completely agree with you.  I thought to do this in preparation
to drop rebase -r.

>> +        if (strlen(commands.items[commands.nr - 1].string) == 0)
> 
> I'd be tempted just to test the string using !* rather than calling
> strlen. 
>

Right.  I’m still not used to this pattern.

> Also is there ever a case where the last string isn't empty?

I don’t think so.  When rebase.c prepares the arguments for
rebase--interactive, it always add a newline at the end[1].  Do you want
me to drop this check?


>> +            --commands.nr;
>> +    }
>> +
>>      switch (command) {
>>      case NONE:
>>          if (!onto && !upstream)
>> @@ -228,7 +235,7 @@ int cmd_rebase__interactive(int argc, const char
>> **argv, const char *prefix)
>>  
>>          ret = do_interactive_rebase(&opts, flags, switch_to,
>> upstream, onto,
>>                          onto_name, squash_onto, head_name,
>> restrict_revision,
>> -                        raw_strategies, cmd, autosquash);
>> +                        raw_strategies, &commands, autosquash);
>>          break;
>>      case SKIP: {
>>          struct string_list merge_rr = STRING_LIST_INIT_DUP;
>> @@ -262,7 +269,7 @@ int cmd_rebase__interactive(int argc, const char
>> **argv, const char *prefix)
>>          ret = rearrange_squash(the_repository);
>>          break;
>>      case ADD_EXEC:
>> -        ret = sequencer_add_exec_commands(the_repository, cmd);
>> +        ret = sequencer_add_exec_commands(the_repository, &commands);
>>          break;
>>      default:
>>          BUG("invalid command '%d'", command);
>> diff --git a/sequencer.c b/sequencer.c
>> index 266f80d704..3a90b419d7 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -4446,25 +4446,27 @@ int sequencer_make_script(struct repository
>> *r, FILE *out,
>>      return 0;
>>  }
>>  
>> -/*
>> - * Add commands after pick and (series of) squash/fixup commands
>> - * in the todo list.
>> - */
>> -int sequencer_add_exec_commands(struct repository *r,
>> -                const char *commands)
>> +static void todo_list_add_exec_commands(struct todo_list *todo_list,
>> +                    struct string_list *commands)
>>  {
>> -    const char *todo_file = rebase_path_todo();
>> -    struct todo_list todo_list = TODO_LIST_INIT;
>> -    struct strbuf *buf = &todo_list.buf;
>> -    size_t offset = 0, commands_len = strlen(commands);
>> -    int i, insert;
>> +    struct strbuf *buf = &todo_list->buf;
>> +    size_t base_offset = buf->len;
>> +    int i, insert, nr = 0, alloc = 0;
>> +    struct todo_item *items = NULL, *base_items = NULL;
>>  
>> -    if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
>> -        return error(_("could not read '%s'."), todo_file);
>> +    base_items = xcalloc(commands->nr, sizeof(struct todo_item));
>> +    for (i = 0; i < commands->nr; ++i) {
>> +        size_t command_len = strlen(commands->items[i].string);
>>  
>> -    if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
>> -        todo_list_release(&todo_list);
>> -        return error(_("unusable todo list: '%s'"), todo_file);
>> +        strbuf_addstr(buf, commands->items[i].string);
>> +        strbuf_addch(buf, '\n');
>> +
>> +        base_items[i].command = TODO_EXEC;
>> +        base_items[i].offset_in_buf = base_offset;
>> +        base_items[i].arg_offset = base_offset + strlen("exec ");
>> +        base_items[i].arg_len = command_len - strlen("exec ");
>> +
>> +        base_offset += command_len + 1;
>>      }
>>  
>>      /*
>> @@ -4473,38 +4475,62 @@ int sequencer_add_exec_commands(struct
>> repository *r,
>>       * those chains if there are any.
>>       */
>>      insert = -1;
>> -    for (i = 0; i < todo_list.nr; i++) {
>> -        enum todo_command command = todo_list.items[i].command;
>> -
>> -        if (insert >= 0) {
>> -            /* skip fixup/squash chains */
>> -            if (command == TODO_COMMENT)
>> -                continue;
>> -            else if (is_fixup(command)) {
>> -                insert = i + 1;
>> -                continue;
>> -            }
>> -            strbuf_insert(buf,
>> -                      todo_list.items[insert].offset_in_buf +
>> -                      offset, commands, commands_len);
> 
> In a todo list that looks like
> pick abc message
> #pick cde empty commit
> This inserts the exec command for the first pick above the commented out
> pick. I think your translation puts it below the commented out pick as
> it ignores the value of insert. I think it's probably easiest to add an
> INSERT_ARRAY macro to insert it in the right place. An alternative might
> be to track the last insert position and only copy commands across when
> there is another exec to insert but that might get complicated in cases
> such as
> 
> pick abc message
> #squash cde squash! message //empty commit for rewording
> fixup 123 fixup! message
> #pick 456 empty commit
> 

I could do this with MOVE_ARRAY(), no?

> Best Wishes
> 
> Phillip
> 

[1] https://github.com/git/git/blob/master/builtin/rebase.c#L1182-L1191

Cheers,
Alban


