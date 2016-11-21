Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C7C91FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 14:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932380AbcKUOSo (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 09:18:44 -0500
Received: from mout.gmx.net ([212.227.15.19]:59269 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932360AbcKUOSm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 09:18:42 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MDhba-1byRQA2jAk-00H62m; Mon, 21
 Nov 2016 15:18:20 +0100
Date:   Mon, 21 Nov 2016 15:18:05 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Taufiq Hoven <taufiq.hoven@gmail.com>
Subject: [PATCH 1/3] rebase -i: identify problems with core.commentchar
In-Reply-To: <cover.1479737858.git.johannes.schindelin@gmx.de>
Message-ID: <f47dce15719954d6d4d8a550856757366871143e.1479737858.git.johannes.schindelin@gmx.de>
References: <cover.1479737858.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:DDD+em8a4FuKx4sJ1gynLEvDq6SDHhXw+MAbOZnQTw2UlQ9Prkk
 b4f26yauXQpT7OmEhhJWMe8uWXKtpyRDvMIhUfCFtiydR3tacWRKxu2DuzPm+CxSPBwZnn5
 T+L1j0M5Kx83VsdHd0530sEcPtwb8mrDUWDQnmOPL1jnhNvqi591+jd9Dz1nvAZK6HOkf05
 QAFHVNw1BR3FCq5+ERjBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oJGwgizOJgU=:rm+Y51rsATe+5GwG0mH197
 FhNFO3Li44eoU3Gmt0VBwohGmxmsTGsxDNKIUkL0nZANZjqqNz6eNDqQSG6AVKtZH856VIUZB
 SIV6glxQ1wgVvBQZCmOb5nczmP9aQSW4NUUIeMVi8Dc3FJgWMNQe/6TXqbx9eXguON0BQgt15
 SicBynh9bAxM2BUs/oAVnEziPX0RMsoOBGXJ9r724UBOmCLXnnVS/NFl6NJmqygqsg96TejJD
 bGu0InU65VZsBQzdmjlu4oYCkVVyE0zgxBoz1JtotHMmOHH/DcVlLIW5rajAj9cYvMlSiaK6b
 qR4mia4nJASn9xuSJRe5g/2ZYp6qDeu+UDYTbXoLczFNGOXUyA4pATvl8kbcAFTrayUoNp/pw
 vUSnRcM9KoSMy68MeBJ3loZ9eLtn/0uhPqaqGvaVih5ZcdtJp2LBjqrdwYyIn4jOJBu2Oj3th
 +NP+GLsxbMiPIcin5K62FM76es2hIUz0DyiZZmhRMfUMs+CMZ3BuY0dVeMbPBI1pbPAZXdvmL
 nVx0skqtlhXNgjCI3Mwz4lu2ZXtn4ctvIiUOAZZ0mq4t5pfHqiCgAHRV/xxyR/m7QwXrqIAx6
 8QdrLOvxN5UfsGCHc0hHqOKpLMxMJukM47Pe+IXpQLEZuG67iNKacqztuigbDfn2cgHqJW3wL
 mRAioNYOOAK74lrpsFsff8qahB44IO1gHSHY7u9gG6P2lXSA3rqksTOiTrKoyaovMjMQUknoe
 +Tm6I43s3jNrKIQOXPcxtqo5bECblbcWJu0rDKp8irwecfe45Z/IpKsROUWimNv7mdlxG4nel
 sHo2W0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The interactive rebase does not currently play well with
core.commentchar. Let's add some tests to identify those problems.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0030-stripspace.sh         |  7 +++++++
 t/t3404-rebase-interactive.sh | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index 29e91d8..202ac07 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -432,6 +432,13 @@ test_expect_success '-c with changed comment char' '
 	test_cmp expect actual
 '
 
+test_expect_failure '-c with comment char defined in .git/config' '
+	test_config core.commentchar = &&
+	printf "= foo\n" >expect &&
+	printf "foo" | git stripspace -c >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'avoid SP-HT sequence in commented line' '
 	printf "#\tone\n#\n# two\n" >expect &&
 	printf "\tone\n\ntwo\n" | git stripspace -c >actual &&
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index e38e296..e080399 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -976,6 +976,18 @@ test_expect_success 'rebase -i respects core.commentchar' '
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
+test_expect_failure 'rebase -i respects core.commentchar=auto' '
+	test_config core.commentchar auto &&
+	write_script copy-edit-script.sh <<-\EOF &&
+	cp "$1" edit-script
+	EOF
+	test_set_editor "$(pwd)/copy-edit-script.sh" &&
+	test_when_finished "git rebase --abort || :" &&
+	git rebase -i HEAD^ &&
+	grep "^#" edit-script &&
+	test -z "$(grep -ve "^#" -e "^\$" -e "^pick" edit-script)"
+'
+
 test_expect_success 'rebase -i, with <onto> and <upstream> specified as :/quuxery' '
 	test_when_finished "git branch -D torebase" &&
 	git checkout -b torebase branch1 &&
-- 
2.10.1.583.g721a9e0


