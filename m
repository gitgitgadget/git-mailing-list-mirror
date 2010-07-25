From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 3/7] Makefile: Split out the untested functions target
Date: Sun, 25 Jul 2010 14:40:57 +0000
Message-ID: <1280068861-17701-4-git-send-email-avarab@gmail.com>
References: <1280068861-17701-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 16:41:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od2OW-0001DE-EJ
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 16:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443Ab0GYOlW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 10:41:22 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40979 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab0GYOlS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 10:41:18 -0400
Received: by mail-ey0-f174.google.com with SMTP id 25so327671eya.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 07:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=TC7zyISXpPB7igc0hQyyWHxBzkAvPFeIgty+y07W5A0=;
        b=p3qTV+pEG4Z8pl42EN+uPP2iuHZD+YePkL7hwCgM0WzkLzQPmKDRMirgCndA0dHaTR
         C2XlQ/PlMLk573s7krUNjLwRl172rTIG/IwFNmuoF5Qpf1bQjxdBtEC1f6KI4s4SKHXR
         2FDChDBsWGmTFB2d6ebsHZqYiyc8KnC/vduJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=jV8eeehBrcMtnQvfQjQBjphBbFXS9b0f5Utr/A/OQQitRYs19f/eIW1CIpiaRzf8cN
         4GKAUjSIX/D4fMXgY7LSjdHeBeXYvyl2P2/n8+TwfCk2gprNFuRQfcddc9pE1qZxD61c
         Mjqq9c+2qlIU0voZ2RpggG6AhpYxWvQNfePAA=
Received: by 10.213.31.129 with SMTP id y1mr106289ebc.21.1280068877780;
        Sun, 25 Jul 2010 07:41:17 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id x54sm3977142eeh.23.2010.07.25.07.41.16
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 07:41:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280068861-17701-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151749>

Change the coverage-report target so that it doesn't generate the
coverage-untested-functions file by default. I'm adding more targets
for doing various things with the gcov files, and they shouldn't all
run by default.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index a95d260..e9f8ef8 100644
--- a/Makefile
+++ b/Makefile
@@ -2298,6 +2298,8 @@ coverage-report:
 	for dir in $(object_dirs); do \
 		gcov --preserve-paths --branch-probabilities --all-blocks --object-d=
irectory=3D$$dir $$dir*.c; \
 	done
+
+coverage-untested-functions: coverage-report
 	grep '^function.*called 0 ' *.c.gcov \
 		| sed -e 's/\([^:]*\)\.gcov: *function \([^ ]*\) called.*/\1: \2/' \
 		| tee coverage-untested-functions
--=20
1.7.0.4
