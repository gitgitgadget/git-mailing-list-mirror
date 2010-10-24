From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH v3 2/3] Documentation: complete config list from other manpages
Date: Sun, 24 Oct 2010 22:44:22 +0200
Message-ID: <201010242244.24326.jnareb@gmail.com>
References: <8145782bddf60325909f328337cb76d25c4402cf.1287690696.git.trast@student.ethz.ch> <8145782bddf60325909f328337cb76d25c4402cf.1287872553.git.trast@student.ethz.ch> <201010241636.51106.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oqJxMOpczXRWEOh"
Cc: git@vger.kernel.org,
	=?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Oct 24 22:44:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PA7Qj-0000qv-VH
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 22:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932931Ab0JXUoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 16:44:32 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55001 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932872Ab0JXUob (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 16:44:31 -0400
Received: by bwz11 with SMTP id 11so1853056bwz.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 13:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :message-id;
        bh=UtaRb46dX07FZcWBD+hIgnss7l34bwKK2wkwWmV8/2k=;
        b=RqONi3eKBaNiJH3iHwb625pBLXZIRpWxrPphA6Wwd2z6BMcnE7iKtpMEalQp3+lxNh
         xbE6jd7TWkBID+uWCt24CcrR+tQa0UHrLW5hiwzulDPwhPWOW4TitP9ZM2Vq7cBwfvhp
         PnsAo9svgLtLo600/BvFCJjndVaOj3reLxT3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:message-id;
        b=u3GcbOS4PV+fI8coeDkVm5DMLTLO50wvFdSj2UGoBwHL0HqmFc3U9uLB3Sep67o+Zk
         NIwNQ0MzfK/ZrU9OLtLhmv3gKdUeLRYh+3en+LH7Xe2JpRE02hP78uat7fTKmDB35+1N
         9Y+Zey8WGCziJFUaiBUKjMti1A+hKBw25cJ4E=
Received: by 10.204.63.9 with SMTP id z9mr4370265bkh.66.1287953069402;
        Sun, 24 Oct 2010 13:44:29 -0700 (PDT)
Received: from [192.168.1.13] (abvu207.neoplus.adsl.tpnet.pl [83.8.218.207])
        by mx.google.com with ESMTPS id a25sm4177024bks.8.2010.10.24.13.44.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 13:44:26 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201010241636.51106.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159889>

--Boundary-00=_oqJxMOpczXRWEOh
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

From: Thomas Rast <trast@student.ethz.ch>

Add an autogeneration script Documentation/make-config-list.perl
that complete list of config variables with missing variables
from other manpages.

This script generates minimal documentation for those missing config
variables at appropriate place in Documentation/config-vars.txt,
using the following form:

    foo.bar::
    foo.baz::
        See linkgit:git-foo[1].


It does that as follows:

* parse config-vars-src.txt (was config-vars.txt, which is now generated)
  to find out config variables it contains

* parse each manpage source (following includes) for config variable
  headers

* assemble a new config-vars.txt that completes the original list with
  "See linkgit:git-foo[1]" entries for all variables that were not in
  it config-vars-src.txt

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is my take on commit message and on autogeneration script.  I have
attached diff between config-vars-src.txt and generated config-vars.txt.

The differences from v2 by Thomas Rast:
* Removed stray changes to Documentation/Makefile and 
  Documentation/config-vars-src.txt

* The config-vars.txt target now depends on $(cmds_txt), which are 
  included by git.txt (without it, and without 'make doc' ran, the
  generation of "make -C Documentation config-vars.txt" failed because
  it couldn't find IIRC cmds-mainporcelain.txt).  See below.

* The config-vars.txt target now uses $(QUIET_GEN) and $(PERL_PATH),
  and makes use of make's automatic variables ($@, $<), like other
  targets that run *.perl scripts.  It uses $(MAN_TXT) in place of
  its definition, i.e. '$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)'

* The make-config-vars.perl invocation in config-vars.txt target
  now has extra '--ignore=merge-config.txt' because config-vars.src.txt
  contains 'include::merge-config.txt[]'.  See below.

* The make-config-vars.perl got rewritten according to proposals in
  parent email.  In general this means that instead of decomposing
  config-vars-src.txt, adding documentation of missing variables,
  and then recomposing it into config-vars.txt (with side-effects
  such as lowercasing variable names, and sorting variables), it
  simply finds places where to insert missing documentation, and
  generates and inserts it there.

  This means that read_varlist() got simplified, and main code got
  rewritten.

The patch with differences between Thomas patch and mine is attached
as text/plain to this email.


Issues to be solved (aka why this is an RFC):
* Dependencies for config-vars.txt target; probably just needs 
  modification to build-docdep.perl script.

* read_varlist does not follow includes, and that is why we had to
  manually ignore merge-config.txt

* Either sorting or inserting generated documentation could be
  improved; as can be seen in attached config-vars.txt the variables
  from manpage for git-http-backend got split.


 Documentation/Makefile                             |    5 +
 .../{config-vars.txt => config-vars-src.txt}       |    0
 Documentation/make-config-list.perl                |  174 ++++++++++++++++++++
 3 files changed, 179 insertions(+), 0 deletions(-)
 rename Documentation/{config-vars.txt => config-vars-src.txt} (100%)
 create mode 100755 Documentation/make-config-list.perl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index e117bc4..be35bf3 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -320,6 +320,11 @@ howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
 	'$(SHELL_PATH_SQ)' ./howto-index.sh $(wildcard howto/*.txt) >$@+ && \
 	mv $@+ $@
 
+config-vars.txt: config-vars-src.txt $(MAN_TXT) $(cmds_txt)
+	$(QUIET_GEN)$(PERL_PATH) ./make-config-list.perl \
+		--mainlist=$< --ignore=$@ --ignore=merge-config.txt $(MAN_TXT) >$@+ && \
+	mv $@+ $@
+
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
 	$(QUIET_ASCIIDOC)$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b xhtml11 $*.txt
 
diff --git a/Documentation/config-vars.txt b/Documentation/config-vars-src.txt
similarity index 100%
rename from Documentation/config-vars.txt
rename to Documentation/config-vars-src.txt
diff --git a/Documentation/make-config-list.perl b/Documentation/make-config-list.perl
new file mode 100755
index 0000000..fe7ac70
--- /dev/null
+++ b/Documentation/make-config-list.perl
@@ -0,0 +1,174 @@
+#!/usr/bin/perl
+
+use strict;
+use warnings;
+use Getopt::Long;
+use Cwd;
+use Data::Dumper;
+
+
+my %ignore;
+my $rc = GetOptions(
+	"mainlist=s" => \my $mainlistfile,
+	"ignore=s" => sub { $ignore{$_[1]} = 1 },
+);
+
+if (!$rc || !defined $mainlistfile) {
+	print "$0 --mainlist=<mainlist> [--ignore=<ignore>...] <asciidoc_manpage>...\n";
+	exit 1;
+}
+
+
+sub read_varlist {
+	my ($filename) = @_;
+
+	open my $fh, '<', $filename
+		or die "Couldn't open '$filename' for reading: $!";
+
+	my (%mainlist, @mainvars);
+	while (<$fh>) {
+		if (/^(\S+)::/) {
+			my $v = $1;
+			push @mainvars, $v;
+			$mainlist{lc($v)} = $.;
+		}
+	}
+
+	close $fh
+		or die "Couldn't close '$filename': $!";
+
+	return \%mainlist, \@mainvars;
+}
+
+my %var_manpages;
+my %manpage_section;
+
+sub read_man_txt {
+	my ($filename, $manpage) = @_;
+	if (!defined $manpage) {
+		$manpage = $filename;
+		$manpage =~ s/\.txt//;
+	}
+
+	open my $fh, '<', $filename
+		or die "Couldn't open '$filename' for reading: $!";
+	while (<$fh>) {
+		if ($. < 5 && /^$manpage\((\d+)\)/) {
+			$manpage_section{$manpage} = $1;
+		}
+		if (/^([a-z0-9]+\.[a-zA-Z<>0-9.]+)::/) {
+			push @{$var_manpages{$1}}, $manpage;
+		}
+		if (/^include::\s*(\S+)\s*\[\]/ &&
+		    !exists $ignore{$1}) {
+			read_man_txt($1, $manpage);
+		}
+	}
+	close $fh
+		or die "Couldn't close '$filename': $!";
+}
+
+sub find_insertion_points {
+	my ($mainlist, $missing_vars) = @_;
+	my %insert;
+
+	my %all_vars = (%$mainlist, %$missing_vars);
+	my $lineno = -1; # means after last line
+
+	# reverse order because we want to find a place before which to insert
+	# generated documentation; it is easy to find where description
+	# of variable begins, but in general harder to find where it ends.
+	my @sorted_vars = reverse sort { lc($a) cmp lc($b) } keys %all_vars;
+	#print STDERR join("\n", @sorted_vars)."\n";
+	foreach my $key (@sorted_vars) {
+		my $val = $all_vars{$key};
+		if (ref $val) {
+			# this came from %$missing_vars
+			push @{$insert{$lineno}}, $key;
+			print STDERR "$key missing ($lineno)\n";
+		} else {
+			# this came from %$mainlist
+			if ($lineno < 0) {
+				# $lineno < 0 means after end of file (special case)
+				$lineno = $val;
+			} else {
+				# this is in case of unsorted entries in $mainlistfile
+				$lineno = $val < $lineno ? $val : $lineno; # min($val, $lineno)
+			}
+			print STDERR "$key $val $lineno\n";
+		}
+	}
+	return %insert;
+}
+
+sub vars_documentation {
+	my ($keylist, $vars) = @_;
+	my @keys = sort @$keylist;
+	my %out;
+
+	# generate output for each key now, because it is easier to compare
+	# strings than arrays; comparing which is needed for compacting output
+	foreach my $k (@keys) {
+		$out{$k} = "\tSee: ".gen_links($vars->{$k}).".\n";
+	}
+
+	my $output = '';
+	while (my $k = pop @keys) {
+		$output .= $k."::\n";
+		unless (@keys && $out{$k} eq $out{$keys[0]}) {
+			$output .= $out{$k};
+		}
+	}
+	return $output;
+}
+
+sub gen_links {
+	my $manpages = shift;
+	return join(", ", map { linkgit($_) } @$manpages);
+}
+
+sub linkgit {
+	my $manpage = shift;
+
+	if (!exists $manpage_section{$manpage}) {
+		warn "section for $manpage unknown\n";
+		$manpage_section{$manpage} = 1;
+	}
+	return "linkgit:${manpage}[$manpage_section{$manpage}]";
+}
+
+
+foreach my $name (@ARGV) {
+	read_man_txt($name);
+}
+
+my ($mainlist, $mainvars) = read_varlist($mainlistfile);
+
+my @missing_vars =
+	grep { !exists $mainlist->{lc($_)} } keys %var_manpages;
+my %missing_vars =
+	map { $_ => $var_manpages{$_} } @missing_vars;
+
+my %insert = find_insertion_points($mainlist, \%missing_vars);
+$Data::Dumper::Indent = 0;
+$Data::Dumper::Sortkeys = 1;
+$Data::Dumper::Terse = 1;
+#print STDERR Dumper(\%insert);
+
+open my $fh, '<', $mainlistfile
+	or die "Couldn't open '$mainlistfile' for reading: $!";
+while (<$fh>) {
+	if (exists $insert{$.}) {
+		print vars_documentation($insert{$.}, \%missing_vars);
+		print "\n";
+	}
+	print;
+}
+# special case: insertion after last line in $mainlistfile
+print vars_documentation($insert{-1}, \%missing_vars)
+	if exists $insert{-1};
+close $fh
+	or die "Couldn't close '$mainlistfile': $!";
+
+exit 0;
+__END__
-- 
1.7.3


--Boundary-00=_oqJxMOpczXRWEOh
Content-Type: text/plain;
  charset="iso-8859-2";
  name="config-vars.diff.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="config-vars.diff.txt"

diff --git 1/Documentation/config-vars-src.txt 2/Documentation/config-vars.txt
index a8d37a7..e8c7eb3 100644
--- 1/Documentation/config-vars-src.txt
+++ 2/Documentation/config-vars.txt
@@ -680,6 +680,9 @@ commit.template::
 	"{tilde}/" is expanded to the value of `$HOME` and "{tilde}user/" to the
 	specified user's home directory.
 
+cvsexportcommit.cvsdir::
+	See: linkgit:git-cvsexportcommit[1].
+
 diff.autorefreshindex::
 	When using 'git diff' to compare with work tree
 	files, do not consider stat-only change as changed.
@@ -699,6 +702,9 @@ diff.external::
 	you want to use an external diff program only on a subset of
 	your files, you	might want to use linkgit:gitattributes[5] instead.
 
+diff.guitool::
+	See: linkgit:git-difftool[1].
+
 diff.mnemonicprefix::
 	If set, 'git diff' uses a prefix pair that is different from the
 	standard "a/" and "b/" depending on what is being compared.  When
@@ -897,6 +903,10 @@ gitcvs.commitmsgannotation::
 	Append this string to each commit message. Set to empty string
 	to disable this feature. Defaults to "via git-CVS emulator".
 
+gitcvs.dbuser::
+gitcvs.dbpass::
+	See: linkgit:git-cvsserver[1].
+
 gitcvs.enabled::
 	Whether the CVS server interface is enabled for this repository.
 	See linkgit:git-cvsserver[1].
@@ -1084,11 +1094,17 @@ help.autocorrect::
 	value is 0 - the command will be just shown but not executed.
 	This is the default.
 
+http.getanyfile::
+	See: linkgit:git-http-backend[1].
+
 http.proxy::
 	Override the HTTP proxy, normally configured using the 'http_proxy'
 	environment variable (see linkgit:curl[1]).  This can be overridden
 	on a per-remote basis; see remote.<name>.proxy
 
+http.receivepack::
+	See: linkgit:git-http-backend[1].
+
 http.sslVerify::
 	Whether to verify the SSL certificate when fetching or pushing
 	over HTTPS. Can be overridden by the 'GIT_SSL_NO_VERIFY' environment
@@ -1150,6 +1166,9 @@ http.noEPSV::
 	support EPSV mode. Can be overridden by the 'GIT_CURL_FTP_NO_EPSV'
 	environment variable. Default is false (curl will use EPSV).
 
+http.uploadpack::
+	See: linkgit:git-http-backend[1].
+
 http.useragent::
 	The HTTP USER_AGENT string presented to an HTTP server.  The default
 	value represents the version of the client git such as git/1.7.1.
@@ -1174,6 +1193,17 @@ imap::
 	The configuration variables in the 'imap' section are described
 	in linkgit:git-imap-send[1].
 
+imap.user::
+imap.tunnel::
+imap.sslverify::
+imap.preformattedHTML::
+imap.port::
+imap.pass::
+imap.host::
+imap.folder::
+imap.authMethod::
+	See: linkgit:git-imap-send[1].
+
 init.templatedir::
 	Specify the directory from which templates will be copied.
 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
@@ -1249,6 +1279,10 @@ man.<tool>.path::
 
 include::merge-config.txt[]
 
+merge.summary::
+merge.log::
+	See: linkgit:git-fmt-merge-msg[1].
+
 mergetool.<tool>.path::
 	Override the path for the given tool.  This is useful in case
 	your tool is not in the PATH.
@@ -1688,6 +1722,13 @@ submodule.<name>.ignore::
 	both settings can be overridden on the command line by using the
 	"--ignore-submodules" option.
 
+svn.useSvnsyncProps::
+svn.useSvmProps::
+svn.pathnameencoding::
+svn.noMetadata::
+svn.brokenSymlinkWorkaround::
+	See: linkgit:git-svn[1].
+
 tar.umask::
 	This variable can be used to restrict the permission bits of
 	tar archive entries.  The default is 0002, which turns off the

--Boundary-00=_oqJxMOpczXRWEOh
Content-Type: text/plain;
  charset="iso-8859-2";
  name="diff-v2.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="diff-v2.txt"

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 747b849..8ce75d2 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -125,7 +125,7 @@ endif
 
 SHELL_PATH ?= $(SHELL)
 # Shell quote;
-SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH)) #'
+SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 
 #
 # Please note that there is a minor bug in asciidoc.
@@ -320,12 +320,10 @@ howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
 	'$(SHELL_PATH_SQ)' ./howto-index.sh $(wildcard howto/*.txt) >$@+ && \
 	mv $@+ $@
 
-config-vars.txt: config-vars-src.txt $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
-	./make-config-list.perl --mainlist=config-vars-src.txt \
-		--ignore=config-vars.txt \
-		$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT) \
-		> config-vars.txt+ && \
-	mv config-vars.txt+ config-vars.txt
+config-vars.txt: config-vars-src.txt $(MAN_TXT) $(cmds_txt)
+	$(QUIET_GEN)$(PERL_PATH) ./make-config-list.perl \
+		--mainlist=$< --ignore=$@ --ignore=merge-config.txt $(MAN_TXT) >$@+ && \
+	mv $@+ $@
 
 $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
 	$(QUIET_ASCIIDOC)$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b xhtml11 $*.txt
diff --git a/Documentation/config-vars-src.txt b/Documentation/config-vars-src.txt
index 949259c..a8d37a7 100644
--- a/Documentation/config-vars-src.txt
+++ b/Documentation/config-vars-src.txt
@@ -936,7 +936,7 @@ gitcvs.dbname::
 
 gitcvs.dbdriver::
 	Used Perl DBI driver. You can specify any available driver
-	for this here, but it might not work. git-cvsserver is tested
+        for this here, but it might not work. git-cvsserver is tested
 	with 'DBD::SQLite', reported to work with 'DBD::Pg', and
 	reported *not* to work with 'DBD::mysql'. Experimental feature.
 	May not contain double colons (`:`). Default: 'SQLite'.
diff --git a/Documentation/make-config-list.perl b/Documentation/make-config-list.perl
index f086867..2894d96 100755
--- a/Documentation/make-config-list.perl
+++ b/Documentation/make-config-list.perl
@@ -4,128 +4,165 @@ use strict;
 use warnings;
 use Getopt::Long;
 
+
 my %ignore;
-
 my $rc = GetOptions(
 	"mainlist=s" => \my $mainlistfile,
 	"ignore=s" => sub { $ignore{$_[1]} = 1 },
-	"no-sort" => \my $no_sort,
-	);
+);
 
-if (!$rc or (!-r $mainlistfile)) {
+if (!$rc || !defined $mainlistfile) {
 	print "$0 --mainlist=<mainlist> [--ignore=<ignore>...] <asciidoc_manpage>...\n";
 	exit 1;
 }
 
+my %var_manpages;
+my %manpage_section;
+
+foreach my $name (@ARGV) {
+	read_man_txt($name);
+}
+
+my ($mainlist, $mainvars) = read_varlist($mainlistfile);
+
+my @missing_vars =
+	grep { !exists $mainlist->{lc($_)} } keys %var_manpages;
+my %missing_vars =
+	map { $_ => $var_manpages{$_} } @missing_vars;
+
+my %insert = find_insertion_points($mainlist, \%missing_vars);
+
+open my $fh, '<', $mainlistfile
+	or die "Couldn't open '$mainlistfile' for reading: $!";
+while (<$fh>) {
+	if (exists $insert{$.}) {
+		print vars_documentation($insert{$.}, \%missing_vars);
+		print "\n";
+	}
+	print;
+}
+# special case: insertion after last line in $mainlistfile
+print vars_documentation($insert{-1}, \%missing_vars)
+	if exists $insert{-1};
+close $fh
+	or die "Couldn't close '$mainlistfile': $!";
+
+exit 0;
+
+# ----------------------------------------------------------------------
+# ----------------------------------------------------------------------
+# ----------------------------------------------------------------------
+
 sub read_varlist {
-	my ($file) = @_;
+	my ($filename) = @_;
+
+	open my $fh, '<', $filename
+		or die "Couldn't open '$filename' for reading: $!";
 
-	open my $fh, "<", $file or die "cannot open $file: $!";
 	my (%mainlist, @mainvars);
-
-	my ($v, $last_v);
-	my $in_block = 0;
 	while (<$fh>) {
 		if (/^(\S+)::/) {
-			$v = lc $1;
-			$in_block = 0;
-			push @{$mainlist{$v}}, $_;
+			my $v = $1;
 			push @mainvars, $v;
-		} elsif (/^$/ && !$in_block) {
-			if (defined $last_v && !$#{$mainlist{$last_v}}) {
-				$mainlist{$last_v} = $mainlist{$v};
-			}
-			$last_v = $v;
-		} elsif (defined $v) {
-			push @{$mainlist{$v}}, $_;
-			$in_block = !$in_block if /^--$/;
+			$mainlist{lc($v)} = $.;
 		}
 	}
 
-	close $fh or die "eh? close failed: $!";
+	close $fh
+		or die "Couldn't close '$filename': $!";
 
 	return \%mainlist, \@mainvars;
 }
 
-my %vars;
-my %sections;
-
-sub read_file {
-	my ($name, $main_name) = @_;
-	if (!defined $main_name) {
-		$main_name = $name;
+sub read_man_txt {
+	my ($filename, $manpage) = @_;
+	if (!defined $manpage) {
+		$manpage = $filename;
+		$manpage =~ s/\.txt//;
 	}
-	my $manpage_name = $main_name;
-	$manpage_name =~ s/\.txt//;
-	my $fp;
-	open $fp, '<', $name or die "open $name failed: $!";
-	while (<$fp>) {
-		if ($. < 5 && /^$manpage_name\((\d+)\)/) {
-			$sections{$manpage_name} = $1;
+
+	open my $fh, '<', $filename
+		or die "Couldn't open '$filename' for reading: $!";
+	while (<$fh>) {
+		if ($. < 5 && /^$manpage\((\d+)\)/) {
+			$manpage_section{$manpage} = $1;
 		}
-		if (/^([a-z0-9]+\.[a-z<>0-9.]+)::/) {
-			push @{$vars{$1}}, $manpage_name;
+		if (/^([a-z0-9]+\.[a-zA-Z<>0-9.]+)::/) {
+			push @{$var_manpages{$1}}, $manpage;
 		}
-		if (/^include::\s*(\S+)\s*\[\]/
-		    && !exists $ignore{$1}) {
-			read_file($1, $main_name);
+		if (/^include::\s*(\S+)\s*\[\]/ &&
+		    !exists $ignore{$1}) {
+			read_man_txt($1, $manpage);
 		}
 	}
-	close $fp or die "close $name failed: $!";
-}
-
-foreach my $name (@ARGV) {
-	read_file($name);
+	close $fh
+		or die "Couldn't close '$filename': $!";
 }
 
-my ($mainlist, $mainvars) = read_varlist($mainlistfile);
-
-my @all_keys = @$mainvars;
-foreach my $k (keys %vars) {
-	if (!exists $mainlist->{$k}) {
-		push @all_keys, $k;
-	}
-}
+sub find_insertion_points {
+	my ($mainlist, $missing_vars) = @_;
+	my %insert;
 
-@all_keys = sort @all_keys unless $no_sort;
+	my %all_vars = (%$mainlist, %$missing_vars);
+	my $lineno = -1; # means after last line
 
-my %out;
-foreach my $k (@all_keys) {
-	if (exists $mainlist->{$k}) {
-		push @{$out{$k}}, @{$mainlist->{$k}}, "\n";
-	} elsif (exists $vars{$k}) {
-		push @{$out{$k}}, $k . "::\n";
-		push @{$out{$k}}, "\tSee ";
-		my $sep = " ";
-		foreach my $p (sort @{$vars{$k}}) {
-			next if ($p =~ /$mainlistfile/);
-			if (!exists $sections{$p}) {
-				warn "section for $p unknown";
-				$sections{$p} = 1;
+	# reverse order because we want to find a place before which to insert
+	# generated documentation; it is easy to find where description
+	# of variable begins, but in general harder to find where it ends.
+	my @sorted_vars = reverse sort { lc($a) cmp lc($b) } keys %all_vars;
+	foreach my $key (@sorted_vars) {
+		my $val = $all_vars{$key};
+		if (ref $val) {
+			# this came from %$missing_vars
+			push @{$insert{$lineno}}, $key;
+		} else {
+			# this came from %$mainlist
+			if ($lineno < 0) {
+				# $lineno < 0 means after end of file (special case)
+				$lineno = $val;
+			} else {
+				# this is in case of unsorted entries in $mainlistfile
+				$lineno = $val < $lineno ? $val : $lineno; # min($val, $lineno)
 			}
-			push @{$out{$k}}, $sep . "linkgit:" . $p . "[" . $sections{$p} . "]";
-			$sep = ", ";
 		}
-		push @{$out{$k}}, ".\n\n";
-	} else {
-		die "can't happen: $k not in any source";
 	}
+	return %insert;
 }
 
-for (my $i = 0; $i < $#all_keys; $i++) {
-	next if $#{$out{$all_keys[$i]}} != $#{$out{$all_keys[$i+1]}};
-	my $same = 1;
-	for (my $j = 1; $j <= $#{$out{$all_keys[$i]}}; $j++) {
-		if ($out{$all_keys[$i]}[$j] ne $out{$all_keys[$i+1]}[$j]) {
-			$same = 0;
-			last;
-		}
+sub vars_documentation {
+	my ($keylist, $vars) = @_;
+	my @keys = sort @$keylist;
+	my %out;
+
+	# generate output for each key now, because it is easier to compare
+	# strings than arrays; comparing which is needed for compacting output
+	foreach my $k (@keys) {
+		$out{$k} = "\tSee: ".gen_links($vars->{$k}).".\n";
 	}
-	if ($same) {
-		$out{$all_keys[$i]} = [$out{$all_keys[$i]}[0]];
+
+	my $output = '';
+	while (my $k = pop @keys) {
+		$output .= $k."::\n";
+		unless (@keys && $out{$k} eq $out{$keys[0]}) {
+			$output .= $out{$k};
+		}
 	}
+	return $output;
 }
 
-foreach my $k (@all_keys) {
-	print @{$out{$k}};
+sub gen_links {
+	my $manpages = shift;
+	return join(", ", map { linkgit($_) } @$manpages);
 }
+
+sub linkgit {
+	my $manpage = shift;
+
+	if (!exists $manpage_section{$manpage}) {
+		warn "section for $manpage unknown, assuming '1'\n";
+		$manpage_section{$manpage} = 1;
+	}
+	return "linkgit:${manpage}[$manpage_section{$manpage}]";
+}
+
+__END__

--Boundary-00=_oqJxMOpczXRWEOh--
