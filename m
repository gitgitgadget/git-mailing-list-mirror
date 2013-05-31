From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v3 0/7] Rebase topology test
Date: Thu, 30 May 2013 23:49:40 -0700
Message-ID: <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
References: <1369809572-24431-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 31 08:50:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiJAA-0000Y3-4S
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 08:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725Ab3EaGuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 02:50:06 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:61414 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab3EaGuE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 02:50:04 -0400
Received: by mail-qc0-f202.google.com with SMTP id d1so113180qcz.3
        for <git@vger.kernel.org>; Thu, 30 May 2013 23:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=iKBY1BlzyDnjDZxYw1/TFjvaikH07EKRcJCOQ+I+6Zk=;
        b=P8R/1Bd5GnX8nBvXpEDyDBapfgtgqyVlKmMCTeh+Cdst9pz9UoK/ic12nrDIWD7LfP
         yylFT/vo1jtbVnaQLa9aVFWc1o3/l3SCgXX7KGjfcoP9ij6ARUZ+IpZHse0NhYxOnTuk
         96EdBlux+G6Qy+iYKdauh/U1CJpi69J0MnsVzul0ij8IspRfL9jBqMw9QhWRaEt1EYAg
         7T0oXiDCU4E5pFEGSiJNShd4bT65tht62IU9p1869GCFVvNAcuurk/NxbU229r3gpnbD
         vtSWhdPwaAT6XV9I3NOO3IjN+pClrhvvdMLt4jB/wGp6CjWso6um59SnXeRqpiaF0LR/
         WEOw==
X-Received: by 10.236.19.198 with SMTP id n46mr5781828yhn.8.1369983002336;
        Thu, 30 May 2013 23:50:02 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id b23si3621204yhj.4.2013.05.30.23.50.02
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Thu, 30 May 2013 23:50:02 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 25A205A430F;
	Thu, 30 May 2013 23:50:02 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 4963E100D20; Thu, 30 May 2013 23:50:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.674.gd17d3d2
In-Reply-To: <1369809572-24431-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQnmgrmJlAppuceKAiI9yEuOMNiery6XP0bfxT5fXl3KP9In8Rg3aNoy9gGJ2WXFCBEYRCLlV2F08gTlZMbVnIXNunyv55n3jJljnNa/Nk2zg6Bd2u0ts0e/NVHVaKInbJGjuSriArC/RdlvwCaTstwMoeDtt5+QXqyGgUIBhVVHb1yk20xb5v7qo75Ie2lUBThUKd4d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226050>

Patches are now expected to be dropped iff they are on upstream. I've
also followed all of Johannes's other suggestions except for the one
about topo-order.

Martin von Zweigbergk (7):
  add simple tests of consistency across rebase types
  add tests for rebasing with patch-equivalence present
  add tests for rebasing of empty commits
  add tests for rebasing root
  add tests for rebasing merged history
  t3406: modernize style
  tests: move test for rebase messages from t3400 to t3406

 t/lib-rebase.sh                   |  32 ++++
 t/t3400-rebase.sh                 |  53 +-----
 t/t3401-rebase-partial.sh         |  69 --------
 t/t3404-rebase-interactive.sh     |  10 +-
 t/t3406-rebase-message.sh         |  50 +++---
 t/t3409-rebase-preserve-merges.sh |  53 ------
 t/t3420-rebase-topology-linear.sh | 350 ++++++++++++++++++++++++++++++++++++++
 t/t3425-rebase-topology-merges.sh | 252 +++++++++++++++++++++++++++
 8 files changed, 666 insertions(+), 203 deletions(-)
 delete mode 100755 t/t3401-rebase-partial.sh
 create mode 100755 t/t3420-rebase-topology-linear.sh
 create mode 100755 t/t3425-rebase-topology-merges.sh

-- 
1.8.2.674.gd17d3d2
