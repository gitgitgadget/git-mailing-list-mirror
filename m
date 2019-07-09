Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BC551F461
	for <e@80x24.org>; Tue,  9 Jul 2019 21:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfGIVnN (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 17:43:13 -0400
Received: from elephants.elehost.com ([216.66.27.132]:17199 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGIVnN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 17:43:13 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x69LhAep002669
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Tue, 9 Jul 2019 17:43:11 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [Question] Diff text filters and git add
Date:   Tue, 9 Jul 2019 17:43:05 -0400
Message-ID: <009201d5369f$4da5d030$e8f17090$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        boundary="----=_NextPart_000_007F_01D5367D.78887B80";
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQF+i6UiLpcYRbldYfg95cN6Q+43cw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I am trying to do something a bit strange and wonder about the best way to
go. I have a text filter that presents content of very special binary file
formats using textconv. What I am wondering is whether using the textconv
mechanism is sufficient to have git calculate the file signature or whether
I need to use an external diff engine, so that git add behaves in a stable
manner (i.e., does git internally use the textconv mechanism for evaluating
whether a file changed or whether the external diff engine is required, or
whether this is even possible at all).

The basic use case is that there is a timestamp embedded in the binary file
that I want to forever ignore when committing. I only need this done on one
specific machine, which is under Jenkins control, so it's not something
developers would deal with at all (so the filter config is in one place).
When the binary generator runs, if the two file images are "similar enough"
(as in: the same except for the generated timestamp, and a couple of other
annoying bits of metadata), I want git to think that they are the same in an
automated way, so that when I am constructing commits, I do not want what
would be considered a duplicate of what is essentially the same file.

Sadly, I cannot modify the generator, so I'm stuck with the files being
wonky. I also cannot run the generator anywhere downstream, so doing so on
the deployment engine is also not an option (don't ask, the generator is
limited on where it can be run). Suggestions are welcome, please.

Thanks,
Randall



