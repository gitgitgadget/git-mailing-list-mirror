Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E9CC38A02
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 10:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJ2KGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 06:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJ2KGO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 06:06:14 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EE769F6B
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 03:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1667037967; bh=5CAx06yngKWVmHx+ENDDqCtDDAC6mr1HdGo9M0e0o3I=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=mlEuTILoX6Vv/zzaGUdC2e1+CPIWuvkbU2ytevtmDoNlRCun6MtLSUSMMJ9RDqHRU
         VGV60b3B2UT2bowuuRlRLEWKr934Ow2k9EdaNO5Niw6yedjBwXmCBZM4GnqUoze+Rr
         ML/GHTk7y3J6ifeKBjx8viIztJM4Um43wsV+REYA7NJnsvbvHl1oXsHoFQ3n4RQFDM
         39CDKr50OoacqDYmUxhjCm7udoproIirqplTSqtOT9ecmY9xY92/CjKEiceCijnEAu
         gEgjotnomRkxK9VjkzItv1HlksOmwDIZvwd8hucC1E2XbX6tuTJvZZNOgnuwkCC0+J
         F4EQKmwaZ9McQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.34] ([79.203.23.191]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2xw0-1olPs3063w-003JkP; Sat, 29
 Oct 2022 12:06:07 +0200
Message-ID: <c51b72e5-1c32-65e4-6faa-04693b623e2e@web.de>
Date:   Sat, 29 Oct 2022 12:06:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] archive-tar: report filter start error only once
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zugp2zq59mUQWgBeb17n4msJxE9b4dxkPfkdgr3oT+Im2DIygBM
 zPiYWcwa4klrU5yzsGc4XOvdHYHhDTnE4tNfHxRE/kzOE9ep3Uve2+MnCxzYwM44KaruXOh
 yXv6z7ZYn0o21yRF4sIvO3boTyBSUvv6E0DCU66vmauOZUJSXlzef5H+hvYr2cJcVqxvsZd
 ix3yPp0EjmCN69cNS6rWQ==
UI-OutboundReport: notjunk:1;M01:P0:NNk2sSR6ADQ=;4T/ivDgHm6tw11/IPY1oynCS8zL
 em+ETEo1N+vfVRcWr4lG6Wm6UjruxzvUKq4q20SZXWmKlpUI1gbdO8qhk0QByGW9W/3bRDTAb
 CLcAl7+akZPmv62wqiIOqsH9Gp4nOVMUaZaRU5ghjVTO0Q76OWlzPObtT6KNPnqWYPxJ7+GnV
 MwGIt9VjksTdecKRV4hnDIwWHzS/vBDAr2tWwUKLwMagG4mhpIP5soEJgql2oV1Hnw2K9fO5g
 pvWh/Kkhi2pXr9TKPGil7qMSuI9+VKrH08UgeYSKBd/rb3QJihewk/kNfhViy0TznkxdXWlRD
 aYbTbYx+FX+2amv4E9GeRk96oTnuPKJwWUgZKx1RdlEflP0ZDNuWr/4O+bRz78d3q4ON3cYKt
 6eFt9cgPp+shoqX7/wnCxNH6zD9PI5l2h/egvPKfdSpjh4ZI1NSYRxBfFT/DNMFPVc5qIEwpJ
 4UbFTbDCKBoUh6aK8UxrJnbX8NIQIM0PG1JVgC/WL2JuYNlL2rZzd3akS2+GRy94thAdN5F54
 wxpA3BRMatJJNKZ+42ZD0nKIDm2EGz5R4BJJDmZY1UplMeCtrV2GbN5WlbC6GMVcO1poc/CCO
 HltaagM8tMPG55iM6WoKJPWXCaL+ToJm/PrTk5lduLxg2gIGuCHBXuCpFUZIzIAuBzNylU3yi
 MdLUUsyEUC5lCIXZ5nQ4TFRUa57E1fQTfYpjC6QssHZbPD1TaLI+LLoIoFqUX5wINbR3QBVwX
 nJ1eNF36hVzCdHVAFqDfeJvPkec/bz+pPBPCkTVfjlKMg0QDSuY6siDxw+8JLht+h7fHkbQui
 Guxpd2gzONnVPklYhxnI5yMcDSR12X33At+CeAHn39MvfjMNu/I14BqwJGy0S3ElQdFnELsL8
 bMZ7m9U0spLNVhzkYDO/tNH7YGeejBQ3Qiyn/iqRTkY2ZmGVLsPrD+xw5vC45/TGL8/Tu8RvF
 PgDQy171sDO6boNtvAxbJtbLWIs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A missing tar filter is reported by start_command() using error(), but
also by its caller, write_tar_filter_archive(), using die():

   $ git -c tar.invalid.command=3Dfoo archive --format=3Dinvalid HEAD
   error: cannot run foo: No such file or directory
   fatal: unable to start 'foo' filter: No such file or directory

The second message contains all relevant information and even says that
the failed command was intended to be used as a filter.  Silence the
first one because it's redundant.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 archive-tar.c       | 1 +
 t/t5000-tar-tree.sh | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/archive-tar.c b/archive-tar.c
index 3e4822b684..f8fad2946e 100644
=2D-- a/archive-tar.c
+++ b/archive-tar.c
@@ -498,6 +498,7 @@ static int write_tar_filter_archive(const struct archi=
ver *ar,
 	strvec_push(&filter.args, cmd.buf);
 	filter.use_shell =3D 1;
 	filter.in =3D -1;
+	filter.silent_exec_failure =3D 1;

 	if (start_command(&filter) < 0)
 		die_errno(_("unable to start '%s' filter"), cmd.buf);
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index eaa0b22ece..d473048138 100755
=2D-- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -342,6 +342,13 @@ test_expect_success 'only enabled filters are availab=
le remotely' '
 	test_cmp_bin remote.bar config.bar
 '

+test_expect_success 'invalid filter is reported only once' '
+	test_must_fail git -c tar.invalid.command=3D archive --format=3Dinvalid =
\
+		HEAD >out 2>err &&
+	test_must_be_empty out &&
+	test_line_count =3D 1 err
+'
+
 test_expect_success 'git archive --format=3Dtgz' '
 	git archive --format=3Dtgz HEAD >j.tgz
 '
=2D-
2.30.2
