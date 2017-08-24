Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8075C208DB
	for <e@80x24.org>; Thu, 24 Aug 2017 08:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbdHXIBy (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 04:01:54 -0400
Received: from ikke.info ([178.21.113.177]:58358 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751208AbdHXIBx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 04:01:53 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id F4182440215; Thu, 24 Aug 2017 09:58:48 +0200 (CEST)
Date:   Thu, 24 Aug 2017 09:58:48 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What does 'git blame --before <rev> -- <file>' supposed to mean?
Message-ID: <20170824075848.GG3839@alpha.vpn.ikke.info>
References: <1503254759.3881.9.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1503254759.3881.9.camel@gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 21, 2017 at 12:15:59AM +0530, Kaartic Sivaraam wrote:
> Hello all,
> 
> I tried to do a 'git blame' on a file and wanted to see the blame
> before a particular revision of that file. I initially didn't know that
> you could achieve that with,
> 
>     $ git blame <rev> <file>
> 
> I thought I need to pass the revision as a parameter so I tried (before
> looking into the documentation) the command found in the subject. It
> worked but to my surprise it had the same result as,
> 
>     $ git blame -- <file>
> 
> I was confused and came to know from the documentation that blame
> doesn't have any '--before' option. That was even more surprising. Why
> does blame accept an option which it doesn't identify? Shouldn't it
> have warned that it doesn't accept the '--before' option? I guess it
> should not accept it because it confuses the user a lot as the could
> make it hard time for him to identify the issue.
> 
> 'git blame' doesn't seem to be the only command that accepts options
> not specified in the documentation there's 'git show' for it's company,
> 
>     $ git show --grep 'regex'
> 
> But the good thing with the above command is it behaves as expected. I
> suspect this should be documented, anyway.
> 
> Thoughts ?
> 
> -- 
> Kaartic

Git blame takes options that are fed to git rev-list, to limit the
commits being taken into account for blaming.

The man page shows "[--since=<date>]", which is one such option, but
before is valid as well.

git blame -h shows:

    <rev-opts> are documented in git-rev-list(1) 

and man git-blame shows under specifying ranges (emphasis mine): 

     When you are not interested in changes older than version v2.6.18,
     or changes older than 3 weeks, *you can use revision range
     specifiers similar to git rev-list*:

So these options are not documented under git blame, but git rev-list.

Perhaps the synopsis of man git-blame could be expanded so that that
it's clear it accepts rev-list options.

Kevin
