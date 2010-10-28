From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 0/3] Gitweb caching v7
Date: Wed, 27 Oct 2010 17:42:51 -0700
Message-ID: <1288226574-19068-1-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.2.3"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 28 03:35:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBHOn-000372-3E
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 03:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758077Ab0J1BfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 21:35:16 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:48194 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757889Ab0J1BfP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 21:35:15 -0400
X-Greylist: delayed 3133 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Oct 2010 21:35:15 EDT
Received: from voot-cruiser.middle.earth (173-27-0-103.client.mchsi.com [173.27.0.103])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id o9S0gucL008331
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 27 Oct 2010 17:43:01 -0700
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.7.2.3
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 27 Oct 2010 17:43:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160147>

This is a multi-part message in MIME format.
--------------1.7.2.3
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Evening everyone,
 
This is the latest incarnation of gitweb w/ caching.  Per the general
consensus and requests from the recent Gittogether I'm re-submitting 
my patches.

Biggest changes are bringing it back in line with Junio's tree, couple
of locking fixes (specifically targeted at binary files), and at the 
nagging behest of Sverre I've cut the old patch down to a much more
manageable (and in his words "reviewable") series.

This still differs, slightly, from whats in production on kernel.org.
It's missing the index page git:// link, and kernel.org is still running
the broken out output buffering but I'm likely to flip over to this just
so I'm not maintaining quite so much (and the changes are easier to track
with upstream)

v7:
	- Rework output system, now central STDOUT redirect
	- Various fixes to caching brought in from existing
	  running system

v6:
	- Never saw the light of day
	- Various testing, and reworks.

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


John 'Warthog9' Hawley (3):
  gitweb: Add option to force version match
  gitweb: add output buffering and associated functions
  gitweb: File based caching layer (from git.kernel.org)

 gitweb/README            |    4 +
 gitweb/cache.pm          |  365 ++++++++++++++++++++++++++++++++++++++++++++++
 gitweb/gitweb.perl       |  147 ++++++++++++++++++-
 gitweb/static/gitweb.css |    6 +
 4 files changed, 514 insertions(+), 8 deletions(-)
 create mode 100644 gitweb/cache.pm

-- 
1.7.2.3

--------------1.7.2.3--
