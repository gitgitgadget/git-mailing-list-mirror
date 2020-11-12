Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF3DC2D0E4
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 21:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6152216C4
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 21:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgKLVaq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 16:30:46 -0500
Received: from siwi.pair.com ([209.68.5.199]:10302 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbgKLVaq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 16:30:46 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 0A82E3F5FB0;
        Thu, 12 Nov 2020 16:30:45 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DBF0F3F5FAF;
        Thu, 12 Nov 2020 16:30:44 -0500 (EST)
Subject: Re: [PATCH v2 07/11] transport: log received server trace2 SID
To:     Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cover.1604006121.git.steadmon@google.com>
 <cover.1604355792.git.steadmon@google.com>
 <21bdbf23f39c800b1722c54b666df7a91b5879b5.1604355792.git.steadmon@google.com>
 <xmqqpn4slt8o.fsf@gitster.c.googlers.com> <20201111225318.GG36751@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1a60fdab-a203-56d0-8dcd-43f88c29d3ff@jeffhostetler.com>
Date:   Thu, 12 Nov 2020 16:30:44 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20201111225318.GG36751@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/11/20 5:53 PM, Josh Steadmon wrote:
> On 2020.11.04 13:14, Junio C Hamano wrote:
>> Josh Steadmon <steadmon@google.com> writes:
>>
>>> When a client receives a trace2-sid capability from a protocol v0, v1,
>>> or v2 server, log the received session ID via a trace2 data event.
>>
>> Would this pose a new security threat surface?  Just wondering if we
>> want to ignore the capability if it is not enabled on our end with
>> the configuration.
>>
>> Thanks.
> 
> As Jeff pointed out, the json-writer handles string escapes, so I don't
> think we could cause any trouble with the trace2 "event" target. The
> "normal" target ignores data events, so this would not show up in a
> normal trace2 log. The "perf" target doesn't seem to do any escaping,
> but it's intended to be human readable rather than parseable, so I'm not
> sure if we need to worry there. Jeff, any thoughts?
> 

Only the "event" target prints the SID and it is JSON quoted there.

Neither the "perf" nor "normal" target print them.  The "perf" target
does print the SID "depth" parameter (which is the number of slashes
in the complete SID).

My earlier concerns were about whitespace, CL/LF and other
non-printables in the wire protocol and etc.

Jeff

