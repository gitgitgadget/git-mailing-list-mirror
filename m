Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F8441FF6D
	for <e@80x24.org>; Thu, 22 Dec 2016 18:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966667AbcLVSyV (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 13:54:21 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:36209 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966655AbcLVSyU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 13:54:20 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tl10B206Xz5tlH;
        Thu, 22 Dec 2016 19:54:18 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C508F1B85;
        Thu, 22 Dec 2016 19:54:17 +0100 (CET)
Subject: Re: [PATCH bw/realpath-wo-chdir] real_path: canonicalize directory
 separators in root parts
To:     Brandon Williams <bmwill@google.com>
References: <1481241494-6861-1-git-send-email-bmwill@google.com>
 <1481566615-75299-1-git-send-email-bmwill@google.com>
 <097e3e2e-f46d-b0aa-be9c-68c274c5e3dc@kdbg.org>
 <20161221223304.GA119874@google.com>
 <0c9aa347-d64e-b7d7-9b07-52d844d76252@kdbg.org>
 <20161222173301.GB119874@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, pclouds@gmail.com
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <05333505-63ca-8733-e247-a57d4a9dac4d@kdbg.org>
Date:   Thu, 22 Dec 2016 19:54:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161222173301.GB119874@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.12.2016 um 18:33 schrieb Brandon Williams:
> It took me a couple extra seconds to realize that
> offset_1st_component returns 0 with a relative path, which makes causes
> the call to get_root_part to essentially be a noop (ie nothing is
> resolved).

Yeah, I am still unsure whether it is a good idea to optimize away the 
is_absolute_path() call, because we lose the symmetry to the symlink 
case, where we cannot get rid of the call...

But I think the condition plus comment

    if (!resolved->len) {
        /* relative path; can use CWD as the initial resolved path */

makes things fairly clear.

-- Hannes

