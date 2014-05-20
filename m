From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 19/19] t/test-lib-functions.sh: convert test -a/-o to && and ||
Date: Tue, 20 May 2014 06:50:32 -0700
Message-ID: <1400593832-6510-20-git-send-email-gitter.spiros@gmail.com>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 15:51:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmkRj-0000Bh-Ld
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 15:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656AbaETNvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 09:51:03 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:34457 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641AbaETNu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 09:50:57 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so340799pbb.39
        for <git@vger.kernel.org>; Tue, 20 May 2014 06:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IOIvQ4n/SnOZW8V5tLnoSn4HkHXIyyDnIcWHpYvV3No=;
        b=0Vr/Rx2ESNAhgEfAw9nxhqpU163rFFu2FrYKhY6ai517hH1hbypyN78sKSoi5821zO
         1+6ZVz0Tf2m0x3S8FSzjCOL19rurVjflRiJpYDQU7fGIjObxSgWVawfgCITaz6LDaawq
         nPuGowbkp+ibor7JS50wvBWb9pT/DCXoQ+k2+IpdG9MKuUvQdDmd+ozn/qrlVhuChmwW
         6QtPwKXk26se1E+6lwy+Sea/iamksJHkJD4NuUFslmAGaRz1cUqJl04FZy5+ZANRSy01
         S+V+DAJ9rlqwXZqVuEjv3S6sb0lMsXxOv2wcYmC4bugPOhQH7C6E83TjH3S8OqcSicCW
         9zoA==
X-Received: by 10.66.153.80 with SMTP id ve16mr51183242pab.143.1400593857312;
        Tue, 20 May 2014 06:50:57 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id oe4sm3317286pbb.33.2014.05.20.06.50.56
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 06:50:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249671>

The interaction with unary operators and operator precedence
for && and || are better known than -a and -o, and for that
reason we prefer them. Replace all existing instances
of -a and -o to save readers from the burden of thinking
about such things.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/test-lib-functions.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 158e10a..0681003 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -542,7 +542,7 @@ test_must_fail () {
 	if test $exit_code = 0; then
 		echo >&2 "test_must_fail: command succeeded: $*"
 		return 1
-	elif test $exit_code -gt 129 -a $exit_code -le 192; then
+	elif test $exit_code -gt 129 && test $exit_code -le 192; then
 		echo >&2 "test_must_fail: died by signal: $*"
 		return 1
 	elif test $exit_code = 127; then
@@ -569,7 +569,7 @@ test_must_fail () {
 test_might_fail () {
 	"$@"
 	exit_code=$?
-	if test $exit_code -gt 129 -a $exit_code -le 192; then
+	if test $exit_code -gt 129 && test $exit_code -le 192; then
 		echo >&2 "test_might_fail: died by signal: $*"
 		return 1
 	elif test $exit_code = 127; then
-- 
1.7.10.4
