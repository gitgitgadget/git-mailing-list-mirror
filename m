Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6150C1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 18:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753424AbdFMSJd (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 14:09:33 -0400
Received: from mout.web.de ([212.227.15.4]:64550 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752674AbdFMSJc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 14:09:32 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MUVrX-1dCttL055P-00RISs; Tue, 13
 Jun 2017 20:09:20 +0200
Subject: Re: [BUG] add_again() off-by-one error in custom format
To:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>
Cc:     git@vger.kernel.org
References: <CACi5S_1j46SbP7cQMdUnULmgGD7xBkSUrS2PKbzq8ZydybHE=w@mail.gmail.com>
 <xmqqd1a8n7o8.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d229403a-d078-87b4-f3e8-89058fa4b548@web.de>
Date:   Tue, 13 Jun 2017 20:09:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqd1a8n7o8.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:OPs6clTDdUlkdtOjCoVdpVg+YvBHtcLydETnt4z849TQglsalEY
 rGCZYIPliJkG0mlO9CswAiaa9pbMHrZ4xx1mDxgBePfW+HHIoSBrIIkdClLvRxTAt6xdkxZ
 y0A0Yw9QyhTVpiSWRu/JFmmZERuTliiYO6I/KHCGj3jrI1oMajpoDP3bLs1BqSyAGKq4WsI
 GW9enGwRG43pbw3ac34WA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ir9Hl60/I0A=:Q+mFtC13TD2DvFqfc7HBB9
 Pm2q4icqAV0PAMFyILvRSS4qj9bETvRsyxGGgnOgFUPK7SSsN0PGoIQVUn8iHoqi0xlqzNc6Q
 BUgjT8BokI3puX7I1CJLhcmpeekJ2kkh7H69iH9XGWdVTRCnOeRECzvq0ZjQUyRNuxKzyPSCT
 3ym+xwnn25+JKWLWayFwMHGYuHDcIoQ8nHJ4viQ9//rRzz9xE2T3sUcP+UgCNpZsJxdapYDLC
 KDB5OZRVTtig9zXy+WNyPpmkUhQ5qo93LvVffF2AzpQ6GlN0LfIGb/eiPXHVSaPSZxR8HQLlt
 q9WmFu6WyXNGj7RcgA4Qx+hL4wJplyPKX2OsD5sj5xhlId4GAPbLMK+5GyA5ZE5qlER8btCxO
 93Je4DEDSkpyDDKCBJ641RVgXW/Onx8DRPS1NDTeEFGnebh+fpikRdEPSie0UNEGVRPpcyCpf
 UD2BCu2jbn5BQz0CwnzdjJUzGyjbFSeU1rLBVTaOTRXnpVepRdAPWrzdyIunKGnnusrFfZuRq
 vJwteFeqkbRUipSXAAmYxJ+QjH9iTeCKk2ATUNDioUFzfA28hOYTpRqy1z9l11eHsWMRaTCTf
 rZDZ7v6tGsJl22JC90K7RaBI2tH73eImK992QnncJ8cqYDIa9v+P8TxUcNsFv+pbmkN3ZkyLn
 K6yfkBTBqc35TCVSpJSInQRAfsROxyEISl/WgJ1SwXduaP0kYL2D7gDYNFtVQXHoe40FeA4K9
 gsbSZQ2XxKOnZWdsl4Xk0/OPl8e8KOmSF+LC+fkV54dxoIZipXRxxCdW3mnHe/SrxVcCfugvg
 LBHCIk+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.06.2017 um 00:49 schrieb Junio C Hamano:
> Michael Giuffrida <michaelpg@chromium.org> writes:
> 
>> For the abbreviated commit hash placeholder ('h'), pretty.c uses
>> add_again() to cache the result of the expansion, and then uses that
>> result in future expansions. This causes problems when the expansion
>> includes whitespace:
>>
>>      $ git log -n 1 --pretty='format:newline:%+h%nno_newline:%h'
>>      newline:
>>      a0b1c2d
>>      no_newline:
>>      a0b1c2
>>
>> The second expansion of the hash added an unwanted newline and removed
>> the final character. It seemingly used the cached expansion *starting
>> from the inserted newline*.
>>
>> The expected output is:
>>
>>      $ git log -n 1 --pretty='format:newline:%+h%nno_newline:%h'
>>      newline:
>>      a0b1c2d
>>      no_newline:a0b1c2d
> 
> Nicely explained.  The add_again() mechanism caches an earlier
> result by remembering the offset and the length in the strbuf the
> formatted string is being accumulated to, but because %+x (and
> probably %-x) magic placeholders futz with the result of
> format_commit_one() in place, the cache goes out of sync, of course.

Indeed, a very nice bug report!

> I think the call to format_commit_one() needs to be taught to pass
> 'magic' through, and then add_again() mechanism needs to be told not
> to cache when magic is in effect, or something like that.
> 
> Perhaps something along this line...?
> 
>   pretty.c | 64 ++++++++++++++++++++++++++++++++++++++--------------------------
>   1 file changed, 38 insertions(+), 26 deletions(-)

That looks quite big.  You even invent a way to classify magic. Does the
caching feature justify the added complexity?  Alternatives:

- Don't cache anymore, now that we have placeholders that change output
   on top of the original append-only ones.  Yields a net code reduction.
   Duplicated %h, %t and %p will have to be resolved at each occurrence.

- Provide some space for the cache instead of reusing the output, like
   a strbuf for each placeholder.  Adds a memory allocation to each
   first occurrence of %h, %t and %p.  Such a cache could be reused for
   multiple commits by truncating it instead of releasing; not sure how
   to pass it in nicely for it to survive a sequence of calls, though.

René
