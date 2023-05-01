Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489DBC77B61
	for <git@archiver.kernel.org>; Mon,  1 May 2023 16:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjEAQVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 12:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEAQVs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 12:21:48 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C78128
        for <git@vger.kernel.org>; Mon,  1 May 2023 09:21:46 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b7b54642cso1886158b3a.0
        for <git@vger.kernel.org>; Mon, 01 May 2023 09:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682958106; x=1685550106;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7GSgUGjmZHxsa8BfhTxH2tcE5Ol87nHQag826EVNRvw=;
        b=XcqSAi5O5ZeDc0F2mAitmdSO1uT4BKtPkPbiqsmKWmfZysicMwaw4gOSTJ4sU3fOMc
         +P6IvVzVwJaXWLSK3Zmo717D9kLbGxJ97LfIAoV0FVqZzaOQsUXikO3ydug6WbZ0MCv/
         3m0T8S0Hf3JdVoJ3jWPtIJrWWRkBfI8sVash/FB7UucYRkS5I6kAMIYOzBcUBlT4oJX6
         ZqVrDxq/riKu9M+DbrH5dpNDPqk/IMUh4GVNekHeujih7HYuSXwF960S3pZGxIgyLHvi
         VMbDCTh1b7TaLRcaiz+K33oxOJGoeU6wNnyemec8iHzkB4vTwnIKxKHU/TbQ/r5GDVEZ
         B0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682958106; x=1685550106;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7GSgUGjmZHxsa8BfhTxH2tcE5Ol87nHQag826EVNRvw=;
        b=S29bNv1LKKrOaMNbQjIpoZKVA+SYwSJuHN1pyQgTA9mJffKffOYKtH02q4ls0HTZdF
         vcmz0UqnPFgFRHqTcHVTagjyjyExY45YRZkKyInLoZro62tnuVTt72Vw0N1HRTSoVKV9
         G4tw1LacXIu0xJsATZ/rLwIRQkITQ3XNhjgRRXU8W5h0CykvjTK6ItF3WXoeB3Iav5gL
         qEj3iL/sgbfCP0OcRJj7oTmbAwIYKTbSnzNFp/sSZjckzRWXlGaZmLyN4J3p6SnHJsBT
         QfW33fA9up0sLZUCP8CSppXzUEkMdRo3+ZLNzIvFCs36anpPJrOr/O2az58T1D0wLZ/d
         E/Ng==
X-Gm-Message-State: AC+VfDw+iQLeGgt6OIyX3RvtA8L8Aa5GAJEMPcpIpchxHk645ZYPL/Em
        EJThLUeoJNZMVMcQPLAbvBk=
X-Google-Smtp-Source: ACHHUZ4+MfFAmAGNRnDLA217kPOl7VMjkk+EpFcjLMx3O3bxQLaEunmAY7XiSxysSB3hb3desRV3jQ==
X-Received: by 2002:a05:6a00:1950:b0:63d:2911:3683 with SMTP id s16-20020a056a00195000b0063d29113683mr21916296pfk.17.1682958105544;
        Mon, 01 May 2023 09:21:45 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id k27-20020aa79d1b000000b0063b6451cd01sm20033899pfp.121.2023.05.01.09.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 09:21:45 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v4] attr: teach "--attr-source=<tree>" global option to
 "git"
References: <pull.1470.v3.git.git.1682707848916.gitgitgadget@gmail.com>
        <pull.1470.v4.git.git.1682822352360.gitgitgadget@gmail.com>
Date:   Mon, 01 May 2023 09:21:44 -0700
In-Reply-To: <pull.1470.v4.git.git.1682822352360.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Sun, 30 Apr 2023 02:39:12 +0000")
Message-ID: <xmqqh6sw6mzr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> Earlier, 47cfc9bd (attr: add flag `--source` to work with tree-ish,
> 2023-01-14) taught "git check-attr" the "--source=<tree>" option to
> allow it to read attribute files from a tree-ish, but did so only
> for the command.  Just like "check-attr" users wanted a way to use
> attributes from a tree-ish and not from the working tree files,
> users of other commands (like "git diff") would benefit from the
> same.
>
> Undo most of the UI change the commit made, while keeping the
> internal logic to read attributes from a given tree-ish. Expose the
> internal logic via a new "--attr-source=<tree>" command line option
> given to "git", so that it can be used with any git command that
> runs as part of the main git process.
>
> Additionally, add an environment variable GIT_ATTR_SOURCE that is set
> when --attr-source is passed in, so that subprocesses use the same value
> for the attributes source tree.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>     attr: teach "--attr-source=" global option to "git"
>     
>     [1] aimed to allow gitattributes to be read from bare repositories when
>     running git-diff(1). Through discussion, a more general solution emerged
>     (represented by this patch), which allows the attribute machinery to
>     read attributes from a source passed in through a git flag.
>     
>     Changes since v3:
>     
>      * fixed documentation link
>      * simplified error message handling when --attr-source or
>        GIT_ATTR_SOURCE is bad

Looking good.  Will queue; let's merge it down to 'next' soonish.

Thanks.
