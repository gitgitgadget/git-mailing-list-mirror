Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F505C433F5
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 01:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353915AbiD2B2K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 21:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352507AbiD2B2J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 21:28:09 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F7ABF317
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 18:24:51 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id i2so4907686qke.12
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 18:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=81kboCUYw1h+EWpR6+jcFBxqVYz2UGd7RVfC3r00UGY=;
        b=qBAtlIoUoaIMK6BzwJVsI1hM6UeilJfpNEiI/yUvWZQ7Ic47DlMvsaN+O/07DWsL64
         CCZjhsSdKykw6eO+rPMZBIiLTeBExz3hi5nJKQFOWpIH1+nnn4H76PAKJT098vYABsHT
         LoOU/NOLQHTAh3lJ8oPMDYRSnnZ60m4su7GG/xZ36HYZZDn2yYHDnq6XxCrkYWd6zUKc
         o/tJkVSN2r77cSye42Kldqu1R583HnvLhdo3RvodRBAay+2MMHEq8DykbcbvJMVbU4mA
         etEjmlwttfDqsiZ5XMmMWGdBG82EP+I09xB5s89fHMCHC5hNgcuPEQcol/B18mWNSrlB
         UExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=81kboCUYw1h+EWpR6+jcFBxqVYz2UGd7RVfC3r00UGY=;
        b=ADCnVBgZxbJdGI5AkssFzLY7LeuyHz3XdAlw8CgvAIpPXNYpymXTpGo7H0O7vXC57m
         qIu0UkmAUzGhL1qCqAcpylWl+uycupacqchwOvay0+2gDr5EmuRq9MBSHsM3U6FqYwxn
         ClFEoad7MdpV2f4lTb4hoNEcSRtJbpR7yLjwURxTkrilQsT7whRigF2ZPn0iKYBInYKe
         pcyafXcF5oYhs6gZSIS5Gug2Q6bJpoIhH4PblYMYAaGbywX8OU3rRqduiKGxYa1eVQrb
         Kw6jfQ0ODhZ1KvViEOcxXIgFHUyhAFPjvvz19f1P3rnfPgHzMmyxgz7MLi1u0r1eQKSr
         0QLw==
X-Gm-Message-State: AOAM532b4C8WFoJAFNRiNihcXlxOQFB3V1TIjLNXGkZPwsjoMw5/Dm8c
        Z6IwHLzqyniNETq0ONQllEkObuHTNk0=
X-Google-Smtp-Source: ABdhPJxQMtjv+LGbPhOpkgDLeoNPIQiZknk6RKMPF3CAeD5NodeydSIwnDrJvclFTKObmWIIxOmZKQ==
X-Received: by 2002:a05:620a:789:b0:69e:6c70:fe3b with SMTP id 9-20020a05620a078900b0069e6c70fe3bmr20964653qka.745.1651195490625;
        Thu, 28 Apr 2022 18:24:50 -0700 (PDT)
Received: from carlos-mbp.lan ([104.1.92.200])
        by smtp.gmail.com with ESMTPSA id q17-20020a05622a031100b002f1d478c218sm1003110qtw.62.2022.04.28.18.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 18:24:50 -0700 (PDT)
Date:   Thu, 28 Apr 2022 18:24:38 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] t: add tests for safe.directory when running with
 sudo
Message-ID: <20220429012438.37o4uaxsrfdu2b6x@carlos-mbp.lan>
References: <20220428033544.68188-1-carenas@gmail.com>
 <20220428105852.94449-1-carenas@gmail.com>
 <20220428105852.94449-4-carenas@gmail.com>
 <xmqq7d79du6c.fsf@gitster.g>
 <CAPUEspiCjQRiaOcvSVgS5cZ9q=o6YeZgjp5s3BRZEByD=9Un2Q@mail.gmail.com>
 <xmqqv8usex1v.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv8usex1v.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 28, 2022 at 02:07:56PM -0700, Junio C Hamano wrote:
> Carlo Arenas <carenas@gmail.com> writes:
> 
> >> Overall, I like the simplicity and clarity of "do not start this
> >> test as 'root'" in the previous round much better.
> >
> > I disagree, and think that the fact that the second test changes
> > behavior with this series proves my point.
> 
> I do not know which second test you are talking about, but anyway.

My bad; by "second test" I was referring to the one that I introduced to
track the regression and its fix and which has its behavior changed, but
you would only notice if looking at it from all angles (and yes, that
includes as a regular user, as well as root, with and without sudo :

If we do :

  [0] login as regular user || sudo to root || login as root
  [1] % mkdir -p root/r
  [2] % git init root/r
  [3] % cd root/r && git status

we get

  step \ type | regular user | sudo to root | root
--------------------------------------------------
            1 |    work      |     work     | work
  before    2 |    work      |     work     | work
            3 |    work      |     work     | work
---------------------------------------------------
            1 |    work      |     work     | work
   after    2 |    work      |     work     | work
            3 |    work      |     fail     | work

the reason why it fails is expected (git now finds the SUDO_UID variable
and rejects the repository because it is NOT owned by that id (it was created
by root anyway, even if there is no way for git to know that it was done
at a different time and with a different session, and therefore the SUDO_UID
variable it is honoring could be considered irrelevant in the current context.

in the documentation patch (which I think would be better to squash with the
fix) I explain what to do as a workaround, and I expect this use case to be
less common than the currently broken one (so a net positive)

Carlo
