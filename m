Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652B4C48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 18:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F89A613B4
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 18:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhFPSHw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 14:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbhFPSHv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 14:07:51 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361A9C061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 11:05:45 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c5so3652113wrq.9
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 11:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lO9OumFoQdWKWl11ON/MIyBbs8wdRPKLhmlu1dcV6c4=;
        b=JpN7YFm9yRMdu/fLYfC9EAMHFctjunW0yjlQeQKk+NE5Ygk++kK1cW4hriOl5w8LlU
         Ur4LWQicEZ8j8dA45owsEr0beYeHrxjwXiaC5sEFfgafVNNWjshSd9xmIm7JS1atzHSt
         jDC0fBZenoTf1iW4aAuXlchc0/T9M/pEZeZw/IeAzABPVOg8Z56owzZjFp48HAGgaU3W
         Jozzrlt5ku8MaslR3rzxEj2sNEYMGoC5uR86H/i0NAC1akijSF6AXo6kD/MyGCK82NFC
         j1OWW9KPfczgOj12qEzJTPJWL6u0Ag8ccPAtDj5t02k2qVMCWIncvqZM96x55vH+u28i
         3atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lO9OumFoQdWKWl11ON/MIyBbs8wdRPKLhmlu1dcV6c4=;
        b=OZfJXMEZ5r2K4P2nZai/U0V8voiu+R6ktw/HL3NBG3zqxnwRMqqnvc36PvOlq41KRn
         mlQTmo7snU3ueIeVtIu1TfzVMKtR/fbi2QAFDarYuiL85Cl9E61iIpvbHhOdBALI5MF1
         e81dPoz0lLgLqRAwLMg8fzL/F9Y3cEkH2np0GqRpLO1HWGF2j927QUD+PhD75N3mVzG+
         VY3WPSn8zkflfWiIZ9gilnDns2bctA+78s9NwVZTrVzK5eSSK/RaGtYKejBpBZzUxgJ3
         TAf3mtBMftkH+iKtzcPKxdejskon/lVWPkdDrgBaowVt/QqYeGqFRapLKSEjbKP5MZRt
         foyA==
X-Gm-Message-State: AOAM533nRxQQkfjujgUNTIP8yUgOwiYUBNSPpZzb2FcAvhGConNput9W
        E9Mpbp6I0JJ0AFZ2Qd+1a5o5Aof+CuuqyzkxJYA=
X-Google-Smtp-Source: ABdhPJxcGYjvrI/+BNUESljHoJm9HDH0Evg5isbEe/5h8yPOjEC+LKyOYpVZik8lePeipMGw+XIGNnkAuAItUNUuqiM=
X-Received: by 2002:a05:6000:2ce:: with SMTP id o14mr353491wry.145.1623866743791;
 Wed, 16 Jun 2021 11:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAHLeu+y3DxLv7M4SM2f5yVxtKXbpAWD7Ad2m+rVKpKfKiA6PVw@mail.gmail.com>
 <YMo3j6mqiKBTTEbS@generichostname>
In-Reply-To: <YMo3j6mqiKBTTEbS@generichostname>
From:   Harrison McCullough <mccullough.harrison@gmail.com>
Date:   Wed, 16 Jun 2021 12:05:30 -0600
Message-ID: <CAHLeu+xC+ecEidoofXsOqSdT4fmf=5A1PAnHzbFPqCiPr5D+BA@mail.gmail.com>
Subject: Re: Error in bash completion
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I don't have any knowledge of the expectations regarding Git internals, but I
think it would be good to note that lines 32-33 of `git-completion.bash` say
this:

    If you have a command that is not part of git, but you would still
    like completion, you can use __git_complete:

For me that would imply that the `__git_complete` function is intended to be a
"public interface", but maybe I'm reading it wrong.

-Harrison McCullough

On Wed, Jun 16, 2021 at 11:40 AM Denton Liu <liu.denton@gmail.com> wrote:
>
> Hi Harrison,
>
> On Wed, Jun 16, 2021 at 09:44:38AM -0600, Harrison McCullough wrote:
> > What did you do before the bug happened? (Steps to reproduce your issue)
> >
> > 1. Create a Bash function, e.g. `ga() { git add "${@:-.}"; }`
> > 2. Use the `__git_complete` function to add Bash tab completion for your custom
> >    Bash function, e.g. `__git_complete ga git_add`
> > 3. Attempt to tab complete a file path, e.g. `ga my-incomplete-file-path<TAB>`
> >
> >
> > What did you expect to happen? (Expected behavior)
> >
> > Bash tab-completes the file path.
> >
> >
> > What happened instead? (Actual behavior)
> >
> > Bash tab-completes the file path but also displays an error:
> >
> > $ ga fi-bash: [: -lt: unary operator expected
> > le3.txt
>
> This happened as a result of my changes at e94fb44042
> (git-completion.bash: pass $__git_subcommand_idx from __git_main(),
> 2021-03-24) and 87e629756f (git-completion.bash: rename to
> $__git_cmd_idx, 2021-04-22).
>
> The tl;dr is that $__git_cmd_idx must be set to the index of the
> git command you're executing (e.g. for `git add`, the index of `add`).
> As a workaround for you, try setting __git_cmd_idx=0 where you define
> ga().
>
> Now, a question to the wider list: does git-completion.bash have a
> public interface? I've been working off the assumption that any time a
> user uses the internals, it's at their own risk. Is this a valid
> assumption to make?
>
> -Denton
