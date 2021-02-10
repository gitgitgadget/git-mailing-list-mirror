Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D084C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 02:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D089064E4B
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 02:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbhBJCoy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 21:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbhBJCmv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 21:42:51 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E46C06178B
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 18:41:58 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id e15so563485qte.9
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 18:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LGNxvo7Au0yFLr9YvJ2Ko7qzTxGXulKRLh3di3LUljE=;
        b=Tp427HHRtijuVVq4u2m7XZO3RI5tQgKrW8HWM0y79WmnwAGm1iKxZCQ73UAMIkg1Rf
         n3K5sVMRrF4H46CgtSFuvmBVmjuzQzEH6hhHuvF8X3VsoqKteF47+pGFednOaSbZd5JU
         FV6Scoahd2wtzZphbmCoYp9FyPuMTmxTW2SkONZLXzySOsjIZdPwrHtERvIjcXPDR+Ib
         y9hIs7ngyRZYjAPI/XCcK6iKS8X7DdIlBf8/qYWGL7xCwVexyCtqp7TFC9dDK4iYWKpW
         vXLerXAMyBja6+vgeSr3h1fKce1+lUlwfhMd1xdJSA1U0MeB2TShhG5ll+1AMcKIduIK
         emDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LGNxvo7Au0yFLr9YvJ2Ko7qzTxGXulKRLh3di3LUljE=;
        b=M8MVtaqYA7PHYO9tbAE6g3a9MFG4S5Pg1xfb4YKAtrSvSHXT+/4o62Ev7958lFhhWw
         CcreO8s0/Xay4Maht6SBQc2LNyXS/gixEod0c2oOqUEB8QJItyE0zidH76sVieEOXCj7
         PE5VWLacyBeZJItL/tjekdkcid6mb4jMdp2u5X9mrfCSjvB0QB4ZYn/itmbKlt0BuPcl
         QVSr5xKVe7AgGSV80aeD3NN82g/U/GYJvF2OH2JT7OmuVqsBlLEUkfKPkAZhWHIa9/F+
         W56C04ZUm+6zYYdM7j4/qU/XP4eftnYp89WQr6WKaCS3jxdnmFCpu1zhtayxQUGsXpVR
         G3LQ==
X-Gm-Message-State: AOAM531Fen+UUpQhbpAagB7VcEu+iwQ3UtRqPw2LUJ/o5lNESNWVRPa8
        bACN9/4Jb5y5MWbKk5aFpOxyjVCzE3y+WOMe
X-Google-Smtp-Source: ABdhPJz4rYvTV6+CzQaHvNKlmssyKnV9Dv7pLPgkagq7fR19fqnWEljXpxejFUml+dXmBvCNaIs7tQ==
X-Received: by 2002:ac8:6e9a:: with SMTP id c26mr1004723qtv.220.1612924917511;
        Tue, 09 Feb 2021 18:41:57 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:2c3d:3179:bfad:c65])
        by smtp.gmail.com with ESMTPSA id x22sm468029qtq.15.2021.02.09.18.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 18:41:56 -0800 (PST)
Date:   Tue, 9 Feb 2021 21:41:54 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/2] Maintenance: add pack-refs task
Message-ID: <YCNH8v3Q/3ny8ETv@nand.local>
References: <pull.871.git.1612795943.gitgitgadget@gmail.com>
 <pull.871.v2.git.1612878149.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.871.v2.git.1612878149.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 09, 2021 at 01:42:27PM +0000, Derrick Stolee via GitGitGadget wrote:
> Updates in V2
> =============
>
>  * Fixed doc typo. Thanks, Eric!
>  * Updated commit messages to make it clear that the 'pack-refs' step will
>    still happen within the 'gc' task.
>  * Updated the test to check that we run the correct subcommand.
>  * maintenance_task_pack_refs() uses MAYBE_UNUSED on its parameter.

Thanks, the range-diff looked sane to me.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>
