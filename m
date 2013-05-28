From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/5] rebase: improve the keep-empty
Date: Tue, 28 May 2013 08:29:12 -0500
Message-ID: <1369747757-10192-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 15:31:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhJzi-0007ZK-O3
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 15:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934148Ab3E1NbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 09:31:03 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:43005 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933952Ab3E1NbA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 09:31:00 -0400
Received: by mail-oa0-f53.google.com with SMTP id g12so9882556oah.26
        for <git@vger.kernel.org>; Tue, 28 May 2013 06:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=xVQ+D/lf4MpQtUhXhPmDvsqNFYhCDVGmq6f+N/d4l7g=;
        b=zaLXErbX1siyqSlzaQbqwEWEpy5/xcr1sP+l+VCImWx6lo1uFj62Ib5DbUovmTl3sn
         pEe888xFZF9iCUJj0A7FEKSlMBrTD/P2x8kcl/X5vMplNKce60jlKno5CSmly/2szWFe
         KPxEw45nF/QbY9G1n8UOebxuxUpPC0CuEef7bwsczy+QVSUs+svBSZnT71GQ5/kBz21y
         5iCz9dFgHfq0tsF0OMF5BM7VkpzXIJ+pvuVu72XBSL9m+Ww+ilntmDHC41PxLDQ2BicL
         aPs/WInppyB1VcHDHL0QhkoFqooghmiYqbLGXt2kTZ5U5z+AAhxLmUJ6vhb2zX5Fk72X
         dniw==
X-Received: by 10.60.65.38 with SMTP id u6mr20585673oes.52.1369747859720;
        Tue, 28 May 2013 06:30:59 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ek3sm8913384obb.6.2013.05.28.06.30.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 06:30:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225646>

Hi,

I've been analyzing 'git rebase' and found that the --keep-empty option
triggers a very very different behavior. Here's a bunch of patches that make it
behave like the 'am' does does for the most part.

There's only a few minor changes, after which it might be possible to replace
the whole 'am' mode to use cherr-pick instead.

Felipe Contreras (5):
  rebase: split the cherry-pick stuff
  rebase: fix 'cherry' mode storage
  rebase: fix sequence continuation
  rebase: fix abort of cherry mode
  rebase: fix cherry-pick invocations

 .gitignore            |  1 +
 Makefile              |  1 +
 git-rebase--am.sh     | 65 ++++++++++++++++++++++-----------------------------
 git-rebase--cherry.sh | 55 +++++++++++++++++++++++++++++++++++++++++++
 git-rebase.sh         |  8 +++++++
 5 files changed, 93 insertions(+), 37 deletions(-)
 create mode 100644 git-rebase--cherry.sh

-- 
1.8.3.rc3.312.g47657de
