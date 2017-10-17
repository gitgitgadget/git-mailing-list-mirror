Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 080581FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 15:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965338AbdJQP42 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 11:56:28 -0400
Received: from ikke.info ([178.21.113.177]:58626 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965224AbdJQP41 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 11:56:27 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 8C96B440393; Tue, 17 Oct 2017 17:56:25 +0200 (CEST)
Date:   Tue, 17 Oct 2017 17:56:25 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Nikolay Yakimov <root@livid.pp.ru>
Cc:     git@vger.kernel.org, Anders Kaseorg <andersk@mit.edu>
Subject: Re: Multiple paths in GIT_EXEC_PATH
Message-ID: <20171017155625.GE19335@alpha.vpn.ikke.info>
References: <CA+A=rXEyQ4aQL=p55f_+kbbrnDyDr9ULSq9gqBE2YE9y6+oJ3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+A=rXEyQ4aQL=p55f_+kbbrnDyDr9ULSq9gqBE2YE9y6+oJ3w@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 17, 2017 at 06:21:22PM +0300, Nikolay Yakimov wrote:
> Hello. After updating to a recent git release (2.14, I believe, but
> possibly earlier), setting GIT_EXEC_PATH to multiple directories
> stopped working. It did work before, and I believe the culprit is
> 'git-sh-setup', which uses 'git --exec-path' output directly, while
> most other git components observe PATH syntax, i.e. multiple paths
> with colon separator. Is this intended, or is it an oversight?
> 
> For why I need that is another matter. Long story short, I need git to
> look for '.gitignore' in a particular non-standard location, since I
> have multiple git repositories in the same workdir (that workdir being
> $HOME and git repositories being stores for my different configs)

The commit that changed what you described is 1073094f3 (git-sh-setup:
be explicit where to dot-source git-sh-i18n from., 2016-10-29). That
commit claims there were already scripts that assumed GIT_EXEC_PATH is
just a single entry. That commit was included in v2.11.

There was also a recent thread[0] about it that discussed this issue,
where someone stated that indeed treating GIT_EXEC_PATH with the same
semantics as PATH has been broken for a while, but it seems there are no
real plans to fix it.

[0]:https://public-inbox.org/git/20170928223134.GA30744@varnish/


