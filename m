From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v5 0/5] Handling of in-tree symlinks for absolute paths
Date: Sun,  2 Feb 2014 17:35:35 +0100
Message-ID: <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
References: <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
Cc: richih@debian.org, tboegi@web.de, gitster@pobox.com,
	pclouds@gmail.com, dak@gnu.org,
	Martin Erik Werner <martinerikwerner@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 02 17:36:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WA01y-0008M5-DH
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 17:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbaBBQgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 11:36:13 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:59482 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313AbaBBQgM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 11:36:12 -0500
Received: by mail-lb0-f172.google.com with SMTP id c11so4774160lbj.3
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 08:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PVYwp1SdCCWcuSqMarwOO7sSjO+hdOHG+IgLaK9ey58=;
        b=YDxFcBPjYa7ZjneIZ9OS5U6+xdgrTE195Dk52lJkB8ZwyQvgHkxdu31tnIKPiSA7vF
         v1+kWsRClNpTpZT8l/C7iv09VcNL1jM2rMx1RAE0MMTJ4SKzmFqbvIs1ABKIPFl4nVt7
         pEi8FZGbEcixuHYEB7R4omqPUl1m7oldbYijxD+cnMSxTtzz9n0ZphJcYvhKdIhe/wCD
         zcSR8IPHhJZWqOWyXE5YmblKLrefgDxVB6wLS+MqZxdtQBSLhUir83yZFQgKanRfTa75
         pSaRCO1WXW5mKYa/n3erxbQe03O3t1i4UFGkgc2BlDwMeOXIxHRFcCkhnildyFgIbGFt
         q0MA==
X-Received: by 10.112.91.228 with SMTP id ch4mr9628117lbb.19.1391358969613;
        Sun, 02 Feb 2014 08:36:09 -0800 (PST)
Received: from mule.student.uu.se (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id jl8sm18063514lbc.16.2014.02.02.08.36.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Feb 2014 08:36:08 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241374>

Again!

(It seems you missed to CC me in your first reply David, please do :)

New reroll, fixing the /dir/repoa and /dir/repolink -> /dir/repo issues noted by
Duy, and adding corresponding tests. If work tree matches beginning of path but
needs further checking, it starts from the end of the work tree length, so as
minimize the 'real_path' calls.

Martin Erik Werner (5):
  t0060: Add test for manipulating symlinks via absolute paths
  t0060: Add test for prefix_path when path == work tree
  t0060: Add tests for prefix_path when path begins with work tree
  setup: Add 'abspath_part_inside_repo' function
  setup: Don't dereference in-tree symlinks for absolute paths

 setup.c               | 100 ++++++++++++++++++++++++++++++++++++++++----------
 t/t0060-path-utils.sh |  21 +++++++++++
 2 files changed, 101 insertions(+), 20 deletions(-)

-- 
1.8.5.2
