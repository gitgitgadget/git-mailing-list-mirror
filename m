Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F752C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 17:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099FB24672
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 17:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="s2FoC5O6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfLSRfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:35:46 -0500
Received: from mout.web.de ([212.227.15.14]:50391 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbfLSRfq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 12:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576776933;
        bh=GNvQ+rXEE7QpfJnaJjYB8GsuSAqmfG2sOD0m2mFFz4U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=s2FoC5O62hr/HUa+tR3Y9ypfT0R0YqWyXo+U3jUA32S2sxJHwUGjUxnxDcwHZHtN1
         z9J6KWzkk1VO2yXL3Ga5k4P2z4XfX7P/vRpus1JLeUfhSIXP0mP7fVem5CGtcnd2VI
         pf5+M1nVvYvSSDpfM7jkFycA1eV35Zepl0YK9ZQA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.27.9]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MDxFv-1iSpHm0UFb-00HSAU; Thu, 19
 Dec 2019 18:35:33 +0100
Subject: Re: [PATCH RESEND] t4015: improve coverage of function context test
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <fedd48bd-28e8-ccc8-ae50-42d9b2ea1c16@web.de>
 <20191218201241.GA6452@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <7d454f2e-eaf6-1897-d6f6-c2e3e2a1f75f@web.de>
Date:   Thu, 19 Dec 2019 18:35:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191218201241.GA6452@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7vLIzgKzep1q7N3e8HFXpfsianJ3jtgVkV4ai0ntS/dkA1mOfqe
 pm9OWscldP/Jaxkw9QrovxACqkAHrtr6nkjl1lkx4O8p3JDVmdu/4f0kiKSrD4xptZTe25/
 xyDGEjANcJJdIezasZRHsq4NMlNvxni7hRdk+R7+USfzQB78VCpgeFF40ZMDkTlj9Pin4tM
 NKhvhWttfrSbPyP1jxKkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tTCFUr/b6DU=:3nVP1YxJwECy3fUlsn1QFB
 /sbs/wLdih4QShKeNtj2+l+jvNBn5BxrMUQ5Et8a684KKHYr19pgVDu95LcAzrECtUMIoPd/0
 n29ZbrvaEp17asqZXsLJWa0igWP8R2wLnc7O0FXxuouSA+LyMIEgsfdAR+mDGx8ZsPNBD+0e6
 rbRQ3xNU+dOzJvkmI7AbEK7yV9JziKoKnFBDjTVWT3RwREqec/ajis0uGyXcrawNAmbT73ID/
 XmvhPhzXpUOnNG2Nt9qdaFEt8DNCgUIFdcKP9lNNy4frX2/LOl0KdFw0nf2ScDRrzYx68Ahrx
 zt+hXeMDvLu48u5nDoj3qXoZRv1arp5TSRZDZin4DX4r7Fxr6e/+PqYVbujkPtgwLQ+pVqYHb
 yn6ThVb7oezDjmuChPjxh/CXdNVstxocR6NytSke+StZ3+pRel9DpOE44Q3nQl6fZ+EJfaRLJ
 xvaeoVZWUG9iNf7a9QFYMRjqZKrSaTbshyBT5tKaUqHjx1Aq4f+NtZ2N3MT028/40c5uevBVI
 IHIPHFg5Pr1talgIZf9Q0XUx8xZTSXwuL81yfi0ZDbjA51Z4hwiH5uLH2BJ/64WfR5BDbFncg
 XiCn9560vs64ErGirmUYphLy2YUhQd5Fnwb+nkEowAB/1wFZCENwoiHkF0VMq8VQ/d6cXrO3q
 MmdGdKImYD3ZzNjTnlo1Cd73bRg97myyoQjH7q9c3J0knNvUopRvUMl5mysOdumdsNdxOrNCt
 kJkELMFIicwO4236p/CBZ4UzyyTaT9kImGI1pVyDPh3kseGa+/4+zS0ZxWwE6wXpk3ZD4hxac
 D9wRnhnccYUJaZU8CoA71ihQGBkpysBEcan5A+5zjm4Ckxjp5NoDLnuObX9sepRr1B8sS7wlv
 k+IfL0JkP19vnQg8JBSv2dOHstaDvKwX9Ud4yXM1Ub5QAhW5PHQmlNg99jDAANSP+in43wB+Z
 1/QquDyqew9FW/vK4TKrbBGGKhr7wNhrSPxN1eFCVKrR70kMCOwLmUPtTjWg3KMv+nuEVp+vO
 DnTGx2iU8YqM/Ztx6ew/iv876ubhP2lR2ILsAdssgzyTAsh5ha0WFsRqyhpMB8B5PQwAqeg1t
 AGZ25VrnAPSG4M0M5qz5JHU747RR9nZI6uDXY5iH53L299HjmChK2hAQjMFxehe8gAdZwFB/o
 KHpTnKK/cchexVwwyDWqwyJUenQhLJqsLx0Nbr1TN/2VOiRqNJmsHPJadEC152X/ybelEbB+i
 Dc8hOamqeZYSldhdkREC3khmdlLlXjYrIJ7F6hQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.12.19 um 21:12 schrieb Jeff King:
> On Wed, Dec 18, 2019 at 07:05:54PM +0100, Ren=C3=A9 Scharfe wrote:
>
>> Include an actual function line in the test files to check if context i=
s
>> expanded to include the whole function, and add an ignored change befor=
e
>> function context to check if that one stays hidden, while the originall=
y
>> ignored change within function context is shown.
>>
>> [...]
>>  test_expect_success 'combine --ignore-blank-lines with --function-cont=
ext' '
>> -	test_write_lines 1 "" 2 3 4 5 >a &&
>> -	test_write_lines 1    2 3 4   >b &&
>> +	test_write_lines    1 2 3 "" function 1 2 3 4 5 "" 6 7 8 9 >a &&
>> +	test_write_lines "" 1 2 3 "" function 1 2 3 4 5    6 7 8   >b &&
>
> I'm a little mixed on this one. This _is_ a much better test of how the
> two features should be have together. But I think the reason the
> original was so short was that it was added when fixing a bug where we'd
> iterate off the beginning of list of lines, which now no longer happens.

That fix, b777f3fd61 (xdiff: clamp function context indices in post-image,
2019-07-23), should no longer be necessary, but I didn't check that
thoroughly.  Since we still have it (and I don't intend to remove it,
better keep that extra safety), it makes sense to keep the specific test.

> Maybe we should cover both cases in two separate tests?

That's easy enough to do.  The hardest part is coming up with a name, but
simply counting up should do the trick here.

> I'd also suggest using "a b c" for the first three lines to avoid
> confusion (I don't think it's important that they're the same as the
> lines inside the "function").

Good point.  That turns the last line into a function line, though, which
is unnecessary and confused me a bit, but I think it's a net win.

Ren=C3=A9
