From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] guilt: add option guilt.diffstat
Date: Sat, 13 Dec 2008 10:14:22 +0800
Message-ID: <20081213021422.GA28249@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josef Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Sat Dec 13 03:15:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBK2m-0006B8-GW
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 03:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711AbYLMCOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 21:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753867AbYLMCOa
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 21:14:30 -0500
Received: from mga14.intel.com ([143.182.124.37]:17012 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753611AbYLMCOa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 21:14:30 -0500
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga102.ch.intel.com with ESMTP; 12 Dec 2008 18:14:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.36,214,1228118400"; 
   d="scan'208";a="89738627"
Received: from unknown (HELO localhost) ([10.254.153.9])
  by azsmga001.ch.intel.com with ESMTP; 12 Dec 2008 18:14:25 -0800
Received: from wfg by localhost with local (Exim 4.69)
	(envelope-from <fengguang.wu@intel.com>)
	id 1LBK1O-0007My-1H; Sat, 13 Dec 2008 10:14:22 +0800
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102979>

Introduce option guilt.diffstat so that we don't have to type
"guilt refresh --diffstat" in its full form every time.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 guilt |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- guilt.orig	2008-12-13 09:53:32.000000000 +0800
+++ guilt	2008-12-13 10:01:03.000000000 +0800
@@ -538,7 +538,7 @@ __refresh_patch()
 
 		[ ! -z "$4" ] && diffopts="-C -M --find-copies-harder"
 		
-		if [ ! -z "$5" ]; then
+		if [ -n "$5" -o "x$diffstat" = "x1" ]; then
 			(
 				echo "---"
 				git diff --stat $diffopts "$2"
@@ -627,6 +627,9 @@ guilt_push_diff_context=1
 # default autotag value
 AUTOTAG_DEFAULT=1
 
+# default diffstat value
+DIFFSTAT_DEFAULT=0
+
 #
 # Parse any part of .git/config that belongs to us
 #
@@ -635,6 +638,10 @@ AUTOTAG_DEFAULT=1
 autotag=`git config guilt.autotag`
 [ -z "$autotag" ] && autotag=$AUTOTAG_DEFAULT
 
+# generate diffstat?
+diffstat=`git config guilt.diffstat`
+[ -z "$diffstat" ] && diffstat=$DIFFSTAT_DEFAULT
+
 #
 # The following gets run every time this file is source'd
 #
