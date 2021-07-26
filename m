Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05883C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 00:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C4560725
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 00:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhGYXx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 19:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhGYXx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 19:53:29 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D7EC061757
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 17:33:57 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id d18so12444501lfb.6
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 17:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bsGZbS2WgMKpx3GePI2yJ7JNU04gSrf0R5XXGvbP/WA=;
        b=jXXxA5NBQwv26stDpcFMnpgHSft3uELlkfwda0XpTZXkya5TQjLQ8zaiKgcSU8JPiX
         67VPmw3cyzfEPwvFilLdWk4SSlpX14Ug4JxRjuCMcdkGDBo4TqiJaoGv0EWpcXb1BB9g
         PPXGvCQ0MdkNAKxcFg/rGjkS0zFPbSVGC68aDwKUiqNCHtTMwGquZNYkPYFl4br98Z8e
         zmu60fp4E6ZyaBIdR3iDW+zRl5risuc+Ak7bDpv12J04128AZdTzBOenhCOpJYV1N2tz
         MQ4MbmbVgkxnzz4iOJpvIo5YpmsxTt2fvT6tbj1kO8HWoKbjtofjeA9GpRLiZK5BMJAl
         H8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bsGZbS2WgMKpx3GePI2yJ7JNU04gSrf0R5XXGvbP/WA=;
        b=tJL/4nIqO45fd3QOwl8yWtFu9Z+NqS0yhQj2vOFqs+hadmkd8eFGqQtiLSZP+SY/u6
         SjnF2b07bFkr4tNbuuYqW38iUL2zHe7ZDWCu1bJPJ0IR/a6vMU0Ip1oWdFqtk3Mi4h7P
         fBXHp+7Y0JVR3vaWJy58dThpIiZ6e7c0Evx54dP/OyGvlQfGudwftq88b5Vb9q7ilBiM
         +pSSaHQhceIv8R4TfTK0dWXnGQMnljg5jJue6uiUjTK9lG17ROiPn62zqdDl3TxqnCbj
         pvdQdNlxxBOYlt2NjKx6BjPN33RUvkocxbaK+NOvQbIzfnDqvEkGu1/c2InfFyhZL2Z/
         cXEA==
X-Gm-Message-State: AOAM530HQnT7soGbEusxHywT9oT44Q1TyqpNDnHe23OtGcJKyIZBZkM/
        rYdBr26TEkWG9VGrVwItAnO607G6ez868knye8M=
X-Google-Smtp-Source: ABdhPJwWwIqmXZKJ0sVFBvozijWJ8sbMXl64P/ibMWFqiv5WHs3uhx4lbaEvBc8R3ULSm4+e3EGGwCHPo+1lkfu27tk=
X-Received: by 2002:a05:6512:3141:: with SMTP id s1mr11140031lfi.644.1627259635724;
 Sun, 25 Jul 2021 17:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <dd4aca2c-9ca2-e489-d78f-9d2a5580f1a5@mfriebe.de>
 <4e9b54b4-8e40-7fd3-ae65-d33390f3af43@mfriebe.de> <04f3b300-3ccf-c91b-6406-6a998b473a24@mfriebe.de>
 <bfc257c7-bf74-06be-ac62-9a6d27f565c9@mfriebe.de>
In-Reply-To: <bfc257c7-bf74-06be-ac62-9a6d27f565c9@mfriebe.de>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sun, 25 Jul 2021 17:33:44 -0700
Message-ID: <CAPx1GvcHiaGsuOybOijRYpmivO0dLvUFacAeOrM4DfY-uuXB2Q@mail.gmail.com>
Subject: Re: Files modified, even after: git reset --hard
To:     Martin <git@mfriebe.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 25, 2021 at 11:43 AM Martin <git@mfriebe.de> wrote:
>>>> [Files show up as every-line-modified]
>> [and] git replace has a weird effect.
> Ok, it seem that
>    git switch
> simple did not update the file.

Here's what's going on.

(1) No *committed* object, including committed file data, can ever
    be changed.

(2) Someone actually committed some files with some sort of line
    endings.

(Points 1 and 2 are true regardless of anything else.)

If you never have Git mess with line endings at all, neither of
these two points make any difference.  But you chose to start
asking Git to mess with line endings.  Things now depend on
exactly *what* you ask Git to *do* about these line endings.

Let's suppose, just for convenience for now, that the files in the
repository right now actually do have CRLF line endings.

Let's suppose further that you ask that Git ensure that your
*working tree* copies of each file contain CRLF line endings.

This means that existing *committed* copies of files already
have the ending you prefer.  But now that you have started to
ask Git to *mess with your line endings* -- by asking that your
*working tree* copies have CRLF endings -- Git will now begin
making sure that *future committed copies of files* have LF-only
line endings.

What this means is that any existing commit you check out has
the "wrong" line endings!  You've just told Git that all the
*committed* files should have LF-only line endings.

You might ask why "ensure my working tree copies have CRLF line
endings" means "ensure all future committed files have LF-only
line endings".  That's a valid design question.  But it is the
case.

As for "git replace", you've figured the rest out already: if
you use git replace to make Git use new, LF-only line ending
objects (file data), Git is now happy about the internal storage.
It just takes some shuffling-about to cause these replaced objects
to wind up in Git's *index* AKA *staging area*.

I'll mostly stop here, because this explains the results you have
so far, but in general, setting `core.autocrlf` tends to be
inferior to making explicit decisions about particular files
via `.gitatttributes` files.

Chris
