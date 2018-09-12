Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4130B1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 02:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeILH1O (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 03:27:14 -0400
Received: from avasout07.plus.net ([84.93.230.235]:43989 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbeILH1O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 03:27:14 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id zupyf5ychjlDzzupzfzLI2; Wed, 12 Sep 2018 03:25:03 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrdsBH9C c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=1Jo9T6vW-OJQvGKjh7IA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/9] string-list: add string_list_{pop, last} functions
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20180911234951.14129-1-sbeller@google.com>
 <20180911234951.14129-2-sbeller@google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <d6668ef0-2a9c-d591-fa4c-b8777576f334@ramsayjones.plus.com>
Date:   Wed, 12 Sep 2018 03:24:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911234951.14129-2-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLqKnqtsXrIFECx3vU24+PfsuC2UecAeOBPulg7Cfb1fZJ/2vnUmLqdDzShP/RHgJ/Scr9b3jfq6541SLA2GGi/cu7pHMarlz5uU0CKag1BMeOAPThqx
 2/KBusSUEWvn37QST8Gjsd3hoMaLNfh7iqVwlLmTAJduzK1ObRIocEhhapxdrAsA5Ruggu/4Ho7gbg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/09/18 00:49, Stefan Beller wrote:
> Add a few functions to allow a string-list to be used as a stack:
> 
>  - string_list_last() lets a caller peek the string_list_item at the
>    end of the string list.  The caller needs to be aware that it is
>    borrowing a pointer, which can become invalid if/when the
>    string_list is resized.
> 
>  - string_list_pop() removes the string_list_item at the end of
>    the string list.
> 
>  - _pop usually has a friend _push. This role is taken by
>     string_list_append already, as they are not symmetrical
>     in our code base: _append returns the pointer, such that
>     adding a util is easy, but _pop doesn't return such a pointer.
> 
> You can use them in this pattern:
> 
>     while (list.nr) {
>         struct string_list_item *item = string_list_last(&list);
> 
>         work_on(item);
>         string_list_pop(&list);

string_list_pop() takes a second int parameter (free_util).

ATB,
Ramsay Jones

