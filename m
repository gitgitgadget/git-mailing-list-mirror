From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 1/5] gitweb: 'pickaxe' and 'grep' features requires 'search' to be enabled
Date: Wed, 22 Jun 2011 17:28:51 +0200
Message-ID: <1308756535-29701-2-git-send-email-jnareb@gmail.com>
References: <1308756535-29701-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 22 17:30:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZPNp-0002mf-JT
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 17:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347Ab1FVP3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 11:29:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59791 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932389Ab1FVP3b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 11:29:31 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so714045fxm.19
        for <git@vger.kernel.org>; Wed, 22 Jun 2011 08:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=lMdbTKAr4hwhxcgoAExAfoEsJA42+zfu2llhxSOwhpo=;
        b=df8GGn31pQurbmdBWjZFDsmifiLlkfiVM3KbaIZ24UVYx7my2822r+n9jMhlePt4Nm
         BLHVx7TbG3XhM4Kj6qmqqxN9ORoDcDL4113Gl/RdVXkhW0AimWQEcnkfL9CPLSf4FaPD
         ZWFjYTQWJ/uSnnsD71lWv9TGA4H3dwluFu/7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=A/e8st1LJPN2FwEBNMr2VcTGAeMlgdGiaYqsd5VmLzb+mdoa3VxhYszzLO2n3C8m1p
         huL0707druk/6pXLMWRnu2TdWvdvqBYymqSn4gCM4TaZ1+xhC9W6FslRe9Oj/OiebvqU
         MXrJAXcDuxiNHDpSN2l0PArA44qg3yr//Fcd4=
Received: by 10.223.53.85 with SMTP id l21mr1029292fag.26.1308756562605;
        Wed, 22 Jun 2011 08:29:22 -0700 (PDT)
Received: from localhost.localdomain (abuz77.neoplus.adsl.tpnet.pl [83.8.197.77])
        by mx.google.com with ESMTPS id l26sm400935fah.14.2011.06.22.08.29.20
        (version=SSLv3 cipher=OTHER);
        Wed, 22 Jun 2011 08:29:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1308756535-29701-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176245>

Both 'pickaxe' (searching changes) and 'grep' (searching files)
require basic 'search' feature to be enabled to work.  Enabling
e.g. only 'pickaxe' won't work.

Add a comment about this.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is slightly more expanded version than what was sent to git
mailing list as

  [PATCH (amend)] gitweb: 'pickaxe' and 'grep' features requires 'search' to be enabled
  http://thread.gmane.org/gmane.comp.version-control.git/176095/focus=176127

What's new is comment for 'search' feature.

 gitweb/gitweb.perl |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0221eb9..fd93d45 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -321,6 +321,10 @@ our %feature = (
 	# Enable text search, which will list the commits which match author,
 	# committer or commit text to a given string.  Enabled by default.
 	# Project specific override is not supported.
+	#
+	# Note that this controls all search features, which means that if
+	# it is disabled, then 'grep' and 'pickaxe' search would also be
+	# disabled.
 	'search' => {
 		'override' => 0,
 		'default' => [1]},
@@ -328,6 +332,7 @@ our %feature = (
 	# Enable grep search, which will list the files in currently selected
 	# tree containing the given string. Enabled by default. This can be
 	# potentially CPU-intensive, of course.
+	# Note that you need to have 'search' feature enabled too.
 
 	# To enable system wide have in $GITWEB_CONFIG
 	# $feature{'grep'}{'default'} = [1];
@@ -342,6 +347,7 @@ our %feature = (
 	# Enable the pickaxe search, which will list the commits that modified
 	# a given string in a file. This can be practical and quite faster
 	# alternative to 'blame', but still potentially CPU-intensive.
+	# Note that you need to have 'search' feature enabled too.
 
 	# To enable system wide have in $GITWEB_CONFIG
 	# $feature{'pickaxe'}{'default'} = [1];
-- 
1.7.5
