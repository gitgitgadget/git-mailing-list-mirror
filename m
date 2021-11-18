Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA097C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 22:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C617E6142A
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 22:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhKRWNp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 17:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhKRWNp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 17:13:45 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C826CC061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 14:10:44 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id 14so10108844ioe.2
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 14:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u6UGg5/CQy71zJ4ij72P5Pj53TWeipPLm6VVTYICg3g=;
        b=lkn4kpURHC/aY14dGMyo9KsazzNUvkRTFT1OynPKxh1xbQ45uEPl/XSnjG+l0m0L7Q
         5TWib4pevMsHTZaet6Xvy1f4wrIigJ0OiE4Q3SWyvKw009y6vIKcZOYRs5n3h42PZP72
         K/VjYh8EOR0ZXx6b6JR0Cf8x/BHi6RYWCpH+n9DIgIgnlinlg41ncc0YymGII91l6Uu5
         Zqkb7KmQ61fYbOj1ygMxzoOryaPvXrqqnJrVlMhv8QpYMP5FsgbQJ/a8nAC+ScHdULkZ
         rM3DzC8M+FIlU4Z7tBBgtOSA/K3PZEtOrBQQOgORrvUllXUAwgR9ofEa55P/0hRQMYvL
         KDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u6UGg5/CQy71zJ4ij72P5Pj53TWeipPLm6VVTYICg3g=;
        b=dQnsEdDXk5lUMxp1z69rX/7NNIHkGLbyhT/S3AhSpjVIYPj+uZS3lI5ORvY+2S5m1I
         +9UdrciE0EBOTJKtvcC3t8weZ8ibQuc1Hzsbir8M5qU1ck4Jv8Sns53SYWZgE76sj+Yw
         jCSXPjJVhYQ2+/aeyOsPp1H69d6la9HQnmUWCq4Bo2+gLvO0O4Pch6jkXmGcygeJF0XX
         Vb0jyJ1udhmFpXSlLsFzWdgvLP4PqHFrdOJJKWyyxnrjW9vol5mT/4UK5y/p86iZ//3G
         xMV9C438ZhvivwE/8flqH3lDKH44wwAeS1tZqr2ksctS8WLbwI5Qo10gCUzzHkoEiJp1
         R6AA==
X-Gm-Message-State: AOAM5325GznzwLuaaBXS08SAsCY+xZKfC5WHptm20xD1PMmtkC0lhYtK
        KsoxVUi+rrgncmL/05vuWo1Dpw==
X-Google-Smtp-Source: ABdhPJzdIkCGGnzEbKifeCuzoyd+WeWIcwAzTPyl5lAX79GcmyOILnSMXqbjiseT5BnV5K9OH+z7ZQ==
X-Received: by 2002:a05:6602:5d9:: with SMTP id w25mr1846335iox.10.1637273443937;
        Thu, 18 Nov 2021 14:10:43 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f5sm601750ioo.34.2021.11.18.14.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 14:10:43 -0800 (PST)
Date:   Thu, 18 Nov 2021 17:10:43 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 03/27] bisect: Fixup test bisect-porcelain/20
Message-ID: <YZbPY9is4+4q2rxF@nand.local>
References: <20211118164940.8818-1-jack@suse.cz>
 <20211118164940.8818-4-jack@suse.cz>
 <CAPx1Gvfe46JFeNT8nW6NcFFy7bnR+eWYKS0-5soPVTmPxxJccA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPx1Gvfe46JFeNT8nW6NcFFy7bnR+eWYKS0-5soPVTmPxxJccA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 18, 2021 at 12:13:21PM -0800, Chris Torek wrote:
> On Thu, Nov 18, 2021 at 10:39 AM Jan Kara <jack@suse.cz> wrote:
> > diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> > index f8cfdd3c36d2..13f7deea4d81 100755
> > --- a/t/t6030-bisect-porcelain.sh
> > +++ b/t/t6030-bisect-porcelain.sh
> > @@ -240,8 +240,13 @@ test_expect_success 'bisect skip: cannot tell between 3 commits' '
> >  test_expect_success 'bisect skip: cannot tell between 2 commits' '
> >         test_when_finished git bisect reset &&
> >         git bisect start $HASH4 $HASH1 &&
> > -       git bisect skip &&
> > -       test_expect_code 2 git bisect good >my_bisect_log.txt &&
> > +       if [ $(git rev-parse HEAD) == $HASH2 ]; then
> > +               results=('good' 'skip')
> > +       else
> > +               results=('skip' 'good')
> > +       fi &&
> > +       git bisect ${results[0]} &&
> > +       test_expect_code 2 git bisect ${results[1]} >my_bisect_log.txt &&
>
> These are also not available in old POSIX shell - consider using two
> separate variables to hold the two strings.

Or just inlining the commands that you actually want to run inside of
the if statement above:

    if test "$HASH2" = "$(git rev-parse HEAD)
    then
      git bisect good &&
      test_expect_code 2 git bisect skip >my_bisect_log.txt
    else
      git bisect skip &&
      test_expect_code 2 git bisect good >my_bisect_log.txt
    fi && #...

Here (and in the previous patch) it might be helpful to add a short note
in these conditionals, maybe along the lines of:

    # HASH2 and HASH3 are equivalent choices, but we only want to mark
    # HASH2 as "good". Handle either ordering:

Same note on the brevity of the subject line applies here, too.

Thanks,
Taylor
