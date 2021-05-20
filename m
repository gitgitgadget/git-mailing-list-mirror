Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6641C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B672D61184
	for <git@archiver.kernel.org>; Thu, 20 May 2021 06:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhETGqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 02:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhETGqg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 02:46:36 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F71EC061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 23:45:14 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id ez19so8142616qvb.3
        for <git@vger.kernel.org>; Wed, 19 May 2021 23:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c7K5ipXH3Fj0LS53E2TDFrf2nlAJLhAtAHvYHh33TXE=;
        b=j0Pbp+LrzpTUvmUUNIeF9SKREht8/3Mc69ke2SQmqmKcdQ9xMVm2T0R250sitXwWBk
         So9R2pjH5ZK6IV/e4WZL7gtMC6ry7Kqrlw/Tb7t6ohvzlF6zkjR1VCCHsfxeUp092u39
         LOPK9RU5eLPmVIIXtRLfkO/zVznXe21uAu/EbR04R7kvTaRjG3Nu6ZsDUyCWeo8ydqds
         DiIAvLm2VjPAvEn7/gzFEP0ELYA+K13ZkbF95I0Dn6cd8F2UezQ5/cfpsYI9M01o3xlr
         L19LCwdlF8toigdKvDeLU7e05BkT0RGhTpTzsgaalOBVdv+ot+/R8w3IWSOSG135al9H
         y7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c7K5ipXH3Fj0LS53E2TDFrf2nlAJLhAtAHvYHh33TXE=;
        b=Vxww1lDK4i240JyayeIAWuEVO4JYsxnqTikhydI7CI/fA8NjBlB+Yt7AZrAobE4pgE
         LHpHpX9k8MG3kGIYTrLyksRR6b26nxB11QoBLvdYLHN7JQTvMr2CP6XzdPi3ueoGvw/4
         fcUcr6exzbqIU0564ewyvKQuSXW0WJCTnvnCawT2z+2xS7TygA4nLl6Tn16fAyoYD5I1
         0XfdngJWjX6tw1+651M6HtY+KFtaw34g3SJCUlCPct1iSM+ye29xw1rIztOyZb7AsHuZ
         MIncyZp6vWmoMES9HSV7YqH8X37Z08UVvSfPeEEq6D9d3V1DSmGxmPNLdNN+1YPwA/dI
         lqVA==
X-Gm-Message-State: AOAM530ViG7iL9uBOvGsrHdtnfCCcQQYQEAoZ3XfHeiinAsUVxumcgk5
        ZdfNMlYXIxiUucYbxkC5/9Kw2NeuwoGU4KWuQtA=
X-Google-Smtp-Source: ABdhPJx4+0chvOEDJKTBSsGRe/JAiPfhWJg/WStvWp1ePqopHE4uhTv8Agj/Or9D7yrEXPGs3YEgxWPSRS4BUJzmPHM=
X-Received: by 2002:a05:6214:76b:: with SMTP id f11mr3965017qvz.8.1621493112693;
 Wed, 19 May 2021 23:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAH6yD_bkY+_7XrzHdOqnnE=qvnnvxAWEQPtOyVh=BwvbcheTCA@mail.gmail.com>
 <83740d18-e0ba-e6b5-0356-144373708d4e@gmail.com>
In-Reply-To: <83740d18-e0ba-e6b5-0356-144373708d4e@gmail.com>
From:   Weishi Zeng <amwish.zeng@gmail.com>
Date:   Wed, 19 May 2021 23:45:01 -0700
Message-ID: <CAH6yD_a+OtAbGcJbvTTY1Sx3uHk9e9v4LE2zA1POO8YXiq+qZA@mail.gmail.com>
Subject: Re: [Bug Report] git log -L:<funcname>:<file>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Bagas.
Looking at it further the problem seems to be with the leading space/tab.
Here's a single line I can reproduce in the latest version.
===
    private static Optional<String> myFunction(String a) {}
===
It works if you delete the 2 leading tab. (same for 4 leading space)
Command executed:
git log -L:'myFunction':~/a.java

On Wed, May 19, 2021 at 8:18 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> Hi Weishi,
>
> On 20/05/21 07.11, Weishi Zeng wrote:
> > Summary:
> > git log -L:<funcname>:<file>
> > would fail if there's any java-style comment that appears before the
> > <funcname> string in the file.
> >
> >
> > Details:
> > Thank you for filling out a Git bug report!
> > Please answer the following questions to help us understand your issue.
> >
> > What did you do before the bug happened? (Steps to reproduce your issue)
> > git log -L:'myFunction':~/a.java
> > The file is a java file that contains comment before the function name.
> > E.g.
> > /**
> > * comments will interrupt the regex match
> > */
> > private static void myFunction() {}
> >
> > What did you expect to happen? (Expected behavior)
> > As described, it should return me the commit history that touched this function
> >
> > What happened instead? (Actual behavior)
> > It returns error:
> > fatal: -L parameter 'myFunction' starting at line 1: no match
> >
> > Anything else you want to add:
> > If the function name string to search for appears before any
> > java-style comment, it returns a valid response.
> >
>
> I can't reproduce this issue on my system (Ubuntu 20.04) using latest Git
> (2.32.0-rc0), compiled with gcc 9.3.0.
>
> Please compile latest Git on your system, repeat and report.
>
> --
> An old man doll... just what I always wanted! - Clara
