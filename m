Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89129C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 00:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiLTAa7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 19:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiLTAa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 19:30:57 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD4A2B9
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:30:56 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id h26so5982807qtu.2
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=webstech-net.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fbJ/6Ex5PghcXywiISXyKHm6yM5VnozcnB2zTILehZo=;
        b=36gnkErc3ZOAb/bcSHE4Qiq3euyEDRbPuYJMGs5qykUB8W54QT3cT6gim+PB0kc+TT
         5xk6SFbHbEi9/eQUsbIN0CjdUapldjmw2BDl5bUU6PDtAtMc7Necg07P+59ZZON8qjSK
         mrUkrYyU7SyQS6rRZm03BxtiIPmxyqEl33Clfc2IwAuFayHPqfjkcEjZ2WUXk5y0XWal
         Wt3LvNEubFqRIsae4jUcUE3tMeYs3jGI6JXraBKUlN4vyrp6A1+GBF6+AVbr4Qhbir+G
         dY3kVPeYkeJkCM/2tOSUFdNAhWi7Mj3vROkTG8Jf7v3YLmklmaAuDpqKrqs1gqg4UEr9
         K+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbJ/6Ex5PghcXywiISXyKHm6yM5VnozcnB2zTILehZo=;
        b=Qp5PQ9Ws/YNkh5vnDAlapbQ6eFltVBxtOQEr+MwQZFiWQij/E2Yoy5pazaMyQLL8hA
         mckJ9LFZ51m+Y6t/en6rr5UpvZYpFpX6zqe+h2yavTU3rqwc8Qc3u2mmyvJ0TeBBHOGC
         DT7n/tSNcXZ5ISFTd7rp/tLZfjWGUE41Ki+7FpXyvJFxAKFUlS2miIpIwKTtC53HFlCA
         UJDkoVJmA+OghxuZy+oNEkVxtVBEWI1jo9zg+uWQN2md1231OFC9u7NgltJeTeXluOd1
         y7at6mW0HLtK4mfCJjARmR/De8A+sv51NGQyaaEW/mPVjAEwOYBxHbFtHVJ5jCyo2Q3f
         Zn5Q==
X-Gm-Message-State: ANoB5pnx+CBnoGMllKPfX31BD2qJMhLwheOiQJc86xSlqS6Qq8ISKRzj
        wGsvMuFwdXfI5ESLNRAZtvNOP7YrCa15/x12dualQw==
X-Google-Smtp-Source: AA0mqf5PDXCHEdIzujc9bjXrrBzn4cya9cA47fYr/LIz95aquLTCZSC48dfGfJ5dVP0PlququC99HeFa7PCTRQAn93s=
X-Received: by 2002:a05:622a:388:b0:35b:b6f9:5b38 with SMTP id
 j8-20020a05622a038800b0035bb6f95b38mr70798056qtx.242.1671496255671; Mon, 19
 Dec 2022 16:30:55 -0800 (PST)
MIME-Version: 1.0
References: <pull.1444.git.1671179520.gitgitgadget@gmail.com>
 <67f60e4e5cbb470bbf3f556f962403af5dd5938c.1671179520.git.gitgitgadget@gmail.com>
 <xmqqo7s3mzlt.fsf@gitster.g>
In-Reply-To: <xmqqo7s3mzlt.fsf@gitster.g>
From:   Chris Webster <chris@webstech.net>
Date:   Mon, 19 Dec 2022 16:30:43 -0800
Message-ID: <CAGT1KpXDHc2bqiiPqxwBiW2UV8BKMnbKD68hKa3fHdCA5GDAzw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Make `check-whitespace` failures more helpful
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 16, 2022 at 2:06 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> People usually make changes to the system to make it "more useful"
> and/or "more helpful", and almost never to make it "less helpful".
> Phrases you would use to explain why the failures become more
> helpful with this change (compared to without) would help to promote
> it in the "git shortlog --no-merges" output for the next release.
> E.g. "make X failures stand out more", "make X failures gramatically
> correct", "show X failures more concisely", etc.

I will resend with a hopefully better explanation.

> directory?  Shouldn't this hunk be a separate topic on its own,
> or at least a separate patch on its own in the series?

It will now be a separate patch.

> Is it safe to assume we run Bash here, or can GitHub start using
> other shells that lack the Bash-ism shell arrays and we should
> protect against such future?
>
> I suspect that we are already depend on <<< Bash-ism, so one more
> dependency to Bash-ism is not a problem here?  I dunno.

While GitHub could probably allow other shells to be used, changing
the default would probably break a lot of things at this point.

Thanks for the feedback,
...chris.
