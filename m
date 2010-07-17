From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 0/2] non-incremental mode for fast-export
Date: Sat, 17 Jul 2010 11:00:49 -0600
Message-ID: <1279386051-31112-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, srabbelier@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 17 18:59:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaAjd-0006Rh-70
	for gcvg-git-2@lo.gmane.org; Sat, 17 Jul 2010 18:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760061Ab0GQQ7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jul 2010 12:59:15 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:38248 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756177Ab0GQQ7P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jul 2010 12:59:15 -0400
Received: by pvc7 with SMTP id 7so1199705pvc.19
        for <git@vger.kernel.org>; Sat, 17 Jul 2010 09:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=vfiRDmP0aHB9ttA57AE/tttqShBZjKUQkw52a2tes0U=;
        b=jLvKbdOQ+sIXrd3FsfL6QBJ/I+z5PqpT8fDMa0FhM1G5t1qe+LgZWQSoB8U1m3nql7
         3r7+xE6DYjqpQn48m95B30TFCQdg3e5s81PTocg8Y9MLQMvd1UkT3Ii47XEAsaJoSplQ
         l0LZLB2ebNVqrf1XOzyyAJY92ulN1Bwc5RcdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=KgFcp1nR5rxzaCMy10C5Y4Wg/frMxIcNzXBFxlzaWcyXgGK2HlWecjojcF7cvH8Oj9
         GqAaKK2HEhkauE6Z4TgDHZITxfD6+7DGAM6nnQb2WTBFi+PBpvQzvOhbjzRuUaekJC66
         2fhuFHJZmR5iZIFnv6fvcCjgg8NdKsc2GTj6E=
Received: by 10.114.93.14 with SMTP id q14mr3749031wab.62.1279385954110;
        Sat, 17 Jul 2010 09:59:14 -0700 (PDT)
Received: from localhost.localdomain (63-248-104-17.static.layl0101.digis.net [63.248.104.17])
        by mx.google.com with ESMTPS id r27sm14724374rvq.9.2010.07.17.09.59.12
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 17 Jul 2010 09:59:13 -0700 (PDT)
X-Mailer: git-send-email 1.6.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151195>

This patch series fixes silently dropped files in uses of fast-export
involving both --import-marks and limiting files by path.  It also
adds a new feature: a --full-tree option to switch from incremental to
comprehensive handling of files in commits.  The two changes are
related in that the bugfix consists of simply automatically activating
the new feature in a case where it is required for correct operation.

There is just one change since the last submission
  * modify one of the new testcases to not depend on the full exact
    output of fast-export (since it is no longer the same in next)
This change enables the series to apply cleanly to next.  All tests
pass with this series applied to either maint or next now.

I'll again note that it may make sense to split this patch series
since the first is a bugfix and thus makes sense to apply to maint,
while the second (whose testcase was the fragile one) is a feature
addition, though a fairly trivial one.

Elijah Newren (2):
      fast-export: Fix dropping of files with --import-marks and path limiting
      fast-export: Add a --full-tree option

 Documentation/git-fast-export.txt |    6 ++++++
 builtin/fast-export.c             |   11 ++++++++++-
 t/t9350-fast-export.sh            |   14 ++++++++++++++
 3 files changed, 30 insertions(+), 1 deletions(-)
