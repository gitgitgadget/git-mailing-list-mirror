From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 01/19] check_bindir: convert test -a/-o to && and ||
Date: Tue, 20 May 2014 06:50:14 -0700
Message-ID: <1400593832-6510-2-git-send-email-gitter.spiros@gmail.com>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 15:50:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmkRJ-00088X-31
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 15:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535AbaETNul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 09:50:41 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:35433 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456AbaETNuk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 09:50:40 -0400
Received: by mail-pb0-f51.google.com with SMTP id ma3so341529pbc.38
        for <git@vger.kernel.org>; Tue, 20 May 2014 06:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vmhjToNHVqlK+6ndxo9bN8QlhZVEvcXp43/6xgN2K9k=;
        b=XZe7qPoN8uNodm1Ye78ZcI9tw/yJutqHfz45YUrhUams+rNtFhG/guZtnzCZj5WuYt
         9Vde8Qte2AlgoHuX8CM6GMFu2YlYt11RDNhCEpfEVe/DYxJLUDSmIk6uMp9u5fHTrYE8
         kptAVLwrZRIkSSHKi2JNgHVwG5cEQy7iGpFMxbY7V2b1zLXQli5uV9Joa32sC7qwzDJl
         odmhz9MtppsDHA7cJE2dKXlXEkVN30i6gqNZUcruKoXYSDQ1CxVo8IeqolE+GaoQHv+n
         kHDSyuvic2+ghAHSsqQqYk38aEZY4stGNwpd8vTJUFCPFBax5ci6pwmPijxLyqGvX44j
         GKbw==
X-Received: by 10.68.162.34 with SMTP id xx2mr50649789pbb.120.1400593840056;
        Tue, 20 May 2014 06:50:40 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id oe4sm3317286pbb.33.2014.05.20.06.50.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 06:50:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249662>

The interaction with unary operators and operator precedence
for && and || are better known than -a and -o, and for that
reason we prefer them. Replace all existing instances
of -a and -o to save readers from the burden of thinking
about such things.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 check_bindir |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check_bindir b/check_bindir
index a1c4c3e..623eadc 100755
--- a/check_bindir
+++ b/check_bindir
@@ -2,7 +2,7 @@
 bindir="$1"
 gitexecdir="$2"
 gitcmd="$3"
-if test "$bindir" != "$gitexecdir" -a -x "$gitcmd"
+if test "$bindir" != "$gitexecdir" && test -x "$gitcmd"
 then
 	echo
 	echo "!! You have installed git-* commands to new gitexecdir."
-- 
1.7.10.4
