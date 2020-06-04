Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1633BC433DF
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 14:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1CE0206E6
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 14:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ld+RpX+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgFDOj7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgFDOj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 10:39:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149F6C08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 07:39:59 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a25so6370448ejg.5
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 07:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sK12jVG09lmcaXyjQsOu7O12cvn3ygc+coDVhwpXltM=;
        b=ld+RpX+xrBE2B3SMV+EdtAbUseBwQdv8d1vSiSIXKKX8GUvsctaLI9mLtI6vKQ2bS8
         R29FAzYE5LboA7f5f4MWtjsqsnAnxpY1sA/+w6Lfz/95LrWCJn0atXwOSvWE1ODXoKPY
         4nrlP2w9xkINpjRkGuATWIBh1bsXMctIga34ym3xuH+ngyyM2ibs0uCZgXZ++ONXPy5z
         kuf+kkkK4WVyF0tiheZY+oAeWc9bazte5Snnu4omg8yhD6R/RlJ+Bfd3PRBHDz5tBsbS
         T2MQ+N4EhbE/QsrfnRXoiDZ7fk/dsuvlwy9SL7Ppmdk8PdfOWzv6GNlf0z7MXpnpVEw1
         27Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sK12jVG09lmcaXyjQsOu7O12cvn3ygc+coDVhwpXltM=;
        b=EOQHRQ5bRlcsA3t2RKsXNYsIW2emlLMqXbRKVpBdRnzchA+Y3e9s4vfXJ45+sBsHhH
         PBbksASujvj07/Lic375XM2uTm7SWHXyESLFyjFC+WIAO2zlUxOMgCy2JPqKl4JhMAjl
         pnLnpvFrHqvxoEmlAtRuUDwaqGWVIk3WVMzD+fLjcF07hVMsU1f8AuXVBMwVmvbhsi0V
         UfMFYHVIVAPhxtsFS+ANP93edB3Ove00ti6X0OKGzlU7yfAgPG/9DyBrTYdDB+ly8j5p
         91M8a0MzF0jURZ0wFJpXEex7UAGCL2wgCUtfzih1IOX7O74BVib4KzwWWqmJl1fWu0bV
         vm2A==
X-Gm-Message-State: AOAM530nvMn0LnsrmZbWGMf9gxs1pfqJIWhqcJ4KPUbJRcBSSuXBXePH
        djtLtP8JxER9KkZ532NVqkPttH9cy+q7J4WfQLrBbDHN
X-Google-Smtp-Source: ABdhPJy2MpZVn/EW6YVBFckd3vpPdttAGf39EEoz01Ji+XzuVg36AJbi78tGSGyun6RRdnwvNpEOF8CL34ttBqe2yQo=
X-Received: by 2002:a17:906:509:: with SMTP id j9mr3972223eja.341.1591281597676;
 Thu, 04 Jun 2020 07:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqlfl3rhl0.fsf@gitster.c.googlers.com> <CABPp-BH=SqT5v=CnuPm+6Sqy+1tP=72Wx_oCKs+DxJcdKzwgFA@mail.gmail.com>
 <CAP8UFD0V+=tq8CGFk_Mz+N=HjRtkhkMbX9Cy2-=WfHL8wrj6=Q@mail.gmail.com>
In-Reply-To: <CAP8UFD0V+=tq8CGFk_Mz+N=HjRtkhkMbX9Cy2-=WfHL8wrj6=Q@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 4 Jun 2020 16:39:46 +0200
Message-ID: <CAP8UFD2x_j9Ne-YQes_Q9B+MAgXgM7+w2xSZpMVxNj3wnf0Rfg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2020, #01; Wed, 3)
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 4, 2020 at 4:32 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Maybe we could just ask people to test rc releases or 'master' in Git
> Rev News? It might work better if someone wrote a small article about
> what is coming in the next release before asking to test.

Such articles and asking users to test more could also be done on
GitLab's, GitHub's, etc, corporate blogs or on Git developer's blogs
too. The content of such articles could also be shared between
different company blogs and Git Rev News to reach as many users as
possible.
