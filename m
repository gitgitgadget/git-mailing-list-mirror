Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 900FC1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 17:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbeJPBDQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 21:03:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:41230 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726585AbeJPBDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 21:03:16 -0400
Received: (qmail 17690 invoked by uid 109); 15 Oct 2018 17:17:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 15 Oct 2018 17:17:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1398 invoked by uid 111); 15 Oct 2018 17:16:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 15 Oct 2018 13:16:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Oct 2018 13:17:07 -0400
Date:   Mon, 15 Oct 2018 13:17:07 -0400
From:   Jeff King <peff@peff.net>
To:     Tao Qingyun <taoqy@ls-a.me>
Cc:     gitster@pobox.com, git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] builtin/branch.c: remove useless branch_get
Message-ID: <20181015171707.GB1301@sigill.intra.peff.net>
References: <CACBZZX7i-Uob9EJ8GeDKYVTyKtdRiy=qPbxSOe=FGh2cbHG9Zw@mail.gmail.com>
 <20181015140839.4925-1-taoqy@ls-a.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181015140839.4925-1-taoqy@ls-a.me>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 10:08:39PM +0800, Tao Qingyun wrote:

> Signed-off-by: Tao Qingyun <taoqy@ls-a.me>

The commit message should describe the "why" here. I gave some reasoning
nearby in:

  https://public-inbox.org/git/20181015171417.GA1301@sigill.intra.peff.net/

From your initial message, it sounds like this might also be fixing a
bug ("confusing that getting a branch before it has created"). Can you
describe that (and ideally show the fix with a test)?

> diff --git a/builtin/branch.c b/builtin/branch.c
> index c396c41533..2367703034 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -809,11 +809,6 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		git_config_set_multivar(buf.buf, NULL, NULL, 1);
>  		strbuf_release(&buf);
>  	} else if (argc > 0 && argc <= 2) {
> -		struct branch *branch = branch_get(argv[0]);
> -
> -		if (!branch)
> -			die(_("no such branch '%s'"), argv[0]);
> -

From what I can tell, the patch itself _is_ an improvement. I just think
we need to explain why for the record.

-Peff
