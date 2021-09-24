Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94519C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 812E061250
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347587AbhIXRRL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 13:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347438AbhIXRRH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 13:17:07 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF421C0614ED
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 10:15:33 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id 10so7035301uae.10
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 10:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3XDlh/P6TIRRavgQCNAQH54EEwX+0z1W3V5u2U74hC0=;
        b=AQ9GXVrMj9AN9PP/wZ+HtVgsjyLToh4JOSN//Kx4nY9hHcWzAvPrGOUsab+kLnREaw
         6i+F0GJya9bcSsht6Ro0Uzl6WD9rHwSrgtuxTJC6xywCex/vABe2gow7fEmfMuSHcdcS
         OV99/O5xclMQAs9W1K/AlOIqZW7oWbOh5K3tbo+l6uMb47nfwzQtZozpDjxH0k5nXp7u
         ItkSjnbx0J27D6dlkV0rVFftxB83I6HWiuIip9q+xO9tA4aW5lwRbdhRmjmr0ReLF1Q3
         ySLOJ5D3OagyfRUTKfFLxI3VntkC0Tq2s+ZQUFeG8G7IdPOb7Ffv/ykKuNHZfY9jFEhI
         dCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3XDlh/P6TIRRavgQCNAQH54EEwX+0z1W3V5u2U74hC0=;
        b=n3M2BQN0/G3vD9wAuLGwOASKA1ckFAisbDm7GlkQY7D9oQi+aYESpCWZeNmUg/L7KK
         +GZfCHThgJ0IR/3fBmiXKKu+q9LTNCsPyTyP+YhGkLf+EQiJlG5Y2aWitfvKQ8Uw/Ib9
         0r5pY3hrxu7PqUWM7Q8a45Zu+TyBKitdw8HplbyFUGQjCF0LpLWmh7KF80rs8cM+keeV
         E6G2QDp0geD4cBGYfrlt/yo9QAtDMuinpXjRUbyeQuJivXBqYzMn7UQHPZ8LiQaWXzas
         se3YJRNL9/Wn65ElKnTQvLovQ1pQQ0YzG67UpyIMrgqkT2RpMhy0NHimocje5XmjKcC2
         stcw==
X-Gm-Message-State: AOAM530/zEjegKwWRB9pvorhdkbFwFfmhpJhOTzEqa2WhXzOlOiKIjCk
        2DSku/GnJbd6xQMMfHHRq2/t0Hic9m7a5UGalPN/TBgx
X-Google-Smtp-Source: ABdhPJy0GzfK+LR3M0AW5ou9/RowALH7XxDUWq5osD0UMd5VYXrGl3IyAlA9KZKFaap4HEfeEIyDDq0n0/A+DO90yMg=
X-Received: by 2002:ab0:14a7:: with SMTP id d36mr10424218uae.96.1632503731564;
 Fri, 24 Sep 2021 10:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAENgTz2DoStQEqoKYKa-qMcyaez64u55mnv1HHOzDm392fuEqQ@mail.gmail.com>
 <CAENgTz0st6RpnVusP67-SSh2eENSxQn1_qiEqUDiMKzg=r54vQ@mail.gmail.com>
In-Reply-To: <CAENgTz0st6RpnVusP67-SSh2eENSxQn1_qiEqUDiMKzg=r54vQ@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 24 Sep 2021 10:15:20 -0700
Message-ID: <CAPUEspgr71t-thozi+Ez4xwxAkSJizsLuV=0TnROKZ85M6-kBg@mail.gmail.com>
Subject: Re: Feature Request: `git commit --amend-to`
To:     Aidan Gallagher <aidgal2@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 24, 2021 at 9:08 AM Aidan Gallagher <aidgal2@gmail.com> wrote:
> I have solved this issue for myself with this handy alias I found online
> ```
> git config --global alias.amend-to '!f() { SHA=`git rev-parse "$1"`;
> git commit --fixup "$SHA" && GIT_SEQUENCE_EDITOR=true git rebase
> --interactive --autosquash "$SHA^"; }; f'
> ```

since v2.31.0 you can do instead :

  git commit --fixup reword:$SHA && EDITOR=true git rebase
--interactive --autosquash "$SHA^"

granted it is not 1 command, but usually I find it useful to do
several of those and then one single
rebase at the end.

Carlo
