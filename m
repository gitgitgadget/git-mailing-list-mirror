Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 301B71F404
	for <e@80x24.org>; Fri, 23 Feb 2018 22:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeBWW4T (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 17:56:19 -0500
Received: from mout.web.de ([212.227.15.4]:49857 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751527AbeBWW4S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 17:56:18 -0500
Received: from [192.168.178.36] ([79.237.251.165]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lgpcs-1eM5Ww096U-00oJPe; Fri, 23
 Feb 2018 23:56:08 +0100
Subject: Re: [PATCH] strbuf_read_file(): preserve errno across close() call
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <6b58885c-b0f6-1687-3f2d-4594aacff9ac@web.de>
 <20180223064952.GB19791@sigill.intra.peff.net>
 <20180223070053.GC19791@sigill.intra.peff.net>
 <f134c6bf-c147-4201-1217-b59bfb9f2288@web.de>
 <xmqqk1v3s64y.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <612cc15c-624c-0963-4d12-aed0993ea16c@web.de>
Date:   Fri, 23 Feb 2018 23:55:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqk1v3s64y.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:F7XG64FndnxijyM8648UnqpNxi/4qkXFohQeg5TQlSPsgXjs+u6
 ATNa9ljJx+xt6yANxIMDygwkzECnGHnc0fYzWLFiH+Ib7gYViEBryfy61fq8RjCdqYtOsVK
 nfHIUR4clPZc2YaSKsX5KdwZGDUg8VhuzmJ1hoJwXQZ9qYm2cmK96iTh2uqcgwlfL8EQeUs
 E4GoYq66pKlM3VyOA4Y/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:71gD/wcIOp4=:my/AeO+7CqOIX9Eh/VC9Kg
 eQUdnTELOfR3i3MCCr3Rf4efiyL5sUjRU8/XkpLSf44t2NTe6JIfVZmu7ci2XoOVDKK0uKf//
 A0d8CYsAzrw6MRVVQ2EGUSc1a+UeZDPuZjUNMFrrSbKZfd6gTkP5L6MW46YlMxgqA+0F22IoU
 cciISExZJ2fhhlXzAHLiPxVd1KKXNZnS+qWnfMO61UVi4pCLOK9cLWTu457fTX9HnaWMfRJA0
 eidKUnCirBN20hHYmvo/0yxrcZ6nkSStUwuo8ruKjK7LOdIAxViViGj2joH8Nyakur/n//+2T
 rabd2+0ADEGTMT3BtI9+4aHlJUtGYmUubHIv6K8S3qEgbUss1Sv4LgjbRTiX2Q6z74xXHxdVq
 8vY54fW3j3dcK2EiDtFHzujCnZPFOYvk3EeEACJWpRNHNlWs4O7hxg3Kiu4OZMwme0AboYeBY
 H0NGGLUSj7erq7dzOYAT6qDc5sgkPT0C3IVr18uZ25tym+QuU2CEpb5v3nq4jYHiLQs/udE0/
 HAH/RvAyXm4RtQ4R7F11uUcWfI8zuj8lGDZLIrCFJ0B7Rzboq6PFfV70iiT0yyguycTARv8ch
 e/ouZVWokdgcF2v/sRBC1Gtl+slO4yiJDq8Mxc96Gh8D9HZXlEVO5k1DI2J9ntxKurblMDQrZ
 /tLMOnwk42h2w9+jgMA+n0/am+EqDrgEJgpSbnBBGFah3EC+UbxVD9CJoe2RjBidkX6eWTPec
 FgLASQ+ydre7q24+ePH3GOxNyQZfLmkSeHSEyZBmC0PzJXzbWT2/f7x167O747ab1/opvoD6h
 vSK4KDEaUGbbwankfPb0CqXtmtVIN4c76H6tteltcktDCiFIek=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.02.2018 um 23:17 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> +#define IGNORE_ERROR(expr) do { int e_ = errno; expr; errno = e_; } while (0)
> 
> The macro certainly is a cute idea, but ...
> 
>> @@ -391,7 +393,7 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
>>   
>>   		if (got < 0) {
>>   			if (oldalloc == 0)
>> -				strbuf_release(sb);
>> +				IGNORE_ERROR(strbuf_release(sb));
>>   			else
>>   				strbuf_setlen(sb, oldlen);
>>   			return -1;
> 
> ... ideally, I would imagine that we wish we could write this hunk
> to something that expands to:
> 
> 		if (got < 0) {
> 			do {
>                                  int e_ = errno;
>                                  if (oldalloc == 0)
>                                          strbuf_release(sb);
>                                  else
>                                          strbuf_setlen(sb, oldlen);
>                                  errno = e_;
> 			} while (0);
> 			return -1;
> 
> no?  That is (1) we do not want to rely too much on knowing that
> strbuf_setlen() is very thin and does not touch errno, and hence (2)
> we want to mark not just a single expr but a block as "we know we
> got an error and errno from that error is more precious than what we
> do in this block to clean thihngs up".

Relying on that internal knowledge should be OK in strbuf.c, but in
this specific example we could of course do:

			if (oldalloc == 0)
				IGNORE_ERROR(strbuf_release(sb));
			else
				IGNORE_ERROR(strbuf_setlen(sb, oldlen));

I guess ignoring errors of whole blocks is not that common, based on
a quick search (git grep -W int.*_errno).  And in such a case we could
factor that code out into a separate function, if really needed.  Or
continue saving errno explicitly.

Compilers should be smart enough to avoid saving and restoring errno
between multiple uses of that macro, e.g. code like this would only do
it once, from what I saw when experimenting with the Compiler Explorer
(https://godbolt.org/):

	IGNORE_ERROR(close(fd1));
	IGNORE_ERROR(close(fd2));

> Of course, a pair of macros
> 
> 	#define IGNORE_ERROR_BEGIN do { int e_ = errno
> 	#define IGNORE_ERROR_END errno = e_; } while (0)
> 
> is probably the only way to do so in C, and that is already too ugly
> to live, so we cannot achieve the ideal.
> 
> So I dunno..

*shudder*

> 
>> @@ -617,9 +619,11 @@ ssize_t strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
>>   	if (fd < 0)
>>   		return -1;
>>   	len = strbuf_read(sb, fd, hint);
>> -	close(fd);
>> -	if (len < 0)
>> +	if (len < 0) {
>> +		IGNORE_ERROR(close(fd));
>>   		return -1;
>> +	}
>> +	close(fd);
>>   
>>   	return len;
>>   }
