Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A02DC433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 07:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED14220738
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 07:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeqtVzRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgHSHSf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgHSHSb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 03:18:31 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0182FC061389
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 00:18:31 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id t4so19839112iln.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 00:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q01TrnIuItPagqZIwECtj6t0GQEUr/aKj/jthKN1Bik=;
        b=HeqtVzRLQltsrLkBwaOt93qN4s4GSz4e3l8fy762ZzkhWHsAYyPax6ZKdFQiNod24k
         xVLbp5/mXnvv4S3yArB+9KCqiQ8rN1p1dwxhSIutbyGObnihE0IjSb6PDLAakUT5W8el
         weI+HnPRwJr+eQsNc575rnhyQHh/9sPs042FEmtVoU3791EYqnjyvu27Bs3nvEeubUQ1
         r/RhNlVlE/pI9EmntuPdHKmrjrqgDOOk+nKELva+rFwc6sWy84/aQK9lcUuGv/7+vUud
         43IELrpT3sJ1OMJnCGSfQLDUyRD78aSXmx4hpeWoUtRByhzF9xw2QDWcfUOFsUUwgjgQ
         sDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q01TrnIuItPagqZIwECtj6t0GQEUr/aKj/jthKN1Bik=;
        b=fHPREquU+yw8mv40oeNfX6IRkgdbu1NUb08zMfXexxVFRjKE1V2mXEjUSiuMzr/yBd
         j1Ix8bV2kjmx5RFLAwDxNiRHgtgX08aiAbIutzxQo8FCvLicTzTRjX7mMPKUT2oMYOv/
         HUzkmNtwWnsBHXzoZiFpUzvaj5N75IuTCn7azzFzvCBvpU9dWJKGz1oJvfI3zDc4BmE6
         bA61eZky5BAqWU8pS+S28wQ8JNEcUxDMKPMpgBR/HphvrxrSC0QB26nJNViyIy1NT2rp
         y4CHHQnaWLrCv2fLLPtNuBX2xQS2q7F6XNvdyjBauQpOPXsbv5mm48GBC1TeauqOc4V9
         KX2w==
X-Gm-Message-State: AOAM532CskfRCspNquzlLKCz/ZSeasanlCbrhNVn/i9iItACfECSHlXt
        rXszX+ypTq6sr07SMlzWjNBfdQxq3dV4tK5HM+Zkc+V00Ss=
X-Google-Smtp-Source: ABdhPJxyJspQGeMweJ2R6MamUMLQfe+UGij1jjBbav6QnPiYRrkgTT8aMxeOzGAJvadJ880Ao+Ed59wDvx+O1PCED88=
X-Received: by 2002:a05:6e02:14cf:: with SMTP id o15mr21666475ilk.239.1597821508960;
 Wed, 19 Aug 2020 00:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAAUOv8jP00_W6=qFBWL1RpV0Dd1Fh1k19PQ33ycBnwVMLfRypA@mail.gmail.com>
 <CAPig+cRF=PXWTgOzxAsMQ=bSUPnsORBKWUTk38BCvMSVzS=KJw@mail.gmail.com>
In-Reply-To: <CAPig+cRF=PXWTgOzxAsMQ=bSUPnsORBKWUTk38BCvMSVzS=KJw@mail.gmail.com>
From:   Gopal Yadav <gopunop@gmail.com>
Date:   Wed, 19 Aug 2020 12:48:17 +0530
Message-ID: <CAAUOv8jraMz3+M_fddwAVcLNGPZehgosvHXyCSUx1u+555LmOA@mail.gmail.com>
Subject: Re: [NEW] Git
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 18, 2020 at 10:22 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Tue, Aug 18, 2020 at 8:23 AM Gopal Yadav <gopunop@gmail.com> wrote:

> No. test_lazy_prereq() is merely the function which defines how a lazy
> prerequisites should be determined when the answer about the
> prerequisite is actually needed. What #353 is saying is to not perform
> the actual determination if a test which requires it isn't going to be
> run.
>
> Fixing the issue might be as simple as moving the test_verify_prereq()
> call (and related "export") inside the 'if ! test_skip "$@"'
> conditional in the test_expect_success() and test_expect_failure()
> functions.

I see that test_verify_prereq() (and related export) being used inside
3 different functions
namely test_expect_failure(), test_expect_success() and test_external().
So the solution here is to move these into the if ! test_skip block.

Thanks, will submit a patch.

> > I know the issue talks about something related to chains but I am
> > thinking of starting by resolving the lazy prereq task first.
>
> I took a look at the &&-chain logic and, as far as I can tell by both
> direct inspection and by experimentation, the detection of broken
> &&-chains is _not_ performed for tests which are being skipped. So, I
> think that portion of #353 is just wrong.
