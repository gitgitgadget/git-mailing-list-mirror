From: Adam Roben <aroben@apple.com>
Subject: [RESEND PATCH 0/9] Make git-svn fetch ~1.7x faster
Date: Thu, 25 Oct 2007 03:25:18 -0700
Message-ID: <1193307927-3592-1-git-send-email-aroben@apple.com>
Cc: Junio Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 12:26:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikzuv-0007IN-ID
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 12:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248AbXJYK0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 06:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756230AbXJYK0G
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 06:26:06 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:63556 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755451AbXJYK0F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 06:26:05 -0400
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out3.apple.com (Postfix) with ESMTP id 142FA1639CEE;
	Thu, 25 Oct 2007 03:26:05 -0700 (PDT)
Received: from relay14.apple.com (unknown [127.0.0.1])
	by relay14.apple.com (Symantec Mail Security) with ESMTP id F1C8F280A3;
	Thu, 25 Oct 2007 03:26:04 -0700 (PDT)
X-AuditID: 11807134-a8e60bb000000c52-40-47206f3ccd6f
Received: from localhost.localdomain (aroben3.apple.com [17.203.12.72])
	by relay14.apple.com (Apple SCV relay) with ESMTP id CE7EB2808E;
	Thu, 25 Oct 2007 03:26:04 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.1342.g32de
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62295>


This is a resend of my previous patch series to speed up git-svn, taking into
account comments from Eric, Johannes, and Brian.

--
 Documentation/git-cat-file.txt    |    6 +-
 Documentation/git-hash-object.txt |    5 +-
 builtin-cat-file.c                |   87 +++++++++++++++++----
 git-svn.perl                      |   40 +++++-----
 hash-object.c                     |   29 +++++++-
 perl/Git.pm                       |  153 ++++++++++++++++++++++++++++++++++++-
 t/t1005-cat-file.sh               |  126 ++++++++++++++++++++++++++++++
 t/t1006-hash-object.sh            |   49 ++++++++++++
 8 files changed, 452 insertions(+), 43 deletions(-)
