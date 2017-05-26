Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A226209FC
	for <e@80x24.org>; Fri, 26 May 2017 06:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033844AbdEZGqv (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 02:46:51 -0400
Received: from mout.web.de ([217.72.192.78]:55769 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763310AbdEZGqu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 02:46:50 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LwYs7-1e0e6q0dp9-018MFM; Fri, 26
 May 2017 08:46:47 +0200
Subject: Re: Bug report: Corrupt pack file after committing a large file (>4
 GB?)
To:     Yu-Hsuan Chen <davidchen9568@gmail.com>, git@vger.kernel.org
References: <CACX31FFFk1aSn+X9VO6PkCofXPE1fjB6pugLcm+srjXFDJkmyg@mail.gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <580a63cd-890a-9c59-9cef-a08a059c2af2@web.de>
Date:   Fri, 26 May 2017 08:46:46 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CACX31FFFk1aSn+X9VO6PkCofXPE1fjB6pugLcm+srjXFDJkmyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:magv4PpeW8eIae6DWIsTfuCJZtkH3+ZASkWNXl8OGPufPHBfSOg
 do9OmDEbZicT9W6ALJC07IBmKN2CSMvtO2OWdI1t6uKZadV0jmY8+NEQXy12nM1ado54m6J
 E9fDDAyxmD0X8L+6jCs6giLu82zHcKanLytDfioEsqfmtBqIhlQPv8vdjQIMFWFRtXHGpbZ
 YceQSH55LxC8lwgKw4xbw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mvQTSjMZv6Y=:8eVGVw4Ou1gb7bivcu3lH5
 5gi8ajaRsiBIE/BQezIg0MDy9Im8tAgSvqQd9XQzo16156gIgN25DMgl1tcNB8u1EmZlHsb08
 w6MutRwwzZ6njjzTXWqZy/G8vl+uHlmXDGjd4Uc2NrdD9xtmgRFaN2H+5zK/7hQRmytCqH1nc
 LwrQV9X53Fi2vEN184htTry2LNFHqBBKV10QtqaNGtPIkP2hdbXMTg61A4Imd2fEfcAVN0GYv
 KcJZzhriiSKNDg1urfMSgWpZvL5MRvEd5tRhIZviF019Zr5eLyc5scC/kwFnfRhP39TnCsVHc
 8fkiKzOf32asZQkKgY6UyMQ3cCrL7wvz4J7LvY4xoiYxFjyk/kPmjJSQXLj2jCcg9U/8b8B4Q
 Z/E4UthtQM7AdwexBOJoGv4gZZI8q7sIJ/aZPhFUunY1F6/lDD4/ybstCh7v/Jg3oaBCvQDcJ
 X9hWhJdJZ565I3SC6PTeOCRVPJ0S4Kziqd9eBEYsQHveZU++8amFuqdLHPARRbB2MARQz7260
 qHxHYsSQk8EtSnPPO33y7hrkd5aqn2NpjhN3EHHOVEQuvfXxESsXtTDhjdG8YvvkzvEUPFNsb
 R6m1ozeZoS7nS6dM0ceVWO+rfHwJmX7HJ5XYDqm0lfNKGMqQn4Ilsvgf6HNm8A7SImLotRcK5
 WBTTpvdpTaPT7ZVEsmVJzmDc+H/5tJw1kMzPtBA0WULLfPloi770XYfdn5NeTNiFBnR7Efx8o
 m4tmJTCbD7OUI7hKZvME09O+QcForn1sa/MA9mb5CQrhwHslF6cu9kN9JVBmL9YkkPqrFZ2cg
 xj8dXeO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-05-26 07:51, Yu-Hsuan Chen wrote:
> Dear maintainer,
> 
> There is a bug where committing a large file corrupts the pack file in
> Windows. Steps to recreate are:
> 
> 1. git init
> 2. stage and commit a file larger than 4 GB (not entirely sure about this size)
> 3. git checkout -f
> 
> The file checked out is much smaller than the original file size.
> 
> This behavior is surprising. If git does not support large files, I
> would at least expect an error message when staging or committing. I
> have post a question on StackOverflow regrading this issue, and has
> been confirmed by another user. (question id: 44022897)
> 
> Best regards,
> 
> David Chen
> 
Issues for Git for Windows should, in general, be reported here:
https://github.com/git-for-windows/git/

After 2 seconds of searching, we can find that the 4Gb problem
has already been reported:
https://github.com/git-for-windows/git/issues/1063

And, to my knowledge, it has not been fixed, since it is a
lot of effort to replace the "long" (or unsigned long) in the
Git code base with a better data type.

In other words, thanks for reminding us, more help is needed.



