Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E18C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 23:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 947E02076A
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 23:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHi9OlHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgI1X0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgI1X0u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 19:26:50 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B46C0613D3
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 16:26:50 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id r78so1983387vke.11
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 16:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zWtOGts3KSIPa2+6eY1BtdgOfAH0+oZqU3c4rxEaqxs=;
        b=VHi9OlHhVdKBrEdeV/pXBN4tYSAKauMiUpOPNkFfC+uu7yI6csUNUqiQ1aJ+Cdmb11
         F6p6DH4l+TJLib5JdLp3tqTHip1iCdwP4Gu/MEw2/IVJD/kBxyjB014Scr5tr6vkJBLX
         msd6xFjx5d7AFuzSGBZSIEmZ+1HvMmzuxY9xYM8HDNXzNKkQ1RvglqIdrZe7gQgFmLtx
         Edkcmvqa2DiZZ8cbQsMnIwFdR4SkWWFOJD0G1t80AXT6LM0nQ0nJKsu5eLjwqnZiVClw
         6elyUYUdD0wCXJZCey9rGsTcijbDnqb2fuZlgXeJ91aqhfcu5dnW0S+9evORcKX+NoUd
         3o/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zWtOGts3KSIPa2+6eY1BtdgOfAH0+oZqU3c4rxEaqxs=;
        b=hIMmGGbjldpClB3g2Wa3Lx+SEq9YjhFgVdXaT2lCXrHKA2MBUXfe3AYD7Fp6Qw+kqb
         5gSgidsdOKmseeogFS3JM073io/63PCBqHpghA/pol/Hz7/OAJ2gCcjXYOjrOs9NLAJb
         b4GyIUW91LjMNXf2n+mc0oB9pygExQq+tobx1T/Bcq6UZNVOPbsQHujU317kzFDz+UhD
         lWjUw4zezO6ZFPb1dCA/2HM+B8iZpeE/KBjJAmlHBA1sqFehgMAx0wZIuKkrh1nrXkay
         31sJ1N7xMXge+iC5bqvdd4xumiF4vpH5QkOexrVAwnUV9DL11tObDB7I3XAfHvcF0mXv
         FRfw==
X-Gm-Message-State: AOAM5312HI6+rNg9hQUks7i172yKLacjtsG4XWaL7/E5G8FZ+TX3q4s+
        9plIdPrEm3gFIWIuPyAuE+i69oo+aWwtKCb/Pq4=
X-Google-Smtp-Source: ABdhPJzf3TcvDRIluck8CZfSDoHqX3VI/ktaJlg5RUhiBR/BK23YGOsVZUFjm3Rc9Zq0gm4JBEcBTrgL+bzwdkL5K4Q=
X-Received: by 2002:a1f:964c:: with SMTP id y73mr1344572vkd.8.1601335609247;
 Mon, 28 Sep 2020 16:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com>
 <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com> <f69076036fe4dfe8b57fc1d4329c7be3f7346850.1601293224.git.gitgitgadget@gmail.com>
In-Reply-To: <f69076036fe4dfe8b57fc1d4329c7be3f7346850.1601293224.git.gitgitgadget@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 28 Sep 2020 16:26:38 -0700
Message-ID: <CAPUEspgW9CFO3WtbiuTUsmXp05fPqr2Cs81piDJFJ0g3KcTy3A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] credentials: make line reading Windows compatible
To:     Nikita Leonov via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nikita Leonov <nykyta.leonov@gmail.com>, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 28, 2020 at 4:41 AM Nikita Leonov via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
> index 716bf1af9f..f2c672e4b6 100755
> --- a/t/t0302-credential-store.sh
> +++ b/t/t0302-credential-store.sh
> @@ -142,7 +142,7 @@ invalid_credential_test "scheme" ://user:pass@example.com
>  invalid_credential_test "valid host/path" https://user:pass@
>  invalid_credential_test "username/password" https://pass@example.com
>
> -test_expect_success 'get: credentials with DOS line endings are invalid' '
> +test_expect_success 'get: credentials with DOS line endings are valid' '
>         printf "https://user:pass@example.com\r\n" >"$HOME/.git-credentials" &&
>         check fill store <<-\EOF
>         protocol=https
> @@ -150,11 +150,9 @@ test_expect_success 'get: credentials with DOS line endings are invalid' '
>         --
>         protocol=https
>         host=example.com
> -       username=askpass-username
> -       password=askpass-password
> +       username=user
> +       password=pass
>         --
> -       askpass: Username for '\''https://example.com'\'':
> -       askpass: Password for '\''https://askpass-username@example.com'\'':
>         --
>         EOF
>  '
> @@ -172,7 +170,7 @@ test_expect_success 'get: credentials with path and DOS line endings are valid'
>         EOF
>  '
>
> -test_expect_success 'get: credentials with DOS line endings are invalid if path is relevant' '
> +test_expect_success 'get: credentials with DOS line endings are valid if path is relevant' '

note that this test was put in place to protect users from regressions
like the one we got after the release of 2.26.1 where users that had
'\r' as part of their credentials were getting an error[1]

while I am sympathetic to the change (indeed I proposed something
similar, but was reminded by Peff that while it looks like a text file
it was designed to be considered opaque and therefore should use UNIX
LF as record terminator by specification), I am concerned this could
result in a similar regression since we know they are still users out
there that had modified this file manually (something that was not
recommended) and are currently relying on the fact that these lines
are invalid and therefore silently ignored.

Carlo

[1] https://lore.kernel.org/git/ad80aa0d-3a35-6d7e-7958-b3520e16c855@ed4u.de/
