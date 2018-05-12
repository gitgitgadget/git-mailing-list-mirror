Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BA9F1F406
	for <e@80x24.org>; Sat, 12 May 2018 21:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeELVIX (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 17:08:23 -0400
Received: from mout.gmx.net ([212.227.15.18]:42839 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751739AbeELVIW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 17:08:22 -0400
Received: from [192.168.123.33] ([95.223.128.184]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LdYxu-1eZEK91cXK-00in8f; Sat, 12
 May 2018 23:08:19 +0200
Subject: Re: [BUG] git send-email: incorrectly parses email address with comma
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <9a35041b-8333-9533-4344-08d6ef99c9c9@gmx.de>
 <20180512094849.GI28279@sigill.intra.peff.net>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <31d0ba6a-f681-53f8-b403-db833f0efa9b@gmx.de>
Date:   Sat, 12 May 2018 23:07:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180512094849.GI28279@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9kV8IdMBqGnxPqFAmgoKoweFDO9/VBLkK04QEzFt6W0IGrIEXCT
 qEuA96ZA0kBmcKyUbz9zr6kxKXMfL2a78opqWR0QEEEfEgP9f5Lz8ZhRSulzFhu1YpKQHP5
 6zneuSZ9QIJwaztMmIWTrI/U1gesCbD9+GbmQMtkAxkn0bgNk0M2ZM2Wky/L6fDcTPKBZkX
 m8v10PCOojsL2y9zkzCKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:s2jHBbgFL9g=:oN2kmHvnyqssmLYzFFPK3d
 UKYql/Y5xfPQZTGoIHgAMRxXru6RsLFHwl/+WDTW8tijRDPRdqfL0ilLkjnFC3wjDJMC2J7LL
 EiI3UBG64p8HzvQ/yvpb5kFUth5CCAChcHqyU0okfxK0ExRYAXWra1O24dFw0FDA1pd9Owm3P
 SVoHBYoT28SZR/M6GvYeJfT6dKptucqGuAoWbXJliZs1dPu03U1dCfh9TVhDZlmarO2/qDNGQ
 AV1tjLaD4Y9nb4v5iqo4kvp2rC6skM1XilRJuZGVCOYw8x/tlvx/iOJFC1yYXMlDdVRUXA02I
 J8P11D83qPn1EYyTyui+/KmFekE6/D/brWUerT+yTDGMqigi9+EwOQ3SHOq+bzzfLPaZv217k
 cHEpvgWeJWuDc114hxfNetYBHeSvsxQGdY78eUFk1m68LrbuWKhnVE3zPC1ipIpeo2I9Et2FV
 SZUdyqFrQWfw2iORqKkTyuu5QrbCDLx1NtuE0TcF9fkFp9f91mqWp++MybbsFO9Oaximy6LBO
 qXP0/WwGAupuJjhOqgobpfOqNM0e69JZbXY5kDUmM14IIBs7eSHq8oqzrRA6UWABlauIWhR7C
 OffzxtsbxT0uRlOLG798tdRl95FATQ1QoLhoN68hLKuF7XbviTl7eEVJfyU0VX5fSzW7QLOW4
 Pu81+ALS1PFywgRIVIz3rHPzyw92c4xHK/xo8lbbXfntuBtGnpPmNd7fnMn3W6bLUxUlOJuwT
 9GzAFcFMgW0pGzoAW3n7w+FlM9KSb2G2H3zM00hiXabi1RKyKLjCLoi9VWD7OIs0pQLtYDeUY
 OaUpXOq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/12/2018 11:48 AM, Jeff King wrote:
> On Sat, May 12, 2018 at 10:21:46AM +0200, Heinrich Schuchardt wrote:
> 
>> Git send-email allows to combine multiple email addresses in one
>> parameter, e.g.
>>
>> --to="a@example.com, b@example.com"
>>
>> But email addresses may contain commas themselves:
>>
>> --to="LASTNAME, firstname <firstname.lastname@example.com>"
>>
>> This may lead to an error:
> 
> If the name contains syntactically relevant metacharacters, it can be
> quoted. So as a workaround, you can do:
> 
>   --to='"LASTNAME, firstname" <firstname.lastname@example.com>'
> 
> I think rfc822 actually requires even names with just spaces in them to
> be quoted, but git-send-email and most other mail programs are pretty
> lax about allowing just about anything outside of the <>, so people tend
> not to bother.
> 
>> If the string preceding a comma is not a valid email address do not
>> split it off.
> 
> That might work as a heuristic, though "is a valid email address" is a
> notoriously hard thing to check. Possibly looking for an "@" would catch
> most common cases, though.

A more elaborate test would be:
A string matching [\S\s]*<\S+@\S+.\S+>\s* is an email address.
A string matching \s*\S+@\S+.\S+\s* is an email address.
Both may need trimming of whitespace.
Any other string is not an email address.

Regards

Heinrich

> 
> -Peff
> 

