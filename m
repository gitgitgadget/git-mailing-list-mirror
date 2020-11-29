Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A9EC3E8C5
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ABC5207CD
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXarN+A6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgK2Hs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 02:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgK2Hs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 02:48:27 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E57C0613D1
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:47:41 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id n12so8488622otk.0
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pF7V1b0ea8bz9MFAAZPacSZxIwUOPqYL91olEyEzOV8=;
        b=VXarN+A6NPWgY+98406hBr3tMaigNJrxJ6LyTa51175LwmlT+dMLB78UtPGwm4QMQB
         dKr4sGeN4E1+eNPS9KK3jKajhqS5SchBISMaRgN/bVz0gVUzNXPNzvxYjVcyNJFKH8C1
         p3ZE5TZHgK4dsgoa9HjuAGkLTU1rNgUV2a759Z7qf6iXrldwxNBIVRgbRSaOxMs/00ha
         fI7klTE3WQSPQKcwZlBKIWPv8ltAN4KQt4xoNi/CFfBc++t9HsamUL4btlfTIOuZ8Rsc
         aOwTP34PQ9pM2yCopijNMKhB+rSUHHIH3fqwXFfwIP907xyey7YWHzSTfWYqQWswKdSW
         T6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pF7V1b0ea8bz9MFAAZPacSZxIwUOPqYL91olEyEzOV8=;
        b=kdnqkgKfdr/Y5mD+5OKGJPKVDiJA62uDuDZsFq0AuwEnuLCXstR4xV0KUMGnkgqkj1
         Tom2GulkJXvWKXjHWZwFk+vwrWZMlIChzAgjYnkhpF3NIo/r4AYZIkLIKJ7lnsN9buK+
         XAF4AcbyJxXUmRSMMnAT7nskhsj/PZ2dd82I81zvIB/Mg36Rumh55B+4nngqR855Fgyc
         TG80LF/6hrLgp3Qo58NL/10037Xgaww4T2OZ5qEhqVXgvA4SvhXP1hrbZPyiVEJNmn/d
         vRluDFzedM37uY7gYfRw+8lAw/nEmMH+5sqJSm1cPMzdh4ybw8yNCDY583CgZY+5ibH9
         xtbQ==
X-Gm-Message-State: AOAM533xAqAkfDChZiCPy4pVdwa/UOywIOtucKETwzRldcpKiRmHss9U
        2nw7/5kZVcuyYFwQDT5yttqHN3wXZaV20aGIfAs=
X-Google-Smtp-Source: ABdhPJwgcCnS0trSN052RZiDetfA/OktJrGIPOeyrklMNP4RRDvD9uAt8TXBBU3bmCuKXfM7lw1AZ+RIkv2JgUcPu54=
X-Received: by 2002:a05:6830:1002:: with SMTP id a2mr12313915otp.316.1606636060253;
 Sat, 28 Nov 2020 23:47:40 -0800 (PST)
MIME-Version: 1.0
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 28 Nov 2020 23:47:29 -0800
Message-ID: <CABPp-BFnzOmJ=7DBXufEDbvqUfJGiKXsAqYdnBe9oTGcMotZ-Q@mail.gmail.com>
Subject: Re: [PATCH 00/20] fundamentals of merge-ort implementation
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 28, 2020 at 11:43 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This is actually v3 of this series; but v2 depended on two topics that
> hadn't graduated yet so I couldn't easily use gitgitgadget and get its
> testing. Now that the topics have graduated, I have rebased on master. You
> can see v2 and comments on it over here:
> https://lore.kernel.org/git/20201102204344.342633-1-newren@gmail.com/

Oops, I forgot to CC my two great reviewers of previous rounds.
Fixing that now...
