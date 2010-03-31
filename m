From: =?UTF-8?q?Jan=20St=C4=99pie=C5=84?= 
	<jstepien@users.sourceforge.net>
Subject: [PATCH] gitweb: The "Owner" column can be hidden
Date: Wed, 31 Mar 2010 11:06:49 +0200
Message-ID: <1270026409-29543-1-git-send-email-jstepien@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Jan=20St=C4=99pie=C5=84?= 
	<jstepien@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 31 11:15:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwu1L-00078o-Qo
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 11:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932954Ab0CaJPG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Mar 2010 05:15:06 -0400
Received: from r245-52.iq.pl ([86.111.245.52]:39162 "EHLO stepien.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757209Ab0CaJPF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 05:15:05 -0400
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Mar 2010 05:15:04 EDT
Received: from localhost.localdomain (chello089078159032.chello.pl [89.78.159.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by stepien.cc (Postfix) with ESMTPSA id 598F52A10EB7;
	Wed, 31 Mar 2010 11:07:04 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143654>

This commit adds $show_owner_column configuration variable which allows
to hide the project list "Owner" column if desired.

Signed-off-by: Jan St=C4=99pie=C5=84 <jstepien@users.sourceforge.net>
---
 gitweb/gitweb.perl |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a2d2283..95f7f06 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -160,6 +160,9 @@ our @diff_opts =3D ('-M'); # taken from git_commit
 # the gitweb domain.
 our $prevent_xss =3D 0;
=20
+# presense of the projects list "Owner" column
+our $show_owner_column =3D 1;
+
 # information about snapshot formats that gitweb is capable of serving
 our %known_snapshot_formats =3D (
 	# name =3D> {
@@ -4430,7 +4433,7 @@ sub git_project_list_body {
 		}
 		print_sort_th('project', $order, 'Project');
 		print_sort_th('descr', $order, 'Description');
-		print_sort_th('owner', $order, 'Owner');
+		print_sort_th('owner', $order, 'Owner') if $show_owner_column;
 		print_sort_th('age', $order, 'Last Change');
 		print "<th></th>\n" . # for links
 		      "</tr>\n";
@@ -4469,8 +4472,8 @@ sub git_project_list_body {
 		                        -class =3D> "list"}, esc_html($pr->{'path'})=
) . "</td>\n" .
 		      "<td>" . $cgi->a({-href =3D> href(project=3D>$pr->{'path'}, ac=
tion=3D>"summary"),
 		                        -class =3D> "list", -title =3D> $pr->{'descr=
_long'}},
-		                        esc_html($pr->{'descr'})) . "</td>\n" .
-		      "<td><i>" . chop_and_escape_str($pr->{'owner'}, 15) . "</i></t=
d>\n";
+		                        esc_html($pr->{'descr'})) . "</td>\n";
+		print "<td><i>" . chop_and_escape_str($pr->{'owner'}, 15) .  "</i></=
td>\n" if $show_owner_column;
 		print "<td class=3D\"". age_class($pr->{'age'}) . "\">" .
 		      (defined $pr->{'age_string'} ? $pr->{'age_string'} : "No commi=
ts") . "</td>\n" .
 		      "<td class=3D\"link\">" .
--=20
1.7.0.3
