Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3679C1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 14:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfDYO7v (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 10:59:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36068 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfDYO7u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 10:59:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id b1so19435085wru.3
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 07:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=romAI2HHfJiRJROJXjmxYOtUILDOWQhvFfnt7oDEDbY=;
        b=tEgmuaWiIGOHp1cah9NmWA3Djk4QlCzOBi6f73UOKK78fjrWMiD/QqZ30zZW6B2hli
         ZWOTEC+VTsvHwgvYThoBE65VxjZhrnZ5jlP0niwhL/WEHzWam0Aw4yYCusroZr+quIkP
         HK0mSgBvvSIDBFRW7KPl04YYQvRrcO35NIv3zutYM0Xe+mQH1oheZ5wDnXGV7NfdO0/R
         rVlileCUGQnoe2ItaY2JseI9ZLjcgOHtr0159SkbI2hIRztDMb/E+LiuL6ko9SCN3wJl
         +7BawnsIgujv4aP22AWKoW+g29LmnXyKTjO1m5cP4cATO0gg4GP1GqRvrD7sdFWsGndL
         o/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=romAI2HHfJiRJROJXjmxYOtUILDOWQhvFfnt7oDEDbY=;
        b=YvSCqJw8TYjUc9/fgBICzxw6QRqB5W4A/gatbxWafWNlLjCiBXLYnEY7uaBWUrSQkr
         lyXVZAZYV81IFeRH/x2AOjR7iwjsUTqJBh1wMadHD6UGls6v9FV4MggfQX6GOkjA7t/5
         XTF8FDq7CEzQTLvTjXD3YohdPI+QNZE10rk1xmchCxB2su9hiah8mSNZeVA++CfgQe2U
         d0LFg5mop8M43fPCz3gYHEqLiiAl+JhFcpiICRQGlaiur4TFtX396oOu06fWqOakDIks
         7IEjDTlfXh+XHmKxSmtJEo65SZQSY9CinrRGye9XDXuoyXOYsbK7he3fIJTlwdIjUkbu
         plaQ==
X-Gm-Message-State: APjAAAXGszneIoXnLkuLO0DADTz+0/letQ5KjetCCFCmwsWRaycw/oYd
        zVkjjuMLjbfNg9tB/ymPur0=
X-Google-Smtp-Source: APXvYqx9lJpJP4cgd8lprS2d5vnZQA+3wVU9h0WoWW0q4L/gNfetK7aJxMn5rwV/g3eyENF86bAHJw==
X-Received: by 2002:a5d:62cf:: with SMTP id o15mr4865824wrv.45.1556204388446;
        Thu, 25 Apr 2019 07:59:48 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-19-253.as13285.net. [92.22.19.253])
        by smtp.gmail.com with ESMTPSA id z20sm19606708wmf.34.2019.04.25.07.59.47
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 07:59:48 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/5] sequencer: add support for multiple hooks
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
 <20190424004948.728326-4-sandals@crustytoothpaste.net>
 <ed0312f5-d174-76e0-fea7-5de93f5840b8@gmail.com>
 <20190424224626.GJ6316@genre.crustytoothpaste.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <52917cba-85b3-cf06-b8df-6b56225d4ff8@gmail.com>
Date:   Thu, 25 Apr 2019 15:59:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424224626.GJ6316@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/04/2019 23:46, brian m. carlson wrote:
> On Wed, Apr 24, 2019 at 10:51:56AM +0100, Phillip Wood wrote:
>> On 24/04/2019 01:49, brian m. carlson wrote:
>>> Add support for multiple post-rewrite hooks, both for "git commit
>>> --amend" and "git rebase".
>>>
>>> Additionally add support for multiple prepare-commit-msg hooks.
>>>
>>> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>>> ---
>>>   builtin/am.c                       | 28 ++++++---
>>
>> Having read the patch subject I was surprised to see this touching
>> bulitin/am.c
> 
> I can rewrite the subject. Unfortunately, the same hook for rebase goes
> through two wildly different modules, so in order to completely convert
> the post-rewrite hook, I have to update both at the same time.

It makes sense to convert both in the same commit, it's just that when I 
see "sequencer" I think of the subset of rebase (-k/-i/-m/-r/-x) that 
uses sequencer.c

>>> +static void run_interactive_rewrite_hook(void)
>>> +{
>>> +	struct string_list *hooks;
>>> +	struct string_list_item *p;
>>> +	struct child_process child;
>>> +
>>> +	hooks = find_hooks("post-rewrite");
>>> +	if (!hooks)
>>> +		return;
>>> +
>>> +	for_each_string_list_item(p, hooks) {
>>> +		child_process_init(&child);
>>> +
>>> +		child.in = open(rebase_path_rewritten_list(),
>>> +			O_RDONLY);
>>> +		child.stdout_to_stderr = 1;
>>> +		child.trace2_hook_name = "post-rewrite";
>>> +		argv_array_push(&child.args, p->string);
>>> +		argv_array_push(&child.args, "rebase");
>>> +		if (run_command(&child))
>>> +			break;
>>> +	}
>>> +	free_hooks(hooks);
>>>   }
>>
>> If you're adding a function to do this it would be nice to use it from
>> am.c as well rather than duplicating essentially the same code. Is there
>> any way to use a helper to run all the hooks, rather than introducing a
>> similar loop everywhere where we call a hook?
> 
> It's becoming clear to me that a helper is probably going to be cleaner,
> so I'll add one in for v2.
> 
>>>   void commit_post_rewrite(struct repository *r,
>>> @@ -1326,6 +1362,7 @@ static int try_to_commit(struct repository *r,
>>>   	char *amend_author = NULL;
>>>   	const char *hook_commit = NULL;
>>>   	enum commit_msg_cleanup_mode cleanup;
>>> +	struct string_list *hooks;
>>>   	int res = 0;
>>>   
>>>   	if (parse_head(r, &current_head))
>>> @@ -1369,7 +1406,10 @@ static int try_to_commit(struct repository *r,
>>>   		goto out;
>>>   	}
>>>   
>>> -	if (find_hook("prepare-commit-msg")) {
>>> +	hooks = find_hooks("prepare-commit-msg");
>>> +	if (hooks) {
>>> +		free_hooks(hooks);
>>
>> I think you forgot to update run_prepare_commit_msg_hook(), it should
>> probably be passed this list now. It might be outside the scope of this
>> series but unifying this with builtin/commit.c
> 
> run_prepare_commit_msg_hook calls run_hook_le, which looks up that value
> itself. It's unfortunate that we have to do it twice, but we need to
> know whether we need to re-read the commit msg or not. I can explain
> this further in the commit message.

Thanks for explaining that, it would be nice to have that in the commit 
message (I probably should have read the previous two patches to see 
what run_hook_le() was doing).

Best Wishes

Phillip


>>> diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
>>> index ba8bd1b514..5b83f037b5 100755
>>> --- a/t/t7505-prepare-commit-msg-hook.sh
>>> +++ b/t/t7505-prepare-commit-msg-hook.sh
>>> @@ -3,6 +3,7 @@
>>>   test_description='prepare-commit-msg hook'
>>>   
>>>   . ./test-lib.sh
>>> +. "$TEST_DIRECTORY/lib-hooks.sh"
>>>   
>>>   test_expect_success 'set up commits for rebasing' '
>>>   	test_commit root &&
>>> @@ -317,4 +318,12 @@ test_expect_success C_LOCALE_OUTPUT 'with failing hook (cherry-pick)' '
>>>   	test $(grep -c prepare-commit-msg actual) = 1
>>>   '
>>>   
>>> +commit_command () {
>>> +	echo "$1" >>file &&
>>> +	git add file &&
>>> +	git commit -m "$1"
>>> +}
>>> +
>>> +test_multiple_hooks prepare-commit-msg commit_command
>>
>> It's not clear to me that this is testing the sequencer
> 
> You're right. I need to adopt a different approach here.
> 
