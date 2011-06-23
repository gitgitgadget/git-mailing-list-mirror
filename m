From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/4] git-instaweb: Improving handling of --start/--restart
Date: Thu, 23 Jun 2011 21:50:55 +0200
Message-ID: <20110623194624.18265.82482.stgit@localhost.localdomain>
References: <201106232129.22137.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Gurjeet Singh <singh.gurjeet@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 21:51:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZpvw-0007JL-9k
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 21:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933242Ab1FWTvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 15:51:19 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45561 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932951Ab1FWTvS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 15:51:18 -0400
Received: by fxm17 with SMTP id 17so1472543fxm.19
        for <git@vger.kernel.org>; Thu, 23 Jun 2011 12:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:subject:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=Q4wmVczXiHgddSViE65vLcoICoVjOfGh218Q3NxX9ZY=;
        b=OM3lRrygpLo98w2g91NDl1+zAg74Lr/HqG+hFH2HxI5dvX+0qFwHKRjfLwbdZ2U2kP
         8qYTp7Y5ojf8kJh9EFu/wCtWqt27vBiq31YepLetemREdu4BwLxLxqWvumqx7f+9S63I
         3jeUuqyurih4gFGtEZVWj8kYv3FFwg1O7HQw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=bgOV1i21VnhcmV4kZD0kdhZVyIbXSAtQ4QhVM4ZIgbxKQy9A8SiNWs55y1HJ0712LX
         rn2pZJhle9Vla+/yQwk/Ufrbvr8lkUS1gNXSlqxPztrBF/sN7tSyaPOZSr/hRCLBDINq
         64QriQu1kWRW8mYWQkx99+uYyEbGuSpc2Lu8s=
Received: by 10.223.61.72 with SMTP id s8mr3196572fah.6.1308858677019;
        Thu, 23 Jun 2011 12:51:17 -0700 (PDT)
Received: from localhost.localdomain (abva28.neoplus.adsl.tpnet.pl [83.8.198.28])
        by mx.google.com with ESMTPS id 10sm1192094faw.24.2011.06.23.12.51.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Jun 2011 12:51:16 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p5NJotUL018363;
	Thu, 23 Jun 2011 21:51:06 +0200
In-Reply-To: <201106232129.22137.jnareb@gmail.com>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176288>

This series fixes the issue reported by Gurheet Singh in "Having some
problem with instaweb", in that --start/--restart doesn't generate
configuration, which is documented:

  start, --start
      Start the httpd instance and exit. This does not generate any of the
      configuration files for spawning a new instance.

but unexpected.

The first three patches are independent refactoring to make final
change smaller and easier to review, thoug they have merit even taken
standalone.

---
Jakub Narebski (4):
      git-instaweb: Check that correct config file exists for (re)start
      git-instaweb: Move all actions at the end of script
      git-instaweb: Use $conf, not $fqgitdir/gitweb/httpd.conf
      git-instaweb: Extract web server configuration into configure_httpd

 Documentation/git-instaweb.txt |    8 ++--
 git-instaweb.sh                |   84 ++++++++++++++++++++++++++--------------
 2 files changed, 58 insertions(+), 34 deletions(-)

-- 
Jakub Narebski
ShadeHawk on #git
Poland
