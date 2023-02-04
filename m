Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD9DC61DA4
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 18:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjBDSI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 13:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjBDSI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 13:08:57 -0500
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A3A2E822
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 10:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1675534121; bh=2dXyfYmy3WdPL9C/6ItynfDKpRdHkMTEdZICdx4SZtM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=NmybpN0uK6GqBqgkw90F+pA44xnE5Y+qVPr1iDI2MMzcyXdjng+nERtzJhpcwX5AZ
         DTm7w58uYCCK5qYi30gC2PXJWWUcMFjaQtD6dp8muqbX5vLW++FIHCinyeHyz0Cmly
         wIusPpHvy1r1loELcVQ2/AbALcHjIRiUIbCs7YLajUmrz9gP/qQIx3d2D6VIcGymgX
         CciAzmL4m35UwMOILG10lMjPEi6AuM3nZDclMUP0Dzvui6eo0/RHStrF17FN7VCupf
         ldEDmWQSg5Djuyzfh1uVuI41JXJFd3Gr7o40MuPxKouZD7spcG1GfmtfikXOAhlzSa
         ztnLThlz5mYlg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MxpiU-1oPDtu3gkg-00zICq; Sat, 04
 Feb 2023 19:08:40 +0100
Message-ID: <c3f215ca-b4ae-79a2-c14a-3c0f1799e6f7@web.de>
Date:   Sat, 4 Feb 2023 19:08:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 0/9] git archive: use gzip again by default, document
 output stabilty
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eli Schwartz <eschwartz93@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>
References: <230131.86357rrtsg.gmgdl@evledraar.gmail.com>
 <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
 <xmqq5yckvxtb.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq5yckvxtb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JjPAO/uxHXcwc5L0DQlWb7NQ9vpUBa7BI3ADEfOxJt720ZS3f0h
 iWG24z5nwm/gBFhzBCeVBlEQvRrkzkX+nc+B8mUauWvnrZYpJJ990ejxJ49f6T3kECSgJ+I
 ZPJFqeckFIj6hjf+zeUukfyC562KAdtwySnUWV6iL+N/cDSXWWdhARYpKPGH7q8QReiRuOc
 4T5HQzeywCVFFnpm/x64A==
UI-OutboundReport: notjunk:1;M01:P0:qKnNh358nL0=;60MnSrKzNJryVhe3TjJVdpcCgq2
 iiN0OyqQqfjhtnMX81/TZDBtdexBhDedi5s5ZUQdJZZNWVjFQKgBhgTTIJ/u9Iz+P5YF+uuqg
 hr/J1kQpWCJdPIKwuxs7ZUU+wbhpVdkxDmGZUjMLViRVOCW/P4N4Jnw5xh2Zbcb89yperM5iO
 r6gm4E8XjuEB+MwWyZlNLrGqJ6MhCzMD6gQKCbTW4svVErmD4ynIxos7dvXDtPkTGdZ3hod8P
 A5kXrKlY5oeZrgKYIxUdfWx2oI9/7cpV05+jGGKkg2ROpEVSgYVJD8ukUaVUjmhP5PF7NzWsL
 kP1Ozy/FPsZ4x3Y1NuaBu6Ia9NCGy+H0PYL/dkcCen+Ckqxvq4cQ9kQNh51Wq7lLhWqLFFvhM
 ehVfsoxopdxVZRdR13YAIFKa/oUUu3ylXMXhcXpl2nByzuqfr/hupstAzCYT2Hh/OIn8qdCCd
 zbvGhrg9+DIEcT+3wZ1hUly2nn0JLGNw76h5PES0B8b/oOE+CbyeJfO+F1YRfji6vP6WzXeTy
 kTBiAE9FprLqgmUYXXOEhKU4Ns9X9vRkM543+agq+PHE0HpdRDO4eRVwsuZrHU/ZL3qx+qAn7
 ARfSQMxcbys7sP6PqSFF7FpUNw1pzfle2jdcPAHBvZnI3JExG221955dVTMc3O7AuCpuSqKJM
 0QKWF5BrMusw0urjAef4zUce5zNnFweEde/vuAg65oihJoqHH43Fb4wEUd1ULOACejxc5SeJT
 vkYmaIZ1ZzR6ogcx4CM92XIDsuu9sd5z8sNvKgw0Ya65zMDWdzxdox7qUyPP6X7GEOJv4JdJc
 wMATgSf9WfcIbdI4MDYXuNwPo41POKz3KDPckCod59D+i5axRyrRIAn5PD1JOTab1m0pLHM+M
 v8rw4b9P5skmCqfCKuYakXWNCBW/4TuozPH+LxAzeePSBO/fPwj6JIJDjd0t3b8+18jUuV4pT
 qv1xZbxFbcdJRmkvnLEr1NSHkqE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.02.23 um 17:25 schrieb Junio C Hamano:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> As the disruption of changing the default isn't worth it, let's use
>> gzip(1) again by default, and only fall back on the new "git archive
>> gzip" if it isn't available.
>
> It perhaps is OK, and lets us answer "ugh, the compressed output of
> 'git archive' is unstable again" with "we didn't change anything,
> perhaps you changed your gzip(1)?" when they fix bugs or improve
> compression or whatever.  Of course that is not an overall win for
> the end users, but in the short term until gzip gets such a change,
> we would presumably get the "same" output as before.

Restoring the old default is an understandable reflex.  In theory it
worsens consistency and stability of the output, but in practice using
whatever was found in $PATH did work before -- or at least it was not
our problem if it didn't.

Are there still people left that would benefit from such a step back,
however?  As far as I understand forges like GitHub relied on git
archive producing the same tgz output across versions.  That assumption
was violated, trust lost.  They had to learn about the configuration
option tar.tgz.command or find some other way to cope.  Changing the
default again won't undo that.

Ren=C3=A9

