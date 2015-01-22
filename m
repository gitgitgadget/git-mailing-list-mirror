From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] gitk: Remove tcl-format flag from a message that shouldn't have it
Date: Thu, 22 Jan 2015 01:19:39 -0700
Message-ID: <1421914779-30865-1-git-send-email-alexhenrie24@gmail.com>
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: git@vger.kernel.org, patthoyts@users.sourceforge.net,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jan 22 09:19:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YECzc-00044k-Tw
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 09:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbbAVITs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 03:19:48 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33563 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbbAVITq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 03:19:46 -0500
Received: by mail-ig0-f180.google.com with SMTP id b16so1234377igk.1
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 00:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=FbKQLx8IXJhFTjTZAVh92xyyvyDnhmhqWIu1wEQzM10=;
        b=jQWX1nyKgXa+SgUegkOngtNMwnHl323mThUJ9SVDF4ExXOBWRWtJShaNx1Mt2bJJMX
         vwb3kIPPwTV6PQzFKVGXiF2HmmpNMLVOCAhLDAEu0vXD1I4cpGXnvJmnPK6XBEDqGhxz
         NxqUkQim76n5LTanK3NQo9pmMFIONEwUzHKyTotSLRaLpiflwWwdgDOshDe4ZPjR5htX
         GQB+A0OYJRQ98aZhErDoATJcae/ybq2Q1sDkveLJuBVrjGj+0iVfEJqWpK6j0J88IquR
         qWxTJ41Zy10OfAohI9SyfnIlwbYEbd0zYYDig2xVlpV8IpW98eSX5EA+gscQdGYmOo1o
         RzMw==
X-Received: by 10.42.207.129 with SMTP id fy1mr1328408icb.17.1421914786074;
        Thu, 22 Jan 2015 00:19:46 -0800 (PST)
Received: from alex-wolverine.lan (c-98-202-141-117.hsd1.ut.comcast.net. [98.202.141.117])
        by mx.google.com with ESMTPSA id fr4sm1986852igd.4.2015.01.22.00.19.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jan 2015 00:19:44 -0800 (PST)
X-Mailer: git-send-email 2.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262809>

xgettext sees "% o" and interprets it as a placeholder for an octal
number preceded by a space. However, in this case it's not actually a
placeholder, and most translations will replace the "% o" sequence with
something else. Removing the tcl-format flag from this string prevents
tools like Poedit from freaking out when "% o" doesn't appear in the
translated string.

The corrected flag will appear in each translation's po file the next time
the translation is updated with `make update-po`.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 gitk-git/gitk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 78358a7..dfd458d 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -11237,6 +11237,7 @@ proc prefspage_general {notebook} {
     ${NS}::label $page.maxwidthl -text [mc "Maximum graph width (lines)"]
     spinbox $page.maxwidth -from 0 -to 100 -width 4 -textvariable maxwidth
     grid $page.spacer $page.maxwidthl $page.maxwidth -sticky w
+                                         #xgettext:no-tcl-format
     ${NS}::label $page.maxpctl -text [mc "Maximum graph width (% of pane)"]
     spinbox $page.maxpct -from 1 -to 100 -width 4 -textvariable maxgraphpct
     grid x $page.maxpctl $page.maxpct -sticky w
-- 
2.2.2
