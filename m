From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] index-format.txt: be more liberal on what can represent invalid cache tree
Date: Wed, 12 Dec 2012 19:44:36 +0700
Message-ID: <1355316276-7661-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 13:44:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tilfp-0002K5-Jr
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 13:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862Ab2LLMoN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2012 07:44:13 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55934 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab2LLMoM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 07:44:12 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so572782pad.19
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 04:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=+VKosSzHX0EaRb2fT84xue7MgqBkCKWEqUGYD4pe+Us=;
        b=IjnV2JMy26HyEc4v6rIAw18DJf8QzcGMoSrSyHGlypLKb2adZl6/ONajUyKA1ZqsRA
         w7WzfcBbKRep6HJVAzcJdTAzG+5agOwD1eSHs/oH5j6ZEjK1OD2r5WxgotAl0zbtV7fp
         Z7MpbPZf4I+kT+0RWv+4DcZ5SJLhHDbRQXG3CS2NnETXixm9Ql4PZo9zTTpVwHw91UPH
         qFeNoAyEslPkt183RoMWHBEPT0aDj7BFjL0kWYq9OAYrtHMOXHlm+LkFoCZOgKVfg8F9
         qZ4fgEzMGpK2SEAJeBnoqNf/M1924cojxxNZXyQbz+vah4UcZOKJjF10i6S2zMLpfi6r
         gWNA==
Received: by 10.68.241.136 with SMTP id wi8mr2469511pbc.95.1355316252454;
        Wed, 12 Dec 2012 04:44:12 -0800 (PST)
Received: from lanh ([115.74.41.198])
        by mx.google.com with ESMTPS id qb3sm3920920pbb.35.2012.12.12.04.44.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 12 Dec 2012 04:44:11 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 12 Dec 2012 19:44:45 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211352>

We have been writing -1 as "invalid" since day 1. On that same day we
accept all negative entry counts as "invalid". So in theory all C Git
versions out there would be happy to accept any negative numbers. JGit
seems to do exactly the same.

Correct the document to reflect the fact that -1 is not the only magic
number. At least one implementation, libgit2, is found to treat -1
this way.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/index-format.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/t=
echnical/index-format.txt
index 9d25b30..2028a49 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -161,8 +161,8 @@ GIT index format
     this span of index as a tree.
=20
   An entry can be in an invalidated state and is represented by having
-  -1 in the entry_count field. In this case, there is no object name
-  and the next entry starts immediately after the newline.
+  a negative number in the entry_count field. In this case, there is n=
o
+  object name and the next entry starts immediately after the newline.
=20
   The entries are written out in the top-down, depth-first order.  The
   first entry represents the root level of the repository, followed by=
 the
--=20
1.8.0.rc2.23.g1fb49df
