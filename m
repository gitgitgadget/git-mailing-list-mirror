From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/6] gitweb: 'commitdiff' view improvements
Date: Fri, 08 Jun 2007 13:24:13 +0200
Message-ID: <20070608112337.3594.93976.stgit@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 13:19:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwcVJ-0001Tq-NA
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 13:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968632AbXFHLTD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 07:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967953AbXFHLTD
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 07:19:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:46727 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968632AbXFHLS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 07:18:59 -0400
Received: by ug-out-1314.google.com with SMTP id j3so929035ugf
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 04:18:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:subject:to:date:message-id:user-agent:mime-version:content-type:content-transfer-encoding;
        b=FhEOH3iXvdV5uZnfXt/PisHvD7E/hDWkFXB00CuXeVK9alIqNJ4fACI+585uT2OryDnSE/UiyI8gvVh5c26+mKkCKoUNkH4sM5BsorhmwBuwxV8dVKgF4vxOnh21DCOJSjj4cBHFCxUaZyNKMWCj14KNbUui1KC1YBXuKpzAZsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:subject:to:date:message-id:user-agent:mime-version:content-type:content-transfer-encoding;
        b=Cfm9RgnhwHFUs3k7/3sC+ftRC+STGCThP8rD18BVe2rgMhMebENgvaO5dRjsnIEMmtSBImhdXPRmti7kYFdk9ZrmLB/N2BvD8F9aRF3kXmCwtauTpwHSU+oGyIWvjnTlKObJhOnb715NQ0dGWWB9Sob9qWOPM/WIVHfL6kyiJaQ=
Received: by 10.78.136.9 with SMTP id j9mr1146815hud.1181301537805;
        Fri, 08 Jun 2007 04:18:57 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id h7sm9212812nfh.2007.06.08.04.18.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Jun 2007 04:18:56 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l58BODrN003612
	for <git@vger.kernel.org>; Fri, 8 Jun 2007 13:24:14 +0200
User-Agent: StGIT/0.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49463>

The following series makes a few improvements to 'commitdiff' view.
The final goal of the series is to use '--cc' (compact combined)
format for merge commits in gitweb, as requested by Linus Torvalds
in
  Message-ID: <Pine.LNX.4.64.0610061202060.3952@g5.osdl.org>
with a few other improvements.

Table of contents:
------------------
 gitweb: Provide links to commitdiff to each parent in 'commitdiff' view
 gitweb: Improve "next" link in commitdiff view
 gitweb: Split git_patchset_body into separate subroutines
 gitweb: Create special from-file/to-file header for combined diff
 gitweb: Add links to blobdiffs in from-file/to-file header for merges
 gitweb: '--cc' for merges in 'commitdiff' view

The first two patches are totally independent of other patches, and
are not required by anu patches.

The "Split git_patchset_body" is required for all subsequent patches;
those patches shows why it was needed. The last patch is conceptually
indepenent on the "improve from-file/to-file header for merges"
patches.

Diffstat:
---------
 gitweb/gitweb.css  |    5 +
 gitweb/gitweb.perl |  481 ++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 362 insertions(+), 124 deletions(-)

-- 
Jakub Narebski
ShadeHawk on #git
Poland
