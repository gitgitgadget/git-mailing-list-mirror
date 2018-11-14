Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BB5B1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 21:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbeKOHrL (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 02:47:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:39870 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725756AbeKOHrL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 02:47:11 -0500
Received: (qmail 17031 invoked by uid 109); 14 Nov 2018 21:42:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Nov 2018 21:42:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8053 invoked by uid 111); 14 Nov 2018 21:41:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Nov 2018 16:41:35 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2018 16:42:12 -0500
Date:   Wed, 14 Nov 2018 16:42:12 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] config: report a bug if git_dir exists without
 commondir
Message-ID: <20181114214212.GB2960@sigill.intra.peff.net>
References: <pull.78.git.gitgitgadget@gmail.com>
 <pull.78.v2.git.gitgitgadget@gmail.com>
 <0767f9837811c922c49c5aa148252f9e66320f18.1542203938.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0767f9837811c922c49c5aa148252f9e66320f18.1542203938.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 14, 2018 at 05:59:02AM -0800, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> This did happen at some stage, and was fixed relatively quickly. Make
> sure that we detect very quickly, too, should that happen again.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  config.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/config.c b/config.c
> index 4051e38823..db6b0167c6 100644
> --- a/config.c
> +++ b/config.c
> @@ -1676,6 +1676,8 @@ static int do_git_config_sequence(const struct config_options *opts,
>  
>  	if (opts->commondir)
>  		repo_config = mkpathdup("%s/config", opts->commondir);
> +	else if (opts->git_dir)
> +		BUG("git_dir without commondir");

Yeah, I think this is the right thing to do. Thanks!

-Peff
