Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 061FD1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 19:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732306AbeGJTXk (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 15:23:40 -0400
Received: from p3plsmtpa11-09.prod.phx3.secureserver.net ([68.178.252.110]:46112
        "EHLO p3plsmtpa11-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732246AbeGJTXk (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Jul 2018 15:23:40 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id cyE9fN1pCXYbAcyECfVeVy; Tue, 10 Jul 2018 12:23:13 -0700
Date:   Tue, 10 Jul 2018 22:23:10 +0300
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Max Kirillov <max@max630.net>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] unpack-trees: do not fail reset because of unmerged
 skipped entry
Message-ID: <20180710192309.GB2050@jessie.local>
References: <20180615044251.10597-1-max@max630.net>
 <xmqqh8m3zurz.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh8m3zurz.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfBNQa7kLaK1V6TICbYEmRDEly0jwFDkBg6fzKPh6ARExRrXm7rFzh+/asUXb6hnkkwuu1n+dBKmuNPzqgbOCBCra9UQxeDUqNyYGVr5lh2Oogy9h0Di9
 RNYzdchl1DOkfev10hZMVMtZcxrzFy93RDZN3X4qyOulYKr13yYXFh3emtlfX9jd8K3w3FyIygZdsK1f5y0NUItUZ3GJo8Dc/A1WAxi3uTOl3sME3a8yLqiW
 Jq45piazx4NTfdoOlj6dMg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 15, 2018 at 12:58:40PM -0700, Junio C Hamano wrote:
> Do we want to verify the state after the 'hard' reset succeeds as
> well?  Things like 
> 
>  - all paths in the HEAD and all paths in the index are identical;
> 
>  - paths that do exist in the working tree are all identical to HEAD
>    version; and
> 
>  - paths that do not exist in the working tree are missing due to
>    the sparse checkout setting (iow, it is a bug if a path that is
>    outside the "sparse" setting is missing from the working tree).

I implemented the additional check, it is a bit different
literally, but should be equivalent for this case
