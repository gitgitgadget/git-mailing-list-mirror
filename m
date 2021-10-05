Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBA8C433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 19:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E0F161372
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 19:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhJET4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 15:56:11 -0400
Received: from mout.web.de ([217.72.192.78]:41271 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhJET4K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 15:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633463642;
        bh=Pu5M5XBFNZP1dUUK0/2XEV9rKnIuw4XYVhgrxaMGMj8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iRXVKRih5uYR31w64IsfLOrJF4+1DEOZQY+j/WLwDJkl6VHRSyhmcvcc7t+rFxe2L
         RaiM7tq/jzJZMEpgABcA7JqipbP6AvKUA3IrBt6UfSw7ugiAne6SQE1QkpHHNw7Gy8
         qvuvM4XGpln9/b0UabBxZHht63NgwGPfuqdzt1AE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MTy1N-1mPM3E3RCb-00QjfO; Tue, 05 Oct 2021 21:54:01 +0200
Subject: Re: [PATCH] p3400: stop using tac(1)
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>
References: <85831cc2-307f-1be8-9bb3-c44028ad07fa@web.de>
 <YVq752xjzYz+LTq6@coredump.intra.peff.net>
 <f6a1296f-f524-9042-7f88-9591522971af@web.de>
 <YVyppmEGkNCxZ+5L@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6c817b65-1699-72d2-892a-3610dcbdf6a5@web.de>
Date:   Tue, 5 Oct 2021 21:54:00 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVyppmEGkNCxZ+5L@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L3ZS2QCVWHdllKMm4vCTB5t3uyAh4JtHgy0Oi+mrPmus58czqt3
 HKEhDdQ76iKYCV+xHi0tZnJGuz6RJpk/7Z+xn6K8l/4JromBh6dWk0v6rqRdcobgBeF0mlt
 0sVlJghnjNpaXNd/mJnfGy9XlUw+QUcD38V5SsWflYjYXjOZ5Yf/AyIhni8W+qFSniXZvgy
 1xKPnUUVeL4UvN3uXFdKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DtJ7NLxxK+Y=:agXIQF4hGbYYqnBN5xGV6I
 Zw5A6B8mHDvE0AT8uLCYnV8zwlaNjczNmGrodYn/fpcGWiWi6kbykjAC+jBwYJ6x7mZ2cFYjt
 55Hcce78BA3omM4B5AM3+0L9CaUVvhShOw3EL5pSkCNOAO4Y9GbWq8Xr+I0qsjAZf0cjnnBN5
 MkOVvWzRofWqpxUudcIGVZtEr7rSxj95c4dh6eMubiEWoxXkyl5OgwXlyczk8aoVYgidPbM3T
 FRU8P6HLwQeHnz8V0shgeXdEb6/isz8BfFlpcqqMdsH6FTrEFvuRZGfKUid2dosSuHLyKBC2H
 V9Cn7C4CJeQt+cpl3qmzrdwlsU4+CYxb6DjyoAErRnIlCnsXWM9AkFRJVN3U3CbeivO6be2vw
 5GTG4Rdw7f4oozn+3ZRMynO0HjDCFLie75XQDZ9MkUbBRZXwYLigJDj+7C9iB3T296f4d2weN
 PWWQb7zlNn+zBvrzVxqjxbb4jJ/cZ4qwd7PdZtlFaLddkBOl2hJZ0Ra1l07UIujsgz45Dquy2
 1EfbVinztY8ZUdpBi25PQUgH6mCEXtPTCpJoF2uEw47J+f256iIxa4ANN6lcpto6HeORy6kZG
 U0+sYC0+8jhDzGoWt4M7AT5TiLexvjzesYiXqOsQfkeChE/bzoeMEgkIvH31gjNWn+BW3W3LB
 URRzK4eJ/NI1rR6huh95/nacke6PTLTY00305omKV7whCtzhX/agcGZZAyBli9X0/zy1vg7Zu
 TIoRF2tCjPrWcWQaytHZytjdIIq/PuaBUw3zq6V58iUH7RGBCEpQzJbOrasEkxqzJp24nm3cp
 B+ZAb0TLOra1T1rJbSDDlf0NoZULJvSGTE6bGazVVmku9azoFX/0b6gcsHDBCrLYdDbxOp9Kg
 jrR3Vmm7fVBxdXB//nzMeDM2Qtvtt4K++VMdOsw4Y48ZiCg/psbmLQ6Uz7/uiyOrytnuhyRij
 Hhom99IVT/GJ0te0OdNGD9Nhh8mmqJTRUpugj0I5/3cK3xNg/+ciugQe09wtHTRTT208msqDV
 g1CcYe6roKhAkgfldyqF/LpxWdgoc0Cltcl7pRSlhf5l/PHtHTEE6oQ7nUkbZZRMddhXXVC3E
 qDxxLKYN6/q6V4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.10.21 um 21:38 schrieb Jeff King:
> On Tue, Oct 05, 2021 at 08:45:38PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Am 04.10.21 um 10:31 schrieb Jeff King:
>>> On Sat, Oct 02, 2021 at 07:44:14PM +0200, Ren=C3=A9 Scharfe wrote:
>>>
>>>> b3dfeebb92 (rebase: avoid computing unnecessary patch IDs, 2016-07-29=
)
>>>> added a perf test that calls tac(1) from GNU core utilities.  Support
>>>> systems without it by reversing the generated list using sort -nr
>>>> instead.  sort(1) with options -n and -r is already used in other tes=
ts.
>>>
>>> Cute fix. With regular seq(1), this whole thing can become:
>>>
>>>   seq 1000 -1 1
>>>
>>> without the extra process, but our test_seq doesn't understand non-1
>>> increments (nor comparisons besides -le). It wouldn't be that hard to
>>> teach it, but given that this is the first time we've wanted it, it ma=
y
>>> not be worth the effort.
>>
>> Right.  The original also allows "seq 1000 1", by the way.  Not sure we
>> need that either.
>
> I'm not sure what you mean by "original" here. "seq 1000 1" produces no
> output for me (nor does it work with test_seq).

I meant the non-shell one, i.e. seq(1).  I somehow expected everyone to us=
e
the same, but of course there is GNU seq, which has "an omitted INCREMENT
defaults to 1 even when LAST is smaller than FIRST" [1] and BSD seq with
"When first is larger than last the default incr is -1" [2].

[1] https://www.man7.org/linux/man-pages/man1/seq.1.html
[2] https://man.netbsd.org/seq.1

Ren=C3=A9
