Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8C4C4332F
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 01:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiKXBJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 20:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiKXBJX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 20:09:23 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CE6ED73A
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 17:09:19 -0800 (PST)
Received: (qmail 24344 invoked by uid 109); 24 Nov 2022 01:09:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Nov 2022 01:09:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21491 invoked by uid 111); 24 Nov 2022 01:09:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Nov 2022 20:09:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 23 Nov 2022 20:09:17 -0500
From:   Jeff King <peff@peff.net>
To:     Yoichi Nakayama <yoichi.nakayama@gmail.com>
Cc:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 2/2] git-jump: invoke emacs/emacsclient
Message-ID: <Y37EPdUkBhsSPmRD@coredump.intra.peff.net>
References: <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com>
 <pull.1423.v4.git.1669126703.gitgitgadget@gmail.com>
 <2f0bffb484beccf58f2440ed5e2c04a1ba26e6c3.1669126703.git.gitgitgadget@gmail.com>
 <Y30a0ulfxyE7dnYi@coredump.intra.peff.net>
 <CAF5D8-vSsBsdiA8SiDgqUFkL9_3N-v+psVxj-AcibOB88gxWfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAF5D8-vSsBsdiA8SiDgqUFkL9_3N-v+psVxj-AcibOB88gxWfA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 23, 2022 at 02:33:50PM +0900, Yoichi Nakayama wrote:

> On Wed, Nov 23, 2022 at 3:54 AM Jeff King <peff@peff.net> wrote:
> > Hmm, I know I suggested using a temporary file since "cat $tmpfile"
> > should be pretty safe. But it does still have problems if your tmp
> > directory has spaces. Or even other metacharacters, which I think will
> > be interpreted by the eval, since $@ is expanded in the outermost level
> > of the shell.
> 
> Right. But the problem is not specific to emacs (it happens in vim too).
> Let's fix it another time (as you noted, that's pretty unlikely, and we may
> not even need to fix it).

Good point. The vim version is easier to fix (we just need to
double-quote \$1 inside the eval), but the fact that nobody has
complained is an indication that it does not really matter.

-Peff
