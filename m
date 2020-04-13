Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E9FC2BA19
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 10:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2957E20678
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 10:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DratqhuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgDMK7m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 06:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728295AbgDMK7l (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Apr 2020 06:59:41 -0400
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 06:59:41 EDT
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7E8C0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 03:53:22 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id e5so11465731edq.5
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 03:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v4DC6IJMyqRCydGojRAqZWFFTMR3CLnFsX/GNzrPNGw=;
        b=DratqhuWzbPG9y1tXxKayDtqLxJHsbPo9Hoji+CpaV/IqU6WWs3zwZzx/3V5YlG+1k
         39MXrKQ3uXG0YPk2P/qVuEoCwB3fSfL+Mx/pLH4UV/oApinq932h3CteyalvrNaojEC/
         000W+EmyykALbIEesCr+K0xj7Sq+p0fu6GByWfVlnHN6/AXT1E9+u5ycFAijlmM9AdXX
         gSr7o/O3XgQEZSbTS7ZlFZaLOdUR4gqP/qU7onTPGZ/YVLUHQmtHqjWeXI1tHQxI+Ue1
         Vqqpnk2+9PuLrxhXW0hEtsGRiW2tyPPYtUdQytOJQqFdTiRB25WB5mThoTRMF8yMEYYv
         Z5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v4DC6IJMyqRCydGojRAqZWFFTMR3CLnFsX/GNzrPNGw=;
        b=MBsFTwHq/2YmB0KAcsYR5RNCBQuf0vsSrSeVrgqyga0QAJNNFuoHscEYVDISN52tAy
         hnR8eoEPm87y3RdeI591e+DBbhwPYvrqxgA5Oe+V2IQmfDe8/yJ1hTHjtMgAW457KRcW
         OaJhFaM5YzxGhOJ6C14IuW9mxPYCo3cGJdgRvOxMZjmi3XUtcWIUMp86v72t9zsrz/IX
         B260RR046JdLEk+GSCgQxxSJ4jlZ0CJX8Yd1AXVyIa9O/lStso6U0QD58MxkmP7mJh41
         3h7CeAdcl5ri8WVeamxDGT8ZVsvew+PZhPMsDh6rHJBF+HBKQlqeV1iuItW4NtGQ4cKW
         gJeg==
X-Gm-Message-State: AGi0PuZ2c40VhzNOtfk8DWeQclCIDegXNGpT6VEY7jPf5xIK2k+/mQ7v
        wdheMGPRhudEGkL5TIvDmLF9lSMd3WkGHMVz2evJGw==
X-Google-Smtp-Source: APiQypJgYOUkvCdRYtU3WNLS7cB5uLlw60FbdCCK/dlz2hoQd6XBHjuhAj3Uk61MiV24FTDhQgaqlJ/ErOyuBe9CNaM=
X-Received: by 2002:aa7:d614:: with SMTP id c20mr15912427edr.232.1586775200513;
 Mon, 13 Apr 2020 03:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAJs9aZ-iXUtZoumnMzTFPrc=mtz2+s4EDUKhxw_KQp42h3mxBw@mail.gmail.com>
 <facf8152-00ce-4878-a13b-3fe72c13fa25@kdbg.org> <0360e896-73b9-3585-54a2-5427bfafaae1@iee.email>
In-Reply-To: <0360e896-73b9-3585-54a2-5427bfafaae1@iee.email>
From:   rupert THURNER <rupert.thurner@gmail.com>
Date:   Mon, 13 Apr 2020 12:53:09 +0200
Message-ID: <CAJs9aZ_Rs8k1Uv-jn-YHCmRaM6kWipcucTCTeE44-BT3ssnNhQ@mail.gmail.com>
Subject: Re: configure remote/local as mine/theirs
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 12, 2020 at 12:12 PM Philip Oakley <philipoakley@iee.email> wrote:
> On 11/04/2020 22:40, Johannes Sixt wrote:
> > Am 11.04.20 um 14:51 schrieb rupert THURNER:
> >> my brain about it sometimes. can i somehow configure git so it
> >> would use "mine" and "theirs" only?
> > The words "mine" (actually "ours") and "theirs" have a very precise
> > meaning in Git. If you were to use these meanings during a rebase, you
> > would not like the result: it would call "ours" what you intend to call
> > "theirs", and vice versa.
> >
> > Consider this history:
> >
> >
> > --a--b--c--d   <-- upstream ("theirs" from your point of view)
> >    \
> >     x--y--z    <-- branch to rebase ("mine/ours" from your POV)
> >
> > During a rebase, Git is "positioned" on the history following commit d,
> > i.e. on "their" branch. Then it cherry-picks commits x, y, and z. In
> > that situation, the change that you consider "theirs" is actually "ours"
> > from Git's point of view, and your own change (those introduced by x, y,
> > and z) are "theirs" from Git's point of view.
thank you for the nice explanation! there would be no easy
way to swap the names in the rebase case? or introduce
a new one, "mine"?

> given the way Git is using it's terminology, would you have any
> suggestions as to how the man page(s) could now be _clarified_ so as to
> avoid these potential misunderstandings? Even perhaps
>     "theirs", "ours", "local" and "remote" are distinct terms in Git
> with different meanings as detailed in gitreference/glossary.   (or some
> such - though 3/4 are not in the glossary!)
philip, maybe phrase it as johannes did, add it to the man pages
of rebase, and mergetool? the change you consider "theirs" is
actually "ours", swapped for technical reasons when rebasing.

rupert
