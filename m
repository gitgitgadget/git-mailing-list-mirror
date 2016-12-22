Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34F461FF40
	for <e@80x24.org>; Thu, 22 Dec 2016 06:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757933AbcLVGHt (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 01:07:49 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:16071 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755555AbcLVGHs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 01:07:48 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tkgzj43Wkz5tlS;
        Thu, 22 Dec 2016 07:07:45 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id EBB7D2222;
        Thu, 22 Dec 2016 07:07:44 +0100 (CET)
Subject: Re: [PATCH bw/realpath-wo-chdir] real_path: canonicalize directory
 separators in root parts
To:     Brandon Williams <bmwill@google.com>
References: <1481241494-6861-1-git-send-email-bmwill@google.com>
 <1481566615-75299-1-git-send-email-bmwill@google.com>
 <097e3e2e-f46d-b0aa-be9c-68c274c5e3dc@kdbg.org>
 <20161221223304.GA119874@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, pclouds@gmail.com
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <0c9aa347-d64e-b7d7-9b07-52d844d76252@kdbg.org>
Date:   Thu, 22 Dec 2016 07:07:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161221223304.GA119874@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.12.2016 um 23:33 schrieb Brandon Williams:
> On 12/21, Johannes Sixt wrote:
>> +/* copies root part from remaining to resolved, canonicalizing it on the way */
>> +static void get_root_part(struct strbuf *resolved, struct strbuf *remaining)
>> +{
>> +	int offset = offset_1st_component(remaining->buf);
>> +
>> +	strbuf_reset(resolved);
>> +	strbuf_add(resolved, remaining->buf, offset);
>> +#ifdef GIT_WINDOWS_NATIVE
>> +	convert_slashes(resolved->buf);
>> +#endif
>
> So then the only extra cononicalization that is happening here is
> converting '\\server\share' to '//server/share'? (or 'c:\' to 'c:/')

Correct. All other directory separators are canonicalized by the primary 
function, strbuf_realpath.

-- Hannes

