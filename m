Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ED7C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 20:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DC6F611C1
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 20:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhDGUSq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 16:18:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:43694 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356052AbhDGUSm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 16:18:42 -0400
Received: (qmail 17688 invoked by uid 109); 7 Apr 2021 20:18:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Apr 2021 20:18:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22645 invoked by uid 111); 7 Apr 2021 20:18:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Apr 2021 16:18:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Apr 2021 16:18:31 -0400
From:   Jeff King <peff@peff.net>
To:     Horst von Brand <vonbrand@inf.utfsm.cl>
Cc:     git@vger.kernel.org
Subject: Re: No error when overwriting ignored files
Message-ID: <YG4Tl1IPlFBIhV4l@coredump.intra.peff.net>
References: <2056254759.360640.1617825398727.JavaMail.zimbra@inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2056254759.360640.1617825398727.JavaMail.zimbra@inf.utfsm.cl>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 07, 2021 at 03:56:38PM -0400, Horst von Brand wrote:

> When pulling from a repository that tracks a file listed in
> `.gitignore` that would overwrite a local file, this is not reported.
> 
> For example, in the attached repositories, when doing `git pull tst1`
> in `tst2`, it is (correctly) reported that `ignored.not` would be
> overwritten, while `ignored.txt` is not reported.

This is behaving as intended. Ignored files are not considered
"precious". You can find more discussion by searching for that term in
the list archive.

There is no concept of "ignored but precious" in Git. However, here's an
old patch series that tries to move in that direction (using an
attribute):

  https://lore.kernel.org/git/20190216114938.18843-1-pclouds@gmail.com/

AFAIK nobody is actively working on it right now.

-Peff
