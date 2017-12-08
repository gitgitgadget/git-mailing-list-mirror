Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EB721FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 20:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbdLHUKg (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 15:10:36 -0500
Received: from mout.web.de ([217.72.192.78]:58685 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750741AbdLHUKf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 15:10:35 -0500
Received: from [192.168.178.36] ([91.20.50.52]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MDxGV-1eHabj2sAB-00HR4c; Fri, 08
 Dec 2017 21:10:28 +0100
Subject: Re: [PATCH] fmt-merge-msg: avoid leaking strbuf in shortlog()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
References: <b2238da3-9eba-1521-f4ca-3b805f103555@web.de>
 <20171207212735.GD12850@sigill.intra.peff.net>
 <e1daa2b6-004b-ad66-b84d-84fa70a44baf@web.de>
 <xmqq609h83gg.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <20ca4c68-1101-0309-966e-cd0615931f1e@web.de>
Date:   Fri, 8 Dec 2017 21:10:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <xmqq609h83gg.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:5+xGXZr0a1l8EIDbtsAD7wiqtN2Dwg5BaoFNZFTkdXF7HV0wXbU
 O+mV0dvixNWPKb7+qQ0gDZSG5NDEmFiSrZQ65drbMeDqMyfAzMvngPa4yFcXcC9D0MULY8Q
 zWiNgKKjoqu8GRHVAO0p0tHnoZxId2OsCGOIGjVfuYuCHaGRRMvnRf4RIHjgRykdP1HMYtz
 NahzCHwVivTsePj/b9COw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xiSKTwxDbHU=:ZpC58wa2ZVY3pmf01IkPlU
 QoCSA8mG39fD2WuabnL1QLakKmvPRyLgQyzzdx51mMdmBd5gSRV3opKyYGpunCqjrleDk9lGo
 XgSNtrSqlIVbASwUqE8YT1jiTNr6+IanlWWcPPzR9rWjO9XefxHvVD4V1I9y2Il9pyudVQwSY
 WLMJ01oJJPKTFO9U7UGkjmN9bEe4sBIc0uPyKF4ziN47xjwQkddbvlVU+tXoUQScsGG+9qSCV
 88EX5ORvtoxHzbDp6k66uRTL62syBnBZi52NabnQ5EISwbQ0D73681TJYmWPEvNnA1PMjLHZn
 2s9grHmNgqZ+WnsT/9FwkEqZo3i4yoRN/m7OexW9Ehgx4Pk9KGV3dZ3hlg3YaEkcFzRWD8LJO
 oEulN5DM83ZeTQJd9RfmNMmDgxJxEhIQ9yi48WyVLuQxYsdIAvMcHywuQzDrdf+N8ixCDtDf3
 9ZSzjiwb1Rj82eBRFnNnQY7zUNPks06upCVsKpodvw9UL/vUPSVrMMyToHGrLrhT8798cxvnP
 65a9/khKrEgPbBL9RHZl+wo17nx2sax7MByBXQMUKXJltdSoHB1EPgIj01/fcKUp7uBxJvvP3
 ozm5GlCjca72QdVvamW5Yc8WrqKWiFYVuG8fGe9yj6f8ysPzqmEeMCMJoPWajVRpy9n9ijkA5
 iIWSQAlYw58AtuDTwH2DCXoTWxhArVS07u/iJ4JcJ0uCtB/bKCC9Xqr/vBwUgbScFSdE1shzQ
 S2ey12DTb7SrdckNBQCTXWsafe+vCfx7T2c3Ff6AXR6DKX3Nl2Vg1e/TC5oTkuJOHmoBKmQCm
 OrLFoC7v1f9/xL/ZZYHOdAlve6BP2FcW7qL8csgNHHmdcMHsXs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.12.2017 um 19:44 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> Am 07.12.2017 um 22:27 schrieb Jeff King:
>>> Grepping for "list_append.*detach" shows a few other possible cases in
>>> transport-helper.c, which I think are leaks.
>>
>> -- >8 --
>> Subject: [PATCH] transport-helper: plug strbuf and string_list leaks
>>
>> Transfer ownership of detached strbufs to string_lists of the
>> duplicating variety by calling string_list_append_nodup() instead of
>> string_list_append() to avoid duplicating and then leaking the buffer.
>>
>> While at it make sure to release the string_list when done;
>> push_refs_with_export() already does that.
>>
>> Reported-by: Jeff King <peff@peff.net>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>>   transport-helper.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/transport-helper.c b/transport-helper.c
>> index bf05a2dcf1..f682e7c534 100644
>> --- a/transport-helper.c
>> +++ b/transport-helper.c
>> @@ -882,7 +882,8 @@ static int push_refs_with_push(struct transport *transport,
>>   			struct strbuf cas = STRBUF_INIT;
>>   			strbuf_addf(&cas, "%s:%s",
>>   				    ref->name, oid_to_hex(&ref->old_oid_expect));
>> -			string_list_append(&cas_options, strbuf_detach(&cas, NULL));
>> +			string_list_append_nodup(&cas_options,
>> +						 strbuf_detach(&cas, NULL));
>>   		}
>>   	}
>>   	if (buf.len == 0) {
>> @@ -897,6 +898,7 @@ static int push_refs_with_push(struct transport *transport,
>>   	strbuf_addch(&buf, '\n');
>>   	sendline(data, &buf);
>>   	strbuf_release(&buf);
>> +	string_list_release(&cas_options, 0);
> 
> There is no such function; you meant _clear() perhaps?

Yes, of course, I'm sorry.  Not sure what happened there. O_o

René
