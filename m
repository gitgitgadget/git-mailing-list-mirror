Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4C4C433F5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 17:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 994C961381
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 17:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhJERbc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 13:31:32 -0400
Received: from mout.web.de ([212.227.17.12]:51693 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234248AbhJERba (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 13:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633454934;
        bh=21HadnxEONt1Zu2IcW0RU4zTAtU7mTrshVvdZVvz2RM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hOK898JLbhFISSloLWT2iyP34PTWGqrgNZMRdS9o8l2WzMQ5ymNpPWj7jSj7aDm9U
         dsqJK7dBGMIiyKcGsy3ZKMsfwwiBoK9BW6cK2xMQOY/wX+VM55bPNDJMXU7NAnMFIe
         AzbQ9ZPlLgC/3DXc9WMI0ugH7ph0R1vCDPUhvp1w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MNcMo-1mRlZE374U-007A7T; Tue, 05 Oct 2021 19:28:54 +0200
Subject: Re: [PATCH] hash: reduce size of algo member of object ID
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Andrzej Hunt <andrzej@ahunt.org>,
        Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <8da7bad2-b5a8-5aef-284b-dfa4e78556a9@web.de>
 <YVq3rqwz82RgpUfl@coredump.intra.peff.net>
 <YVq5XCyLDr0SPBzx@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <269501ed-41ef-9ebf-e56b-1d817a5b9b2e@web.de>
Date:   Tue, 5 Oct 2021 19:28:53 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVq5XCyLDr0SPBzx@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sPTZKziSBu8Fkyv26BC5CvZcePg/nk32L+HTeDq9Zv+BpNiNkWd
 n/l4yKKJmAaLLKDFWMDxvXIot2RuH0ocjJUS7CZDVlOoEh0HdNiQzbSfk7q8vckpH2Xuzg5
 rBtGGW48rYrOt1MhcKq6tverXmME1/LdViyPnuV/THtkG1Cv8d3hjmLDhdgccf2WNzOHH0L
 ldFNpGvC6epSeUkp2JQgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NSaC7eFfQ8M=:+0ZIf/mLJ6+RedRQRzQFio
 2q283R8dUgRb5f42npN1vuPV/+/Gx4bglmAqmZxdoGRZSJFQHDjbQk4bXSghjiPbRa/uVnD4t
 Qv+WQ5GdMQISBoEhlj/pWgXEN9aX2UHasH1BKo3OzlAK5th38s8hawc4f+C5u/9iEar2cJCoQ
 WJklJZO691TmrJdIZATt+HO0tmmyweoR2IwAT03JSYMeKrQjAz6HZjvGy5fWKV5iuT8mA3cr5
 j7pYGiDB5eeMw8xi01LqTCDmmxFQbcUQHYDHarHG3ZPLR+DhdPEA/+BiDXHs+GTn8p0GxmFQe
 SGXCzvD2y064sQEyNTBUv5AHvVgX0RqsVvfQXQbKyilr1PdEyn3HKLNguOZgw/BfR5jwvVGpc
 zJW0YfY1f863Ex/hrUeGpM+3iq+p/7cDRRx3lHzg7u4MimO+7F2ZIETdtocvaRn22M07c2suA
 D7/HRV8O7oCjRQYdVM/YDQCuHtXn3mkBtoMJYugKqsDccl2U0SHa1llsnJKGsC3w8r8BWk/7T
 7OK1EDEvn5glMd1m62c2jzlgq29xyIF0F2eG+XZZUU1M5Csa2NqKBXiu2wRC3/SKaSowgErIc
 oGHKPG8PAjMpkmJGQT38L5sy8S6buogzA+QKZiBSizqp7j23VHjJb3QdRujXLsms+BxZN5mmf
 JDiJQWGWTCF/I3WSduWuMtdw7Xzd8hYMu/vl5GVcQGazCDa+XIjqAhV8kFbvHyIRfuFedrp5f
 o3O2NkChZCXWlCdCzG4Hd4ydm3EOt6CYEAxvGOSyLsQJXmdg4D8wESH6myXKCiy2wwREr/9uf
 fQWgHGxdIvQXOtHFY9a9NhwaT9gGAyFC9Do/dZzqi/9w42PpyuHP7kELXeaxJxrfeGg+wLIfB
 IO09ZLr0RqVRbggEyq/4lHBPMELOyr4YPr1Ag7t74e0oQ/70maNv3Iq+NRrV5SbVUC7tjg+2Y
 EgfVTz42c0USBZ2D5e+nIRMfXJjzSvk0S1+/+N23dZ/hsZXG22bI1sMwWfnNB7pbZVdtwc5MU
 ooyNrNOfmnJuJjmnHaplWg4tQIZ9C39SGoqVJJAfhb7fqq+2irO1MtZ+YR2YvjCEuA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.10.21 um 10:20 schrieb Jeff King:
> On Mon, Oct 04, 2021 at 04:13:34AM -0400, Jeff King wrote:
>
>> It looks like adding the "algo" field did make a big difference for the
>> oid_array case, but changing it to a char doesn't seem to help at all:
>>
>>   $ hyperfine -L v none,int,char './git.{v} cat-file --batch-all-object=
s --batch-check=3D"%(objectname)"'
>>   Benchmark #1: ./git.none cat-file --batch-all-objects --batch-check=
=3D"%(objectname)"
>>     Time (mean =C2=B1 =CF=83):      1.653 s =C2=B1  0.009 s    [User: 1=
.607 s, System: 0.046 s]
>>     Range (min =E2=80=A6 max):    1.640 s =E2=80=A6  1.670 s    10 runs
>>
>>   Benchmark #2: ./git.int cat-file --batch-all-objects --batch-check=3D=
"%(objectname)"
>>     Time (mean =C2=B1 =CF=83):      1.067 s =C2=B1  0.012 s    [User: 1=
.017 s, System: 0.050 s]
>>     Range (min =E2=80=A6 max):    1.053 s =E2=80=A6  1.089 s    10 runs
>>
>>   Benchmark #3: ./git.char cat-file --batch-all-objects --batch-check=
=3D"%(objectname)"
>>     Time (mean =C2=B1 =CF=83):      1.092 s =C2=B1  0.013 s    [User: 1=
.046 s, System: 0.046 s]
>>     Range (min =E2=80=A6 max):    1.080 s =E2=80=A6  1.116 s    10 runs
>>
>>   Summary
>>     './git.int cat-file --batch-all-objects --batch-check=3D"%(objectna=
me)"' ran
>>       1.02 =C2=B1 0.02 times faster than './git.char cat-file --batch-a=
ll-objects --batch-check=3D"%(objectname)"'
>>       1.55 =C2=B1 0.02 times faster than './git.none cat-file --batch-a=
ll-objects --batch-check=3D"%(objectname)"'
>>
>> I'm actually surprised it had this much of an impact. But I guess this
>> benchmark really is mostly just memcpy-ing oids into a big array,
>> sorting it, and printing the result. If that array is 12% bigger, we'd
>> expect at least a 12% speedup. But adding in non-linear elements like
>> growing the array (though I guess that is amortized linear) and sorting
>> (which picks up an extra log(n) term) make the difference.
>>
>> It's _kind of_ silly in a sense, since usually you'd ask for other part=
s
>> of the object, which will make the speed difference relatively smaller.
>> But just dumping a bunch of oids is actually not an unreasonable thing
>> to do. I suspect it got a lot slower with 32-byte GIT_MAX_RAWSZ, too
>> (even when you're using 20-byte sha1), but I don't think there's an eas=
y
>> way to get out of that.
>
> Oh wait, I'm reading it totally wrong. Adding in the extra 4 bytes
> actually made it _faster_ than not having an algo field. Now I'm
> super-confused. I could believe that it gave us some better alignment,
> but the original struct was 32 bytes. 36 seems like a strictly worse
> number.

Apple clang 13 on arm64-apple-darwin20.6.0:

cf0983213c^ (no algo):
Benchmark #1: ./git -C ../linux cat-file --batch-all-objects --batch-check=
=3D"%(objectname)"
  Time (mean =C2=B1 =CF=83):      1.105 s =C2=B1  0.017 s    [User: 1.058 =
s, System: 0.045 s]
  Range (min =E2=80=A6 max):    1.086 s =E2=80=A6  1.126 s    10 runs

cf0983213c (int algo):
Benchmark #1: ./git -C ../linux cat-file --batch-all-objects --batch-check=
=3D"%(objectname)"
  Time (mean =C2=B1 =CF=83):      1.186 s =C2=B1  0.015 s    [User: 1.134 =
s, System: 0.051 s]
  Range (min =E2=80=A6 max):    1.162 s =E2=80=A6  1.201 s    10 runs

cf0983213c (unsigned char algo):
Benchmark #1: ./git -C ../linux cat-file --batch-all-objects --batch-check=
=3D"%(objectname)"
  Time (mean =C2=B1 =CF=83):      1.409 s =C2=B1  0.013 s    [User: 1.367 =
s, System: 0.041 s]
  Range (min =E2=80=A6 max):    1.397 s =E2=80=A6  1.429 s    10 runs


current master (int algo):
Benchmark #1: ./git -C ../linux cat-file --batch-all-objects --batch-check=
=3D"%(objectname)"
  Time (mean =C2=B1 =CF=83):      1.217 s =C2=B1  0.018 s    [User: 1.170 =
s, System: 0.046 s]
  Range (min =E2=80=A6 max):    1.202 s =E2=80=A6  1.246 s    10 runs

current master with the patch (unsigned char algo):
Benchmark #1: ./git -C ../linux cat-file --batch-all-objects --batch-check=
=3D"%(objectname)"
  Time (mean =C2=B1 =CF=83):      1.465 s =C2=B1  0.012 s    [User: 1.417 =
s, System: 0.046 s]
  Range (min =E2=80=A6 max):    1.449 s =E2=80=A6  1.480 s    10 runs

OK, I don't like my patch anymore.  Weird, though.

Ren=C3=A9
