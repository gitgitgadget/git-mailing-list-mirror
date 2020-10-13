Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAA6C41604
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 09:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4932B206DD
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 09:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbgJNJYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730801AbgJNJUK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:10 -0400
Received: from giant.haxx.se (www.haxx.se [IPv6:2a00:1a28:1200:9::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52F2C061755
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 14:17:17 -0700 (PDT)
Received: from giant.haxx.se (mail [127.0.0.1])
        by giant.haxx.se (8.15.2/8.15.2/Debian-4) with ESMTPS id 09DLH0g8004983
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Oct 2020 23:17:00 +0200
Received: from localhost (dast@localhost)
        by giant.haxx.se (8.15.2/8.15.2/Submit) with ESMTP id 09DLGw4u004963;
        Tue, 13 Oct 2020 23:16:59 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
Date:   Tue, 13 Oct 2020 23:16:58 +0200 (CEST)
From:   Daniel Stenberg <daniel@haxx.se>
X-X-Sender: dast@giant.haxx.se
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Sean McAllister <smcallis@google.com>, git@vger.kernel.org,
        masayasuzuki@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 2/3] replace CURLOPT_FILE With CURLOPT_WRITEDATA
In-Reply-To: <20201013205841.GA3678071@coredump.intra.peff.net>
Message-ID: <alpine.DEB.2.20.2010132309250.7554@tvnag.unkk.fr>
References: <20201013191729.2524700-1-smcallis@google.com> <20201013191729.2524700-2-smcallis@google.com> <xmqq7drtkg6o.fsf@gitster.c.googlers.com> <20201013205841.GA3678071@coredump.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 13 Oct 2020, Jeff King wrote:

Let me just inject myself here and comment on two curl things.

>  - when is _FILE going away (or has it already in some versions)?

It will be kept around *at least* for as long as libcurl supports the version 
7 API: for the forseeable future. Posssibly decades.

>  - when did _WRITEDATA appear?

All curl symbols ever introduced are documented clearly in which version they 
appeared. See:

   https://curl.haxx.se/libcurl/c/symbols-in-versions.html

To map the version numbers to release dates, this second table comes handy:

   https://curl.haxx.se/docs/releases.html

CURLOPT_WRITEDATA was added in curl 7.9.7, shipped on May 10 2002.

In the curl project we often see users use *very* old versions but 18 years is 
longer than even the most conservative users I've seen...

-- 

  / daniel.haxx.se (with my curl hat on)
