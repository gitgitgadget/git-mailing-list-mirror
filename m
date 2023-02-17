Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A1DC05027
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 20:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjBQUcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 15:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjBQUcL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 15:32:11 -0500
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AA442BE5
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 12:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676665907; i=l.s.r@web.de;
        bh=u5+/4TWu9ssGJfJMaKJkOwF4oromP2eiC/xBfdzMKk0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Nuw75KuQ7MvYB3GcvuRVAQVE2olRZ2fVqRbNT+FJH/Zogvcz5YrOcmt7XkQVw0M8N
         lVcrKZs2fx8EwMLFtgQJmE/xKuCHSHA6BdapY1gcTGQjraQGcnxKxGNTtCTnplG2WN
         umz3aaBrf4TJFCRZmhwzQBZ1+hBIJ72prAavZ+hQOa8P2+3HVRfix7V1QTbSbyfNrP
         Oum7xbe8ie/jXE9KEg/pI45T4tiJzpxp3+h3xCsWlFg2Uv+NMEfuYmlAipCnjlWWwB
         p0f9LS5Ye+S9a4ki/Vs+OF9EaTO14idyluXvoynPjfvAwVWNOhtWRh6Zph4KwzL9RV
         mxpXfXJPkxj3w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M91Pe-1pVsoP26Gk-006SII; Fri, 17
 Feb 2023 21:31:47 +0100
Message-ID: <83635ee4-02a2-dea7-38fa-c7b65c30c897@web.de>
Date:   Fri, 17 Feb 2023 21:31:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: Feature request: Add --mtime option to git archive
Content-Language: en-US
To:     Raul Rangel <rrangel@chromium.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <Y+6G9n6cWRT9EKyl@google.com>
 <Y+6akicTFG9n0eZy@coredump.intra.peff.net> <xmqq5yc1p7yn.fsf@gitster.g>
 <Y+7PcqpYhF5ZuApG@coredump.intra.peff.net> <xmqqpma9m4i1.fsf@gitster.g>
 <CAHQZ30Dq1_vdJj_hakqXKFUbuqn9ysNsw-zzN83RmUVbibA3Gw@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAHQZ30Dq1_vdJj_hakqXKFUbuqn9ysNsw-zzN83RmUVbibA3Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HIoTGB58yJgfL41+SB276wZpT41LHf77y9FCPczgClFgGCVq4Wu
 VO6NHo3GY6wAxiukiuSEpHcWeZR8EdDhWaAjYghgn/Gijdi5vD3IPdYzMbhvjSPSmcl2Mxs
 7K3GED3IVec1I+OHhyPC1HNOX1AKogBKc54a7ee2XDYO3BTEH3gowabD4CwlhMHKYWilnFn
 hjW2brFHQMKOykPYX3WMw==
UI-OutboundReport: notjunk:1;M01:P0:VVKMXidMjrQ=;ogLQcfUfWi1wRe9bxF5hIgT2GBp
 oBISOYRoIjoFlLrAyPNmccbKf/UYSKsTf1pKOqq5FhwnsqCPPI/ZXQKzS6m3MxAe+2gqw3pln
 mH4hLC6OBS6tCjvxbt0XILUZ243TI6OOurqbSZrP5SW2msMSQ4KHsyk9S3PmC38LqHMeATYRd
 guSJEy2x5/4kDfHG4wZteKYVHIHo4mWU0bud+lb41hA70jIDuoYuuggMkG0dFCKx3JdTDUL+0
 LlaS12lJ5whMIyIrdD1OLhuBNMb7sc3pJcP7hKHz2K7IsDcpCBgMetWvYNtPjzWXh9SnSAg1z
 d1lNVht9AaygJ7J0pi4HisEZA8GjACrGLo5Ju9FXBx3/P+F43uHsjmlf58poxOHnw7BjnVOqz
 9YTEg8NmJ2w80X/FznFQkq1REWVn4V9BeT0XwUY1ziMJ+RurxL086Hd9Be6cfIkvtyV2CPd+5
 ojU10jH9dTPCg/CQ9zbX2Hsibglw4zcwHijqnoasi8Yp8TP/VI3KEGTswI0diixgCtjrPUeRw
 yXbqr7847sx1b6f4wHqMQcI4tF+tZZhyTPFjAhfNVkLnmByCUmW9TCjRxC12Mcwy7FDdtjXcC
 KWZLLlhtQE3quqxXXe5/h36Sxwr2IWf/ErilSN5nKCcgZbWmbz9tcfTQ/ssHTP3+J1wkXXIf0
 ODN9nqig5/gkpVdqmURKiZWKjbhjajbReXSmFa6FQJadG4R5jLjym0Mfrc/4VjRpEMi1KssUp
 kzYuvUmxKyT9n/Cc3/9jpJupEWR1bVzvIGUPVWi1b7PLC4+RNrwFVX2wp1h/q9CADkFBxSMPt
 8bh95XPqeEOzwSHo8HUGxuPFZKHnIQaqndZWuIqjyD2j0jhNYQaxlOx4MumQNTZMqhcQ15pvZ
 P7MaoI+RTy9GL71fosXYWzAjtssuDFNzAAzNX4d/fvowYVswWaCuCzldQQ5xCVMpDgzodNjEC
 vKRPUowe7QcHn9ryP24bNsPC0gw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.02.23 um 16:43 schrieb Raul Rangel:
> On Thu, Feb 16, 2023 at 7:04 PM Junio C Hamano <gitster@pobox.com> wrote=
:
>>
>> Jeff King <peff@peff.net> writes:
>>
>>> A similar option in is to simply start using "0" in the meantime, like=
:
>>>
>>> diff --git a/archive.c b/archive.c
>>> index 81ff76fce9..48d89785c3 100644
>>> --- a/archive.c
>>> +++ b/archive.c
>>> @@ -470,7 +470,7 @@ static void parse_treeish_arg(const char **argv,
>>>               archive_time =3D commit->date;
>>>       } else {
>>>               commit_oid =3D NULL;
>>> -             archive_time =3D time(NULL);
>>> +             archive_time =3D 0;
>>>       }
>>>
>>>       tree =3D parse_tree_indirect(&oid);
>>>
>>> Nobody will complain about changing the byte-for-byte format, since by=
 definition it
>>> was already changing once per second (cue somebody complaining that th=
ey
>>> have been using LD_PRELOAD tricks to simulate --mtime).

And how are you now going to tell the current time on a remote git
server? ;)

>>> I do wonder if people would complain (both with the patch above and wi=
th
>>> brian's proposal) that the resulting tarballs extract everything with =
a
>>> date in 1970. That's not functionally a problem, but it looks kind of
>>> weird in "ls -l".

Yes, 21st century artifacts being sent back in time looks a bit strange.
GNU tar and bsdtar provide option -m to ignore mtimes when extracting.

>> And owned by root:root ;-)
>
> I fully support both of those easy changes. Only reason I proposed
> --mtime was that https://reproducible-builds.org/docs/archives/
> recommends setting SOURCE_DATE_EPOCH, but honestly for my purposes I
> would always use 0 and root:root.

git archive already records root as user and group.

>> I am sure people would complain.  What matters is if these
>> complaints have merit, and in this case, I doubt it.  I especially
>> like your "it has been already changing once per second" reasoning
>> for this change.

I find it quite convincing as well.

Ren=C3=A9

