From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv4 3/5] git-sh-setup: introduce say() for quiet options
Date: Tue, 16 Jun 2009 15:32:59 -0700
Message-ID: <1245191581-11127-4-git-send-email-bebarino@gmail.com>
References: <1245117905-19351-1-git-send-email-bebarino@gmail.com>
 <1245191581-11127-1-git-send-email-bebarino@gmail.com>
 <1245191581-11127-2-git-send-email-bebarino@gmail.com>
 <1245191581-11127-3-git-send-email-bebarino@gmail.com>
Cc: Thomas Adam <thomas.adam22@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 00:34:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGhES-0001yF-9v
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 00:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757731AbZFPWdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 18:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757499AbZFPWdh
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 18:33:37 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:28763 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760496AbZFPWdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 18:33:09 -0400
Received: by wa-out-1112.google.com with SMTP id j5so969312wah.21
        for <git@vger.kernel.org>; Tue, 16 Jun 2009 15:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=SNkUfuhwQjt7Ixfbgy9ySrpW5aMOaOarKjRhray+1bE=;
        b=aDBCKU8PKEYZ6hvBkvksM0fs+nN6wYeUbllOZRh+MjFRI5Pl9nTv9/Ha6ds1qEF/m9
         MchNANbsmrvcwNy4CUdxWkH4SjtvKlLB86NrDx5WbD9ylmY1KPoSTFWdUBBHfXZqp+ar
         5t3gEgKajngekL8r9ijnosFJbBLSrue6N87IY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IHyuK3sczkSm7Oj+Sz9l7aNm7YSnu+N5doI8oe1aI0PGXFsUtnGZdl4JUrnGYVgbuI
         HgcH2k1MPG9DScGfu3Ht1JphCV9e+69N2Njs8B1txDgRRtMt3/X1X/2F95QnzkX+xoZn
         0NBy1r31U1p7cf5yJNhyS8Yi6FuJDXecQyitU=
Received: by 10.115.95.13 with SMTP id x13mr14267579wal.64.1245191592016;
        Tue, 16 Jun 2009 15:33:12 -0700 (PDT)
Received: from earth (user-0c9haco.cable.mindspring.com [24.152.169.152])
        by mx.google.com with ESMTPS id n9sm1850868wag.23.2009.06.16.15.33.10
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Jun 2009 15:33:11 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Tue, 16 Jun 2009 15:33:09 -0700
X-Mailer: git-send-email 1.6.3.2.306.g4f4fa
In-Reply-To: <1245191581-11127-3-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121723>

Scripts should use say() when they want to output non-error messages.
This function helps future script writers easily implement a quiet
option by setting GIT_QUIET to enable suppression of non-error messages.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 git-sh-setup.sh |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 80acb7d..c41c2f7 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -44,6 +44,15 @@ die() {
 	exit 1
 }
 
+GIT_QUIET=
+
+say () {
+	if test -z "$GIT_QUIET"
+	then
+		printf '%s\n' "$*"
+	fi
+}
+
 if test -n "$OPTIONS_SPEC"; then
 	usage() {
 		"$0" -h
-- 
1.6.3.2.306.g4f4fa
