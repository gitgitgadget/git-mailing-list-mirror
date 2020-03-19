Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5CBC4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 15:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC89920724
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 15:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgCSPxJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 11:53:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:43922 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727217AbgCSPxI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 11:53:08 -0400
Received: (qmail 25711 invoked by uid 109); 19 Mar 2020 15:53:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Mar 2020 15:53:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28120 invoked by uid 111); 19 Mar 2020 16:02:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Mar 2020 12:02:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Mar 2020 11:53:07 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/6] t4061: use POSIX compliance regex(7)
Message-ID: <20200319155307.GB3513282@coredump.intra.peff.net>
References: <cover.1584625896.git.congdanhqx@gmail.com>
 <c45d6383173d8d3e73cdcdd6e993d3259d519a68.1584625896.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c45d6383173d8d3e73cdcdd6e993d3259d519a68.1584625896.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 19, 2020 at 09:00:02PM +0700, Đoàn Trần Công Danh wrote:

> BRE interprets `+` literally, and
> `\+` is undefined for POSIX BRE, from:
> https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09_03_02
> 
> > The interpretation of an ordinary character preceded
> > by an unescaped <backslash> ( '\\' ) is undefined, except for:
> > - The characters ')', '(', '{', and '}'
> > - The digits 1 to 9 inclusive
> > - A character inside a bracket expression
> 
> This test is failing with busybox sed, the default sed of Alpine Linux
> 
> Fix it by using literal `+` instead.

This makes sense, I think. It could hurt a sed which is expected ERE and
needs the "+" escaped, but I think such a sed would be wrong (and I
imagine would break things elsewhere).

-Peff
