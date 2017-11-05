Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D664D20281
	for <e@80x24.org>; Sun,  5 Nov 2017 16:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751069AbdKEQsL (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 11:48:11 -0500
Received: from mout.web.de ([212.227.15.4]:56703 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750785AbdKEQsK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 11:48:10 -0500
Received: from [192.168.178.36] ([91.20.50.17]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKr7w-1eBO5O2kca-0001g6; Sun, 05
 Nov 2017 17:47:50 +0100
Subject: Re: [PATCH 1/3] notes: move hex_to_bytes() to hex.c and export it
To:     Kevin Daudt <me@ikke.info>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Thomas Gummerer <t.gummerer@gmail.com>
References: <508b1b3f-6b55-eee8-110a-c17d572ec27a@web.de>
 <20171105025647.GB23275@alpha.vpn.ikke.info>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <71257adb-56c0-2e13-c0b1-a7ee4b084207@web.de>
Date:   Sun, 5 Nov 2017 17:47:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171105025647.GB23275@alpha.vpn.ikke.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:FzJxGFLHE0teecmLAejco5avIcmIyKIeo5Rh1hIRImkaaH4/63h
 RCcZAqMxUCQIOaoJzvQyFETOq6lLDVvPW6z1DQopNlfb6qMptgTVe47xvG6qGtgXS4jb7mI
 JOkG2lftrqtyYSF8EiiQ2yxNerjlA6hSHFqY7OuTrlijpfFBBD9YVO+YjXUcN2bO0H4MGJr
 BcweNfE4g7bC48D/p1kyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qPhf5AO09bM=:TjwkHYgDBFiM8ZCaLdP8KZ
 b45onfLuoxlZgB+rG8lt/UYL/jWDspIBAOt/XFpCU/nYV87IoczYjLozpkRX6dSLNA+9Qcpde
 co+tCANiue/XDKLNK17j74bCCvuNbkMY4PZE6vbdCMsGB/LwTaCXUFqQfBvPXlzqTqUxm6XpX
 YXFpuhYYUpvP0SW41JU//A63nGfQGH9WXAvEyGBgVPOfmCBY8L3YoUDL8hzq79UkKH7GV15aK
 z/DrIInlRTGl+aNvYWKF93A2I6qMpF3auEoIwIQwByGGZBrok3aRXd3T7TXIp8Tpg3gKlwOPB
 SUdujq1OTzXaFffKKKHTJgYXpzcYXB5gHuJn80RdTz1ncang4J7lM7+ULGo5fuP8dPOy5+2pZ
 7LbShz+hOq2PAjOzfd3LDtsNklqDpjkQUXU2jNWVruBXiRUJdrreljkwTvquSj0TgK9QZ3e1A
 oqLyO/77/GTSBFxUv4z04z3UY0pLUpd5GYzxi0qh6SVIXhSk+/iBkr1CsVl/FVtvUOxNSFgAQ
 86l2gyR4K0+YnJTwtJE4pRx5tYM3HeiLg32hwOmjCIqkjPhjsv8vyS5jOPZidTQUTPJNsciYC
 nx1PjgjXcJ8w7sYYZtFvjboQiPua2RArAoV4XgFyLCqgP/UIJeKUcREg75taS3RHOkOP0XVeV
 cPF5FI97IEMkdWFK0ABeO5Pqxi08IYlfe4/LvHzfxe4AWPMvfgGtexCaoo+iBRmdpkMrs/p2j
 HOfml8lXZ+DIHFzEK/SXRZ8LFjNWy1aSCCrucZg+fRU/Jpa/oY8Hpat8zqiKUdOniDx4SEbhg
 VJaJW2o3hJUSQLYP3KzrAfOa10rPSujedS3h3qmcCu5MA3sLr0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.11.2017 um 03:56 schrieb Kevin Daudt:
> On Tue, Oct 31, 2017 at 02:46:49PM +0100, René Scharfe wrote:
>> Make the function for converting pairs of hexadecimal digits to binary
>> available to other call sites.
>>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>>   cache.h |  7 +++++++
>>   hex.c   | 12 ++++++++++++
>>   notes.c | 17 -----------------
>>   3 files changed, 19 insertions(+), 17 deletions(-)
>>
>> diff --git a/cache.h b/cache.h
>> index 6440e2bf21..f06bfbaf32 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -1317,6 +1317,13 @@ extern int set_disambiguate_hint_config(const char *var, const char *value);
>>   extern int get_sha1_hex(const char *hex, unsigned char *sha1);
>>   extern int get_oid_hex(const char *hex, struct object_id *sha1);
>>   
>> +/*
>> + * Read `len` pairs of hexadecimal digits from `hex` and write the
>> + * values to `binary` as `len` bytes. Return 0 on success, or -1 if
> 
> Is it correct to call the result binary? I would say that it's the value
> that gets stored. To me, this value does not really have a base.

Here's the full context:

  /*
   * Read `len` pairs of hexadecimal digits from `hex` and write the
   * values to `binary` as `len` bytes. Return 0 on success, or -1 if
   * the input does not consist of hex digits).
   */
  extern int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);

The patch moves the comment verbatim.  Words in backticks (`binary`,
`hex`, `len`) are parameter names.

The function converts pairs of hexadecimal digits (base 16, ASCII
encoded) to bytes (base 256).  A byte can be seen as an array of bits;
thus the output is also binary (base 2) without requiring further
conversion.

Calling the variable "binary" may seem unspecific, but makes sense in
the context of this function.

Does any of that help?

Thanks,
René
