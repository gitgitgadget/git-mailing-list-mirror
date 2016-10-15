Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06FDF20988
	for <e@80x24.org>; Sat, 15 Oct 2016 17:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753007AbcJORkc (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Oct 2016 13:40:32 -0400
Received: from mout.web.de ([212.227.15.14]:53635 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751519AbcJORkb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2016 13:40:31 -0400
Received: from birne10.local ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MLPMI-1buuiB38fC-000YVd; Sat, 15 Oct 2016 19:40:17
 +0200
Subject: Re: [PATCH v3 07/25] sequencer: completely revamp the "todo" script
 parsing
To:     Jeff King <peff@peff.net>
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
 <cover.1476120229.git.johannes.schindelin@gmx.de>
 <4e73ba3e8c1700259ffcc3224d1f66e6a760142d.1476120229.git.johannes.schindelin@gmx.de>
 <933b13d6-5f24-c03a-a1a0-712ceb8ddcc8@web.de>
 <20161015171926.qgtvrjcaqwb436hx@sigill.intra.peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <d9f4f658-94fb-cb9e-7da8-3a2fac120a9e@web.de>
Date:   Sat, 15 Oct 2016 19:40:15 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
 Gecko/20100101 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161015171926.qgtvrjcaqwb436hx@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:R6qI19zoDJDwnILXq93LpITT9o2kOyQKiwV9WH/CrKQ+DdX51L2
 W/GSeQYJuG2CkonA1B9oK3LqVCnodYcmwK3B8zdjLgle1huEMqmOqtOV8Pq8tnYNFCfFbJ9
 SKqhejoQjPTIQFIkmNUODfMj0pJnLjGXs/vgj3gkONlrHz9RQvLbv3604DCdExadLFAiph/
 6zhczAxSkO1eiZyzpWybQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+fpeCgoduig=:3yf+MG2Ks8HU+X9d39v6Af
 m4NySJB9lQWagEPVV0r/CKOLHABh0V7DjvOhTedJyzEJk0HG7x7dzy73NyTcMxSej0Qd4Tr9Q
 tFdClAYQc/XLVDxlq3tEISzjlNQpRDJ5y7W1DYVvt3RHmN5C8hEFub1l1pYne66/mjpHjFO/j
 ZTVYk3OAnfh5aBdPl9eshrtVeIGu+aWZkVWqIStYFgqOLDVaQPwGX4k9ZWTSgNnhcRNqCx07J
 K/ppuubXIXSQWaFfq/stWEGOOCdW/cVcyPLvp6Z36zHipw9Btia2/p2jP20jq809dh36j0yXN
 EZnobjVf/cKiiF/lj3cZk3Kt1w3ugcQNPBzhRAfn54Qg6c1YQP2hJlWLrOec3yQSzJdeGqc4G
 sikmuphMrqgrbqP++tvbYc3aUX6bSIo3p+FTcWy+1BiiSETBtrxVDDEcFtNcBrYa9Dvdu3TCU
 B03YddKDgEt3HN7y55EF8EHEvvIY5QevFiHL61HW52Z489SLVz6jQMpD91fSMQnEKxqC5BXJ9
 P6mceHRK4ffdmYIigjJKyaFrLm6n3vAhcZBR3zJjUfNR8DSoAWfyES2SrR5mtOUlwozRM9Igw
 jo2WQ5fhDORI4A0j7HsIbVTBEXml/RqkGFAqY1MAKAaLzwoaso4Y8XhdtBxgB/YCasWT7dc7i
 4CE1r/tERnpwLfVN9YZKheDfFdsK6nqIXiUcwsOmcrbcaktULQLHnEvO+Fj/qCMSt/crTccsi
 HSBtPW79psxNenfMsvor9aVWWRq12RENsV+CnWGR0QHhZq0gHARJqGk5G7W1LR5S5s3jEHGCA
 8i04x+m
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15.10.16 19:19, Jeff King wrote:
> On Sat, Oct 15, 2016 at 07:03:46PM +0200, Torsten Bögershausen wrote:
> 
>> sequencer.c:633:14: warning: comparison of constant 2 with expression of type 'const enum todo_command' is always true [-Wtautological-constant-out-of-range-compare]
>>         if (command < ARRAY_SIZE(todo_command_strings))
>>             ~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> 1 warning generated.
>>
>> 53f8024e (Johannes Schindelin   2016-10-10 19:25:07 +0200  633)         if (command < ARRAY_SIZE(todo_command_strings))
>>
> 
> Interesting. The compiler is right that this _should_ never happen, but
> I think the patch is quite reasonable to be defensive in case the enum
> happens to get a value outside of its acceptable range (which is
> probably undefined behavior, but...).
> 
> I wonder if:
> 
>   if ((int)command < ARRAY_SIZE(todo_command_strings))
> 
> silences the warning (I suppose size_t is probably an even better type,
> though obviously it does not matter in practice).
> 
> -Peff
> 
Both do (silence the warning)

enum may be signed or unsigned, right ?
So the size_t variant seams to be a better choice



