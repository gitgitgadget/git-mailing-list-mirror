Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6360C433FE
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 09:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiKTJ3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 04:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKTJ3f (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 04:29:35 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50442FAE6
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 01:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1668936566; bh=hYyqINRYQjbsANLsN78Y4wLd0ZxatKIXQPyJvy3yCuI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=j6rl49/cyADL6wUB+tzXy9KunnPuS2NFtleZ7DFnCdAARMscV+VzVOzW/mTCtAlRB
         ytJheWGzrDuynrWuFMkVCWHs/anm3YYOxnjqWRl6SbLTG+pliZbztyk/HmJNwU9EBE
         AiSqIpAjC8sgNO/vUyi7DqrdMBy5q7kLoxb7uIB8GdHfK0Xt0Hdlx8knLdcAcxmFiy
         iZ3ptsYQZZiktd8qaz3GkRd9IRMtc/fEy1m80dHkXno45shGtQFAF5Qnz/M/EoP8MQ
         VnlQOwXg9jD1p6r5S0LykOhAGH7GCvk2e8qRwv2va7f77lnR8Mqfdke/AXQ70qVae3
         DWt1j4rh4TJiw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MAtwh-1olNxn1COn-00B9Q2; Sun, 20
 Nov 2022 10:29:26 +0100
Date:   Sun, 20 Nov 2022 10:29:25 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
Message-ID: <20221120092925.z5jv2e2rtfpota6t@tb-raspi4>
References: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
 <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
 <a7f4265ceb26c6dd9d347ef4cbef2aac7d60bf13.1668290855.git.gitgitgadget@gmail.com>
 <Y3B36HjDJhIY5jNz@nand.local>
 <xmqqv8nbkg77.fsf@gitster.g>
 <65ff24be-4392-f236-5500-ce0c0d4d42ca@kdbg.org>
 <f5d6c063-2fc4-4355-57e1-056eac1fb4a2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f5d6c063-2fc4-4355-57e1-056eac1fb4a2@web.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:YSFL0QFA6OQyTcV1Si01akoi2sQ7Kr6NpWZzXMUjPZ97iJVXvho
 0UCNaZqrfkLySIYtV8+J/484iuOjmrnAk7XEu+Qj65mHwAfKYzUowAP3K3rT9YcZVvuDwZO
 t7CD95M7unaZmy/JxrSbiMae1s+weQzOmOQ8uvb88RZIDyu6FIRDsZBiNOFHksal8KMv72y
 gH7NcIHZC2R4tcZSiqLFw==
UI-OutboundReport: notjunk:1;M01:P0:ozmD4sl8W0Y=;Ya+j2O0lNfuy71YfQ3tJmnyyTHN
 AsT70OeE0kDExUZJdjxH10ocNb9QyyGk3Wdy0LufZmGfN4g/XqJ3tFtUaIzIt3AK2joAfx1V3
 yaWG4PQFFoBnrq0GHi5kCFubODIZkHUO6N4S6R4G2LcdW/m8xnzR1AJK/JCY+xFhtSfIPFTiF
 Hb4AaLz4HiK6V7jFeZBTStKjVQNVgmAtTSWtk4shtRPTCZGNiPiTJNCONi2AjDiLebpnXCeGi
 XH/0r40lHy3WF68fNK0j6pZhNd0rtPzXpBZGRVFchzD1HLrP+xd0bsqbUjC88ykOvoFOqWQro
 vhbphS6xpvF7DobSpQqS/txwg1lm1SFzFB87Th8tJ+YzkoMJyOREE/FMaAc0m9UefAT5HodPX
 CdTfyOKr6t7+C5/DJT9u+3zuZLw5TihqzjiraecwY7UxM4p+ZJm1xqs69e5ukm7Ve+g2EZtKU
 VKNWjSQ5ZeDHxZShgd92zNwExxijOpRy9x2tvP6B4sGFLBW5nGFPcNpwAqnyfqq1BIWiJKBTQ
 UzMPNVotark0zbC7sLMf2IwK1PEbTpAzL8CsMLNK2+MY+T7qIGJJDy33hkE5tISoXtjWORZMS
 QeNYadZtDa/YlXxRZRf8ij70Rec/4iksKVmY2TLclRMzNarRhhqwjUxJIS3a/UvWw9ZM5bvqU
 sTrNmjNsdZzpiEGh239nahiTvuhbs7nnalnkGyLvJXgOqj4t8nuNUigL8Dme7v3k90Uee2oHF
 4oBKi+m0YDDXNVQIMf8ZGwCvP0r9lCjWbbBvwj+r5zSv2lZtxb0gd0MSDE7TMSWYvYGLr8mzq
 gY3xdl8H7uzZjr+xsWSwVhfoFRCkP0Juicj62Y8Kw1YEwb22XxV7NyCR3BuupVb8wutUmRgex
 /b0EW+ilau727zu8fXBLdx6Q1lcR1olZiSZwrislOid6bLIqQotf1plmDQHCuw5NQXCIg0Szz
 T9i3lzC+q2VYZ5F2HgMvNhxUchc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 19, 2022 at 06:50:28PM +0100, Ren=E9 Scharfe wrote:
> Am 19.11.2022 um 09:18 schrieb Johannes Sixt:
> >
> > The reason that mingw_test_cmp exists is not that Git isn't ported
> > correctly, or that tests aren't ported correctly. The reason is that
> > tests assume Unix LF line endings everywhere, but there are some tools
> > that are outside our control that randomly -- to the layman's eye --
> > produce CRLF line endings even when their input has LF style.
> >
> > For example, when we post-process Git output with `sed`, the result
> > suddenly has CRLF line endings instead of LF that the input had.
>
> Actually I see the opposite behavior -- sed eats CRs on an up-to-date
> Git for Windows SDK:
>
>    $ uname -s
>    MINGW64_NT-10.0-22621
>
>    $ printf 'a\r\n' | hexdump.exe -C
>    00000000  61 0d 0a                                          |a..|
>    00000003
>
>    $ printf 'a\r\n' | sed '' | hexdump.exe -C
>    00000000  61 0a                                             |a.|
>    00000002


There is a "-b" option for sed under MINGW;
 -b, --binary
                  open files in binary mode (CR+LFs are not processed spec=
ially)

The CRLF handling for sed (and probably grep and awk) had beed changed in =
cygwin
https://cygwin.com/pipermail/cygwin/2017-June/233133.html

(And I suspect that this rippled into MINGW some day)


>
> And with the following patch on top of eea7033409 (The twelfth batch,
> 2022-11-14) the test suite passes for me -- just one case of grep
> stealing CRs seems to need adjustment to make mingw_test_cmp
> unnecessary:
>
>  t/t3920-crlf-messages.sh | 2 +-
>  t/test-lib.sh            | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
> index 4c661d4d54..353b1a550e 100755
> --- a/t/t3920-crlf-messages.sh
> +++ b/t/t3920-crlf-messages.sh
> @@ -12,7 +12,7 @@ create_crlf_ref () {
>  	cat >.crlf-orig-$branch.txt &&
>  	cat .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch.txt &&
>  	grep 'Subject' .crlf-orig-$branch.txt | tr '\n' ' ' | sed 's/[ ]*$//' =
| tr -d '\n' >.crlf-subject-$branch.txt &&
> -	grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt || true =
&&
> +	grep 'Body' .crlf-orig-$branch.txt | append_cr >.crlf-body-$branch.txt=
 || true &&


Talking about grep:
Both grep under Linux, MacOs and MINGW (git bash) seem to have the -U opti=
on:
  -U, --binary              do not strip CR characters at EOL (MSDOS/Windo=
ws)

