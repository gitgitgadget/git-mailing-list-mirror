From: Michael Hendricks <michael@ndrix.org>
Subject: [PATCH] gitweb: configurable width for the projects list Description column
Date: Wed,  4 Jul 2007 18:36:48 -0600
Message-ID: <11835958082458-git-send-email-michael@ndrix.org>
Cc: Michael Hendricks <michael@ndrix.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 05 02:37:13 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6FLL-0005oK-Iq
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 02:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756697AbXGEAhJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 20:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756146AbXGEAhJ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 20:37:09 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35981 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755495AbXGEAhH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jul 2007 20:37:07 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id A8EBE6621
	for <git@vger.kernel.org>; Wed,  4 Jul 2007 20:36:50 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 04 Jul 2007 20:36:52 -0400
X-Sasl-enc: SzSi43o9XzirCvIZdrngcS4Aji4J3p8/1bvVgiKQ2h3b 1183595809
Received: from ndrix.org (tameion.ndrix.org [166.230.131.80])
	by mail.messagingengine.com (Postfix) with ESMTP id D0FD512F2D;
	Wed,  4 Jul 2007 20:36:49 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.rc0.14.gebe8f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51650>

This allows gitweb users to set $projects_list_description_width
in their gitweb.conf to determine how many characters of a project
description are displayed before being truncated with an ellipsis.

Signed-off-by: Michael Hendricks <michael@ndrix.org>
---
 gitweb/gitweb.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index dbfb044..29d058c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -71,6 +71,9 @@ our $logo_label = "git homepage";
 # source of projects list
 our $projects_list = "++GITWEB_LIST++";
 
+# the width (in characters) of the projects list "Description" column
+our $projects_list_description_width = 25;
+
 # default order of projects list
 # valid values are none, project, descr, owner, and age
 our $default_projects_order = "project";
@@ -3163,7 +3166,7 @@ sub git_project_list_body {
 		if (!defined $pr->{'descr'}) {
 			my $descr = git_get_project_description($pr->{'path'}) || "";
 			$pr->{'descr_long'} = to_utf8($descr);
-			$pr->{'descr'} = chop_str($descr, 25, 5);
+			$pr->{'descr'} = chop_str($descr, $projects_list_description_width, 5);
 		}
 		if (!defined $pr->{'owner'}) {
 			$pr->{'owner'} = get_file_owner("$projectroot/$pr->{'path'}") || "";
-- 
1.5.3.rc0.14.gebe8f
