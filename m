Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_PH_SURBL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 949402022A
	for <e@80x24.org>; Tue,  8 Nov 2016 12:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933116AbcKHMLs (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 07:11:48 -0500
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:33279 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932412AbcKHMLq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 07:11:46 -0500
Received: (qmail 25382 invoked from network); 8 Nov 2016 12:11:44 -0000
Received: (qmail 7756 invoked from network); 8 Nov 2016 12:11:44 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 8 Nov 2016 12:11:44 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 00/16] Mark strings in Perl scripts for translation
Date:   Tue,  8 Nov 2016 11:08:07 -0100
Message-Id: <20161108120823.11204-1-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.11.0.rc0.23.g8236252
In-Reply-To: <20161005172110.30801-1-vascomalmeida@sapo.pt>
References: <20161005172110.30801-1-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark messages in some perl scripts for translation.

In these series v5:
- Add and use a subroutine to comment lines. This way we can mark strings
  for translation without including the comment char within them.
- Mark for translation a message for the user when she is composing an
  e-mail in git-send-email.perl.

Interdiff included below.


Vasco Almeida (16):
  Git.pm: add subroutines for commenting lines
  i18n: add--interactive: mark strings for translation
  i18n: add--interactive: mark simple here-documents for translation
  i18n: add--interactive: mark strings with interpolation for
    translation
  i18n: clean.c: match string with git-add--interactive.perl
  i18n: add--interactive: mark plural strings
  i18n: add--interactive: mark patch prompt for translation
  i18n: add--interactive: i18n of help_patch_cmd
  i18n: add--interactive: mark edit_hunk_manually message for
    translation
  i18n: add--interactive: remove %patch_modes entries
  i18n: add--interactive: mark status words for translation
  i18n: send-email: mark strings for translation
  i18n: send-email: mark warnings and errors for translation
  i18n: send-email: mark string with interpolation for translation
  i18n: send-email: mark composing message for translation
  i18n: difftool: mark warnings for translation

 Makefile                  |   3 +-
 builtin/clean.c           |  10 +-
 git-add--interactive.perl | 329 ++++++++++++++++++++++++++++++----------------
 git-difftool.perl         |  22 ++--
 git-send-email.perl       | 192 ++++++++++++++-------------
 perl/Git.pm               |  23 ++++
 perl/Git/I18N.pm          |  19 ++-
 t/t0202/test.pl           |  14 +-
 8 files changed, 391 insertions(+), 221 deletions(-)

-- >8 --
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 4754104..56e6889 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1039,26 +1039,26 @@ sub color_diff {
 
 my %edit_hunk_manually_modes = (
 	stage => N__(
-"# If the patch applies cleanly, the edited hunk will immediately be
-# marked for staging."),
+"If the patch applies cleanly, the edited hunk will immediately be
+marked for staging."),
 	stash => N__(
-"# If the patch applies cleanly, the edited hunk will immediately be
-# marked for stashing."),
+"If the patch applies cleanly, the edited hunk will immediately be
+marked for stashing."),
 	reset_head => N__(
-"# If the patch applies cleanly, the edited hunk will immediately be
-# marked for unstaging."),
+"If the patch applies cleanly, the edited hunk will immediately be
+marked for unstaging."),
 	reset_nothead => N__(
-"# If the patch applies cleanly, the edited hunk will immediately be
-# marked for applying."),
+"If the patch applies cleanly, the edited hunk will immediately be
+marked for applying."),
 	checkout_index => N__(
-"# If the patch applies cleanly, the edited hunk will immediately be
-# marked for discarding"),
+"If the patch applies cleanly, the edited hunk will immediately be
+marked for discarding"),
 	checkout_head => N__(
-"# If the patch applies cleanly, the edited hunk will immediately be
-# marked for discarding."),
+"If the patch applies cleanly, the edited hunk will immediately be
+marked for discarding."),
 	checkout_nothead => N__(
-"# If the patch applies cleanly, the edited hunk will immediately be
-# marked for applying."),
+"If the patch applies cleanly, the edited hunk will immediately be
+marked for applying."),
 );
 
 sub edit_hunk_manually {
@@ -1068,21 +1068,22 @@ sub edit_hunk_manually {
 	my $fh;
 	open $fh, '>', $hunkfile
 		or die sprintf(__("failed to open hunk edit file for writing: %s"), $!);
-	print $fh __("# Manual hunk edit mode -- see bottom for a quick guide\n");
+	print $fh Git::comment_lines __("Manual hunk edit mode -- see bottom for a quick guide\n");
 	print $fh @$oldtext;
 	my $is_reverse = $patch_mode_flavour{IS_REVERSE};
 	my ($remove_plus, $remove_minus) = $is_reverse ? ('-', '+') : ('+', '-');
-	print $fh sprintf(__(
-"# ---
-# To remove '%s' lines, make them ' ' lines (context).
-# To remove '%s' lines, delete them.
-# Lines starting with # will be removed.
-#\n"), $remove_minus, $remove_plus),
-__($edit_hunk_manually_modes{$patch_mode}), __(
+	my $comment_line_char = Git::config("core.commentchar") || '#';
+	print $fh Git::comment_lines sprintf(__(
+"---
+To remove '%s' lines, make them ' ' lines (context).
+To remove '%s' lines, delete them.
+Lines starting with %s will be removed.
+\n"), $remove_minus, $remove_plus, $comment_line_char) .
+__($edit_hunk_manually_modes{$patch_mode}) ."\n". __(
 # TRANSLATORS: 'it' refers to the patch mentioned in the previous messages.
-" If it does not apply cleanly, you will be given
-# an opportunity to edit again. If all lines of the hunk are removed,
-# then the edit is aborted and the hunk is left unchanged.\n");
+"If it does not apply cleanly, you will be given an opportunity to
+edit again.  If all lines of the hunk are removed, then the edit is
+aborted and the hunk is left unchanged.\n");
 	close $fh;
 
 	chomp(my $editor = run_cmd_pipe(qw(git var GIT_EDITOR)));
@@ -1094,7 +1095,7 @@ __($edit_hunk_manually_modes{$patch_mode}), __(
 
 	open $fh, '<', $hunkfile
 		or die sprintf(__("failed to open hunk edit file for reading: %s"), $!);
-	my @newtext = grep { !/^#/ } <$fh>;
+	my @newtext = grep { !/^$comment_line_char/ } <$fh>;
 	close $fh;
 	unlink $hunkfile;
 
diff --git a/git-send-email.perl b/git-send-email.perl
index 5c01425..bbeb9fb 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -671,18 +671,20 @@ if ($compose) {
 	my $tpl_subject = $initial_subject || '';
 	my $tpl_reply_to = $initial_reply_to || '';
 
-	print $c <<EOT;
+	print $c <<EOT1, Git::prefix_lines("GIT: ", __ <<EOT2), <<EOT3;
 From $tpl_sender # This line is ignored.
-GIT: Lines beginning in "GIT:" will be removed.
-GIT: Consider including an overall diffstat or table of contents
-GIT: for the patch you are writing.
-GIT:
-GIT: Clear the body content if you don't wish to send a summary.
+EOT1
+Lines beginning in "GIT:" will be removed.
+Consider including an overall diffstat or table of contents
+for the patch you are writing.
+
+Clear the body content if you don't wish to send a summary.
+EOT2
 From: $tpl_sender
 Subject: $tpl_subject
 In-Reply-To: $tpl_reply_to
 
-EOT
+EOT3
 	for my $f (@files) {
 		print $c get_patch_subject($f);
 	}
diff --git a/perl/Git.pm b/perl/Git.pm
index b273282..17be59f 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1438,6 +1438,29 @@ sub END {
 
 } # %TEMP_* Lexical Context
 
+=item prefix_lines ( PREFIX, STRING )
+
+Prefixes lines in C<STRING> with C<PREFIX>.
+
+=cut
+
+sub prefix_lines {
+	my ($prefix, $string) = @_;
+	$string =~ s/^/$prefix/mg;
+	return $string;
+}
+
+=item comment_lines ( STRING )
+
+Comments lines following core.commentchar configuration.
+
+=cut
+
+sub comment_lines {
+	my $comment_line_char = config("core.commentchar") || '#';
+	return prefix_lines("$comment_line_char ", @_);
+}
+
 =back
 
 =head1 ERROR HANDLING
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index 32c4568..c41425c 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -74,7 +74,7 @@ Git::I18N - Perl interface to Git's Gettext localizations
 
 	printf __("The following error occurred: %s\n"), $error;
 
-	printf __n("commited %d file", "commited %d files", $files), $files;
+	printf __n("commited %d file\n", "commited %d files\n", $files), $files;
 
 
 =head1 DESCRIPTION
@@ -95,12 +95,14 @@ L<Locale::Messages>'s gettext function if all goes well, otherwise our
 passthrough fallback function.
 
 =head2 __n($$$)
+
 L<Locale::Messages>'s ngettext function or passthrough fallback function.
 
 =head2 N__($)
-No-op that only returns its argument. Use this if you want xgettext to
-extract the text to the pot template but do not want to trigger retrival of
-the translation at run time.
+
+No-operation that only returns its argument. Use this if you want xgettext to
+extract the text to the pot template but do not want to trigger retrival of the
+translation at run time.
 
 =head1 AUTHOR
 
-- >8 --

-- 
2.11.0.rc0.23.g8236252

