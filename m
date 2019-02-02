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
	by dcvr.yhbt.net (Postfix) with ESMTP id 368C31F453
	for <e@80x24.org>; Sat,  2 Feb 2019 14:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfBBOlA (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Feb 2019 09:41:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36200 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfBBOk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Feb 2019 09:40:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so10078001wrp.3
        for <git@vger.kernel.org>; Sat, 02 Feb 2019 06:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+387uzyV8y4CajWW+glO4TO6OaXudCSaxKAdbmQT3ps=;
        b=AuvBf6jrljPl4zQoosabi8cbNJEvXVSrnlf2VGC0np2gENVjAcO4ldD/qc5nNL7I4u
         XHnppJ3gewnplnpwIsO1OkrgVCg/SvBe2xgGLCVb+xJNt8/YCEGsLf7HOVwUCSzWigC9
         7KzrYVTfhAFSECL8mTN4NyIJSsd7wlXiie/NesDXQRgryDLBD95vUGh+tLEhc1U4E7xE
         j6Q9MgW6xxlEt+Wh9lTLV7cGcG9zmSxgb04lmLbbt2Jh8FTiEQz5KQNDA853Eol963B8
         EHhMk8wjkO27S7LauX1JMY6HgCmbIzK4jnZvI1lgVcVwSWbpEqVVPWPH8lK9pZCUucbF
         CFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+387uzyV8y4CajWW+glO4TO6OaXudCSaxKAdbmQT3ps=;
        b=NO61THRs+H/SchYa70VZml4gRlHKVmeOnSlmsI5/tzTrRIUigUGRohjY7EUdzYXFno
         C6Agg3ygd3oQEqfqqxReV83h1wGCAGZQfV/FMUPKgC/CmwyzsVv762O8LFRm1A9wgYAs
         XysEZDFsClLo6IhOjdVdAAlZe++q/sMrV7MDkBfntqllj0KCq9dxb0xXkZ6K+zxAV9j4
         FdREauXgrMwmiYjmRKZqt2QVC8HZeZC9zTpdffJ3+yTjVJTtpuoPU5rzB+p34/Hze3Ws
         o8PyDNtnbc9hUEO6cjcquwFrSRKCC4Bl/topgRmxPxPYlWleK536SR1MPu4NrxQ12mjZ
         0pZA==
X-Gm-Message-State: AJcUukfVudW3vEhPR7Q2T39ppFeD1XRimaVPdqxY5DUyt5IfRrwS2yNb
        3NMc2OAGSj7YXzhBEEQp640=
X-Google-Smtp-Source: ALg8bN6+ngqYrQjqiMWlGAggrWPzTc+2gpdkKuym+AxCwNJApSHu3YHdN03TF0uIQkOupELs4DC1ww==
X-Received: by 2002:adf:f211:: with SMTP id p17mr42262584wro.293.1549118456676;
        Sat, 02 Feb 2019 06:40:56 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-658-1-47-104.w86-221.abo.wanadoo.fr. [86.221.54.104])
        by smtp.gmail.com with ESMTPSA id h131sm7373911wmd.17.2019.02.02.06.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 06:40:56 -0800 (PST)
Subject: Re: [PATCH v6 14/16] rebase-interactive: rewrite edit_todo_list() to
 handle the initial edit
To:     phillip.wood@dunelm.org.uk, Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20190123205821.27459-1-alban.gruin@gmail.com>
 <20190129150159.10588-1-alban.gruin@gmail.com>
 <20190129150159.10588-15-alban.gruin@gmail.com>
 <f3652f60-dde4-0e5a-50ab-81536af9bae0@talktalk.net>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <66a61731-d794-8704-5246-0e906055e47b@gmail.com>
Date:   Sat, 2 Feb 2019 15:40:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <f3652f60-dde4-0e5a-50ab-81536af9bae0@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Le 01/02/2019 à 12:03, Phillip Wood a écrit :
>>       }
>>   -    strbuf_reset(&todo_list.buf);
>> -    if (launch_sequence_editor(todo_file, &todo_list.buf, NULL)) {
>> -        todo_list_release(&todo_list);
>> -        return -1;
>> -    }
>> +    if (launch_sequence_editor(todo_file, &new_todo->buf, NULL))
>> +        return -2;
>>   -    if (!todo_list_parse_insn_buffer(r, todo_list.buf.buf,
>> &todo_list))
>> -        res = todo_list_write_to_file(r, &todo_list, todo_file, NULL,
>> NULL, -1,
>> -                          flags & ~(TODO_LIST_SHORTEN_IDS));
>> +    strbuf_stripspace(&new_todo->buf, 1);
>> +    if (initial && new_todo->buf.len == 0)
>> +        return -3;
>>   -    todo_list_release(&todo_list);
>> -    return res;
>> +    if (!initial)
>> +        todo_list_parse_insn_buffer(r, new_todo->buf.buf, new_todo);
> 
> error handling. Also why don't we try parse the file for the initial
> edit - is it done somewhere else?
> 

Yes, it’s done in complete_action().

-- Alban

> Best Wishes
> 
> Phillip
> 
>> +
>> +    return 0;
>>   }
>>     define_commit_slab(commit_seen, unsigned char);
>> diff --git a/rebase-interactive.h b/rebase-interactive.h
>> index 0e5925e3aa..44dbb06311 100644
>> --- a/rebase-interactive.h
>> +++ b/rebase-interactive.h
>> @@ -8,7 +8,9 @@ struct todo_list;
>>   void append_todo_help(unsigned keep_empty, int command_count,
>>                 const char *shortrevisions, const char *shortonto,
>>                 struct strbuf *buf);
>> -int edit_todo_list(struct repository *r, unsigned flags);
>> +int edit_todo_list(struct repository *r, struct todo_list *todo_list,
>> +           struct todo_list *new_todo, const char *shortrevisions,
>> +           const char *shortonto, unsigned flags);
>>   int todo_list_check(struct todo_list *old_todo, struct todo_list
>> *new_todo);
>>     #endif
>> diff --git a/sequencer.c b/sequencer.c
>> index 92de982bc4..8f47f0cf39 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -55,8 +55,7 @@ static GIT_PATH_FUNC(rebase_path, "rebase-merge")
>>    * file and written to the tail of 'done'.
>>    */
>>   GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
>> -static GIT_PATH_FUNC(rebase_path_todo_backup,
>> -             "rebase-merge/git-rebase-todo.backup")
>> +GIT_PATH_FUNC(rebase_path_todo_backup,
>> "rebase-merge/git-rebase-todo.backup")
>>     /*
>>    * The rebase command lines that have already been processed. A line
>> diff --git a/sequencer.h b/sequencer.h
>> index c5bee8124c..68acab980b 100644
>> --- a/sequencer.h
>> +++ b/sequencer.h
>> @@ -10,6 +10,7 @@ struct repository;
>>   const char *git_path_commit_editmsg(void);
>>   const char *git_path_seq_dir(void);
>>   const char *rebase_path_todo(void);
>> +const char *rebase_path_todo_backup(void);
>>     #define APPEND_SIGNOFF_DEDUP (1u << 0)
>>  
> 

