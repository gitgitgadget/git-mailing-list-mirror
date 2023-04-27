Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A36C77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 08:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243033AbjD0IdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 04:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242907AbjD0Ic6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 04:32:58 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2381A49FE
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 01:32:55 -0700 (PDT)
Received: (qmail 20785 invoked by uid 109); 27 Apr 2023 08:32:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Apr 2023 08:32:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17478 invoked by uid 111); 27 Apr 2023 08:32:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Apr 2023 04:32:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Apr 2023 04:32:53 -0400
From:   Jeff King <peff@peff.net>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf_stripspace(): rename skip_comments arg to
 strip_comments
Message-ID: <20230427083253.GA1478679@coredump.intra.peff.net>
References: <20230323162234.995405-1-oswald.buddenhagen@gmx.de>
 <ZEopHDNl69ZBcpps@ugly>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZEopHDNl69ZBcpps@ugly>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2023 at 09:49:48AM +0200, Oswald Buddenhagen wrote:

> ping!
> 
> On Thu, Mar 23, 2023 at 05:22:34PM +0100, Oswald Buddenhagen wrote:
> > That makes its function much clearer and more consistent with the
> > context.

A quick aside on workflow:

  - It's customary on this list to just re-send the patch (with a note
    that it's a re-send below the "---"), rather than a "ping" email.
    They both potentially get more people's attention, but one doesn't
    require people to dig up the old thread. :)

  - We usually reserve cc-ing for people who have touched that area, or
    participated in previous discussions on the topic. That helps people
    manage the list traffic by seeing which threads somebody else
    thought would be important for them to see. But here I think I'm on
    the cc because I'm a sucker who will review anything that gets cc'd
    to me. A better cc might be folks who added the parameter, though it
    has been long enough that they may or may not be active.

I'll quote liberally from the original below:

On Thu, Mar 23, 2023 at 05:22:34PM +0100, Oswald Buddenhagen wrote:

> That makes its function much clearer and more consistent with the
> context.
> 
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> ---
>  strbuf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/strbuf.c b/strbuf.c
> index 1c57ac6574..49e8beaa4c 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -1118,10 +1118,10 @@ static size_t cleanup(char *line, size_t len)
>   *
>   * If last line does not have a newline at the end, one is added.
>   *
> - * Enable skip_comments to skip every line starting with comment
> + * Enable strip_comments to strip every line starting with a comment
>   * character.
>   */
> -void strbuf_stripspace(struct strbuf *sb, int skip_comments)
> +void strbuf_stripspace(struct strbuf *sb, int strip_comments)

I don't have a strong opinion either way. The original name was just
copied from stripspace()'s similar parameter, which came from 9690c118fa
(Fix git-stripspace to process correctly long lines and spaces.,
2007-06-25). I don't think it carries any particular significance,
though I find either name easy enough to understand.

-Peff
