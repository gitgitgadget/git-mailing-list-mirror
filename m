From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 03/15] contrib: related: sort by amount of involvement
Date: Sat, 18 May 2013 06:46:43 -0500
Message-ID: <1368877615-9563-4-git-send-email-felipe.contreras@gmail.com>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 18 13:48:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udfcv-0006ti-SF
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 13:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754250Ab3ERLsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 07:48:38 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:54311 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761Ab3ERLsh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 07:48:37 -0400
Received: by mail-oa0-f50.google.com with SMTP id l20so6005256oag.23
        for <git@vger.kernel.org>; Sat, 18 May 2013 04:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ZX7njtUwQgiGp2htSwD5oBZHwXb3XDsGazCu+imYebA=;
        b=N4DRS/1P2LsnAUUJJ3nhkcODDPrJOHNrwmGLzcEpBlbAzrOY4pR+/wOlt7aHVqi6Dm
         /l/63RAg8zXfCiio6pJuK+xYHi3m0uXaBuWwFMuc062LPBgamPDkyznCSLmFPYZginmV
         8LEKvklcxyyzfE/ZKVWm44RcXYQn6EGp8owDG5T5IzUcbhRUHWI0LZ7Q9MpDAktKchws
         bGNO5t7u4cOM3l+taOy/AXEnH0k2pOToVw3auytVlEfRORgA5LKj1Qc8QmuosPxYZ1Gv
         NeeJPlgWJnfi3XSt9c4goJehsZdhyuIe8cds9Q+FVHWn6AYhexhX6LpaPe4UvOogZYWo
         mESw==
X-Received: by 10.60.84.102 with SMTP id x6mr25672772oey.73.1368877716620;
        Sat, 18 May 2013 04:48:36 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id eq4sm11264782obb.5.2013.05.18.04.48.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 18 May 2013 04:48:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
In-Reply-To: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224776>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 6f18cc8..8c26cf8 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -134,7 +134,12 @@ commits.each do |id, commit|
   end
 end
 
-count_per_person.each do |person, count|
+# sort by number of participations
+count_sort = lambda do |a, b|
+  b[1] <=> a[1]
+end
+
+count_per_person.sort(&count_sort).each do |person, count|
   percent = count.to_f * 100 / commits.size
   next if percent < $min_percent
   puts person
-- 
1.8.3.rc2.542.g24820ba
