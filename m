Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50724C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 22:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbiGYWOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 18:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236862AbiGYWOk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 18:14:40 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CB024BDD
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 15:14:39 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id l14so9316277qtv.4
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 15:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TLScx4v7oOXwr6CmvRJupxwh8FrJz48xFp6JDWKE33s=;
        b=j0hBvIIIUwrVj2/U2GSZVA9Lae3rqRJ7O4w10rVwD1DxH6z0wCIgOuDOegnCIJ+yEl
         iFLEOec7zWx1HOudFS5WZs/H4E6Y8whS6koBfNazqOip0ykHQdtEr5lhno7H1Her23XC
         XsXG9KpQoRbyxXRt+vCXTipSFXJ5a3P37cee33g22s7tnQwtTeWOr002LBAq5ygNrOvT
         LzvKheboVjl3+LN2+MDVAoT9REdYa390yPbmJ8DGpSmW1jOQHTYcoLgB+7IK81MmTZwD
         dYy9zBleMcooMpugzQAQIz8AwDQlMGfsUBixOZpWl9Udrx3ItJatB3KQNI7r1v+sES2E
         rVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TLScx4v7oOXwr6CmvRJupxwh8FrJz48xFp6JDWKE33s=;
        b=f6cbeONjiKxSiMsorRjF857uupvp4b3PBENu5GrJe2z01rG6oFLa4bgQ+zsnTYHlCl
         AgnmZDvsVVSoXTpuvoVwxC298qf1ms22qMkexLxI3aLRncs4Zbbc7T2LsoLOFOb28MmX
         BJrR03HoOoIaiv8woMF86xIs8Y76fKMernhX2aEwSXwEz1z07lxQgmkgEL8puhcq6Cf+
         FarwLFDNETsPvxDUTdQNbkTDVkQAjpZGSI/i+7hUi+WCrgGwJhazne4FI6Q0Z6g6q0TU
         LfbN6xPR5hYbBK1vv7X8t14KhtgmSJQaZj96NMkbvrp1qJwgiMHHAYKXHqqm8Bi2WUlJ
         5zQA==
X-Gm-Message-State: AJIora/FeUYZpEft2t5gLZB2l9JoQ937SctNhtfy2GTWC1CTCsM8i7Vj
        e0OKvv+g4WIJYn6T/OLn7bCmjg==
X-Google-Smtp-Source: AGRyM1tmY3oiXo8x6xEq+q6x+V33jHvqkN/46n9h+88bguTBBO3J/v8jLZk2Ge2nFF3kiSRnzRAy9g==
X-Received: by 2002:ac8:5a42:0:b0:31f:1ce3:d726 with SMTP id o2-20020ac85a42000000b0031f1ce3d726mr12185100qta.12.1658787278821;
        Mon, 25 Jul 2022 15:14:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n13-20020a05620a294d00b006b61b34d2c2sm10270777qkp.42.2022.07.25.15.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:14:38 -0700 (PDT)
Date:   Mon, 25 Jul 2022 18:14:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: Can I use CRoaring library in Git?
Message-ID: <Yt8VzTLmVOKCALxr@nand.local>
References: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
 <CAPOJW5wVYcmTA6kpf=kGEofziq1RLCg2haCMrye=EXaPLzb7Tw@mail.gmail.com>
 <9c909270-cbd5-0356-0418-4b2d3e105c93@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9c909270-cbd5-0356-0418-4b2d3e105c93@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 18, 2022 at 08:18:14AM -0400, Derrick Stolee wrote:
> On 7/18/22 7:48 AM, Abhradeep Chakraborty wrote:
> > I just got to know that CRoaring doesn't support Big Endian systems (till now) -
> >
> > https://groups.google.com/g/roaring-bitmaps/c/CzLmIRnYlps
> >
> > What do you think about this?
>
> Git cares enough about compatibility that that might be a
> deal-breaker for taking the code as-is. If we _did_ take it
> as-is, then we would need to not make it available on such
> machines using compiler macros.

I definitely agree here. If I'm understanding CRoaring's implementation
correctly, a bitmap written on a machine that uses big endian would be
unreadable on a little endian machine and vice-versa.

That's definitely *not* the case with the existing EWAH bitmaps, which
are readable on machines using either endianness, since we always write
numbers in network byte order, independent of machine endinaness.

(I suspect you know all of this already, but just stating here
explicitly for the benefit of the list).

Thanks,
Taylor
