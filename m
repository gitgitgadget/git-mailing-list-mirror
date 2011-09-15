From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 01/22] t1402: add some more tests
Date: Thu, 15 Sep 2011 23:10:22 +0200
Message-ID: <1316121043-29367-2-git-send-email-mhagger@alum.mit.edu>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 23:11:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4JDl-0006Fp-3l
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 23:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934955Ab1IOVLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 17:11:01 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40057 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934951Ab1IOVLA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 17:11:00 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R4J8c-00019o-O5; Thu, 15 Sep 2011 23:06:26 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181503>

The new tests reflect the status quo.  Soon the rule for "*.lock" in
refname components will be tightened up.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1402-check-ref-format.sh |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index ed4275a..dc43171 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -13,6 +13,8 @@ invalid_ref() {
 		"test_must_fail git check-ref-format '$1'"
 }
 
+invalid_ref ''
+invalid_ref '/'
 valid_ref 'heads/foo'
 invalid_ref 'foo'
 valid_ref 'foo/bar/baz'
@@ -27,6 +29,9 @@ invalid_ref 'heads/foo..bar'
 invalid_ref 'heads/foo?bar'
 valid_ref 'foo./bar'
 invalid_ref 'heads/foo.lock'
+invalid_ref 'heads///foo.lock'
+valid_ref 'foo.lock/bar'
+valid_ref 'foo.lock///bar'
 valid_ref 'heads/foo@bar'
 invalid_ref 'heads/v@{ation'
 invalid_ref 'heads/foo\bar'
@@ -83,5 +88,9 @@ invalid_ref_normalized '/foo'
 invalid_ref_normalized 'heads/foo/../bar'
 invalid_ref_normalized 'heads/./foo'
 invalid_ref_normalized 'heads\foo'
+invalid_ref_normalized 'heads/foo.lock'
+invalid_ref_normalized 'heads///foo.lock'
+valid_ref_normalized 'foo.lock/bar' 'foo.lock/bar'
+valid_ref_normalized 'foo.lock///bar' 'foo.lock/bar'
 
 test_done
-- 
1.7.6.8.gd2879
