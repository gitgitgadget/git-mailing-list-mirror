Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFD801F4F8
	for <e@80x24.org>; Mon, 10 Oct 2016 10:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbcJJKdI (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 06:33:08 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:44427 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751401AbcJJKdH (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Oct 2016 06:33:07 -0400
X-AuditID: 1207440f-1f3ff700000009a9-bf-57fb6e591aaa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 94.6B.02473.95E6BF75; Mon, 10 Oct 2016 06:32:59 -0400 (EDT)
Received: from [192.168.69.190] (p57906111.dip0.t-ipconnect.de [87.144.97.17])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u9AAWtH2011274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Mon, 10 Oct 2016 06:32:56 -0400
Subject: Re: [PATCH v2 1/2] files_read_raw_ref: avoid infinite loop on broken
 symlinks
To:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
References: <20161006164723.ocg2nbgtulpjcksp@sigill.intra.peff.net>
 <20161006164825.otms5ovz2vzanimw@sigill.intra.peff.net>
 <1c39b371-eb41-05d9-3c48-bd41764c9c9a@kdbg.org>
 <20161006194108.qy7qpg6qpodpeacx@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <b82fe6e6-8cb5-bcfa-7cd9-0ad065f0fe6f@alum.mit.edu>
Date:   Mon, 10 Oct 2016 12:32:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161006194108.qy7qpg6qpodpeacx@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsUixO6iqBud9zvcYMMfLYuuK91MFk/m3mW2
        +NHSw+zA7PHwVRe7x7PePYwenzfJBTBHcdmkpOZklqUW6dslcGUseHSZqeAmY8W1Xe9ZGxjX
        MXYxcnBICJhIvHyb3sXIxSEkcJlR4mHnYjYI5xyTROed9UwgRcICERJNDzi7GDk5RASsJSZ/
        ncwCUfOSUeLG4XY2kASzgLjEurnn2UFsNgFdiUU9zUwgNq+AvcTXv+vBbBYBVYmph+aygNii
        AiESvzdOZ4GoEZQ4OfMJmM0p4CJxcGMjC8RMdYk/8y4xQ9jyEtvfzmGewMg/C0nLLCRls5CU
        LWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6KXm1mil5pSuokREqL8Oxi71sscYhTgYFTi
        4X1R+StciDWxrLgy9xCjJAeTkihv4okf4UJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeC1zfocL
        8aYkVlalFuXDpKQ5WJTEedWXqPsJCaQnlqRmp6YWpBbBZGU4OJQkeKVygRoFi1LTUyvSMnNK
        ENJMHJwgw3mAhguC1PAWFyTmFmemQ+RPMepyLPhxey2TEEtefl6qlDjvc5ALBECKMkrz4ObA
        UssrRnGgt4R5/4NU8QDTEtykV0BLmICWsCz+AbKkJBEhJdXAuIp/5jPPV68EZvVd9Fd8M3W9
        w4qZTQHdOZ+OrrUvPHFae+vz1OO5Rpl5i0RqndR5dx0T2nbKRibn+5binc9Tlt89uEerRfLV
        65WvtUV0tPZucEzn/D3Fdk280RnvaeUvmW61e72UnFPiX3x1+vdLe9aeUZn+bte2m2cVNtxm
        zHdkUYmZmvO/j0GJpTgj0VCLuag4EQAOxdlwCAMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/06/2016 09:41 PM, Jeff King wrote:
> [...]
> Subject: files_read_raw_ref: avoid infinite loop on broken symlinks
> [...]

This patch is

Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>

Michael

