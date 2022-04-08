Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AE9C433EF
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 16:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiDHQYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 12:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiDHQYL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 12:24:11 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AA1396AA
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 09:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1649434913;
        bh=mr4bHhO1R5Z7hbxSV5/IjOUpd3Sa68jv2ESME8sLa/8=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=SZi9Y3dKTHjRPVmxEdx+0ehQ31bnabRUFy8CsTHESiM4+CEHu755M4/26tpSu5wIc
         Vlzzzz4LW5JPx9UmAnp2in7AvJWkch5oD0U7G/++RCz129hnVX39Te/p7x9cSiqzJo
         qoUjfhyNgchpRy2RScjrOpTboZGxBvD3wFlKZJr8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.144]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQgks-1nISyV1NSw-00NsxN; Fri, 08
 Apr 2022 18:21:53 +0200
Message-ID: <3a49649d-8ff9-e5a7-e3fd-33fee5068ae8@web.de>
Date:   Fri, 8 Apr 2022 18:21:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH RESEND] t7812: test PCRE2 whitespace bug
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d/zO3qKRIHL9SSJP+GRKsHCDH3NjVy42z0YtBIKkrHrfrefGAok
 IJRfzp0JNgb2H12HrtR6v7HuEwtG3T1e16JKonNGctldsYAyjThKWzKpyoD1SF2QTWrxe9H
 lFH+4rmM8Oixg4+d1pz218tbmVbQrrTAMH5cWgRiuzbiCr76oxg2D4DJRB+lDHoj4+qJrzK
 jnIwhUh/x+NE8BORZEglg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eGmj5GtKgG8=:cEeEltecErsUPYa4rHFUGV
 7xaaEd6Uww2zfP7ds4pbNuIBAjvvzu2jlfvzRHejXDLCgguzr8ZYtVZCE8v8WyYhriYzdU8wy
 G4ua4HEd0zb/GnfjPzFkmZAWa8p0pUb1sfRty0ovg4hBEc4OHGj+XIRi+N4vCQXb/Hoe5vVeR
 fXt+PeA2hX+uTL0jKrcDrZHTU+GGrbgO5Pf14Iil5w7PZQyIXA1K5KEJv69oDgHqbhJtmJYMW
 hCxuI76r5aAATxSaQKwpe9waqOnw4dQxLeMPmyVn26voD3Hj5/QYxwxG/K2opIkb5l6hsy16G
 2qzkEmPvvg+6P6eh3rbF5R67qEzcpk9KIfD2/ynryIc/VSqDWQtaXdLpZ7qDIiUV+BjdXLrgd
 ovkDPIHLAmsD1Xtr2o6Ea7bQL12fJNzM4DXtZIa/m0dVXH6L1rZ5kiPYV4LwRpvWUtp3V0Ohr
 VgW7Qmge3EKUSUfwUxJVMRykT09oHIPwKPCTm6z0yx3fps446/obIqKTsfHxiDr6sOfjCPzI5
 EqwRrNzr0M03dNE6CW27VtNv2X9yifXQpZBJLyQrXMkSTn/EX4vFg84KbjjD99A1dpt2ngEHz
 mrOJSvssxlPF6XwatDGvwwT8gwh1FCAvUaj1PF+KLxRumk68UXHppLJ5LkqJ4VBavgTEO/Yxo
 JP65bqAtjzFFbRF9hWUrOrKsRStSQ0ONLafSI0N759RJkqmKf3dzcvDlSSBSvfuJ6oXkcioqm
 YMWAZcsn2rOYFodoL30uA4Hd+wBt+wyTfpB81SV7Vr0dYMwYUkgh75UydesKQVJvXZKkBQhAm
 EHzCfIznZUP1F6Ng/Ncv7MdqFhPeKKZnKp4p2UIjViZ9ndrZ3cqmuY/eIobsCUN45o/EXGR7b
 Y1dZjQrFzwnX1x6NmN1AynreAW0KKZB3cssq/aB7Wbq6zLvYiLvr1K7gu9bjbSKOFhybBPavX
 +HLkvZV+3mj+X6hM9ROGBqfj0ISc4+B68CMlv30Fn0LtaU/xxjZc5dQRDm/Q9SeS9pkadWWo3
 G0INEeFEOUSeNSebg8ASqUgJEpI6jyIR63VmNrDAAOPoniIHT75kfWgqFoHjFFfN1g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Check if git grep works around the PCRE2 big fixed by their e0c6029
(Fix inifinite loop when a single byte newline is searched in JIT.,
2020-05-29), which affects version 10.35 and earlier.

Searching for leading whitespace also triggers the endless loop.
Set a one-second alarm to abort in case we do get hit by the bug, to
avoid having to wait forever for the test result.

Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Original submission:
https://lore.kernel.org/git/1187feda-c14a-f75c-6e09-4df101f00056@web.de/

 t/t7812-grep-icase-non-ascii.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-asci=
i.sh
index 9047d665a1..ac7be54714 100755
=2D-- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -4,6 +4,10 @@ test_description=3D'grep icase on non-English locales'

 . ./lib-gettext.sh

+doalarm () {
+	perl -e 'alarm shift; exec @ARGV' -- "$@"
+}
+
 test_expect_success GETTEXT_LOCALE 'setup' '
 	test_write_lines "TILRAUN: Hall=C3=B3 Heimur!" >file &&
 	git add file &&
@@ -139,4 +143,10 @@ test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2:=
 grep non-literal ASCII fro
 	test_cmp expected actual
 '

+test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep avoid endless =
loop bug' '
+	echo " Hall=C3=B3" >leading-whitespace &&
+	git add leading-whitespace &&
+	doalarm 1 git grep --perl-regexp "^\s" leading-whitespace
+'
+
 test_done
=2D-
2.35.1
