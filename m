Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BF671F859
	for <e@80x24.org>; Wed, 31 Aug 2016 12:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933593AbcHaMco (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 08:32:44 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:42544 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932516AbcHaMcn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 08:32:43 -0400
Received: (qmail 12994 invoked from network); 31 Aug 2016 12:32:40 -0000
Received: (qmail 2088 invoked from network); 31 Aug 2016 12:32:40 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <gitster@pobox.com>; 31 Aug 2016 12:32:34 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 00/11] Mark strings in perl script for translation
Date:   Wed, 31 Aug 2016 12:31:19 +0000
Message-Id: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark messages in some perl scripts for translation.

Since v1, adds brackets so parameter grouping of sprintf parameters is easier
to see.

Interdiff included below.

Vasco Almeida (11):
  i18n: add--interactive: mark strings for translation
  i18n: add--interactive: mark simple here documents for translation
  i18n: add--interactive: mark strings with interpolation for
    translation
  i18n: add--interactive: mark plural strings
  i18n: add--interactive: mark message for translation
  i18n: add--interactive: i18n of help_patch_cmd
  i18n: add--interactive: mark edit_hunk_manually message for
    translation
  i18n: send-email: mark strings for translation
  i18n: send-email: mark warnings and errors for translation
  i18n: send-email: mark string with interpolation for translation
  i18n: difftool: mark warnings for translation

 Makefile                  |   3 +-
 git-add--interactive.perl | 358 ++++++++++++++++++++++++++++++++++------------
 git-difftool.perl         |  18 +--
 git-send-email.perl       | 160 +++++++++++----------
 perl/Git/I18N.pm          |   4 +-
 t/t0202/test.pl           |  11 +-
 6 files changed, 376 insertions(+), 178 deletions(-)

---- >8 ----
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 1652a57..235142c 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -614,12 +614,12 @@ sub list_and_choose {
 			else {
 				$bottom = $top = find_unique($choice, @stuff);
 				if (!defined $bottom) {
-					error_msg sprintf __("Huh (%s)?\n"), $choice;
+					error_msg sprintf(__("Huh (%s)?\n"), $choice);
 					next TOPLOOP;
 				}
 			}
 			if ($opts->{SINGLETON} && $bottom != $top) {
-				error_msg sprintf __("Huh (%s)?\n"), $choice;
+				error_msg sprintf(__("Huh (%s)?\n"), $choice);
 				next TOPLOOP;
 			}
 			for ($i = $bottom-1; $i <= $top-1; $i++) {
@@ -669,17 +669,17 @@ sub say_n_paths {
 	my $did = shift @_;
 	my $cnt = scalar @_;
 	if ($did eq 'added') {
-		printf Q__("added one path\n", "added %d paths\n",
-			   $cnt), $cnt;
+		printf(Q__("added one path\n", "added %d paths\n",
+			   $cnt), $cnt);
 	} elsif ($did eq 'updated') {
-		printf Q__("updated one path\n", "updated %d paths\n",
-			   $cnt), $cnt;
+		printf(Q__("updated one path\n", "updated %d paths\n",
+			   $cnt), $cnt);
 	} elsif ($did eq 'reversed') {
-		printf Q__("reversed one path\n", "reversed %d paths\n",
-			   $cnt), $cnt;
+		printf(Q__("reversed one path\n", "reversed %d paths\n",
+			   $cnt), $cnt);
 	} else {
-		printf Q__("touched one path\n", "touched %d paths\n",
-			   $cnt), $cnt;
+		printf(Q__("touched one path\n", "touched %d paths\n",
+			   $cnt), $cnt);
 	}
 }
 
@@ -1056,12 +1056,12 @@ sub edit_hunk_manually {
 	my $hunkfile = $repo->repo_path . "/addp-hunk-edit.diff";
 	my $fh;
 	open $fh, '>', $hunkfile
-		or die sprintf __("failed to open hunk edit file for writing: %s"), $!;
+		or die sprintf(__("failed to open hunk edit file for writing: %s"), $!);
 	print $fh __("# Manual hunk edit mode -- see bottom for a quick guide\n");
 	print $fh @$oldtext;
 	my $is_reverse = $patch_mode_flavour{IS_REVERSE};
 	my ($remove_plus, $remove_minus) = $is_reverse ? ('-', '+') : ('+', '-');
-	print $fh (sprintf __(
+	print $fh sprintf(__(
 "# ---
 # To remove '%s' lines, make them ' ' lines (context).
 # To remove '%s' lines, delete them.
@@ -1121,7 +1121,7 @@ sub edit_hunk_manually {
 	}
 
 	open $fh, '<', $hunkfile
-		or die sprintf __("failed to open hunk edit file for reading: %s"), $!;
+		or die sprintf(__("failed to open hunk edit file for reading: %s"), $!);
 	my @newtext = grep { !/^#/ } <$fh>;
 	close $fh;
 	unlink $hunkfile;
@@ -1314,7 +1314,7 @@ sub apply_patch_for_checkout_commit {
 
 sub patch_update_cmd {
 	my @all_mods = list_modified($patch_mode_flavour{FILTER});
-	error_msg sprintf __("ignoring unmerged: %s\n"), $_->{VALUE}
+	error_msg sprintf(__("ignoring unmerged: %s\n"), $_->{VALUE})
 		for grep { $_->{UNMERGED} } @all_mods;
 	@all_mods = grep { !$_->{UNMERGED} } @all_mods;
 
@@ -1458,100 +1458,79 @@ sub patch_update_file {
 		if ($patch_mode eq 'stage') {
 			if ($hunk[$ix]{TYPE} eq 'mode') {
 			  print colored $prompt_color,
-			    sprintf __("Stage mode change [y,n,q,a,d,/%s,?]? "),
-				       $other;
+			    sprintf(__("Stage mode change [y,n,q,a,d,/%s,?]? "), $other);
 			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
 			  print colored $prompt_color,
-			    sprintf __("Stage deletion [y,n,q,a,d,/%s,?]? "),
-				       $other;
+			    sprintf(__("Stage deletion [y,n,q,a,d,/%s,?]? "), $other);
 			} else {
 			  print colored $prompt_color,
-			    sprintf __("Stage this hunk [y,n,q,a,d,/%s,?]? "),
-				       $other;
+			    sprintf(__("Stage this hunk [y,n,q,a,d,/%s,?]? "), $other);
 			}
 		} elsif ($patch_mode eq 'stash') {
 			if ($hunk[$ix]{TYPE} eq 'mode') {
 			  print colored $prompt_color,
-			    sprintf __("Stash mode change [y,n,q,a,d,/%s,?]? "),
-				       $other;
+			    sprintf(__("Stash mode change [y,n,q,a,d,/%s,?]? "), $other);
 			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
 			  print colored $prompt_color,
-			    sprintf __("Stash deletion [y,n,q,a,d,/%s,?]? "),
-				       $other;
+			    sprintf(__("Stash deletion [y,n,q,a,d,/%s,?]? "), $other);
 			} else {
 			  print colored $prompt_color,
-			    sprintf __("Stash this hunk [y,n,q,a,d,/%s,?]? "),
-				       $other;
+			    sprintf(__("Stash this hunk [y,n,q,a,d,/%s,?]? "), $other);
 			}
 		} elsif ($patch_mode eq 'reset_head') {
 			if ($hunk[$ix]{TYPE} eq 'mode') {
 			  print colored $prompt_color,
-			    sprintf __("Unstage mode change [y,n,q,a,d,/%s,?]? "),
-				       $other;
+			    sprintf(__("Unstage mode change [y,n,q,a,d,/%s,?]? "), $other);
 			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
 			  print colored $prompt_color,
-			    sprintf __("Unstage deletion [y,n,q,a,d,/%s,?]? "),
-				       $other;
+			    sprintf(__("Unstage deletion [y,n,q,a,d,/%s,?]? "), $other);
 			} else {
 			  print colored $prompt_color,
-			    sprintf __("Unstage this hunk [y,n,q,a,d,/%s,?]? "),
-				       $other;
+			    sprintf(__("Unstage this hunk [y,n,q,a,d,/%s,?]? "), $other);
 			}
 		} elsif ($patch_mode eq 'reset_nothead') {
 			if ($hunk[$ix]{TYPE} eq 'mode') {
 			  print colored $prompt_color,
-			    sprintf __("Apply mode change to index [y,n,q,a,d,/%s,?]? "),
-				       $other;
+			    sprintf(__("Apply mode change to index [y,n,q,a,d,/%s,?]? "), $other);
 			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
 			  print colored $prompt_color,
-			    sprintf __("Apply deletion to index [y,n,q,a,d,/%s,?]? "),
-				       $other;
+			    sprintf(__("Apply deletion to index [y,n,q,a,d,/%s,?]? "), $other);
 			} else {
 			  print colored $prompt_color,
-			    sprintf __("Apply this hunk to index [y,n,q,a,d,/%s,?]? "),
-				       $other;
+			    sprintf(__("Apply this hunk to index [y,n,q,a,d,/%s,?]? "), $other);
 			}
 		} elsif ($patch_mode eq 'checkout_index') {
 			if ($hunk[$ix]{TYPE} eq 'mode') {
 			  print colored $prompt_color,
-			    sprintf __("Discard mode change from worktree [y,n,q,a,d,/%s,?]? "),
-				       $other;
+			    sprintf(__("Discard mode change from worktree [y,n,q,a,d,/%s,?]? "), $other);
 			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
 			  print colored $prompt_color,
-			    sprintf __("Discard deletion from worktree [y,n,q,a,d,/%s,?]? "),
-				       $other;
+			    sprintf(__("Discard deletion from worktree [y,n,q,a,d,/%s,?]? "), $other);
 			} else {
 			  print colored $prompt_color,
-			    sprintf __("Discard this hunk from worktree [y,n,q,a,d,/%s,?]? "),
-				       $other;
+			    sprintf(__("Discard this hunk from worktree [y,n,q,a,d,/%s,?]? "), $other);
 			}
 		} elsif ($patch_mode eq 'checkout_head') {
 			if ($hunk[$ix]{TYPE} eq 'mode') {
 			  print colored $prompt_color,
-			    sprintf __("Discard mode change from index and worktree [y,n,q,a,d,/%s,?]? "),
-				       $other;
+			    sprintf(__("Discard mode change from index and worktree [y,n,q,a,d,/%s,?]? "), $other);
 			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
 			  print colored $prompt_color,
-			    sprintf __("Discard deletion from index and worktree [y,n,q,a,d,/%s,?]? "),
-				       $other;
+			    sprintf(__("Discard deletion from index and worktree [y,n,q,a,d,/%s,?]? "), $other);
 			} else {
 			  print colored $prompt_color,
-			    sprintf __("Discard this hunk from index and worktree [y,n,q,a,d,/%s,?]? "),
-				       $other;
+			    sprintf(__("Discard this hunk from index and worktree [y,n,q,a,d,/%s,?]? "), $other);
 			}
 		} elsif ($patch_mode eq 'checkout_nothead') {
 			if ($hunk[$ix]{TYPE} eq 'mode') {
 			  print colored $prompt_color,
-			    sprintf __("Apply mode change to index and worktree [y,n,q,a,d,/%s,?]? "),
-				       $other;
+			    sprintf(__("Apply mode change to index and worktree [y,n,q,a,d,/%s,?]? "), $other);
 			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
 			  print colored $prompt_color,
-			    sprintf __("Apply deletion to index and worktree [y,n,q,a,d,/%s,?]? "),
-				       $other;
+			    sprintf(__("Apply deletion to index and worktree [y,n,q,a,d,/%s,?]? "), $other);
 			} else {
 			  print colored $prompt_color,
-			    sprintf __("Apply this hunk to index and worktree [y,n,q,a,d,/%s,?]? "),
-				       $other;
+			    sprintf(__("Apply this hunk to index and worktree [y,n,q,a,d,/%s,?]? "), $other);
 			}
 		}
 		my $line = prompt_single_character;
@@ -1589,13 +1568,13 @@ sub patch_update_file {
 					chomp $response;
 				}
 				if ($response !~ /^\s*\d+\s*$/) {
-					error_msg sprintf __("Invalid number: '%s'\n"),
-						      $response;
+					error_msg sprintf(__("Invalid number: '%s'\n"),
+							     $response);
 				} elsif (0 < $response && $response <= $num) {
 					$ix = $response - 1;
 				} else {
-					error_msg sprintf __("Sorry, only %s hunks available.\n"),
-						      $num;
+					error_msg sprintf(__("Sorry, only %s hunks available.\n"),
+							     $num);
 				}
 				next;
 			}
@@ -1633,7 +1612,7 @@ sub patch_update_file {
 				if ($@) {
 					my ($err,$exp) = ($@, $1);
 					$err =~ s/ at .*git-add--interactive line \d+, <STDIN> line \d+.*$//;
-					error_msg sprintf __("Malformed search regexp %s: %s\n"), $exp, $err;
+					error_msg sprintf(__("Malformed search regexp %s: %s\n"), $exp, $err);
 					next;
 				}
 				my $iy = $ix;
@@ -1690,10 +1669,10 @@ sub patch_update_file {
 			elsif ($other =~ /s/ && $line =~ /^s/) {
 				my @split = split_hunk($hunk[$ix]{TEXT}, $hunk[$ix]{DISPLAY});
 				if (1 < @split) {
-					print colored $header_color, sprintf
+					print colored $header_color, sprintf(
 						Q__("Split into %d hunk.\n",
 						    "Split into %d hunks.\n",
-						    scalar(@split)), scalar(@split);
+						    scalar(@split)), scalar(@split));
 				}
 				splice (@hunk, $ix, 1, @split);
 				$num = scalar @hunk;
@@ -1798,19 +1777,19 @@ sub process_args {
 				$patch_mode = $1;
 				$arg = shift @ARGV or die __("missing --");
 			} else {
-				die sprintf __("unknown --patch mode: %s"), $1;
+				die sprintf(__("unknown --patch mode: %s"), $1);
 			}
 		} else {
 			$patch_mode = 'stage';
 			$arg = shift @ARGV or die __("missing --");
 		}
-		die sprintf __("invalid argument %s, expecting --"),
-			       $arg unless $arg eq "--";
+		die sprintf(__("invalid argument %s, expecting --"),
+			       $arg) unless $arg eq "--";
 		%patch_mode_flavour = %{$patch_modes{$patch_mode}};
 		$cmd = 1;
 	}
 	elsif ($arg ne "--") {
-		die sprintf __("invalid argument %s, expecting --"), $arg;
+		die sprintf(__("invalid argument %s, expecting --"), $arg);
 	}
 }
 
diff --git a/git-difftool.perl b/git-difftool.perl
index fe7f003..de8d783 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -452,11 +452,11 @@ sub dir_diff
 		}
 
 		if (exists $wt_modified{$file} and exists $tmp_modified{$file}) {
-			warn sprintf __(
-"warning: Both files modified:
-'%s/%s' and '%s/%s'.
-warning: Working tree file has been left.
-warning:\n"), $workdir, $file, $b, $file;
+			warn sprintf(__(
+				"warning: Both files modified:\n" .
+				"'%s/%s' and '%s/%s'.\n" .
+				"warning: Working tree file has been left.\n" .
+				"warning:\n"), $workdir, $file, $b, $file);
 			$error = 1;
 		} elsif (exists $tmp_modified{$file}) {
 			my $mode = stat("$b/$file")->mode;
@@ -468,9 +468,9 @@ warning:\n"), $workdir, $file, $b, $file;
 		}
 	}
 	if ($error) {
-		warn sprintf __(
-"warning: Temporary files exist in '%s'.
-warning: You may want to cleanup or recover these.\n"), $tmpdir;
+		warn sprintf(__(
+			"warning: Temporary files exist in '%s'.\n" .
+			"warning: You may want to cleanup or recover these.\n"), $tmpdir);
 		exit(1);
 	} else {
 		exit_cleanup($tmpdir, $rc);
diff --git a/git-send-email.perl b/git-send-email.perl
index f445a5e..c29381b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -434,7 +434,7 @@ $smtp_encryption = '' unless (defined $smtp_encryption);
 my(%suppress_cc);
 if (@suppress_cc) {
 	foreach my $entry (@suppress_cc) {
-		die sprintf __("Unknown --suppress-cc field: '%s'\n"), $entry
+		die sprintf(__("Unknown --suppress-cc field: '%s'\n"), $entry)
 			unless $entry =~ /^(?:all|cccmd|cc|author|self|sob|body|bodycc)$/;
 		$suppress_cc{$entry} = 1;
 	}
@@ -585,12 +585,12 @@ sub is_format_patch_arg {
 		if (defined($format_patch)) {
 			return $format_patch;
 		}
-		die sprintf __(
+		die sprintf(__(
 "File '%s' exists but it could also be the range of commits
 to produce patches for.  Please disambiguate by...
 
     * Saying \"./%s\" if you mean a file; or
-    * Giving --format-patch option if you mean a range."), $f, $f;
+    * Giving --format-patch option if you mean a range."), $f, $f);
 	} catch Git::Error::Command with {
 		# Not a valid revision.  Treat it as a filename.
 		return 0;
@@ -606,7 +606,7 @@ while (defined(my $f = shift @ARGV)) {
 		@ARGV = ();
 	} elsif (-d $f and !is_format_patch_arg($f)) {
 		opendir my $dh, $f
-			or die sprintf __("Failed to opendir %s: %s"), $f, $!;
+			or die sprintf(__("Failed to opendir %s: %s"), $f, $!);
 
 		push @files, grep { -f $_ } map { catfile($f, $_) }
 				sort readdir $dh;
@@ -628,8 +628,8 @@ if ($validate) {
 	foreach my $f (@files) {
 		unless (-p $f) {
 			my $error = validate_patch($f);
-			$error and die sprintf __("fatal: %s: %s\nwarning: no patches were sent\n"),
-						  $f, $error;
+			$error and die sprintf(__("fatal: %s: %s\nwarning: no patches were sent\n"),
+						  $f, $error);
 		}
 	}
 }
@@ -652,7 +652,7 @@ sub get_patch_subject {
 		return "GIT: $1\n";
 	}
 	close $fh;
-	die sprintf __("No subject line in %s ?"), $fn;
+	die sprintf(__("No subject line in %s ?"), $fn);
 }
 
 if ($compose) {
@@ -662,7 +662,7 @@ if ($compose) {
 		tempfile(".gitsendemail.msg.XXXXXX", DIR => $repo->repo_path()) :
 		tempfile(".gitsendemail.msg.XXXXXX", DIR => "."))[1];
 	open my $c, ">", $compose_filename
-		or die sprintf __("Failed to open for writing %s: %s"), $compose_filename, $!;
+		or die sprintf(__("Failed to open for writing %s: %s"), $compose_filename, $!);
 
 
 	my $tpl_sender = $sender || $repoauthor || $repocommitter || '';
@@ -693,10 +693,10 @@ EOT
 	}
 
 	open my $c2, ">", $compose_filename . ".final"
-		or die sprintf __("Failed to open %s.final : %s"), $compose_filename, $!;
+		or die sprintf(__("Failed to open %s.final : %s"), $compose_filename, $!);
 
 	open $c, "<", $compose_filename
-		or die sprintf __("Failed to open %s : %s"), $compose_filename, $!;
+		or die sprintf(__("Failed to open %s : %s"), $compose_filename, $!);
 
 	my $need_8bit_cte = file_has_nonascii($compose_filename);
 	my $in_body = 0;
@@ -772,7 +772,7 @@ sub ask {
 		if ($confirm_only) {
 			# TRANSLATORS: Keep [y/N] as is.
 			my $yesno = $term->readline(
-				sprintf __("Are you sure you want to use <%s> [y/N]? "), $resp);
+				sprintf(__("Are you sure you want to use <%s> [y/N]? "), $resp));
 			if (defined $yesno && $yesno =~ /y/i) {
 				return $resp;
 			}
@@ -851,7 +851,7 @@ my %EXPANDED_ALIASES;
 sub expand_one_alias {
 	my $alias = shift;
 	if ($EXPANDED_ALIASES{$alias}) {
-		die sprintf __("fatal: alias '%s' expands to itself\n"), $alias;
+		die sprintf(__("fatal: alias '%s' expands to itself\n"), $alias);
 	}
 	local $EXPANDED_ALIASES{$alias} = 1;
 	return $aliases{$alias} ? expand_aliases(@{$aliases{$alias}}) : $alias;
@@ -1226,7 +1226,7 @@ sub ssl_verify_params {
 		return (SSL_verify_mode => SSL_VERIFY_PEER(),
 			SSL_ca_file => $smtp_ssl_cert_path);
 	} else {
-		die sprintf __("CA path \"%s\" does not exist"), $smtp_ssl_cert_path;
+		die sprintf(__("CA path \"%s\" does not exist"), $smtp_ssl_cert_path);
 	}
 }
 
@@ -1388,7 +1388,7 @@ Message-Id: $message_id
 					# supported commands
 					$smtp->hello($smtp_domain);
 				} else {
-					die sprintf __("Server does not support STARTTLS! %s"), $smtp->message;
+					die sprintf(__("Server does not support STARTTLS! %s"), $smtp->message);
 				}
 			}
 		}
@@ -1445,7 +1445,7 @@ $subject = $initial_subject;
 $message_num = 0;
 
 foreach my $t (@files) {
-	open my $fh, "<", $t or die sprintf __("can't open file %s"), $t;
+	open my $fh, "<", $t or die sprintf(__("can't open file %s"), $t);
 
 	my $author = undef;
 	my $sauthor = undef;
@@ -1678,7 +1678,7 @@ sub recipients_cmd {
 		       $prefix, $what, $address, $cmd) unless $quiet;
 		}
 	close $fh
-	    or die sprintf __("(%s) failed to close pipe to '%s'"), $prefix, $cmd;
+	    or die sprintf(__("(%s) failed to close pipe to '%s'"), $prefix, $cmd);
 	return @addresses;
 }
 
@@ -1732,10 +1732,10 @@ sub unique_email_list {
 sub validate_patch {
 	my $fn = shift;
 	open(my $fh, '<', $fn)
-		or die sprintf __("unable to open %s: %s\n"), $fn, $!;
+		or die sprintf(__("unable to open %s: %s\n"), $fn, $!);
 	while (my $line = <$fh>) {
 		if (length($line) > 998) {
-			return sprintf __("%s: patch contains a line longer than 998 characters"), $.;
+			return sprintf(__("%s: patch contains a line longer than 998 characters"), $.);
 		}
 	}
 	return;
@@ -1744,7 +1744,7 @@ sub validate_patch {
 sub file_has_nonascii {
 	my $fn = shift;
 	open(my $fh, '<', $fn)
-		or die sprintf __("unable to open %s: %s\n"), $fn, $!;
+		or die sprintf(__("unable to open %s: %s\n"), $fn, $!);
 	while (my $line = <$fh>) {
 		return 1 if $line =~ /[^[:ascii:]]/;
 	}
@@ -1754,7 +1754,7 @@ sub file_has_nonascii {
 sub body_or_subject_has_nonascii {
 	my $fn = shift;
 	open(my $fh, '<', $fn)
-		or die sprintf __("unable to open %s: %s\n"), $fn, $!;
+		or die sprintf(__("unable to open %s: %s\n"), $fn, $!);
 	while (my $line = <$fh>) {
 		last if $line =~ /^$/;
 		return 1 if $line =~ /^Subject.*[^[:ascii:]]/;
---- >8 ----

-- 
2.7.4

