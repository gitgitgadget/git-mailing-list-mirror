Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE744C2BA2B
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 06:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F5FE21973
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 06:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="id+5mW98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgDSG1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 02:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSG1e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Apr 2020 02:27:34 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27238C061A0C
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 23:27:34 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b2so936706ljp.4
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 23:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9UqNcxz1h8lmUBfO3G1iVcv43D3tNz1aB9gotWlORpo=;
        b=id+5mW98CkbDBOpZ1Bu+4ojVviuXSt0p9raAh1hDXcPGCxRbwsOuaWbeyuAM9ztjhT
         Qu+kl5rJjITWWvuzWpMwYWateqwAlfX1bd5TWGSm059xIa3QlD3H/c+qLG3u7VPEcUQ9
         rcJNmtCjKc4NBy+x9mI3W1XbUUguz+HKegM56CzWvIYc0OFZ6vBYRb9C1HGBNzKPafZo
         fcMgxQbiCrUlfDGbMUJYIQAaDPMRXHoDF66Xc9xL3hqaNzxLWTN2xS7958qGRd1m7HtZ
         rZegcdgwChh8XE5pR74QuoCwre5BgyuuAovRrXQADxfafy3WcEk+l8vClDgbI14OMU73
         j72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9UqNcxz1h8lmUBfO3G1iVcv43D3tNz1aB9gotWlORpo=;
        b=WPwn771BwR5fl35e0Da5cgZquAo6Yu9hj2CDPT2/MWk1hgm0L8B7emUkiuJw4WJcrM
         R2OEBOFq1oG5C4MVJd10jXfdHVfLyW/FTyXSpgz38fkGXC/+bYesXfH3i2Iv33DgPkp5
         9dBbHyB9CCKjfzVZh4BhFJC3GIDl/nZz613qQja1XbhHBfCSpFEZdnnp8esZvb6QnWeo
         RD+Ag2mYN7jz4ItN9ptY3EH9Pc2OSDceN8NWe/rAXtSlTNRb7tEK3TeqCvES3qIDBF67
         qyDAuutgcwJG56Craz+D1iOH8rNJK/7tp4Fp9AOQ+ceLKua9NkzVSNzse6V59tbI+nkc
         AxmA==
X-Gm-Message-State: AGi0PuYHv8zBkw1e+whuG4xcWLpiqpWF4P7Y4kFIoYQ3t8eDdFUc2VGD
        ZHZ9+OnRYn7/tr4sV4T1IUgjwx8zniH0l1nB3p85mQ==
X-Google-Smtp-Source: APiQypI/xLVIlSOcvKnqbYclvFFKPIdq9jBMBn5qnK97QXiXQVrNr1z34ULGu341ifYSdO47XUuuHCf/K87/hs+0zr0=
X-Received: by 2002:a2e:9c9a:: with SMTP id x26mr6718957lji.44.1587277652460;
 Sat, 18 Apr 2020 23:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq1ronyz1s.fsf@gitster.c.googlers.com> <eaae7214925189f562056b1ee6972c05dcf76a32.1587103366.git.matheus.bernardino@usp.br>
 <nycvar.QRO.7.76.6.2004181509350.46@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2004181655300.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2004181655300.46@tvgsbejvaqbjf.bet>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sun, 19 Apr 2020 03:27:21 -0300
Message-ID: <CAHd-oW4dkLMp3FYyRoRWVgcTMJ0oKnKfnK--3r_Mx9EfrLoEnQ@mail.gmail.com>
Subject: Re: [PATCH] grep: follow conventions for printing paths w/ unusual chars
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andreas Heiduk <asheiduk@gmail.com>, git <git@vger.kernel.org>,
        Greg Hurrell <greg@hurrell.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Dscho

On Sat, Apr 18, 2020 at 11:57 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Sat, 18 Apr 2020, Johannes Schindelin wrote:
> >
> > On Fri, 17 Apr 2020, Matheus Tavares wrote:
...
> > >
> > > Reported-by: Greg Hurrell <greg@hurrell.net>
> > > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > > ---
> > >  Documentation/git-grep.txt |  6 +++--
> > >  builtin/grep.c             | 46 ++++++++++++++++++++++++++++----------
> > >  t/t7810-grep.sh            | 44 ++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 82 insertions(+), 14 deletions(-)
> >
> > Unfortunately, this causes eight test failures on Windows:
> > https://dev.azure.com/gitgitgadget/git/_build/results?buildId=38023&view=ms.vss-test-web.build-test-results-tab
> >
> > Could you please have a look? I suspect that this has something to do with
> > those new tests needing the `FUNNYNAMES` prereq.
>
> I need this commit to fix it:
> https://github.com/git-for-windows/git/commit/7ca815e1ab89d6ffdb1a17b3cbacdf22a508d33c
>
> I'll paste it here, for your convenience:
>
> -- snipsnap --

Thanks for reporting and correcting the testing issue. I'll send a v2
with your patch squashed in.
