Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CB6C48BE8
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 02:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1671B610EA
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 02:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhFQCRp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 22:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhFQCRo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 22:17:44 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBFAC061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 19:15:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c9so4800599wrt.5
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 19:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5XOQsJmU/w8Qjy5rFqYvrNXc94ScmcAdfY96v3V8Nmw=;
        b=Z3j8rUv2/QrHo9wFH232HQj/4qxe9lLGaYjUAhnwkAOFOuLlnZMX9y4PfbatKn0F7p
         36Iu59zwYKfK7yKksIormuVNiOR3qYgEDJm9Mw/aKGex40Dt5PXDWzj3DIIiCXXB+ch1
         pAoPb+jOEdIezL9xJAoCjkjc5LO68KJgUEK62X5FTs++GJnXv7P+Sq8GfzfjbO5adC0K
         4WtJTvdx/mWcERC+E45n8jVSvP2Msk0bYXDkbaElgpchnPp73IN94WUDlTNL9ncbeByl
         72DheD5hpvlCr9x9a7DoZcNmNrCQliBKHyJuOnlq+gGMKhYSktzyU5/ESHPZOBNBITjf
         Flyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5XOQsJmU/w8Qjy5rFqYvrNXc94ScmcAdfY96v3V8Nmw=;
        b=X0o+9DOQu2TydFCUrcPgKt7ixAlgQD/glnJHO4KCu0+zQ1Qep9r4mYNMj+dkW2YvQu
         rW/9CPx/BjNck6WZ+0YirVtPKJZxJevxZfjA3X6UebNpBVhs51tsNsOGi7v9GUo7c10T
         KwxMK72Xw+FywPUi+zHz/uzRYqR0AWQzbbSN0nux0kndOqWzKdUoPu3rBliFjrNZdOw/
         pINTmpv64Ee2bUTrKIzdZXXjvko2N9YG0aXqUSQ2ddZcFO3uOgecraec7Sj9dYUlGY6L
         FvO3wQvPLJvOCgVvZaWP98ipIW1OAFzfQs0JvaTNEnyWHPKwu7eVTUCwzDYc0MhO6IOI
         53Yw==
X-Gm-Message-State: AOAM532wv7zmvPTNnw7kPL8CzgZx7Hd8DkRQOE9M6IHhdDGC3jfQxo4S
        b2J18mg/rdS2jD1vPeKnt+/jYV0E//tjHXcwQYs=
X-Google-Smtp-Source: ABdhPJy/8F7kUwAv2vcxzn0gE8ROsR8Gz6AYNmSJ0fQGWOkLeeC1skd6elPnNPOZAfUN+jqt/DadDCK+aVXDTL9DTeQ=
X-Received: by 2002:a5d:4cd1:: with SMTP id c17mr2547624wrt.295.1623896135351;
 Wed, 16 Jun 2021 19:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHLeu+y3DxLv7M4SM2f5yVxtKXbpAWD7Ad2m+rVKpKfKiA6PVw@mail.gmail.com>
 <60caae2f893ec_894e2085d@natae.notmuch>
In-Reply-To: <60caae2f893ec_894e2085d@natae.notmuch>
From:   Harrison McCullough <mccullough.harrison@gmail.com>
Date:   Wed, 16 Jun 2021 20:15:23 -0600
Message-ID: <CAHLeu+zcgrhvdqMWG1GegSP-y6CmJsJranxX-2MEGkhTaWWHMw@mail.gmail.com>
Subject: Re: Error in bash completion
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I can verify that this fix works. Thank you for the quick response!

-Harrison McCullough

On Wed, Jun 16, 2021 at 8:06 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Harrison McCullough wrote:
> > What did you do before the bug happened? (Steps to reproduce your issue)
> >
> > 1. Create a Bash function, e.g. `ga() { git add "${@:-.}"; }`
> > 2. Use the `__git_complete` function to add Bash tab completion for your custom
> >    Bash function, e.g. `__git_complete ga git_add`
> > 3. Attempt to tab complete a file path, e.g. `ga my-incomplete-file-path<TAB>`
>
> I can reproduce this issue; it's caused by 59d85a2a05
> (git-completion.bash: use $__git_cmd_idx in more places, 2021-04-22)
> which is present in v2.32.
>
> The problem is that __git_find_on_cmdline now relies on __git_cmd_idx,
> which is not defined when you do __git_complete.
>
> The solution is to add __git_cmd_idx=1 to __git_func_wrap.
>
> zsh is also broken by the same change, and the fix is to do the same in
> the _git service.
>
> I've fixed this in git-completion's master branch [1].
>
> You are welcome to trying the fix.
>
> Cheers.
>
> [1] https://github.com/felipec/git-completion/commit/95b3b49
> [2] https://github.com/git/git/commit/59d85a2a05
>
> --
> Felipe Contreras
