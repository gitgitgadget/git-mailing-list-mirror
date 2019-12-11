Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18374C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 17:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A992173E
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 17:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="DxotfQfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbfLKRuN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:50:13 -0500
Received: from mout.web.de ([217.72.192.78]:45619 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbfLKRuN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 12:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576086607;
        bh=Ood6iiUfig0R4G6okfy/lu+qhXWEb4QbfKg33tgFM4E=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=DxotfQfpHJ7JwSvJlvaIJlky9gbF6qJQ1yNVhk5LV/rJ8DuBdfBp29gPP49He3KPz
         JnLXDbmYxCr+KI1H89XrngbU8atZTbAURzADjdJeQcVCaL0Wax8/6exXNHZN+RvjuT
         ZzXqjnT/s2yNrfTpEPIt70nCy3QRABaJbCpdJXDk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.158.92]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lx7Mz-1hdD0g1rwX-016dLK; Wed, 11
 Dec 2019 18:50:07 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] t4256: don't create unused file
Message-ID: <4918ed10-8fb4-ddea-36eb-adc683955356@web.de>
Date:   Wed, 11 Dec 2019 18:50:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FskBrarBb6sNc0tOT2GCuHG7RngS+tZZVe53QfQDEru9QPwUnk4
 wGESm6nuSSfY4TZ0C/TxIpcHBwn1C1pHA4vf5Exx/GIpWBlIYfY6uyWjkaqUBQ65OVo5Qv1
 E0v3aVo972Wgz/NANtkubSRVP2ArMH/CL8b0pG1rIk8FBhKgpT1JEo88fo6Th10QiIvydCc
 XXVmZly1uNogAhMD66MTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bFf1j2kAul0=:p7LnUj7M79Qf2tCv7c+8PP
 GMIay2M0FUIw2Blh+hGPDC0iEkhpReWWRdTkJXg3ZQXGeAGpxWofYe8NfE65mqnq6oU03N3zD
 CLfWrjouPFye9sXO4197cpNOwB1DNdzcoSlshRoUJ9dhomDNNhLApcAm1im2ZXchPSUyBbJR1
 LVXeABkzQ4rTVxPh9fhu6GXOKVaToxdibTpSBOK6dnX7/lQQeCAX3VYSnzbDcHWA4blBjHVQn
 WazywyCVKzydj1JthKOxEgojxJvZuETO/vjHEx9b/uKDzzOVJGrOuYl3/xxEyXnzUuodB30jL
 /2UzpuuZVjhX8BRnmdFIMPQxTvk9R/jD6dZAIazAhYNIbAZyPNaehFPIQkPi4aROwdSg5GlHi
 WfXVdME0EnOw6qj5lIrlBUP3/7qCZexuxRVrfuu7aT54J6ckxpdXmdCsD1gFs67LUncDvbPOM
 yRdZIFw1veAo/5My/Zye2hRkYhionEAu0Cmn1EANCS9kQpx/O0R12IRuhYRadKuGUbuTyRWN9
 5itUzuY+Yg7evKDMYINNzQI3nYCkloxcubnQld3pJgFukCLJKRyTI0q2gU52OUtOm1+pt6hpz
 wrXAAverMUFvTO6gLk81Qdj1awcKBmZk6UydDIid4g0REq5hrje3qD1j2mG8bZ6IE+tzlJC0i
 3Eg4NPY+bs2j53FzOoHkRyyhy2wrpfKJUQsoUoSdTlSzDUVX+hzbtryWVswrDM8Xqj+uLclGO
 dF81cc2TumTa8WCwM6qlV53DmG8NXVm+kehaap6LuZqFM+4xPtPjk/Q/sIyh9ZoBB5F88UCgj
 4/HzWENAHuc3T5pHfY6+vRSOeEkhynbriepEFnffmJRSQve36Tq1KVul7Bx6lkyUaXbpLC8Uo
 84SjMUGwW34Keyyu2tD/vsdU/C5uif1DCdI2zTUj1enXWWweqbAGbiWZyAIJRXwNMPX21a82Q
 0cr5Jtoz1pqqjccLFseFib+ZBf7UEimtex76/AQr5cbFg4HREiYfLCZQhPFqV1NiipA6i01eM
 u9WZ6JwDjNSsFtxuaJStrmKDZlV2TrlOT5P/EjXF887gHLQUXDr3lNAX+aVz8ciCIe+EXcIsW
 6QJoQ+OinPQQlZpZ4pO2rGTxfMHhOj7FiA1+sg0Kp0xY9hYH1iAGNranp82+RNljaiRWr2XrE
 44u0we6YSvN7dxsKqY4BY9NXfdlOT9Ky/1W0eUAQO2ywZ0FV63vg8MBq+RRk9ly0i4yHIJlEd
 yE/rEw9BAUboYGgv/dtsfFl3mNfVdF2nERjQv3w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The file "stdout" has been created by the test script since its initial
(and so far only) version added by 3aa4d81f88 (mailinfo: support
format=3Dflowed, 2018-08-25), but has never been used.  Get rid of it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t4256-am-format-flowed.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4256-am-format-flowed.sh b/t/t4256-am-format-flowed.sh
index 6340310e9a..2369c4e17a 100755
=2D-- a/t/t4256-am-format-flowed.sh
+++ b/t/t4256-am-format-flowed.sh
@@ -11,7 +11,7 @@ test_expect_success 'setup' '
 '

 test_expect_success 'am with format=3Dflowed' '
-	git am <"$TEST_DIRECTORY/t4256/1/patch" >stdout 2>stderr &&
+	git am <"$TEST_DIRECTORY/t4256/1/patch" 2>stderr &&
 	test_i18ngrep "warning: Patch sent with format=3Dflowed" stderr &&
 	test_cmp "$TEST_DIRECTORY/t4256/1/mailinfo.c" mailinfo.c
 '
=2D-
2.24.1
