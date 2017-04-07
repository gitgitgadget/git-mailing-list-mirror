Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 828DB20966
	for <e@80x24.org>; Fri,  7 Apr 2017 08:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752971AbdDGIk7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 04:40:59 -0400
Received: from 5.itsy.de ([188.40.84.14]:55526 "EHLO 5.itsy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751997AbdDGIk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 04:40:56 -0400
Received: from [192.168.0.13] (84-72-0-73.dclient.hispeed.ch [84.72.0.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 5.itsy.de (Postfix) with ESMTPSA id 0BD2D64474
        for <git@vger.kernel.org>; Fri,  7 Apr 2017 10:40:54 +0200 (CEST)
Subject: Re: problem with backslash in directory name
References: <20170407063057.yjbqavu4uiipslpc@sigill.intra.peff.net>
To:     git@vger.kernel.org
From:   Joachim Durchholz <jo@durchholz.org>
Message-ID: <0a51432b-b9c9-32c5-c064-5fc9aaddebc7@durchholz.org>
Date:   Fri, 7 Apr 2017 10:40:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170407063057.yjbqavu4uiipslpc@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.04.2017 um 08:30 schrieb Jeff King:
> I also don't know how some of those loops would cope with
> a submodule name that needed quoting).

"git submodule add" worked fine with most of the following names:

     "sub"
     # potentially confusing the shell
     "sub with blanks",
     "sub with\nnewline",
     "sub with'single quote",
     "sub with\"double quote",
     "sub with\\backslash",
     "sub with\bbackspace",
     "sub with\thorizontal tab",
     # potentially confusing git's configuration format
     "sub with #",
     "sub with ="

(That's Python 3 literals in case somebody is wondering. I'm using 
Python to unit test a shell script, just so I can catch this sort of 
stuff...)
