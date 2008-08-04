From: Robert Richter <robert.richter@amd.com>
Subject: [PATCH] Gitweb: Provide Git links in project list
Date: Mon, 4 Aug 2008 12:06:50 +0200
Message-ID: <1217844410-24079-1-git-send-email-robert.richter@amd.com>
References: <1217796793.32240.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Robert Richter <robert.richter@amd.com>
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 12:09:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPx0G-0008QJ-Jc
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 12:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874AbYHDKIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 06:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbYHDKIZ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 06:08:25 -0400
Received: from outbound-wa4.frontbridge.com ([216.32.181.16]:48822 "EHLO
	WA4EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754811AbYHDKIX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Aug 2008 06:08:23 -0400
Received: from mail25-wa4-R.bigfish.com (10.8.14.250) by
 WA4EHSOBE006.bigfish.com (10.8.40.26) with Microsoft SMTP Server id
 8.1.240.5; Mon, 4 Aug 2008 10:08:23 +0000
Received: from mail25-wa4 (localhost.localdomain [127.0.0.1])	by
 mail25-wa4-R.bigfish.com (Postfix) with ESMTP id 1D00214384AC;	Mon,  4 Aug
 2008 10:08:23 +0000 (UTC)
X-BigFish: VPS27(zzzz10d3izz92fbmz32i87il)
X-FB-DOMAIN-IP-MATCH: fail
Received: by mail25-wa4 (MessageSwitch) id 1217844500855607_18988; Mon,  4 Aug
 2008 10:08:20 +0000 (UCT)
Received: from ausb3extmailp02.amd.com (ausb3extmailp02.amd.com
 [163.181.251.22])	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)	by mail25-wa4.bigfish.com (Postfix) with
 ESMTP id AE3BF848063;	Mon,  4 Aug 2008 10:08:20 +0000 (UTC)
Received: from ausb3twp02.amd.com ([163.181.250.38])	by
 ausb3extmailp02.amd.com (Switch-3.2.7/Switch-3.2.7) with ESMTP id
 m74A8E3a018982;	Mon, 4 Aug 2008 05:08:17 -0500
X-WSS-ID: 0K52MTK-02-KUV-01
Received: from sausexbh2.amd.com (SAUSEXBH2.amd.com [163.181.22.102])	by
 ausb3twp02.amd.com (Tumbleweed MailGate 3.5.1) with ESMTP id 2231016A040B;
	Mon,  4 Aug 2008 05:08:08 -0500 (CDT)
Received: from SAUSEXMB3.amd.com ([163.181.22.202]) by sausexbh2.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Mon, 4 Aug 2008 05:08:13 -0500
Received: from SDRSEXMB1.amd.com ([172.20.3.116]) by SAUSEXMB3.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Mon, 4 Aug 2008 05:08:13 -0500
Received: from erda.amd.com ([165.204.85.17]) by SDRSEXMB1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Mon, 4 Aug 2008 12:08:10 +0200
Received: by erda.amd.com (Postfix, from userid 35569)	id E06318A21; Mon,  4
 Aug 2008 12:07:57 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.4
In-Reply-To: <1217796793.32240.36.camel@localhost.localdomain>
X-OriginalArrivalTime: 04 Aug 2008 10:08:10.0859 (UTC) FILETIME=[FFEFF3B0:01C8F619]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91336>

Signed-off-by: Robert Richter <robert.richter@amd.com>
---
 gitweb/gitweb.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 90cd99b..6d9b7aa 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3558,6 +3558,9 @@ sub fill_project_list_info {
 		if (!defined $pr->{'owner'}) {
 			$pr->{'owner'} = git_get_project_owner("$pr->{'path'}") || "";
 		}
+		if (!defined $pr->{'url_link'}) {
+			$pr->{'url_link'} = (git_get_project_url_list("$pr->{'path'}"))[0] || "";
+		}
 		if ($check_forks) {
 			my $pname = $pr->{'path'};
 			if (($pname =~ s/\.git$//) &&
@@ -3661,6 +3664,7 @@ sub git_project_list_body {
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"shortlog")}, "shortlog") . " | " .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"log")}, "log") . " | " .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"tree")}, "tree") .
+		      ($pr->{'url_link'} ? " | " . $cgi->a({-href => $pr->{'url_link'}}, "git") : '') .
 		      ($pr->{'forks'} ? " | " . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks")}, "forks") : '') .
 		      "</td>\n" .
 		      "</tr>\n";
-- 
1.5.5.4
