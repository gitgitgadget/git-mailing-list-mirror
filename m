Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E752DC433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 23:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbiBVXRc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 18:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbiBVXRa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 18:17:30 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AB290CC0
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 15:17:04 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id u16so13598304pfg.12
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 15:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=08xkDPBJ7WvpC9hqlzNrXmnE91wAP+aX5OqbjiHskbk=;
        b=ert7OjsM5PCtzj0IBPSY/eoWzsaxxjCb98kXUht32A6fs2bBFZ3NXA8oGcX+Xrwnl0
         LFlwqStXcvic1BJMoiEH4eHrJpRNeiKuy/jjqYJnMLdGbKuJPwb3yx2LG2to0TAehxTx
         WnDBDNZABX9KAW1KghYXuBDWG+psaWNzInFoNjBOLFjcE9fEia+eT5nhp8UPZgWfrTrT
         XcmUIMCRhe/tRQIuI4w/6m1pW+ZRFfp1+rWpStVSb9RQrgOr8eZk8fSsrDAkDBlgkZFG
         vAbxxRLOb0kZDyza7xm2SpL73UdS440vJYTsiRT7uLJ5QFz3ULk2HTmOP9SRXcReEOV8
         +COA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=08xkDPBJ7WvpC9hqlzNrXmnE91wAP+aX5OqbjiHskbk=;
        b=Jw0tZEM7TrueEsoqpUJRpmV6g2YXuSQzqXMkmXwdvO7aZKHTuhR90dbrrzn5VHbJ/d
         8bw7aAJ6R3jb5INxJSJBuYdLDuOH524la2DHHxPtAKjxEZHX5CuMEj5eC+HeNkuJMs/K
         Oe+Jio1Xuw8OIrejmH9GTUhxwrCzaDlxG7bJi78RouhJZ+MlyyQc5oMtFWvI79ZRXPLt
         R/DdzejKkqKowqavAYLzvUKK4ncywDkju/kLDYCkVOYb+ILIXfyYHxBIQ5U2U+b3BTnj
         qPshVwN9Z2YAiY/lMJjPPecMg6QejgCQuHEFRebUrXhPXrfa/h6x9aEYskLlLbIRT/Ic
         +3bQ==
X-Gm-Message-State: AOAM532mnOzsaS0FY4Na1J3LB5BhIrOmcjgapniN50Pb5yfhI8SpJxLi
        VJ0y6O7uzo++P7VsZURZOj8=
X-Google-Smtp-Source: ABdhPJyn5/ag3ugS2ffnyGv09qPdyFJZWQzJaK6yueeejK0N285qrTh0hmsHWzK25VLpNZtzox1SYw==
X-Received: by 2002:a05:6a00:22c8:b0:4e1:cb76:2e58 with SMTP id f8-20020a056a0022c800b004e1cb762e58mr25770351pfj.47.1645571823587;
        Tue, 22 Feb 2022 15:17:03 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:2ada:62da:c2a8:ce2c])
        by smtp.gmail.com with ESMTPSA id x126sm17039420pfb.117.2022.02.22.15.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 15:17:03 -0800 (PST)
Date:   Tue, 22 Feb 2022 15:17:00 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, jabolopes@google.com,
        Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v2 3/5] repo_read_index: clear SKIP_WORKTREE bit from
 files present in worktree
Message-ID: <YhVu7GH/tcVmao66@google.com>
References: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
 <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>
 <11d46a399d26c913787b704d2b7169cafc28d639.1642175983.git.gitgitgadget@gmail.com>
 <YhBCsg2DCEd9FXjE@google.com>
 <0979ce9b-d7be-9f84-0942-201626b488a4@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0979ce9b-d7be-9f84-0942-201626b488a4@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Derrick Stolee wrote:

> Just chiming in here to say that we've dealt with these issues in
> microsoft/git by special-casing them behind our core_virtualfilesystem
> global. A recent example is the changes to 'git add' to prevent
> adding a file that is marked as sparse (unless --sparse is specified).
> We always allow this when in the virtualized scenario [1].
>
> [1] https://github.com/microsoft/git/blob/2f6531aced2e77a6c1000a923967ae0105383930/builtin/add.c#L50-L54

Oh!  Thanks for that pointer --- it's very helpful.  I hadn't realized
that VFS for Git still requires a patched Git.

> This seems like something that should be on vfsd to handle, and should
> not prevent upstream Git from making changes that benefit its users.

Separate from the "should" questions (in general I'm in favor of
unpatched Git being able to serve as a solid platform for both Scalar
and this kind of VFS use case), this context tells me that this is not
in fact a regression for VFS for Git users, so it's much appreciated.

Thanks,
Jonathan
