Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8C2C433FE
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 14:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB0A6023F
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 14:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbhJKOb7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 10:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237130AbhJKOb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 10:31:56 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0364CC0397B7
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 07:12:27 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id ay35so7751618qkb.10
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 07:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3dFBuMF6iqTWXkbGCHrHJASs3R6IzHuJ9pMqxoXa1aU=;
        b=f5Dd8byuw1WzzL5BcpmbDM+IEB5cUGEk9iBOmfOzV64rGYgQQKhnRaDWRkJeuvfYQj
         bNcwpoM4LkMjin61/+A6gL2gdhLqtEAPDn0mwa1gRKHQRch5uIpD1fWYEx3RULzyi143
         q5nnEQq/AsDuYJYa9x4ZQ6icG+f+6bEx7fvPX7ckIDBPSCiMWxbz25v7ZnN4moObq3ub
         d6tWAzNDeE8nqoFwm/Ob7yBB4dW6SZK5Q0ZiyVjrCNVHYQZRj9iX6S9w8zLbLTqKIfsm
         8lgBBmKrlQYWGByYJEXppMzfs47vIqGO0lqEmQQkC0RYpLbjzSybj9sNSugE7FbLnPu2
         0lxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3dFBuMF6iqTWXkbGCHrHJASs3R6IzHuJ9pMqxoXa1aU=;
        b=fyjFx2pKXjWGsZNNshXJyML3t8t0Hwyc9NwrVLJ8ISBP616pwLf0aS9f+7rc+4XPC1
         pNyO0NzIwfAci/yhal3reVW9RdQnMmpxQr7Lif5WiurJfvLnm+tR0v3g/Uabg+1w83nk
         Mc3CRyZWCkoWv1rllgSSlMO1vdfhQxh2mfM58b/kphRpcVelzmxN7meCcLWi0T/I4Cyb
         XxDEryuf5gKx+VTRYljAig6Z/F/T0nDUYSTqZZ8qt3sTnTp7A9nXzey//jy6jkbq/S11
         FoAubb9hwTlZaanNa2yzzooDrXF9wHyNx943zSlimq2qntJGpWh0QhGjCHbyuaAunRlJ
         PFUw==
X-Gm-Message-State: AOAM530Wgd7PkeHXM2OhoEXmEMV3gMJUzKwZkH/XW07m1HfvUIm9TNJi
        8eyWkR0Jg2BOyvHRn2fiU7yB4A91S04=
X-Google-Smtp-Source: ABdhPJxTMGyTrjJR8iSHqGqrnlhnhL/BaRL2DzWT3TV7QhUdAvcJVhpMZdj0WIjkiPtoVh7jozE4bA==
X-Received: by 2002:a37:314:: with SMTP id 20mr12254658qkd.279.1633961545980;
        Mon, 11 Oct 2021 07:12:25 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:c80b:7c01:ed8b:1720])
        by smtp.gmail.com with ESMTPSA id t9sm4882209qtx.47.2021.10.11.07.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 07:12:25 -0700 (PDT)
Subject: Re: [PATCH v3 3/8] update-index: add --force-full-index option for
 expand/collapse test
To:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
 <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
 <014a408ea5d9894197c60f8d712749ea3cc39c9d.1633641339.git.gitgitgadget@gmail.com>
 <xmqq35pcm6m9.fsf@gitster.g>
 <72f4df1e-54ef-6bdb-ef71-1f115e92c9a5@github.com>
 <xmqqily7l9i5.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cc60c6e7-ecef-ae22-8ec7-ab290ff2b830@gmail.com>
Date:   Mon, 11 Oct 2021 10:12:24 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqily7l9i5.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/8/21 1:19 PM, Junio C Hamano wrote:
> Victoria Dye <vdye@github.com> writes:
> 
>> I tried coming up with a user-facing name that wasn't too focused on the
>> internal implementation, but it ends up being misleading. The intention was
>> to have this be a variation of `git update-index` that uses the default
>> setting for `command_requires_full_index` but then proceeds to read and
>> write the index as `update-index` normally would. Something like
>> `--use-default-index-sparsity` might have been more accurate?
> 
> The option name in the reviewed patch does imply "we force expanding
> to full" and not "use the default", so it probably needs renaming,
> if we want the "use the default" semantics.  But is that useful in
> the context of the test you are using it in place of "reset" or "mv"?
> Even if the default is somehow flipped to use sparse always, wouldn't
> the particular test want the index expanded?  I dunno.
> 
>> In the test's use-case, `active_cache_changed` ends up set to
>> `CACHE_TREE_CHANGED`, which forces writing the index. It is still
>> effectively a no-op, but it serves the needs of the test.
> 
> Ah, cache-tree is updated, then it's OK.
> 
> As to test-tool vs end-user-accessible-command, I do not have a
> strong opinion, but use your imagination and ask Derrick or somebody
> else for their imagination to see if such a "force expand" feature
> may be something the end-users might need an access to in order to
> dig themselves out of a hole (in which case, it may be better to
> make it end-user-accessible) or not (in which case, test-tool is
> more appropriate).

I think there is something to be said about the name being confusing,
because the current implementation focuses on "expand a sparse index
upon read" but it also allows the index to be written as sparse.

Conversely, if the user runs

  git -c index.sparse=false update-index ...

then the index.sparse config setting forbids conversion from full to
sparse, but does not say anything about expanding to full.

Perhaps this should be corrected: the index.sparse=false setting
should expand a sparse index to a full one, then prevent it from
being converted to a sparse one on write.

This diff should do it:

diff --git a/read-cache.c b/read-cache.c
index 564283c7e7e..04df1051e18 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2376,7 +2376,8 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	if (!istate->repo)
 		istate->repo = the_repository;
 	prepare_repo_settings(istate->repo);
-	if (istate->repo->settings.command_requires_full_index)
+	if (!istate->repo->settings.sparse_index ||
+	    istate->repo->settings.command_requires_full_index)
 		ensure_full_index(istate);
 
 	return istate->cache_nr;

Victoria, what are your thoughts about including such a change?

Junio, would it be better to change the config setting, and then
update this test to use the config setting over a command-line flag?
This would allow us to punt on the --force-full-index flag until we
have time to focus on the 'git update-index' command and interactions
like this.

Thanks,
-Stolee
