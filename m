Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B69C4741F
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 22:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDBA920867
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 22:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmBnKsgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbgKDWRf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 17:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732051AbgKDWRD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 17:17:03 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE0FC0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 14:17:03 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id e7so18458861pfn.12
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 14:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I8znQ4kz/49E5RFkMwPl1xnyENLjfggB8HjKwK4g4Ng=;
        b=hmBnKsgKAP4hyeYRP4EiyQ8TWjGRtFSifiddZM7qFg3bXdxdYK7oNWQB1Ky2f5oykE
         lSOy7hCi8N4OiHdxtufY+IqHC+rQYRC7cGiODLzolnEFVnIMj/kbN0Nzdq+YfIwinDTK
         gNVHEVrQ1RIi5jpM3XfM6d69KfuRlM1NgX60SM/9puCgyFXv2n5CxaM//El39f1Ooe0I
         BLhubpt0wr6AJz1FL6sVU6c1kIPDG18Op0Hbwyk9TYeBwuSVEhu6WbUG4u/fuYhWcbfL
         ghyDsP2kxMXDI6TZFOgmElkpKkXvpboXJmw/telQXe9TBzu5dTIRBl7x507cYML1MvBQ
         65gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I8znQ4kz/49E5RFkMwPl1xnyENLjfggB8HjKwK4g4Ng=;
        b=bJ1WPRGhvRX1eNgAbZ46p5AJoM7qh60XbEJShXJdParp71HyrHqvaY4v4uxa1nbd5u
         oi/febRPdZ2eTNEk0TEMi1m+DexGoclEsgp3h1gDAK0sECepNq04QNwerrwDSKf/J9Va
         63Bhfc1CSERr3MwfeVBmjFL4il3/FLaaOTYvTkxZW7EUMMjIUCvkmCRgMp+rFPvjxeet
         3RMWTzxAw//A9/kaAYxomyGuMmaBcbhufZm3IYk3JN2FvNbuyGcv8BxI6x6GUos4iYP4
         A+shEva/St/v3J8AvcitzjmXgRrV7Jdh+YBVFPHcGbiO0t6g/VYI/K9LUgfsazgQLTTM
         ufxg==
X-Gm-Message-State: AOAM531wOsxrWMIQW6HVwHLjEyMOzl9em1aIEXoBRwY6g6dAmVwsGp2P
        0QQ3b3dg79UvzYF5batfDwzg95SO1V8=
X-Google-Smtp-Source: ABdhPJyUeYT7ciIk1OiM1wlWbSj3+CgcN0/neI17ah/eKTzRjneTNCA4nIo5RZakfRqEaDUJQ+m2Xg==
X-Received: by 2002:a17:90a:3d0f:: with SMTP id h15mr43984pjc.234.1604528222854;
        Wed, 04 Nov 2020 14:17:02 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id nv7sm2942819pjb.27.2020.11.04.14.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 14:17:01 -0800 (PST)
Date:   Wed, 4 Nov 2020 14:16:59 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rev-parse: add option for absolute or relative path
 formatting
Message-ID: <20201104221659.GA3183353@google.com>
References: <20200908185017.2005159-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908185017.2005159-1-sandals@crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:

> This impetus for this patch is Git LFS, which is written in Go.  Go
> lacks a cross-platform way to canonicalize paths in the same way that
> Git does, so when Git produces relative paths, such as in some cases
> with --git-common-dir, we end up with problems when users are doing
> things with unusual paths on Windows, such as when using SUBST or
> OneDrive or various other edge cases.  Go upstream does not appear eager
> to address this problem.

Can you describe the user-facing symptom?  While reviewing
https://lore.kernel.org/git/20201009191511.267461-1-sandals@crustytoothpaste.net/
I'm trying to understand the motivation and I'm getting stuck at
trying to understand the basics of the problem being solved.

E.g. is this about being able to compare paths, being able to open
files, resolving symlinks, something else?

Thanks,
Jonathan
