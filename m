Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C38C433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 17:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243468AbhLFRkn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 12:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhLFRkm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 12:40:42 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9C4C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 09:37:13 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w1so46181818edc.6
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 09:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LTwkkDMmo2NaSF8K8xFJrOGFKHsJbmUmx9oUvEpbJsE=;
        b=rWppTq5onrZt99tzw1wDc667RXOUGjupdPrE/3l5PQJuMJ+gLcApBQ7yqirKaXF+9h
         SLkVJK3RE4ogqMaa0qvdyjLbMRlSI/ECdajm1ALDi6Sfn84Ml7tAc/71m9xCClvuf1tI
         FQyMSd4Mm4J7nb2543P8V66p99pFPOhsTSIs/t5ZPqDvF6dg/YvHWsbfYS/w6aCWbSYU
         D2d56S9C0SyKZpYTOlpSnaa5C+E5ajd/3tYpzvbFkZ4fJEgJBkQ31DLnvPrqIeulKHl/
         Tj690lN6LKSlFLwPij7g/x+GarzTOvZFcq1g+sZJhvXjapPHmomqDxg3XuVJYjBv8ab7
         FyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LTwkkDMmo2NaSF8K8xFJrOGFKHsJbmUmx9oUvEpbJsE=;
        b=3cNhw4s4oxH/u0K9qKF4PUPlExQWzltRlbA0bG6rOBYZOLEf7fgz6Y/1PFywvwymTe
         H5SOmnn0r7ERspTtzlHRnlk9APxntNWCWw35SA+EnulHa74PZniby+TCfWp/aejn8ROZ
         mu/GHV/aIQmGNJP5+Wu6zv5EBJalY3YHvO637fPacnu1nbhf6QVsF9Hgfhn6Apsl4q0I
         TCcdGNdjXqSPYlrjMrxnvHMzkG108u7CT0No+DTpaE/716HzeQ8n+9BKGR04eyautkmM
         TBACSCZYnlOH/n/NJTvEzwNPf8HxahaB9r3LsCteogn5ENYhElzb0h8AIPOXLG+ICqyt
         c29A==
X-Gm-Message-State: AOAM532vJh2reQ+vLfjlwU+xK1s43GLHrFzrTBeD7DowX1BntpCuhi5W
        OX7xsw1ObKnVKp2rMv0RzDnKBpsTWJ508bX1egTzR31A/8Q=
X-Google-Smtp-Source: ABdhPJxaNKE00ram+c1wZ3XEE93jZS4xUOvEsyR9SJSk3Hz5xMjcIZvTfOpOrOjlf5GKLIKRqgqv0TR5pq8cIJ/fRZU=
X-Received: by 2002:a17:907:3e22:: with SMTP id hp34mr47257041ejc.491.1638812231725;
 Mon, 06 Dec 2021 09:37:11 -0800 (PST)
MIME-Version: 1.0
References: <CAO6o7kKXZg37ydC145yf5uZt+tsKdYADnVfinO0sHAN=cHo-FA@mail.gmail.com>
 <CAPig+cQr27ra4DTjC1gyZO7YdV81Jq5J3s-LcAf+wePP=+n59g@mail.gmail.com>
In-Reply-To: <CAPig+cQr27ra4DTjC1gyZO7YdV81Jq5J3s-LcAf+wePP=+n59g@mail.gmail.com>
From:   Will Beason <willbeason@google.com>
Date:   Mon, 6 Dec 2021 11:36:58 -0600
Message-ID: <CAO6o7k+hphmVKtZtrJEvkZq7TQv8HRCMBSFQ-5JARK2fRoq4sQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Checkout_previous_branch_command_not_working_on_?=
        =?UTF-8?Q?=E2=80=8B2=2E34=2E1=2E400?=
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm going to bet you're absolutely correct. Yeah, the error message
could be clearer.

After using "git checkout [branch]" for a while, I reflexively typed
"git checkout -" and it worked again.

- Will Beason

On Mon, Dec 6, 2021 at 11:17 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, Dec 6, 2021 at 12:04 PM Will Beason <willbeason@google.com> wrote:
> > I typed "git checkout -"
> > error: pathspec '-' did not match any file(s) known to git
> >
> > I expected the previously-working behavior of switching to previous branch to
> > work, but it didn't.
>
> If I recall correctly, for `-` to work it consults the reflog, but if
> the reflog has been cleared or expired, it won't be able to determine
> the previous branch. For instance, try this:
>
>     % git init foo
>     % cd foo
>     % echo data >data
>     % git add data
>     % git commit -m data
>     % git checkout -b other
>     % git checkout -
>     % git reflog expire --expire=now --all
>     % git checkout -
>     error: pathspec '-' did not match any file(s) known to git
>
> So, this is probably expected behavior, though the error message isn't
> very helpful and perhaps could be improved.
