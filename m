From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: [PATCH v4 2/2] gitweb: place links to parent directories in page
 header
Date: Sun, 29 Jan 2012 17:13:16 +0100
Message-ID: <20120129161316.GD13937@server.brlink.eu>
References: <20120128165606.GA6770@server.brlink.eu>
 <m3wr8bcuon.fsf@localhost.localdomain>
 <20120129012234.GD16079@server.brlink.eu>
 <201201291354.50241.jnareb@gmail.com>
 <20120129160615.GA13937@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 29 17:13:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrXNI-0005ju-Jd
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 17:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021Ab2A2QM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 11:12:59 -0500
Received: from server.brlink.eu ([78.46.187.186]:54075 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752692Ab2A2QM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 11:12:58 -0500
Received: from mfs.mathematik.uni-freiburg.de ([132.230.30.170] helo=client.brlink.eu)
	by server.brlink.eu with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrXNB-0005Eq-IR; Sun, 29 Jan 2012 17:12:57 +0100
Received: from brl by client.brlink.eu with local (Exim 4.77)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrXNU-0003t0-4s; Sun, 29 Jan 2012 17:13:16 +0100
Content-Disposition: inline
In-Reply-To: <20120129160615.GA13937@server.brlink.eu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189292>

Change html page headers to not only link the project root and the
currently selected project but also the directories in between using
project_filter.

Signed-off-by: Bernhard R. Link <brlink@debian.org>
---
 gitweb/gitweb.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f0e03d8..e2a9146 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3853,7 +3853,10 @@ sub print_nav_breadcrumbs {
 
 	print $cgi->a({-href => esc_url($home_link)}, $home_link_str) . " / ";
 	if (defined $project) {
-		print $cgi->a({-href => href(action=>"summary")}, esc_html($project));
+		my @dirname = split '/', $project;
+		my $projectbasename = pop @dirname;
+		print_nav_breadcrumbs_path(@dirname);
+		print $cgi->a({-href => href(action=>"summary")}, esc_html($projectbasename));
 		if (defined $action) {
 			my $action_print = $action ;
 			if (defined $opts{-action_extra}) {
-- 
1.7.8.3
