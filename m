From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 0/5] fixes for committer/author parsing/check
Date: Thu, 28 Jul 2011 11:43:59 +0600
Message-ID: <1311831844-13123-1-git-send-email-divanorama@gmail.com>
Cc: SASAKI Suguru <sss.sonik@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 07:41:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmJLU-0004Gf-U7
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 07:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784Ab1G1FlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 01:41:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56514 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484Ab1G1FlO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 01:41:14 -0400
Received: by fxh19 with SMTP id 19so916357fxh.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 22:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=3Loyj9HmcmbiKIoj5UWeRqrU1s/dnGJvAMj9sefZCDE=;
        b=Q3kcsGo73ymV8KmufUs2/9ozWdQVbW0DrLpuV+FJa5qwYHN7ZFuyF4f4uQcL/4wZOh
         0fjn2KTvRsZVyZ+6RW0YyPEl7RHSUpjpeBsKacUtX1g1JSBDxg3IUOoXbsdcV0K7dDzh
         rgvS8zZKchaEJD/wqLF08sPTzAVfulecAiafs=
Received: by 10.204.153.208 with SMTP id l16mr173064bkw.342.1311831673626;
        Wed, 27 Jul 2011 22:41:13 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id g11sm154133bku.49.2011.07.27.22.41.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 22:41:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178035>

fast-import part is clear and should be safe to apply. The test
script is a bit ugly as it uses fsck and prune on a shared (with
nearby tests) repo. But it should work, any hints on simplifying
it are welcome.

fsck part fixes an uncaught bad committer, but also changes error
messages for some of bad committer strings. The messages choice is
a subject for discussion most likely.

Dmitry Ivankov (5):
  fast-import: add input format tests
  fast-import: don't fail on omitted committer name
  fast-import: check committer name more strictly
  fsck: add a few committer name tests
  fsck: improve committer/author check

 fast-import.c          |   33 ++++++++++------
 fsck.c                 |   10 +++--
 t/t1450-fsck.sh        |   24 ++++++++++++
 t/t9300-fast-import.sh |   99 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 150 insertions(+), 16 deletions(-)

-- 
1.7.3.4
