Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA226C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 22:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiKUWXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 17:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKUWXH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 17:23:07 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A1111C2C
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 14:23:06 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-39562b26a76so92536937b3.15
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 14:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vUjzJcUEucbUC7YTDGk5sf2yRJXewWWMd4woBm9fg4Y=;
        b=JdljOf+lHcn9x87JXOyRJIoZYdLtUldEg3B5sH/MtJF8FdG49nQe1VnwETDiUeX+rs
         /MlYPXnF5F6aezwS1u4pjW0HGXBPeLJoaVMwBmS0sHhySIRuIFqVUwEw/s+FhvdIq7/M
         Ep2ARnq6jiSXEvy8ET+cWtpyaZQM7UoVc0DqGSLLcIUGWz9b1f5rJJ3CS2HZQSP8DrTm
         uof1YD8WCiaZAFrYSTY51KGnqZodTUaKgqjT0Sk+X8z9hTaI3a1TGA7Y9VdksbbX3Jga
         34KdieEimhrNM2Wi8mj+em0yQIL0L7tHgwqNVyYmz0mgxBiG0x6gHdRq/alUwL+q4ke0
         ofBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vUjzJcUEucbUC7YTDGk5sf2yRJXewWWMd4woBm9fg4Y=;
        b=Sz+yvEnrknsAe9FT/aaf0WtFsEJ9oQNPJzaWmZ4xejt/2e5zu6c7mdIrkhprTgKnMO
         ndqNi0UW8gqael+lmCyEyxc2RJJoflGmsTJGhRsKBynns0xkVEln6oEslYn9178RNoTH
         7hDJqBnOVsLsUjDvl3TUtaV6KeQPK1YeCrZ6CEbicr1a9/Po2Xpi/NrBWAEDGc885yyM
         olIeMHobTxuOBK/0A/NuVuZKnFG1wtH6LS6YacRnp3STxiv0BAQC9mvwWDogmzIjuMkI
         RZ9bq72/spwqekEd292cv4z3rkzgtBS1GwBpicwPshJcCTOvtEpo2HIO9wSCA/OtaJdq
         PYUQ==
X-Gm-Message-State: ANoB5pkVzj6tLmni+m/AZwGr27gwUSTfGMLwyeIhiMLc/MwS2SqwB9EX
        qmNUo+oZId7OvK2aPQ5tBdH058XEhvGiRw==
X-Google-Smtp-Source: AA0mqf4W75fF4dccR+EwH+hFElnxEpgBhflmj7+qJ+gXpABV0ef7Vg92WN+aYsZEsc1xan0hOvX2BEWeG2a/7A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6902:150a:b0:6e1:b314:cd21 with SMTP
 id q10-20020a056902150a00b006e1b314cd21mr3ybu.539.1669069385479; Mon, 21 Nov
 2022 14:23:05 -0800 (PST)
Date:   Mon, 21 Nov 2022 14:22:56 -0800
In-Reply-To: <Y3g95OYdwzq2OP3z@nand.local>
Mime-Version: 1.0
References: <Y3g95OYdwzq2OP3z@nand.local>
Message-ID: <kl6ltu2sdk1r.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: ab/submodule-no-abspath (was Re: What's cooking in git.git (Nov 2022,
 #04; Fri, 18))
From:   Glen Choo <chooglen@google.com>
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> * ab/submodule-no-abspath (2022-11-09) 1 commit
>   (merged to 'next' on 2022-11-18 at 34d0accc7b)
>  + submodule--helper absorbgitdirs: no abspaths in "Migrating git..."
>  (this branch is used by ab/remove--super-prefix.)
>
>  Remove an absolute path in the "Migrating git directory" message.
>
>  Will merge to 'master'.
>  source: <patch-1.1-34b54fdd9bb-20221109T020347Z-avarab@gmail.com>
>

(Sorry, I should have spoken up before this got merged to 'next'.)

I have some reservations about this that I mentioned in [1], namely:

- Does this work correctly when using a worktree?
- If "absorbgitdirs" becomes consistent with other "git submodule"
  subcommands and prints relative paths to submodules, then this
  produces the wrong result.

We probably won't see any complaints about this for a while, since
submodules + worktrees are an uncommon combination, but I expect that
we'll have to revert this at some point.

[1] https://lore.kernel.org/git/kl6lmt8qv9gc.fsf@chooglen-macbookpro.roam.corp.google.com
