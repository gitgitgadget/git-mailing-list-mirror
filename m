Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A0CC433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 15:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbhLAPxo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 10:53:44 -0500
Received: from siwi.pair.com ([209.68.5.199]:23615 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351157AbhLAPww (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 10:52:52 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 244CE3F40DA;
        Wed,  1 Dec 2021 10:49:30 -0500 (EST)
Received: from WIN10-A.eucom.mil (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D42E53F4098;
        Wed,  1 Dec 2021 10:49:29 -0500 (EST)
Subject: Re: [PATCH] trace2: increment event format version
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>
References: <ebc4d9a6960f0350772c14981ef211876f29d0fa.1636669891.git.steadmon@google.com>
 <xmqqh7cijnwx.fsf@gitster.g> <YY2h5lO90vo3Dy42@google.com>
 <xmqqczn6jlvu.fsf@gitster.g> <211112.867ddduhly.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9ce9c989-5a8c-1d5c-cc7e-9447760ed110@jeffhostetler.com>
Date:   Wed, 1 Dec 2021 10:49:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <211112.867ddduhly.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/12/21 5:33 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Nov 11 2021, Junio C Hamano wrote:
> 
>> Josh Steadmon <steadmon@google.com> writes:
>>
>>> On 2021.11.11 15:03, Junio C Hamano wrote:
>>>> Josh Steadmon <steadmon@google.com> writes:
>>>>
>>>>> In 64bc752 (trace2: add trace2_child_ready() to report on background
>>>>> children, 2021-09-20), we added a new "child_ready" event. In
>>>>> Documentation/technical/api-trace2.txt, we promise that adding a new
>>>>> event type will result in incrementing the trace2 event format version
>>>>> number, but this was not done. Correct this in code & docs.
>>>>>
...
> 
> On the field itself I also wonder if it's useful at all. I'd think
> anyone implementing a parser for the format would dispatch to a lookup
> handling known keys, so having a version indicating "new keys here"
> seems rather useless.
> 

That may be true, but it is easier to have a version number and
allow parsers to ignore it, than it is to not have a version number
and at some point in the future require parsers try to figure it
out. IMHO.

So far we've only added new event types (cmd_ancestry and child_ready)
and everything is in regular JSON forms, so parsing and dispatching
is relatively easy and the version number is not really needed.
But, if in the future we decide to change the contents within one of
those events, then the version number may be significant.

Thanks,
Jeff

