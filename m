Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A31C3B186
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 14:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E036120870
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 14:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjb5MWni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbgBKOUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:20:08 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:41080 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729590AbgBKOUH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 09:20:07 -0500
Received: by mail-lf1-f52.google.com with SMTP id m30so7115291lfp.8
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 06:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tMlUSXHdCQgStt9ncrRmRR0UfqvoRdzUKzMl/c19cHs=;
        b=hjb5MWniHSL1AOrghtRdh9PbwDFImJjo9Q7eO4Sca0MTw5oeiql8XE3D6cXHw2GHTQ
         F2lX4/KNt+UfBrzk9106bu2Uxc8IRw+UgiLQlosjnQ8boZ3MkLhVsf5QPkEp1Ogp3iCv
         SssiXAPDNgTvaaZmP11r2QDfc5eMbOFblQ2iO4c3+HxyHxemwXRILCEKc7yBUi/hI8sN
         12OoydOsMspq4X+i1ctqXKiB4Pym48u/sqAucyAKfGGOfJCqliC3Iwsu6vt3XNJYJaTn
         XlgCMFTbwaSnEivVWqA6cGsJuFO7hEwt7UKgDfWecXHyNM4gRyyANSZa2vt6aZGTkbQC
         gcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tMlUSXHdCQgStt9ncrRmRR0UfqvoRdzUKzMl/c19cHs=;
        b=WAzP/PjTKsfSHe1OXy5XAsKG3P1SEX/Pjk0Jf+uF6aPZlBXwq2YnS1+GzDQdgAhN5H
         sF1MRtIcUxrldfNeIntltcCsOHJBt+qyshJkM91bkxo69rWX8cB5JI4YbwVO4At3FZvP
         knkwDC4Oqr+iHZxCANo6nQEpLDzdoqh7nGEKEFCfY1pDRQm9QgDw03tvoRI7KEe3h5Gy
         IHrMLM8DASfnkYiN2/08dbXah4YUOOYU4xZOSnFgnTc10Aw1kUHMZB7qxM05go4+tWly
         xV98So8sl0nlt7/q1WWuHDHU03+NObdpAYK2nUgnXDVPYKTSC4MgzhFhWonFd5mdgv25
         xEKg==
X-Gm-Message-State: APjAAAU5FJPkRhcMdwITNArwsF5eGZiq1q99mRlo/n2npULHWqEfh4bW
        pPN6zIZTkjp5gMYGSExU//2Zvz42aIofbtGveYpriumL
X-Google-Smtp-Source: APXvYqxG39/Z8gCTthQfOs6iuk3KtB8Y/XSQhGJei86jNGWJGOBgTtT9whGWJ8TvmuMitzD5hqPZ2VEdeXYewGwKuY4=
X-Received: by 2002:a19:dc1e:: with SMTP id t30mr3745779lfg.34.1581430806264;
 Tue, 11 Feb 2020 06:20:06 -0800 (PST)
MIME-Version: 1.0
References: <CAHk66ftUsKU2+Uhy-a7V5QcRdO7ShcYUk28qz7WAm28wGFmPOg@mail.gmail.com>
In-Reply-To: <CAHk66ftUsKU2+Uhy-a7V5QcRdO7ShcYUk28qz7WAm28wGFmPOg@mail.gmail.com>
From:   Aleksey Midenkov <midenok@gmail.com>
Date:   Tue, 11 Feb 2020 17:19:53 +0300
Message-ID: <CAF8BazCpFyr_tpayWVtbk7V2LAtXaVmEKTCRQbgLYg4AvmvLvQ@mail.gmail.com>
Subject: Re: Git tedious verbosity
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhishek!

Nice info, thanks. Does that disable maintenance messages like:

Updated 1 path from the index

Or gc about garbage collection? Actually bad defaults is big problem
developers undeservedly ignore. You can control everything but you
have to switch hundreds of options, because software defaults are
oriented on dumbest user. Let's overcome this bad tendency and satisfy
smartest users, not the dumbest ones. Unix was always terse system
which provided little to no output by default. Let's honor that good
tradition and not submit to "Google-Got-It" virus.



On Tue, Feb 11, 2020 at 12:01 AM Abhishek Kumar
<abhishekkumar8222@gmail.com> wrote:
>
> Greetings Aleksey
>
> You can look into using `--short` and `--porcelain` flags.
>
> > Git offered enabling/disabling advice by using the 'advice.*' key in the configuration.
>
> Read up on this StackOverflow question on "How to turn off the help
> hints in git output?" [1]. These should do the trick, but feel free to
> elaborate if you need something more specific.
>
> Regards
> Abhishek
>
> [1]: https://stackoverflow.com/q/55463863



--
All the best,

Aleksey Midenkov
@midenok
