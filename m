Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DEAC433F5
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 13:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B771160FC2
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 13:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhJaNVS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Oct 2021 09:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJaNVR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Oct 2021 09:21:17 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8326FC061570
        for <git@vger.kernel.org>; Sun, 31 Oct 2021 06:18:45 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 17so21873989ljq.0
        for <git@vger.kernel.org>; Sun, 31 Oct 2021 06:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HW8XQME+UK9rxy1lgrEfcHKhwwLgsmBxfAIcNA30/vs=;
        b=i/0nyEsdtnWkHcE4CIT7eijrIFa/6gajRguUpdJdXRDlkhpXuQWD/ciGAB7N78oBSx
         DDkV5PSVOu/SbGE90K/HyXhKHwu3q/gWcNU3dbo027Vw83RTulpROXHg/ymJry1+JXiS
         Ya72/e0RcNLU9tQhlfOBVV6mYirI51EZ6ORnzqR3UHyxcWUg7EJdBdltC3t+QUb+D0p5
         uWAHotqYRr7BKfbHz6BV8t5E49ajsLwmu+EYUDonNTrGPCucm49oYX1tRhbWtUJxPT4y
         MIAGPET29tTev2XofIDWv75XLyaCwGo0mCy9EMXHdX9eKRhOleW7XhoGedAwshIcRj0E
         CemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HW8XQME+UK9rxy1lgrEfcHKhwwLgsmBxfAIcNA30/vs=;
        b=viwkJ0H3sYn0A9SLp0RYFMi1iCmDCprTk+3UbQwNLiOv03NgjLzqHyDN4SkIjixSF6
         6Zfklrkw2CDHrwCSB9QU55k6vGnc+2yh7EH6HhWFGQ7LD35fAus1XaWkQSwuS5ICOUJF
         R+gvodyvywBjW4FDj7N5TEOfI3fxzzHIjmrTY4TFscravx6KqR8hXv55/k1yXA+JtxgR
         v+BZY2arUNmTLo+KCgTIxZcWp8hII/hfGkwrMFxYAau12RR+5tZNGg4VS7dtfAAh8U7p
         r6iofksOgjNGy1DdfejJvNjpuu0ecTnHnCuPBYx/9NQUwUOrL1puA2y5Ac8BeE5dIeQG
         trzQ==
X-Gm-Message-State: AOAM532+g/RmyKNFIftKW+bo+rMt0isFC+DH4amvCLT8i/aZBiaM3aiL
        zEQvOetab7rZDEMEVTsO8rY+ZPoFhAKtLHhwnwNJgdGrk9AXiw==
X-Google-Smtp-Source: ABdhPJxMrTWaJ4P3VnyMIEGkdciHQrj0XGU4cqT/1jWtpRsn9JRpU2EeDu89LQ8Rziz8wfnLvbp070I75kpi3h8OgVI=
X-Received: by 2002:a2e:d19:: with SMTP id 25mr24869766ljn.167.1635686323763;
 Sun, 31 Oct 2021 06:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAE8XmWpK0ubcTXOaxBKGKh1qU+73Rr181wMAM7KAAX_A5PEYOw@mail.gmail.com>
 <YX5Zo9uV7qG73p6R@coredump.intra.peff.net>
In-Reply-To: <YX5Zo9uV7qG73p6R@coredump.intra.peff.net>
From:   Dongsheng Song <dongsheng.song@gmail.com>
Date:   Sun, 31 Oct 2021 21:18:27 +0800
Message-ID: <CAE8XmWqexT89v0R+iVcjOHF+WsF1caMu+toY_gyNmJ6BU_L=ZQ@mail.gmail.com>
Subject: Re: timezone related bug of git
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the clarification, it's really a disappointing answer.

Perhaps the manual needs to be clearer about this limitation.

On Sun, Oct 31, 2021 at 4:53 PM Jeff King <peff@peff.net> wrote:
>
> On Sun, Oct 31, 2021 at 11:23:24AM +0800, Dongsheng Song wrote:
>
> >  I found a timezone related bug in the git:
> >
> > 1. git log 11990eba -1 --date=format:%s
> >
> > commit 11990eba0be50d1ad0655ede4062b7130326c41f (HEAD -> trunk,
> > origin/trunk, origin/HEAD)
> > Author: rillig <rillig@NetBSD.org>
> > Date:   1635604878
> >
> >     indent: move debugging functions to a separate section
> >
> > 2. git cat-file -p 11990eba
> >
> > tree 5d62150f5e2bafd3db76641450ca5d902302a039
> > parent 892557a74bd49983fac28366b772b53c9216ca73
> > author rillig <rillig@NetBSD.org> 1635633678 +0000
> > committer rillig <rillig@NetBSD.org> 1635633678 +0000
> >
> > indent: move debugging functions to a separate section
> >
> > 3. conclusion
> >
> > The unix time stored in git repository not same as the git log output,
> > then there must be a timezone offset bug:
> >
> > 1635633678 - 1635604878 = 28800 = 8 hours (local timezone offset)
>
> The short answer is: don't do that. Use --date=unix instead.
>
> The longer one is:
>
> The problem is that the strftime() "%s" specifier is a bit broken.
> That function (which is what is interpreting your format) takes a
> broken-down "struct tm", which can only be converted back to an epoch
> time if you know which time zone it's in.
>
> But we have no way to tell the function that; the standard indicates
> that it always assumes the local system timezone, and there's no
> provision at all for formatting times in other zones (which is what we
> usually try to do, showing the date in the author's zone). There's no
> field in the "struct tm" to carry any zone information[1].
>
> Even when you're in the same timezone, there's a similar problem with
> the is_dst field. There's some discussion in [2], including the
> possibility of intercepting "%s" and handling it ourselves, like we do
> for "%z". I don't think anybody has cared enough to work on it.
>
> -Peff
>
> [1] Some implementations (like glibc) actually _do_ carry this
>     information in private fields of "struct tm". But we can't rely on
>     it, and even where it's available, it's confusing (e.g., mktime()
>     ignores it!). If you're a real masochist, you can read all of:
>
>       https://lore.kernel.org/git/22824.29946.305300.380299@a1i15.kph.uni-mainz.de/
>
> [2] This is a similar bug report from 2020:
>
>       https://lore.kernel.org/git/CAGqZTUu2U6FFXGTXihC64O0gB5Bz_Z3MbD750kMoJWMciAGH6w@mail.gmail.com/
