From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v6 0/8] Rebase topology test
Date: Thu,  6 Jun 2013 23:11:36 -0700
Message-ID: <1370585503-11374-1-git-send-email-martinvonz@gmail.com>
References: <1370292135-1236-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 08:19:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukq1C-0000FA-Pt
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 08:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056Ab3FGGTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 02:19:18 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:46490 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789Ab3FGGTR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 02:19:17 -0400
Received: by mail-qa0-f74.google.com with SMTP id g10so128391qah.3
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 23:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=Ai7H7I2WgPzNw7V3MjztwakT1BmveS+8H3F5zyj1BNw=;
        b=lnQDdxHQgxJdFQtZjDIsgAt/zhUBXyIJdtBQ2o/OpLsWrtvPySkixmP7J/XlB/0/fR
         G8XlJzMvOLPlne1Y+D/Y4TaYl4YhYUyWVKX6qg4tct8zgvHQdD1YwMq94LelScdvUTbu
         Jq3N7rJWDVIlFMdaDnvktZEdtnbFE/7Y1LKsPCIVUqKHoTtrh1a5WOFQnIf8QlsG5tcT
         LZ48ku9iFuFYfsU2ICO2QX2ncVGzBSq080uaokeeVsQvNlHo8wpSv2aAFdwmBhL0A/Ku
         hf4mZU0ZagFr3oi2ynVvIBuVABvpcUhxcMUbz8GXoWtH5e+YTJ8jX16DbMufisNHwSYl
         O0Fg==
X-Received: by 10.236.118.196 with SMTP id l44mr21811759yhh.48.1370585510224;
        Thu, 06 Jun 2013 23:11:50 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y4si5472795yhi.3.2013.06.06.23.11.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Thu, 06 Jun 2013 23:11:50 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 08B7731C1BD;
	Thu,  6 Jun 2013 23:11:50 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id A4AEF10084C; Thu,  6 Jun 2013 23:11:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.497.g83fddbe
In-Reply-To: <1370292135-1236-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQmrhsHh3xy1JKBjlXO0f77ndBf55T8U0HQqRcYDGzSZ+OFIIsQLrwb5V8HGAsQoIPshLTTcLORdLiTDMUYS1yq4O80ho3OZOkIs8ZMH+XpLftzfgIeJDvpduo1vwmmVY3D5IPaLOLl4Zsra1kzi8up70m1Y5H0PuSNzOcqhFQ7E+k9+zXUbKxO/hF7R7wVqXM28Mykc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226605>

Changes since v5:

 * Improved test_linear_range
 * Changed TODOs to be about consistency, not --topo-order

Martin von Zweigbergk (7):
  add simple tests of consistency across rebase types
  add tests for rebasing with patch-equivalence present
  add tests for rebasing of empty commits
  add tests for rebasing root
  add tests for rebasing merged history
  t3406: modernize style
  tests: move test for rebase messages from t3400 to t3406

 t/lib-rebase.sh                   |  33 ++++
 t/t3400-rebase.sh                 |  53 +-----
 t/t3401-rebase-partial.sh         |  69 --------
 t/t3404-rebase-interactive.sh     |  10 +-
 t/t3406-rebase-message.sh         |  50 +++---
 t/t3409-rebase-preserve-merges.sh |  53 ------
 t/t3421-rebase-topology-linear.sh | 350 ++++++++++++++++++++++++++++++++++++++
 t/t3425-rebase-topology-merges.sh | 258 ++++++++++++++++++++++++++++
 8 files changed, 673 insertions(+), 203 deletions(-)
 delete mode 100755 t/t3401-rebase-partial.sh
 create mode 100755 t/t3421-rebase-topology-linear.sh
 create mode 100755 t/t3425-rebase-topology-merges.sh

-- 
1.8.3.497.g83fddbe
