From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: Test t9500 fails if Time::HiRes is missing
Date: Mon, 23 Jan 2012 06:39:21 +0100 (CET)
Message-ID: <hbf.20120123smq1@bombur.uio.no>
References: <hbf.20120123rqzg@bombur.uio.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 23 06:39:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpCcp-0008UA-T2
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 06:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177Ab2AWFjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 00:39:23 -0500
Received: from mail-out1.uio.no ([129.240.10.57]:58575 "EHLO mail-out1.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923Ab2AWFjX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 00:39:23 -0500
Received: from mail-mx1.uio.no ([129.240.10.29])
	by mail-out1.uio.no with esmtp (Exim 4.75)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1RpCck-0001mR-Cs
	for git@vger.kernel.org; Mon, 23 Jan 2012 06:39:22 +0100
Received: from bombur.uio.no ([129.240.6.233])
	by mail-mx1.uio.no with esmtp  (Exim 4.76)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1RpCck-0002YX-20
	for git@vger.kernel.org; Mon, 23 Jan 2012 06:39:22 +0100
Received: by bombur.uio.no (Postfix, from userid 2112)
	id F218312C0; Mon, 23 Jan 2012 06:39:21 +0100 (CET)
In-Reply-To: <hbf.20120123rqzg@bombur.uio.no>
X-UiO-Ratelimit-Test: rcpts/h 1 msgs/h 1 sum rcpts/h 2 sum msgs/h 1 total rcpts 2096 max rcpts/h 17 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, T_RP_MATCHES_RCVD=-0.01,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 78054384AF1A1CA55DF491C53E5A9CEA273F7873
X-UiO-SPAM-Test: remote_host: 129.240.6.233 spam_score: -49 maxlevel 80 minaction 2 bait 0 mail/h: 1 total 922 max/h 5 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188978>

I wrote:
> Better add a comment about that, so it doesn't get re-reverted.

Perhaps I should follow my own advise...

> Or pacify the test and expect gitweb@RHEL-users to install the RPM:

--- git-1.7.9.rc2/t/gitweb-lib.sh~
+++ git-1.7.9.rc2/t/gitweb-lib.sh
@@ -113,4 +113,10 @@
 	test_done
 }
 
+# RedHat has moved Time::HiRes out from core Perl to a separate package.
+perl -MTime::HiRes -e 0 >/dev/null 2>&1 || {
+	skip_all='skipping gitweb tests, Time::HiRes module not available'
+	test_done
+}
+
 gitweb_init

-- 
Hallvard
