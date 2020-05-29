Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFC1C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 18:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D72A206A4
	for <git@archiver.kernel.org>; Fri, 29 May 2020 18:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="xR4rcRdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgE2STW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 14:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgE2STW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 14:19:22 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0151BC03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 11:19:22 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id j3so3373679ilk.11
        for <git@vger.kernel.org>; Fri, 29 May 2020 11:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TMoizE1GoLUTuR/3pJNO0SqrKyNoAQmZiWX0OAR98Kk=;
        b=xR4rcRdk2K2yZ9sWMZx4MR3yvMhO9WQ8kL7DdBkIcrck2/tDtIrQ54Ty0liGGaWtOq
         GNoz0Sm6hcG2bhlNKglTAnq4m+mTVBlxy/P8vDO+dg0Gv1iJ9j0ozJ74zqfFWUA1iRc7
         eicI+Ly/seFPlbLqJZo8EyMFH/A4HMykXTcXYMKfpryK1NoFWwVRBwE5P4Nd/39yzeuu
         dGo3mJamRF/hz7ruZEra2mfdTqa80I00kjoWglO5ANPLMIqRaBda0OyptNptH2Rzf6iF
         q82eCp4IyuiEi409UsZCStJFtT6zqjl2YeRnfwZ+bk6zaYe7RGVWA4wKFNnt1Bru77Bw
         WlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TMoizE1GoLUTuR/3pJNO0SqrKyNoAQmZiWX0OAR98Kk=;
        b=TLTkDqwTKd0cGL6S3x3R1vivjactv4jtv7X23tusBeI2ZDw/47WQutpjIz2vy6s9PM
         1L36T+fTeH1ag+XAD7emrE25jmjAxD9QoW114DRwpBwLbYNuhb0TkygsjOyoJ1uuDl+6
         ClotVnxW/QlSd8sCdij62MyfQYYcX69opPlexv/8FjYl5u1qxKBrwAXxEliYkaXiDQmn
         qTvj4SMn7UzYiWxiG2LMVqnXbAJ56EdelGEFG/dufiN4wMv0v5ce6YyqKlXsXDaBnj0G
         EKjclzmPdWx2nn+/BWIDgQc4g357aN7QWIzozVmYTBCYsIQLxSOi46CiBNb7LqSAZ8rm
         rhpw==
X-Gm-Message-State: AOAM530QMXJgjfGAcsqshndD+QjIkJSPfOG+aSzPlCEOQtIodR3cYMf8
        1RomQjrcYaOIPphkPqyRi75LBn94RJFlBFcdjdf4IQ7J
X-Google-Smtp-Source: ABdhPJzrh+5TrVxCyLKMFE3Gxlg8wh5qZ59AmA84fUdAgBKxkAQdRmjziQAlHGm4fu5/HG9I4bDOPs+ezbtPanoDNHk=
X-Received: by 2002:a92:155b:: with SMTP id v88mr8249440ilk.274.1590776361258;
 Fri, 29 May 2020 11:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <BY5PR11MB426002E5EC02396535220F70E18F0@BY5PR11MB4260.namprd11.prod.outlook.com>
In-Reply-To: <BY5PR11MB426002E5EC02396535220F70E18F0@BY5PR11MB4260.namprd11.prod.outlook.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 29 May 2020 11:19:10 -0700
Message-ID: <CAGyf7-EuTmf9WrY51-aPiQ_TTJK69HydFM4eY-J8tDSmGPFGFg@mail.gmail.com>
Subject: Re: Rebase failure with git version 2.17.1
To:     "Bensaid, Selma" <selma.bensaid@intel.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 29, 2020 at 11:11 AM Bensaid, Selma <selma.bensaid@intel.com> wrote:
>
> Hi,
> I'm running into a rebase failure with git version 2.17.1 the same rebase is successful with git version 2.7.4.
> Do you have any idea if this a regression or I'm I missing something:
> This the command I run with the 2 versions:
> git rebase --verbose to_remote/to_branch from_remote/from_branch
> Both versions print: Changes from b944516f66e253a325bd3c071f8810b7bd3e0416 to cceddad5aa3161b8b841be92090d12f3ed2349ec:
> However git version 2.17.1 fails the rebase.

Without providing any details of what the failure looks like, it's
going to be pretty difficult for anyone on the list to help you with
the problem. Perhaps you can include more complete output from 2.7.4
and 2.17.1.

> Thanks for your help,
> Selma.
>
