Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ABBC0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 17:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbjHARYZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 13:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbjHARYK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 13:24:10 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9372D4E
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 10:23:49 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b74fa5e7d7so89410181fa.2
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 10:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690910626; x=1691515426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oBTbu1MkvX9qtLUQwbMqVZGCYQ0o/mEoYdTwPJIo+tc=;
        b=Pa1DPGV0WiWd/RoLqcYRBZfqy8rLIoK38yvGwvwHVQ8CApOjOa1MqOf6w8DX3k+wSN
         GIyszCQu3jUqBuhEksKMxmBgqbJDqP0FuqY7d1tzxJYcVK7zzTkpq0uS5e4+xNgwlsYB
         O/wJs9ZgmK2yLn19tTv0MM7P7/E7bjU3/8YgItOITmsGu8myjdujTXEsa1NeOljXMIDi
         PjftHw0/TkpeXEPvMBc1b0Od0vNDNhCUBKwfJ3JsbSo+lLMUiQ7PM9iHS0pZpB+rW80p
         9w9pNbWxCXFoQMy7IPEDPX9MX0wvzt/XGESaegNAK1pKhn92AM1Whpx4B077UQ/AUtMN
         93+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690910626; x=1691515426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oBTbu1MkvX9qtLUQwbMqVZGCYQ0o/mEoYdTwPJIo+tc=;
        b=cFjOScSCFXvJsNs542NdAtT1vbKIdvLIQEoZB2Ek41I3ghMkhGqASwHmWZdI5mHBNy
         CY1bylQeu0VqaGm15APaSM86psm3jvLrhDUtmLc/9cw3hs/HPpsNRRrvJ5Bhfy2i5Fpm
         VdDq+EDo59sTecXLnkhjpv3mpPhXeAvJG2x2rTyRQPTowh2wFTdvyGPUPhhACnwt/SzF
         Ff+QFDnoX+8VWbbhzoGyOqnJ6q98pOPvWyxtM9qNTemeKvIfttWAWJ1JRM3PphhichTC
         A4jeVTrOH+UYUYz/dAHymPYxW4VrPGj8uKWA508X7i7DcSNRS8t965C/VE78onXsZvJv
         eHdQ==
X-Gm-Message-State: ABy/qLZblQ81de1Wsh7hIbQwtUsz7CUrsP4sF6jMBASBy5QevrykHdxo
        Vv5Udkr94sV+JYjuNWLQEitRGhrnt/WqSap3B7M=
X-Google-Smtp-Source: APBJJlGIYw2AQg8W4sF1HdgCjGfeAEuMbXgi32WsXVmQs9MyJCJiTIoqFZRLS1SVCwGv/aIFNfU5s4RhBx4U7aqwfEs=
X-Received: by 2002:a2e:b710:0:b0:2b9:bcac:7ba6 with SMTP id
 j16-20020a2eb710000000b002b9bcac7ba6mr2637467ljo.46.1690910626383; Tue, 01
 Aug 2023 10:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <CACmJb3yoHagaU1wb4qRT-nZV4Wptao8boaUXCAYrFxfrxcmUYg@mail.gmail.com>
 <CACmJb3xWh+0BR_V6sxfMK7iMSdWfvY9d2rjt1hnZhFw70zWweA@mail.gmail.com> <xmqqa5wjee25.fsf@gitster.g>
In-Reply-To: <xmqqa5wjee25.fsf@gitster.g>
From:   Namikaze Minato <LLoydsensei+git@gmail.com>
Date:   Tue, 1 Aug 2023 19:23:20 +0200
Message-ID: <CACmJb3wTsWdqDGrkYC0p+eB-XYBotVcFAKcXJF3ftYdiiRvEdw@mail.gmail.com>
Subject: Re: git-switch history and checkout compatibility
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 28 Jun 2023 at 18:39, Junio C Hamano <gitster@pobox.com> wrote:
>  * I suspect that requiring an explicit "--detach" is deliberate, as
>    they were trying to make "newbie friendlier" version of checkout.
Yes, I also believe this is deliberate.
I do not think however it makes it newbie-friendly.
As I said, on the contrary, I am having a hard time to get newbies to
start using switch precisely because it behaves differently from
checkout.

>  * I am on the fence about the latter one.  While I think it is a
>    bug if "switch -" and "switch @{-1}" did not work exactly like
>    "checkout @{-1}", combined with the previous point of requiring
>    to be explicit when detaching HEAD, "switch -" that tries to go
>    back to a detached state may be justifiable---it stops you in
>    order to avoid accidental detaching of HEAD.
You are right, it may be justifiable. But unexpected behavior for both
newbies and experts may not be desirable.

> Personally, I think those who are familiar with and expert enough on
> Git and do not feel uneasy working on detached HEAD can and should
> just use "checkout" not "switch/restore", but that may be just me.
Isn't checkout supposed to become deprecated at some point?
Does it mean I can safely ignore the fact that switch exists and
continue advocating for checkout instead? I am missing the point for
the introduction of git-switch entirely then. And as you said you were
not among the primary advocates to add it, I guess we should wait for
someone else to reply about this?

And I still would love to have a checkout.autoDetach or
switch.autoDetach option :)

In any case, thank you already for this reply <3
Minato
