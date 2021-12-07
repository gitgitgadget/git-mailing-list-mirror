Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085DDC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 16:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239466AbhLGQM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 11:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbhLGQM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 11:12:58 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6713C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 08:09:27 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso18636518otj.11
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 08:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tQoYCoCbhj6BaE4huFLqeVCpTGNdsMMtqiq2oj4/MKk=;
        b=n8tzFq0lVNamGu8GgqUpbFaRdQs+Q46gi/Y5qdOIzXu4zjDZz351d80NQ9vP//loyt
         17hqhih9xm1qZhc4MhvwG9okSzlU6b4HAuF4DWe0pMC4N0db53a4/pyGwvFGB4L0cVeH
         Jo7+ytffpHwwSvb1TyMz/LdHrSkaJRkx/fISen/SBWl+j09rcDpoYPyYzrWrPzNuoXoR
         i5U4S/vZ6XJrUPiG4xr2PV9/W83z5qX4bEUYp0jAekyruTw4ueTm5NdiXS2k3D0R5pZw
         U/GWMvQMnSx3Fuys7T8Gf8QBfX4vqRBBdJvoLfkP2AuViWaENT75EuP/6u8fL5o8dZBu
         VLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tQoYCoCbhj6BaE4huFLqeVCpTGNdsMMtqiq2oj4/MKk=;
        b=aLC089kEIjoT2tUbxSzhTRX0O/55dz04pJsASHzGLFLFw6llvZZ6QgKv0HVF4p3Dbh
         nYGm0JApbkOlNLH9cWDrj1NPUTMnIesdt00yrLhEJ9o5fIhExw1QvTRz+JKt7tYwF9Hg
         OyxJbdlrpLEhBpQXL8XjvIe/vf6dDcE7PsZ9SSYJlnvS7pw1pisgsglvVhFY6dpKOOYB
         nnRq4KeSfEQVHwe3ywt1tkharpmsaYafciAFXap/7ejk0AB0UFklCzsDW5W8s1L04IuD
         ubVIPjnyXBETxMD4UugvJBoFxgPNLtN7BZ3jU2+xPiqz7fkuy7zb4iDgkVx9K5+rqxBV
         yXfA==
X-Gm-Message-State: AOAM532ZmCQZovJt/iwLEj5FoIOJDq+0owXoaZH/WrLucR3mNAmTmqZt
        Fj7bI4L5NGfmq8/9FVui7OQ=
X-Google-Smtp-Source: ABdhPJw1IWp/w2vMceMi0gB8d83eocUFXLUYBZSzHvj97PTuTpNpNHBAFmJABAiUx7p8KHGXgWycTg==
X-Received: by 2002:a9d:71dc:: with SMTP id z28mr36835105otj.244.1638893367129;
        Tue, 07 Dec 2021 08:09:27 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1d54:16a5:5c65:4b5? ([2600:1700:e72:80a0:1d54:16a5:5c65:4b5])
        by smtp.gmail.com with ESMTPSA id i3sm16574ooq.39.2021.12.07.08.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 08:09:26 -0800 (PST)
Message-ID: <aa85e35d-143e-93e4-f54b-146b38dd4b88@gmail.com>
Date:   Tue, 7 Dec 2021 11:09:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v5 00/11] Avoid removing the current working directory,
 even if it becomes empty
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
 <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/1/2021 1:40 AM, Elijah Newren via GitGitGadget wrote:
> Traditionally, if folks run git commands such as checkout or rebase from a
> subdirectory, that git command could remove their current working directory
> and result in subsequent git and non-git commands either getting confused or
> printing messages that confuse the user (e.g. "fatal: Unable to read current
> working directory: No such file or directory"). Many commands either
> silently avoid removing directories that are not empty (i.e. those that have
> untracked or modified files in them)[1], or show an error and abort,
> depending on which is more appropriate for the command in question. With
> this series, we augment the reasons to avoid removing directories to include
> not just has-untracked-or-modified-files, but also to avoid removing the
> original_cwd as well.

I did not clearly voice my approval of the core idea here, but I do like it.

I think this fits squarely into a category of "help the user not get stuck"
which Git has enough of those situations that we don't need this one. Even
expert users won't know for sure if a 'git checkout' will cause their current
directory to be removed, however unlikely.

In the Git project, we spend a lot of time in the root of our workdir, but
this is not the typical case for large projects. I remember spending most of
my time in a previous role working four levels deep in the directory hierarchy.


I read the previous two range-diffs and took another pass at this v5 and
didn't see anything worth commenting on. This version is good to go.

There is _also_ more work to do, as follow-ups. In particular, the thing
that I thought about was sparse-checkout and created this test which still
fails at the end of your series (as an addition to t1092)

test_expect_success 'remove cwd' '
	init_repos &&

	test_sparse_match git sparse-checkout set deep/deeper1/deepest &&
	for repo in sparse-checkout sparse-index
	do
		(
			cd $repo/deep/deeper1 &&
			test-tool getcwd >"$TRASH_DIRECTORY/expect" &&
			git sparse-checkout set &&

			test-tool getcwd >"$TRASH_DIRECTORY/actual" &&
			test_sparse_match git status --porcelain &&
			cd "$TRASH_DIRECTORY" &&
			test_cmp expect actual
		)
	done
'

Please do not let this test delay the advancement of this series. As we
find these kinds of issues, we can fix them one-by-one as needed.

Thanks,
-Stolee
