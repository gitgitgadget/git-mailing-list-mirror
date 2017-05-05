Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D51AD207D6
	for <e@80x24.org>; Fri,  5 May 2017 01:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbdEEBM1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 21:12:27 -0400
Received: from avasout07.plus.net ([84.93.230.235]:42272 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbdEEBM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 21:12:26 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id GRCP1v0021keHif01RCQFv; Fri, 05 May 2017 02:12:24 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=HP2zLslv c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=1EZpJe-wV8nAhiWODaoA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: What's cooking in git.git (May 2017, #01; Mon, 1)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Message-ID: <4fe7bb75-2d4d-37b2-910c-e63cfdfa5282@ramsayjones.plus.com>
Date:   Fri, 5 May 2017 02:12:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 01/05/17 06:35, Junio C Hamano wrote:
> 
> * nd/fopen-errors (2017-04-23) 17 commits
>  - warn_failure_to_open_read_optional_path(): a new helper
>  - t1308: add a test case on open a config directory
>  - config.c: handle error on failing to fopen()
>  - xdiff-interface.c: report errno on failure to stat() or fopen()
>  - wt-status.c: report error on failure to fopen()
>  - server-info: report error on failure to fopen()
>  - sequencer.c: report error on failure to fopen()
>  - rerere.c: report correct errno
>  - rerere.c: report error on failure to fopen()
>  - remote.c: report error on failure to fopen()
>  - commit.c: report error on failure to fopen() the graft file
>  - log: report errno on failure to fopen() a file
>  - clone: use xfopen() instead of fopen()
>  - blame: report error on open if graft_file is a directory
>  - bisect: report on fopen() error
>  - config.mak.uname: set FREAD_READS_DIRECTORIES for Linux and FreeBSD
>  - git_fopen: fix a sparse 'not declared' warning
> 
>  We often try to open a file for reading whose existence is
>  optional, and silently ignore errors from open/fopen; report such
>  errors if they are not due to missing files.
> 
>  Expecting a reroll that would be much simplified thanks to a higher
>  level helper.

Since this "What's cooking", this has been re-rolled, but the
"git_fopen: fix a sparse 'not declared' warning" patch has been
dropped, so I'm seeing the sparse warning again.

Also, this series removes every external caller of the
'warn_on_inaccessible()' function, so this could be marked
static in wrapper.c. (I would move the definition of that
function above/before warn_on_fopen_errors(), in order not
to require a forward declaration).

ATB,
Ramsay Jones


