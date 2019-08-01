Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D61C1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 21:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbfHAVmt (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 17:42:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:59504 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729708AbfHAVmt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 17:42:49 -0400
Received: (qmail 32597 invoked by uid 109); 1 Aug 2019 21:42:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 01 Aug 2019 21:42:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31718 invoked by uid 111); 1 Aug 2019 21:44:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2019 17:44:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Aug 2019 17:42:48 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2019, #01; Thu, 1)
Message-ID: <20190801214247.GB30522@sigill.intra.peff.net>
References: <xmqqv9vgmz2f.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv9vgmz2f.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 01, 2019 at 01:05:12PM -0700, Junio C Hamano wrote:

> [Graduated to "master"]
> [...]
> * jk/repack-silence-auto-bitmap-warning (2019-07-31) 3 commits
>   (merged to 'next' on 2019-07-31 at 3aa218347c)
>  + repack: simplify handling of auto-bitmaps and .keep files
>  + repack: silence warnings when auto-enabled bitmaps cannot be built
>  + t7700: clean up .keep file in bitmap-writing test
> 
>  Squelch unneeded and misleading warnings from "repack" when the
>  command attempts to generate pack bitmaps without explicitly asked
>  for by the user.

After your "I need to digest this third one" comment in the thread, I
was surprised to see this merged so soon. :) I think it's fine, and I'd
be happy to see it in the upcoming release, but I just wanted to double
check that it was intentional.

> * jk/tree-walk-overflow (2019-07-31) 6 commits
>  - tree-walk: harden make_traverse_path() length computations
>  - tree-walk: add a strbuf wrapper for make_traverse_path()
>  - tree-walk: accept a raw length for traverse_path_len()
>  - tree-walk: use size_t consistently
>  - tree-walk: drop oid from traverse_info
>  - setup_traverse_info(): stop copying oid
> 
>  Codepaths to walk tree objects have been audited for integer
>  overflows and hardened.
> 
>  Will merge to 'next'.

Thanks. Stolee noted a minor typo fix in the commit message:

  https://public-inbox.org/git/b99561c9-cd7c-aca0-c7dd-a9916b7bd429@gmail.com/

if it's not too late / too much trouble to fix.

> * js/early-config-with-onbranch (2019-07-31) 1 commit
>   (merged to 'next' on 2019-08-01 at 26b713c824)
>  + config: work around bug with includeif:onbranch and early config
> 
>  The recently added [includeif "onbranch:branch"] feature does not
>  work well with an early config mechanism, as it attempts to find
>  out what branch we are on before we even haven't located the git
>  repository.  The inclusion during early config scan is ignored to
>  work around this issue.
> 
>  Will merge to 'master'.

I had some open comments here on how the "do we have a repo" check is
done, but I think what is committed here is functionally equivalent. I
can pursue the NULL the_repository cleanups separately.

> * jc/log-mailmap-flip-defaults (2019-08-01) 1 commit
>   (merged to 'next' on 2019-08-01 at 80cddd7895)
>  + log: flip the --mailmap default unconditionally

I think this one does need fixing to actually flip the default (I
responded in that thread, too).

-Peff
