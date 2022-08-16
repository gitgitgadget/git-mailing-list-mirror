Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3C7C25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 14:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbiHPOC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 10:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbiHPOCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 10:02:25 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A497F0B0
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 07:02:24 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so3775932wmb.4
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 07:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=pyn7pyOKlrhzv0hcVWzvp4w2Q02pasK9rLBVW5xpAUc=;
        b=Lu/JqpRBrOfxhZmKsK0l/HyfvMp629X6QbFO4n4QHwRfBtuPMaSWNmW1Dzt8ziGcs+
         VRUZQbcHvRmQz1QNCyITGXx5xEApo0Bie2l5GUckopdUW9rV1+28SUPOWB8P9fO1yVvm
         D8RX1p4Ul+pHiMhuisp80/kfAFFcoIHtAqy6BSgPo23cnGKmLX80K04+s4c37Za/sr71
         2hg8JB4VdTdt9/gFwPTlj+tZJsLNvhMADi/ddEHJssUCarqCKceRh958BnJlPtudrjXU
         SDG9R4q3YtUf73820ie043qHclMVTFUW0vkRIDt2s1OcXHtEilircSfL2Kmg5L2APrKX
         0bFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=pyn7pyOKlrhzv0hcVWzvp4w2Q02pasK9rLBVW5xpAUc=;
        b=MOGnD/y2xUo2TyAIBrsEcJ94RKVqslGN7Ow6deeEj53fwMhaBDnI2E5cA7Ja4wmwIT
         BWqrEBk/wuphzD97oMj95QRDoAkDdGXa0D7anHAT2nzBzYjfwVSDzjO4OZTF3+uabV+x
         hN3LsyWU8A7gEb/13P6tasyQq+IApc1gGvlqCPIpVFgUm+TwfK/foKObMq0X8DWbJ6qH
         o5pn3gwoLt9Ispb7kNPFspOZMI+8nL1O1+Q5LO9cPwsTOP86SW+dhpoBccRAyVM0AsHZ
         9tHZCMBDCYOaUK5clwZzwt9Jhy0bMcHEpgwieUny0u9oJivp81S5cZEoNKjWDzxchXzH
         nuRg==
X-Gm-Message-State: ACgBeo3C+nrwkqSScVEHaBo6uTA4Bb7G1G5+l4Z2rXPd8lMNRLBmXocq
        Uu+pyAvwQ5i2PfMz9J7wJNg=
X-Google-Smtp-Source: AA6agR4lIbd3fyEsS4Da96FCOhjkO7/VwNNRNFtWwU8GJ1ZW3DXKX8dU1kQSM1g4XsWHe0q/4ci7Kw==
X-Received: by 2002:a05:600c:b57:b0:3a5:3c06:f287 with SMTP id k23-20020a05600c0b5700b003a53c06f287mr19004534wmr.148.1660658542652;
        Tue, 16 Aug 2022 07:02:22 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id y2-20020adfe6c2000000b002207cec45cesm12893196wrm.81.2022.08.16.07.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 07:02:22 -0700 (PDT)
Message-ID: <ae2a2c1c-e592-16d4-aa50-a89cc7a2d31c@gmail.com>
Date:   Tue, 16 Aug 2022 15:02:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 08/14] merge-resolve: rewrite in C
Content-Language: en-GB-large
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <20210317204939.17890-1-alban.gruin@gmail.com>
 <20220809185429.20098-1-alban.gruin@gmail.com>
 <20220809185429.20098-9-alban.gruin@gmail.com>
 <08ea1eec-58fb-cbfa-d405-0d4159c99515@gmail.com>
 <128n8n08-23ss-pnsr-n910-o39nr32q42n5@tzk.qr>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <128n8n08-23ss-pnsr-n910-o39nr32q42n5@tzk.qr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 16/08/2022 13:17, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Wed, 10 Aug 2022, Phillip Wood wrote:
> 
>> On 09/08/2022 19:54, Alban Gruin wrote:
>>> This rewrites `git merge-resolve' from shell to C.  As for `git
>>> merge-one-file', this port is not completely straightforward and removes
>>> calls to external processes to avoid reading and writing the index over
>>> and over again.
>>>
>>>    - The call to `update-index -q --refresh' is replaced by a call to
>>>      refresh_index().
>>>
>>>    - The call to `read-tree' is replaced by a call to unpack_trees() (and
>>>      all the setup needed).
>>>
>>>    - The call to `write-tree' is replaced by a call to
>>>      cache_tree_update().  This call is wrapped in a new function,
>>>      write_tree().  It is made to mimick write_index_as_tree() with
>>>      WRITE_TREE_SILENT flag, but without locking the index; this is taken
>>>      care directly in merge_strategies_resolve().
>>>
>>>    - The call to `diff-index ...' is replaced by a call to
>>>      repo_index_has_changes().
>>>
>>>    - The call to `merge-index', needed to invoke `git merge-one-file', is
>>>      replaced by a call to the new merge_all_index() function.
>>>
>>> The index is read in cmd_merge_resolve(), and is wrote back by
>>> merge_strategies_resolve().  This is to accomodate future applications:
>>> in `git-merge', the index has already been read when the merge strategy
>>> is called, so it would be redundant to read it again when the builtin
>>> will be able to use merge_strategies_resolve() directly.
>>>
>>> The parameters of merge_strategies_resolve() will be surprising at first
>>> glance: why using a commit list for `bases' and `remote', where we could
>>> use an oid array, and a pointer to an oid?  Because, in a later commit,
>>> try_merge_strategy() will be able to call merge_strategies_resolve()
>>> directly, and it already uses a commit list for `bases' (`common') and
>>> `remote' (`remoteheads'), and a string for `head_arg'.  To reduce
>>> frictions later, merge_strategies_resolve() takes the same types of
>>> parameters.
>>
>> git-merge-resolve will happily merge three trees, unfortunately using
>> lists of commits will break that.
> 
> But isn't `merge-resolve` specifically implemented as a merge strategy? I
> do not see any contract in Git's documentation that commits to supporting
> direct calls to the implementation detail that is `git merge-resolve`:
> 
> 	$ man git-merge-resolve
> 	No manual entry for git-merge-resolve

I've certainly got scripts that call "git merge-recursive" with a 
mixture of commits and trees (it's kind of doing an cherry-pick), it 
wouldn't surprise me if someone was doing something weird with 
merge-resolve.
>>> +int cmd_merge_resolve(int argc, const char **argv, const char *prefix)
>>> +{
>>> +	int i, sep_seen = 0;
>>> +	const char *head = NULL;
>>> +	struct commit_list *bases = NULL, *remote = NULL;
>>> +	struct commit_list **next_base = &bases;
>>> +	struct repository *r = the_repository;
>>> +
>>> +	if (argc < 5)
>>> +		usage(builtin_merge_resolve_usage);
>>
>> I think it would be better to call parse_options() and then check argc. That
>> would give better error messages for unknown options and supports '-h' for
>> free.
> 
> Again, we are talking about a merge strategy, a program that is not meant
> to be called directly by the user. Why should we complicate the code by
> using the `parse_options` machinery?

I thought it would simplify the implementation of '-h' below. However as 
the script does not support '-h' we should perhaps drop support for that 
and the usage() call if we want a strictly equivalent conversion.

>> I think we also need to call git_config(). I see that read-tree respects
>> submodule.recurse so I think we need the same here. I suspect we should
>> also be reading the merge config to respect merge.conflictStyle.
> 
> Valid concerns. Extra brownie points if you can provide a simple test case
> that demonstrates the current behavior.

I'll add it to my todo list.

>>> +
>>> +	if (repo_index_has_changes(r, head_tree, &sb)) {
>>> +		error(_("Your local changes to the following files "
>>> +			"would be overwritten by merge:\n  %s"),
>>> +		      sb.buf);
>>
>> This matches the script but I wonder why that did not check for unstaged
>> changes.
> 
> Any deviations from the scripted behavior should be done on top of this
> patch series, unless the deviations make the conversion substantially
> cleaner.

I agree. Having thought some more I suspect it is relying on 
unpack_trees() to error out if there are unstaged changes.

Best Wishes

Phillip

> Thanks,
> Dscho
