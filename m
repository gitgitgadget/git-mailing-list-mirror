From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Make it work with $GIT containing spaces
Date: Sat, 14 Jun 2008 20:37:59 +0200
Message-ID: <20080614183758.26667.62656.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 14 20:39:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7afF-0005iV-CI
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 20:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567AbYFNSiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 14:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbYFNSiZ
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 14:38:25 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:60529 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbYFNSiY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 14:38:24 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2774770ywe.1
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 11:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=lKs03+MA1WJSu23HeCg9GNckEhnZADgP1y8mLXUXC9U=;
        b=AZqjmxFqnZAbCJTye1U+xwzdYZIAHNK5AV9bojWQ0tCICCqYbbRmiVdwdgVS6vM1pi
         XNjxwd3q7FQ9bH13DrcymS8ChTLtgzNT4VpXDejSfTCFnT4Dz/M2PTr7+vyvVmBZsqne
         8PqHohRB1Dhzhsbrvopu88D117MLVnyNU5wTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=UGKSxyZuBo7RA5ZUUQtRSIIv+Dxy2yqV/qAczVsAXr+yKkvbhCOoOcCOPEHBTmLFWd
         f6IuFsoQSjg1KRomYRmTyKvY7RJ+uob/+qyUkgA3pRl8bJt4gUrr6FMUj30Gxhha/e+q
         QBNLC7x52e+ksq2O+C24F/0HTseC8yr0785z4=
Received: by 10.150.137.8 with SMTP id k8mr7073145ybd.87.1213468702103;
        Sat, 14 Jun 2008 11:38:22 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.239.84])
        by mx.google.com with ESMTPS id p31sm239561qbp.6.2008.06.14.11.38.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Jun 2008 11:38:21 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5EIbxWD026695;
	Sat, 14 Jun 2008 20:38:04 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85036>



This fixes single point where $GIT (which can contain full path
to git binary) with embedded spaces gave errors.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c7882f2..485e1bd 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -377,7 +377,7 @@ if (-e $GITWEB_CONFIG) {
 }
 
 # version of the core git binary
-our $git_version = qx($GIT --version) =~ m/git version (.*)$/ ? $1 : "unknown";
+our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
 
 $projects_list ||= $projectroot;
 
