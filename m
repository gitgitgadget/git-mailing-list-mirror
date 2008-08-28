From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [JGIT PATCH 0/3] Fix local tracking refs updates during push
Date: Thu, 28 Aug 2008 04:32:46 +0200
Message-ID: <1219890769-20119-1-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Aug 28 04:34:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYXKj-0007A2-DV
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 04:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192AbYH1Cc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 22:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343AbYH1Cc5
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 22:32:57 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:2777 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbYH1Cc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 22:32:57 -0400
Received: by mu-out-0910.google.com with SMTP id g7so125717muf.1
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 19:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=gq7wM4yremacoKq4hBKixuhSK7eLRrXK/yV1voZbG3w=;
        b=n8MmJ2UurFaAqg7x0/UICEWynFvPPV0krjGUd2VStLVwUvyRIRP5aT4vTaQ5V/UUvR
         anKq3+kJ3wEuwHQ/9Sj70HRYjYOSyUuGGjeWayWRtMhSWjNg0bpdz0YZ+qc8hOB6lMM/
         i71isgAMtnJD6BSsyQxCYOMjXtZMa1UKtKvC8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=PCfUm8JWozXhuMf61A9jTHMu12WCqtyFM4zkj2Try9bXhobD22a6ku3GNmYvpsDhmP
         h9ZiP/IQSLuLmIurWMFzGCy3dn5kBaagWMWIe9eBjIc0LiiFmfHUVZTpQ41o1fFbzpB/
         ZIbn4CAwMXV81x+ZkPnSB60B8M4dyIg8K5Q4k=
Received: by 10.103.175.8 with SMTP id c8mr474581mup.26.1219890775487;
        Wed, 27 Aug 2008 19:32:55 -0700 (PDT)
Received: from localhost ( [62.21.4.140])
        by mx.google.com with ESMTPS id j2sm1772456mue.4.2008.08.27.19.32.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Aug 2008 19:32:54 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94021>

This series address http://code.google.com/p/egit/issues/detail?id=18
issue: PushProcess does not delete local tracking branches

BTW, I discovered that C Git always force update local tracking refs
upon successful push, so I also fixed it.

Marek Zawirski (3):
  Fix push's RemoteRefUpdate to always force update local
    TrackingRefUpdate
  Add another delete method in RefUpdate, reusing RevWalk
  Fix RemoteRefUpdate to delete local tracking ref upon successful
    deletion

 .../src/org/spearce/jgit/lib/RefUpdate.java        |   22 ++++++++++++++++++-
 .../spearce/jgit/transport/RemoteRefUpdate.java    |    7 ++++-
 .../spearce/jgit/transport/TrackingRefUpdate.java  |    4 +++
 3 files changed, 29 insertions(+), 4 deletions(-)
