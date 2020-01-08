Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74154C00523
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 09:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E80206F0
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 09:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgAHJ2F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:28:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53261 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbgAHJ2F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 04:28:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id m24so1675484wmc.3
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 01:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GKF+ru3ovzPyWuCZVz52T4+HmCjjZVKoPIsYwrnNNrQ=;
        b=p78toU6/XI//2YW13ce47T09KXm/3A4kUYZI2JpEovUYDLqwbWpNijqNdnHdnzH8OE
         6SChEropjOtmdSTbZAWS7RKvtnvy/e35JzRrZP7Sl5cGox8AHVrnr/AgmomOjL3J5QZG
         02c5UHudfVTGcJVw9zUlU/hsQS6DLPSA+eMo6ojl0ElefXkAnnlIPBaxeWc0TucFdQFf
         FYjsojxgwYf/xXMz7CrKV/bn/foGG5ocMq2Uh5gDGUQPY77RluvONLu4HG7EU7Xe08F0
         Bw3qanJt2mUJYlk+SRGMdnnqws/R2qN/oqx0S9ooQoYO/1cCbQPjriyltSRjys3/BPgV
         zyjA==
X-Gm-Message-State: APjAAAV9/3ewuD19p+agnRRi40nTuw298siiwnt+F2UIeb8x0vWZgSI6
        pcfoKRYKae+SfDcT8ImFHA75FhZPz/odefBO7Q0=
X-Google-Smtp-Source: APXvYqyQcb95jU4j0WOhUrpJ0/26rocAmahRy2XravTBXyXgVh6RK+TFGsM/Zm76YnqCLv3JyjihqLqYzYF3kg5QoOI=
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr2577705wma.84.1578475683135;
 Wed, 08 Jan 2020 01:28:03 -0800 (PST)
MIME-Version: 1.0
References: <pull.507.git.1577933387.gitgitgadget@gmail.com>
 <pull.507.v2.git.1578370226.gitgitgadget@gmail.com> <19a7cc1889d6094e4f8a94c19c43ad554662e8d8.1578370226.git.gitgitgadget@gmail.com>
 <CAPig+cQ0qY8KDZrQ8khuz34DqPimorN7JHHn0Ms=KpvJYtxJoA@mail.gmail.com> <CACg5j26jyWnAtM+mZ-FuN7OQWHpKk5nADG+7J-=metJMdO6+2Q@mail.gmail.com>
In-Reply-To: <CACg5j26jyWnAtM+mZ-FuN7OQWHpKk5nADG+7J-=metJMdO6+2Q@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 8 Jan 2020 04:27:52 -0500
Message-ID: <CAPig+cTDayF0hHn7wSPGNS8h2qPUYhhg9Z8fY_rLQnWmAg-NKQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] branch: advise the user to checkout a different
 branch before deleting
To:     Heba Waly <heba.waly@gmail.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 7, 2020 at 8:15 PM Heba Waly <heba.waly@gmail.com> wrote:
> On Wed, Jan 8, 2020 at 12:16 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > By the way, did you actually run across a real-world case in which
> > someone was confused about how to resolve this situation? I ask
> > because this almost seems like too much hand-holding, and it would be
> > nice to avoid polluting Git with unnecessary advice.
>
> No I didn't. I was trying to find scenarios where git can give more
> user-friendly messages to its users.
> I see your point though, so I don't mind not proceeding with this
> patch if the community doesn't think it's adding any value.

My own feeling is that this level of hand-holding is unnecessary, at
least until we a discover a good number of real-world cases in which
people are baffled by how to deal with this situation. Adding the
advice seems simple on the surface, but every new piece of advice
means having to add yet another configuration variable, writing more
code, more tests, and more documentation, and it needs to be
maintained for the life of the project. So what seems simple at first
glance, can end up being costly in terms of developer resources. For a
bit of advice which doesn't seem to be needed by anyone (yet), all
that effort seem unwarranted. Thus, my preference is to see the patch
dropped.
