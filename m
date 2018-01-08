Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 474491F406
	for <e@80x24.org>; Mon,  8 Jan 2018 10:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756512AbeAHKey convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 8 Jan 2018 05:34:54 -0500
Received: from mut-mta1-se01a-zose1-fr.yulpa.io ([185.49.21.248]:47510 "EHLO
        mut-mta1-se01a-zose1-fr.yulpa.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755890AbeAHKew (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 8 Jan 2018 05:34:52 -0500
Received: from zose-mx-out01.web4all.fr ([185.49.20.46] helo=zose-mta-hub-out-mua-02.web4all.fr)
        by mut-mta1-se01b-fr.yulpa.io with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <git@matthieu-moy.fr>)
        id 1eYUlT-0002Se-OY; Mon, 08 Jan 2018 11:34:48 +0100
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-mua-02.web4all.fr (Postfix) with ESMTP id D696B60E5B;
        Mon,  8 Jan 2018 11:34:46 +0100 (CET)
Received: from zose-mta-hub-out-mua-02.web4all.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-mua-02.web4all.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pvebSHEl2Nry; Mon,  8 Jan 2018 11:34:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-mua-02.web4all.fr (Postfix) with ESMTP id 4257660E35;
        Mon,  8 Jan 2018 11:34:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at zose1.web4all.fr
Received: from zose-mta-hub-out-mua-02.web4all.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-mua-02.web4all.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XCYz5u6TfMpo; Mon,  8 Jan 2018 11:34:46 +0100 (CET)
Received: from moylip.lip.ens-lyon.fr (dhcp-13-157.lip.ens-lyon.fr [140.77.13.157])
        (Authenticated sender: matthieu.moy@matthieu-moy.fr)
        by zose-mta-hub-out-mua-02.web4all.fr (Postfix) with ESMTPSA id 7968060E20;
        Mon,  8 Jan 2018 11:34:44 +0100 (CET)
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Thomas Adam <thomas@xteddy.org>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: [PATCH v3 3/3] send-email: add test for Linux's get_maintainer.pl
Date:   Mon,  8 Jan 2018 11:34:34 +0100
Message-Id: <1515407674-5233-3-git-send-email-git@matthieu-moy.fr>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1515407674-5233-1-git-send-email-git@matthieu-moy.fr>
References: <1515177413-12526-1-git-send-email-git@matthieu-moy.fr>
 <1515407674-5233-1-git-send-email-git@matthieu-moy.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: 185.49.20.46
X-SpamExperts-Domain: zose1.web4all.fr
X-SpamExperts-Username: 185.49.20.46
Authentication-Results: yulpa.io; auth=pass smtp.auth=185.49.20.46@zose1.web4all.fr
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00166013331204)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5g5/MGXgoGy3NSKPsgqOAc7j1g3/PwYZaTCzSym8uE9HPImhfA8k5/zW
 UdbqUfA/+atZAIrjsCRyglG39ay7s40zkSakW8+kgCjGkeOx1qmz3ywmUacsjxjAsJqLMS98bJTN
 iqbXZIDkOGe2FHwUiJMpTgZqLYtJsbXv/ketFafwq+G25XHaa2KawFj0OiLrEH091rP1WLs/7NTd
 f/v9ilzOIBlCHgCawvkuWitWcipbuRFQm2jqALoMZllaxFqDsuKVse1sVhWabI0/+PN3sIJgPotx
 C4d5mZiBkvWU8JOmlab7A14bDhsVpYYd7UZLwsivEsJmn1J3i12zQnpjnAkksRzltJtieFUSxnzh
 hYFeh4JLEtnm8ySEiLmvj502SX5iR5s2m8n9hOTmgdU9KKveLgRddK55nMwKlfa186oozmyhDRHa
 NLgbENzE8UYLv0ZqmBjctg3sraCMRH0q8y0f/ewgTZZHnomyLohxA2/JJ6lavGyCMxxrx/V1QkJh
 uHW2G/SF32BkaVUv9IQODMJ47049fv7DynTeLk68Ja5SY5R6BpcvGp3jcY/qUcseg7VRAzeOsvgA
 V5QompPxrkfi9hmPKuiBYMIBAmK2NFHJ2+mjZSBX08/Qa05JAIPdavvg7iEFLP+SSY+Av5+AiC6q
 57wRJX0TOTJHzvd3MM9RlAGcUzJGugIsdSHTBsSYjxq5njeYVgYruX41s+gDgwmhSCf4BF/WdfYJ
 bQ6u3FdnP3h8izjtZsxkRYrv06jIw6W1C84udHc1IZJSv0wxMqxThRWXb/vjhFfnRGEw17v+HDXM
 PVMaQCIb+s/RO6mAGcwYghcXJyLED6jwQGBY36ohzfH4XhSDqdP/cnlEQ4kfiNo8GupROe8ziKxj
 WvmzolFfEoXm0/FPF8PR0w363lm8oLPYy4YTN6Tnj/EjhZ8pvzjd0/KJo06KSY/Nuo+6Ze58MBvt
 Sp/30FBTc0LHHV5YbaWAq0BDJ73nbtNkWc/zst1ymB3m2xZYS6jH5McCr5LJM700aXzYJC4yKoPz
 E5+rg5zjXjFYo+QNnmYltQOnEF9dSV894wpXF4CTvMURvtge8Z7vJMrDsqwzXs0XHW3yvXuqcc8b
 2Rz+DKDRpNcP
X-Report-Abuse-To: spam@mut-mta1-se01a-fr.yulpa.io
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alex Bennée <alex.bennee@linaro.org>

We had a regression that broke Linux's get_maintainer.pl. Using
Mail::Address to parse email addresses fixed it, but let's protect
against future regressions.

Note that we need --cc-cmd to be relative because this option doesn't
accept spaces in script names (probably to allow --cc-cmd="executable
--option"), while --smtp-server needs to be absolute.

Patch-edited-by: Matthieu Moy <git@matthieu-moy.fr>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Matthieu Moy <git@matthieu-moy.fr>
---
Change since v2:

* Mention relative Vs absolute path in commit message.

* Remove useless "chmod +x"

* Remove useless double quotes

 t/t9001-send-email.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 4d261c2..a06e5d7 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -172,6 +172,25 @@ test_expect_success $PREREQ 'cc trailer with various syntax' '
 	test_cmp expected-cc commandline1
 '
 
+test_expect_success $PREREQ 'setup fake get_maintainer.pl script for cc trailer' "
+	write_script expected-cc-script.sh <<-EOF
+	echo 'One Person <one@example.com> (supporter:THIS (FOO/bar))'
+	echo 'Two Person <two@example.com> (maintainer:THIS THING)'
+	echo 'Third List <three@example.com> (moderated list:THIS THING (FOO/bar))'
+	echo '<four@example.com> (moderated list:FOR THING)'
+	echo 'five@example.com (open list:FOR THING (FOO/bar))'
+	echo 'six@example.com (open list)'
+	EOF
+"
+
+test_expect_success $PREREQ 'cc trailer with get_maintainer.pl output' '
+	clean_fake_sendmail &&
+	git send-email -1 --to=recipient@example.com \
+		--cc-cmd=./expected-cc-script.sh \
+		--smtp-server="$(pwd)/fake.sendmail" &&
+	test_cmp expected-cc commandline1
+'
+
 test_expect_success $PREREQ 'setup expect' "
 cat >expected-show-all-headers <<\EOF
 0001-Second.patch
-- 
2.7.4

