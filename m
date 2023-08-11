Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AB7EB64DD
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 17:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbjHKR76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 13:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjHKR74 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 13:59:56 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8686030E5
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1691776756; x=1692381556; i=l.s.r@web.de;
 bh=XrkB39vb1uajGZAYCBCAx/0KYt/Kv7ginhwnRcTikRY=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=MMBKR1CbAUsWwF5sv4d1leJh+UkivTWnLODDPk8MdkFcNgVV8smVtGfYeGX2j/3YWNlQJiI
 0T1cJcQUxhLFNPon7/bcb/7Upfexja4bbii9p1c8oHLTGTvL75hi1Y+y24QEFys83wSutOzgN
 Y031ifcTTJFrlO0JRLfN2z6lfFTn5f6Visx8QaiYoBRVLxbfYGlgbOppv743+mgbMaBikOZwk
 FRLjntm5I8TgeyoEg37S51hDYetfUc6DN5X+mq6+Lm1ueuTX5F/M1IDG4cWrqQcX9TWg5Mwk8
 ZfglfjeeseqOHtbY46U3lnQP/r/4MeXsabvcwoqfjaVG/jgD+gdw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N947J-1pglEZ04Wd-015qxC; Fri, 11
 Aug 2023 19:59:16 +0200
Message-ID: <6a6c86cd-9545-f0b3-8a0f-71d29c0b8833@web.de>
Date:   Fri, 11 Aug 2023 19:59:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] describe: fix --no-exact-match
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <4eea7e15-6594-93e2-27b5-3d6e3c0baac6@web.de>
 <20230808212720.GA760752@coredump.intra.peff.net>
 <xmqqzg3156sy.fsf@gitster.g>
 <20230809140902.GA775795@coredump.intra.peff.net>
 <22e5a87a-cd35-9793-5b6f-6eb368fdf40e@web.de>
 <20230810004127.GD795985@coredump.intra.peff.net>
 <09f499ad-28a5-0d8b-8af6-97475bdc614b@web.de>
 <20230811151323.GF2303200@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230811151323.GF2303200@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+lRTnPp5epvGjF54MQyIZllkM0LazSSBB82pNEEEGGH/CbiAK70
 vO35vjOlGUlhgyEHEvwtx5sPtfOWaNjJSVgICwO9pGlX794EpAQHThYuDpQ/2VFA/YJ8glc
 BkBwe/1UC47Z1t0UUV0tdB4yTOgF1xN21QZ9tQ9wwXiHuIjGJqgd2Z0PGJssTrLx+dGgNra
 LMAC+tvPlEQQO1wqUnIWg==
UI-OutboundReport: notjunk:1;M01:P0:p2LSMcB/ta0=;b8W2GsikxypeQO7xnkhqHv7L5rg
 sjl9kExe70WMEJis2GpjPRyRC3qttmcgmWbUzXw4mXiIpC6U3hINlUTh4mD073Pv7U6llE4SJ
 WG5khelzqhAfreK8tOub2qFU+swFhGLUf1zUqnurCUk7S94u2W5X82vfwNjGwH0N3OyfnABXV
 p1XSujN44we+uymfBGnLXXb8BPhIWsUP2+FRhaHjIZFG0HWKyluTTJCspEzguAL2M9G6zhoiD
 5S5EDIvk80Zm9S53+3CIW+sgHF/q+pTvWZeP32eNd0kIP85+wIf3v8UQLuo/XVIMQZGiLRZfA
 u+T9RrcwMbo5kMoFIgYYinXvNOlkc8RxvaquSEXxd0sZuqdPW36wknUkCsyapMtmSwMyq5aWg
 mz4q4NEQM7cL/cIPeqDYBYbEG1qB0ghPNJFjlmnfLGZDZiBWvN3SltyEN9yJ/Ahy9C2+/WEPq
 r3VJgfmEBebmH68PPBuBnNARThJyrQROvmIWG9AoRxcMOBmqaVw0JzeLtM8C9AgkqPvwtmhwL
 9mHro44SHzMzR667K1dtY4y9hUr+rdNWVCXE2xlFY/dV5w62Exys0E/8f6ANn0wc5DeIXwlhu
 YWnih9xYflv5sULEDFNbEhwgAkLIu3YiUfLv0qRh7pP4WInthKKMsBTksr6KXvtf1bpVn5ZoN
 Go6YNDqc0UxScJfSqEeGSL/i0aQr2UpzAM/qYlJixBD6fQTjLUWWIv7hzDFD70e3x84ak9ezk
 FBU8nq3I1g1lGPwxW/ukL8pDrBTvP03D0sgYVu51ElCqiCzitlN8NZX9jUgkkEqWysNuVeyOa
 Q+Pqr6ewwBDL6ZvlZAWNoDHUQ5PGnYrLSf0NwB4uruT6JgzCNBbRjyXIldUSjeFuElRhNGxpG
 a0HViismyLp48SpTzt3UDKTcteHThwTvhKYq6Ng/5nuL9lNBxAtqyKzwEhLAZfs7irdew6BK8
 pY8smLrpzSnz2m+nRWkuSkCYu/o=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.08.23 um 17:13 schrieb Jeff King:
> On Thu, Aug 10, 2023 at 09:10:33PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> +#define DEFINE_PARSE_OPT_CB(name)				\
>> +static inline int name ## __void(const struct option *opt,	\
>> +				 const char *arg, int unset)	\
>> +{								\
>> +	return name(opt, arg, unset, opt->value);		\
>> +}								\
>> +struct option
>
> BTW, I wondered what this extra "struct option" was doing. I guess it is
> there to soak up the semi-colon of:
>
>   DEFINE_PARSE_OPT_CB(foo);
>
> with a noop declaration. Both clever and gross. :)

You guessed correctly.  It was short and handy..

A production-grade patch would use the function header.

Ren=C3=A9
