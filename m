From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH] t6006 (rev-list-format): quote format strings to avoid error on some shells
Date: Tue, 20 May 2014 18:48:43 +0400
Message-ID: <7a4473fce2948c31f561c6002ab0b1d5ab0ee841.1400597264.git.Alex.Crezoff@gmail.com>
References: <537B5E8C.3070803@ramsay1.demon.co.uk>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 16:49:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmlLv-0000w5-Db
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 16:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbaETOtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 10:49:10 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:36950 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbaETOtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 10:49:09 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so494277lbg.32
        for <git@vger.kernel.org>; Tue, 20 May 2014 07:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rxI1HLSinRL4EqhK+6dxYc14V/SRHPoNErfDTd8Epq8=;
        b=a6e9Gap0YBi21Ma3Q/szMGzMqxu1eZrmK9NlU8vlaae+IcVlqECP4aNlpoHh/zcZU9
         na2+CqHMMuRt7f/sc2wTaEh8/SK4VUZIrVXTMyOHTIEK7uyLbsCcW2+IeYM/K2kUQbdk
         VulpcRvuNcrYlIizkta/CMv6/mjS6mLLgfX6phrR9izH3sj0paPqki8C+k6JSgpgkcjC
         UosUNfmFMGE/a4MTHAe1BZeorfvYsaQFTErFbDcLi1FbT2UajCD9xKy+JuRIwzvKWVbw
         CjwW/nyyy4iz4JbFpI1988rgoSwkizT3AbwqAa/uk8wRgGOJxIeI889KCQP71rxEcsri
         Kouw==
X-Received: by 10.152.203.168 with SMTP id kr8mr32545052lac.17.1400597347631;
        Tue, 20 May 2014 07:49:07 -0700 (PDT)
Received: from localhost ([193.9.244.4])
        by mx.google.com with ESMTPSA id sz5sm21019886lbb.33.2014.05.20.07.49.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 May 2014 07:49:06 -0700 (PDT)
X-Google-Original-From: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-Mailer: git-send-email 1.9.2-17
In-Reply-To: <537B5E8C.3070803@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249688>

Added in 0a144b3 (t4205, t6006: add failing tests for the case when
i18n.logOutputEncoding is set, 2014-05-19) tests give no error
(somehow) with Bash as /bin/sh but fail for some other shells.

Quote format strings to avoid errors.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
Suggested-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/t6006-rev-list-format.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index c6e9a73..19434ad 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -149,7 +149,7 @@ commit $head1
 $added
 EOF
 
-test_format subject-truncated %<($truncate_count,trunc)%s <<EOF
+test_format subject-truncated "%<($truncate_count,trunc)%s" <<EOF
 commit $head2
 changed (ge${changed_utf8_part}ndert)..
 commit $head1
@@ -259,7 +259,7 @@ commit $head1
 $added_iso88591
 EOF
 
-test_format complex-subject-trunc %<($truncate_count,trunc)%s <<EOF
+test_format complex-subject-trunc "%<($truncate_count,trunc)%s" <<EOF
 commit $head3
 Test printing of c..
 commit $head2
@@ -268,7 +268,7 @@ commit $head1
 added (hinzugef${added_utf8_part_iso88591}gt..
 EOF
 
-test_format complex-subject-mtrunc %<($truncate_count,mtrunc)%s <<EOF
+test_format complex-subject-mtrunc "%<($truncate_count,mtrunc)%s" <<EOF
 commit $head3
 Test prin..ex bodies
 commit $head2
@@ -277,7 +277,7 @@ commit $head1
 added (hi..f${added_utf8_part_iso88591}gt) foo
 EOF
 
-test_format complex-subject-ltrunc %<($truncate_count,ltrunc)%s <<EOF
+test_format complex-subject-ltrunc "%<($truncate_count,ltrunc)%s" <<EOF
 commit $head3
 .. of complex bodies
 commit $head2
@@ -314,7 +314,7 @@ commit $head1
 $added
 EOF
 
-test_format complex-subject-commitencoding-unset-trunc %<($truncate_count,trunc)%s <<EOF
+test_format complex-subject-commitencoding-unset-trunc "%<($truncate_count,trunc)%s" <<EOF
 commit $head3
 Test printing of c..
 commit $head2
@@ -323,7 +323,7 @@ commit $head1
 added (hinzugef${added_utf8_part}gt..
 EOF
 
-test_format complex-subject-commitencoding-unset-mtrunc %<($truncate_count,mtrunc)%s <<EOF
+test_format complex-subject-commitencoding-unset-mtrunc "%<($truncate_count,mtrunc)%s" <<EOF
 commit $head3
 Test prin..ex bodies
 commit $head2
@@ -332,7 +332,7 @@ commit $head1
 added (hi..f${added_utf8_part}gt) foo
 EOF
 
-test_format complex-subject-commitencoding-unset-ltrunc %<($truncate_count,ltrunc)%s <<EOF
+test_format complex-subject-commitencoding-unset-ltrunc "%<($truncate_count,ltrunc)%s" <<EOF
 commit $head3
 .. of complex bodies
 commit $head2
-- 
1.9.2-17
