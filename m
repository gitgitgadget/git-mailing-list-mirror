Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA571C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 15:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbiGGPfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 11:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiGGPfW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 11:35:22 -0400
Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4F62613D
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 08:35:20 -0700 (PDT)
Received: from [10.0.2.15] ([147.147.167.40])
        by smtp with ESMTPA
        id 9TX9op1faAcBn9TXAohjQj; Thu, 07 Jul 2022 16:35:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1657208118; bh=jlMgl6ZMDIM6erLCWAgAnRGtMJIXZoMJVC0xMw3ith0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=QVuJJPKcrVORyVAUwy9Xjs7DUXZUcaRyOePUJ9CC7wdkPfiQZ3KNrrrzO7RRgfl1v
         j3ptPzCiRSxTza9ZBFymjUBeiGmZpCa8ZOZ8c9okQU7XI+PszMtofqPwMuEYQJ4cj7
         gwiEkYUMTewf8J2iD/b8JtoClHWAfGF14Jo0oMcLy+Kp+elIP9uAdLDyH6bYFSjmrX
         Wvdnvow/w9AAvifiZhedKjsd6wu9xjhgMmCZiT1rnvjp0yf1edfV72l2mAPGS232hM
         3vha+viUbvFNE4A2KNAOGnCm05DEKN93hpAfgNECI+Y50KpO0B/o0mmeb5hVWB5cTj
         2dQlDg6M7IDvA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=JPUoDuGb c=1 sm=1 tr=0 ts=62c6fd36
 a=nyqnwr6A7Kzjd6EpZhiMcA==:117 a=nyqnwr6A7Kzjd6EpZhiMcA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=VwQbUJbxAAAA:8 a=nqqq8CHp-VvNiXySAVQA:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22 a=AjGcO6oz07-iQ99wixmX:22
X-AUTH: ramsayjones@:2500
Message-ID: <a26a837a-51f2-d38b-7eb4-8e425d6d9150@ramsayjones.plus.com>
Date:   Thu, 7 Jul 2022 16:35:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 1B] credential-cache--daemon: close input before
 exit-ing
Content-Language: en-GB
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        GIT Mailing-list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
References: <c344938b-afe9-edef-1e0d-fbe2425c8c01@ramsayjones.plus.com>
 <220707.86pmih847l.gmgdl@evledraar.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <220707.86pmih847l.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNXeDuA8hRTlY6vI39gPK7iBWSC5q2dCQNfB0uBwnCI+gcnND8tb0O/QGXulhs1z2cbSCYV0ccW5GgnvQCzagSvCSxaQf0zWkSPLSYWMENb+9GcAVtfz
 fnvLzdyHSVClDJFiM8mT/iyJpjgflMylhTOjF+hLAY5avUMUvSj1x/DqqlZoGG/lZpXqfLveOdHYGb9/BnwevlfsIZ4qZZUfXJU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 07/07/2022 14:00, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Jul 07 2022, Ramsay Jones wrote:
> 
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>  builtin/credential-cache--daemon.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
>> index 4c6c89ab0d..556393498f 100644
>> --- a/builtin/credential-cache--daemon.c
>> +++ b/builtin/credential-cache--daemon.c
>> @@ -138,6 +138,7 @@ static void serve_one_client(FILE *in, FILE *out)
>>  		 * process actually ends, which closes the socket and gives
>>  		 * them EOF.
>>  		 */
>> +		fclose(in);
>>  		exit(0);
>>  	}
>>  	else if (!strcmp(action.buf, "erase"))
> 
> This is called by a function that will also close stdout, shouldn't we
> be closing it here?

Err, do you mean 'out' rather than 'stdout'? Actually, it doesn't
matter either way! :)

Let me quote from [1], which (hopefully) explains the context:

"""
Anyway, I started playing around with flushing/closing of 'FILE *' streams
before the 'exit' call, to change the order, relative to the socket-file
deletion in the 'atexit' function (or the closing of the listen-socket
descriptor, come to that). In particular, I found that if I were to close
the 'in'put stream, then the client would receive an EOF and exit normally
(ie no error return from read_in_full() above).

[fclose(in); fclose(out) also works, but fclose(out) on its own does not.
fflush() in various combinations did not work at all].
"""

So, my intent was to find the _minimum_ change necessary to fix the test.
This is not a 'real' patch - it was only to demonstrate that there appears
to be some order dependency problem induced by the 'atexit' clean-up from
exit()-ing the server.

ATB,
Ramsay Jones

[1] https://lore.kernel.org/git/9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com/

