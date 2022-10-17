Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FECC4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 17:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiJQRvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 13:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiJQRut (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 13:50:49 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DB51DA79
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:50:32 -0700 (PDT)
Received: (qmail 27455 invoked by uid 109); 17 Oct 2022 17:50:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Oct 2022 17:50:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9137 invoked by uid 111); 17 Oct 2022 17:50:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Oct 2022 13:50:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Oct 2022 13:50:08 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 00/11] cocci: make "incremental" possible + a
 ccache-like tool
Message-ID: <Y02V0E0JRSNa4Sb9@coredump.intra.peff.net>
References: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
 <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2022 at 05:31:16PM +0200, Ævar Arnfjörð Bjarmason wrote:

> The big change in this belated v3 is that we now run against a
> concatenated version of all our *.cocci files. This is something I
> discussed with Jeff King at Git Merge, after having confirmed the
> viability of that approach on the cocci mailing list.

Is that safe? The last time it was brought up on this list (AFAIK) was
in:

  https://lore.kernel.org/git/alpine.DEB.2.20.1808030755350.2446@hadrien/

where Julia said:

  I'm surprised that the above cat command would work.  Semantic patch rules
  have names, and Coccinelle will not be happy isf two rules have the same
  name.  Some may also have variables declared in initializers, although
  perhaps the ones in the kernel don't do this.  Causing these variables to
  be shared would not have a good effect.

  Putting everything together can also go counter to the optimizations that
  Coccinelle provides. [...]

Maybe we don't do any of the things that could trigger problems in our
spatch rules. But it's not clear to me what we're risking. Do you have a
link for further discussion?

-Peff
