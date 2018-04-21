Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83F311F424
	for <e@80x24.org>; Sat, 21 Apr 2018 11:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbeDULOs (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 07:14:48 -0400
Received: from mout.gmx.net ([212.227.17.22]:53145 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752480AbeDULOr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 07:14:47 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LlGoc-1ebKjt49lW-00b68k; Sat, 21
 Apr 2018 13:14:44 +0200
Date:   Sat, 21 Apr 2018 13:14:28 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Dan Jacques <dnj@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/3] git_setup_gettext: plug memory leak
In-Reply-To: <cover.1524309209.git.johannes.schindelin@gmx.de>
Message-ID: <34971f7dd4c4b5df1f7924759d5aee9784c82fc6.1524309209.git.johannes.schindelin@gmx.de>
References: <cover.1524211375.git.johannes.schindelin@gmx.de> <cover.1524309209.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oSnMp060fzcaWvJ92nzppP47+jsn8LSURRfNqpNcb2QBkXiYX8e
 Q8TbYrAjX5cgM9gAb1RvL/eoAkrmyrRD4fUJufBsg3B+RsYucg2XbowZYr9nTIJNRhv6wSt
 ubBfmMqZ2dk4TpUK1A0xBeLHyqf7aMFrw1Ex1wHC3Z0R+rGHvaeRgRO57RDbmFZescmr5JG
 iEKpGKVjIFis7u2ti32+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2p0NSYBSVRo=:dDcExAFPhq4Qb3n1+hl2YA
 1Bqqcq08JSuW+VLbJs9aBDVu93EtdW834VFnyplE8YXz1UTTIeJpcT9tQeY5TGfCa1fCBjuQk
 qXJAy2kx/godxdDWr5maiNGx4TyomFEhrrtyLSYvZuVmN77uDpd0jdWko8dIz5JzJn7dR0uFl
 L5IM5JncAyh3IMHthbXEy6d0f+H9S/8Iez0vnn7rWGS9FuVBjBjIM08xpkj1MYwqAtBwGshJ7
 EmqVVItEDA7Aryjhe23ARYtKXK48epKClIm20ANLzM4aB9jQ6WSaDrms1uj2eYVqvE4zIUFD7
 HDZfNEIWmoT3gq16x6YXDQU+1OqZXcCNbJIYLWJB1GWrEdganzkio1AgtMqvT0VKHhGhmN/Zq
 CBPYeXXw7loqKz3KuSGAcnWacq9yY8ADzmtkycSjdK6vfS3w7DHH25svTMkDInQaGZs6ujxOy
 4VfhUdK7j4E3Gc7tfiF1lz1s+JqKrx/IyXqn2uxiXuXhv1nE+yp0MkEvwWvCc3TbwrprO6BNi
 488ebW+sQNiwJKA8vcH6UgRjtVV86/GAaGbE7paVgXs2O4di6wO0h14W/bGrpQ+ft0mgPxu5A
 ifPx3p55r5tH3YWUwxQHrwkkRVR84iI9QA7sIXe9DLCHOgO4XEBOnCKuDgn5YUlXP3ZK0la6/
 +0kmdb9cHIF/rb8KXkWls5wYDwPfCPBX2acvN0RZ/oncUHEQXSWVQUbk5Bgp7K4vg8JptO1xS
 z95lT1ZRqJTYIckHMnW7d2/z2DuTHh2nc/UGHzUM3b9sWTQ9e+IgWVTeuwaepL1MJjJQzpQvb
 5DFSW2glN7C9u9Ps6Y9xCMgY2p2vhq2Kp30t6B+qlXZMALyBIo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The system_path() function returns a freshly-allocated string. We need
to release it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 gettext.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/gettext.c b/gettext.c
index 701355d66e7..7272771c8e4 100644
--- a/gettext.c
+++ b/gettext.c
@@ -159,18 +159,23 @@ static void init_gettext_charset(const char *domain)
 void git_setup_gettext(void)
 {
 	const char *podir = getenv(GIT_TEXT_DOMAIN_DIR_ENVIRONMENT);
+	char *p = NULL;
 
 	if (!podir)
-		podir = system_path(GIT_LOCALE_PATH);
+		podir = p = system_path(GIT_LOCALE_PATH);
 
-	if (!is_directory(podir))
+	if (!is_directory(podir)) {
+		free(p);
 		return;
+	}
 
 	bindtextdomain("git", podir);
 	setlocale(LC_MESSAGES, "");
 	setlocale(LC_TIME, "");
 	init_gettext_charset("git");
 	textdomain("git");
+
+	free(p);
 }
 
 /* return the number of columns of string 's' in current locale */
-- 
2.17.0.windows.1.15.gaa56ade3205


