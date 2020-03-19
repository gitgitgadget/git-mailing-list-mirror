Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD016C4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD1F20658
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgCSQDL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:03:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:43956 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727189AbgCSQDL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 12:03:11 -0400
Received: (qmail 25793 invoked by uid 109); 19 Mar 2020 16:03:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Mar 2020 16:03:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28243 invoked by uid 111); 19 Mar 2020 16:12:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Mar 2020 12:12:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Mar 2020 12:03:10 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/6] t5003: skip conversion test if unzip -a is
 unavailable
Message-ID: <20200319160310.GD3513282@coredump.intra.peff.net>
References: <cover.1584625896.git.congdanhqx@gmail.com>
 <27c7813c0fe81455b675611b9e11fee6ee2a79e9.1584625896.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27c7813c0fe81455b675611b9e11fee6ee2a79e9.1584625896.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 19, 2020 at 09:00:04PM +0700, Đoàn Trần Công Danh wrote:

> Alpine Linux's default unzip(1) doesn't support `-a`.
> 
> Skip those tests on that platform.

Makes sense. One minor nit:

> +test_lazy_prereq UNZIP_CONVERT '
> +	(
> +		mkdir unzip-convert &&
> +		cd unzip-convert &&
> +		"$GIT_UNZIP" -a "$TEST_DIRECTORY"/t5003/infozip-symlinks.zip
> +	)
> +'

Lazy prereqs are already evaluated in a throw-away directory, so you can
drop the subshell and mkdir/cd.

-Peff
