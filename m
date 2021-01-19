Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE4CC433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E19523104
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbhASXDn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 18:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbhASXDg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 18:03:36 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FDCC061573
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:02:52 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id d14so23620071qkc.13
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j8c4qkKNMYXxJfCb7kr2Eym8kxIzNy7THrVNbErk4QQ=;
        b=a/5lDcLI486kh/AD+ZoF70QX8JCEALlo5kni4ubJNhmFx17yxQOBFPhZSawTuMM4Gb
         1UxMALlOj0B/KouyO7RQ4PsZe76UdXZ4WazykFm3UZObY720JYCaG+fP7l8yEa3EhmTS
         qcIe0eDkBex4UCS/VcKxXx79m8XnNrVVc52uwJVv/P5AnSnIFP3UQkEf9ujEaRr6Txwq
         RBVzEOcP35r4aqDAgL3xshnb9+YmaGerssNVxLxA1VUVETYvEINBoLCUsBT5rOsWoD3+
         hit4MHizGhqoQ3C+Uj9Ld3ijWRZbPkJ2yuBD5gSrfTPwMlbmRbjkYIxJOsXlivJ0qnoh
         iOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j8c4qkKNMYXxJfCb7kr2Eym8kxIzNy7THrVNbErk4QQ=;
        b=Go4NYcvoF2p8UcSqsyMjP7w07gdgcrqManA7PfM0bp24fCshudpIUd1auYHUaDz/jw
         Ezv/z7l6wAEcYMJAm9pYf6pEUYmk0/DOUCkNcl2EaWLFlTKydNz6tc1GPZ/5U0p5ZFK3
         xbNIP7fCScka1Nol/ltgFSMQX3qycnsxUeutFeHpenkkJBehe5xp3mBnYWMgVax4i6hR
         iwfShORIaPD/bYDP2c0XQdVAFSMDdl1jiAUHvN3K2z+KcbOt7tpGNT8OTZYew7WnU+SU
         qDDwLKfMbx2Mm/dtxCYHmj/fhDOxSfwCUkBkhAILOS0AalOcGJhtspu7agopFfB10NgY
         hVuA==
X-Gm-Message-State: AOAM531yzEwZ0SpTBTT0tS7PhWkOeARF2j+sZr4FzaJJYDeeENuWJYns
        oxQS/9t3vn6CJDPj6im2q8rnOg==
X-Google-Smtp-Source: ABdhPJx20FEHN/7d1SiyQRL+Aq+JjcwfuLJ4zh/WgmyQX8zf//xfzfUBB33jMIFOtt/k5uX2js5jgg==
X-Received: by 2002:a05:620a:1368:: with SMTP id d8mr6672009qkl.101.1611097371555;
        Tue, 19 Jan 2021 15:02:51 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id q3sm137929qkb.73.2021.01.19.15.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 15:02:50 -0800 (PST)
Date:   Tue, 19 Jan 2021 18:02:48 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Jacob Vosmaer <jacob@gitlab.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] ls-refs.c: minimize number of refs visited
Message-ID: <YAdlGMv3EC1ORUew@nand.local>
References: <20210119144251.27924-1-jacob@gitlab.com>
 <20210119144251.27924-2-jacob@gitlab.com>
 <YAcE/dTuOB9PbGQU@nand.local>
 <CADMWQoPREhirr+RJPkJJV2U+8VG=DFotvTBCDSXFhn-3pn2X-A@mail.gmail.com>
 <YAcuUDqfvKzfHFMb@nand.local>
 <YAdWNgF75QEYFLA7@coredump.intra.peff.net>
 <YAdaAsP6vCQla/Ar@coredump.intra.peff.net>
 <YAdb6GmVXWLEGkP1@nand.local>
 <YAdik+z5yj2XU0ti@coredump.intra.peff.net>
 <YAdkVkXOnpDy28h2@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAdkVkXOnpDy28h2@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 19, 2021 at 05:59:34PM -0500, Jeff King wrote:
> Actually, I am not sure that we would look for "refs/tags/" in that case
> (I did a quick test and we do not seem to). Which makes sense, as it is
> cheaper to find the "a" and "b" hierarchies separately if there is a
> very big "refs/tags/c" hierarchy.

Ah, makes sense. Thanks for double checking.

> But I agree that this is a good reason that callers should consider it
> as an optimization which could return more results than expected.

Yep. Even though I couldn't quite remember when the algorithm would
split without looking more closely, I made sure to document that it
iterates *all* references that are descendent of the LCP of its
arguments.

> -Peff

Thanks,
Taylor
