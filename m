Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2553C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 14:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbhKWO4C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 09:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbhKWO4B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 09:56:01 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB088C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 06:52:53 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id h23so21944782ila.4
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 06:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JSvrWLwdC3OO/3avJ0DYg+Ea+earG/GBPG9GgWijk2A=;
        b=B16Y4+3zynI4jwoig5BBYjnVSbh5OSJR0v11uE+DITc6XRzwCop5VNpC0UiTn8AC6i
         MMXBfihT5svI95UtqhFATAzIzr8/SkU7+xoA4j0tpezydA1RKKz/6tjXOH6zPwribqG6
         m//IVHwFMojhzvNtixNwGM14+gmIKhUjLls/Yom/OyFB4I/qbdT2xmtrbWvz8mhQFdpJ
         fDAEJNKj9+vOvnOQqCQbmJTJDzvtds8UiJzCUVlFhAPfjpRygyEcqgpZu5seYy4sjjAU
         IDnkbQ4Gl3XVmpznxi88JWL6HrDQxtKH21DXSbg3CaixJaQ2rNKmhQW/PihnsSXoM9l2
         LL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JSvrWLwdC3OO/3avJ0DYg+Ea+earG/GBPG9GgWijk2A=;
        b=2rVTzS5r8WSIfO5H4VYP+yDKGP6H7FAOCd8H8nw3sJaqcGopnRbzOnFDZ8EgAugc3J
         zk5kPXonQpIRttXnj9YsagrjLXgIlL9wYUO8kaQNn2Lr7KRR5TrJCiYNisnfxOIk2TpK
         OHcDh+XYvNcpsPFeJ050bMpiMa1CrGuw//ZQ+KGe0ddkXC5a+uNeL5zHZu4Rf42X+d0O
         5C/3lqsTlO/NvXF6jEuT4h0IanBFPI6+ynaSbiq+ylf+ypWxPA/rz7CtdmewUEEkGm+Y
         F/K7/rlmBgM9r7TphmEBBgEWBGfZKFfiYJa3Y+qgkuHMAcglmKIlkLnugIaf6T5Cu8Ea
         znzg==
X-Gm-Message-State: AOAM530DS1cY43/CfOxKJdCaXSTmU0IbcAsvpVxFMcUsT6ZS6OH2Pntx
        tqTTkbqcOUM51yJuNOJd3Xk=
X-Google-Smtp-Source: ABdhPJx3FsAQ3ccdxeMQyEN/spUbAYz65NrcewO7qs/Svz6Sl+OcOt9ZD3YnVJq9nLipjouSsa4S7A==
X-Received: by 2002:a92:ca0b:: with SMTP id j11mr6071343ils.289.1637679172479;
        Tue, 23 Nov 2021 06:52:52 -0800 (PST)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id g8sm9273558ilf.33.2021.11.23.06.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 06:52:51 -0800 (PST)
Message-ID: <cd9f20aa-0fff-6749-eaec-0527cf4cf4cc@gmail.com>
Date:   Tue, 23 Nov 2021 06:52:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v4 1/4] sparse index: enable only for git repos
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
 <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
 <81e208cf454b61c761fa66e4f43a464ed439ba59.1637620958.git.gitgitgadget@gmail.com>
 <CABPp-BEM+FpdQ4yJxDcqvdz3LNmFV+5CBMAQdAnEfc0ytbZ-dA@mail.gmail.com>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <CABPp-BEM+FpdQ4yJxDcqvdz3LNmFV+5CBMAQdAnEfc0ytbZ-dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/22/21 11:41 PM, Elijah Newren wrote:
> On Mon, Nov 22, 2021 at 2:42 PM Lessley Dennington via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
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
> 
> Why only checkout and pack-objects?  Why don't the -h flags to all of
> the following need it as well?:
> 
> $ git grep -l prepare_repo_settings | grep builtin/
> builtin/add.c
> builtin/blame.c
> builtin/checkout.c
> builtin/commit.c
> builtin/diff.c
> builtin/fetch.c
> builtin/gc.c
> builtin/merge.c
> builtin/pack-objects.c
> builtin/rebase.c
> builtin/reset.c
> builtin/revert.c
> builtin/sparse-checkout.c
> builtin/update-index.c
> 
> If none of these need it, was it because they put
> prepare_repo_settings() calls after some other basic checks had been
> done so more do not have to be added?  If so, is there a similar place
> in checkout and pack-objects where their calls to
> prepare_repo_settings() can be moved?  (Looking ahead, it appears you
> moved some code in patch 2 to do something like this.  Are the similar
> moves that could be done here?)
> 
Thank you for the quick feedback. Yes, I believe there are similar moves 
that can be done here. I was attempting to be explicit about the case I'm 
guarding against, but you're right - it shouldn't be done one way for some 
builtins and another way for others.
>> Finally, ensure the above BUG is not triggered for commit-graph by
>> returning early if the git directory does not exist.
> 
> If commit-graph needs a special case to avoid triggering the BUG,
> wouldn't several of these need it too?:
> 
> $ git grep -l prepare_repo_settings | grep -v builtin/
> commit-graph.c
> fetch-negotiator.c
> merge-recursive.c
> midx.c
> read-cache.c
> repo-settings.c
> repository.c
> repository.h
> sparse-index.c
> t/helper/test-read-cache.c
> t/helper/test-read-graph.c
> unpack-trees.c
> 
> or are their calls to prepare_repo_settings() only done after gitdir
> setup?  If the latter, perhaps the commit-graph function calls could
> be moved after gitdir setup too to avoid the need to do extra checks
> in it?
> 
Agreed, I can move this as well.
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
>>          git_config(git_checkout_config, opts);
>>
>> -       prepare_repo_settings(the_repository);
>> -       the_repository->settings.command_requires_full_index = 0;
>> +       if (startup_info->have_repository) {
>> +               prepare_repo_settings(the_repository);
>> +               the_repository->settings.command_requires_full_index = 0;
>> +       }
>>
>>          opts->track = BRANCH_TRACK_UNSPECIFIED;
>>
>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> index 1a3dd445f83..45dc2258dc7 100644
>> --- a/builtin/pack-objects.c
>> +++ b/builtin/pack-objects.c
>> @@ -3976,9 +3976,12 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>>          read_replace_refs = 0;
>>
>>          sparse = git_env_bool("GIT_TEST_PACK_SPARSE", -1);
>> -       prepare_repo_settings(the_repository);
>> -       if (sparse < 0)
>> -               sparse = the_repository->settings.pack_use_sparse;
>> +
>> +       if (startup_info->have_repository) {
>> +               prepare_repo_settings(the_repository);
>> +               if (sparse < 0)
>> +                       sparse = the_repository->settings.pack_use_sparse;
>> +       }
>>
>>          reset_pack_idx_option(&pack_idx_opts);
>>          git_config(git_pack_config, NULL);
>> diff --git a/commit-graph.c b/commit-graph.c
>> index 2706683acfe..265c010122e 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -632,10 +632,13 @@ static int prepare_commit_graph(struct repository *r)
>>          struct object_directory *odb;
>>
>>          /*
>> +        * Early return if there is no git dir or if the commit graph is
>> +        * disabled.
>> +        *
>>           * This must come before the "already attempted?" check below, because
>>           * we want to disable even an already-loaded graph file.
>>           */
>> -       if (r->commit_graph_disabled)
>> +       if (!r->gitdir || r->commit_graph_disabled)
>>                  return 0;
>>
>>          if (r->objects->commit_graph_attempted)
>> diff --git a/repo-settings.c b/repo-settings.c
>> index b93e91a212e..00ca5571a1a 100644
>> --- a/repo-settings.c
>> +++ b/repo-settings.c
>> @@ -17,6 +17,9 @@ void prepare_repo_settings(struct repository *r)
>>          char *strval;
>>          int manyfiles;
>>
>> +       if (!r->gitdir)
>> +               BUG("Cannot add settings for uninitialized repository");
>> +
>>          if (r->settings.initialized++)
>>                  return;
> 
> I'm not what the BUG() is trying to help us catch, but I'm worried
> that there are many additional places that now need workarounds to
> avoid triggering bugs.
> 
I see your point. We're trying to make sure we catch issues like the 
nongit scenario I overlooked in diff in earlier versions of this series. 
But if we feel this change is too disruptive and will likely cause issues 
beyond those I've fixed to ensure our tests pass, I can remove.
