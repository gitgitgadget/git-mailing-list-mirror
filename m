From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/3] remote-bzr: remove stale check code for tests
Date: Mon,  1 Apr 2013 15:14:31 -0600
Message-ID: <1364850872-21135-3-git-send-email-felipe.contreras@gmail.com>
References: <1364850872-21135-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 01 23:16:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMm5F-0004Q3-VZ
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 23:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757201Ab3DAVPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 17:15:33 -0400
Received: from mail-gh0-f179.google.com ([209.85.160.179]:47044 "EHLO
	mail-gh0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756988Ab3DAVPc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 17:15:32 -0400
Received: by mail-gh0-f179.google.com with SMTP id z12so465508ghb.24
        for <git@vger.kernel.org>; Mon, 01 Apr 2013 14:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=bYHm/snUvezxlkUj19Lj7NQ0dQSG21LIBTI/NSjeCMw=;
        b=o5wXIm5wGwk1ivNaXYiXOODEDoEYjaAc0iTZ5kkgeOXpUni8iqJPwPvTFbNlJF6sGs
         ybUDOU+U3FyAa29hb0si0iPDqKhprb7xPDy7JPa5JLCJj+syNM7nmMp6cblxOXAB3L0F
         DgPk+tJRBZIe3Zyh5Do3S7BilJ6FBECZ5QFUnTKI5LrcLp7JRj9wIK/03Zf5qJb0JZqt
         jyiAOVlWot97iLypO2QIc6XmVp+m3n684B2Dq8hGiPm1YeiFFv/KAFft/49hbr/3NA7N
         eBqUl7ngXQtf9nw9KVIDJpsj294MaOPYwzl75r/oGnK8W40zOhHkUGF/ASOM2VtjI1nC
         T+qQ==
X-Received: by 10.236.29.201 with SMTP id i49mr11927260yha.81.1364850931539;
        Mon, 01 Apr 2013 14:15:31 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id o64sm29877527yhd.16.2013.04.01.14.15.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Apr 2013 14:15:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364850872-21135-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219708>

The fastimport plugin was only required in the early stage of
development.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-bzr.sh | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
index 70aa8a0..5dac171 100755
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
