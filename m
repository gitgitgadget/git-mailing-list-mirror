From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 6/5] gitweb: No periods for error messages
Date: Sat, 05 Aug 2006 02:02:34 +0200
Organization: At home
Message-ID: <eb0n5g$p72$1@sea.gmane.org>
References: <200608050038.20534.jnareb@gmail.com> <20060804235414.66496.qmail@web31801.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Aug 05 02:02:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G99cP-00029a-1v
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 02:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422651AbWHEACO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 4 Aug 2006 20:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422650AbWHEACO
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 20:02:14 -0400
Received: from main.gmane.org ([80.91.229.2]:13715 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422651AbWHEACN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 20:02:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G99cI-00028g-Dj
	for git@vger.kernel.org; Sat, 05 Aug 2006 02:02:10 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 02:02:10 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 02:02:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24867>

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Luben Tuikov wrote:
> --- Jakub Narebski <jnareb@gmail.com> wrote:
> > Clean up input validation, including removing $rss_link variable an=
d
> > making error messages more explicit. =A0Expand and uniquify other e=
rror
> > messages.
>=20
> Can you fix your patch then?
>=20
> Error messages in general do not end with a period.

Here you have the patch, on top of series.

 gitweb/gitweb.perl |   66 ++++++++++++++++++++++++++------------------=
--------
 1 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e983452..4316bd0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -420,7 +420,7 @@ sub git_get_hash_by_path {
        my $tree =3D $base;
=20
        open my $fd, "-|", $GIT, "ls-tree", $base, "--", $path
-               or die_error(undef, "Open git-ls-tree failed.");
+               or die_error(undef, "Open git-ls-tree failed");
        my $line =3D <$fd>;
        close $fd or return undef;
=20
@@ -1282,13 +1282,13 @@ ## actions
 sub git_project_list {
        my $order =3D $cgi->param('o');
        if (defined $order && $order !~ m/project|descr|owner|age/) {
-               die_error(undef, "Invalid order parameter '$order'.");
+               die_error(undef, "Invalid order parameter $order");
        }
=20
        my @list =3D git_read_projects();
        my @projects;
        if (!@list) {
-               die_error(undef, "No projects found.");
+               die_error(undef, "No projects found");
        }
        foreach my $pr (@list) {
                my $head =3D git_get_head($pr->{'path'});
@@ -1422,7 +1422,7 @@ sub git_summary {
              "</table>\n";
=20
        open my $fd, "-|", $GIT, "rev-list", "--max-count=3D17", git_ge=
t_head($project)
-               or die_error(undef, "Open git-rev-list failed.");
+               or die_error(undef, "Open git-rev-list failed");
        my @revlist =3D map { chomp; $_ } <$fd>;
        close $fd;
        git_print_header_div('shortlog');
@@ -1478,22 +1478,22 @@ sub git_tag {
 sub git_blame2 {
        my $fd;
        my $ftype;
-       die_error(undef, "Permission denied.") if (!git_get_project_con=
fig_bool ('blame'));
+       die_error(undef, "Permission denied") if (!git_get_project_conf=
ig_bool ('blame'));
        die_error('404 Not Found', "File name not defined.") if (!$file=
_name);
        $hash_base ||=3D git_get_head($project);
-       die_error(undef, "Couldn't find base commit.") unless ($hash_ba=
se);
+       die_error(undef, "Couldn't find base commit") unless ($hash_bas=
e);
        my %co =3D parse_commit($hash_base)
-               or die_error(undef, "Reading commit failed.");
+               or die_error(undef, "Reading commit failed");
        if (!defined $hash) {
                $hash =3D git_get_hash_by_path($hash_base, $file_name, =
"blob")
                        or die_error(undef, "Error looking up file $fil=
e_name");
        }
        $ftype =3D git_get_type($hash);
        if ($ftype !~ "blob") {
-               die_error("400 Bad Request", "Object is not a blob.");
+               die_error("400 Bad Request", "Object is not a blob");
        }
        open ($fd, "-|", $GIT, "blame", '-l', $file_name, $hash_base)
-               or die_error(undef, "Open git-blame failed.");
+               or die_error(undef, "Open git-blame failed");
        git_header_html();
        my $formats_nav =3D
                $cgi->a({-href =3D> "$my_uri?" . esc_param("p=3D$projec=
t;a=3Dblob;h=3D$hash;hb=3D$hash_base;f=3D$file_name")}, "blob") .
@@ -1536,18 +1536,18 @@ sub git_blame2 {
=20
 sub git_blame {
        my $fd;
-       die_error('403 Permission denied', "Permission denied.") if (!g=
it_get_project_config_bool ('blame'));
-       die_error('404 Not Found', "File name not defined.") if (!$file=
_name);
+       die_error('403 Permission denied', "Permission denied") if (!gi=
t_get_project_config_bool ('blame'));
+       die_error('404 Not Found', "File name not defined") if (!$file_=
name);
        $hash_base ||=3D git_get_head($project);
        die_error(undef, "Couldn't find base commit.") unless ($hash_ba=
se);
        my %co =3D parse_commit($hash_base)
-               or die_error(undef, "Reading commit failed.");
+               or die_error(undef, "Reading commit failed");
        if (!defined $hash) {
                $hash =3D git_get_hash_by_path($hash_base, $file_name, =
"blob")
                        or die_error(undef, "Error lookup file $file_na=
me");
        }
        open ($fd, "-|", $GIT, "annotate", '-l', '-t', '-r', $file_name=
, $hash_base)
-               or die_error(undef, "Open git-annotate failed.");
+               or die_error(undef, "Open git-annotate failed");
        git_header_html();
        my $formats_nav =3D
                $cgi->a({-href =3D> "$my_uri?" . esc_param("p=3D$projec=
t;a=3Dblob;h=3D$hash;hb=3D$hash_base;f=3D$file_name")}, "blob") .
@@ -1658,7 +1658,7 @@ sub git_blob_plain {
                        $hash =3D git_get_hash_by_path($base, $file_nam=
e, "blob")
                                or die_error(undef, "Error lookup file =
$file_name");
                } else {
-                       die_error(undef, "No file name defined.");
+                       die_error(undef, "No file name defined");
                }
        }
        my $type =3D shift;
@@ -1691,12 +1691,12 @@ sub git_blob {
                        $hash =3D git_get_hash_by_path($base, $file_nam=
e, "blob")
                                or die_error(undef, "Error lookup file =
$file_name");
                } else {
-                       die_error(undef, "No file name defined.");
+                       die_error(undef, "No file name defined");
                }
        }
        my $have_blame =3D git_get_project_config_bool ('blame');
        open my $fd, "-|", $GIT, "cat-file", "blob", $hash
-               or die_error(undef, "Couldn't cat $file_name, $hash.");
+               or die_error(undef, "Couldn't cat $file_name, $hash");
        my $mimetype =3D blob_plain_mimetype($fd, $file_name);
        if ($mimetype !~ m/^text\//) {
                close $fd;
@@ -1754,9 +1754,9 @@ sub git_tree {
        }
        $/ =3D "\0";
        open my $fd, "-|", $GIT, "ls-tree", '-z', $hash
-               or die_error(undef, "Open git-ls-tree failed.");
+               or die_error(undef, "Open git-ls-tree failed");
        my @entries =3D map { chomp; $_ } <$fd>;
-       close $fd or die_error(undef, "Reading tree failed.");
+       close $fd or die_error(undef, "Reading tree failed");
        $/ =3D "\n";
=20
        my $refs =3D git_read_info_refs();
@@ -1832,7 +1832,7 @@ sub git_log {
=20
        my $limit =3D sprintf("--max-count=3D%i", (100 * ($page+1)));
        open my $fd, "-|", $GIT, "rev-list", $limit, $hash
-               or die_error(undef, "Open git-rev-list failed.");
+               or die_error(undef, "Open git-rev-list failed");
        my @revlist =3D map { chomp; $_ } <$fd>;
        close $fd;
=20
@@ -1893,7 +1893,7 @@ sub git_log {
 sub git_commit {
        my %co =3D parse_commit($hash);
        if (!%co) {
-               die_error(undef, "Unknown commit object.");
+               die_error(undef, "Unknown commit object");
        }
        my %ad =3D parse_date($co{'author_epoch'}, $co{'author_tz'});
        my %cd =3D parse_date($co{'committer_epoch'}, $co{'committer_tz=
'});
@@ -1903,9 +1903,9 @@ sub git_commit {
                $parent =3D "--root";
        }
        open my $fd, "-|", $GIT, "diff-tree", '-r', '-M', $parent, $has=
h
-               or die_error(undef, "Open git-diff-tree failed.");
+               or die_error(undef, "Open git-diff-tree failed");
        my @difftree =3D map { chomp; $_ } <$fd>;
-       close $fd or die_error(undef, "Reading git-diff-tree failed.");
+       close $fd or die_error(undef, "Reading git-diff-tree failed");
=20
        # non-textual hash id's can be cached
        my $expires;
@@ -2121,15 +2121,15 @@ sub git_commitdiff {
        mkdir($git_temp, 0700);
        my %co =3D parse_commit($hash);
        if (!%co) {
-               die_error(undef, "Unknown commit object.");
+               die_error(undef, "Unknown commit object");
        }
        if (!defined $hash_parent) {
                $hash_parent =3D $co{'parent'};
        }
        open my $fd, "-|", $GIT, "diff-tree", '-r', $hash_parent, $hash
-               or die_error(undef, "Open git-diff-tree failed.");
+               or die_error(undef, "Open git-diff-tree failed");
        my @difftree =3D map { chomp; $_ } <$fd>;
-       close $fd or die_error(undef, "Reading git-diff-tree failed.");
+       close $fd or die_error(undef, "Reading git-diff-tree failed");
=20
        # non-textual hash id's can be cached
        my $expires;
@@ -2207,9 +2207,9 @@ sub git_commitdiff {
 sub git_commitdiff_plain {
        mkdir($git_temp, 0700);
        open my $fd, "-|", $GIT, "diff-tree", '-r', $hash_parent, $hash
-               or die_error(undef, "Open git-diff-tree failed.");
+               or die_error(undef, "Open git-diff-tree failed");
        my @difftree =3D map { chomp; $_ } <$fd>;
-       close $fd or die_error(undef, "Reading git-diff-tree failed.");
+       close $fd or die_error(undef, "Reading git-diff-tree failed");
=20
        # try to figure out the next tag after this commit
        my $tagname;
@@ -2267,7 +2267,7 @@ sub git_history {
        my $ftype;
        my %co =3D parse_commit($hash_base);
        if (!%co) {
-               die_error(undef, "Unknown commit object.");
+               die_error(undef, "Unknown commit object");
        }
        my $refs =3D git_read_info_refs();
        git_header_html();
@@ -2325,14 +2325,14 @@ sub git_history {
=20
 sub git_search {
        if (!defined $searchtext) {
-               die_error("", "Text field empty.");
+               die_error(undef, "Text field empty");
        }
        if (!defined $hash) {
                $hash =3D git_get_head($project);
        }
        my %co =3D parse_commit($hash);
        if (!%co) {
-               die_error(undef, "Unknown commit object.");
+               die_error(undef, "Unknown commit object");
        }
        # pickaxe may take all resources of your box and run for severa=
l minutes
        # with every query - so decide by yourself how public you make =
this feature :)
@@ -2470,7 +2470,7 @@ sub git_shortlog {
=20
        my $limit =3D sprintf("--max-count=3D%i", (100 * ($page+1)));
        open my $fd, "-|", $GIT, "rev-list", $limit, $hash
-               or die_error(undef, "Open git-rev-list failed.");
+               or die_error(undef, "Open git-rev-list failed");
        my @revlist =3D map { chomp; $_ } <$fd>;
        close $fd;
=20
@@ -2498,9 +2498,9 @@ ## feeds (RSS, OPML)
 sub git_rss {
        # http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
        open my $fd, "-|", $GIT, "rev-list", "--max-count=3D150", git_g=
et_head($project)
-               or die_error(undef, "Open git-rev-list failed.");
+               or die_error(undef, "Open git-rev-list failed");
        my @revlist =3D map { chomp; $_ } <$fd>;
-       close $fd or die_error(undef, "Reading git-rev-list failed.");
+       close $fd or die_error(undef, "Reading git-rev-list failed");
        print $cgi->header(-type =3D> 'text/xml', -charset =3D> 'utf-8'=
);
        print "<?xml version=3D\"1.0\" encoding=3D\"utf-8\"?>\n".
              "<rss version=3D\"2.0\" xmlns:content=3D\"http://purl.org=
/rss/1.0/modules/content/\">\n";
--=20
1.4.1.1
