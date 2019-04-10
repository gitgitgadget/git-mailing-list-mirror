Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C7FA20248
	for <e@80x24.org>; Wed, 10 Apr 2019 19:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbfDJTQl (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 15:16:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52229 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDJTQk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 15:16:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id a184so3817436wma.2
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 12:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AAPEEeDMizPY45gnHtC5mGg5xgsuTCl7wrt/PJyMVYk=;
        b=by6Zrw9zIPSuzDD5nhY5CBE9NNCVH6XrPp7oX3DiHVgSfBJ2XJWNHlCMzaJlrE+7fS
         Xgb5wou7CobL8ASkWwopYswq6/ahW925YfupjGUVNceJ7b6Iw7G5ypBnmYB4CpITYIqX
         BYWua3Ovgt7TAPzeJgYId+DV8lsuBtP5ONERBf9CT8ZpKgXJlJN6P1r/bRLM7+Ip+/vI
         1G8deRUTFKhBlygtGLP0GwFCLouDRkL+CXBcmk+7aJ4s3QNRsbyRq9zsIzwV8ubrCS9f
         RvzjwlEl60X20kHpIeHQb1hzwZCHorYUwdhKitiepkcGYaSf9AW897Rn70IcTyZD8rKc
         TVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AAPEEeDMizPY45gnHtC5mGg5xgsuTCl7wrt/PJyMVYk=;
        b=dR7G4hHkV6RqEnvDHOsvVdU/CIdmD2IZo83FisRAhGrM/B0VQ2tWfyaFhyfLNU2jd/
         9CPGfkD7zSYlhUjtdcfFjD3yeIxYP+Qkj7wJTHx8nBgYUsH/EgAzObt7p6nr0XkRww2e
         ZflxlofI8ZQ+YU3H04fVJG4ZKkNAcGVJ5Aev7L1QYzN4nBz9GhcRHAEBiZy7gRH72aaK
         ZYR5AMY+ByHBqFbi0IgHlOj1LDVseZeOlz4xmRKH9CI9RfXbmvgeSvjmDQBW9vAQD7yg
         XpvObJhQAVF4slx25uaPlWMWZE0hyd3IKNKC8AizyPe8m85Dr/Vu2/fNEgzFOeCGcELh
         nxxg==
X-Gm-Message-State: APjAAAXjxLLYibDwnLj3OB9wcCTcHr4PZQHhvwJ5Xx/02L3jasps2f3Y
        yyB87uc1uXzYtTZV43zbqV0=
X-Google-Smtp-Source: APXvYqzrs7yIRLqcCaWKTAYn8vEmpiFerZtoccG4V+c/UaIlqUFuHvONMCQs9CWo8qdYvipGcyUX2g==
X-Received: by 2002:a1c:6c17:: with SMTP id h23mr4215886wmc.122.1554923798564;
        Wed, 10 Apr 2019 12:16:38 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-29-81.as13285.net. [92.22.29.81])
        by smtp.gmail.com with ESMTPSA id c20sm68018379wre.28.2019.04.10.12.16.37
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 12:16:37 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 08/11] rebase -i: use struct rebase_options to parse
 args
To:     Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
 <20190319190317.6632-9-phillip.wood123@gmail.com>
 <7ba0dc1a-b6dd-4ef6-81ee-495e32fc67cf@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <1413d9ef-7164-c3e6-629d-8388d3177e1b@gmail.com>
Date:   Wed, 10 Apr 2019 20:16:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7ba0dc1a-b6dd-4ef6-81ee-495e32fc67cf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

sorry for the slow reply, I think you're probably off-list for a while 
by now

On 21/03/2019 21:13, Alban Gruin wrote:
> Hi Phillip,
> 
> It’s nice to see your work on this on the list.
> 
> Le 19/03/2019 à 20:03, Phillip Wood a écrit :
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> In order to run `rebase -i` without forking `rebase--interactive` it
>> will be convenient to use the same structure when parsing the options in
>> cmd_rebase() and cmd_rebase__interactive().
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   builtin/rebase.c | 203 ++++++++++++++++++++++++++---------------------
>>   1 file changed, 112 insertions(+), 91 deletions(-)
>>
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index c93f2aa629..33a2495032 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -50,6 +50,73 @@ enum rebase_type {
>>   	REBASE_PRESERVE_MERGES
>>   };
>>   
>> +struct rebase_options {
>> +	enum rebase_type type;
>> +	const char *state_dir;
>> +	struct commit *upstream;
>> +	const char *upstream_name;
>> +	const char *upstream_arg;
>> +	char *head_name;
>> +	struct object_id orig_head;
>> +	struct commit *onto;
>> +	const char *onto_name;
>> +	const char *revisions;
>> +	const char *switch_to;
>> +	int root;
>> +	struct object_id *squash_onto;
>> +	struct commit *restrict_revision;
>> +	int dont_finish_rebase;
>> +	enum {
>> +		REBASE_NO_QUIET = 1<<0,
>> +		REBASE_VERBOSE = 1<<1,
>> +		REBASE_DIFFSTAT = 1<<2,
>> +		REBASE_FORCE = 1<<3,
>> +		REBASE_INTERACTIVE_EXPLICIT = 1<<4,
>> +	} flags;
>> +	struct argv_array git_am_opts;
>> +	const char *action;
>> +	int signoff;
>> +	int allow_rerere_autoupdate;
>> +	int keep_empty;
>> +	int autosquash;
>> +	char *gpg_sign_opt;
>> +	int autostash;
>> +	char *cmd;
>> +	int allow_empty_message;
>> +	int rebase_merges, rebase_cousins;
>> +	char *strategy, *strategy_opts;
>> +	struct strbuf git_format_patch_opt;
>> +	int reschedule_failed_exec;
>> +};
>> +
>> +#define REBASE_OPTIONS_INIT {			  	\
>> +		.type = REBASE_UNSPECIFIED,	  	\
>> +		.flags = REBASE_NO_QUIET, 		\
>> +		.git_am_opts = ARGV_ARRAY_INIT,		\
>> +		.git_format_patch_opt = STRBUF_INIT	\
>> +	}
>> +
>> +static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>> +{
>> +	struct replay_opts replay = REPLAY_OPTS_INIT;
>> +
>> +	sequencer_init_config(&replay);
>> +
>> +	replay.action = REPLAY_INTERACTIVE_REBASE;
>> +	replay.signoff = opts->signoff;
>> +	replay.allow_ff = !(opts->flags & REBASE_FORCE);
>> +	if (opts->allow_rerere_autoupdate)
>> +		replay.allow_rerere_auto = opts->allow_rerere_autoupdate;
>> +	replay.allow_empty = 1;
>> +	replay.allow_empty_message = opts->allow_empty_message;
>> +	replay.verbose = opts->flags & REBASE_VERBOSE;
>> +	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
>> +	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
>> +	replay.strategy = opts->strategy;
>> +
>> +	return replay;
>> +}
>> +
> 
> I wonder if `struct rebase_options` and `struct replay_options` could be
> merged, or at least have `replay_options` used in `rebase_options`,
> instead of converting one to the other.  I think it would make things
> simpler and cleaner, but I don’t know how hard it would be, or if my
> assumption is correct.

I did consider doing that, but there are a few subtle differences in the 
way the options are stored in each struct (eg the gpg option has a 
leading -S in struct rebase_options but not struct replay_options) and I 
think it would be a bit of a faff to align them as it would mean messing 
with the code uses them and the code that reads/writes the various state 
files (we cannot change the on-disk format without breaking things - 
sometimes users start a rebase with one version of git bundled with 
something like tig and then continue on the command-line with a 
different version). I'd prefer to leave it as a future cleanup once this 
series has been merged.

Best Wishes

Phillip
> 
> Cheers,
> Alban
> 
