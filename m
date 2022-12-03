Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26854C352A1
	for <git@archiver.kernel.org>; Sat,  3 Dec 2022 17:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiLCRWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Dec 2022 12:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiLCRWu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2022 12:22:50 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FA5BCA8
        for <git@vger.kernel.org>; Sat,  3 Dec 2022 09:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1670088161; bh=YFs/HLYDbGQQS/JqgvRRBTo3kIPWvx0jHLN+UUcg1CU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=R31v88xd23Nm9h10maWqAWHplwETMMztFn48RpO9fZQscfTHQZRr5mYOsHJ7dMWoD
         LaAm+nQdL83qrH2uzLI3Y4vw9GzFXy1ifbRAYhlURd5iu0zt3XYANxiinyeUZ/pvwM
         SkvdkP5h2qxFIf/ppuMkIkoegxFLUrmZh88ugpgFk0DGRm9wpdSF7WpxJfrPXpTpw/
         JxFnFfvTPEwR4O5TO10WgXQiZN3gJ0P/1cgrRFiBMCB44ZmNWYJQ0DUKickLPfo384
         yb+TOs+q2kY6RmOjTwj/LE1ZQbXgXK9ngakd9d3mhfh+3NZe/8/YVaknibUwmvHCnX
         fHFEKE3wT+yUg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MfKtN-1oTaJu2O1D-00gdK3; Sat, 03
 Dec 2022 18:22:41 +0100
Message-ID: <491ad25c-1cf3-98dd-f7aa-e8d1f24c8cd0@web.de>
Date:   Sat, 3 Dec 2022 18:22:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH 4/1] t3920: replace two cats with a tee
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
 <203cb627-2423-8a35-d280-9f9ffc66e072@web.de>
 <CAPig+cQack=pJ04fwEiq81x6+2AAG4ni0Gd4GQgr4FS=PERb_Q@mail.gmail.com>
 <4611a23a-e7e9-6039-5d54-c2f8cadc2f73@web.de>
 <221203.86lenoeipb.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <221203.86lenoeipb.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vlo9lYEMYKY6CeOD37PpCEV14nM0WVCZuzVeBoJwRhz326b1AYh
 0suAO/PomrEcGfdMyqyun7AwMMcUCIXxmQFdvec2yYP1JdHz2NXMA0jLUovfbQt3lqCqS4I
 vUlS0fCQ9BO3SkD90AfHjTUl9KEwp7k7fKdkEsmaK5YpMSb2+VXOIQQDcsJ0g+gxZiuf5AF
 e6Kwb4geqRAVMaZkb3n8Q==
UI-OutboundReport: notjunk:1;M01:P0:Jpr9RbcBTwc=;eozRMNrs681L5+9m4+F6g6OFb1E
 qNQ4nSL+yqB1ZDioAv/H5lHJha50gwSujLvUIhI/TqtYnf1+tVYjpbl1cqjfLVhGmeA84dWtL
 i24NxXtma6RJbz/CJnoqBfXBSwBxblqxHsS47fJzcPnKCYTlVmYxyYToz9iMFg9vOUtPFzoMI
 pDo+HJb4vNin3UwUt77KLi+kMGuR8DrC7JJ7U/14e1J16YtqTTBxZR7E39ymG6cmkhuepECfT
 ZPFyUQx4JPrN4Dck3h25gRi3h31jOQCxoLVsEQkN6c4RcOKwKxm2c/IV+XUWhihcUOM2dO2Ig
 s+BgmHvyfaDHNZ6FqXyWh44V41Vy4HDc1hsFlR06gzgvz9KnhrwyeIF7yHdKyW/pbyc6PE0gA
 nKACQjm/rWq4i6pIu5xBMT5hfm22mOUMohV156mgSltvlh6VM5/WQCjFqmwq9G8PLz3kLqcWk
 pkQ8xdcKF5D+Zs9zbTWpZ2+dlojuXlBOl//Xt3TKNGDvdlw3LNcLZJqShlxU5E21NN/ggXzKB
 zt7LgxGTTkULlYD+g5J3pccUgbJFjsuYelPDjTjEAU3AKqpYuqI3N6og3/GyQ60287KKjc3nM
 S5MF3dqki0njPPjxKcdMvdUff8Eh8MZDals5whPwpIIPZIQFdfiN9/FWT9ZPatigJWLmd4Sv9
 4KTjA/5/jY/6Glff8XyQvcHL4AnkVBMFmBIJHhzanmgjigtRAdbNZ1SYaHG/t0Cfq2ek3yQ7H
 Cjc7fuoRHQej3RZ2wyDukVCD7TVltYrSG2auBQFkm/KlzMOaNyd99Bt+qc5mAniTtKtnSbG3M
 3rgeMAM0qgATg3Z9Doqt8q8lUWSxqqVu6hZx2rlKlDWmEmWs3Dyn8NL6EwIOEzcVQSF+ExfhW
 92ERd7DFW+SdWQLiV7df3SBi8K+mEPOuRrnnQorziEr1t+YjoD6q+e948yry43tMjmRWQnKgC
 DkEPrg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.12.22 um 13:53 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Sat, Dec 03 2022, Ren=C3=A9 Scharfe wrote:
>
>> Am 03.12.22 um 06:09 schrieb Eric Sunshine:
>>> On Fri, Dec 2, 2022 at 11:51 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote=
:
>>>> Use tee(1) to replace two calls of cat(1) for writing files with
>>>> different line endings.  That's shorter and spawns less processes.
>>>> [...]
>>>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>>>> ---
>>>> diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
>>>> @@ -9,8 +9,7 @@ LIB_CRLF_BRANCHES=3D""
>>>>  create_crlf_ref () {
>>>> -       cat >.crlf-orig-$branch.txt &&
>>>> -       cat .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch=
.txt &&
>>>> +       tee .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch=
.txt &&
>>>
>>> This feels slightly magical and more difficult to reason about than
>>> using simple redirection to eliminate the second `cat`. Wouldn't this
>>> work just as well?
>>>
>>>     cat >.crlf-orig-$branch.txt &&
>>>     append_cr <.crlf-orig-$branch.txt >.crlf-message-$branch.txt &&
>>
>> It would work, of course, but this is the exact use case for tee(1).  N=
o
>> repetition, no extra redirection symbols, just an nicely fitting piece
>> of pipework.  Don't fear the tee! ;-)
>>
>> (I'm delighted to learn from https://en.wikipedia.org/wiki/Tee_(command=
)
>> that PowerShell has a tee command as well.)
>
> I don't really care, but I must say I agree with Eric here. Not having
> surprising patterns in the test suite has a value of its own.

That's a good general guideline, but I wouldn't have expected a pipe
with three holes to startle anyone. *shrug*

> In this case I wonder if you want to optimize this whether we couldn't
> do much better with "test_commit_bulk", maybe by teaching it a small set
> of new tricks.
>
> I.e. if I do:
>
> 	git fast-export --all
>
> At the end of the setup test it seems we just end up with refs with
> names that correspond to their contents, and with double newlines in
> them or whatever. This is a lot of "grep", "sed", "tr" etc. just to end
> up with that.
>
> So maybe we can create them as a patch, possibly with some slight "sed"
> munging on the input stream, just just teach it to accept a "ref prefix"
> and "commit message contents". That could just be an argument that you
> "$(printf "...")", so we don't even need a sub-process....

The files are used later for verification, so their contents can't just
be passed on via parameters.

Had a similar idea and spent too much time on creating the four files in
a single awk invocation.  The code was too verbose and yet hard to read
for my taste.

> Also this:
>
>      perl -wE 'say for 1..1024*100' | tee /tmp/x | perl -nE 'print "in: =
$_"; exit 1 if $_ =3D=3D 512'; tail -n 1 /tmp/x
>
> Isn't deterministic. Now, in this case I doubt it matters, but it's nice
> to have intermediate files in the test suite be determanistic, i.e. to
> always have the full content be in the file at the top after the "top".

Whoa, such a one-liner is a good argument for banishing Perl.

So to rephrase it in a way that I can understand, you say that something
like this:

	$ cd /tmp; seq 100000 | tee x | head -1 >/dev/null; wc -l x

... will probably report less than 100000 lines because the downpipe
command ends the whole thing early.

> With a "tee" you need to worry about the "append_cr" function it's being
> piped in stopping the stdin.
>
> I don't think it matters in this case, but in general as a pattern: I do
> fear the "tee" a bit :)

Right, append_cr reads until EOF.

Ren=C3=A9

