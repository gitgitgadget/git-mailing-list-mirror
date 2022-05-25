Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B30C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 14:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244825AbiEYO1M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 10:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244837AbiEYO1B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 10:27:01 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1A711176
        for <git@vger.kernel.org>; Wed, 25 May 2022 07:26:44 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id s7so780260ilt.3
        for <git@vger.kernel.org>; Wed, 25 May 2022 07:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=E9macp7x69wDjdT0Jot/h+UBAyEsJxFnEecOSzUuVIU=;
        b=gqzQXXJUaPRLax5lFqaIFwpJKrGQVyIu59QVv/QvGY9R3+GkHn+BT7MDvM5Uvnv+vD
         H24hzjPMsvZ3Iud6dBmxkeuMByBlzIFASPdy+CluMXXBvh7V8Msw0xLHwLTIHaOsu2KU
         dXprmnHEo4eh3eet6E9fxEnMMJh9ZvanlnGa0fKHx2TNAlGrST/Aw2RgTfCTevXqfdso
         yk2PYHXBUh4Fk7wFVlNcug1rjhxouO3LAJVxHGhbgrrMx57L0l7phoTxfrhIgE9Txhls
         Ls2ckFQR5DK1t8eB+FyxQLH7z0Tw+EFY6McJBr/WIbfsN+eJibYIcfQ/jE5uFx176PJZ
         1iLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E9macp7x69wDjdT0Jot/h+UBAyEsJxFnEecOSzUuVIU=;
        b=waBVhtdRveZw0EWi9wogjXCVh6EccwiciyjcdgACZy/6M5283uBR59D0iYbhaFejs8
         12Lm8fGdgTbJHcZHGYi+DFmEu5CuBPzJnwFg29cWR+piGmABX3UBvgJeTqHt8C75TPZU
         pghzNsHI2MFmB5OOq4RihPgzedJMiP3KF8BGbBaBdunVFYkselj55YcFggkkB//aNOSV
         fzdX7/agTDIqIVxsdgVlmb0rHSE/B3CvzK3MS8I371otXNF0Rgy+Q5Yo5sFv4nFIvNof
         72qd07/zkt4rrbHevdEDIn+zXIHMa3LQBT4WwrFz/J3iokXH0RkjS6I8C5Jc5fltXP8W
         eMdg==
X-Gm-Message-State: AOAM532fdxE4qwC/ep4Nv+MO3P2ErbWxRyExVlwG9iXKO5LdqkzDYQZt
        bTvApZunAfVsQigEd4K66zAIobGtghGI
X-Google-Smtp-Source: ABdhPJzQFlg90bqPD0J+n0605rxhb9ZLFOa/hCyHy/msSFizmWGbWlmNur4FVUiJQlm400SsC4q+Og==
X-Received: by 2002:a92:d09:0:b0:2c3:f141:848b with SMTP id 9-20020a920d09000000b002c3f141848bmr16796138iln.230.1653488803400;
        Wed, 25 May 2022 07:26:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b144:5f1c:7ca1:15fd? ([2600:1700:e72:80a0:b144:5f1c:7ca1:15fd])
        by smtp.gmail.com with ESMTPSA id d137-20020a6bcd8f000000b0065b2fd94d2bsm5489309iog.5.2022.05.25.07.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 07:26:42 -0700 (PDT)
Message-ID: <f0327fd6-f2b3-64b6-3a34-2a7bbad20a01@github.com>
Date:   Wed, 25 May 2022 10:26:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 08/10] sparse-index: complete partial expansion
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
 <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
 <ed640e3645ba4f60f06bd335b9ac7bf350dd81f9.1652982759.git.gitgitgadget@gmail.com>
 <xmqqsfp3coqy.fsf@gitster.g>
 <5909f466-c323-0874-b175-51fe5e93dc12@github.com>
 <xmqqv8tvlvao.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqv8tvlvao.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/23/2022 6:48 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>>> I suspect that is a situation that is not so uncommon.  Working
>>> inside a narrow cone of a wide tree, performing a merge would
>>> hopefully allow many subtrees that are outside of the cones of our
>>> interest merged without getting expanded at all (e.g. only the other
>>> side touched these subtrees we are not working on, so their version
>>> will become the merge result), while changes to some paths in the
>>> cone of our interest may result in true conflicts represented as
>>> cache entries at higher stages, needing conflict resolution
>>> concluded with "git add".  Having to expand these subtrees that we
>>> managed to merge while still collapsed, only because we have
>>> conflicts in some other parts of the tree, feels somewhat sad.
>>
>> You are correct that conflicts outside of the sparse-checkout cone will
>> cause index expansion. That happens during the 'git merge' command, but
>> the index will continue to fail to collapse as long as those conflicts
>> still exist in the index.
>>
>> When there are conflicts like this during the merge, then the index
>> expansion is not as large of a portion of the command as normal, because
>> the conflict resolution also takes some time to compute. The commands
>> afterwards do take longer purely because of the expanded index.
> 
> I was imagining a situation more like "tech-writers only have
> Documentation/ inside the cone of interest, attempt a pull from
> somebody else, have conflicts inside Documentation/, but everything
> else could be resolved cleanly without expanding the index".  If the
> puller's tree is based on the pristine upstream release tag, and the
> pullee's tree is based on a slightly newer version of upstream
> snapshot, everything that happened outside Documentation/ in their
> trees would fast-forward, so such a merge wouldn't have to expand
> directories like "builtin/" or "contrib/" in the index and instead
> can merge at the tree level, right?
> 
> On the other hand, ...
> 
>> However, this state is also not as common as you might think. If a user
>> has a sparse-checkout cone specified, then they are unlikely to change
>> files outside of the sparse-checkout cone. They would not be the reason
>> that those files have a conflict. The conflicts would exist only if they
>> are merging branches that had conflicts outside of the cone. Typically,
>> any merge of external changes like this are of the form of "git pull" or
>> "git rebase", in which case the conflicts are still "local" to the
>> developer's changes.
> 
> ... you seem to be talking about the opposite case (e.g. in the
> above paragraph), where a conflict happens outside the cone of
> interest of the person who is making a merge.  So, I am a bit
> puzzled.

Hm. We must be getting mixed up with each other. Let me try again
from the beginning.

When the conflict happens inside of the sparse-checkout cone,
then the sparse index is not expanded. This is checked by the
test 'sparse-index is not expanded: merge conflict in cone' in
t1092.

Most merges get to "fast forward" changes that are outside of
the sparse-checkout cone because the only interesting changes
that could lead to a conflict are those created by the current
user (and hence within the sparse-checkout cone).

So, the typical case of a tech writer only editing "Documentation/"
should only see conflicts within "Documentation/".

The case where we would see conflicts outside of the cone include
cases where long-lived branches are being merged by someone with
a small cone. I can imagine an automated process using an empty
sparse-checkout cone to occasionally merge a "deployed" and a
"develop" branch, and it gets conflicts when someone ships a
hotfix directly to "deployed" without first going through "develop".
Any conflict is likely to cause index expansion in this case.

Let's re-introduce the patch section we are talking about:

+	if (pl && !pl->use_cone_patterns) {
 		pl = NULL;
+	} else {
+		/*
+		 * We might contract file entries into sparse-directory
+		 * entries, and for that we will need the cache tree to
+		 * be recomputed.
+		 */
+		cache_tree_free(&istate->cache_tree);
+
+		/*
+		 * If there is a problem creating the cache tree, then we
+		 * need to expand to a full index since we cannot satisfy
+		 * the current request as a sparse index.
+		 */
+		if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
+			pl = NULL;
+	}

If a user is in a conflict state and modifies their sparse-checkout
cone, then we will hit this "recompute the cache-tree" state, fail,
and cause full index expansion. I think that combination (have a
conflict AND modify sparse-checkout cone) is rare enough to not
optimize for (yet).

Does that make the situation more clear?

Thanks,
-Stolee
