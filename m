From: Anders Kaseorg <andersk@MIT.EDU>
Subject: =?UTF-8?Q?=5BPATCH=5D_gitweb=3A_Don=E2=80=99t_die=5Ferror_in_git=5Ftag_after_already_printing_headers?=
Date: Fri, 27 Aug 2010 13:38:16 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1008271337310.25632@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 27 19:38:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Op2si-00066N-Rc
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 19:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929Ab0H0RiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 13:38:20 -0400
Received: from DMZ-MAILSEC-SCANNER-3.MIT.EDU ([18.9.25.14]:54797 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754836Ab0H0RiS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Aug 2010 13:38:18 -0400
X-AuditID: 1209190e-b7b91ae0000068d0-66-4c77f80b75fd
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
	by dmz-mailsec-scanner-3.mit.edu (Symantec Brightmail Gateway) with SMTP id FE.6F.26832.B08F77C4; Fri, 27 Aug 2010 13:38:19 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id o7RHcHnu007772;
	Fri, 27 Aug 2010 13:38:17 -0400
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o7RHcGUM018959
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 27 Aug 2010 13:38:17 -0400 (EDT)
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154612>

This fixes an XML error when visiting a nonexistent tag
(?p=git.git;a=tag;h=refs/tags/BADNAME).

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 gitweb/gitweb.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 84261bb..5dab825 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5192,15 +5192,15 @@ sub git_summary {
 }
 
 sub git_tag {
-	my $head = git_get_head_hash($project);
-	git_header_html();
-	git_print_page_nav('','', $head,undef,$head);
 	my %tag = parse_tag($hash);
 
 	if (! %tag) {
 		die_error(404, "Unknown tag object");
 	}
 
+	my $head = git_get_head_hash($project);
+	git_header_html();
+	git_print_page_nav('','', $head,undef,$head);
 	git_print_header_div('commit', esc_html($tag{'name'}), $hash);
 	print "<div class=\"title_text\">\n" .
 	      "<table class=\"object_header\">\n" .
-- 
1.7.2.2
