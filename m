From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/2] Fix multiple file rename across D/F conflict
Date: Tue, 17 Aug 2010 17:53:17 -0600
Message-ID: <1282089199-17253-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 01:51:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlVwd-0006e9-LM
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 01:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659Ab0HQXvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 19:51:47 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62744 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472Ab0HQXvq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 19:51:46 -0400
Received: by qwh6 with SMTP id 6so6618535qwh.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 16:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=AlMNC7WZ8UC5bZpaSloABc0I/Eeo+lBuc+apkn7fFo4=;
        b=WXwjIX3IsAdJWwPGcCExZiD0jDQeNIQEnshSkdjnTGNqZKXd5f9NquST3hVfELGRyh
         IlKVVImKf3EH7UdztM7InxHe5wdc6pytoc6HFzPPKDR1sx5FrH+7vQmmiicO5jepGm7v
         UYg9iMMmCZnXn2AtptuvUJusHvxxYaD6kGqhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=XpUXIspLIaHLiJOTOA7FzzwmQrZ1m6+4gy3LUz5HJZfa+G0CK0fZpPNAulIzcidK1u
         JMrOtCs11WtybWc4hWCj7o0dmExBeLOrj6tnjS40zx2wOREPnat6Ecr5drPuja94gf/9
         vHjnXb6wpnYxaygPJTsZ4xrlzjJC+NdFLNH9Y=
Received: by 10.224.44.151 with SMTP id a23mr4848005qaf.6.1282089105948;
        Tue, 17 Aug 2010 16:51:45 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id r36sm9427471qcs.3.2010.08.17.16.51.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 16:51:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.227.g086c8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153794>

Another D/F conflict not fixed by the en/d-f-conflict-fix series in next
was found in the wild, involving multiple file renames across a D/F
conflict.  That series would have fixed this case too, were it not for
a stupid simple bug.  Fix it, and add a testcase for good measure.

This series is on top of next; it needs both the en/d-f-conflict-fix
series and the testcase requires em/checkout-orphan.

Elijah Newren (2):
  t6031: Add a testcase covering multiple renames across a D/F conflict
  merge-recursive: Fix triple file rename across D/F conflict

 merge-recursive.c          |    1 +
 t/t6031-merge-recursive.sh |   28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

-- 
1.7.2.1.227.g086c8
