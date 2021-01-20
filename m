Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6827C433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 11:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C29F23159
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 11:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbhATLdh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 06:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387781AbhATKpL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 05:45:11 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF96BC0613CF
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 02:44:30 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id e15so15891320qte.9
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 02:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XhTtlDFo1+FVVbcCEubIu9FdLe89h9AwHUrWvh7HrNs=;
        b=HYfEs+sQnYtRC2WmcdDkSLI+riKeHuT165Baui57pbvWH9jLqsRVBwmh7Ctq/pw6gh
         OtqtORmmWgZ+7KnQ2IhPlpEXip16R8jh8Z15WzTci44ZRC7m9OnNnTaXsEkyKZ/PouOr
         OpIJTHrur6/jRLhRwbEyCdcLLGAFdYA1FiY1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XhTtlDFo1+FVVbcCEubIu9FdLe89h9AwHUrWvh7HrNs=;
        b=KRlKWTQJUzoD9tt495c8n0V4brksc06+VIlVm53aZvoxokXvd1xJ/aLlCfrZHdGbAt
         JG2BOkbMk9En/GInK8ZxWzg+f/oR4Bc61D+8oVzQTZz7stojuaY1BW4fqkDQ65/Ek5mW
         3YZhGlxQGZ/Bi8orYgzIaYx5SGdMMjScBGlIBsaX2FWCFrNCDZ5C0oTIBvQeqSlfqQ1X
         kp21SRFdM8t+REkBUZbCk0F8aN+rpyReljIDsgkJBwmQzT2fyWfAW+xbyPHzuoKDpQif
         EarZ1B/qV6q/0OcKt3yPoZQxJO5+2ZdCYdZea3v+XdlJ886BJEmmnxo5IJc2eVHL4uai
         4QNQ==
X-Gm-Message-State: AOAM532LxHZOnx3ZTZWdCa+JInavudEYADo/476IoDSBzsVi/CqxVJv2
        oy4JW0vCiDVdHxVrkrdWAZkVTijNFXlsI6pvEouRaw==
X-Google-Smtp-Source: ABdhPJyJwpKaZq7e2342AfjJz87tacz2mgHuQZj+m/z6QZ7S7UAPd6Isq5UgvEcvf84AVRbAIfVQ5KejsFoE/4B4aTY=
X-Received: by 2002:ac8:782:: with SMTP id l2mr6433080qth.271.1611139469964;
 Wed, 20 Jan 2021 02:44:29 -0800 (PST)
MIME-Version: 1.0
References: <20210119144251.27924-1-jacob@gitlab.com> <20210119144251.27924-2-jacob@gitlab.com>
 <YAdjBC7z2eE1Z0uk@coredump.intra.peff.net> <YAdkg7ZijzfB8eMc@nand.local>
 <YAdnB3Qy46qQ2to4@coredump.intra.peff.net> <CADMWQoOzD0xF4PSAUo2qXp62-tTJX4DhquFZxFjfdQmy+7j+6g@mail.gmail.com>
In-Reply-To: <CADMWQoOzD0xF4PSAUo2qXp62-tTJX4DhquFZxFjfdQmy+7j+6g@mail.gmail.com>
From:   Jacob Vosmaer <jacob@gitlab.com>
Date:   Wed, 20 Jan 2021 11:44:19 +0100
Message-ID: <CADMWQoMHUwJcR5T8H048BgsLCd8-_yg8d8Dj-ojYV31pUmhw4w@mail.gmail.com>
Subject: Re: [PATCH 1/1] ls-refs.c: minimize number of refs visited
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 11:40 AM Jacob Vosmaer <jacob@gitlab.com> wrote:
> I also think we could. But as I alluded to in my original commit
> message, I don't like how complicated that gets. I find it easier to
> convince myself in the current form that the longest prefix code
> selects _enough_ prefixes, which is a weaker property than "selects
> exactly the right prefixes".

By which I mean to say I think we should keep the current form, with
the final authoritative ref matching pass.

Jacob
