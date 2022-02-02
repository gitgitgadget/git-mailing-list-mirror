Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8273DC433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 22:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243351AbiBBWAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 17:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiBBV77 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 16:59:59 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B82C061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 13:59:58 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id g15-20020a17090a67cf00b001b7d5b6bedaso906227pjm.4
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 13:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coup.net.nz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q7C0Mg/gHpzUMjwA6OJsP4OopH2kQnar4ikDxFi4vFw=;
        b=NeBe5LIREe1TH+M4YDzUzk7rzsgVvTkkn6SbGUzvA+B+hycTGUi2L8MBEZ8eDUj+DY
         DyPsSMnlA0/YU/xoSy5DUuM6d4TDdJZ7EmZuF5mC8VzI2RDBtbq9pzT0FVwaidzUWHnT
         TitKgRPdOayQOfefhki8XW8QCjseL110bdVbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q7C0Mg/gHpzUMjwA6OJsP4OopH2kQnar4ikDxFi4vFw=;
        b=79DuCQnyceomWcBCwy9p9gIAXm1UiiOCIsiJUC9azKsCr4qzpDrRJuqIwOKutt/vMm
         3BRSYvSpInnAyJtVLAnWzSnP4KWfin/CCihXH1l0M012I/zOrO1PFLW6+VratwSU/tGz
         kxcn4yGYF6FcUBCkJ9XiFM2CW2XX85FHqc/2qcTk8P6ebbHQ6UONypD9efAhbAJef/Fx
         +JK5HtFQyzZfVTX+i3UDrjzBkO4Bzsg7aAJNNU/vlFX6VkXDsmFhjQlFgwTKwHo49Avi
         n7ZIJ96FIpJEsZN8Xi9CviDVteNydnXthDxfAi3TlPBhBEniP91fgLphUqu8ltE3o+oF
         OAaA==
X-Gm-Message-State: AOAM533KHoyCamMUaN8EOhpFLMvG+KZygAUzOwtsQ1XEgLHfqQaIJvVY
        S7dVofzvuxtbwrkZQovve9eqX0NIUfiBVuJH4T/R1g==
X-Google-Smtp-Source: ABdhPJza32e/dpYIfi7dhQC+2L1P+IGFxET6maNyWPDbrJERcjCXhgdPPJNbfuWMebHdqF0+Ypqx8IWF9ItUBvfQKTA=
X-Received: by 2002:a17:90b:4b88:: with SMTP id lr8mr10384996pjb.166.1643839198261;
 Wed, 02 Feb 2022 13:59:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
 <20220202185957.1928631-1-jonathantanmy@google.com> <CACf-nVevXOSoGTLp4qK2c6HE60+pwotUS3p0+N_zia1+opAdXA@mail.gmail.com>
In-Reply-To: <CACf-nVevXOSoGTLp4qK2c6HE60+pwotUS3p0+N_zia1+opAdXA@mail.gmail.com>
From:   Robert Coup <robert@coup.net.nz>
Date:   Wed, 2 Feb 2022 21:59:47 +0000
Message-ID: <CACf-nVd-z-qi2VhW2P1YamaqQkZKEGwMa1m4ZvxqtM9Nmmz2QA@mail.gmail.com>
Subject: Re: [PATCH 0/6] [RFC] partial-clone: add ability to refetch with
 expanded filter
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org, stolee@gmail.com,
        me@ttaylorr.com, christian.couder@gmail.com, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2 Feb 2022 at 21:58, Robert Coup <robert@coup.net.nz> wrote:
>
> Hi Jonathan,
>
> On Wed, 2 Feb 2022 at 19:00, Jonathan Tan <jonathantanmy@google.com> wrote:
> >
> > Thanks - I think this is a useful feature. This is useful even in a
> > non-partial-clone repo, to repair objects that were, say, accidentally
> > deleted from the local object store.
>
> I'd

I'd be keen to hear the stories here :) Just losing loose object files?

Rob.
