Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD6FD204A0
	for <e@80x24.org>; Wed,  3 Aug 2016 14:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbcHCOjJ (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 10:39:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:56257 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752995AbcHCOjI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 10:39:08 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MTBLi-1bePea1M4U-00S5lZ; Wed, 03 Aug 2016 16:31:42
 +0200
Date:	Wed, 3 Aug 2016 16:31:41 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Chris Packham <judge.packham@gmail.com>
cc:	git@vger.kernel.org
Subject: Re: [RFC/PATCH] rebase--interactive: Add "sign" command
In-Reply-To: <20160803084743.3299-1-judge.packham@gmail.com>
Message-ID: <alpine.DEB.2.20.1608031621590.107993@virtualbox>
References: <20160803084743.3299-1-judge.packham@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9YQ3OJjzPlIS3JKJgEY1kKwvTDamnaWHByWx9wI+wih7O7jyN9I
 OoHrwF6vfgZ8agWF4svVB2K9j/oMbcsqrfDbJR220w5Clx67x1dVW2IbZBxwluZv8vV3Oua
 GxC+4SG3NGlXcd2lCDqYaK+eFpRiSPLCmUKf+f58ZShoYf1nsqZIsFCEMeX7Z51aMyvLn+P
 nBm1IyNjq7BKW3T3Vn+Xw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:L/OfvjKizsk=:Hm0mse96tbkCXtvmtvDEjJ
 7RGEAtnQS7Pa5KF6bN7RfL9eD7/rbwkjLnX0IqjS8dXnQINVm5mNgwl2f56SNIaujxaKBDP/L
 6rREEFugT2NSVHBymHT6CginqA/rmIlGBXvLrddZHapCqHtowVMdxG0Zk63TrtC7pZW7244xe
 BS5sgN4YARo/t5iI8rWaFDCZqCMjDVVCgng+UhVafFFfcPqUMudHRG4mVCqjbRHfLNvFgFnAr
 NVQMBxJn8ugaqWOr97dbjWdWGrumnOc19NK2RyfgtXBoHtIMXQvtJE02kKNoY9YVE6317boei
 9+3M+ijI+U+AC191ngNZ01I4MRC7avhbRvaIW9JhhLO310M3pNGjglSZeivQWqDCKZBi7KKNS
 KvZWDhJoLb587wUJ/hZEHKPWZ4V+Y5P8A4IeqZhiPldM6CFwkB9BI8MW3GbHNz1jRcwS9L86k
 ea2QulTn840LaoO6xK+0FNRaAWcn7h+4s2zAt42jeLZKR/aCMxAmzQMejxnSHGdSKeI1b/8qi
 17LhZ9C3hpPa5XrRuMWY6XU4+QHnqdeb52H8ViFGx6gVyX0x986GlZMGGiCMC5T+dQDeo4RZu
 DAxpdpan4ZmQzpM/QSZSXuoJ7htRi3WaUIhqblzC4EkQU7vJ0Fwey9Ht+Y7jBRKerBouOkU0a
 qxAxrBnTcsLjVjCmYB8MihAY/9ldJn2kbfXGRlznIR3HIHwxgeBgGYX/cshGG6G6RlFaZD8qq
 w8AYUyGxopiVOaCnUFwS5yb5vZpDepFQQmQ6cu/F6qX7Y6s4Ua/IHBtYyEvYIVUyIR1xjO0GV
 +c6aBI5
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Chris,

On Wed, 3 Aug 2016, Chris Packham wrote:

> This is similar to the existing "reword" command in that it can be used
> to update the commit message the difference is that the editor presented
> to the user for the commit. It provides a useful shorthand for "exec git
> commit --amend --no-edit -s"

I can understand how this "sign" command helps you. I myself wished for
new commands when working on my Git garden shears [*1*] (essentially, what
git rebase --interactive --preserve-merges *should* have been).

My solution was to introduce a new fake editor that calls the real editor
and afterwards converts the "new" commands into exec lines.

Having said that, this patch clashes seriously with my current effort to
move a lot of the interactive rebase from shell into plain C. It is
actually ready, but getting this into the code base is really slow-going,
unfortunately.

Now, after looking at your patch it looks to me as if this would be easily
ported, so there is not a big deal here.

However, I could imagine that we actually want this to be more extensible.
After all, all you are doing is to introduce a new rebase -i command that
does nothing else than shelling out to a command. Why not introduce a much
more flexible feature, where you add something like "rebase -i aliases"?

Maybe something like this:

[rebase "command"]
	sign = git commit --amend -s --no-post-rewrite --no-edit -S

I have not completely thought this through, but maybe this direction would
make the interactive rebase even more powerful?

Ciao,
Johannes
