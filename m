Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05530C55185
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 01:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB41A206DD
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 01:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXUvr6S0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgDZBMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 21:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725962AbgDZBMf (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Apr 2020 21:12:35 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E12C061A0C
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 18:12:35 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id z16so13568865uae.11
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 18:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQIhWXLSrdKHWXyFOnhf/PrRqsW7XA44KBo1Va8hsZA=;
        b=LXUvr6S09A04GJHXiX0OaD59OZQmTQntiuwP0a7dFIf+PJyimBgD9tg+XU+Mf+DGZc
         bRNXjyom5b/xD875AJym7Is+N49vBI60TSqcxIX1s3ZcXFayU5Zwb80cEPsfOSFj+2Pe
         PQ1CP3hZ7CpvIn2+ClTHokTRKS7t/wABOZRlQ6DFH+0lJQtUBAE7rZFB/AWwLwTj3YOv
         /v4qccPqchb/Xgt0ERHTxOFJV/8T6pCBb+C/UIYJIup6AW64b7GbCzqsXxqgkeexyFCI
         +c6aJ4mxMk9Ia6YP6TcJ5+xJPLJTJfXCsoMD/8obTjnGUgbiQMkST6l03YlH/sq5yj/R
         UBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQIhWXLSrdKHWXyFOnhf/PrRqsW7XA44KBo1Va8hsZA=;
        b=bUWTfi/ZYaoGgbAgYQtk3qUzX0hh9ZnYRaubrm6Ax1ZLscDxu9C86lftUNGahOIfcG
         LnBpZgR9hHfviVnDMPlr9GrpyNjByh0PaVm1lY44tLJsV+pfUZJy1rOjZQLSzSr6i5KM
         iyG8Q1+RecogjL6PXJ9ZF4UBzuqOgGeFjU5FpjeaA6R2I6XRh8lju5oI9WkJE246909s
         f7HYsPj65VwgqEffPI9xNl4zfWYSY8nCTbq/uuzjD9JN8RPmvyrjbWy29oGVzD9UFzPx
         5RMPB+SwCwX4xeUrG79GhhqiVk8XcUT61ecLf5B2+MzOfYmviignOKU7h4UOow2aE7aw
         2NTg==
X-Gm-Message-State: AGi0PuY7osZ37Z4n31sxq/4C5tsFfPydnx9tGnel6TNk++FUOt4BGE8/
        ElGQgwsOhXqMnMn8T7MBAkmX9N6v/X/577Esn/4=
X-Google-Smtp-Source: APiQypL5pn2q+m0RlB9nPUO4Rv7VTx0GXQfG7kGYsMSXo+HvPAB84AfAQyHucBuZ5UiWLnUOJ6bgEL3hrpJip1wxV64=
X-Received: by 2002:a67:a20f:: with SMTP id l15mr13097295vse.40.1587863554562;
 Sat, 25 Apr 2020 18:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200425235716.1822560-1-maxmati4@gmail.com>
In-Reply-To: <20200425235716.1822560-1-maxmati4@gmail.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Sat, 25 Apr 2020 21:12:23 -0400
Message-ID: <CAOjrSZs33-CqV5m4wKROYJT8au1hup7bGZWiEaXMV7cU4p-J=Q@mail.gmail.com>
Subject: Re: [PATCH] config: use GIT_CONFIG in git config sequence
To:     =?UTF-8?Q?Mateusz_Nowoty=C5=84ski?= <maxmati4@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, bwilliams.eng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This would need an appropriate addition to show-scope functionality in order
to be considered complete too, as I believe the current code would give it a
scope of "unknown" which is obviously incorrect since we know the scope.

-- 
Matthew Rogers
