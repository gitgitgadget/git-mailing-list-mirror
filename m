Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3210C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 09:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJDJwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 05:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiJDJwI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 05:52:08 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F8630557
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 02:51:01 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1324e7a1284so7248704fac.10
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 02:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=d+FlGI8XBiQlk2TxYFG10Q0qYPO+JjFtV3inxlx7HZs=;
        b=EzZ4yGUX7EQDxI3zhAAAPY3zu4boCzem3d4U4ypJbliOplIh1mXcAqepFNImno6VXR
         ktkzYVYl4VBvcbBT/r8HTjycQyK+wTAATMPIJeO/BdVMuJwe6o4UuyjfgZRhDb6hDRvB
         xVcJUMBAkXHBwW1xbHQlb7F9ztJeM64fcgHnROEgz6NPR+6kprWv0Z3taU+BECKwTdJi
         /dhfBrcJ6WN6rjVkpRrZyJGi6AX2GzgB7Ywl0MFq9z6hKQlpC+ADWrh6FY0y9cTr4T4W
         dpYSM//PUjyKrmLs13HxzJrdodlCRk+t41ijwj8l+2WZW6+z3Y8cke284AsjemBRwHnW
         vCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=d+FlGI8XBiQlk2TxYFG10Q0qYPO+JjFtV3inxlx7HZs=;
        b=yOFV2vPiiGDUNJgzrnW8EjrnIqRqH/CkCJqWLs7E0LBxceoYXVWBU6q+I41MSlIbsw
         7tYX5RP0eMktXsL3qOYVgJRWUwHCWYqugZm+wYw1YGonkhyuIYn8EQgTZyt/QF1BVK1H
         p523KtuScUC8CmqUxpjpKc3K4UaG8RA6WSJjrv212fmSuC65pkg9Mo+C2/Uop8gWH3zR
         1IAUSmCreL0dVn4xXuwkRnG1+op1s4TM/YOHW4IeovSViFQQUDVctzLwE3SFYuB8M0El
         nxZM7yLYgLvTVqVQ4iSXemu4bWCMnLjUfMAxYo86NtZlmUAZLqv3orJGkl1MlwhMODar
         AB9w==
X-Gm-Message-State: ACrzQf19CQMYZM+eQFA0gzjh3NNndAzRe0C54UXrpE/kdLnvdngcEPXH
        vYae/BNKPvoQUs5qg+Lsk7SU6wFJaaq6FL8YLDI=
X-Google-Smtp-Source: AMsMyM5lJ9n+HSxFx0mfX8t2GK3yLyjkTRT4KG9dbcGAHafXLI4zLuqQF/P6NLPw2jTISv8DpV3iN4YN7xvpqJEz9zg=
X-Received: by 2002:a05:6871:588:b0:132:8901:5d4c with SMTP id
 u8-20020a056871058800b0013289015d4cmr3408596oan.106.1664877061301; Tue, 04
 Oct 2022 02:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <54e559967df55ca314e629b65927a88c7f804a98.1663959324.git.gitgitgadget@gmail.com>
 <fc291c07-55e9-64f8-1251-20bd2422024d@gmail.com>
In-Reply-To: <fc291c07-55e9-64f8-1251-20bd2422024d@gmail.com>
From:   Chris P <christophe.poucet@gmail.com>
Date:   Tue, 4 Oct 2022 11:50:50 +0200
Message-ID: <CAN84kK=vuvmaPJeVupV-ZN2Cnn_E+9STvxRqEbQc4m3dQbD34w@mail.gmail.com>
Subject: Re: [PATCH 03/10] ref-filter: add the metas namespace to ref-filter
To:     phillip.wood@dunelm.org.uk
Cc:     Chris Poucet via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Chris Poucet <poucet@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I assume this is to save having to write "refs/metas/" when we want to
> search for meta commits?

Yes, though currently it still requires "metas/", I'm trying to figure
out how to
remove that.

> Signed-off-by: Chris Poucet <poucet@google.com>
> --- > diff --git a/ref-filter.h b/ref-filter.h
> index aa0eea4ecf5..064fbef8e50 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -17,8 +17,10 @@
>   #define FILTER_REFS_BRANCHES       0x0004
>   #define FILTER_REFS_REMOTES        0x0008
>   #define FILTER_REFS_OTHERS         0x0010
> +#define FILTER_REFS_CHANGES        0x0040

> It would be nice to keep FILTER_REFS_OTHERS at the end I think (we don't
> need to worry about abi compatibility), also what happened to 0x0020?

The 0x0020 is listed further below, I don't know why the previous
author decided to
put them out of order. I've renumbered them as you've requested with
the assumption
that this data never gets serialized to storage.

> Best Wishes

Thank you for all the feedback!

- simply chris
