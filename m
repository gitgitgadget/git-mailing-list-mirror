From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 0/9] Gitweb caching v5
Date: Wed, 13 Jan 2010 17:22:56 -0800
Message-ID: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 02:23:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVERG-0002pa-S0
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 02:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895Ab0ANBXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 20:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411Ab0ANBXL
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 20:23:11 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:56014 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab0ANBXL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 20:23:11 -0500
Received: from localhost.localdomain (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0E1N5Lm009231
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 17:23:10 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.6.5.2
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 13 Jan 2010 17:23:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136913>

Afternoon everyone,
 
This is the latest incarnation of gitweb w/ caching.  This is
finally at the point where it should probably start either being
considered for inclusion or mainline, or I need to accept that this
will never get in and more perminantely fork (as is the case with
Fedora where this is going in as gitweb-caching as a parrallel rpm
package).

That said this brings the base up to mainline (again), it updates a
number of elements in the caching engine, and this is a much cleaner
break-out of the tree vs. what I am currently developing against.

v5:
	- Missed a couple of things that were in my local tree, and
	  added them back in.
	- Split up the die_error and the version matching patch
	- Set version matching to be on by default - otherwise this
	  really is code that will never get checked, or at best
	  enabled by default by distributions
	- Added a minor code cleanup with respect to $site_header
	  that was already in my tree
	- Applied against a more recent git tree vs. 1.6.6-rc2
	- Removed breakout patch for now (did that in v4 actually)
	  and will deal with that separately 

	http://git.kernel.org/?p=git/warthog9/gitweb.git;a=shortlog;h=refs/heads/gitweb-ml-v5

v4:
	- major re-working of the caching layer to use file handle
	  redirection instead of buffering output
	- other minor improvements

	http://git.kernel.org/?p=git/warthog9/gitweb.git;a=shortlog;h=refs/heads/gitweb-ml-v4
v3:
	- various minor re-works based on mailing list feedback,
	  this series was not sent to the mailing list.
v2:
	- Better breakout
	- You can actually disable the cache now

- John 'Warthog9' Hawley 



John 'Warthog9' Hawley (9):
  gitweb: Load checking
  gitweb: change die_error to take "extra" argument for extended die
    information
  gitweb: Add option to force version match
  gitweb: Makefile improvements
  gitweb: add a get function to compliment print_local_time
  gitweb: add a get function to compliment print_sort_th
  gitweb: cleanup error message produced by undefined $site_header
  gitweb: Convert output to using indirect file handle
  gitweb: File based caching layer (from git.kernel.org)

 Makefile           |   65 +---
 gitweb/Makefile    |  129 +++++++
 gitweb/README      |   10 +-
 gitweb/cache.pm    |  283 ++++++++++++++
 gitweb/gitweb.css  |    6 +
 gitweb/gitweb.perl | 1034 ++++++++++++++++++++++++++++++----------------------
 6 files changed, 1030 insertions(+), 497 deletions(-)
 create mode 100644 gitweb/Makefile
 create mode 100644 gitweb/cache.pm
