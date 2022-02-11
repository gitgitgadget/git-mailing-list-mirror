Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F75FC433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 10:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348745AbiBKKHV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 05:07:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiBKKHV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 05:07:21 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AECE7E
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 02:07:20 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id k80-20020a628453000000b004e042d3910eso6198361pfd.5
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 02:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PJzaST5OMxVEUCFrzvAcnWTH9nDPK91yD0xD0wLWp7o=;
        b=Ozz51F2FXUlDmYBxZs9eyyNYPw/00OHrXhKZJ0l20V3d+6MCs0mFdpVcJOL4gOknbd
         Go7Mt1UXoNldgEDNfy95elX9ftzTR9nweROC7l7d6FNmP2MQMASSWMg97vkH3MzoRVcf
         1nE+xlLfVvL0ywBgRtvcsAynOvXZiWjwq8Rc4bjfWdJm1+YmkIRg2cO+8J+eLc7xOewI
         46CgoZAJu53WbzzTf1vtY85eFsXRpx6Zmk/dch4iEsq8rI41L6i5lTt/XOjJL1tW5hX2
         D8bQiFLSPAK1/g1jXMYC0YmzAZmF80aYwYWTLGpz3DJG2D4rq1A9IbIz0fW3ql3X0nkK
         eubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PJzaST5OMxVEUCFrzvAcnWTH9nDPK91yD0xD0wLWp7o=;
        b=XvoSsrgeY5W1qOV76DT2i9/gy3hc3mK0n3AnxjxXrdRvO6ODGH3B/95+xEix6txDDy
         a3Gb1VW7hJrRZON/r07Et/InigBPW9gzFfVud6S3Ui9LLEMkNaXDFLoyDClDuhKZBHqx
         94eoA5Lhc25oN6PLRKiQ5VAnHeJWEzDJ69PSuA6wwoQq/JFgUoKhk2tD+ZYRTwCnSAcR
         JfydURNBApaYsxnj2Kp8Z6+QZhY2CrKwvXzCpwVcxr2irt7TO/bU3kd2b6i7G9zSduh8
         bBH7vdkxUIlq1PXqrlxQocxJ6eWQ94JyIZkNObpnhF0lsP+K+pXonubCv1fHTKGkEN59
         EPNA==
X-Gm-Message-State: AOAM533x/hea3Y+zuwWtdaSOBHVCTi6EPCHwb/q9/k86ljXncYH7tnfj
        5saZ/tBPj3c7fo+EIizCsf7W9dmdaffiDg==
X-Google-Smtp-Source: ABdhPJxUobG519SePl+Nb0FnypXf8GX7EXctKBAWtbZ/CM88HLW2RabLTJin1pOhyf74QrFMmVu/ibt0uUUT6A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:e2d3:: with SMTP id
 l19mr719038plc.103.1644574039290; Fri, 11 Feb 2022 02:07:19 -0800 (PST)
Date:   Fri, 11 Feb 2022 18:07:01 +0800
In-Reply-To: <20220210191533.659570-1-jonathantanmy@google.com>
Message-Id: <kl6l7da1yawq.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220210191533.659570-1-jonathantanmy@google.com>
Subject: Re: [PATCH 3/8] submodule: make static functions read submodules from commits
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hm, after reading your feedback, I'm starting to question whether this
patch makes sense in its current form.

Jonathan Tan <jonathantanmy@google.com> writes:

> Glen Choo <chooglen@google.com> writes:
>> As a result, "git fetch" now reads changed submodules using the
>> `.gitmodules` and path from super_oid's tree (which is where "git fetch"
>> actually noticed the changed submodule) instead of the filesystem.
>
> Could we have a test showing what has changed?

Looking at this closer, I don't think a test is feasible, but even more
importantly, I don't think this behavior change is even desirable at
all..

I was confused when I wrote the commit message. Prior to this patch,
"git fetch" already records the names of changed submodules by correctly
reading .gitmodules from the given commit. From
collect_changed_submodules_cb(): 

		submodule = submodule_from_path(me->repo,
						commit_oid, p->two->path);
    [...]
		item = string_list_insert(changed, name);
		if (!item->util)
			item->util = xcalloc(1, sizeof(struct changed_submodule_data));
		cs_data = item->util;
		oid_array_append(&cs_data->new_commits, &p->two->oid);

The only behavior that actually _does_ change is that we plumb super_oid
through submodule_has_commits(). "git fetch" invokes this function to
figure out if it already has all of the needed commits, and if so, skip
the fetch.

Before plumbing super_oid, we could not check for commits in an
unpopulated submodule, but now we do. We will need this when we fetch in
unpopulated submodules, but as of this patch, we never fetch in
unpopulated submodules anyway, so this check is just wasted effort.

And because we never fetch anyway, we can't test any meaningful
behavior. We could check whether or not we check the submodule odb, but
that's a lot of effort to spend on something we don't need.

So we probably don't want this behavior change. I can preserve the
existing behavior by passing null_oid() instead, and pass super_oid in
the actual "fetch unpopulated submodules" patch.

>> @@ -1476,7 +1493,7 @@ static int get_next_submodule(struct child_process *cp,
>>  		if (!S_ISGITLINK(ce->ce_mode))
>>  			continue;
>>  
>> -		task = fetch_task_create(spf->r, ce->name);
>> +		task = fetch_task_create(spf->r, ce->name, null_oid());
>
> Hmm...is the plumbing incomplete? This code is about fetching, but we're
> not passing any superproject commit OID here. If this will be fixed in a
> future commit, maybe the distribution of what goes into each commit
> needs to be revised.
>
>> @@ -1499,7 +1516,7 @@ static int get_next_submodule(struct child_process *cp,
>>  			continue;
>>  		}
>>  
>> -		task->repo = get_submodule_repo_for(spf->r, task->sub->path);
>> +		task->repo = get_submodule_repo_for(spf->r, task->sub->path, null_oid());
>
> Same comment here.

This is intentional (but I admit that I also got confused rereading
this). This should be null_oid() (i.e. read from the filesystem) because
we are iterating through the index to get submodule paths. So we should
pass null_oid() so that we read .gitmodules from the filesystem, not a
possibly out-of-sync superproject commit.
