Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D2DC433E0
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 15:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD4F20679
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 15:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoNA+fjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgFCPgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgFCPgL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jun 2020 11:36:11 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57487C08C5C0
        for <git@vger.kernel.org>; Wed,  3 Jun 2020 08:36:11 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id d67so2182754oig.6
        for <git@vger.kernel.org>; Wed, 03 Jun 2020 08:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xkxzUKzHsYymmlEhLjZCDPulNT0xb7nxLj6kt/v5uPM=;
        b=DoNA+fjdml9lAkePOv+7BFEPAHVLK5Fs91KofmpFQVHErnfCH0tHVY51zpzLItb31R
         9QcUliYbCJ1nSdgd8RDS20Ixk5Iu5sWm3MlLxJcnrMAj14NEL3g4peigHSMzTY7bdSX5
         hfIAhjBaPy28vb90i2W6S9EIojutBX5AqPVOgYaR6cQJm3h5pq4Z0F7WxojqPww7Dbrh
         8Aw8nh0vUHX9XFyGVGzsyrdfRSjOxY0oh19CNzrv9XZaVjCwk3qh3OJ2i6tJzZZV8rTx
         LD+RgYIwMdd2/HN7vmyD/g9Ql9UawGnsS/vc14ef2F2XC6DKKtDACDqFOq3qVcpXCfT+
         qSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xkxzUKzHsYymmlEhLjZCDPulNT0xb7nxLj6kt/v5uPM=;
        b=XRPfcK7Wsqz2s5zj39/gE3Wmm3ltuHoBiswdG/h0oosS1+1mJpMsTJg2zRP3V1Bv6s
         HrkO8Ro14WzjxShhPVT05DIZTbEtJgkP8buRF1ilOcRHrvjiNNlfzDiGv3UKsH9ssVax
         pHlHZtgtev80hkYEqVKLuXL1JZDxKM1mixkq9BDt0Hxntd+Iy3f5JiNtxB8hWe+kpwUg
         KGJvUD9CpFa8sjcpBMAFgo9PL04065n+IS9uFwKwn/tY/BSh8qqE14qGvmt8K9MKGSW7
         FIhn1eVI/msF27GGdwC/qEC1bWldRMIsbFIL6WpzZmmYqQjODaNFg6EYOomSN23a1lSo
         1Czg==
X-Gm-Message-State: AOAM5305VXk/pUWBt0gXMF7BzQWrP5kKqEesS+JOiPVYGV5ZVo299iZq
        UkZXo5xkSJJ93qDSJtpZ9UT0HFXNJj4=
X-Google-Smtp-Source: ABdhPJy8ZgO+3msgatXyhpGzzTnfPr3y1hqB+n5Jyfta267Lnq8sGRqBoH03RcxcKKoVj6mxAhEkfA==
X-Received: by 2002:aca:3145:: with SMTP id x66mr185430oix.159.1591198570380;
        Wed, 03 Jun 2020 08:36:10 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id c3sm551262otb.47.2020.06.03.08.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 08:36:09 -0700 (PDT)
Subject: Re: Possible regression for sparse-checkout in git 2.27.0
To:     Elijah Newren <newren@gmail.com>, Shaun Case <warmsocks@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <CAD3+_6CUX0RPr-dgfUnfGDNNfqu80SYCskioYnu=MS6aJv2dEQ@mail.gmail.com>
 <CABPp-BGvc3GZfFuiXaqDk6391ZexQ7D3x9gr5JK6-L+rDQQ4sg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c1f9d76a-bf39-8508-1f4f-b34be77450a0@gmail.com>
Date:   Wed, 3 Jun 2020 11:36:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGvc3GZfFuiXaqDk6391ZexQ7D3x9gr5JK6-L+rDQQ4sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/3/2020 12:37 AM, Elijah Newren wrote:
> I think it'd be more natural to run

>   git clone --filter=blob:none --sparse
> https://github.com/r-spacex/launch-timeline.git

> in place of the combination of

>   git clone --filter=blob:none --no-checkout
> https://github.com/r-spacex/launch-timeline.git
>   git sparse-checkout init --cone

> since the --sparse flag was added just for this kind of case -- to do
> a clone but start with only a few things checked out.  It's easier, is
> the route we're moving towards, and as a bonus also happens to work.

Just one warning: the --sparse option in "git clone" does not currently
enable core.sparseCheckoutCone, so running "git sparse-checkout init --cone"
afterwards is a good idea, or else your "git sparse-checkout (set|add)"
commands will not behave the way you expect.

(I think that I will propose a change in behavior to make it do so during
this release cycle.)

> A bit of a side note, or a few of them, but this command of yours is broken:
>   git sparse-checkout set README.md
> because --cone mode means you are specifying *directories* that should
> be checked out.  Currently, this gives no error, it instead silently
> drops you back to non-cone mode, which seems bad to me.
> sparse-checkout should provide some kind of error -- or at very least
> a warning -- when you make that mistake.
 
> Now let's talk about the commit in question that changed behavior
> here.  The point of sparse-checkout is never to switch branches or
> checkout new commits; all it does is update which paths are in the
> current working directory.  A related point to this is it should never
> add or remove entries from the index and shouldn't change any hashes
> of files in the index.  It used to violate this, at first via an
> implementation that was literally invoking `git read-tree -mu HEAD` in
> a subprocess, and then later using internal code equivalent to
> invoking that command in a subprocess.  But by violating the
> leave-index-entries-alone mandate, it left folks who were in the
> middle of a rebase and wanted to update their sparse-checkout to
> include some more directories in their working tree in a precarious
> spot -- if they didn't update, then they didn't have the files
> necessary to build, and if they did forcibly update via `git read-tree
> -mu HEAD` then their staged changes would all get wiped out.  I spent
> some quality time helping users recover their files and teaching them
> about the git storage model.
> 
> So that brings us back to your original question.  When you said
> --no-checkout, it means that there is no commit checked out and the
> index is empty.  update_sparsity() is correctly toggling the
> SKIP_WORKTREE bits for the existing index entries that don't match the
> sparsity patterns, and it is correctly calling check_updates().
> check_updates() is correctly checking for files currently in the index
> which have toggled to being needed in the current worktree so that it
> can issue downloads related to promisor packs.  The problem is just
> that there aren't any index entries to begin with, so there are no
> SKIP_WORKTREE bits to update, and thus no files that need to be
> downloaded.
> 
> It seems a bit risky to make sparse-checkout start doing
> checkout/switch behavior and adding entries to the index.  There's a
> couple ways forward.  One, we could decide this is a special edge or
> corner case where we allow it: if the index is completely empty, then
> there's no data to lose and thus we could make `git sparse-checkout
> init [--cone]` in that one case use the old 'read-tree -mu HEAD'
> logic.  Alternatively, we could just require users to run 'git reset
> --hard' at the end of your script.
> 
> Stolee: Thoughts?

I agree that using "--sparse" instead of "--no-checkout" is the
best way forward for now, but I'll classify that as a workaround
and not necessarily the end of the conversation.

In general, the commit in question is doing something extremely
valuable for common situations, like rebase that you mention.
I also think that this change in behavior is warranted by the
clear warning placed at the top of the docs [1]:

	THIS COMMAND IS EXPERIMENTAL. ITS BEHAVIOR, AND THE
	BEHAVIOR OF OTHER COMMANDS IN THE PRESENCE OF SPARSE-
	CHECKOUTS, WILL LIKELY CHANGE IN THE FUTURE.

[1] https://git-scm.com/docs/git-sparse-checkout#_description

Of course, that's just us covering our butts as we push the
feature forward. It doesn't stop users (especially those that
are bravely using the feature) from feeling pain that might
be avoidable.

To wrap up, it's unfortunate that the behavior changed. If it
is easy to detect and handle this special case, then it _may_
be worth doing to avoid disrupting users. Elijah: could you
spend at most an hour trying to see how difficult this would be?

Thanks,
-Stolee
