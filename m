Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2E7C202F4
	for <e@80x24.org>; Sun,  3 Jul 2016 06:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbcGCGPz (ORCPT <rfc822;e@80x24.org>);
	Sun, 3 Jul 2016 02:15:55 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46886 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791AbcGCGPz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2016 02:15:55 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 093A51F728;
	Sun,  3 Jul 2016 06:15:53 +0000 (UTC)
Date:	Sun, 3 Jul 2016 06:15:53 +0000
From:	Eric Wong <e@80x24.org>
To:	Christopher Layne <clayne@anodized.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] git-svn: clone: Fail on missing url argument
Message-ID: <20160703061553.GA20458@dcvr.yhbt.net>
References: <20160703053923.GA12956@ns1.signalpunk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160703053923.GA12956@ns1.signalpunk.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Christopher Layne <clayne@anodized.com> wrote:
> * cmd_clone should detect a missing $url arg before using it otherwise
>   an uninitialized value error is emitted in even the simplest case of
>   'git svn clone' without arguments.

Thanks, this patch looks obviously correct.

I've eliminated the '* ' and space prefix from the version I've
applied since it's not the convention around here.

> Signed-off-by: Christopher Layne <clayne@anodized.com>

Signed-off-by: Eric Wong <e@80x24.org>

And pushed to "master" of git://bogomips.org/git-svn
(I'll request for Junio to pull within a few days while
 other changes pile up).

>  sub cmd_clone {
>  	my ($url, $path) = @_;
> -	if (!defined $path &&
> +	if (!$url) {
> +		die "SVN repository location required ",
> +		    "as a command-line argument\n";

"as a command-line argument" seems like an unnecessary phrase,
but I see we use it elsewhere; so it's fine here.

I might be tempted to queue up a separate patch
to eliminate this extra statement from the rest of git-svn,
though.  Not sure if others feel the same way.
