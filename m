Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E972C2BA19
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 23:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A95320CC7
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 23:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsZdQAkl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgDWXqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgDWXqU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 19:46:20 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A68CC09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 16:46:20 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id q200so2254440vka.13
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 16:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=trIdZA3PhCg69XvYKavH96FbZnVrkt7JWpRFskzkc2E=;
        b=DsZdQAklYimso1Xhh0S5CmWfXLO3X87TCqNKfC2Al4Fcv+ylo8uWF1aVL6HT0RkDId
         NtXSyQwv8jNQoI2zSMlUBWHqumeNNc/A54sAT7sX30GBoyPRWgaaJeJ2s6FrvExxBVYC
         j+wg1ZN0stBYQiO9dVJzLF3L/P9XLI/e5tDFgn+XEE72n3EyybHFBTuj3/O+sC66FNg6
         tKv71IrBFMo6CQ1/B73xge6kqvvc+A4maWEFVHF/KOEUjJGl5xwAy7wJ+M4zQ9owQa5u
         cFeOiMMWVswGK88lPiAr/kPTTb3M1LDMEDs/T3JeKc9dw0FVnKfZNLgOjeuy65Uetogp
         kMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=trIdZA3PhCg69XvYKavH96FbZnVrkt7JWpRFskzkc2E=;
        b=n+5ZbZVe42PEmYyNKZNL3ZHmEVuDEDSjkY5uraw6S8YDgETqe2nf4LE6BeYbxwRNN5
         z3pzv3iRBV7aEfOnAGWFrfB/e3sDCX159k3NVNig1F41Qz7Df1TmUmUSKVzaG1t3OzHL
         Adqk+2y2jcQdEfISLNnT1lQzmlhkNXLeXQIdY7vnK+LywOqtLGbHer9doZynjAH9fNU+
         /a1/PKnX/OZYs06E/CxD6FMhqkO4CWoJrg6mnyox4J5R7Tj9kRqdRw/Z54ilypcG7DlA
         8EuLBLiiz18ufZpamoTnT94rv5WfYd8rsEhhafaCZUtGtio0WczHjituOAtW9k5QHTh9
         yyrg==
X-Gm-Message-State: AGi0PuY2sFGmlQV0M9Je7bmOkChiCeTlPNbKM/h0hkehxEm71DpNx/8g
        0L20SxgomITLFq1B3Rltl3ZlkG/IqDmMewXZbtzOV6f3
X-Google-Smtp-Source: APiQypIhHE72zn9vUjfBrJ29mXxghTumGZyywApf7AIztdV8XK/Ki7qD221lNIEMri2bI7LxLYtAJtGxXi1EdEUT0Gw=
X-Received: by 2002:a1f:16d5:: with SMTP id 204mr3173263vkw.20.1587685579655;
 Thu, 23 Apr 2020 16:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200422201541.3766173-1-jacob.e.keller@intel.com> <20200423020344.GI140314@google.com>
In-Reply-To: <20200423020344.GI140314@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 23 Apr 2020 16:46:08 -0700
Message-ID: <CA+P7+xqgW0tfLcy8R4gy2X_8apvXOaibvd3XWWdKSk8yMi+4Bg@mail.gmail.com>
Subject: Re: [PATCH] completion: complete remote branches with switch --track
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 7:03 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Let me check that I understand correctly:
>

I do not believe your understanding here is correct. This is about the
case where you try to complete

git switch --track <TAB>

I expect this to complete to the list of all remote branches, and
*not* to include local branches that already exist.

Today, on git version 2.25.2,

git switch --track <TAB> completes only to local branches.

git switch <TAB> appears to complete to basically any reference.

> If --detach is passed, the <start-point> parameter is an arbitrary
> commit.  So we want all refs (or even all commits), not just commits
> that are eligible for "git switch --guess" (the default mode) dwimery.
>

Yep, I agree here.

> If --track is passed, the <start-point> parameter should be an
> arbitrary remote-tracking branch, not just a remote-tracking branch
> without corresponding local branch that would be eligible for --guess.
> A few lines up we handle this by setting track_opt to empty.
>

Sort of. Yes, we do disable "track_opt", but, because --detach is
*not* set, we also set only_local_ref=y.

In this case, when only_local_ref=y, and when track_opt is not set, we
trigger the call to __git_heads instead of __git_complete_refs.

I *think* the problem is that we actually got something inverted in a sense:

We probably do want git switch to complete only local branches and
dwims, not arbitrary references.

> If neither --detach nor --track is passed, then...
>
> ... I'm not sure I understand the neither --detach nor --track passed
> case.  Wouldn't this be --guess mode, where "$track_opt" is set, so the
> value of "$only_local_ref" isn't used?  Or is this about the case
> where (1) --detach is not passed, (2) --track is not passed, and (3)
> --no-guess or GIT_COMPLETION_CHECKOUT_NO_GUESS is passed?
>
> Yes, it must be about that case.  In that case, only_local_ref is
> right.
>

that seems to behave properly, i.e.

git switch --no-guess <TAB> will complete only local branches.

> In any case, this is getting difficult to understand, so I wonder if
> some refactoring is in order.
>

The trouble here is that we accidentally trigger that behavior if you do

git switch --track

because we set track_opt to none, *and* we set only_local_refs to y,
resulting in just calling git_heads.

I think the trouble is that __git_complete_refs prints far more than
we want, so it needs some new options to avoid printing certain
settings.

I *think* the problem is that --dwim lists *both* local refs *and*
unique branches from remotes, and because it lists local references,
we end up displaying a bunch of unnecessary refs like tags and such.

Hmm.

Thanks,
Jake
