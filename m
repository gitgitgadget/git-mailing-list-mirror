Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 196BF207F8
	for <e@80x24.org>; Thu,  4 May 2017 09:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751407AbdEDJvB (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 05:51:01 -0400
Received: from mout.gmx.net ([212.227.15.15]:50105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751389AbdEDJu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 05:50:59 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVui8-1dYgTM0OwC-00X6mX; Thu, 04
 May 2017 11:50:52 +0200
Date:   Thu, 4 May 2017 11:50:37 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 6/7] Fix the remaining tests that failed with
 core.autocrlf=true
In-Reply-To: <cover.1493891336.git.johannes.schindelin@gmx.de>
Message-ID: <daa27cca688e864c0b85a92639e0fb46261dad5c.1493891336.git.johannes.schindelin@gmx.de>
References: <cover.1493728172.git.johannes.schindelin@gmx.de> <cover.1493891336.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:e5i7qgitCPzqtVJ64XRWn2TlghB/agqedrUYr60pbJv1UgmJc6J
 pKUUCaCG3I+7yM5GyKd1oKflMK2yrC+vYdl9vVfSx7khJbbh2ELstDO5+mCdjxLyPQ+owjf
 bcr0sHzaFSmGSJ82+w6HQs8gLLAoZqJaQybc/xqk6YEMga/fSfeOv9muX/qmIqC5xZyG6H8
 HC+GI04zprgo1SzmOzYQg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HgyBdvCqtE8=:D0fqK9k4ysgvD4KwRXIsL6
 Jvo0YmDjG22dYdB7MPPk5egORjSYZLN9276y3rVp7C9+lDCi1yECJrZIXbdVFVtPjfVyPO1FT
 G923iY+W+3EX/EPXlPexgIZKvExpQxwTrvEkqHPK46IPcSfIOEcKBrgkQd8lovh87ovBcAJU/
 zUJJcwXQn7gVzYbG5zX5b3IW5yfRmyGLy3STSgOzuqLSKf1C/zMXSp3hdsipz3CyvPsPN+xBp
 msTE6W3Otl1YBNput8eQWBZEWldCpuhob0UcUGZKKamukiu69r82J+fkbgCS3r24zLmGC8Vxb
 wLVvZvkaiGhgdFlMzYuHcyY1rHjep0JyBpaUYowSF6BVcUOMOxYvA+eqwpzPYltX84bmAcdPE
 SSd5SNMeCoPRmLPBOxXv8w3dhOdh7QpwtKfWyGirAi7/zyOLuL5DdjJw5HodsbdFFz9N9NQ6V
 ZKF+eIQBC2Q0ez10FfintJwXEiAInKAqHLe/A23VmzFdz0uEK258TPlL7uRfAHfIaubAJ6EkH
 E3rfZ2kWDY5I3pJ92jzuE4WdxmpEByDiMeiBxC3Mdj0FTid4875HAN2VKYlf9BvrWaVs0Mf8s
 tUtVnggA8p4ZK/UsIVEs7dj31rHG60YJuxirZtu3c1NpyIiJJS8XPlbruzy+uIpSg1Dzm27bU
 0c1+dZycjXGc0ZsiXzFyvsMo2926ERx2QoKcDU0dB2l9R6TdtTZmextbJ9VAPUUTVbAKZl7eX
 6bD0JhAHSyHHIP3f9LtYs7ZHtCAJxZLMMKz/x/wYF4HYSArowGG70KdsJV9d9XEEnm99ZvkGU
 wiyCvB4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test suite is mainly developed on Linux and MacOSX, which is the
reason that nobody thought to mark files as LF-only as needed.

The symptom is a test suite that fails left and right when being checked
out using Git for Windows (which defaults to core.autocrlf=true).

Mostly, the problems stem from Git's (LF-only) output being compared to
hard-coded files that are checked out with line endings according to
core.autocrlf (which is of course incorrect).

Note: the test suite also uses the t/README file as well as the COPYING
file in t/diff-lib/, expecting LF-only line endings explicitly and
failing if that assumption does not hold true. That is why we mark them
as LF-only in the .gitattributes, too.

This patch can be validated even on Linux by using this cadence:

	git config core.autocrlf true
	rm .git/index && git stash
	make -j15 DEVELOPER=1 test

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/.gitattributes | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/t/.gitattributes b/t/.gitattributes
index 2d44088f56e..3525ca43f30 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -1,2 +1,20 @@
 t[0-9][0-9][0-9][0-9]/* -whitespace
-t0110/url-* binary
+/t0110/url-* binary
+/t3900/*.txt eol=lf
+/t3901/*.txt eol=lf
+/t4034/*/* eol=lf
+/t4013/* eol=lf
+/t4018/* eol=lf
+/t4100/* eol=lf
+/t4101/* eol=lf
+/t4109/* eol=lf
+/t4110/* eol=lf
+/t4135/* eol=lf
+/t4211/* eol=lf
+/t4252/* eol=lf
+/t5100/* eol=lf
+/t5515/* eol=lf
+/t556x_common eol=lf
+/t7500/* eol=lf
+/t8005/*.txt eol=lf
+/t9*/*.dump eol=lf
-- 
2.12.2.windows.2.800.gede8f145e06


