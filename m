From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 10/11] contrib: cc-cmd: sort by participation
Date: Fri, 19 Apr 2013 14:30:30 -0500
Message-ID: <1366399831-5964-11-git-send-email-felipe.contreras@gmail.com>
References: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 21:32:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTH2p-0005C1-U8
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 21:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154Ab3DSTcU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 15:32:20 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:65131 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715Ab3DSTcR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 15:32:17 -0400
Received: by mail-qc0-f182.google.com with SMTP id k19so889117qcs.13
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 12:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ua3RJpTBWShddIG6zzeu+F0ipOdr/t+2QLGN2m5Te70=;
        b=EcFO/2SWLiW04uosOP4D8F3qS7UEOLqunFvQK9qscklYCwEsK7SlkLMH6h3obQRFv8
         phc+Emz6JAXXkpmNg8jYGQ69XN4BpAMUpUhByvxWVgiv08z+zOx4e6bp3+0548y7IojJ
         S9WfgN1tO7eU7igC2brzC1b2fWFmfDHL0xxQeJzDEkWs3NgVPI6TREvBQH5radd1KKle
         HSKcJEQM1tOkcsIV6Jew2UieoR/iwc7lVBR0Z10kY+N9h5VzhMC8IEF4sJF1fBFyzE7s
         8xN+oazCmCbYFtvtYa+OFPxvRtXU2/t4tlQr3XA+xCEkW3dMnW7L53FIo3XJqXlXorf0
         ASUA==
X-Received: by 10.229.90.5 with SMTP id g5mr706698qcm.26.1366399936498;
        Fri, 19 Apr 2013 12:32:16 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id en8sm18662112qeb.0.2013.04.19.12.32.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Apr 2013 12:32:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366399831-5964-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221805>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/cc-cmd/git-cc-cmd | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
index 67a276d..9a2d2fd 100755
--- a/contrib/cc-cmd/git-cc-cmd
+++ b/contrib/cc-cmd/git-cc-cmd
@@ -237,7 +237,12 @@ commits.items.values.each do |commit|
   end
 end
 
-persons.each do |person, roles|
+# sort by number of participations
+count_sort = lambda do |a, b|
+  b[1].values.reduce(:+) <=> a[1].values.reduce(:+)
+end
+
+persons.sort(&count_sort).each do |person, roles|
   roles = roles.map do |role, count|
     percent = count.to_f * 100 / commits.size
     next if percent < $min_percent
-- 
1.8.2.1.790.g4588561
