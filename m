Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F007C7EE2E
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 03:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbjFLDsf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 23:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjFLDse (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 23:48:34 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BA2B3
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 20:48:33 -0700 (PDT)
Received: (qmail 23809 invoked by uid 109); 12 Jun 2023 03:48:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Jun 2023 03:48:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11754 invoked by uid 111); 12 Jun 2023 03:48:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 11 Jun 2023 23:48:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 11 Jun 2023 23:48:31 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 07/11] branch: fix a leak in inherit_tracking
Message-ID: <20230612034831.GG306352@coredump.intra.peff.net>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <25e68755-7073-9523-dacc-d79e4e10eb39@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25e68755-7073-9523-dacc-d79e4e10eb39@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 11, 2023 at 08:50:16PM +0200, Rubén Justo wrote:

> Actually, the string we're strdup()'ing is from the struct branch
> returned by get_branch().  Which, in turn, retrieves the string from the
> global "struct repository".  This makes perfectly valid to use the
> string throughout the entire execution of create_branch().  There is no
> need to duplicate it.
> 
> Let's fix the leak, removing the strdup().

Yep, good reasoning. I agree this is a good way to fix the leak.

-Peff
