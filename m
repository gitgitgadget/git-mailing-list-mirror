Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E413C433FE
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 14:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357802AbhKXOwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 09:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355648AbhKXOwp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 09:52:45 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66F2C052931
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 06:41:31 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id t23so5787328oiw.3
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 06:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xAILCCCydvl2AhFzV1wBt6y3imSXDvmZTe9m6Y3/Ef0=;
        b=fTtgJ1FhSCAEBDNbGxDzjUllcIVK9ldChc3/MJx6xozCmvb5lZpWDdF+2lSCR+AXCk
         qmA42EmAegH07jIUNjj0PfsBSea2Kh8CmqTkiVqqKJemZy8vcFiUy9bmuZCF4B/tIUFv
         ok9hlxf69jjWLCwaVHfETP2bN1e861VTTw+lA3QrNCxDszWJBg0dqp7cFpgCJVPRaQ1E
         Wfjo6Oz/v23eAID8fpP51KrY1tDQY7KsVIBE6GhMFb5PaeH378b4Y+WIr5Un0n2EgGTy
         douQEGAK6kAbIIDoS/pU3AF3L4VOFz5AbKo+dZZNpZH/rWnq4IelRMrpmhuK/UY+GMON
         cSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xAILCCCydvl2AhFzV1wBt6y3imSXDvmZTe9m6Y3/Ef0=;
        b=jnTzH0MpSpHuqeqUwrdvj1Q5/dcaBsdFbIEO9Hwh76KoK2lssPLBSgffoF43fBE4xn
         Vx+ZezX2BLu2fjP4FAVQODW4D4R2cbzbuWlPcXcgSZ6ec7SfEkzce1GjgUit2g91tbzG
         HXyppbdQP8qwjgTWsLWi0f5YEGe8wZWAbexM3YNuTN90blmsDmPReho+YdHrGC6eNymL
         q6yz5DP89toyYZwg4UDrnitg0/LPccExfcyiJ2nvl1Fnd4dOawY2PGYDtieW1Of2NO1V
         iEJjRKMqR74BWF8ZsuTZzKrWfvKxS1g1Q4YiXpbY5eIZb8vx9yZHy05+A8G0JCShZCdf
         IyuA==
X-Gm-Message-State: AOAM530E4NSy2/gAPfPZkhDO/fLJyEnpLfw1Cp3mUAnG5RTJla8FTnFO
        y5T5c2QuVygEzS0xRhdexu0=
X-Google-Smtp-Source: ABdhPJwlsNq22ZVNhBLL770AFq/D+VyyPgcWuAuNCvWM8qmbUN0oc1PYbvKEs6uvpzu4dvALrnmgGA==
X-Received: by 2002:a05:6808:a08:: with SMTP id n8mr6655463oij.148.1637764888549;
        Wed, 24 Nov 2021 06:41:28 -0800 (PST)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id 70sm2800900otn.74.2021.11.24.06.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 06:41:28 -0800 (PST)
Message-ID: <724abbd4-b9ee-3b3d-226c-b7999f138152@gmail.com>
Date:   Wed, 24 Nov 2021 06:41:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v4 1/4] sparse index: enable only for git repos
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
 <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
 <81e208cf454b61c761fa66e4f43a464ed439ba59.1637620958.git.gitgitgadget@gmail.com>
 <xmqq8rxe787g.fsf@gitster.g>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <xmqq8rxe787g.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/23/21 3:39 PM, Junio C Hamano wrote:
> "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
>> From: Lessley Dennington <lessleydennington@gmail.com>
>>
>> Check whether git dir exists before adding any repo settings. If it
>> does not exist, BUG with the message that one cannot add settings for an
>> uninitialized repository. If it does exist, proceed with adding repo
>> settings.
>>
>> Additionally, ensure the above BUG is not triggered when users pass the -h
>> flag by adding a check for the repository to the checkout and pack-objects
>> builtins.
>>
>> Finally, ensure the above BUG is not triggered for commit-graph by
>> returning early if the git directory does not exist.
>>
>> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
>> ---
>>   builtin/checkout.c     | 6 ++++--
>>   builtin/pack-objects.c | 9 ++++++---
>>   commit-graph.c         | 5 ++++-
>>   repo-settings.c        | 3 +++
>>   4 files changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>> index 8c69dcdf72a..31632b07888 100644
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
>> @@ -1588,8 +1588,10 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>>   
>>   	git_config(git_checkout_config, opts);
>>   
>> -	prepare_repo_settings(the_repository);
>> -	the_repository->settings.command_requires_full_index = 0;
>> +	if (startup_info->have_repository) {
>> +		prepare_repo_settings(the_repository);
>> +		the_repository->settings.command_requires_full_index = 0;
>> +	}
> 
> I am kind-a surprised if the control reaches this deep if you are
> not in a repository.  In git.c::commands[] list, all three primary
> entry points that call checkout_main(), namely, cmd_checkout(),
> cmd_restore(), and cmd_switch(), are marked with RUN_SETUP bit,
> which makes us call setup_git_directory() even before we call the
> cmd_X() function.  And setup_git_directory() dies with "not a git
> repository (or any of the parent directories)" outside a repository.
> 
> So, how can startup_info->have_repository bit be false if the
> control flow reaches here?  Or am I grossly misunderstanding what
> you are trying to do?
> 
This was in reaction to the t0012-help.sh tests failing with the
new BUG in prepare_repo_settings. However, Elijah pointed out
that it's a better idea to move prepare_repo_settings farther
down (after parse_options) instead. So I will be issuing that
change as part of v5.
>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> index 1a3dd445f83..45dc2258dc7 100644
>> --- a/builtin/pack-objects.c
>> +++ b/builtin/pack-objects.c
>> @@ -3976,9 +3976,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>>   	read_replace_refs = 0;
> 
> Ditto wrt RUN_SETUP.
> 
Updating with the same change as checkout for v5.
>> diff --git a/commit-graph.c b/commit-graph.c
>> index 2706683acfe..265c010122e 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -632,10 +632,13 @@ static int prepare_commit_graph(struct repository *r)
>>   	struct object_directory *odb;
>>   	/*
>> +	 * Early return if there is no git dir or if the commit graph is
>> +	 * disabled.
>> +	 *
>>   	 * This must come before the "already attempted?" check below, because
>>   	 * we want to disable even an already-loaded graph file.
>>   	 */
>> -	if (r->commit_graph_disabled)
>> +	if (!r->gitdir || r->commit_graph_disabled)
>>   		return 0;
> 
> I haven't followed the control flow, but this one probably is a good
> addition (in other words, unlike cmd_pack_objects(), I cannot convince
> myself that r->gitdir will never be NULL here).
> 
>> diff --git a/repo-settings.c b/repo-settings.c
>> index b93e91a212e..00ca5571a1a 100644
>> --- a/repo-settings.c
>> +++ b/repo-settings.c
>> @@ -17,6 +17,9 @@ void prepare_repo_settings(struct repository *r)
>>   	char *strval;
>>   	int manyfiles;
>>   
>> +	if (!r->gitdir)
>> +		BUG("Cannot add settings for uninitialized repository");
>> +
> 
> This is a very good idea.  If I recall correctly, I think I reviewed
> a bugfix patch that would have been simplified if we had this check
> here.
>Lessley
