Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3229EC4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 19:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLITVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 14:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLITVq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 14:21:46 -0500
X-Greylist: delayed 304 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Dec 2022 11:21:44 PST
Received: from smtp87.iad3b.emailsrvr.com (smtp87.iad3b.emailsrvr.com [146.20.161.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCE02CCAC
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 11:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oddbit.com;
        s=20180920-g2b7aziw; t=1670613400;
        bh=kGvax5GdotMmTvAU+Tq1oIuBjwKFWxVuEmH9YEnRstY=;
        h=Date:From:To:Subject:From;
        b=Ai3Xi+qgXNAV1dyjya3AmFJ0EZ49MgshIubLjvyzjgjMQlWx8Q8B7dQtcK48m6jBA
         +82EYpMkI5PQ7QcClcXWCWbdJoDW3/bM+QiZUd0G/THxfPw5DmLnRmEqHGFRfBwaP8
         vgnK5z5lRsjSbG3Omucx0xvgxm5Szv6i50rm7cKY=
X-Auth-ID: lars@oddbit.com
Received: by smtp19.relay.iad3b.emailsrvr.com (Authenticated sender: lars-AT-oddbit.com) with ESMTPSA id CE7DD4019F;
        Fri,  9 Dec 2022 14:16:39 -0500 (EST)
Date:   Fri, 9 Dec 2022 14:16:39 -0500
From:   Lars Kellogg-Stedman <lars@oddbit.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] line-range: Fix infinite loop bug with degenerate
 regex
Message-ID: <20221209191639.ixsvxgf5ef2zloik@oddbit.com>
References: <20221205193625.2424202-1-lars@oddbit.com>
 <221207.86tu27aju3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221207.86tu27aju3.gmgdl@evledraar.gmail.com>
X-Classification-ID: 39a5256a-2bc7-4697-a631-9dfc7c861ffe-1-1
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 07, 2022 at 05:52:04AM +0100, Ævar Arnfjörð Bjarmason wrote:
> We really should fix this, but why not just count this as a match,
> rather than erroring out?
> 
> That we're mixing up whether '$' always matches here with our iteration
> loop is our own internal bug, we shouldn't error out on a '$'. It's just
> a regex that happens to match everything.

Thanks, that makes a lot of sense. I'll try to rework things this
weekend.

Cheers,

-- 
Lars Kellogg-Stedman <lars@oddbit.com> | larsks @ {irc,twitter,github}
http://blog.oddbit.com/                | N1LKS
