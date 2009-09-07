Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_RECEIVED,RP_MATCHES_RCVD,
	T_DKIM_INVALID shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: (qmail 16955 invoked by uid 107); 7 Sep 2009 12:01:14 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 07 Sep 2009 08:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbZIGMAq (ORCPT <rfc822;peff@peff.net>);
	Mon, 7 Sep 2009 08:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753005AbZIGMAq
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 08:00:46 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:55064 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbZIGMAp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 08:00:45 -0400
Received: by bwz19 with SMTP id 19so1521432bwz.37
        for <git@vger.kernel.org>; Mon, 07 Sep 2009 05:00:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:to:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=3J2AM2PKmt46ciPlnz+qoVihaJpka2jj2T/gPfgjcsw=;
        b=YK4hdY04Ll3SBEj47793ApEv17lk0Nmigo6dbqDKLv+VrpZNACyQm8gH4gpJqUFDxD
         loV/96gKFaKMHIxMY6pBmhlQGdvutsD+LP1gS9pqP+AlDl7YSjfmtGezKIJ5zIyLFLH5
         XuLROcXrIIz5i7AaziiMXG6q1khYDG0i0N+ss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=vMemzbLnKcP2c4RI0uRUBeFRlS3BK0kU85l8U5RDa5emO2vNz8YSMpt2ZpIhbc5CZk
         uTmTtB6+0CZb9lqttkTHQdQFJRxqc86DWTx3grfDTY01AxjZYeasZBEDNFeYpu1A08WL
         OHk0c8Z6sk3s0q0puB6nIklmqWuWRtjq1s6k4=
Received: by 10.103.48.17 with SMTP id a17mr6033392muk.82.1252324846539;
        Mon, 07 Sep 2009 05:00:46 -0700 (PDT)
Received: from localhost.localdomain (abwl70.neoplus.adsl.tpnet.pl [83.8.235.70])
        by mx.google.com with ESMTPS id s10sm10784251mue.28.2009.09.07.05.00.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Sep 2009 05:00:45 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n87C0htC027956;
	Mon, 7 Sep 2009 14:00:43 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n87C0gNI027955;
	Mon, 7 Sep 2009 14:00:42 +0200
From:	Jakub Narebski <jnareb@gmail.com>
To:	git@vger.kernel.org
Cc:	Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC] gitweb: Add 'show-sizes' feature to show blob sizes in tree view
Date:	Mon,  7 Sep 2009 14:00:26 +0200
Message-Id: <20090907114809.27552.2354.stgit@localhost.localdomain>
X-Mailer: git-send-email 1.6.4.2
To:	git@vger.kernel.org
User-Agent: StGIT/0.14.3 (git version 1.6.4.2)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Add support for 'show-sizes' feature to show (in separate column,
between mode and filename) the size of blobs (files) in the 'tree'
view.  It passes '-l' option to "git ls-tree" invocation.

For the 'tree' and 'commit' (submodule) entries, '-' is shown in place
of size; for generated '..' "up directory" entry nothing is shown.

The 'show-sizes' feature is enabled by default.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I don't quite like 'show-sizes' as a name for this feature.  
Does anyone has any better ideas?

Not tested extensively (just that it works, and looks correct),
in particular I didn't test that having 'gitweb.showsizes' as
config variable name while 'show-sizes' as feature name works
as expected.

Previous version of this idea was presented in
  http://thread.gmane.org/gmane.comp.version-control.git/54335/focus=54334
It required to pass '-l' to 'tree' action via 'opt' (extra options)
parameter.  This one uses features mechanism.

This patch might have @extra_options passed unnecessary...

 gitweb/gitweb.css  |    6 +++++
 gitweb/gitweb.perl |   69 +++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 8f68fe3..d60bfc1 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -341,6 +341,12 @@ td.mode {
 	font-family: monospace;
 }
 
+/* format of (optional) objects size in 'tree' view */
+td.size {
+	font-family: monospace;
+	text-align: right;
+}
+
 /* styling of diffs (patchsets): commitdiff and blobdiff views */
 div.diff.header,
 div.diff.extended_header {
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 24b2193..7b1c60e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -297,6 +297,19 @@ our %feature = (
 		'override' => 0,
 		'default' => [1]},
 
+	# Enable showing size of blobs in a 'tree' view, in a separate
+	# column, similar to what 'ls -l' does.  This cost a bit of IO.
+
+	# To disable system wide have in $GITWEB_CONFIG
+	# $feature{'show-sizes'}{'default'} = [0];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'show-sizes'}{'override'} = 1;
+	# and in project config gitweb.showsizes = 0|1;
+	'show-sizes' => {
+		'sub' => sub { feature_bool('showsizes', @_) },
+		'override' => 0,
+		'default' => [1]},
+
 	# Make gitweb use an alternative format of the URLs which can be
 	# more readable and natural-looking: project name is embedded
 	# directly in the path and the query string contains other
@@ -2764,16 +2777,31 @@ sub parse_ls_tree_line {
 	my %opts = @_;
 	my %res;
 
-	#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
-	$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/s;
+	if ($opts{'-l'}) {
+		#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa   16717	panic.c'
+		$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40}) +(-|[0-9]+)\t(.+)$/s;
 
-	$res{'mode'} = $1;
-	$res{'type'} = $2;
-	$res{'hash'} = $3;
-	if ($opts{'-z'}) {
-		$res{'name'} = $4;
+		$res{'mode'} = $1;
+		$res{'type'} = $2;
+		$res{'hash'} = $3;
+		$res{'size'} = $4;
+		if ($opts{'-z'}) {
+			$res{'name'} = $5;
+		} else {
+			$res{'name'} = unquote($5);
+		}
 	} else {
-		$res{'name'} = unquote($4);
+		#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
+		$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/s;
+
+		$res{'mode'} = $1;
+		$res{'type'} = $2;
+		$res{'hash'} = $3;
+		if ($opts{'-z'}) {
+			$res{'name'} = $4;
+		} else {
+			$res{'name'} = unquote($4);
+		}
 	}
 
 	return wantarray ? %res : \%res;
@@ -3564,6 +3592,9 @@ sub git_print_tree_entry {
 	# and link is the action links of the entry.
 
 	print "<td class=\"mode\">" . mode_str($t->{'mode'}) . "</td>\n";
+	if (exists $t->{'size'}) {
+		print "<td class=\"size\">$t->{'size'}</td>\n";
+	}
 	if ($t->{'type'} eq "blob") {
 		print "<td class=\"list\">" .
 			$cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
@@ -3609,12 +3640,14 @@ sub git_print_tree_entry {
 	} elsif ($t->{'type'} eq "tree") {
 		print "<td class=\"list\">";
 		print $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
-		                             file_name=>"$basedir$t->{'name'}", %base_key)},
+		                             file_name=>"$basedir$t->{'name'}",
+		                             %base_key)},
 		              esc_path($t->{'name'}));
 		print "</td>\n";
 		print "<td class=\"link\">";
 		print $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
-		                             file_name=>"$basedir$t->{'name'}", %base_key)},
+		                             file_name=>"$basedir$t->{'name'}",
+		                             %base_key)},
 		              "tree");
 		if (defined $hash_base) {
 			print " | " .
@@ -5088,10 +5121,14 @@ sub git_tree {
 	}
 	die_error(404, "No such tree") unless defined($hash);
 
+	my $show_sizes = gitweb_check_feature('show-sizes');
+	my $have_blame = gitweb_check_feature('blame');
+
 	my @entries = ();
 	{
 		local $/ = "\0";
-		open my $fd, "-|", git_cmd(), "ls-tree", '-z', $hash
+		open my $fd, "-|", git_cmd(), "ls-tree", '-z',
+			($show_sizes ? '-l' : ()), @extra_options, $hash
 			or die_error(500, "Open git-ls-tree failed");
 		@entries = map { chomp; $_ } <$fd>;
 		close $fd
@@ -5102,7 +5139,6 @@ sub git_tree {
 	my $ref = format_ref_marker($refs, $hash_base);
 	git_header_html();
 	my $basedir = '';
-	my $have_blame = gitweb_check_feature('blame');
 	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 		my @views_nav = ();
 		if (defined $file_name) {
@@ -5118,7 +5154,8 @@ sub git_tree {
 			# FIXME: Should be available when we have no hash base as well.
 			push @views_nav, $snapshot_links;
 		}
-		git_print_page_nav('tree','', $hash_base, undef, undef, join(' | ', @views_nav));
+		git_print_page_nav('tree','', $hash_base, undef, undef,
+		                   join(' | ', @views_nav));
 		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash_base);
 	} else {
 		undef $hash_base;
@@ -5151,8 +5188,10 @@ sub git_tree {
 		undef $up unless $up;
 		# based on git_print_tree_entry
 		print '<td class="mode">' . mode_str('040000') . "</td>\n";
+		print '<td class="size">&nbsp;</td>'."\n" if $show_sizes;
 		print '<td class="list">';
-		print $cgi->a({-href => href(action=>"tree", hash_base=>$hash_base,
+		print $cgi->a({-href => href(action=>"tree",
+		                             hash_base=>$hash_base,
 		                             file_name=>$up)},
 		              "..");
 		print "</td>\n";
@@ -5161,7 +5200,7 @@ sub git_tree {
 		print "</tr>\n";
 	}
 	foreach my $line (@entries) {
-		my %t = parse_ls_tree_line($line, -z => 1);
+		my %t = parse_ls_tree_line($line, -z => 1, -l => $show_sizes);
 
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";


