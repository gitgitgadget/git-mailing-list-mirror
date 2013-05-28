From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/5] rebase: fix abort of cherry mode
Date: Tue, 28 May 2013 08:29:16 -0500
Message-ID: <1369747757-10192-5-git-send-email-felipe.contreras@gmail.com>
References: <1369747757-10192-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 15:31:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhJzk-0007ZK-B7
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 15:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934151Ab3E1NbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 09:31:15 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:41799 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933952Ab3E1NbM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 09:31:12 -0400
Received: by mail-oa0-f51.google.com with SMTP id f4so9995463oah.10
        for <git@vger.kernel.org>; Tue, 28 May 2013 06:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=KlvVmtPdA5TuFMU1qlcBQrRv1nGbOk4kpUdBVUl8zhE=;
        b=K8peqxyL80tp4owG2cfnNdAglahMNZXpEbIlaipxXxJVeufdHhTHOes9bpq0veHDb5
         KD4C4cf+qOLMvr7sfIHlAx+NQMtRMzC3tFOQeoAsbh2PEjJnChJEkLw11y4V1YoITVRw
         Mv8vPI5tSGsUhow4U1pfHbqEPyxU3v+HCpKuDEt5EI9XY6etCb7056G9ixNSF4/14VlI
         Kackk6wvi3SkewAMyiajrE+z7i1VDw9GdQB8oC4XnROyCfLC01L60IMQARI7nQHUMaqG
         hV2DDqez28yg9GVjyFpFXZBeXWVuIc5wymkhvPwihtVSU1IEwguFwzBkIbiWLB77OzDb
         Qg7A==
X-Received: by 10.60.37.133 with SMTP id y5mr4256167oej.123.1369747871854;
        Tue, 28 May 2013 06:31:11 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id q4sm34655090obl.1.2013.05.28.06.31.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 06:31:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369747757-10192-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225648>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-rebase.sh b/git-rebase.sh
index b7759d5..48bd1b8 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -335,6 +335,7 @@ skip)
 	run_specific_rebase
 	;;
 abort)
+	test "$type" == "cherry" && git cherry-pick --abort
 	git rerere clear
 	read_basic_state
 	case "$head_name" in
-- 
1.8.3.rc3.312.g47657de
