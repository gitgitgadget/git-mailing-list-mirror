From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: master: t5800-remote-helpers.sh hangs on test "pulling from
 remote remote"
Date: Sat, 14 Apr 2012 22:14:48 +0200
Message-ID: <20120414201446.GB29999@ecki>
References: <4F893CD8.5020700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 22:16:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ9On-00086K-RJ
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 22:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754979Ab2DNUQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 16:16:06 -0400
Received: from smtpout15.highway.telekom.at ([195.3.96.90]:43024 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753859Ab2DNUQF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 16:16:05 -0400
Received: (qmail 25856 invoked from network); 14 Apr 2012 20:16:01 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL606.highway.telekom.at
X-Spam-Level: ****
Received: from p5b22d2b0.dip.t-dialin.net (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[91.34.210.176])
          (envelope-sender <drizzd@aon.at>)
          by smarthub81.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <stefano.lattarini@gmail.com>; 14 Apr 2012 20:16:00 -0000
Content-Disposition: inline
In-Reply-To: <4F893CD8.5020700@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195514>

On Sat, Apr 14, 2012 at 11:01:12AM +0200, Stefano Lattarini wrote:
>
> The test 't5800-remote-helpers.sh' hangs on my Linux desktop (where I have
> installed a custom simple-minded firewall based on iptables).  This does
> not happen on remote systems I use for testing, so I guess the problem
> lies with my machine.

I don't think this particular test is related to networking. Could you
please run the test again with the following change and paste the
output? (You cannot set the variables on the command line, because
test-lib.sh would unset them.)

diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index 1c62001..4cebd63 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -68,7 +68,7 @@ test_expect_success 'pushing to local repo' '
 	(cd localclone &&
 	echo content >>file &&
 	git commit -a -m three &&
-	git push) &&
+	GIT_TRANSPORT_HELPER_DEBUG=1 GIT_DEBUG_TESTGIT=1 git push) &&
 	compare_refs localclone HEAD server HEAD
 '
 
