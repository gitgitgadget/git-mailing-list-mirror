Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B09C433DF
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 13:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE51220679
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 13:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGdIr98D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgFCNIf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 09:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFCNIe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jun 2020 09:08:34 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370C1C08C5C0
        for <git@vger.kernel.org>; Wed,  3 Jun 2020 06:08:33 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k4so186910oik.2
        for <git@vger.kernel.org>; Wed, 03 Jun 2020 06:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MxpLRmc/r3J6uQEWakJTdFpUlGQmcBRjH/NGVYPW01w=;
        b=aGdIr98D3rcij0zk10mIqTQHK03m+BpbHLP23VCCXPAT1lK420JsmS2cwi2weGUMja
         pKDGl6OkmMV75GCVQWHlocBXlGmf3TCTRyDkPB+A+oO2KyzZn72b+bKS2RZDSsG3gkFy
         M7LxjigUhQzuMuje8+/xCBfrAhjT5f7UHotSSb9PZhdFXZ/ui7jvl1I46cNHzEY2muV5
         Fw3mh+NepR6sAV92iqti1ibpUJKrVDmTfIGi54RGsw/RumRIALFLKB+M/L5Ev75fYrTb
         fFGL0HjJuaTwTiKneXIM1zsMtAHb/+ixi6DDH1uVt7bYRRmcnxySX2ynrJhIwIN3lSh0
         OX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MxpLRmc/r3J6uQEWakJTdFpUlGQmcBRjH/NGVYPW01w=;
        b=qQjWuPqh0DE0IPcL1Ippl2NVmvR3h67+GEPeowY0L427wvwqBOCwYk0LGo7q4g9cXE
         aBWCV50hmDqRTrrwIkfHm8PD0tSfTmUl6O8EBPUr7u9/26IWStEh90EoxIGkviCJZEQa
         ZqW8KEpRfzo4k1fE0X93LzaM33dFFVJ75IaypZJDoDONp8H0VxG8s/KRr7nvlHvTcN+W
         RlRBSx4sThBV9gmkFLAIO4/j2iTJLJWvrOzEvl27rcYTtj7IKsm6hoMxYDrGApPIyl+P
         3t6Fztym3k4eHmGZEIK/52PmLcQTjAIU7EymMF452f5RxvLCKNLJyAithJUV82VrcjF2
         FT6w==
X-Gm-Message-State: AOAM531bACgkpyq/eOlUvpvL6v8qPz0pPw9QxRWLFZps9QAcaJuA8MOU
        PAFXYb8qTI2wygX8ThQuTUw=
X-Google-Smtp-Source: ABdhPJynWUHqRwg98LobwoLoGPUHfPcl2sN6pYHG7Lo7JxhAidtdsH2xunYEnI1Lz2hpEJH2P4bvpg==
X-Received: by 2002:aca:8cb:: with SMTP id 194mr5929999oii.41.1591189707761;
        Wed, 03 Jun 2020 06:08:27 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f3sm474164otq.20.2020.06.03.06.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 06:08:26 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] shallow.c: use '{commit,rollback}_shallow_file'
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        jonathantanmy@google.com, gitster@pobox.com, newren@gmail.com,
        Jay Conrod <jayconrod@google.com>
References: <20200423001438.GC19100@syl.local>
 <cover.1587601501.git.me@ttaylorr.com>
 <296e70790d7a391d471554b0bc5a58e2a091ce88.1587601501.git.me@ttaylorr.com>
 <20200603034213.GB253041@google.com> <20200603045248.GA20266@syl.local>
 <20200603051631.GA20678@syl.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1253efb6-f1bc-0a16-68e3-c1bc07e1bc18@gmail.com>
Date:   Wed, 3 Jun 2020 09:08:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <20200603051631.GA20678@syl.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/3/2020 1:16 AM, Taylor Blau wrote:
> On Tue, Jun 02, 2020 at 10:52:48PM -0600, Taylor Blau wrote:
>> Hi Jonathan,
>>
>> On Tue, Jun 02, 2020 at 08:42:13PM -0700, Jonathan Nieder wrote:
>>> Hi,
>>>
>>> Taylor Blau wrote:
>>>
>>>> Signed-off-by: Taylor Blau <me@ttaylorr.com>
>>>> ---
>>>>  builtin/receive-pack.c   |  4 ++--
>>>>  commit.h                 |  2 ++
>>>>  fetch-pack.c             | 10 +++++-----
>>>>  shallow.c                | 30 +++++++++++++++++++++---------
>>>>  t/t5537-fetch-shallow.sh | 29 +++++++++++++++++++++++++++++
>>>>  5 files changed, 59 insertions(+), 16 deletions(-)
>>>
>>> I haven't investigated the cause yet, but I've run into an interesting
>>> bug that bisects to this commit.  Jay Conrod (cc-ed) reports:
>>>
>>> | I believe this is also the cause of Go toolchain test failures we've
>>> | been seeing. Go uses git to fetch dependencies.
>>> |
>>> | The problem we're seeing can be reproduced with the script below. It
>>> | should print "success". Instead, the git merge-base command fails
>>> | because the commit 7303f77963648d5f1ec5e55eccfad8e14035866c
>>> | (origin/master) has no history.
>>>
>>> -- 8< --
>>> #!/bin/bash
>>>
>>> set -euxo pipefail
>>> if [ -d legacytest ]; then
>>>   echo "legacytest directory already exists" >&2
>>>   exit 1
>>> fi
>>> mkdir legacytest
>>> cd legacytest
>>> git init --bare
>>> git config protocol.version 2
>>> git config fetch.writeCommitGraph true
>>> git remote add origin -- https://github.com/rsc/legacytest
>>> git fetch -f --depth=1 origin refs/heads/master:refs/heads/master
>>> git fetch -f origin 'refs/heads/*:refs/heads/*' 'refs/tags/*:refs/tags/*'
>>> git fetch --unshallow -f origin
>>> git merge-base --is-ancestor -- v2.0.0 7303f77963648d5f1ec5e55eccfad8e14035866c
>>> echo success
>>> -- >8 --
>>
>> Thanks to you and Jay for the report and reproduction script. Indeed, I
>> can reproduce this on the tip of master (which is equivalent to v2.27.0
>> at the time of writing).
>>
>>> The fetch.writeCommitGraph part is interesting.  When does a commit
>>> graph file get written in this sequence of operations?  In an
>>> unshallow operation, does the usual guard against writing a commit
>>> graph in a shallow repo get missed?
>>
>> The last 'git fetch' is the one that writes the commit-graph. You can
>> verify this by sticking a 'ls objects/info' after each 'git' invocation
>> in your script.
>>
>> Here's where things get weird, though. Prior to this patch, Git would
>> pick up that the repository is shallow before unshallowing, but never
>> invalidate this fact after unshallowing. That means that once we got to
>> 'write_commit_graph', we'd exit immediately since it appears as if the
>> repository is shallow.
>>
>> In this patch, we don't do that anymore, since we rightly unset the fact
>> that we are (were) shallow.
>>
>> In a debugger, I ran your script and a 'git commit-graph write --split
>> --reachable' side-by-side, and found an interesting discrepancy: some
>> commits (loaded from 'copy_oids_to_commits') *don't* have their parents
>> set when invoked from 'git fetch', but *do* when invoked as 'git
>> commit-graph write ...'.
>>
>> I'm not an expert in the object cache, but my hunch is that when we
>> fetch these objects they're marked as parsed without having loaded their
>> parents. When we load them again via 'lookup_object', we get objects
>> that look parsed, but don't have parents where they otherwise should.
> 
> Ah, this only sort of has to do with the object cache. In
> 'parse_commit_buffer()' we stop parsing parents in the case that the
> repository is shallow (this goes back to 7f3140cd23 (git repack: keep
> commits hidden by a graft, 2009-07-23)).
> 
> That makes me somewhat nervous. We're going to keep any objects opened
> prior to unshallowing in the cache, along with their hidden parents. I
> suspect that this is why Git has kept the shallow bit as sticky for so
> long.
> 
> I'm not quite sure what to do here. I think that any of the following
> would work:
> 
>   * Keep the shallow bit sticky, at least for fetch.writeCommitGraph
>     (i.e., pretend as if fetch.writecommitgraph=0 in the case of
>     '--unshallow').

I'm in favor of this option, if possible. Anything that alters the
commit history in-memory at any point in the Git process is unsafe to
combine with a commit-graph read _or_ write. I'm sorry that the guards
in commit_graph_compatible() are not enough here.

>   * Dump the object cache upon un-shallowing, forcing us to re-discover
>     the parents when they are no longer hidden behind a graft.
> 
> The latter seems like the most complete feasible fix. The former should
> work fine to address this case, but I wonder if there are other
> call-sites that are affected by this behavior. My hunch is that this is
> a unique case, since it requires going from shallow to unshallow in the
> same process.

The latter would solve issues that could arise outside of the commit-graph
space. But it also presents an opportunity for another gap if someone edits
the shallow logic without putting in the proper guards.

To be extra safe, I'd be in favor of adding an "if (grafts_ever_existed)"
condition in commit_graph_compatible() based on a global that is assigned
a non-zero value whenever grafts are loaded at any point in the process,
mostly because it would be easy to guarantee that it is safe. It could
even be localized to the repository struct.
 
> I have yet to create a smaller test case, but the following should be
> sufficient to dump the cache of parsed objects upon shallowing or
> un-shallowing:
> 
> diff --git a/shallow.c b/shallow.c
> index b826de9b67..06db857f53 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -90,6 +90,9 @@ static void reset_repository_shallow(struct repository *r)
>  {
>  	r->parsed_objects->is_shallow = -1;
>  	stat_validity_clear(r->parsed_objects->shallow_stat);
> +
> +	parsed_object_pool_clear(r->parsed_objects);
> +	r->parsed_objects = parsed_object_pool_new();
>  }
> 
>  int commit_shallow_file(struct repository *r, struct shallow_lock *lk)
> 
> Is this something we want to go forward with? Are there some
> far-reaching implications that I'm missing?

I'd like to see the extra-careful check, in addition to this one. This
is such a rarely-used and narrowly-tested case that we need to be really
really careful to avoid regressions.

Thanks,
-Stolee

