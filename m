From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/4] remote-bzr: remove stale check code for tests
Date: Thu,  4 Apr 2013 09:36:18 -0600
Message-ID: <1365089779-9726-4-git-send-email-felipe.contreras@gmail.com>
References: <1365089779-9726-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>, Antoine Pelisse <apelisse@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 04 17:38:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNmEo-0000m1-4S
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 17:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760810Ab3DDPha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 11:37:30 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:33251 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760763Ab3DDPh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 11:37:27 -0400
Received: by mail-ob0-f172.google.com with SMTP id tb18so2707743obb.31
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 08:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=wVZxMwpJmRlbUzveDh/VUCqHql7Zs/qpj+Zq7//mv0U=;
        b=mQNtB3nv+xJOyIRwjEgzuhc39IlX+wB0wFr0YAUjXzIgObheoWmtHW4mlslpXG5/XC
         a9M9raSQuLyWf7wUGAA1qE6dB3vyh4JziJKleaoXdkv69gzWBD5PT5OF10BH6Yz2TpCy
         bDro/10zz3hwfMMufAT4o+qoLmOZnipO4ZT6oPsSPUzONsfRKMuWQMIkf37NuDWR+scC
         0wKTOl+6DU+ST6i5Cg4vIXb4KtRDoZL50GDit4zpD0GbR9p0ex6g3UXXTWeRkyi9ajfP
         nZlWxCfoTEguRtc6l/8eYNAswuNwFhU6u2aBxSfvL65LG2gEw/V2zenH34VcG9ZXXQD5
         oWXQ==
X-Received: by 10.60.34.98 with SMTP id y2mr74945oei.74.1365089846173;
        Thu, 04 Apr 2013 08:37:26 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id d10sm6821547obk.1.2013.04.04.08.37.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 08:37:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365089779-9726-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220021>

The fastimport plugin was only required in the early stage of
development.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-bzr.sh | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
index b81052b..8450432 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -17,20 +17,6 @@ if ! "$PYTHON_PATH" -c 'import bzrlib'; then
 	test_done
 fi
 
-cmd='
-import bzrlib
-bzrlib.initialize()
-import bzrlib.plugin
-bzrlib.plugin.load_plugins()
-import bzrlib.plugins.fastimport
-'
-
-if ! "$PYTHON_PATH" -c "$cmd"; then
-	echo "consider setting BZR_PLUGIN_PATH=$HOME/.bazaar/plugins" 1>&2
-	skip_all='skipping remote-bzr tests; bzr-fastimport not available'
-	test_done
-fi
-
 check () {
 	(cd $1 &&
 	git log --format='%s' -1 &&
-- 
1.8.2
