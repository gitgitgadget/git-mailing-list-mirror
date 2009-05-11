From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/4] gitweb: Use capturing parentheses only when you intend to
	capture
Date: Mon, 11 May 2009 19:39:43 +0200
Message-ID: <20090511173733.15152.83661.stgit@localhost.localdomain>
References: <20090511173025.15152.94215.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 19:39:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3ZTn-0006Bs-PT
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 19:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755256AbZEKRjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 13:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754687AbZEKRjr
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 13:39:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:6279 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901AbZEKRjq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 13:39:46 -0400
Received: by fg-out-1718.google.com with SMTP id d23so618632fga.17
        for <git@vger.kernel.org>; Mon, 11 May 2009 10:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=+x5W8tRigXFDiyMPkqNqh1x8fY/36Ajrhat8kxqrsrI=;
        b=fYobKyb3PHWWyOVyuwzVJr6WIyAa84N/1S6OmOwFjiH/OmIzxgLPUtwEub8/rmaEvq
         /WQG9/RCKHCeGNYurfr4VgEKZqIq1RhvwhtmskScCXmVHZwYof5UcDb5wDWTKpfDJ4u1
         fzvkBvBgBm998hoALcv3RjGQgaGIQYRa4AdOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=MOWt6Oqs2geD3xM3HL0sLQvTZDb2pncZ+R5G385kgPUWeyZg0OL40ycAuxW5QCKjIp
         fSCkbw5OV/AGK1QF21ynYPb967ql7nGaY9X5WhzILgfQ9yNHe9xevAPl8gLeLbzRogLA
         uDC7r0QotVFizoG40Nfs4uPHviSO7CXp6l/XI=
Received: by 10.86.80.5 with SMTP id d5mr6738110fgb.6.1242063586448;
        Mon, 11 May 2009 10:39:46 -0700 (PDT)
Received: from localhost.localdomain (absh130.neoplus.adsl.tpnet.pl [83.8.127.130])
        by mx.google.com with ESMTPS id e20sm4891679fga.5.2009.05.11.10.39.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 May 2009 10:39:45 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4BHdhpe016715;
	Mon, 11 May 2009 19:39:45 +0200
In-Reply-To: <20090511173025.15152.94215.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118814>

Non-capturing groups are useful because they have better runtime
performance and do not copy strings to the magic global capture
variables.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
"Perl Best Practices", section 12.14. Capturing Parentheses (Use
capturing parentheses only when you intend to capture.)

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index beb79ee..097bd18 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -828,7 +828,7 @@ if (!defined $action) {
 if (!defined($actions{$action})) {
 	die_error(400, "Unknown action");
 }
-if ($action !~ m/^(opml|project_list|project_index)$/ &&
+if ($action !~ m/^(?:opml|project_list|project_index)$/ &&
     !$project) {
 	die_error(400, "Project needed");
 }
