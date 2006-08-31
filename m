From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH 0/3] git-daemon: plug new upload-tar command
Date: Thu, 31 Aug 2006 14:35:20 +0200
Message-ID: <11570277231100-git-send-email-vagabon.xyz@gmail.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 31 14:35:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIlla-0003S9-P0
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 14:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWHaMf1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 08:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWHaMf1
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 08:35:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:32618 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751411AbWHaMf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Aug 2006 08:35:26 -0400
Received: by nf-out-0910.google.com with SMTP id x30so387460nfb
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 05:35:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=dM+7qcN54YbW/Kjh18djeFpEZFHpvJyKCan6Pb8OaQ+N24CMXiar9RmOfpjlma3RQyNRIN4AGosEOHPkAWdfuzllwJVRbvjUzK4gsgT6fwrGrpwruXQ1IbtZz95ig1TJd1ezKBriqDGnAjUu3fLIVn6RQRjOG9J0pNxm8k+LFVc=
Received: by 10.48.14.4 with SMTP id 4mr1251247nfn;
        Thu, 31 Aug 2006 05:35:24 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [194.3.162.233])
        by mx.gmail.com with ESMTP id l21sm1543272nfc.2006.08.31.05.35.23;
        Thu, 31 Aug 2006 05:35:23 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 6C62723F76A; Thu, 31 Aug 2006 14:35:23 +0200 (CEST)
To: junkio@cox.net
X-Mailer: git-send-email 1.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26255>

Here's a simple patchset that basically teach git-daemon about the
upload-tar command added by Junio's commit:

217542640ed219c980fff2b3c307c4520120f20f

With a patched daemon it's now possible to do:

$ git tar-tree --remote=git://host/path/to/repo HEAD > repo.tar

It also creates a 'service' structure to ease future command
integration (like git internal commands handling does). I'm not sure
how usefull it will be, but it improves at least code readability.

Something that may be usefull now is to make git-daemon able to
compress data it sends back...


		Franck
---

 builtin-tar-tree.c |    2 +
 daemon.c           |   85 ++++++++++++++++++++++++++++++++++++++++++----------
 git.c              |    2 +
 3 files changed, 71 insertions(+), 18 deletions(-)
