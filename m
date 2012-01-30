From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: [PATCH v6 6/6] gitweb: place links to parent directories in page
 header
Date: Mon, 30 Jan 2012 21:10:23 +0100
Message-ID: <20120130201023.GG2584@server.brlink.eu>
References: <20120128165606.GA6770@server.brlink.eu>
 <20120130095252.GA6183@server.brlink.eu>
 <20120130114557.GB9267@server.brlink.eu>
 <201201301657.12944.jnareb@gmail.com>
 <20120130200355.GA2584@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 21:10:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrxYK-0004YH-29
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 21:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489Ab2A3UKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 15:10:06 -0500
Received: from server.brlink.eu ([78.46.187.186]:54121 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753447Ab2A3UKF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 15:10:05 -0500
Received: from mfs.mathematik.uni-freiburg.de ([132.230.30.170] helo=client.brlink.eu)
	by server.brlink.eu with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrxYC-0005wA-C1; Mon, 30 Jan 2012 21:10:04 +0100
Received: from brl by client.brlink.eu with local (Exim 4.77)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrxYV-0001CO-94; Mon, 30 Jan 2012 21:10:23 +0100
Content-Disposition: inline
In-Reply-To: <20120130200355.GA2584@server.brlink.eu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189415>

Change html page headers to not only link the project root and the
currently selected project but also the directories in between using
project_filter. (Allowing to jump to a list of all projects within
that intermediate directory directly and making the project_filter
feature visible to users).

Signed-off-by: Bernhard R. Link <brlink@debian.org>
Acked-by: Jakub Narebski <jnareb@gmail.com>

---

What are the rules for copying Acked-by? This change and it's
description are unchanged since v4 which got a Acked-by. Do
I keep that Acked-by if only the other patches change or do I reset
it?
---
 gitweb/gitweb.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 27db84e..c45e0e7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3858,7 +3858,10 @@ sub print_nav_breadcrumbs {
 
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
