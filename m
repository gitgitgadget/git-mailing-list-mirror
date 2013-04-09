From: Simon Ruderich <simon@ruderich.org>
Subject: [PATCH] t/README: --immediate skips cleanup commands for failed tests
Date: Tue, 9 Apr 2013 15:18:02 +0200
Message-ID: <20130409131802.GA25673@ruderich.org>
References: <1365356784-24872-1-git-send-email-felipe.contreras@gmail.com>
 <1365356784-24872-6-git-send-email-felipe.contreras@gmail.com>
 <20130407193415.GB13708@ruderich.org>
 <20130407223200.GF19857@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 15:18:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPYRH-0003uw-7F
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 15:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760155Ab3DINSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 09:18:12 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:40095 "EHLO
	zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759476Ab3DINSM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 09:18:12 -0400
Received: from localhost (pD9F541FE.dip.t-dialin.net [::ffff:217.245.65.254])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Tue, 09 Apr 2013 15:18:03 +0200
  id 00000000000000BD.000000005164150B.00005A00
Content-Disposition: inline
In-Reply-To: <20130407223200.GF19857@elie.Belkin>
User-Agent: Mutt/1.5.21 (2013-03-19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220568>

On Sun, Apr 07, 2013 at 03:32:00PM -0700, Jonathan Nieder wrote:
>> I'm not sure if it's better to use test_when_finished with rm or
>> just && rm -rf tmp at the end of the test in case someone wants
>> to look at the output.
>
> test_when_finished is better here, since it means later tests can
> run and provide useful information about how bad a regression is.
> Cleanup commands requested using test_when_finished are not run when a
> test being run with --immediate fails, so you can still inspect output
> after a failed test.

Hello Jonathan,

Thanks for the explanation.

I couldn't find this documented in t/README, the following patch
adds it.

-- 8< --
Subject: [PATCH] t/README: --immediate skips cleanup commands for failed tests

---
 t/README | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/README b/t/README
index 9b41fe7..e5e7d37 100644
--- a/t/README
+++ b/t/README
@@ -86,7 +86,8 @@ appropriately before running "make".
 
 --immediate::
 	This causes the test to immediately exit upon the first
-	failed test.
+	failed test. Cleanup commands requested with
+	test_when_finished are not executed if the test failed.
 
 --long-tests::
 	This causes additional long-running tests to be run (where
-- 
1.8.2.481.g0d034d4

-- 8< --

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
