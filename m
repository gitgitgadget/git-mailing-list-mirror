From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH 2/2] t/lib-http.sh: Enable httpd tests by default.
Date: Thu, 19 Nov 2009 17:22:03 -0800
Message-ID: <1258680123-28684-2-git-send-email-tarmigan+git@gmail.com>
References: <1258680123-28684-1-git-send-email-tarmigan+git@gmail.com>
Cc: peff@peff.net, jaysoffian@gmail.com, drizzd@aon.at,
	gitster@pobox.com, spearce@spearce.org,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 02:23:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBIDC-0007O3-7Q
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 02:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757181AbZKTBWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 20:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757161AbZKTBWp
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 20:22:45 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:46607 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756718AbZKTBWp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 20:22:45 -0500
Received: by pzk1 with SMTP id 1so2037116pzk.33
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 17:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=Xtu4DXvoK2++tVLhme+kmnR3vJGRztok8/dbp0TSv2I=;
        b=c9nqt1kSDTWIZK+mD/ixDGqjNc//JPOqNjg6uC4RHFI1UdhtPzORb4JhVE4AKa/3VW
         /Zpk5ZlI1VDSpfGT2K/3pwnYk7A2jvBuYqroMwHLKqTaWwNEdJ702CWBIpeH0b4v4Af7
         pHcebX/zfkEcSPnME6dqZUDSgG0fmJ1Jw8L8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=XXtvwfx6YHdUaXsqlk662CDDs1m9tBEAIAN3vBwn+PlllUB3IGsG7WVjqlWchId3yb
         p6taMlUi7uVI3s2vhV0BGV786nn0z1bsUk3+WTlicWaFJK7LVxpsjP22vK3EmDm934qJ
         A0llPVaWucRxHDPqUqxnXrhjJgZ94PqCzYfUk=
Received: by 10.115.101.18 with SMTP id d18mr856632wam.191.1258680171337;
        Thu, 19 Nov 2009 17:22:51 -0800 (PST)
Received: from localhost.localdomain (host-98-127-69-228.bln-mt.client.bresnan.net [98.127.69.228])
        by mx.google.com with ESMTPS id 20sm681601pxi.11.2009.11.19.17.22.49
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 17:22:50 -0800 (PST)
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1258680123-28684-1-git-send-email-tarmigan+git@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133276>

With smart http, git over http is likely to become much more common.
To increase testing of smart http, enable the http tests by default.

If we cannot detect httpd, we still skip these tests, so it should not
cause problems on platforms where we cannot run the tests.

Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---
 t/lib-httpd.sh |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 6b86353..db537b4 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -3,11 +3,12 @@
 # Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
 #
 
-if test -z "$GIT_TEST_HTTPD"
+if test -n "$NO_GIT_TEST_HTTPD"
 then
-	say "skipping test, network testing disabled by default"
-	say "(define GIT_TEST_HTTPD to enable)"
+	say "Skipping http tests because NO_GIT_TEST_HTTPD is defined"
 	test_done
+else
+	say "Define NO_GIT_TEST_HTTPD to disable http testing"
 fi
 
 HTTPD_PARA=""
-- 
1.6.5.52.g35487
