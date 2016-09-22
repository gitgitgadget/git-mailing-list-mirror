Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81AE21F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 15:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935881AbcIVPob (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 11:44:31 -0400
Received: from ikke.info ([178.21.113.177]:47434 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935752AbcIVPo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 11:44:29 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 904D74400AA; Thu, 22 Sep 2016 17:44:21 +0200 (CEST)
Date:   Thu, 22 Sep 2016 17:44:21 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Timur Tabi <timur@codeaurora.org>
Cc:     git <git@vger.kernel.org>
Subject: Re: .gitignore does not ignore Makefile
Message-ID: <20160922154421.GA6641@ikke.info>
References: <CAOZdJXWpcSZ+jAoV8HttkaB7Fh=wzWDTCsHy8W-S9xOOBodVFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOZdJXWpcSZ+jAoV8HttkaB7Fh=wzWDTCsHy8W-S9xOOBodVFw@mail.gmail.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2016 at 09:19:22AM -0500, Timur Tabi wrote:
> I have the following .gitignore file in patch arm/arm64/boot/dts:
> 
> *.dtb
> qcom
> qcom.orig
> 
> When I do a git status, I see this:
> 
>     modified:   .gitignore
>     modified:   qcom/Makefile
> 
> All of the other files in arm/arm64/boot/dts/qcom are being ignored,
> as request.  However, the file "Makefile" is not being ignored.  Why?
> What's so special about "Makefile" that git refuses to ignore it?
> 

There is nothing special about the Makefile, except that it's tracked.
Git never ignores tracked files (almost a paradox).

You can untrack the file by doing git rm --cached <file>, which new
commits won't have this file.

If your goal is to ignore local changes to a tracked file, then the
advise is to reconsider your plan. 

Often people advise tricks like `git update-index --assume-unchanges
<file>`, but this does not work as expected. It's merely a promise to
git that this file does not change (and hence, git will not check if
this file has changed when doing git status), but command that try to
change this file will abort saying that the file has changed.

Hope this helps,

Kevin.

