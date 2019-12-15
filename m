Return-Path: <SRS0=YD5J=2F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E81FC2D0CB
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 05:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8ABB2253D
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 05:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="LLbfzoFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfLOFd3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Dec 2019 00:33:29 -0500
Received: from ozlabs.org ([203.11.71.1]:44941 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfLOFd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Dec 2019 00:33:28 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
        id 47bCjy43Mzz9sPn; Sun, 15 Dec 2019 16:33:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1576388006; bh=H7XzMx14ck9f1Gc7Ht7ipP1ytHz1txeXcR+B8rEnRxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LLbfzoFT6oPX+sckvokDYCmkPhg9mJeFuFQlhi/fiDLLz5XyIlEuauwc2lmnj3txP
         HQ+lB+EhdCqpa3tyVx+gfmN1n8VyEEiD2u4rXHatYoJLnUopxI8vqua3nRGw989NZP
         kmYus4iyH7orlBi2/YpoucXm0hfqsIpQcRLtvzKFz9Ty9Ey5Nh+ftBwQIm1Azj5ggO
         XR0pGEkIwVVbW6yVcciqD+B1JzCJr88KD3bt9/DmoUuyYwQZbAZ0V4XwD5EAdS/CCx
         Y+OXHfTQ1FDAmggdn5cYBtbngwyX13guf05KBWEPoTZGlIGkjKn/NK1bEugI7S+TNg
         mHbBuscQMAL5w==
Date:   Sun, 15 Dec 2019 15:39:26 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     =?utf-8?B?0KDQvtC80LDQvSDQlNC+0L3Rh9C10L3QutC+?= 
        <dpb@corrigendum.ru>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gitk: don't highlight files after submodules as
 submodules
Message-ID: <20191215043926.GE12512@blackberry>
References: <20191101233427.4108-1-dpb@corrigendum.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191101233427.4108-1-dpb@corrigendum.ru>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 02, 2019 at 02:34:27AM +0300, Роман Донченко wrote:
> gitk applies submodule highlighting (coloring lines starting with
> "  >" and "  <") when `currdiffsubmod` is not an empty string.
> However, it fails to reset `currdiffsubmod` after a submodule diff
> ends, so any file diffs following a submodule diff will still be
> highlighted as if they were submodule diffs.
> 
> There are two problems with the way gitk tries to reset `currdiffsubmod`:
> 
> 1. The code says `set $currdiffsubmod` instead of `set currdiffsubmod`,
>    so it actually sets the variable whose name is the submodule path
>    instead.
> 
> 2. It tries to do it after the first line in a submodule diff, which
>    is incorrect, since submodule diffs can contain multiple lines.
> 
> Fix this by resetting `currdiffsubmod` when a file diff starts.
> 
> Signed-off-by: Роман Донченко <dpb@corrigendum.ru>

Thanks, patch applied.

Paul.
