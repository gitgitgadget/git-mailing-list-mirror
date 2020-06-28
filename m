Return-Path: <SRS0=levB=AJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B6AC433E0
	for <git@archiver.kernel.org>; Sun, 28 Jun 2020 09:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB0B320771
	for <git@archiver.kernel.org>; Sun, 28 Jun 2020 09:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzeoPZ31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgF1JES (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Jun 2020 05:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgF1JES (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jun 2020 05:04:18 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E35C061794
        for <git@vger.kernel.org>; Sun, 28 Jun 2020 02:04:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id q15so12445664wmj.2
        for <git@vger.kernel.org>; Sun, 28 Jun 2020 02:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rIxrjUj03tiA5FnmZsYJbk26CTE/nmOftY8Z9DRHCBk=;
        b=QzeoPZ31AyT5oWGk97mw0hABf6fLxDrU6dMQnnSrBuTxHf5lmwNxbaC0vNo4as5Ojl
         biDzYgzMft4llUX+BH3mf5jbJs8V0ATsevT+TBkMTJsURMPJkSVfKIyO9GKyXgUs7/Yh
         hDnqpszp+gUMBonhPFVKPFyhxa9lUHhL7rkSZkjEDGM7sVeP/1nTKVJpGtZ9L8QCgWjj
         qnnSlRkRPb+Jy7goWPYyN/sm3EnKdU+3U4JvnYIeaAJIQfDjxFb57AGCQUOmTfohstyF
         yzHzZWo64A1cEu5PuVtWIbklJB+L19W5nrvqKe1ESYBdGkNBvc7ykd6HyJ5ap49FgAIW
         xxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rIxrjUj03tiA5FnmZsYJbk26CTE/nmOftY8Z9DRHCBk=;
        b=XnOV1+bmhlknusHC3j6jU/mS5A6Nyb/ooNDF6Dr1iXliBoeAf7bo3eWL3VlygscJJk
         MAWYoikkQB21S2qmkCSI63EXWeWFBKu2l9e6+2KST0CkntXQLOCB1MzfvC8LpAqdjHiM
         XekMLd/0tBeklenxm7AK/jS05xkI/cTd75FS2RSJXA+FjyUvi8eSo230JgKky9qpAYFg
         rOQYOV41IMi6OQ4aNAWk3yDnRIGs5qRCovWmnTu34UKDey8KbcGMXKg/WGzSbNP19Asj
         UCQGt6HPacQlOjQVB9VtxZkOF+SFgx4+GhzCqxCAnqqGvtdIZT99OXU6TZG/zUf/Lcvp
         U3FQ==
X-Gm-Message-State: AOAM533vkSD0Lb8kT0mHpPzf3XS2J4awBIvi3fm3VM1cQqgVQxLVfUyY
        pzE9o55cDTkBmVGsLu15zHIS5R5M85wJbZXWA6k=
X-Google-Smtp-Source: ABdhPJz3cVWhMI//8+bK56LqsF1qIQoh26XKbbZd7Jrgl7N2UdJt3iG2LxKa4IzO1i/pOCDwH7ILxfQ4Ay4SiGJXEjY=
X-Received: by 2002:a1c:1d93:: with SMTP id d141mr11391941wmd.14.1593335055245;
 Sun, 28 Jun 2020 02:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAP16ngrfrvXxN=xwFDmqnY6z3sXwG+Lqsh_9JyECdVJ_f8hrzQ@mail.gmail.com>
In-Reply-To: <CAP16ngrfrvXxN=xwFDmqnY6z3sXwG+Lqsh_9JyECdVJ_f8hrzQ@mail.gmail.com>
From:   Gunnar Liljas <gunnar.liljas@gmail.com>
Date:   Sun, 28 Jun 2020 11:04:04 +0200
Message-ID: <CAAOnFsManNnFZD88oaMwHTSqffz6kS=fw3dnK_Ca1ftecP-=cw@mail.gmail.com>
Subject: Re: "gh" question -- perhaps off topic
To:     bruce <badouglas@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That's indeed a bit too off topic. The gh project is here:

https://github.com/cli/cli

/G

On Sun, Jun 28, 2020 at 12:51 AM bruce <badouglas@gmail.com> wrote:
>
> Hi.
>
> I realize this is more for "git", but maybe someone can point me in
> the right direction.
>
> Running centos 8
> When installing gh, used the
> https://github.com/cli/cli/releases/download/v0.10.1/gh_0.10.1_linux_amd64.rpm.
>
> yum install -y gh_0.10.1_linux_amd64.rpm
>
> gets the "gh" cli installed.
>
> However, there should be a
> ~/.config/gh/config.yml file <<<
>
> I can't find any process where this gets created. Should this be
> created/inserted by me?
>
> Again, I apologize if this is off topic!
>
> thanks-
