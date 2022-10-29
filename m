Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD3FC433FE
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 10:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiJ2KGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 06:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJ2KGM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 06:06:12 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E75E7B7AA
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 03:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1667037954; bh=T9MZiciMtWUXsmIDs0SNnAUnm5RwlTjrjEHOvk6ywjo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=uS8UkxLkJuUl0o+GpUBf+H904P23V+/nE69cyDq7PZ7RhtGe0J7ElyA8gwhpvo2QW
         xa5aplVoxYH+rFHNTqpoJHlt5rhYBDcDupLU0NSoHjTVm9s3SoSoJNsr7NneHjZN0B
         aHzUUq/q4G1ngAO99ZtsYKlN6tDwOr976MeXsGhV05KUBT+WKbak2EhOljDZbfDsL6
         S6mDRl5SPZqT93DQatG5nuO2td+47IR+JFz8TD2iTT8juR+UkDfl1N8zHiAsg/uYTu
         MPna5mLg5wslBKDWumFlZkblds8wVCBx/cMMkK+h/h+r3R8xytGeGoebGu3sjco7K7
         zGyjTepLfdPfg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.34] ([79.203.23.191]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6091-1oiuu92rQB-007YKm; Sat, 29
 Oct 2022 12:05:54 +0200
Message-ID: <9f300d06-a595-5f21-c97a-7b8c6b02b866@web.de>
Date:   Sat, 29 Oct 2022 12:05:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 0/8] run-command: remove run_command_v_*()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <221028.86edusan0k.gmgdl@evledraar.gmail.com>
 <749f6adc-928a-0978-e3a1-2ede9f07def0@web.de>
 <221028.8635b87wo6.gmgdl@evledraar.gmail.com>
 <b200477c-f856-f107-b897-63721c805093@web.de>
 <221029.86y1sz74ez.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <221029.86y1sz74ez.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N3KJWiJfOSgJ60KAi3aFa51QMnzlhDOrZ4Z4ls9XGBYOB0KTZUS
 hUvmwVIYKLMAeRPtwbEMpPZfhdfiShSfwcjAjhAxYHH/kKNanUzr5xHVPewuuGw5M2IhOlg
 8HuoNF3+ndStAB05o1df92R+0QqzfDJeiTksjRUWfNprM+3wKlAUKa/9EoP79XRzxrGXNfS
 X0Xlz1flZsT2FbWc4jUjg==
UI-OutboundReport: notjunk:1;M01:P0:JirTG7Nx4dg=;AK9VeiEcDjP6xvfMcDcjwQz0YLF
 fAzYqsHrTOppmahvYyofrrSrust7ltbUKMeqJSSLadt5AxDaFpQref4VfxOLSK0MDP++rOI7k
 CtouD0+tT9Y0/v3Pg/1gCuzkJFjtynAYoZn8jxiwTn4L6UoSZ5puDO/KEDdVIWc6M7H1/EAsN
 Q25jRM35zeT3yTglrIrC/EOcM3tyHwun69MaPVcTsmw3lKBfir4GsdDuhIqgieEyHhmQ1542p
 xPEbETBQmDRc7lgsFX+i54/n36xyNfeJTrlEpiBNMBZd3ASVjPaRb4p73A1b0iRZARW1R5wMD
 T0I83vEvhbEaPyNlw/Xo2j2dkYa283MfnUEYQIew+03vqR42P0I5JiPBLHXfcSTnqDg1+D4EL
 4l6xkShTEgt7H2Awk++hqt5n0A8wJFpaUBKrCtR8vmO4eujc3Hi6j6bB3+I415rR1pc1tmmxV
 /tSRii3gIDLjbCvCLpN+I1bWVI5xu3xGhvGrv4JQkTOsMZzi4wksZiO3tj2YezEWixQCOuQ21
 VEq6ISm2OwnzZ957w1RoZeu0M6zzt+DO9TrtdwpvuadJ67wfuX/vYxxJln3IBd9mOPcBUft6n
 4KMJfN7r0i5kqL5SEFQwJUcKJawbdZ/muXp0nh0LohGcNJCK3z7JbMnJ7NE8sy8+vBBwK1DA5
 pwg/Pm8/MzIUGktOIqunQYNhZeu6Ng26YXlejF0r+Ss7YHOY4kCxDCJzVYrkiEbrcKSpcyu2X
 xDS1EpLKEYOsIl4aCJitLrk7xWOCOcI3tx48SzryVsgah1uihrXb+B02wwXpwQy8PCQTPxHWs
 63A1bNvHwFhGs73X1EEmVZ572qKk2q/nlBsYwldmLWaskQic+tLC/5plWAMnIF7scE6iM289Z
 rolrfYvlBlpSegkP08MlZR+mfxCV/CS5+tfLS3Y2Jp0VXk6bNymokVeu4YCyF/UdHyBGpem1P
 8hgsIvkE5GtSM3unhnYruX7H7Mc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.10.2022 um 04:17 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Fri, Oct 28 2022, Ren=C3=A9 Scharfe wrote:
>
>> Wait a second: Does it even make sense to mention the command in a die(=
)
>> message after start_command() failed?  Unless .silent_exec_failure is
>> set, start_command() already reports it.  E.g. archive-tar.c has:
>>
>> 	if (start_command(&filter) < 0)
>> 		die_errno(_("unable to start '%s' filter"), cmd.buf);
>>
>> ... and the result looks like this upon failure:
>>
>>    $ git -c tar.tgz.command=3Dnonsense archive --format=3Dtgz HEAD
>>    error: cannot run nonsense: No such file or directory
>>    fatal: unable to start 'nonsense' filter: No such file or directory
>>
>> The second message is mostly redundant, but it mentions that the failed
>> command was a filter.  Probably .silent_exec_failure should be set here=
,
>> then the die() message is no longer redundant.  This requires args[0] t=
o
>> be stored outside of struct child_process, though, which is already don=
e
>> here, but may be a bit tedious in other cases.
>
> Yes, maybe these messages aren't all that useful. But note that that
> "error" is emittted by thy "#ifndef ...WINDOWS..." part of the code. See
> also the recent 255a6f91ae4 (t1800: correct test to handle Cygwin,
> 2022-09-15).

On Windows I get:

  $ git -c tar.tgz.command=3Dnonsense archive --format=3Dtgz HEAD
  error: cannot spawn nonsense: No such file or directory
  fatal: unable to start 'nonsense' filter: No such file or directory

>> So for start_command(), would it be a generally useful to support a
>> scenario where upon failure
>>
>> - the program terminates,
>> - but before that prints a single message,
>> - which includes the command that could not be started
>
> Isn't this just the "cannot spawn"/"cannot fork" etc. messaging from
> start_command() now?

Sure, a subset is easy, but do we need all four points?

>> - and some kind of hint why we tried to start it?

I suspect .silent_exec_failure suffices for most cases.  Testing calls
of commands that usually exist is a bit hard without source code
changes, though.  Then again: Beatifying messages that will almost
never be seen isn't probably worth it anyway.

But I'll send a patch for the archive case above.

Ren=C3=A9
