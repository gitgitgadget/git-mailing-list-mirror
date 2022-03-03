Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2432C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 16:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiCCQBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 11:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiCCQBn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 11:01:43 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2587218E431
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 08:00:58 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 40-20020a9d032b000000b005b02923e2e6so4982888otv.1
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 08:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dd0eiSxP4kVccBVVM1gON/YxUqhCZmelanoJ16+zjgg=;
        b=Zgy8orO3QivMtGdFkdNTfSnWN/MJTJIqDy0bZNbZ8ON6p+Fbvid05Cft/TNFoa9lQE
         r7uaHWXAh0tQdqitp03zOx6wqjE3Cmm8Xwvoz9HI9hyGHE7DlH5+Mv2X+rFwLfHkyuFt
         U4Cud4ZVg4IvARh36yTbIYByyp3ngFpblkp9/91DDGqRRa7CNUxXO4YhiDUtv/37fych
         RUDlh9z1cJ6DE6JgXoVNyxCZNGTlvJGLUSn3yJ/gBflpV2BX/MaJHEGLgCtF0KrYiTkK
         L5bR0Nx5vn2d/FMVn2gxKkLHwgUHFDY7EK9tEOO7e6iApaCf2ntYSXg8tSuxS5rYN5XY
         ptiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dd0eiSxP4kVccBVVM1gON/YxUqhCZmelanoJ16+zjgg=;
        b=peo2FQK9CQDiLeeQMso3w6y6hgxb1UN86+0WAuoHLvqRiNUmil4bNhiAR0wsHApDkv
         CPUJHROt9ALbK+RE/3IbIJUT3DzHNRmQ8Ub+EL+sHNrvMPFU3u8FmeY1IMANLy70V7oj
         dhwPGVFWTzOecXE+seDGY1m7jK2ypEIEfQSxHrnx45eXWFDMlPrO77LyMlZmYG7gf2A0
         RoRtZ0NhSbo3z3tqXh0AJiiIPRmOVvhQwzTXtq4YZQLJz18++Y9YuASSR642Cn1mS+pj
         Y6X3GQdGx3zu5dHiD0DPXu5ZAbNq+aZ8dj8Ck7H3vsuoNq0tF0MI4qyH/XAkE9pBZIL9
         NnkQ==
X-Gm-Message-State: AOAM532xVhIgpgX8CBGqtE+LR1NLPoUfvZDzewTAul9ASB76FFXZMRWh
        tlQHVSICzKcjFir1DVe8N22+w5tMKNeO
X-Google-Smtp-Source: ABdhPJzTWIsuN+HMar51AwIfr7D41iQ7QW8F3YpswY2w/r9e7V+QNdj5TEArmIHPzJylBTiN/VNoYQ==
X-Received: by 2002:a9d:24a4:0:b0:5af:a3ab:c644 with SMTP id z33-20020a9d24a4000000b005afa3abc644mr18892336ota.138.1646323255819;
        Thu, 03 Mar 2022 08:00:55 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id o5-20020a9d4045000000b005a920356a70sm1064070oti.77.2022.03.03.08.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 08:00:55 -0800 (PST)
Message-ID: <33deae83-1afd-1645-82f3-5af14f14094d@github.com>
Date:   Thu, 3 Mar 2022 11:00:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/7] commit-graph: start parsing generation v2 (again)
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com
References: <e29ec01f-3039-6992-8ade-800ad32fcf34@github.com>
 <Yhz/hsDDGNVjt64R@xps> <dbb59fe7-4918-50ef-33a6-79eb430445e8@github.com>
 <Yh3rZX6cJpkHmRZc@ncase> <Yh325v3RBDMxjFnD@ncase>
 <f50e74f0-9ffa-f4f2-4663-269801495ed3@github.com> <Yh4zehdSnHLW1HuK@ncase>
 <1b9912f7-87be-2520-bb53-9e23529ad233@github.com> <Yh93vOkt2DkrGPh2@ncase>
 <db5eb248-1b54-9f24-8f8a-28c19a1eee6a@github.com> <YiCkRLFxn8Pok7Kc@ncase>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YiCkRLFxn8Pok7Kc@ncase>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/3/2022 6:19 AM, Patrick Steinhardt wrote:
> On Wed, Mar 02, 2022 at 09:57:17AM -0500, Derrick Stolee wrote:
>> On 3/2/2022 8:57 AM, Patrick Steinhardt wrote:
>>> On Tue, Mar 01, 2022 at 10:25:46AM -0500, Derrick Stolee wrote:
>>>> On 3/1/2022 9:53 AM, Patrick Steinhardt wrote:
>>
>>>>> Hum. I have re-verified, and this indeed seems to play out. So I must've
>>>>> accidentally ran all my testing with the state generated without the
>>>>> final patch which fixes the corruption. I do see lots of the following
>>>>> warnings, but overall I can verify and write the commit-graph just fine:
>>>>>
>>>>>     commit-graph generation for commit c80a42de8803e2d77818d0c82f88e748d7f9425f is 1623362063 < 1623362139
>>>>
>>>> But I'm not able to generate these warnings from either version. I
>>>> tried generating different levels of a split commit-graph, but
>>>> could not reproduce it. If you have reproduction steps using current
>>>> 'master' (or any released Git version) and the four patches here,
>>>> then I would love to get a full understanding of your errors.
>>>>
>>>> Thanks,
>>>> -Stolee
>>>
>>> I haven't yet been able to reproduce it with publicly available data,
>>> but with the internal references I'm able to evoke the warnings
>>> reliably. It only works when I have two repositories connected via
>>> alternates, when generating the commit-graph in the linked-to repo
>>> first, and then generating the commit-graph in the linking repo.
>>>
>>> The following recipe allows me to reproduce, but rely on private data:
>>>
>>>     $ git --version
>>>     git version 2.35.1
>>>
>>>     # The pool repository is the one we're linked to from the fork.
>>>     $ cd "$pool"
>>>     $ rm -rf objects/info/commit-graph objects/info/commit-graph
>>>     $ git commit-graph write --split
>>>
>>>     $ cd "$fork"
>>>     $ rm -rf objects/info/commit-graph objects/info/commit-graph
>>>     $ git commit-graph write --split
>>>
>>>     $ git commit-graph verify --no-progress
>>>     $ echo $?
>>>     0
>>>
>>>     # This is 715d08a9e51251ad8290b181b6ac3b9e1f9719d7 with your full v2
>>>     # applied on top.
>>>     $ ~/Development/git/bin-wrappers/git --version
>>>     git version 2.35.1.358.g7ede1bea24
>>>
>>>     $ ~/Development/git/bin-wrappers/git commit-graph verify --no-progress
>>>     commit-graph generation for commit 06a91bac00ed11128becd48d5ae77eacd8f24c97 is 1623273624 < 1623273710
>>>     commit-graph generation for commit 0ae91029f27238e8f8e109c6bb3907f864dda14f is 1622151146 < 1622151220
>>>     commit-graph generation for commit 0d4582a33d8c8e3eb01adbf564f5e1deeb3b56a2 is 1631045222 < 1631045225
>>>     commit-graph generation for commit 0daf8976439d7e0bb9710c5ee63b570580e0dc03 is 1620347739 < 1620347789
>>>     commit-graph generation for commit 0e0ee8ffb3fa22cee7d28e21cbd6df26454932cf is 1623783297 < 1623783380
>>>     commit-graph generation for commit 0f08ab3de6ec115ea8a956a1996cb9759e640e74 is 1621543278 < 1621543339
>>>     commit-graph generation for commit 133ed0319b5a66ae0c2be76e5a887b880452b111 is 1620949864 < 1620949915
>>>     commit-graph generation for commit 1341b3e6c63343ae94a8a473fa057126ddd4669a is 1637344364 < 1637344384
>>>     commit-graph generation for commit 15bdfc501c2c9f23e9353bf6e6a5facd9c32a07a is 1623348103 < 1623348133
>>>     ...
>>>     $ echo $?
>>>     1
>>>
>>> When generating commit-graphs with your patches applied the `verify`
>>> step works alright.
>>>
>>> I've also by accident stumbled over the original error again:
>>>
>>>     fatal: commit-graph requires overflow generation data but has none
>>>
>>> This time it's definitely not caused by generating commit-graphs with an
>>> in-between state of your patch series because the data comes straight
>>> from production with no changes to the commit-graphs performed by
>>> myself. There we're running Git v2.33.1 with a couple of backported
>>> patches (see [1]). While those patches cause us to make more use of the
>>> commit-graph, none modify the way we generate them.
>>>
>>> Of note is that the commit-graph contains references to commits which
>>> don't exist in the ODB anymore.
>>>
>>> Patrick
>>>
>>> [1]: https://gitlab.com/gitlab-org/gitlab-git/-/commits/pks-v2.33.1.gl3
>>
>> Thank you for your diligence here, Patrick. I really appreciate the
>> work you're putting in to verify the situation.
>>
>> Since our repro relies on private information, but is consistent, I
>> wonder if we should take the patch below, which starts to ignore the
>> older generation number v2 data and only writes freshly-computed
>> numbers.
>>
>> Thanks,
>> -Stolee
> 
> Thanks. With your patch below the `fatal:` error is gone, but I'm still
> seeing the same errors with regards to the commit-graph generations.

This is disappointing and unexpected. Thanks for verifying.

> So to summarize my findings:
> 
>     - This bug occurs when writing commit-graphs with v2.35.1, but
>       reading them with your patches.
> 
>     - This bug occurs when I have two repositories connected via an
>       alternates file. I haven't yet been able to reproduce it in a
>       single repository that is not connected to a separate ODB.

This is an interesting distinction. One that I didn't think would
matter, but I'll look into the code to see how that could affect
things.

>     - This bug only occurs when I first generate the commit-graph in the
>       repository I'm borrowing objects from.
> 
>     - This bug only occurs when I write commit-graphs with `--split` in
>       both repositories. "Normal" commit-graphs don't have this issue,
>       and neither can I see it with `--split=replace` or mixed-type
>       commit-graphs.
> 
> Beware, the following explanation is based on my very basic
> understanding of the commit-graph code and thus more likely to be wrong
> than right:
> 
> With the old Git version, we've been mis-parsing the generation because
> `read_generation_data` wasn't ever set. As a result it can happen that
> the second split commit-graph we're generating computes its own
> generation numbers from the wrong starting point because it uses the
> mis-parsed generation numbers from the parent commit-graph.
> 
> With your patches, we start to correctly account for overflows and would
> thus end up with a different value for the generation depending on where
> we parse the commit from: if we parse it from the first commit-graph it
> would be correct because it's contains the "root" of the generation
> numbers. But if we parse a commit from the second commit-graph we may
> have a mismatch because the generation numbers in there may have been
> derived from generation numbers mis-parsed from the first commit-graph.
> And because these would be wrong in case there was an overflow it is
> clear that the new corrected generation number may be wrong, as well.

Hm. My expectation was that the older layers of the split commit-graph
would have read_generation_data disabled (because the new Git version
cannot read the GDAT chunk) and then the validate_mixed_generation_chain()
method would remove read_generation_data from all of the graphs in the
list.

Combining this with your thoughts on cross-alternate split commit-graphs,
this makes me think we should try this:

--- >8 ---

diff --git a/commit-graph.c b/commit-graph.c
index fb2ced0bd6..74c6534f56 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -609,8 +609,6 @@ struct commit_graph *read_commit_graph_one(struct repository *r,
 	if (!g)
 		g = load_commit_graph_chain(r, odb);
 
-	validate_mixed_generation_chain(g);
-
 	return g;
 }
 
@@ -668,7 +666,13 @@ static int prepare_commit_graph(struct repository *r)
 	     !r->objects->commit_graph && odb;
 	     odb = odb->next)
 		prepare_commit_graph_one(r, odb);
-	return !!r->objects->commit_graph;
+
+	if (r->objects->commit_graph) {
+		validate_mixed_generation_chain(r->objects->commit_graph);
+		return 1;
+	}
+
+	return 0;
 }
 
 int generation_numbers_enabled(struct repository *r)


--- >8 ---

Notice that I'm moving the validate_mixed_generation_chain() call
out of read_commit_graph_one() and into prepare_commit_graph(). To
my understanding, this _should_ have an equivalent end state as the
old code, but might be worth trying just as a quick check.

I will continue investigating and try to reproduce with this
additional constraint of working across an alternate.

Thanks,
-Stolee


