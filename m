Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1043C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 17:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C35FA613F8
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 17:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhGPRdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 13:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhGPRdt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 13:33:49 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE9BC06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 10:30:53 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o30-20020a05600c511eb029022e0571d1a0so6318471wms.5
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 10:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:reply-to:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GVprfVWBUnZncrxYzbVIOxy5UZc9vDj2coBYywoBLDM=;
        b=NjRyWosKNzxs8/gknNwZiCADvGogk42sZzvgKBjDpOySC93AZG9+0dqe5Y4F+cWJVi
         31xTuw+eSUbBzBrLyt1LNiwmxSjBn+hmV2DBQuBB7b39gx7EzdRtHQ5S9IOSay3zcytJ
         o5mQkm8YBekKJ5pMIT5pEI83ebCNh5gNvU6o0DYTG4+MAMtDOctrihSexcAafn/keJQV
         Aho/gjnIjdgXVDSzc87UOuaYe/WXYaTtsutL/FY3U/lfkqY3Z1pgkb4fGFuufUiPEhbh
         +rQDE4M4tiWVuYj7oqVA4jVAGttpOGpvp1BanYltktGhA0an2Nu0kVk01LnstD9kY7mL
         HdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:reply-to:to:references:cc
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GVprfVWBUnZncrxYzbVIOxy5UZc9vDj2coBYywoBLDM=;
        b=DkzxWCual9z88Lsz2XuW7ekhAgknU49dvBcET5kPQZxlSlicC97PjzGmLlQuZfzlwo
         40d+0XeMOU7heRa3xmsphSNAxH7Jr3NQ2vY/gRQxS1CZzG9pxitPKhovBQhsNN51b0Ci
         bG6e7ECpVIrAWr+rH+z+djq8vH0a7HAwtBpn2nU7d7ttn0EjO1Pog9kkCsgeUC9Mh39I
         U4CPLz1SB+/GpN3zFmR8K2+Qi4Oexulx3WJfYO7bF6sWuBZ25RGLMUWFDNIMcRFH+TqL
         tBf9DgmFaeFr0U3wxT0waL4Gp6A4L0t2d2YSUtbMC3fW9k8QzJZRk/V6qUKCXASrLMLn
         M+zw==
X-Gm-Message-State: AOAM532suQlbCOfyeniM2hKHDpcKfZT7zIiWovnvD8FvrD0zTRW6VsKU
        5YWkUoVPnc6sHCYyRa69Qs1rVIiZ8Bhr/A==
X-Google-Smtp-Source: ABdhPJzSk5ltaxC7jOGkPac8TnagQGKBlaYIRlezFkQkSUUrdNevi95in8Os3CfKNR7PWJA4kUFIUg==
X-Received: by 2002:a1c:c90c:: with SMTP id f12mr18145222wmb.80.1626456651495;
        Fri, 16 Jul 2021 10:30:51 -0700 (PDT)
Received: from [192.168.1.201] (141.2.7.51.dyn.plus.net. [51.7.2.141])
        by smtp.googlemail.com with ESMTPSA id b15sm12591307wrr.27.2021.07.16.10.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 10:30:51 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 2/2] merge: make sure to terminate message with newline
Reply-To: phillip.wood@dunelm.org.uk
To:     Luca Weiss <luca@z3ntu.xyz>,
        Luca Weiss via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1048.git.git.1626421416.gitgitgadget@gmail.com>
 <31371c25743e1001b4fac89e80e7206ff477ac8a.1626421416.git.gitgitgadget@gmail.com>
 <8678772b-dd5d-9188-8b63-98d05cedb323@gmail.com>
 <AB048897-F70A-4388-B2A6-56BFEA40B303@z3ntu.xyz>
Cc:     Denton Liu <liu.denton@gmail.com>
Message-ID: <16229b1d-e4a6-7a8d-8ea0-ae7c3f13075d@gmail.com>
Date:   Fri, 16 Jul 2021 18:30:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <AB048897-F70A-4388-B2A6-56BFEA40B303@z3ntu.xyz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luca

On 16/07/2021 13:37, Luca Weiss wrote:
> Hi Phillip,
> 
> So the behavior that I have observed is the following:
> 
> I've added a usleep for ~10 seconds instead of the line I added and
> .git/MERGE_MSG was not terminated with a newline.
> This didn't change when using --log
> It was properly handled with --signoff and the trailer was added
> correctly.
> 
> I have a simple reproducer here:
> 
> mkdir /tmp/test
> cd /tmp/test
> git init
> echo 'dest="$1.tmp"; git interpret-trailers --trailer "Foo: Bar" < "$1" > "${dest}"; mv "${dest}" "$1"' > .git/hooks/commit-msg
> chmod +x .git/hooks/commit-msg
> git commit --allow-empty -m "Initial commit"
> sleep 1
> git switch -c foobar
> git commit --allow-empty -m "Foo1"
> sleep 1
> git commit --allow-empty -m "Foo2"
> git switch master
> git merge --no-ff --no-edit foobar
> # look at merge commit message now

Thanks for the reproducer, I can confirm it shows the bug for me. What I 
missed this morning was that we promptly chop the '\n' off the end of 
the message we get back from fmt_merge_msg(). I've looked through the 
history and this behavior dates back to the beginning of the builtin 
merge added in 1c7b76be7d ("Build in merge", 2008-07-07). Back then we 
added a newline to the end of the message before writing .git/MERGE_MSG 
or committing in finish_automerge() but merge_trivial() did not add a 
new line before committing. Commit 66f4b98ad9 ("Teach merge the 
'[-e|--edit]' option", 2011-10-08) added prepare_to_commit() which added 
the newline and was called by both finish_automerge() and 
merge_trivial(). This behavior was changed in d540b70c85 ("merge: 
cleanup messages like commit", 2019-04-17) after which we only added a 
newline if the message was going to be edited. I've cc'd Denton to see 
if he remembers if this was intentional or not.

I suspect the best way to fix this is to stop stripping the newline that 
is added by fmt_merge_msg() and remove the line in prepare_to_commit() 
that adds the newline when editing. That would leave '-F' untouched so 
it would still not add missing newline in that case - I'm not sure if 
that is desirable or not but I think it matches what 'git commit -F' does.

> With my patch(es) this works properly.
> 
> If you have any other ideas on how to fix this, I am open for
> suggestions :)
> 
> Otherwise I'll try to add more detail to the individual commit
> messages (I deliberately kept the "unnecessary" detail out of the actual
> commit messages before).

The commit message should explain why you're making the change - that is 
not unnecessary detail but essential context to help others reading the 
history in the future to understand the reason for the change.

> Regards
> Luca
> 
> p.s. sorry for replying off-list, and if this is wrongly bottom/top posted, email client troubles ;)

This message seems to have made it onto the list. We normally reply in 
line as I've done here but don't worry if you're having problems with 
your mail client.

I've not had time to look at the first patch properly but from a quick 
glance it seems to be a sensible approach

Best Wishes

Phillip

> On July 16, 2021 12:23:06 PM GMT+02:00, Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Luca
>>
>> Thanks for your patches. It would be very helpful to have the
>> explanation from the cover letter in the commit messages for both
>> commits to explain why this change is being made, otherwise that
>> information will not appear in the history.
>>
>> The cover letter says this happened when using '--no-edit', but unless
>> I've missed something 'git merge --no-edit' creates its message using
>> fmt_merge_msg() which calls strbuf_complete_line() just before it
>> returns. append_signoff() and 'merge -m' always terminate the message
>> with a newline. The only path I found that does not ensure the message
>> ends with a newline before calling the prepare-commit-msg hook is when
>> using '-F' and I suspect that may have been a deliberate decision but it
>> could be an oversight. In any case we would want to make sure that 'git
>> commit -F' and 'git merge -F' to behave the same which I think they do
>> at the moment.
>>
>> Best Wishes
>>
>> Phillip
>>
>> On 16/07/2021 08:43, Luca Weiss via GitGitGadget wrote:
>>> From: Luca Weiss <luca@z3ntu.xyz>
>>>
>>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>>> ---
>>>    builtin/merge.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/builtin/merge.c b/builtin/merge.c
>>> index a8a843b1f54..646bb49367f 100644
>>> --- a/builtin/merge.c
>>> +++ b/builtin/merge.c
>>> @@ -867,6 +867,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
>>>    	}
>>>    	if (signoff)
>>>    		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
>>> +	strbuf_complete_line(&msg);
>>>    	write_merge_heads(remoteheads);
>>>    	write_file_buf(git_path_merge_msg(the_repository), msg.buf, msg.len);
>>>    	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
>>>
>>
