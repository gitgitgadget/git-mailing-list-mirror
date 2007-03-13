From: Florian La Roche <laroche@redhat.com>
Subject: git-1.5 and bare repos
Date: Tue, 13 Mar 2007 17:09:50 +0100
Message-ID: <20070313160950.GA14163@dudweiler.stuttgart.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 17:10:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HR9Zp-0000Ro-KW
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 17:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbXCMQKA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 12:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753306AbXCMQKA
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 12:10:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47962 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753295AbXCMQJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 12:09:59 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l2DG9rde015834
	for <git@vger.kernel.org>; Tue, 13 Mar 2007 12:09:53 -0400
Received: from pobox.stuttgart.redhat.com (pobox.stuttgart.redhat.com [172.16.2.10])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l2DG9rO1012519
	for <git@vger.kernel.org>; Tue, 13 Mar 2007 12:09:53 -0400
Received: from dudweiler.stuttgart.redhat.com (dudweiler.stuttgart.redhat.com [10.32.5.60])
	by pobox.stuttgart.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l2DG9qFG015591
	for <git@vger.kernel.org>; Tue, 13 Mar 2007 17:09:52 +0100
Received: from dudweiler.stuttgart.redhat.com (localhost [127.0.0.1])
	by dudweiler.stuttgart.redhat.com (8.13.8/8.13.8) with ESMTP id l2DG9pO5014175
	for <git@vger.kernel.org>; Tue, 13 Mar 2007 17:09:51 +0100
Received: (from laroche@localhost)
	by dudweiler.stuttgart.redhat.com (8.13.8/8.13.8/Submit) id l2DG9oDY014171
	for git@vger.kernel.org; Tue, 13 Mar 2007 17:09:50 +0100
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42127>

Here a patch to correctly allow also bare
repositories.

regards,

Florian La Roche



--- git-sh-setup.sh	2007-03-05 03:15:33.000000000 +0100
+++ git-sh-setup	2007-03-13 17:08:22.000000000 +0100
@@ -49,8 +49,8 @@
 
 require_work_tree () {
 	test $(is_bare_repository) = false &&
-	test $(git-rev-parse --is-inside-git-dir) = false ||
-	die "fatal: $0 cannot be used without a working tree."
+	{ test $(git-rev-parse --is-inside-git-dir) = false ||
+	  die "fatal: $0 cannot be used without a working tree."; }
 }
 
 if [ -z "$LONG_USAGE" ]
