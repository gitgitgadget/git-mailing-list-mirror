Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 497901F6C1
	for <e@80x24.org>; Thu, 18 Aug 2016 14:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767179AbcHROYp (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 10:24:45 -0400
Received: from mout.gmx.net ([212.227.15.19]:59461 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767547AbcHROYk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 10:24:40 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LdYdG-1asqCg1c0I-00io4y; Thu, 18 Aug 2016 16:23:44
 +0200
Date:	Thu, 18 Aug 2016 16:23:42 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Lars Schneider <larsxschneider@gmail.com>
cc:	git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	mlbright@gmail.com, e@80x24.org, peff@peff.net, ben@wijen.net
Subject: Re: [PATCH v5 15/15] read-cache: make sure file handles are not
 inherited by child processes
In-Reply-To: <20160810130411.12419-16-larsxschneider@gmail.com>
Message-ID: <alpine.DEB.2.20.1608181617240.4924@virtualbox>
References: <20160803164225.46355-1-larsxschneider@gmail.com/> <20160810130411.12419-1-larsxschneider@gmail.com> <20160810130411.12419-16-larsxschneider@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aU1ezodq3LvKFHyHa/WPJ+qQoUG2cigq+4jiUQTM/64hTeMPzfb
 2WyFr18NpnIm858Wptg/mr3u6isha9RrQUv5y5+spmRTVdVEuxBJqxM/OHuaul9mnT48xjc
 OhQL3/Wnx/RMG9RMleL268Y9FZwTtU0C+qf/QzqQ6uQAdhnE+WCH0fud4aqrBHOBS7rt3g/
 Yc6f3h38d73Vu2H3qtVRw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:mJ2MVNh7W+M=:v647ORkSReE+rpncr3BlCX
 khc+zVYWYXae1e6T82YffSCuwGXwaj+SrTuK2GfB1on9orFjkwF1e7dmuQlXTJegKp8zcFqsG
 eiUT+1QvNycqPsvzrJzigl/T09GO0391zWpd1ID/ojOdXn/eBb/ljHcTfk6J6BZ+2bbW5+5QT
 RS+ichRwVWhaZsEVqxkC9nQ+mGUd684Q4FWC26/QlJl4sDerR8Ca4Pw5PQTpE1shbgZayutg5
 8P1XAzmkSZR0xyExi5SkA9kDcwWZTPOAoqxUMOEI3+lvCn32IN4L/IRGYMDGmq+JxKm9nJg8F
 9ktZ//SofrB7/R3wkGCVPXhcDJunQHzDQoc7fn3QjsyOuuZk12B7gM0mHNDBAbIJMjDwgUiS8
 W5rkZWLwEYG6tKz8imoG+PSSLueL76zLgI5wOqFZLUbVZ571teB0IYkLRSuQdC50Q9eetZw9J
 onVClinFU6mHS/C//b52p7wUAvAF7uxlMhTpNWpwwgN5bf9NcBqxU6lj0sb9T/ra2TN5FZllH
 PVa5ycxQ73S+wrD0trCdddKbD0JGxv2SZP3+2eGI4oVtnPA+r1jXxFenWeMJ2NeDcXeiqF9Qh
 LwJGfekqZ6yMdtfx+5bTY/fXyAsTcR3sVo6YVMvNeedg1qWxH9JaM+BfctaJ22E+P8ktdOPol
 n2xeCosX313DROtpOBdnZFg78sB4GZMzUGUWMHWuuH3T7MCtdyzXnYSITFIOlH5IHIXcTiA55
 Mjvnbn0Og+U7e8uzdcHHkVDdYR4Ns1u2m68dvqmJpQ7uOU6VZhfsZUtB8bYxGr34JS3Kcr8IE
 2ZBrYQR
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Lars,

On Wed, 10 Aug 2016, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Consider the case of a file that requires filtering and is present in branch A
> but not in branch B. If A is the current HEAD and we checkout B then the
> following happens:
> 
> 1. ce_compare_data() opens the file
> 2.   index_fd() detects that the file requires to run a clean filter and
>      calls index_stream_convert_blob()
> 4.     index_stream_convert_blob() calls convert_to_git_filter_fd()
> 5.       convert_to_git_filter_fd() calls apply_filter() which creates a new
>          long running filter process (in case it is the first file of this kind
>          to be filtered)
> 6.       The new filter process inherits all file handles. This is the default
>          on Linux/OSX and is explicitly defined in the `CreateProcessW` call
>          in `mingw.c` on Windows.
> 7. ce_compare_data() closes the file
> 8. Git unlinks the file as it is not present in B
> 
> The unlink operation does not work on Windows because the filter process has
> still an open handle to the file. Apparently that is no problem on Linux/OSX.
> Probably because "[...] the two file descriptors share open file status flags"
> (see fork(2)).

We typically wrap the commit messages at 76 columns per row (personally,
I wrap already at 72, and it seems Junio wraps at 70).

> Fix this problem by opening files in read-cache with the `O_CLOEXEC` flag to
> ensure that the file descriptor does not remain open in a newly spawned process.
> `O_CLOEXEX` is defined as `O_NOINHERIT` on Windows. A similar fix for temporary

s/CLOEXEX/CLOEXEC/

> file handles was applied on Git for Windows already:
> https://github.com/git-for-windows/git/commit/667b8b51ec850c3e1c7d75dee69dc13c29d1f162

In response to your commit note on GitHub, I submitted this patch series
(slightly cleaned up) yesterday (and you already commented on it):

https://public-inbox.org/git/cover.1471437637.git.johannes.schindelin@gmx.de

The patch is obviously correct, and needs the patch series I submitted to
compile on Windows (this note is more for Junio's interest than a comment
on this patch).

Ciao,
Dscho
