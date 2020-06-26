Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6E1C433E0
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 14:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07A8820836
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 14:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMmncUrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgFZOim (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgFZOim (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 10:38:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25862C03E979
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 07:38:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so9032838wme.5
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 07:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oYLHGGOtzBiC6OjtVeAWqARoc+37To3YHEoHbc/uq5o=;
        b=RMmncUrN8+VEATHb7RFwHBzJgXeZbZBnFKWB0SCRnWYL8UB9AeYZ1tN1AnIuYqBy+b
         AfUIrBXf0+w+4ciJnNqZU7D34B4T3FHw2riVGaqvm9Oa3saR9gEuKy54fYga7+cfi3CC
         8+bAM1X6/Vj1sIB2m7plWVpLXb/lFxHqs6EHxbYuJ/e0nLgE+J7MQgYVSSkZLzrJn73P
         pmdic/LQZoY5kmSPz9pqZ5YFoesoigA6aBJvJK8ijECzY/oZpZGKj3QxNg0SPWNAWgxd
         XjWOdH3icm1D5HNaJveDm49cH/kZ5eGW3VFRVija3Vw8vC154YCNO/lBWSH6Xc3/rvpV
         xBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oYLHGGOtzBiC6OjtVeAWqARoc+37To3YHEoHbc/uq5o=;
        b=beBclI6yeUWpBbdb+cqmm3qWsXeeGdw/jCzqwzwwU8udjf6cscTot1pJAMr88XHE6h
         E3gPJ6M3O12CnxmmMaJR0ImYpbZ+9gtcvuNjvradX/IMtsfELjVzivx34JXdQwJT4c13
         aqPn8ZDlbvSRe9JS6GvHXmwyoiho3e2FFg1BmupOzN2HSyjHaa3t35P5GwhlixgEgbPV
         40528u5txYI8c8ox7PKT8xWBbEzxE3QVrrrJQS94TFjtNAthKyf5HuQhcGBVA9Yvmqre
         rpKCN/7rvODQmAqlino4M5LVkoDbdz52e5y6RHfOSx7OVC3RAxYXk1FsKp2rhJOehZnl
         KAIg==
X-Gm-Message-State: AOAM532HCpAxImw42v4w5RffF2qGkHKGIOChpqq7Dt0NzN3zHyR2RSNt
        mGwv52f9U8tGrsZX8NH+TX/OGj9D
X-Google-Smtp-Source: ABdhPJy7NhEIgpcnbQdtFA3FMcGuUE79Urd4wH1NMnyh8+Xp7dre8rHu43ow7+ikMnKkHGnXZQN56g==
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr3867636wmy.79.1593182320286;
        Fri, 26 Jun 2020 07:38:40 -0700 (PDT)
Received: from [192.168.1.240] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id l18sm14399421wrt.59.2020.06.26.07.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 07:38:39 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 4/5] rebase -i: support --ignore-date
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200626095528.117524-1-phillip.wood123@gmail.com>
 <20200626095528.117524-5-phillip.wood123@gmail.com>
 <20200626140854.GC12504@danh.dev>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <d0d8dcb2-6714-f0a6-61a3-55c5e0b6ab19@gmail.com>
Date:   Fri, 26 Jun 2020 15:38:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200626140854.GC12504@danh.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Danh

On 26/06/2020 15:09, Đoàn Trần Công Danh wrote:
> On 2020-06-26 10:55:27+0100, Phillip Wood <phillip.wood123@gmail.com> wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Rebase is implemented with two different backends - 'apply' and
>> 'merge' each of which support a different set of options. In
>> particular the apply backend supports a number of options implemented
>> by 'git am' that are not implemented in the merge backend. This means
>> that the available options are different depending on which backend is
>> used which is confusing. This patch adds support for the --ignore-date
>> option to the merge backend. This option uses the current time as the
>> author date rather than reusing the original author date when
>> rewriting commits. We take care to handle the combination of
>> --ignore-date and --committer-date-is-author-date in the same way as
>> the apply backend.
>>
>> Original-patch-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   Documentation/git-rebase.txt   |  7 +++--
>>   builtin/rebase.c               | 13 +++++---
>>   sequencer.c                    | 50 ++++++++++++++++++++++++++++--
>>   sequencer.h                    |  1 +
>>   t/t3436-rebase-more-options.sh | 56 ++++++++++++++++++++++++++++++++++
>>   5 files changed, 117 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>> index dfa70263e6..e2717e20e6 100644
>> --- a/Documentation/git-rebase.txt
>> +++ b/Documentation/git-rebase.txt
>> @@ -450,8 +450,9 @@ See also INCOMPATIBLE OPTIONS below.
>>   	date. This option implies --force-rebase.
>>   
>>   --ignore-date::
>> -	This flag is passed to 'git am' to change the author date
>> -	of each rebased commit (see linkgit:git-am[1]).
>> +	Instead of using the author date of the original commit, use
>> +	the current time as the	author date of the rebased commit.  This
>> +	option implies `--force-rebase`.
>>   +
>>   See also INCOMPATIBLE OPTIONS below.
>>   
>> @@ -589,7 +590,6 @@ INCOMPATIBLE OPTIONS
>>   The following options:
>>   
>>    * --apply
>> - * --ignore-date
>>    * --whitespace
>>    * -C
>>   
>> @@ -617,6 +617,7 @@ In addition, the following pairs of options are incompatible:
>>    * --preserve-merges and --empty=
>>    * --preserve-merges and --ignore-whitespace
>>    * --preserve-merges and --committer-date-is-author-date
>> + * --preserve-merges and --ignore-date
>>    * --keep-base and --onto
>>    * --keep-base and --root
>>   
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index a7c3d5c92b..890dd4c588 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -89,6 +89,7 @@ struct rebase_options {
>>   	char *gpg_sign_opt;
>>   	int autostash;
>>   	int committer_date_is_author_date;
>> +	int ignore_date;
>>   	char *cmd;
>>   	int allow_empty_message;
>>   	int rebase_merges, rebase_cousins;
>> @@ -127,6 +128,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>>   	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
>>   	replay.committer_date_is_author_date =
>>   					opts->committer_date_is_author_date;
>> +	replay.ignore_date = opts->ignore_date;
>>   	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
>>   	replay.strategy = opts->strategy;
>>   
>> @@ -1503,8 +1505,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>   		OPT_BOOL(0, "committer-date-is-author-date",
>>   			 &options.committer_date_is_author_date,
>>   			 N_("make committer date match author date")),
>> -		OPT_PASSTHRU_ARGV(0, "ignore-date", &options.git_am_opts, NULL,
>> -				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
>> +		OPT_BOOL(0, "ignore-date", &options.ignore_date,
>> +			 "ignore author date and use current date"),
> 
> Nit: The options' description is subjected to l10n.
> 
> s/".*"/N_(&)/

Well spotted, thanks

>>   		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
>>   				  N_("passed to 'git apply'"), 0),
>>   		OPT_BOOL(0, "ignore-whitespace", &ignore_whitespace,
>> @@ -1797,13 +1799,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>   	    options.autosquash) {
>>   		allow_preemptive_ff = 0;
>>   	}
>> -	if (options.committer_date_is_author_date)
>> +	if (options.committer_date_is_author_date || options.ignore_date)
>>   		options.flags |= REBASE_FORCE;
>>   
>>   	for (i = 0; i < options.git_am_opts.argc; i++) {
>>   		const char *option = options.git_am_opts.argv[i], *p;
>> -		if (!strcmp(option, "--ignore-date") ||
>> -		    !strcmp(option, "--whitespace=fix") ||
>> +		if (!strcmp(option, "--whitespace=fix") ||
>>   		    !strcmp(option, "--whitespace=strip"))
>>   			allow_preemptive_ff = 0;
>>   		else if (skip_prefix(option, "-C", &p)) {
>> @@ -1862,6 +1863,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>   		if (options.committer_date_is_author_date)
>>   			argv_array_push(&options.git_am_opts,
>>   					"--committer-date-is-author-date");
>> +		if (options.ignore_date)
>> +			argv_array_push(&options.git_am_opts, "--ignore-date");
>>   	} else if (ignore_whitespace) {
>>   			string_list_append (&strategy_options,
>>   					    "ignore-space-change");
>> diff --git a/sequencer.c b/sequencer.c
>> index 29f6d1bc39..f8e1e38623 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -150,6 +150,7 @@ static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
>>    */
>>   static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
>>   static GIT_PATH_FUNC(rebase_path_cdate_is_adate, "rebase-merge/cdate_is_adate")
>> +static GIT_PATH_FUNC(rebase_path_ignore_date, "rebase-merge/ignore_date")
>>   static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
>>   static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
>>   static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
>> @@ -889,6 +890,24 @@ static const char *author_date_from_env_array(const struct argv_array *env)
>>   	BUG("GIT_AUTHOR_DATE missing from author script");
>>   }
>>   
>> +/* Construct a free()able author string with current time as the author date */
>> +static char *ignore_author_date(const char *author)
>> +{
>> +	int len = strlen(author);
>> +	struct ident_split ident;
>> +	struct strbuf new_author = STRBUF_INIT;
>> +
>> +	if (split_ident_line(&ident, author, len) < 0) {
>> +		error(_("malformed ident line '%s'"), author);
>> +		return NULL;
>> +	}
>> +
>> +	len = ident.mail_end - ident.name_begin + 1;
>> +	strbuf_addf(&new_author, "%.*s ", len, ident.name_begin);
> 
> I wonder if we can do this instead:
> 
> 	strbuf_add(&new_author, ident.name_begin, len);

There is a space at the end of the format string, which I think is 
needed to separate the name and email from the date we add with 
datestamp() below

Best Wishes

Phillip

> Quick skim through the code and nothing crashes when make test with:
>
> 	CFLAGS="-fstack-clash-protection -D_FORTIFY_SOURCE=2"
> 
> I think it's OK to be changed.
> 
>> +	datestamp(&new_author);
>> +	return strbuf_detach(&new_author, NULL);
>> +}
>> +
> 
