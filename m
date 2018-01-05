Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87BE11F428
	for <e@80x24.org>; Fri,  5 Jan 2018 18:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbeAESh6 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 5 Jan 2018 13:37:58 -0500
Received: from mut-mta1-se01a-zose1-fr.yulpa.io ([185.49.21.248]:39580 "EHLO
        mut-mta1-se01a-zose1-fr.yulpa.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752418AbeAESh5 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Jan 2018 13:37:57 -0500
Received: from zose-mx-out01.web4all.fr ([185.49.20.46] helo=zose-mta-hub-out-mua-02.web4all.fr)
        by mut-mta1-se01b-fr.yulpa.io with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <git@matthieu-moy.fr>)
        id 1eXWsM-000KRX-DU; Fri, 05 Jan 2018 19:37:56 +0100
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-mua-02.web4all.fr (Postfix) with ESMTP id 7819A60E4A;
        Fri,  5 Jan 2018 19:37:53 +0100 (CET)
Received: from zose-mta-hub-out-mua-02.web4all.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-mua-02.web4all.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id h9mKapslL5CK; Fri,  5 Jan 2018 19:37:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-mua-02.web4all.fr (Postfix) with ESMTP id C9C9860E62;
        Fri,  5 Jan 2018 19:37:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at zose1.web4all.fr
Received: from zose-mta-hub-out-mua-02.web4all.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-mua-02.web4all.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TfJ5SgWJ_dO4; Fri,  5 Jan 2018 19:37:51 +0100 (CET)
Received: from moylip.numericable.fr (3.136.192.77.rev.sfr.net [77.192.136.3])
        (Authenticated sender: matthieu.moy@matthieu-moy.fr)
        by zose-mta-hub-out-mua-02.web4all.fr (Postfix) with ESMTPSA id A0E8860E4A;
        Fri,  5 Jan 2018 19:37:49 +0100 (CET)
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Thomas Adam <thomas@xteddy.org>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: [PATCH v2 3/3] send-email: add test for Linux's get_maintainer.pl
Date:   Fri,  5 Jan 2018 19:36:53 +0100
Message-Id: <1515177413-12526-3-git-send-email-git@matthieu-moy.fr>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1515177413-12526-1-git-send-email-git@matthieu-moy.fr>
References: <1515092151-14423-1-git-send-email-git@matthieu-moy.fr>
 <1515177413-12526-1-git-send-email-git@matthieu-moy.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: 185.49.20.46
X-SpamExperts-Domain: zose1.web4all.fr
X-SpamExperts-Username: 185.49.20.46
Authentication-Results: yulpa.io; auth=pass smtp.auth=185.49.20.46@zose1.web4all.fr
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00222433117345)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5vqK+KGm1OfiCAefGeV3fhDj1g3/PwYZaTCzSym8uE9HPImhfA8k5/zW
 UdbqUfA/+atZAIrjsCRyglG39ay7s40zkSakW8+kgCjGkeOx1qmz3ywmUacsjxjAsJqLMS98bO5z
 ycA319z5HV3CMmoHwxoemuNNL7GGp+zW501rEhQ5LqisX5+l+fRB3wYlhH1KyOfHzJ6mVE7ewsip
 SVIfs4YHwULuSfncWQQCZFmav+TpZoJMI94JyDNTYfA50Otxn/jk0+YoVjbPYBbwrj5eWUnn05F9
 RrS4QR520oMvm0hNEPKqj4wpSPprxfaL4KUPa+d7ax+3+Jf/9S3laQAPwF4OOPS2BLJ6Do0LA2bx
 tTWVqi2fY8oW0hCeiKrXsIHuXDVcbwW2vZRbwlTsaou4YdkkTMgPdccxEqDs1YXBmdsdph+zJwql
 Pd7TjGfWxGLgmXGIZgivQPDIYm4WSM8blQV7LjJv6mzjqKuJJhZmAO87f5jxqIuHmumvO07FITnq
 MT3dKxLhoxcmaInYbR5vlqHMyA/lkPBbC6c0vlSRGDQGZ79loFWGs6aHjUJ9h7NVQthDlN3ZFexZ
 fYgAG9qTPTpp5PS1j/T/np9d21JHIowhCFJI24wA8tcqtUtSzhOuQi6pUSf119XuQl7jsFm5sSbk
 Q6XsptULZibxtxGZ3EQ6uHDPXwCws/YtYuVwh7rZNxYyV5KHfiKBno8OsMogRnWlQ9fDAeXihC1X
 mRU9VPw70z6bhalFEM/pjPCQA+BAlngHvY0q9Gw5NOloxVW0K/tO3saCFey4hE3JznGRzrizu129
 acHYDxLXrLFZ27x/iUDXTg3+zEtPhPK6l993q4Vc9aUV1oY4fX3W5eOCNA39aaEeNVeYHTQ4qc4p
 rBw6OWxEnZ+B9jntbFMsB5h9L3Pcq6EXKX3cZxLzrCA9pYo1HvE2dZcCZBCEfYvQUHiJ0yEw/ggH
 k6NxP0mFXr1FslXeNHk15VolAGHS5rCXQKDyHv3TiDImoWFJv2x8Vhm7/dDfeKdHWm+j+q2hZS63
 ia/tIkSE0ngbX0T3LvR1Khr2Eo2bTut7ztDdNHV3VH6Kds23J7LHDHZzGBAiCeuHbrg=
X-Report-Abuse-To: spam@mut-mta1-se01a-fr.yulpa.io
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alex Bennée <alex.bennee@linaro.org>

We had a regression that broke Linux's get_maintainer.pl. Using
Mail::Address to parse email addresses fixed it, but let's protect
against future regressions.

Patch-edited-by: Matthieu Moy <git@matthieu-moy.fr>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Matthieu Moy <git@matthieu-moy.fr>
---
Change since v1: fixed proposed by Eric Sunshine and pointed out by
Alex Bennée.

Eric pointed out that using --cc-cmd=$(pwd)/expected-cc-script.sh did
not work because $(pwd) had spaces in it, but I already turned it into
./expected-cc-script.sh.

 t/t9001-send-email.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 4d261c2..d13d8c3 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -172,6 +172,26 @@ test_expect_success $PREREQ 'cc trailer with various syntax' '
 	test_cmp expected-cc commandline1
 '
 
+test_expect_success $PREREQ 'setup fake get_maintainer.pl script for cc trailer' "
+	write_script expected-cc-script.sh <<-EOF &&
+	echo 'One Person <one@example.com> (supporter:THIS (FOO/bar))'
+	echo 'Two Person <two@example.com> (maintainer:THIS THING)'
+	echo 'Third List <three@example.com> (moderated list:THIS THING (FOO/bar))'
+	echo '<four@example.com> (moderated list:FOR THING)'
+	echo 'five@example.com (open list:FOR THING (FOO/bar))'
+	echo 'six@example.com (open list)'
+	EOF
+	chmod +x expected-cc-script.sh
+"
+
+test_expect_success $PREREQ 'cc trailer with get_maintainer.pl output' '
+	clean_fake_sendmail &&
+	git send-email -1 --to=recipient@example.com \
+		--cc-cmd="./expected-cc-script.sh" \
+		--smtp-server="$(pwd)/fake.sendmail" &&
+	test_cmp expected-cc commandline1
+'
+
 test_expect_success $PREREQ 'setup expect' "
 cat >expected-show-all-headers <<\EOF
 0001-Second.patch
-- 
2.7.4

