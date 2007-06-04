From: Johan Herland <johan@herland.net>
Subject: [PATCH 0/6] Refactor the tag object
Date: Mon, 04 Jun 2007 02:51:52 +0200
Message-ID: <200706040251.52613.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 02:52:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv0nh-0001m7-Be
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 02:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbXFDAv4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 20:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbXFDAv4
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 20:51:56 -0400
Received: from smtp.getmail.no ([84.208.20.33]:64821 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773AbXFDAvz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 20:51:55 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJ300I016EIYS00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 02:51:54 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJ300E7F6EHJW20@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 02:51:53 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJ300JK36EGQ010@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 02:51:52 +0200 (CEST)
In-reply-to: <200706040251.05286.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49053>

This patch series implements part of the ground work for the 'notes'
feature discussed earlier in the thread "[PATCH 00/15] git-note: A
mechanism for providing free-form after-the-fact annotations on commits".

The following patches refactors the tag object by:
1. Making the "tag" header optional
2. Introducing a new optional "keywords" header
3. Making the "tagger" header mandatory as far as possible
4. Do better and more thorough verification of tag objects

Unfortunately the first patch in the series is bigger than I would have
liked, but I couldn't find an easy way to split it up.

Here's the shortlog:

Johan Herland (6):
      Refactor git tag objects; make "tag" header optional; introduce new optional "keywords" header
      git-show: When showing tag objects with no tag name, show tag object's SHA1 instead of an empty string
      git-fsck: Do thorough verification of tag objects.
      Documentation/git-mktag: Document the changes in tag object structure
      git-mktag tests: Fix and expand the mktag tests according to the new tag object structure
      Add fsck_verify_ref_to_tag_object() to verify that refname matches name stored in tag object

 Documentation/git-mktag.txt |   42 +++++--
 builtin-fsck.c              |   35 ++++++
 builtin-log.c               |    2 +-
 mktag.c                     |  148 +++++-------------------
 t/t3800-mktag.sh            |  204 ++++++++++++++++++++++++++++++---
 tag.c                       |  266 +++++++++++++++++++++++++++++++++++--------
 tag.h                       |    4 +-
 7 files changed, 507 insertions(+), 194 deletions(-)


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
