Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C8FC4332F
	for <git@archiver.kernel.org>; Sat,  3 Dec 2022 07:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiLCHJd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Dec 2022 02:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLCHJc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2022 02:09:32 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E10F140F5
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 23:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1670051364; bh=w5eAJ39IghDzUSM3QjiiBFOCWj3jk/xfTIArS/W7Y0c=;
        h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:In-Reply-To;
        b=cXJ90iFgUeHjUldx4cAF1lUVIRG7eqLX1pypf7rLgZ99M4HJknjox/1ePJomV6lAx
         6j2sDSXoucIaAlDPyA9muMpUCPIUg2MvIw/w1NKT1V664mQDjU3J3RdDWIUzKcOOEs
         oXMBr39Jzhr4hNoiP0RA0Lm5g6xTqQY+eCBA2P8kYXb0U4A3rkoSMUKiQ1yx72Kw6w
         CYLjr1AwBrsfXm/T4A6dPhAehNY5m6vbAkl75Ax19ILLScJdz8BlorU6Dx+tu8G/OK
         r4pAJCz9uyKR9ZrhL1yT1cBZlr4iZi0CBaehaYXTGnjgzdXauVNOedWeoa3LaHPI8u
         +AmaQT868gBxg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.34] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MfKtN-1oTweF2Bpb-00gdCl; Sat, 03
 Dec 2022 08:09:24 +0100
Message-ID: <ae2862dd-78c2-238f-46df-4a25643046ae@web.de>
Date:   Sat, 3 Dec 2022 08:09:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 2/1] t3920: support CR-eating grep
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
 <cbe88abc-c1fb-cb50-6057-47ff27f7a12d@web.de>
 <cd92755f-de16-0df9-075e-2bd5ab0dd4fb@gmail.com>
Content-Language: en-US
In-Reply-To: <cd92755f-de16-0df9-075e-2bd5ab0dd4fb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MOcOFHSPXjQtHxIYi2RX8qqhNY0CZPzp1EJHK81cJN6kAO8424R
 30IBzNh+AgJogx+OuKIkAbPk9taWrfLDBgPxBCh8mQqgn+qb+sc9W0zsuDaxCHXD6dWWtZD
 Um7YUWCqB9bd3d9uc6WDlz6/OMR/mUhwisjZ7oenw6jZUdXuIEiW6zdpraQoK/YZYe/X5oV
 ntBBTV2xKvPn71Am96Sjw==
UI-OutboundReport: notjunk:1;M01:P0:VHqljxBvNWE=;O3JsAB6msDGaH7EuOS6X+pHlvN7
 zGckVGxbU3ou3okcbSC8GGYxXtcFlJEDaMmfX39KVlsySZU0j0l5kKKz/q0Fxd6yk8jP4dpdJ
 t5upI4YDJG/IFlK3TbB18nkc7uhivaHeY7rNM/dcaIwLQun9lZ2xEMQ5jHBSGW6KSSK5rjLzN
 4/dggSYXdH44pO5OqOIv4SLO6O9fFpyBcatP7i5/Cig+pC86GPzCPiSEgVEmi852JB9vPc0lJ
 EET0sZNeiZsmib7u8yg8tc7IBx+QykqhWQbmeHiYBVyri5CYgzfGqOULxUOeki113hDwMYuRG
 ElhPxiCpB63g3mz5woBDFLX1YKVesEjhACwspR7WJ3k+G1PpsV1GzXzM7j7PWq1hXeA91+1yH
 XH+omocu8nrTeIX+NEXayHjEEL5dIegWnM3/V34bGyVExmyFSEtHwbZ5K850ezP0IYv7B6GnK
 stOu+gZQayjODlBZNUjaCQm1nT8VIk08r0dYkOgp1XXaf1KVtLI4pzWlo2j05dMy3zFAUIIgU
 3IwRbX12o8OWaQeeFks/s5wMyINVrml+yva85/Yevp7rr+L73qmK2DvqEC/EanZHsGhfE7DOV
 YYYr9VHhNJhnew5SfSDM5oAmfQ1TC1rOf9gvm7DHlVO9c9ANrl47QlCry5TFO2aaqZmHoC/vQ
 pnBrsnu9rNmyMbFxuJEccZACwaSHwC8B+v4cfrKhjjAmSvLWP57dHkkuH6r8v++wd+cpiMA6X
 jWW/FeadXWcRvIwxEXzdhCIAJbnf+jWn1gGRaji48Z6+HgftbSS/Bdd1rFhPI1zEKRpX0hDRL
 /THOoGrBaZ3wD78rJvR/ENxqsbvkfwcHA/9uaSxoN5QGZUgBFzrGk74mluDko+r2L5eqkvMFp
 6hCdIwQhu1Be2PKfcm12Q4BZSsN8GdQdOrzOO/ZmIj4xWJkpk2mhxN101tc8zmdDv3Vhx/ro7
 FAyH3Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.12.22 um 00:14 schrieb Philippe Blain:
> Hi Ren=C3=A9,
>
> Le 2022-12-02 =C3=A0 11:51, Ren=C3=A9 Scharfe a =C3=A9crit=C2=A0:
>> grep(1) converts CRLF line endings to CR on current MinGW:
>>
>>    $ uname -sr
>>    MINGW64_NT-10.0-22621 3.3.6-341.x86_64
>
> I don't really know the conventions in this regards, but for me
> "MinGW" refers to the port of GCC to Windows. Here it would be more
> correct to refer to "the Git for Windows flavor of MSYS2" or something
> like this, in my (maybe uninformed) opinion.

The thing I downloaded and installed is the "Git for Windows SDK", so I
could use that name instead.

>
>>
>>    $ printf 'a\r\n' | hexdump.exe -C
>>    00000000  61 0d 0a                                          |a..|
>>    00000003
>>
>>    $ printf 'a\r\n' | grep . | hexdump.exe -C
>>    00000000  61 0a                                             |a.|
>>    00000002
>>
>> Create the intended test file by grepping the original file with LF
>> line endings and adding CRs explicitly.
>>
>> The missing CRs went unnoticed because test_cmp on MinGW ignores line
>> endings since 4d715ac05c (Windows: a test_cmp that is agnostic to rando=
m
>> LF <> CRLF conversions, 2013-10-26).
>
> Reading that commit's messages, if I understand correctly it's more MSYS=
2's Bash
> that is the culprit, rather than its grep, no?

4d715ac05c blames bash for converting LF to CRLF.  Above I blame grep
for converting CRLF to LF.  The experiment to confirm the latter leaves
the possibility that bash somehow inserts a CR eater between grep and
hexdump.  If it does then it is quite selective; e.g. cat passes CRs on
unscathed:

   $ printf 'a\r\nb\n' | grep . | hexdump.exe -C
   00000000  61 0a 62 0a                                       |a.b.|
   00000004

   $ printf 'a\r\nb\n' | cat | hexdump.exe -C
   00000000  61 0d 0a 62 0a                                    |a..b.|
   00000005

>> Fix this test anyway to avoid
>> depending on that special test_cmp behavior, especially since this is
>> the only test that needs it.
>
> Do you mean the only test in that file, or in the whole Git test suite (=
which would
> mean after this series we could completely remove the Windows-specific '=
test_cmp' ) ?

Both.

>>
>> Piping the output of grep(1) through append_cr has the side-effect of
>> ignoring its return value.  That means we no longer need the explicit
>> "|| true" to support commit messages without a body.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  t/t3920-crlf-messages.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
>> index a58522c163..67fd2345af 100755
>> --- a/t/t3920-crlf-messages.sh
>> +++ b/t/t3920-crlf-messages.sh
>> @@ -12,7 +12,7 @@ create_crlf_ref () {
>>  	cat >.crlf-orig-$branch.txt &&
>>  	cat .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch.txt &&
>>  	grep 'Subject' .crlf-orig-$branch.txt | tr '\n' ' ' | sed 's/[ ]*$//'=
 | tr -d '\n' >.crlf-subject-$branch.txt &&
>> -	{ grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt || tr=
ue; } &&
>> +	grep 'Body' .crlf-orig-$branch.txt | append_cr >.crlf-body-$branch.tx=
t &&
>>  	LIB_CRLF_BRANCHES=3D"${LIB_CRLF_BRANCHES} ${branch}" &&
>>  	test_tick &&
>>  	hash=3D$(git commit-tree HEAD^{tree} -p HEAD -F .crlf-message-${branc=
h}.txt) &&
>> --
>> 2.38.1.windows.1
>>
>
> apart from the minor things in the commit message, the 3 patches look go=
od to me :)
> Here is my Acked-by: for all 3 :
>
> Acked-by: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Thanks for detailed messages as always, it definitely went over my radar=
 at the time
> that both 'grep' and  'test_cmp' acted differently on Windows.
>
> Cheers,
> Philippe.
> p.s. I wonder what happened for format-patch to generate these 2/1, 3/1 =
and 4/1 patch prefixes :P

Hand-edited..

Ren=C3=A9
