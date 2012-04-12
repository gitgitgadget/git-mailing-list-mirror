From: Brian Gernhardt <benji@silverinsanity.com>
Subject: push.default warning breaks tests on OS X
Date: Thu, 12 Apr 2012 02:34:45 -0400
Message-ID: <346D29CB-F34D-4360-ABE3-39358E407BFD@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 08:41:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIDj4-0001mV-3b
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 08:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761943Ab2DLGlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 02:41:45 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:33820 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761513Ab2DLGlo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Apr 2012 02:41:44 -0400
X-Greylist: delayed 417 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Apr 2012 02:41:44 EDT
Received: by silverinsanity.com (Postfix, from userid 5001)
	id CD8DA1FFC015; Thu, 12 Apr 2012 06:34:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.141] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 3C2C91FFC008
	for <git@vger.kernel.org>; Thu, 12 Apr 2012 06:34:34 +0000 (UTC)
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195302>

After a break in regularly compiling git on my Mac 10.7.3 laptop, I had a couple tests in t5570-git-daemon.sh fail: 10 and 14.  Both of these tests use test_remote_error to look for a string and produce output like:

--- expect	2012-04-12 06:30:16.000000000 +0000
+++ output	2012-04-12 06:30:16.000000000 +0000
@@ -1 +1,13 @@
+warning: push.default is unset; its implicit value is changing in
+Git 2.0 from 'matching' to 'upstream'. To squelch this message
+and maintain the current behavior after the default changes, use:
+
+  git config --global push.default matching
+
+To squelch this message and adopt the new behavior now, use:
+
+  git config --global push.default upstream
+
+See 'git help config' and search for 'push.default' for further information.
+
 fatal: remote error: access denied or repository not exported: /repo.git

Bisecting traced it back to 5293b54: "push: start warning upcoming default change for push.default"

I'm sending this off to the list in case someone else has some idea of the root cause.  I'll get back to this problem myself sometime tomorrow.

~~ Brian Gernhardt
