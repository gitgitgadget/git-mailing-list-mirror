From: Lucian Poston <lucian.poston@gmail.com>
Subject: [PATCH 0/1] Adjust diff stat width calculations so lines do not wrap in terminal when using --graph
Date: Tue, 20 Mar 2012 00:38:16 -0700
Message-ID: <1332229097-19262-1-git-send-email-lucian.poston@gmail.com>
Cc: Lucian Poston <lucian.poston@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 08:39:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9tfA-00082i-Ga
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 08:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757911Ab2CTHjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 03:39:08 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57924 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757688Ab2CTHjH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 03:39:07 -0400
Received: by pbcun15 with SMTP id un15so1540894pbc.19
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 00:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Ssb3dwNyatgXbSCwZEtu4TgPxk8pqO4m4vmFdgHbZTE=;
        b=QOEeXHXpr32CiU6evlQGKscdW/VwpHuaLYRGVpKfJ7L2X9/iZasO6l+fmmpscdIIqK
         yMQnkis1uWDrLWhOX+hXK7EsBj3zcxHc9G49JFDzmKynFUCnJvAKS+fnoGS1ryIPNG26
         6FbU11VQh9SxZUZtnDfYDyLGRo3ptufNhAbwR6miHjSXajtGpAQSQdsHLyL36fCUFO7X
         z1A1B/ul/arRS7VQa5QZRA1rI3YrHcXEpldyNIF8ed4hWO6+CEzs2YW+0xXENijOTS5L
         9rSVimHn/PaY4LbN388LF0ll8QPBJO+OSLNWbBx+F0o/pnbj9Ty/Ct7KYQ22go+lJ8Pa
         GIkA==
Received: by 10.68.241.131 with SMTP id wi3mr47243721pbc.1.1332229146996;
        Tue, 20 Mar 2012 00:39:06 -0700 (PDT)
Received: from localhost.localdomain (c-76-121-54-246.hsd1.wa.comcast.net. [76.121.54.246])
        by mx.google.com with ESMTPS id f7sm727637pbr.3.2012.03.20.00.39.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Mar 2012 00:39:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193487>

When diff stats are displayed in the terminal, the width is scaled to fit
within the available $COLUMNS. The current stat width calculations do not
factor in the diff output prefix that is displayed when when graphing the
commit history e.g. `git log --graph --stat`. Consequently, the diff stats can
wrap to next line breaking the text graph representation.

This patch adjusts the diff stat width calculations to prevent line wrapping
when the text-based graph representation is displayed along with the diff
stats.


Lucian Poston (1):
  Fix --stat width calculations to handle --graph

 diff.c                 |   55 ++++++++++++++++++++++++++++++++---------------
 t/t4052-stat-output.sh |   24 +++++++++++++++++++-
 2 files changed, 59 insertions(+), 20 deletions(-)

-- 
1.7.3.4
