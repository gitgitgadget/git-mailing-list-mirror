From: Michal Nazarewicz <mina86@mina86.com>
Subject: [PATCH] path: for clarity, rename get_pathname to get_path_buffer
Date: Tue, 08 Jul 2014 15:15:41 +0200
Organization: http://mina86.com/
Message-ID: <xa1t4mys56v6.fsf@mina86.com>
References: <xa1ta98k58qm.fsf@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: <torvalds@linux-foundation.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 15:16:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4VFX-00069v-PL
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 15:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755035AbaGHNPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 09:15:47 -0400
Received: from mail-we0-f176.google.com ([74.125.82.176]:45336 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754796AbaGHNPp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 09:15:45 -0400
Received: by mail-we0-f176.google.com with SMTP id u56so5949816wes.7
        for <git@vger.kernel.org>; Tue, 08 Jul 2014 06:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:in-reply-to:organization:references
         :user-agent:face:date:message-id:mime-version:content-type;
        bh=vfXR9Ck7ecwJ0wRLVUb8O+BsDJIbZQbIgND2QtP5ZXY=;
        b=lUiG87nQCTxzYgeoKbfvrA7kvs1soxdDlzfF8o2jPMHKlmnenCsPlWIrfTwNSNnpHA
         x7FXbxzBz4Ky6sml5+6I6ctpGXCUzwZXj3Kln+flpxe51sxUXI9kireup560+fcWKJ65
         e6z7TY9LXwTdtZXn6w9P2bQJM8rYJM4ONfTTFszRwp43pMZURB58lbfLZsr5sJ6w5ddw
         BE3CanT+mGoncD+FzZqlON7PnW9EX7jTTiGWfXqtdEhfn96pLhs22CHeniOGvQqbCLQI
         SRQRdc9ZQN4EfbDfxhONe8CxjNSNCorl8DDngu7eHd4sufWmjWdNjpSMgezhpeXud9EB
         0s1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to
         :organization:references:user-agent:face:date:message-id
         :mime-version:content-type;
        bh=vfXR9Ck7ecwJ0wRLVUb8O+BsDJIbZQbIgND2QtP5ZXY=;
        b=ECR1EvjcPZnMgbUIHUAp1DBkOtq1jgFKHkhIEvc7WVBCiiEZ3vdL/qjwwWPbTQ8tCV
         3yIYnMXJfnqVzhKd9wGn2Sga76Hu6NgW/zt+eTktA8ZVbA3ssYMMMgJ4C+Mpd+cMUhLJ
         ZYrIunmD0AR4HNi+GMWKAl4DZVzqxswUj1VVJhf4YlaITb42sZXfywGm1TJ9eXQJj9u0
         5ZNkxfgngzJrLPTmfqzaevqLFG+eKhNjHbVUpTOKXkTIbLK8ogM1d87h/aWMr3gx2gTt
         NwJQFZMGu3hqunrOc1pu8jCYm7ke8OwYDUd8uTxa2/wj4kLCBTF4j+FSeK9r1RF952m5
         B5Hw==
X-Gm-Message-State: ALoCoQkra174O3odQrSO+SuPQwf4N4h5CFTnSWPGWTQ5n8oE58i9KyJ+e6NFPWEJKbGWoCo4sfnC
X-Received: by 10.194.158.101 with SMTP id wt5mr2746070wjb.136.1404825343922;
        Tue, 08 Jul 2014 06:15:43 -0700 (PDT)
Received: from mpn-glaptop.roam.corp.google.com ([2620:0:105f:311:5ce1:b7a9:45ae:3b51])
        by mx.google.com with ESMTPSA id ei3sm4385659wib.13.2014.07.08.06.15.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 08 Jul 2014 06:15:43 -0700 (PDT)
In-Reply-To: <xa1ta98k58qm.fsf@mina86.com>
User-Agent: Notmuch/0.17+15~gb65ca8e (http://notmuchmail.org) Emacs/24.4.50.1 (x86_64-unknown-linux-gnu)
X-Face: PbkBB1w#)bOqd`iCe"Ds{e+!C7`pkC9a|f)Qo^BMQvy\q5x3?vDQJeN(DS?|-^$uMti[3D*#^_Ts"pU$jBQLq~Ud6iNwAw_r_o_4]|JO?]}P_}Nc&"p#D(ZgUb4uCNPe7~a[DbPG0T~!&c.y$Ur,=N4RT>]dNpd;KFrfMCylc}gc??'U2j,!8%xdD
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEWbfGlUPDDHgE57V0jUupKjgIObY0PLrom9mH4dFRK4gmjPs41MxjOgAAACQElEQVQ4jW3TMWvbQBQHcBk1xE6WyALX1069oZBMlq+ouUwpEQQ6uRjttkWP4CmBgGM0BQLBdPFZYPsyFUo6uEtKDQ7oy/U96XR2Ux8ehH/89Z6enqxBcS7Lg81jmSuujrfCZcLI/TYYvbGj+jbgFpHJ/bqQAUISj8iLyu4LuFHJTosxsucO4jSDNE0Hq3hwK/ceQ5sx97b8LcUDsILfk+ovHkOIsMbBfg43VuQ5Ln9YAGCkUdKJoXR9EclFBhixy3EGVz1K6eEkhxCAkeMMnqoAhAKwhoUJkDrCqvbecaYINlFKSRS1i12VKH1XpUd4qxL876EkMcDvHj3s5RBajHHMlA5iK32e0C7VgG0RlzFPvoYHZLRmAC0BmNcBruhkE0KsMsbEc62ZwUJDxWUdMsMhVqovoT96i/DnX/ASvz/6hbCabELLk/6FF/8PNpPCGqcZTGFcBhhAaZZDbQPaAB3+KrWWy2XgbYDNIinkdWAFcCpraDE/knwe5DBqGmgzESl1p2E4MWAz0VUPgYYzmfWb9yS4vCvgsxJriNTHoIBz5YteBvg+VGISQWUqhMiByPIPpygeDBE6elD973xWwKkEiHZAHKjhuPsFnBuArrzxtakRcISv+XMIPl4aGBUJm8Emk7qBYU8IlgNEIpiJhk/No24jHwkKTFHDWfPniR
 4iw5vJaw2nzSjfq2zffcE/GDjRC2dn0J0XwPAbDL84TvaFCJEU4Oml9pRyEUhR3Cl2t01AoEjRbs0sYugp14/4X5n4pU4EHHnMAAAAAElFTkSuQmCC
X-PGP: 50751FF4
X-PGP-FP: AC1F 5F5C D418 88F8 CC84 5858 2060 4012 5075 1FF4
X-Hashcash: 1:20:140708:git@vger.kernel.org::GOLG/0piLiUAs8tv:0000000000000000000000000000000000000000008het
X-Hashcash: 1:20:140708:junkio@cox.net::bFJsc7cIFJeAbvJL:0009Frt
X-Hashcash: 1:20:140708:torvalds@osdl.org::fC56Q9WABgUfDWa5:00000000000000000000000000000000000000000000CBkx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253021>

The get_pathname function does not really return path name but rather
a buffer to store pathname in.  As such, current name is a bit
confusing.  Change the name as to make it clearer what the function is
doing.

Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
---
 path.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

 This time sent with Junio's correct address.

diff --git a/path.c b/path.c
index bc804a3..70e2f85 100644
--- a/path.c
+++ b/path.c
@@ -16,7 +16,7 @@ static int get_st_mode_bits(const char *path, int *mode)
 
 static char bad_path[] = "/bad-path/";
 
-static char *get_pathname(void)
+static char *get_path_buffer(void)
 {
 	static char pathname_array[4][PATH_MAX];
 	static int index;
@@ -108,7 +108,7 @@ char *mkpath(const char *fmt, ...)
 {
 	va_list args;
 	unsigned len;
-	char *pathname = get_pathname();
+	char *pathname = get_path_buffer();
 
 	va_start(args, fmt);
 	len = vsnprintf(pathname, PATH_MAX, fmt, args);
@@ -120,7 +120,7 @@ char *mkpath(const char *fmt, ...)
 
 char *git_path(const char *fmt, ...)
 {
-	char *pathname = get_pathname();
+	char *pathname = get_path_buffer();
 	va_list args;
 	char *ret;
 
@@ -158,7 +158,7 @@ void home_config_paths(char **global, char **xdg, char *file)
 
 char *git_path_submodule(const char *path, const char *fmt, ...)
 {
-	char *pathname = get_pathname();
+	char *pathname = get_path_buffer();
 	struct strbuf buf = STRBUF_INIT;
 	const char *git_dir;
 	va_list args;
-- 
2.0.0.526.g5318336
