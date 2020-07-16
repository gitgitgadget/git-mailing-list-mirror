Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C0EC433E0
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 08:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C917820760
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 08:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrebKBfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGPIXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgGPIXV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 04:23:21 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB085C061755
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 01:23:20 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b6so6040685wrs.11
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 01:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5pz445h38JLEkAsyQNt0AkI+a/4eQBisD0d40a22Sic=;
        b=FrebKBfXHSSqhpJvk/d8NS/v3fYn+9vJ9WZYGlWS2w5UdaZmVwhav6vm5SoY5+CE8l
         wxJOJTb3OWGbP+N2XydAlNOuleEYQk5962AJNRFy8ozlj9++eMpSsI40JLEFatz823jx
         BM116O7VagnZjf8D+2iHczg/M2t5dhzDnS9vPINa9ek+SrFo7RpJxssAFcN12JJf/P77
         foOSpfP0CEgEhQyJeqFL1G1N69LKJwFdQTLTgzS4RYv7OPSMMlQMpjMKg9cROYmHQG1g
         kCfhTLxXsnFBG+EjhU4lusqLpN/1+qeBSwzSjmU9Tn5AoCmgPr/aZXMxsP0NgW7xNY5X
         DFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5pz445h38JLEkAsyQNt0AkI+a/4eQBisD0d40a22Sic=;
        b=Ngj3z035IVkTJ/lowR9l5k+vq8XAYOOxntQHMVYxS9UUn2/jPPyqKImaMDskAO3fix
         a/33ld0kvdfhloP70ZUdL+k70KjbKpB+uHC6krZgjjtO2bF1jQ39YS7UPUbEZN/R7tRd
         9gP1PafIMBzE7Oe99qKFNk1t4nE4wFl/29GVpkOMI3WoNwfkaBgRpQuYdDRuVX0UGnaa
         i4eCfkjTu/cFgyD14YGzkDfIZx2tvDx3yL4XzUMBrYWYePbwUMFIOteLukIZ97NBKdSM
         hVby1iq8VxzPCBC7SG2P4d/esnftQSJAXlvrOJvsqIgaIPweeZzLsBnwxxGN+exzcCV+
         LEwQ==
X-Gm-Message-State: AOAM530v7BFRuT6ctTO6m7FlRIaQFAbzbIFHaSVizqxGX4ClL3lL/Vol
        YdneBrZ7LPconO8kMpfEHrN4Gsgk
X-Google-Smtp-Source: ABdhPJzCiUPCAudqOq+WiVA67iFHwl4SSrGahQCgelmLyLW3eoXiskf7en7FYnmYUx5Kjvkfmdg0jw==
X-Received: by 2002:adf:e801:: with SMTP id o1mr4030371wrm.54.1594887799184;
        Thu, 16 Jul 2020 01:23:19 -0700 (PDT)
Received: from [192.168.1.240] (130.20.198.146.dyn.plus.net. [146.198.20.130])
        by smtp.gmail.com with ESMTPSA id i6sm7711898wrp.92.2020.07.16.01.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 01:23:18 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 2/5] rebase -i: support --committer-date-is-author-date
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200713101045.27335-1-phillip.wood123@gmail.com>
 <20200713101045.27335-3-phillip.wood123@gmail.com>
 <20200715142717.GA7803@danh.dev>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <281d92d3-f901-bca1-6030-fd0c8761f214@gmail.com>
Date:   Thu, 16 Jul 2020 09:23:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200715142717.GA7803@danh.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Danh

On 15/07/2020 15:27, Đoàn Trần Công Danh wrote:
> 
> Hi Phillip,
> 
> On 2020-07-13 11:10:42+0100, Phillip Wood <phillip.wood123@gmail.com> wrote:
 >> [...]
>>   
>> +	if (opts->committer_date_is_author_date) {
>> +		struct ident_split ident;
>> +		struct strbuf date = STRBUF_INIT;
>> +
>> +		if (split_ident_line(&ident, author, (int)strlen(author)) < 0) {
>> +			res = error(_("malformed ident line '%s'"), author);
> 
> I've checked with the translation for my native language (vi).
> The translators seem to misread ident (as in identity) as
> indent (as in indentation).
> 
> The translation in po/vi.po:25045 (of v2.28.0-rc0) reads:
> 
> 	#~ msgid "malformed ident line"
> 	#~ msgstr "thụt đầu dòng dị hình"
> 
> Translating back to English, it reads: "malformed indentation".
> 
> Hence, I think it would read better if we write:
> 
> 	res = error(_("malformed identity line '%s'"), author);
> 
> 3 more characters is not that much :)

Looking through the existing strings "invalid ident line: %.*s" is 
already used by am so maybe we should reuse that (log.c also contains 
"invalid ident line: %s"). Is the translation correct?

#: builtin/am.c:1270
#, c-format
msgid "invalid ident line: %.*s"
msgstr "dòng thụt lề không hợp lệ: %.*s"

Best Wishes

Phillip

> 
>> +			goto out;
>> +		}
>> +		if (!ident.date_begin) {
>> +			res = error(_("corrupted author without date information"));
>> +			goto out;
>> +		}
>> +
>> +		strbuf_addf(&date, "@%.*s %.*s",
>> +			    (int)(ident.date_end - ident.date_begin),
>> +			    ident.date_begin,
>> +			    (int)(ident.tz_end - ident.tz_begin),
>> +			    ident.tz_begin);
>> +		res = setenv("GIT_COMMITTER_DATE", date.buf, 1);
>> +		strbuf_release(&date);
>> +
>> +		if (res)
>> +			goto out;
>> +	}
>> +
>>   	if (write_index_as_tree(&tree, r->index, r->index_file, 0, NULL)) {
>>   		res = error(_("git write-tree failed to write a tree"));
>>   		goto out;
>> @@ -2532,6 +2578,11 @@ static int read_populate_opts(struct replay_opts *opts)
>>   			opts->signoff = 1;
>>   		}
>>   
>> +		if (file_exists(rebase_path_cdate_is_adate())) {
>> +			opts->allow_ff = 0;
>> +			opts->committer_date_is_author_date = 1;
>> +		}
>> +
>>   		if (file_exists(rebase_path_reschedule_failed_exec()))
>>   			opts->reschedule_failed_exec = 1;
>>   
>> @@ -2622,6 +2673,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
>>   		write_file(rebase_path_drop_redundant_commits(), "%s", "");
>>   	if (opts->keep_redundant_commits)
>>   		write_file(rebase_path_keep_redundant_commits(), "%s", "");
>> +	if (opts->committer_date_is_author_date)
>> +		write_file(rebase_path_cdate_is_adate(), "%s", "");
>>   	if (opts->reschedule_failed_exec)
>>   		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
>>   
>> @@ -3542,6 +3595,10 @@ static int do_merge(struct repository *r,
>>   			goto leave_merge;
>>   		}
>>   
>> +		if (opts->committer_date_is_author_date)
>> +			argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
>> +					 author_date_from_env_array(&cmd.env_array));
>> +
>>   		cmd.git_cmd = 1;
>>   		argv_array_push(&cmd.args, "merge");
>>   		argv_array_push(&cmd.args, "-s");
>> @@ -3819,7 +3876,8 @@ static int pick_commits(struct repository *r,
>>   	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
>>   	if (opts->allow_ff)
>>   		assert(!(opts->signoff || opts->no_commit ||
>> -				opts->record_origin || opts->edit));
>> +				opts->record_origin || opts->edit ||
>> +				opts->committer_date_is_author_date));
>>   	if (read_and_refresh_cache(r, opts))
>>   		return -1;
>>   
>> diff --git a/sequencer.h b/sequencer.h
>> index 0bee85093e..4ab94119ae 100644
>> --- a/sequencer.h
>> +++ b/sequencer.h
>> @@ -45,6 +45,7 @@ struct replay_opts {
>>   	int verbose;
>>   	int quiet;
>>   	int reschedule_failed_exec;
>> +	int committer_date_is_author_date;
>>   
>>   	int mainline;
>>   
>> diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
>> index 55ca46786d..c8234062c6 100755
>> --- a/t/t3422-rebase-incompatible-options.sh
>> +++ b/t/t3422-rebase-incompatible-options.sh
>> @@ -61,7 +61,6 @@ test_rebase_am_only () {
>>   }
>>   
>>   test_rebase_am_only --whitespace=fix
>> -test_rebase_am_only --committer-date-is-author-date
>>   test_rebase_am_only -C4
>>   
>>   test_expect_success REBASE_P '--preserve-merges incompatible with --signoff' '
>> diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
>> index 4f8a6e51c9..50a63d8ebe 100755
>> --- a/t/t3436-rebase-more-options.sh
>> +++ b/t/t3436-rebase-more-options.sh
>> @@ -9,6 +9,9 @@ test_description='tests to ensure compatibility between am and interactive backe
>>   
>>   . "$TEST_DIRECTORY"/lib-rebase.sh
>>   
>> +GIT_AUTHOR_DATE="1999-04-02T08:03:20+05:30"
>> +export GIT_AUTHOR_DATE
>> +
>>   # This is a special case in which both am and interactive backends
>>   # provide the same output. It was done intentionally because
>>   # both the backends fall short of optimal behaviour.
>> @@ -21,11 +24,20 @@ test_expect_success 'setup' '
>>   	test_write_lines "line 1" "new line 2" "line 3" >file &&
>>   	git commit -am "update file" &&
>>   	git tag side &&
>> +	test_commit commit1 foo foo1 &&
>> +	test_commit commit2 foo foo2 &&
>> +	test_commit commit3 foo foo3 &&
>>   
>>   	git checkout --orphan master &&
>> +	rm foo &&
>>   	test_write_lines "line 1" "        line 2" "line 3" >file &&
>>   	git commit -am "add file" &&
>> -	git tag main
>> +	git tag main &&
>> +
>> +	mkdir test-bin &&
>> +	write_script test-bin/git-merge-test <<-\EOF
>> +	exec git-merge-recursive "$@"
>> +	EOF
>>   '
>>   
>>   test_expect_success '--ignore-whitespace works with apply backend' '
>> @@ -52,6 +64,50 @@ test_expect_success '--ignore-whitespace is remembered when continuing' '
>>   	git diff --exit-code side
>>   '
>>   
>> +test_ctime_is_atime () {
>> +	git log $1 --format=%ai >authortime &&
>> +	git log $1 --format=%ci >committertime &&
>> +	test_cmp authortime committertime
>> +}
>> +
>> +test_expect_success '--committer-date-is-author-date works with apply backend' '
>> +	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
>> +	git rebase --apply --committer-date-is-author-date HEAD^ &&
>> +	test_ctime_is_atime -1
>> +'
>> +
>> +test_expect_success '--committer-date-is-author-date works with merge backend' '
>> +	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
>> +	git rebase -m --committer-date-is-author-date HEAD^ &&
>> +	test_ctime_is_atime -1
>> +'
>> +
>> +test_expect_success '--committer-date-is-author-date works with rebase -r' '
>> +	git checkout side &&
>> +	GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
>> +	git rebase -r --root --committer-date-is-author-date &&
>> +	test_ctime_is_atime
>> +'
>> +
>> +test_expect_success '--committer-date-is-author-date works when forking merge' '
>> +	git checkout side &&
>> +	GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
>> +	PATH="./test-bin:$PATH" git rebase -r --root --strategy=test \
>> +					--committer-date-is-author-date &&
>> +	test_ctime_is_atime
>> +'
>> +
>> +test_expect_success '--committer-date-is-author-date works when committing conflict resolution' '
>> +	git checkout commit2 &&
>> +	GIT_AUTHOR_DATE="@1980 +0000" git commit --amend --only --reset-author &&
>> +	test_must_fail git rebase -m --committer-date-is-author-date \
>> +		--onto HEAD^^ HEAD^ &&
>> +	echo resolved > foo &&
> 
> Nitpick: no space after ">" :D
> 
