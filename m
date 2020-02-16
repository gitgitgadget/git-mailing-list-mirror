Return-Path: <SRS0=2Qsv=4E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SHORT_SHORTNER,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBEEC3B1BF
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 04:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1036620718
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 04:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTDhv19Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgBPEnB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 23:43:01 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36750 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBPEnB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 23:43:01 -0500
Received: by mail-oi1-f195.google.com with SMTP id c16so13637764oic.3
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 20:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V/+W2ZhlP19bbGZLreDlHsZ1bijVMmcXIzSENk9hfEw=;
        b=UTDhv19Y47B8mjNjHZu+dnMeZQG6c+PAMRmi+ArEa0PCRvpZOiHvIC3yTzIQZsd3k9
         DyBEZmQzu0njnjejFvcBNyNfzHYdryOfATaPMz4uxA1L9l9mF+a7EsbVUjlPsknT1cej
         8AwumqFW5GAtUK8UiW2m0yQGXRWmpyE4Ptf6xHlpdv6Zmx3Hv0765KG5CZgeTboPyGJw
         pdjrzC/+hFOuyTiDwhea1hQ8xdugesiYSBVCi5ucNc0UA9AIxw6wIsLqhA8TiArX0IJK
         C/H4wXawgKT4dbFiaLEI6dRWrV0Zbq2W/InunY9u8+QcbrEbVSTthf4bADGvbEinxikQ
         zJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V/+W2ZhlP19bbGZLreDlHsZ1bijVMmcXIzSENk9hfEw=;
        b=A7C8I3y8p1e7L2haccsR9YGk2cb05aUcm07le1Y5zsSVf13e5Pgmbh+sFAMU+ezaZw
         RDsu0MXB6HiNKJJf/ot5RpX6/g/haODEdfzF8rt0icAXtNSTN1v3uP22+7z7cqF4UtRc
         o6+vR6xdj8EHPG4QGd9qVBbzPFlCkPNLD9C+HhWV8hztyad8a2h6dRi1y5eAL2SBmv5W
         0hYuwLpTNJZl9HAGAyjTkufY5mtmqrXNp0R1QEEJU3igMo1fS+mO5ZhbJPzvI+wQW1hn
         rg1goqfrvnkyjoKkNQhE2yjY4MqKBQOhplc9XLbaeUiCWgFkzBeNSMhQXZjbfGEnZXQZ
         OtAA==
X-Gm-Message-State: APjAAAXJKcbrECaeYDc3uPjdxnxaVBshuEUvu2u6BvE0vFOgi9ET21JB
        JrbLXutJKAjD6she4j6Dhsy6bxUHQJl2XnapMIE=
X-Google-Smtp-Source: APXvYqyhPLH3qOQDFqfBcX/J4j0gKvFH6KQuvCbUrFqHYU3ep4pGoiWrWrx/W70xsGw85LvRk6HSmGltj1fMrAP0r6c=
X-Received: by 2002:aca:4e10:: with SMTP id c16mr6247301oib.6.1581828180230;
 Sat, 15 Feb 2020 20:43:00 -0800 (PST)
MIME-Version: 1.0
References: <xmqqo8u3tqly.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo8u3tqly.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 15 Feb 2020 20:42:49 -0800
Message-ID: <CABPp-BEdrFnSqPnK6FsRqpyP7qZALg_K8JDkdqxnhwkD4yFdzA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2020, #03; Wed, 12)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 12, 2020 at 2:02 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
>
> The fourth batch of topics are now in 'master'.

Somewhat of a tangent, but is there any plan to update tinyurl.com/gitCal?
