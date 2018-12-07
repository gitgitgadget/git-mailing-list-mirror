Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F1FF20A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 17:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbeLGRFF (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 12:05:05 -0500
Received: from mout.web.de ([212.227.17.12]:33923 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeLGRFE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 12:05:04 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MfHfy-1godvD3IsM-00OsQc; Fri, 07
 Dec 2018 18:05:01 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, svnpenn@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 3/3] Refactor mingw_cygwin_offset_1st_component()
Date:   Fri,  7 Dec 2018 18:05:00 +0100
Message-Id: <20181207170500.9078-1-tboegi@web.de>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05
In-Reply-To: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0EqXoxIbKuhxlcwxSGjDUv97UFbcLgyUkV+VWLOGvZwm6tVwSDA
 ZuI7OEXUkrSYDdcZ0745UIAz0SRuHpSrAuBjMt4imnBIcNZegP8QS7EfkwwFgep28Yz1WfD
 znAIsIuNhvsn560nf4r2RYaJa1lTJzUfRwha920QRBKeoMX0rjqSZgtZCPmNFrPtSBm1+YF
 kXX1zEr3jhiVo3yh62lCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KHEwMmkD3LA=:JqYrpW6OsXbdKgdm0dw5sq
 norghHVau87uU/FUclB2KyIOtKcLfQUGDCOS/3a6Mw7cNqo7bSt7mMAUJvK9e1jo9zClBIf88
 8GnTcLB1g/X/vsM8YohakDOZWccApAAi7NFlE6SYu/0A5wIPNg0VkYciEEXr4Jr1sdQ49K/5h
 ctmUc0Qy5cacAZ+Z8xjW5pbsSPD/QzBZrQDt+4vAZFqxbzQwZQdSfNmHX7QoFVhj+9DyTtD8t
 nP0oJEtH6+JAf/bxZHBxF6GF7fICOr/oujbzUw5oGlEs8yv1By3PKpE1ZQoUtFC8HJ33lz7mL
 eq8nCOy31ExBw4YjaYZRkvl0eMfdPTcvBNp4jhd3YtQ+p2VOzcznqk0mjIned+6mk6w1YXJWK
 TeWPOsYVuFbe5zF2LlCGp8D1oSr9z12MCgOXNnW9mxFPstx0akgTCwQtXtDEIouWDsCdfexLc
 49CToz7nO9AUOctIRzzPLh+xmrptF1kB3akLQvl3lc54R+shrpKTg2Zil4Julh3/Av+G2Yj/B
 aYoau3cyXuGu2F3QX0YfuplrMEBa0LHOXVu4Sc5KonSgnUoOl53OP3Kub9L8eprrzTJZOiMtm
 jdRb7IcX6wJ2tkTFabp6yZUeeHLS8bingKzOx9SRPKG5f6LXCj5wGTnDmD2/ylup9D04Hk/jE
 /S9muEdjZBvyuY4SPcujTPBJFxXYs6AbwxxVTJOz5QLMbr2/1N7NnRpFV4drPcKw0K4+8nU8u
 11OTovxEtjFA2ZDDf2nmpsP3pe+59qApTwzt92AW5n8HBXavzv7zmRRTvuMnfmKd0uomCQH9n
 fvYYWT9KxPJzMep6D75XMvTm4dBcLUyqjpLWylkYXCZ+D5qGXQdLE7JVyw0ryQwVEu230M/OS
 X2zjmTTiL0N8rtX3rgGJ9atysilBnf6RgroZ4kVS/wfTHbbMBJzZmw6jVQL0CF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

The Windows version of offset_1st_component() needs to hande 3 cases:
- The path is an UNC path, starting with "//" or "\\\\".
  Skip the servername and the name of the share.
- The path is a DOS drive, starting with e.g. "X:"
  The driver letter and the ':' must be skipped
- The path is pointing to a subdirectory somewhere in the path and the
  directory seperator needs to be skipped ('/' or '\\').

Refactor the code to make it easier to read.

Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 compat/mingw-cygwin.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/compat/mingw-cygwin.c b/compat/mingw-cygwin.c
index 5552c3ac20..c379a72775 100644
--- a/compat/mingw-cygwin.c
+++ b/compat/mingw-cygwin.c
@@ -10,10 +10,8 @@ size_t mingw_cygwin_skip_dos_drive_prefix(char **path)
 size_t mingw_cygwin_offset_1st_component(const char *path)
 {
 	char *pos = (char *)path;
-
-	/* unc paths */
-	if (!skip_dos_drive_prefix(&pos) &&
-			is_dir_sep(pos[0]) && is_dir_sep(pos[1])) {
+	if (is_dir_sep(pos[0]) && is_dir_sep(pos[1])) {
+		/* unc path */
 		/* skip server name */
 		pos = strpbrk(pos + 2, "\\/");
 		if (!pos)
@@ -22,7 +20,8 @@ size_t mingw_cygwin_offset_1st_component(const char *path)
 		do {
 			pos++;
 		} while (*pos && !is_dir_sep(*pos));
+	} else {
+		skip_dos_drive_prefix(&pos);
 	}
-
 	return pos + is_dir_sep(*pos) - path;
 }
-- 
2.19.0.271.gfe8321ec05

